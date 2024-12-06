Return-Path: <netdev+bounces-149642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544FB9E694B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9691881635
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6281DF742;
	Fri,  6 Dec 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="S2ain+q+"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CC192D89;
	Fri,  6 Dec 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474981; cv=none; b=Y6IXGZsKRmNvNW91T71fhMKJ8SLNmGWnSE2+F4iT/UmDPzaQH6CwiR9/7KHUgZumRb6VDRAB0BMmWxzEA8kRAY0tKpp1ROgnewN8SUr38YNPVu/gqU5c4M5ov2dID09SQdaOe8dQwSV4ZOmc103A3/K22v3xfukJuC+dI792dds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474981; c=relaxed/simple;
	bh=SpWS6tHvJ4vr0pLDDXRJKN4Rqy+4CXz8b7KhTFwlur0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=asvUJ1ykX11kTIHBbUlzW4Yyq3kDJOcd05p08qYZVmu4qBIEze2+MukFFKNlaGylGnVdUSd88ttCXu9p/crTOvDEbunwpCFePyqyJAIeGUKDRo9sk73m3kPqcL6CglS5ZKWw6u2zySHr7uxR1Ufkl7P0daBZBwDpa8H0Kwta1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=S2ain+q+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B68mxmaF138139, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733474939; bh=SpWS6tHvJ4vr0pLDDXRJKN4Rqy+4CXz8b7KhTFwlur0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=S2ain+q+hbOZDcQOnPP5J6tFw15t1PWvDM2UgxVxXmVE/wscVAJYyvE0HkL+KyMfh
	 KdhBjmNg/QmptUsh3j72j2b73dcxIE1wLNqJeKG1Rt3zZOekJmf6Rxt6OV146efOkn
	 BQZjRca51qaKzbzIyLeCmHuBcl1c/ooOC8OUvdMQHwCkIJgt8Pwr2gIQtz/dvahrlm
	 wv7kIUM2DqHdXs3p6xNC7G+F8+B1tFeStQdS1SxQZR5ZDo8xLrmhbiEua1LewUVraF
	 fX2O18l6qTpIgvZH+2vKLEWZtCVda/VpsFi+VyDZE7W/5zqmUeHe5L0xx06Bz44qcz
	 IVPl0GJUtMYyw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B68mxmaF138139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 16:48:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 16:48:59 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 16:48:58 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>,
        <michal.kubiak@intel.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next] rtase: Refine the if statement
Date: Fri, 6 Dec 2024 16:48:51 +0800
Message-ID: <20241206084851.760475-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Refine the if statement to improve readability.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 6106aa5333bc..585d0b21c9e0 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2018,7 +2018,7 @@ static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	ret = pci_enable_device(pdev);
-	if (ret < 0)
+	if (ret)
 		goto err_out_free_dev;
 
 	/* make sure PCI base addr 1 is MMIO */
@@ -2034,7 +2034,7 @@ static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
 	}
 
 	ret = pci_request_regions(pdev, KBUILD_MODNAME);
-	if (ret < 0)
+	if (ret)
 		goto err_out_disable;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -2110,7 +2110,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 	dev_dbg(&pdev->dev, "Automotive Switch Ethernet driver loaded\n");
 
 	ret = rtase_init_board(pdev, &dev, &ioaddr);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	tp = netdev_priv(dev);
@@ -2120,7 +2120,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 
 	/* identify chip attached to board */
 	ret = rtase_check_mac_version_valid(tp);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(&pdev->dev,
 			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
 			tp->hw_ver);
@@ -2131,7 +2131,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 	rtase_init_hardware(tp);
 
 	ret = rtase_alloc_interrupt(pdev, tp);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&pdev->dev, "unable to alloc MSIX/MSI\n");
 		goto err_out_del_napi;
 	}
@@ -2176,7 +2176,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 	netif_carrier_off(dev);
 
 	ret = register_netdev(dev);
-	if (ret != 0)
+	if (ret)
 		goto err_out_free_dma;
 
 	netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
-- 
2.34.1


