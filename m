Return-Path: <netdev+bounces-274031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFKQJLr2zGl9YQYAu9opvQ
	(envelope-from <netdev+bounces-274031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E69FC378ACC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECBD3059A8B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B53ED12A;
	Wed,  1 Apr 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USqTTkxp"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1393E95B7;
	Wed,  1 Apr 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039410; cv=fail; b=Oifvnx+zcqphHRQckbWAntc4PhmxeyZ9SEiNMNhgKX3s2gkSdSGLZWrMlHUiOq7FEfRI6UZsF/QBu28/VAI+uBDFpYftgSS4oocnO9qII9x7wsAR0QgrRvq2ulhO43j8dmX8RV95k0olJbUwbj4IYhFoYdau5/tr6VVHYcZKURU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039410; c=relaxed/simple;
	bh=TKbSMiPEm7F372mHbCqz4qE3Us9cFlrursSBUgKNHyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/5tpWyYhp5ZnbQ2rNGcqMipFWYuLEwMA9HRDK6o1on8n6KKSgPWTemjLo0PGdIbvneUOfNAqeFBlpeBHkMtTnqM6PVeo4E0lJ6tKmjH5YuLfFycTO6/1fLQiC5FpK+0wa5XkfBV/lNYSKD0lKUhBjY3OB2cQ/vsBsSmyctpze0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USqTTkxp; arc=fail smtp.client-ip=40.107.200.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPfQ0ayRKQp+chHxFQg5L+wXD4uNJ+7KPOOQ5fqk5zGIKRoe1wem1ouGZmamvPdig4CnEydcwKmt2+G4flrsgiKutetjFvzhS/4/Ck1XIMTLlg+lgg+DUc03nW131kHVakHe5QTU9PTnF9FVAUJWZBIaQPxokxYI6cmj47tbmjjzO+06k4zFruXfnAv2v1dMoBXsPm+8YMFvx9KmSJyGgN2jiJYyjUcFvAXMXXaebyj3NetqKBa1opb+cbZrukaCSdziVIoFHh4Wlau6Xx4t8Gq1B52WkQlrhUkso/kfi8Z5tzxEkr5++BB4e/ZSgbTyxDRD5mHA45t+E/WGaCo0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s062lHt2WvLgB/mpHqpF2f6nCayFCYN7PZZL98EOlIc=;
 b=EnzKY9PIGfO8vyWYin45sdFxWaFfdz+fV8FFgY8/pd+qBY4P++DN1AfQYQ6NzzfgvXQnjzpPRxPl8aq/1C2xreiBrenDtPiqVrXt61pG4rU1hPGbVaWLHdf8Zmkq55EPZnvLYnQSvewwAO2ZNAsYOeSjyHasM35MH1GzgmLNyR6KIA1dAa3EMsiKgDS67jvieIR4paFiTvFsEn/0EU2RKh/PlxXf44SCHmY71EECSgpdelx6YL1/vc5TdqdM6r+kvYeQTM8LLSRNql8dgd9Ylngua571wPnw2/nmG7HXpQ758sGqADXCoZs2wwg8B6EteftYy65Z8agfdU3HKiWCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s062lHt2WvLgB/mpHqpF2f6nCayFCYN7PZZL98EOlIc=;
 b=USqTTkxpmN0G5BYLFliCDb66TcEAYrQI1nJr6t/IJ8r8pe1BT+zQGEc22c+b7dl6zrRNTIug5W6BIsodgeYJkkb7FFlhYTGp/9vEQF/lmLRy6zAGtLvUlTEenieGSnKwtLdlwixhgZ0nkmfKgwVgtBg7elc5qn/b7aZiBWuiAWcdicqrBTSVLbs53ss6fZFqhmSvlwdpA8Lfn4RsqprpTqSsx2ENA7uPmEJJy5GS7sozAR4+HoYSDvhunBGxsJgArtEIJnXA+cVJrb6wtRO+oy0JmOg9WkDBhiGydtrueAruJSI0YqvOtdW7ukJZzwybd/xWJ06XIRD2poAAEYySEw==
Received: from BN0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:408:ec::8)
 by LV2PR12MB999074.namprd12.prod.outlook.com (2603:10b6:408:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 10:30:02 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::b5) by BN0PR04CA0093.outlook.office365.com
 (2603:10b6:408:ec::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 10:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:30:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 03:29:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 03:29:55 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 03:29:53 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V4 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
Date: Wed, 1 Apr 2026 11:29:40 +0100
Message-ID: <20260401102941.17466-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401102941.17466-1-jonathanh@nvidia.com>
References: <20260401102941.17466-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|LV2PR12MB999074:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eac43fd-bbd9-4e80-44ce-08de8fd9a237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ypVUe8mdmworb5DOFJyS47lhLKTvaBey9NGoSW+jdgaGScmbGdnV1q5rytnWmES9yOey7Yd/MdQTfuhFgj8N5aHIoB11q43x3xWGAs4IDGkxhIjN7KId/zA9UiB44ROEfpv5wnKf9srBKrG+74KcP5WNM/Nep3ZHQLN8TeG85r5zacWRhXqRV8YikUMOQUiUg2juAjPPa3IgRKyzHzYJebQecZowcalbtTDwGskk1ThYOAJFn6KfxgNP6V50bQS68MumWoSq+2vtzBJndCZof/ovmAxG6LZot0du3CCxD9ExZC5Zsb+eKNn4jBVah43qEigG3mR5jViv0EWgpcb+/7KKMb19mO4OIrfKYKoqVSGfzIoFHBLFlhH+cpmsQdMdzm599DulMumxZkGmCOPk078kIz/0XbVmu3OGviZmPzgoT5wnRhK+z9JvZzPZoGhnKT4ChmYynE39l3bbljW306pcBzaPVadJMkUYv73Dga7ILEICvspLL+roEpnrznWqNao+2+FThKFaBLc+R0flA37NO6UHlnMOGYYDTIaX3Ewfn3RtWlnGkXPpLGCFEzn5q+BKroGBHT4mUVkT1mHB8oBnCKlAlqmpdlUuW5pGWLf9Vp9zXebmrmCc/EFUf0uqIJdODgdibv0eVbAjUMtAxBe0uwvVwlv4OZf6ysefmuIxQ6w4Puh13UuVrkEV7NCu8YaA5xhL0h5iPymulKUDFqVXZ3hRZZtrw4QE7slb/bbOADLHQFla+IPozhxEyb5u39ezxmpI5mptKOjwODanuA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ybdLEHvUOa1GQHqRI/HENhvJ6pCNcqSBySkSevziKVbVWPpE+RwiQ14bjZCEORzEdPtkwz0nEXhuL71ZQ1R9RWjzI+rJ6U83pyvZbNax4FyzIn8IqcjQcmts4sLJJ2yf9+FTJOGE85MCpIVwbu9+4IW+lmHIvD+PqxW6ha0kw4rFVEo0CLcp2LutYSDLCA5z6FESJKw+FHGfQk2IlmqwcQfbKXuMRjrf8cpQpqTW+DY/cT5UTmtBDcISN08YUGyM3zyV6CGWnD5oXQHvRbYupyKThKqzavx2i5GJAauHm9ih07iwXULh2kGvfHp8pdkBir0EDYmGl3E1/rwJVlD4OQMutQ1TPfvcGUlU2smPs8etFS2eb1lI1lf4a/5Bt70WbFM7AAdE/1PIfXsaZsSUMrq0ZIDebJDh+u9gscsymsfzZhqAFPmgvmAJ5Eo67Bxn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:30:02.2833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eac43fd-bbd9-4e80-44ce-08de8fd9a237
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999074
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274031-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E69FC378ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PTP clock for the Tegra234 MGBE device is incorrectly named
'ptp-ref' and should be 'ptp_ref'. This is causing the following
warning to be observed on Tegra234 platforms that use this device:

 ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
 WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed

Although this constitutes an ABI breakage in the binding for this
device, PTP support has clearly never worked and so fix this now
so we can correct the device-tree for this device. Note that the
MGBE driver still supports the legacy 'ptp-ref' clock name and so
older/existing device-trees will still work, but given that this
is not the correct name, there is no point to advertise this in the
binding.

Fixes: 189c2e5c7669 ("dt-bindings: net: Add Tegra234 MGBE")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/net/nvidia,tegra234-mgbe.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
index 2bd3efff2485..215f14d1897d 100644
--- a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
+++ b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
@@ -42,7 +42,7 @@ properties:
       - const: mgbe
       - const: mac
       - const: mac-divider
-      - const: ptp-ref
+      - const: ptp_ref
       - const: rx-input-m
       - const: rx-input
       - const: tx
@@ -133,7 +133,7 @@ examples:
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS_M>,
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS>,
                  <&bpmp TEGRA234_CLK_MGBE0_TX_PCS>;
-        clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+        clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
                       "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
                       "rx-pcs", "tx-pcs";
         resets = <&bpmp TEGRA234_RESET_MGBE0_MAC>,
-- 
2.43.0


