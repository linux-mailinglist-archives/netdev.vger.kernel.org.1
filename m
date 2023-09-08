Return-Path: <netdev+bounces-32648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3F798E0D
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5899281D21
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4B1549C;
	Fri,  8 Sep 2023 18:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FBE16416
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39EEC433CA;
	Fri,  8 Sep 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197141;
	bh=XODDTN7vRoEHOpmYQf6ue9p4+3JcrLCDM534vfS8aVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFEYDfS9EjzQwuQeBtXx7drfuf8jLWl8lhcBKw8ptYaaha3RtMUuK1rMRASddaeiJ
	 xZvAhb/uMwkHKMSrIO/Ry00/jFHeRrmsMQ5tQRTbuOUjuxxtTP09WvJk1E+T4DkXx5
	 5jEi2/3XzxFri8GU4YIFGju+8YThKgVyLNd+2rTJEab4NpP0fn/Nn7KaianLO7rzHO
	 Bf3cm/z1Tj+6e/s/zoGlI8O+2bpbTFw7ODDNguk3BTWAcLSqfL0BNECiPISQQcqaqh
	 cxC7ta2F3qA1ycbSav0ZyZGW1zx57HFpDFXqr1j8PEAgXEmcq0fNKPkZ/V/0fK27ZA
	 3A27s2eAYmH1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "GONG, Ruiqi" <gongruiqi1@huawei.com>, GONG@web.codeaurora.org,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/26] alx: fix OOB-read compiler warning
Date: Fri,  8 Sep 2023 14:17:56 -0400
Message-Id: <20230908181806.3460164-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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


