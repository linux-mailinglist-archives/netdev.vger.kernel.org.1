Return-Path: <netdev+bounces-98424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE98D15FD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E63B234A1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924D13C67B;
	Tue, 28 May 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="oIZxSF2n"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9B13E3E7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883822; cv=none; b=kiru+lXBuVudoXEPDMZ3xsbHOrcnEbFZ+JqXK7RVXZNFGuLmCnGgsooI0MP500UYeGOCYWytPKs7ufg9OqtTkzVc9p6xAQ0FyVU85gSWBpSFmIqOvZCxlxGDEuH/eVK6dLooVOJOngGA3vIK6wdDEwlCWtRo0PdY00O9ukKE4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883822; c=relaxed/simple;
	bh=Fkfxzan7+VVwhR+E/zceZ23cnz/laoCua2izY7sFQ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq0puVA8+fehGxKx+edVamL/imHi9WvWa2JlHh9lYdcGZPpAFEKNxr2EvXvHybyRjw77Q+KYcdVQrKD7rTC5sEi5WifnGj3GlU0u235ZCojydQT2rkVm+TIyxjCzodoxMATVPaVCyx5RhcnF/qqO910OdYUNtACSecD19+hRo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=oIZxSF2n; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240528080003b093467aa0a089ed85
        for <netdev@vger.kernel.org>;
        Tue, 28 May 2024 10:00:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=O62xt/3Aofzu+/EkdK/euWUcYEIO0V7gvSFJT7IyUSI=;
 b=oIZxSF2nZGYE/I5IjDM3SbTHWKs5hTqoU+tjKm+3ZiTW+tBCfK0OSS8/E21ud1Xec19hb9
 0qfxon//A9XLaOXze5r+wvzV0u8+YWc674HXcVeYrSvUk+zWV7lHC2rHnmHeAFdkDp1BKEF0
 4vonubOlGLoQ+zZQuFvMxyoqmUjUI=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw-nuss: populate netdev of_node
Date: Tue, 28 May 2024 09:59:50 +0200
Message-ID: <20240528075954.3608118-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
References: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

So that of_find_net_device_by_node() can find cpsw-nuss ports and other DSA
switches can be stacked downstream.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index eaadf8f09c401..e6f87ac394fe6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2703,6 +2703,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	mutex_init(&ndev_priv->mm_lock);
 	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
+	port->ndev->dev.of_node = port->slave.port_np;
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
 
-- 
2.45.0


