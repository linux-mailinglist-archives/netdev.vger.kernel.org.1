Return-Path: <netdev+bounces-271577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3RGC/sw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA92326703
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36AF730718DF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CE3DCDBD;
	Wed, 25 Mar 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWY5ggMI"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2053BD24A;
	Wed, 25 Mar 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447141; cv=fail; b=aXzsCu+/zxoYmaSyX5WExeXxjqUs8phVXAP/4T+lDkx18pJzPWTNOwmLsuG3G00GxCSrijwvGU4TS60VGwf7o+vsgAPqp6sQGuAuyNwrIjMe4QlXT1i0jj/U/sI5DSmW1Ce+bJcNBT/DrK2p3wxGmgXHuzx5KW71wd1JaGFxAhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447141; c=relaxed/simple;
	bh=SWfdVeOwUj1T9DFpvrS2q8pYu8MhZ+9qVZ78RbgVy5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn07m4jQl06wdaNuKe/OCDZ9ZIf0cTSrocjtJSi/ujRFf3ghZX+TdUIEtA+fX9Ov1AcR6eMgeB+cCIhVNO4PqXtkIMItd5W5masE//4BjChEQuDiAYBPA+llLUV/BaIZx4PT1k5RVy/wWPlvJPVZZoLzDJlih00VZUt1qc4f5q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWY5ggMI; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3583rFcNJw8MT5ytT+NYh3HojcX1y43Dd0U+oIIq6DcEkuPPa26w2HEq105eFpiqwc6CW7ouKrIFk/40IxR10IM0IZnpO69tFRj++tLPudjRfs5ZiTkpEMJv/0ThvxYUcTGPSdt0uBvg46jBK4SCyomFjsA0qkM1RQUMF8KoCAzV0mfAWI37cAKndeJNryNJyU1Sov32fZozJzO2Q0e7NhctthguNR0QiOEd95isO47GkrFgkS5MX/OdIBqSTSnWlrB5LlNFCU0eNfSTYgC3YAmazujpyooyqvoei1TDbdrULuPd1stjabHc4KrCFMGJe1iWAb8nKsTLwZpEA0FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SP2R54JL0uxmAu60benfau+Y2UTCJ548fhxkZikuY8=;
 b=Ea2sbHfPXkHptTXxQaUIGRHniZun3kHlFJhhZZCXE8PBgiheB1peX0YtR5u8OZvt8v6PCK8UjNlC/51JhpUtKwFZbHkRj10TNwcb+S7ZIW6TmcidLjBYxZM3OCKkb4W0gtFGPHWLpHN0mgzRbSqBRsB6jf9P5cFtg4fO02BW9Q+tHM0xbJyUc2zb6fOgk1iRKU9rCNAthtwVLNCY9Uwx118w2GF9ojuPwgeFGaI2BCjbQNV15sjbqcMwZxkHYhgnvnk5jJZfqtERzmjQSpqrM5r4SfuuQOfxfSsFpXqUh1tkpKRHGRARCpTc/dUa0StQPeKxKWP+71rxZoypWqj2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SP2R54JL0uxmAu60benfau+Y2UTCJ548fhxkZikuY8=;
 b=BWY5ggMIcQGp6Cq7cREvI37LfB5ylBEC6+n9JpYpvAxEq7MwmiaXodUVFvsvwvmX5GNqjF45C4iM/gG09u0gifHVDqqA54wAYYg3sQx90aXRd7avRyG+el880xrM1crOE6wnJl3PsMVMmO+KSmXQMhFGowmbViNjaZDEvhFQNjmYIlI/DE9tMRhn2TA0NAGMrMa+jQF7lUJo/X3MjmmmR2+5FIEQ3KxF0/KzIBFxIe9phJ8HEoi9EVEOgePdj8gH5W4yOustWej3B2kUYhW8DPiBwF5nMRCeeO5HoCMU7oEfVs5A4v8P6eyATYkEF0wZQvFndJeFxyWn+8UpBhzqGg==
Received: from SA1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:806:2cf::25)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 13:58:53 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::6b) by SA1PR02CA0023.outlook.office365.com
 (2603:10b6:806:2cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 13:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 13:58:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 06:58:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Mar 2026 06:58:37 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 06:58:34 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 1/3] net: stmmac: Fix PTP ref clock for Tegra234
