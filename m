Return-Path: <netdev+bounces-31257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3A978C570
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A9D1C20A50
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCAE174EB;
	Tue, 29 Aug 2023 13:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E4154B0
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B27BC43391;
	Tue, 29 Aug 2023 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693315960;
	bh=oH6hl56tUU6fyNan0MeAbQaEx2I7FS353c7o/JZ+zRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+AA4hswFLYssmlQhiCZS4RpXFHLfChKfl4zkNh967cO+V9nIrl5LML4CaHWHVBYK
	 JeDqEsYSHTqLTKJ+MuYwrNvosh3RhUYAT86SGIjZ8PtG+O1anKbxB488Umr/n5SJle
	 9rDQx5GmilNmGxzG5rtIpYpcMUkasVWBgVWU9HOigPXI734E/45sYIb9Rs+NpC2kJw
	 asAgN+s1bjLR3MQ3SlMkYQPrcss2ne6tDPVOGYCDLEdFmnLRFuwCQN/SCJWhuXKCMO
	 Zst2BioBhvDoQOv9LZSAp4qj8ryLRvm2nAmRFEplJoB/b4W+ih2Jy7gqRgvK9dhOSL
	 6WWogbGxo0SRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Leon Romanovsky <leonro@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	michael.chan@broadcom.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 15/17] broadcom: b44: Use b44_writephy() return value
Date: Tue, 29 Aug 2023 09:32:02 -0400
Message-Id: <20230829133211.519957-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit

From: Artem Chernyshev <artem.chernyshev@red-soft.ru>

[ Upstream commit 9944d203fa63721b87eee84a89f7275dc3d25c05 ]

Return result of b44_writephy() instead of zero to
deal with possible error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/b44.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 392ec09a1d8a6..3e4fb3c3e8342 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1793,11 +1793,9 @@ static int b44_nway_reset(struct net_device *dev)
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	r = -EINVAL;
-	if (bmcr & BMCR_ANENABLE) {
-		b44_writephy(bp, MII_BMCR,
-			     bmcr | BMCR_ANRESTART);
-		r = 0;
-	}
+	if (bmcr & BMCR_ANENABLE)
+		r = b44_writephy(bp, MII_BMCR,
+				 bmcr | BMCR_ANRESTART);
 	spin_unlock_irq(&bp->lock);
 
 	return r;
-- 
2.40.1


