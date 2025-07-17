Return-Path: <netdev+bounces-207773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A9B088B0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E921647CE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A938288511;
	Thu, 17 Jul 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="mhoYAAvM"
X-Original-To: netdev@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635632609C4;
	Thu, 17 Jul 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742851; cv=none; b=Iq18oFbFIlLbUvd8ud7eOVop70pjK008lAWgPSPUzAJegZ7e+asR8oHx1g/l7yFLHgKyn4QpWssW3i6fq8nLXZLGBgn5HXg2aw1CX5fiZ0Og+6enCu+J5LiN4R7Ae2d/FHBZp9dF5S4OMyNcnG7DonOVEctPDlAnONLRlShfYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742851; c=relaxed/simple;
	bh=PRDLQfj4atQJv1rGYsV2QjshJSdhh7MeeRwv/ciYAR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JiZ6TvhvcGjLm5SIZFdsLBrhqlJuBJGf/MgamSe0kmYx7le2IjPNJHE6JXJTYlEQi7n8xEp4zFWB8s/K2aW9dOEt11aBLN7PEzX7aIVwFXH4Zx9g9F1Lu+RMkph1ZZKzil2tYlVhf+niAZXuCV/lWthit05jeyvBrDMiOo7Cwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=mhoYAAvM; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kVLHVGAR/VZN5lwNOcVQ4DkumoYnRZVacqL4KhRzyk0=; b=mhoYAAvM282xWLPZaKiZFohYwl
	15QSI2VNw+NpS8LTjdfbA8lwAUXNfU/hL/5WGt4geYDjJV07tBriAaD7B//4v0fXy7xTlGgdDI0+k
	oXll1z472mDv7+sPcJYLwwWIhO9wllxXE+NXnuee6rdZLXYmzx71LZWJUzV+0W3CQ9e2etSTTpTc0
	yLROQA4oW/ViwSjTPS8dbciFRsIkKlNlZ+c6Qyr2iOw6BDfOWxmp6x1tmCCQBl8tPwcfgyjdR3snN
	qghVTn3G6idXIxqgUjNKYIquOeDEbp/DMCVtGaQK8w3YXVvOwtvhzY2/QQxUok7qv3eTIFCO7sSwo
	E4w1pjxA==;
Received: from [89.212.21.243] (port=53282 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ucKTp-00DbO3-2J;
	Thu, 17 Jul 2025 11:00:40 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] net: stmmac: Populate netdev of_node
Date: Thu, 17 Jul 2025 11:00:37 +0200
Message-Id: <20250717090037.4097520-3-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717090037.4097520-1-primoz.fiser@norik.com>
References: <20250717090037.4097520-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Populate netdev of_node with device of_node so that the network device
inherits the device tree node information in case of platform device.
On the other hand, when stmmac_dvr_probe() is called from pci device,
of_node will be NULL preserving current behavior.

With this in place, when initiated from platform device, udev will be
able to export OF_* properties (OF_NAME, OF_FULLNAME, OF_COMPATIBLE,
OF_ALIAS, etc) for the network interface. These properties are commonly
used by udev rules and other userspace tools for device identification
and configuration.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f350a6662880..dfd503a87f22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7487,6 +7487,7 @@ int stmmac_dvr_probe(struct device *device,
 		return -ENOMEM;
 
 	SET_NETDEV_DEV(ndev, device);
+	ndev->dev.of_node = device->of_node;
 
 	priv = netdev_priv(ndev);
 	priv->device = device;
-- 
2.34.1


