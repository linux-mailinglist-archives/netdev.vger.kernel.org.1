Return-Path: <netdev+bounces-97095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06D08C9114
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4401C215D5
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712EB763FD;
	Sat, 18 May 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CmexDeL3"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0576049;
	Sat, 18 May 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036277; cv=none; b=crgMTlgOufKc4qBzeBLRNJUVQz/wHmhTb1sBaRmf/tv6jJxbQ0Mur20GA42Evbvpa7HUNiXQtNZbuUdfqlkoArmVMAE5+kXWbX4JSX3MqueeYvtSCLIDUTHFV5NrSsE3umS2F1/cX9sMc2sPg0MfdrBXbqPuiarxgCArecnANpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036277; c=relaxed/simple;
	bh=nU0E2Hu4Vd6tBUu/2Y2ZBPL4LsgszqmUvt7C5YBjkHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujWv+ld5id8LjIXxMKy7wW6DPjPj2Hm53zpegKm02Bmkx0/iAORJJRzsygHmsSDy8n9VOqIN7bCiHJbBUdvcNQwPc8ss3iqL0Q2JiBuZ17pUbr1yYXEWlTN9J5P4kxqH2kKQVXD+mG02tlxF+fycc326C3ir21ATcCcsboqJdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CmexDeL3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICiG14110164;
	Sat, 18 May 2024 07:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036256;
	bh=ORTd8VgUuVAq8aYkX1Htufqln1Jye9rbO8cQmwKmnTU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CmexDeL3dMGrX7cXKw77q1CXfpX2mOC0uO1O/+6jw/J33ORtKgbdUjeBHPiYXjWRv
	 VkSgOGVYeBA1HHKXPePJia/lRCvtzz5AcXFSBsOJgjUa5PeU4llSm3Ccr4GYJcpAqS
	 kjuCBW+x2AcE6ZRIfddc6aa/2rvWxvbpZQvtvA28=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiG4i017802
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:15 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9b041511;
	Sat, 18 May 2024 07:44:11 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 21/28] net: ethernet: ti: cpsw-proxy-client: register ndo_validate/ndo_set_mac_addr
Date: Sat, 18 May 2024 18:12:27 +0530
Message-ID: <20240518124234.2671651-22-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Register "eth_validate_addr()" as the .ndo_validate_addr callback.
Register "eth_mac_addr()" as the .ndo_set_mac_address callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 92a014e83c6c..be42b02c3894 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1627,6 +1627,8 @@ static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_start_xmit		= vport_ndo_xmit,
 	.ndo_get_stats64	= vport_ndo_get_stats,
 	.ndo_tx_timeout		= vport_ndo_tx_timeout,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= eth_mac_addr,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
-- 
2.40.1