Date: Wed, 25 Mar 2026 13:58:09 +0000
Message-ID: <20260325135811.148480-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325135811.148480-1-jonathanh@nvidia.com>
References: <20260325135811.148480-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: aa319923-5a69-49a3-01d1-08de8a76a604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YwBnwLO81ABC4GORwzkXAL5G21gZzOTVuCg1rEh+FvAsBysktm6rcyj3UoOF5oIiVhF8B2HdRP6E57aB3vA5PaIPfY0pXzgQoaMX/6Wdwaow7Bi9bAJCJ3rVyge3v9N/osVPmJfO5h1h+8LXYHao1BIGLOGcjHp1dX4+MPQ6KuR7Xe+xqQ4GT6BjYC+FUNQBWFjN5MBpuyi+byS0qJ/xSAZ7QUY/WP7+uxLgQGlbZqbw6tNsOPHBW75znYO/OYQP5iWRGXNW5BvgBqwa0ZIv7UXXlBZBNrsr6Kpe9QpTVT+GQTkPwRAvLL56YIzbT6xSgfLMKpNT18YNSNGuUj5PrMstQklWLkt8IhHXLjNa5yvIlOrddaEnMoaxzxG9t92Jxiue+XSY7DCeqt3PNgyHV3D+SdGAmwpducwD7+BPKX4sfNclj3GUJjczPm/KrqiBzfFcWDivY1S3Bt9gg71BXfZpWxU5t8LEFnVrsyIKOEHdUi1gxwJp5bDTs5NRwRAf2q1t3QQ/th8rjYtvDY2WwCvv3zGunHy+akcIuWYHR3UV9D2MsIVl0b9LVkgYJfPEezcpPwcT9rm4eXY8FGUwmn8woON4UY8QocbIpIgVvQWyr6+/fX7Fh87oaKJ+l/9pKJ8QvvedMA/X1kEk/IKCQQwN40747Giwtsj7n7vwCfKxhGygNiVr0fx8cjgZTEWw6bkDF6efnMbRF6GeV+UuHtL8lQt2BbkprsczFvNfdbo6JCK+aY+GGTOTIa+PmRN8wG2z+3N8sd6XoinrwlIEvw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ql90/7TSBlEz2ccLwds9/dZ/bGs/zjnxRpJC/K3U6riGjRoFN/7d0x4OjJqfeXCRvp1UWMC/KQyaNLxe1fHtqQjn4zqhXhtbHcvnSc+v4euP/4Rna/RXWslx1gF6JC5WMQ0qYH2ZIyHh8N24GZOnvVPFnFMboymkifeHMPeXryCXaPiNvMY4k4NO74lcg6MYfOqbTphhmzomh+S6qr+esv44A1GCpYMz7zALXfvpjgHg4GyhK8g6/TxKf1ZYTUEjOrp4NygvCjJzEojGETJ+JjxQZFOps+3ZOWSO45JZFFH+iOhHZkLygjAeocYi1vGQ656zRNF+0RtnBLn1LwghnRGld226D9IdTC7JFK6G7UGRZoK7AiaFGn6Fr3oHb/R2Y4nLAvybZgwBeB77JzU1Oc73RQvtOfbRomHokoxmGglUA5s/jg1kvn7DKX84XQrt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:58:52.8200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa319923-5a69-49a3-01d1-08de8a76a604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271577-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0AA92326703
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
0 before configuring timestamping") was added the following error is
observed on Tegra234:

 ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
 WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed

It turns out that the Tegra234 device-tree binding defines the PTP ref
clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
exposes this and that the PTP clock is not configured correctly.

In order to update device-tree to use the correct 'ptp_ref' name, update
the Tegra MGBE driver to use 'ptp_ref' by default and fallback to using
'ptp-ref' if 'ptp_ref' is not found.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index b4b39e6a169e..ec18ee46889f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -9,7 +9,7 @@
 #include "stmmac_platform.h"
 
 static const char *const mgbe_clks[] = {
-	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp-ref", "mac"
+	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp_ref", "mac"
 };
 
 struct tegra_mgbe {
@@ -216,6 +216,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_resources res;
 	struct tegra_mgbe *mgbe;
+	bool use_legacy_ptp;
 	int irq, err, i;
 	u32 value;
 
@@ -257,9 +258,23 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (!mgbe->clks)
 		return -ENOMEM;
 
-	for (i = 0; i <  ARRAY_SIZE(mgbe_clks); i++)
+	/*
+	 * Older device-trees use 'ptp-ref' rather than 'ptp_ref'.
+	 * Fall back to the legacy name when 'ptp_ref' is absent.
+	 */
+	use_legacy_ptp = of_property_match_string(pdev->dev.of_node,
+						  "clock-names", "ptp_ref") < 0;
+
+	for (i = 0; i < ARRAY_SIZE(mgbe_clks); i++) {
 		mgbe->clks[i].id = mgbe_clks[i];
 
+		if (use_legacy_ptp && !strcmp(mgbe_clks[i], "ptp_ref")) {
+			dev_warn(mgbe->dev,
+				 "Device-tree update needed for PTP clock!\n");
+			mgbe->clks[i].id = "ptp-ref";
+		}
+	}
+
 	err = devm_clk_bulk_get(mgbe->dev, ARRAY_SIZE(mgbe_clks), mgbe->clks);
 	if (err < 0)
 		return err;
-- 
2.43.0


