Return-Path: <netdev+bounces-32635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB3798D92
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FC91C20CD3
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085214F87;
	Fri,  8 Sep 2023 18:17:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC3156C9
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62980C43397;
	Fri,  8 Sep 2023 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197026;
	bh=XODDTN7vRoEHOpmYQf6ue9p4+3JcrLCDM534vfS8aVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJO2VuGQGt2MrWDLNeJWb41ZcJN4gu58j9taegxo7Xk/BwywVgGSzvWw/rETeo2zM
	 kIxtaSv1G0JiXTei0ZKtiO9f9bUhJK47OcIDSalUKiJ+0fqbFthZV0WCvBtU/XGPlS
	 k3mprrXCi0mFvkgsQboV4WbU2aYPyRXTO+C+zc6V2LehE3fLJLHW8t851mgjD5E0x4
	 eAEYKU93/GxUBjFN9UChbWrMxAKyNE6K/2h1HjOg8+bVHlHu7XHRzLsL3UUYKefeR5
	 jFaGG5Y455Yvy7zlfNnKV4SAhiu9BPJlN3Y1YNS+Y7Aeu/yeUADV31CKQDhXVvTKEP
	 Lm+DQkID8ae7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "GONG, Ruiqi" <gongruiqi1@huawei.com>, GONG@web.codeaurora.org,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 27/41] alx: fix OOB-read compiler warning
Date: Fri,  8 Sep 2023 14:15:41 -0400
Message-Id: <20230908181555.3459640-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

[ Upstream commit 3a198c95c95da10ad844cbeade2fe40bdf14c411 ]

The following message shows up when compiling with W=1:

In function ‘fortify_memcpy_chk’,
    inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to get alx stats altogether, alx_get_ethtool_stats() reads
beyond hw->stats.rx_ok. Fix this warning by directly copying hw->stats,
and refactor the unnecessarily complicated BUILD_BUG_ON btw.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230821013218.1614265-1-gongruiqi@huaweicloud.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/alx/ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index b716adacd8159..7f6b69a523676 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -292,9 +292,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
 	spin_lock(&alx->stats_lock);
 
 	alx_update_hw_stats(hw);
-	BUILD_BUG_ON(sizeof(hw->stats) - offsetof(struct alx_hw_stats, rx_ok) <
-		     ALX_NUM_STATS * sizeof(u64));
-	memcpy(data, &hw->stats.rx_ok, ALX_NUM_STATS * sizeof(u64));
+	BUILD_BUG_ON(sizeof(hw->stats) != ALX_NUM_STATS * sizeof(u64));
+	memcpy(data, &hw->stats, sizeof(hw->stats));
 
 	spin_unlock(&alx->stats_lock);
 }
-- 
2.40.1


