Return-Path: <netdev+bounces-271016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGrYM9+BwmlneQQAu9opvQ
	(envelope-from <netdev+bounces-271016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151730818E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7121C3111B56
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5F3E556D;
	Tue, 24 Mar 2026 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmt6OKR/"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178D36165F;
	Tue, 24 Mar 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354622; cv=fail; b=KOv8PCaFZgEZ9L9LkCMmzgXJxTBD+ugrVjzPTKpZZjWufw7DftHLjGUJ1rhtUbRJR7aFPE3hrVYbSkYpYyasB+gvzbQv75s9OcjdeqO7h2P8W32qRVnJ8mAjDZNtlPf9PXWoglfB2WmhSJnEyygJpMzZrWmSsS3wbJz2r/t8qmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354622; c=relaxed/simple;
	bh=SWfdVeOwUj1T9DFpvrS2q8pYu8MhZ+9qVZ78RbgVy5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI3FXDzXc8iNc+OQRvHhyeBm8c7QVh5CJU5XeETc/AlIydQ0hsK8yQCCjvrS3x+Evq9ggxrURiw1c7XcSQGs23aU7S2aREVTtEP8DRRUT2IP4V9/qIkupkZNHZeUwXoPvJIpUoeA+1ZXQXyMc4zdPbSRXDbC5e91vQVeFzprbCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmt6OKR/; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee7+npEZPKdsuqQBaFKJWGpaA964oxSKU2EO96YrGj4Jq59Z9nIdjelamMNyubCSTmepXBkPheZDvXpF0BX+GUBSjuzUFJk0LLOJlAt332w++M+9vfkDVknRFgEuIomd9yeivldxry9fKAmJc90aUzOpJ2/7tN0yLKCj6rwQ12vemj7pNgW6GRzVyz5HE8/miTGYVJuf7fCn1YxEqqyHzTAbGjwJDvZ96S2MFCnPmoXbudZmeT6mDiPmmxBLmtF7vzzZPuMvHV5g0aRBL861nFbE5JyQ7w4orskZuk4bLu2mYPLAjEMid9Z0rvhEN42KNrw/tuhbkEazpR1RJdqS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SP2R54JL0uxmAu60benfau+Y2UTCJ548fhxkZikuY8=;
 b=BddBcFy2SHYnNK6db8wzJ7AQC+gOCz2mx7sb54TetDg8KBCXznOGmL6vF5CVWVlH1Q8HeiZyTZU/RtDqy0Ni2erCT5O/2AFBaMrbz5o8wBsfQSAXnM0v4o9CTsfOK85wX3zqipFwCRSD+vEXbk1S2f38U0Z3jrncxI8gD2H8pQmedIjop1oskPjeuG0F6iYKOeZZxRaIw0MMk24oizlC5/eUJjO2VJ8PADfjpJcXZ2yNkemWSwq1pIw3frGFx+lxC6uxnyy4DOnKDP4eZspfh/eJKS5ehMy2+8+mO0ZYu1w8hwRGBHQSUKmMWjb3xEJD3sCtnDrDWkAiJ/BpyHfZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SP2R54JL0uxmAu60benfau+Y2UTCJ548fhxkZikuY8=;
 b=rmt6OKR/s960vpW53mT8cY/cjhDK2q9BCZod+1dBgoT79NXRu3FIcQEbfwpZlQHgHWgWFiUurlxFqhGbriwEEZOQ+MjKMyn0l05UXKaGHBwEm7cotllejYncwwKkNoHNAVLliyySRn4h2EsMM2AgofA4IJv9Jp2cLL6hmtpw8NWbNeHePxv4SrUTg5HW5FpDXPj8l3qbd2Ze+Bjx/+Jp1b4Hq+vUVQJYzuKxVx0H9V6hqsXjOodf2g8QpniKyqHkB7VB08tTE38zDesdmJ6a7k7lXmOCH9eVa2DzjuOX11ByIkFs/UwksqDUM7A0pjzBCoI9duIIJJ9H2ZIg+WBLjA==
Received: from DS7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::14) by
 MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:16:56 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:259:cafe::d3) by DS7P220CA0084.outlook.office365.com
 (2603:10b6:8:259::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:16:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:40 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:16:38 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 1/3] net: stmmac: Fix PTP ref clock for Tegra234
Date: Tue, 24 Mar 2026 12:16:29 +0000
Message-ID: <20260324121631.771628-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324121631.771628-1-jonathanh@nvidia.com>
References: <20260324121631.771628-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: b91fc78f-b3b8-498b-55ef-08de899f3de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	diJHp1OTi6fvQlWsBRk61jwyc7C/mH0l5Nk1kreNvDY5kQDZbF3IjTnGp61jQwDKhaxJJ1XJ08t1HUe8nBVRj/xa19lrRs4+5sd5x5caF351/pBNoY+9LH1VZWBB+N8WbEaYk8zqhdsSyMB1sLiA5K+5MviwsOJZ/fKTwYkzOZAwGxy67jpYSmkmABgQUyACahUR9Ry9i71UcaxXTp6Fird0/vgMi+KjEOjoXdJxTXCyAY03X89/uKq7NOtzn+66iYExAH6wrKwAhdT8YBubRPIsBV6JuHH8BvGbC35aU8lxilm1u3enkY3UdoImd1w4cEXNllAlU1Te35zciJLuTOrTEZsbnh33Sxn4O9gHe7EqJyO1FjSLBHdBKT0OgeONBwcAjrDHZ5FJurXwuajUht4h2cMlnS9ImPkZwUx0Nu/yIQAlB3bI+VIhFrGINY9oX6X+QHl1ZpgiA4apzuvM8iff3cx5oOjf6wFb/3bGD3J1Cs+ZQO/ua9wjY1a5gjMkEw2DdAX8YtmDPcplORWP4q9Zyf5j0i3zW9puOeX//2WSs8MjPRbkPYcwKKdlvbjfgoD4K5rJZrx+M8gu2OruYAGQCeSP2KZMN0hN/z5QPhfX6yGhdqodxkHx0ZnoempNSf/o6vZGVfNZHIv4FOUW7w4zYS2G5EJU4QmqsmZajmT6c8s8iHH9O+q9VbpbhT0sHX0m1JXGINSOy4/XupwVN74vDjC04idWbBQePuuJJX8VO+FA4z46Bp0go5k5nyjtwD29VC6tdbDMgZNMmK8jXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/bG/20LDItutTxCd5Le4Dd8u6uZ1jfRAYL9KXAYzmqKT61y483410ih/Fl33QComl6ZOaynhHAPFiPT1tdI7EGV0RTirlRioZ8suZgrR51s9i8K6gfXR2EInI5EnhzmR2Jh2vLeOLocsCaK/o9qOoAMVEyRNH1bgPRjuU87vwUhJoit1j0HN/pC16SBDyoFS1Br/1Wx/Be28XQ8rfrVoEPrGKZm2O3ti5FraKb+DwcFzbpv33Ej+2HPUSWZK4GkScib6ZmOaBmaZVpJk/jSv5woDb/F5PHGoyj/6hfmc0+NHh+V09zJE2ZWZA6T9aPZriL8BoI7HD1NbQiNeKNbJ+sjIrhYsc+mynsujWWmVjX3nwY+oDzrxrB6oA9FJMbhy/WaLZJQ2ZrT0LKyHtjr+lEdsp4jrboPAUyA1D7+OSORtKBs7EvL0zlI/tLYf1IAC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:16:56.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91fc78f-b3b8-498b-55ef-08de899f3de3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271016-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4151730818E
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


