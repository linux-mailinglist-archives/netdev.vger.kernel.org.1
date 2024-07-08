Return-Path: <netdev+bounces-110009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAAF92AAD0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511F62832BE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809614D6FF;
	Mon,  8 Jul 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="WDLABT2r"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88314A60E
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472322; cv=none; b=JtVq/a7T8yFkyVDtt5sTDNLfMeOE+y/xbFGb+YjNcwu+D7loWvyve+IYRPA6YZ4HCmZ+wj6wI/XEW9idGAMEsJ6ykmhndK/z2s7DCgelx3M365XM4Q9HG6qbMkGkosNk+h4601CIBodj4gi75K0QTT6C/UWFG9Rk9amzoxWhOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472322; c=relaxed/simple;
	bh=2rlB6Ojmu/l2PeRGxUrHBKpnhbN+d/Ky2sKmjrKGSmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7+wuMCdha2RY68JCMcjE0hPVJ6gMHUBZZHAfwez+4B1I1umFMYvm1O6R+o0WABREWsRZN3kjxP4190mkz2YllDI/D98Tt0XgNhuxmRtZxylNljU8oKpQJDVRWGhL/kiO5G1a5i4NfNnckQ3k8GdAV391mUs6PHVHZG6zt4YaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=WDLABT2r; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 12442 invoked from network); 8 Jul 2024 22:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720472308; bh=8NPN9/UQ4HRsQkyCMpM5BM9NHCb9hWs4MwzCmNnUzXg=;
          h=From:To:Cc:Subject;
          b=WDLABT2r6r44jOMC8rcdJ/CZ0CtNva2y/qOZZm0PJXGsK+VEDrP6pbRvuB0xSLqFp
           jkoPcz26t5LwfBnyIAOGlhHwwwcEvS9F0SctnVcLGDM5o9/oio+0NnRXN3wzLvWuht
           yxlOY69+WObM0m0qnh9IxajosJMziFd0Fe86iRr0=
Received: from 83.5.170.55.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.170.55])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 8 Jul 2024 22:58:28 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	shannon.nelson@amd.com,
	horms@kernel.org,
	sd@queasysnail.net,
	olek2@wp.pl,
	u.kleine-koenig@pengutronix.de,
	ralf@linux-mips.org,
	ralph.hempel@lantiq.com,
	john@phrozen.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v3] net: ethernet: lantiq_etop: fix double free in detach
Date: Mon,  8 Jul 2024 22:58:26 +0200
Message-Id: <20240708205826.5176-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 88c14d6ea541429c80222df60077a39f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [sUO0]                               

The number of the currently released descriptor is never incremented
which results in the same skb being released multiple times.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Reported-by: Joe Perches <joe@perches.com>
Closes: https://lore.kernel.org/all/fc1bf93d92bb5b2f99c6c62745507cc22f3a7b2d.camel@perches.com/
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/lantiq_etop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 5352fee62d2b..0b9982804370 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -217,9 +217,9 @@ ltq_etop_free_channel(struct net_device *dev, struct ltq_etop_chan *ch)
 	if (ch->dma.irq)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
-		int desc;
+		struct ltq_dma_channel *dma = &ch->dma;
 
-		for (desc = 0; desc < LTQ_DESC_NUM; desc++)
+		for (dma->desc = 0; dma->desc < LTQ_DESC_NUM; dma->desc++)
 			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
 	}
 }
-- 
2.39.2


