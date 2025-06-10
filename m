Return-Path: <netdev+bounces-196294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67568AD40F4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313663A4D7D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFBC242D96;
	Tue, 10 Jun 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kV67pUWQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C781E8338;
	Tue, 10 Jun 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577122; cv=none; b=hjaTZpl/Qq/SRlKCoqRmiFFIFbb5ocU56unjKEnqI3MD/aSCoP2onNw9B9CGiIuJVt+jdbDNr0IZbLeN25l84JZVT2T4WIqSZHRlNMUCbUKLzMTSi3+YlSj8TXbo6FsL6iV6E/OD09U2sBtD6q9e5YJo5LDl6Yx/a6W4wRm0pdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577122; c=relaxed/simple;
	bh=gSh7d4vb/JVifU2xnGxxkJZYnZARVkQLZUMLt8/ZQzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNHMJt6ljH2qlnZkbEyitKSDYICSQl9t6YeUYw4zCPCCxp+jaPlTWnIqWqejQH85wPNdw/4Kq7TyfQtIGz9uZ1zGdwQsSeMCLCIp8OK3CqCiYnFv4hR05FTWTAeW0Pt8Aq5XkcNgbByUWWmMRcdkJV30CLlE4R/LH/WSwmrinaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kV67pUWQ; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3C47EC002809;
	Tue, 10 Jun 2025 10:38:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3C47EC002809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749577120;
	bh=gSh7d4vb/JVifU2xnGxxkJZYnZARVkQLZUMLt8/ZQzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kV67pUWQv2Rfy3Q8epMd2XB4cMk8819yZsqm7AiDtJeRpWYPt8pItE9jmxluROpd+
	 nx2MkkiFH4tN8kAMqKuYHj64z+bHRY1cNGql5144kSWURcunoWwtL0Mjp7St1WzAn1
	 RXXrW1m6iwpMG+tcyw7tXEkT5PcrgK8WUTOXwdfw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id D566918000853;
	Tue, 10 Jun 2025 10:38:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net: bcmasp: enable GRO software interrupt coalescing by default
Date: Tue, 10 Jun 2025 10:38:35 -0700
Message-Id: <20250610173835.2244404-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
References: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize netdev_sw_irq_coalesce_default_on() to provide conservative
default settings for GRO software interrupt coalescing.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 7dc28166d337..d7d0ce379495 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1279,6 +1279,8 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 	ndev->hw_features |= ndev->features;
 	ndev->needed_headroom += sizeof(struct bcmasp_pkt_offload);
 
+	netdev_sw_irq_coalesce_default_on(dev);
+
 	return intf;
 
 err_free_netdev:
-- 
2.34.1


