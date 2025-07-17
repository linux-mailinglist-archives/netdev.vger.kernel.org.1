Return-Path: <netdev+bounces-207774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0114B088B5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260361894C25
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34E288C35;
	Thu, 17 Jul 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="GiHjAWZu"
X-Original-To: netdev@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C9266B67;
	Thu, 17 Jul 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742851; cv=none; b=K5NzO5rP/jq5vRNmz+8mop7uiMbCe8yxQ7OWYBX5aih3MscFw4pQ1KNib9fCM7Tp7cOILUMGXwjvzmCtxrGj9vc/e4fcTKgWO6jIpXnBA/BX5FDOu8TesLy3/i/jcen9S7sU+ob9b1O1AlJiLtf/LQuio5r/hsTB0jLYRvGc8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742851; c=relaxed/simple;
	bh=WpweE0TSh3yxXmsFt6Pvap7nVJFSSqmciIIFUU3MfY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cmo5/EqJgx//pl640CsIuwblSkGUJfR0yTFYsx8ruVQGoXbjWsKNUi397M4U3jJ5AVMCfY/C7RFOfSuHvJlV+j9nCLRpgSSK7+kcsv2nkiWt/L8nie8AhkazWJQ8gRbF0p7ItsZHbQYNS+E+H0sZiyQhL0JciZ9z/PRrrleSsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=GiHjAWZu; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cso+5tLqeTQKKO4EZ493bd6mPolRbgVqpRkTEZ8wCvs=; b=GiHjAWZuixQ0SHXQ06qPgG6UT7
	Hq8yzPf2jUiJ/Zsr++itTALRJBdupkZk8y6MvoyxrpIpCKJoEhpvXoB1R9albUjf3TEwCItKP7/U/
	dVJ1RItYpuA9jVSCqwIpQT79ADlYsZWOY26H6Djt6bBnMu+9bdqm5EerqbS+hMWOvTMWCkpvnUz0n
	rJJMWMmO3YlJlYzLBfEdKcQmkdO23mm44tjo+wInWRSBs5wiLwqAZeSYOsKLOJHD2uCQd9puC8zZM
	7xjvxRuCAdN2ELGSHsMwfimJUAY/85KEUuT+IG59nkiNO30Ur1aWmEUrTdj3xbQboPPcGCV4WVWzE
	gOe/ynNQ==;
Received: from [89.212.21.243] (port=53282 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ucKTp-00DbO3-1t;
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
Subject: [PATCH 1/2] net: fec: fec_probe(): Populate netdev of_node
Date: Thu, 17 Jul 2025 11:00:36 +0200
Message-Id: <20250717090037.4097520-2-primoz.fiser@norik.com>
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

Populate netdev of_node with pdev of_node so that the network device
inherits the device tree node information from the platform device and
its of_node is available in sysfs.

Without this, udev is unable to expose the OF_* properties (OF_NAME,
OF_FULLNAME, OF_COMPATIBLE, OF_ALIAS, etc.) for the network interface.
These properties are commonly used by udev rules and other userspace
tools for device identification and configuration.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63dac4272045..5142fed08cba 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4359,6 +4359,7 @@ fec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
+	ndev->dev.of_node = pdev->dev.of_node;
 
 	/* setup board info structure */
 	fep = netdev_priv(ndev);
-- 
2.34.1


