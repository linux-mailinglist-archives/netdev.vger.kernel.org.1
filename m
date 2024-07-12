Return-Path: <netdev+bounces-111068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34F92FB69
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD452821F3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182416F82E;
	Fri, 12 Jul 2024 13:29:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA116EB6E;
	Fri, 12 Jul 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790976; cv=none; b=SOSNsyskRH4ovpWbpWP/xcv+xfm1JO7dsDxHbv6j4TEw3MNjyA8ant3v4aJXJ82hdEkvceykQIHhthdeq97/uA9if4mRqfBqOSu4+A4hpGbuHNX9cCETxkrA/GHjxJjCPfvznxyGDDqcVvVnkx/HY7G20+1bEDFXXr4zRtQ0dlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790976; c=relaxed/simple;
	bh=WUbnPtxtIzEtvHwNlGlO/l7CFkiPNGEz4QNZtg5HVYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8fuVPFow8Xugj5G3TSLvkl9MT7ehbMfeBHBsRNJX+xZ4IvpVq23GXjOXjpPWlzOMXs09+BkaE7hthHuHYh/Xm8ONdf1jHOrKg2KkdMc2I/9D+IHIz/vR7uEiGrC93f1uhwqwGdu2A4hAu6siExYkIlNkFeHzrB0JXrCHgcLJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=35280 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sSGKs-00037n-9Z;
	Fri, 12 Jul 2024 16:29:19 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1sSGKs-0001vy-2j;
	Fri, 12 Jul 2024 16:29:18 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Sudarsana Kalluru <skalluru@marvell.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net-next] bnx2x: turn off FCoE if storage MAC-address setup failed
Date: Fri, 12 Jul 2024 16:29:15 +0300
Message-Id: <20240712132915.54710-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

As of now, initial storage MAC setup (in bnx2x_init_one) is not checked.

This can lead to unexpected FCoE behavior (as address will be in unexpected
state) without notice.

Check dev_addr_add for storage MAC and if it failes produce error message
and turn off FCoE feature.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 678829646cec..c5d5e85777d4 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13988,8 +13988,12 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	if (!NO_FCOE(bp)) {
 		/* Add storage MAC address */
 		rtnl_lock();
-		dev_addr_add(bp->dev, bp->fip_mac, NETDEV_HW_ADDR_T_SAN);
+		rc = dev_addr_add(bp->dev, bp->fip_mac, NETDEV_HW_ADDR_T_SAN);
 		rtnl_unlock();
+		if (rc) {
+			dev_err(&pdev->dev, "Cannot add storage MAC address\n");
+			bp->flags |= NO_FCOE_FLAG;
+		}
 	}
 	BNX2X_DEV_INFO(
 	       "%s (%c%d) PCI-E found at mem %lx, IRQ %d, node addr %pM\n",
-- 
2.34.1


