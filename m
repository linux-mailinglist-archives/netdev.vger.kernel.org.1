Return-Path: <netdev+bounces-271578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BNMCo7sw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:09:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698C326796
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C143731331B5
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59453DC4DB;
	Wed, 25 Mar 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pL54892V"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CC3DB642;
	Wed, 25 Mar 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447151; cv=fail; b=RY6IDJPspEJePzNQhLvQX4cWP/+ZRs8owAX/ZN2jRxc2EMhT2ico7hxv9KzjvB5w3pAeDHt5wExtolJqC31JP4fzBQRYK/zOfOgJUHXP53NC3HkEOsCkvB6el+Y5mS4KO/Ag7B8MsK+4rNiuMyvWa606TF47DDuIvc6Rw71eTLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447151; c=relaxed/simple;
	bh=wQKDbvRMyX8fhP1Fbq7C0BtKZAK7gKj5100zLD8nxOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqG9qZzJKqMaIVCXNPnH1JSz57r9eXs0KHgrCKZWBcz6eNmHQEcrtnGyM/Zm5U014smVFLe+NLUmEef2a05XZ7LH8MxM2LFrXyndzH/kPU6/MvhRxb284gbKqGzlWtG8iDIFDCawFVYUb3hPJzVYunNGQQSC7Bl2ck7klP2dqj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pL54892V; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqIQLcMu86fxeQsZwtqV9xIcxTUrrp27loFPBeoUf93FIh8MThJXi62QC3HaAEDK30Px/AIF4Dv3Tmcpd3qCVD9TvR7k9+QZLvBqqyGnK1cRZ0N77I8r7eTFdEPGcMWxyhlKjGq9DNVuM511qe9wjXdOXHqB2fbLKZRf3OqqP+LhiYsOZfh7gTFbLqB6RPEq9tWyIlBg7bDeYukHebD/Q0rwMXnRRR8JYS5T8HiKwzzGQDjFDka3X4i9rK1Y1R1N4LjUz6nlou8bpmH5K8DK7suvq5MdqpfzmiRTb/l7aitS3DkuL46+uIj4ybOfUC0it1MiSQXj5+lWzhm8ZgCSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0ajSBreS153DEhbagaXKI/IS7EYWXn6jiDxs1ZQ6+4=;
 b=ivfHM5ivY4NF4Bv5sM7S8SsMUTOCCuQNMnHbzLU5ZDLR95yAF2fWkgDo8cUNcoHoe6voXq5mj30NJB43ySHyOMMT9A8zHYJEXmmdT6+64S1W/pv8VxoulqS0XdukMjsYBpoxTzGItEJDnrrXQqEsgP4+S1Row2TG77CeZ/KzL190gYauVRcNLumK5xYNXU356tyz08PN81v8Xgjrs9O37izfalcL9w9sIRQCgMYkSFvMciBmX/CyvVVACBJWg+94+C0m0sr4kZAECrz9IBWCYl2iZsyw5lWEqDs/FcBywVZgDq6cWm49HPWnTHn8BBT5FOYdTDDoSP3NEZpPmxDTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0ajSBreS153DEhbagaXKI/IS7EYWXn6jiDxs1ZQ6+4=;
 b=pL54892V0xnpSsRAsjXFXVpEBeziO/639hoCl4bAWt6tBem/XQVVEcW3O1pjKLBO6L34ZAI1FNqFyLtZilZC52hkp8JYidi8ZFhTu84klDpzo3H90qxfcO47HFP5Z9rkJIY12SqxPh0mgGb0CayHr37SnzdcwRS22zPrmW+KpJR6hgaWk6cHx/5odAWs32ok+DID0F5lObTKz6HiGe51Pgt0KaWQgJFWR3cU738luiT1Q7yJlOAJBWMlIJxOPxgr2WmSilaHdtGpgU+nYlJuPezQA3zNYSf97747NxBmln8k8XUxKsu4X31dVb8vK+6yBTaDE9dbNEACLFb9s2EBZA==
Received: from PH7PR13CA0007.namprd13.prod.outlook.com (2603:10b6:510:174::17)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:59:02 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::14) by PH7PR13CA0007.outlook.office365.com
 (2603:10b6:510:174::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 13:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 13:59:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 06:58:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Mar 2026 06:58:44 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 06:58:41 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 3/3] arm64: tegra: Fix Tegra234 MGBE PTP clock
Date: Wed, 25 Mar 2026 13:58:11 +0000
Message-ID: <20260325135811.148480-4-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fe5123-85ba-4872-725e-08de8a76ab48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A6aaIUm5v3NRTKaGqtOJ3LLFkijGQutcIzTtlAiV9GD8sR0CmGcrcN/e9NeIpAPZ2P/gWyOlJMtbq1W5CSBTyPWFFNy7iFbt9yH+17pIGCZz153z7mhyiI1fZuxKWCq+/NwqAu/lGnYdEyXjtEcG9b3kISXFqEDvks4I0WiGhESSGYz2GEyahuoHCje8MPVM6O6kya81Aqmwt9WxDK0zXyaMJftKrSB3JWwJORUBIKYZhTLnnP8+1e2qB/6HDSkYjgfgKb2cd1hgSRB8KuRmSt4YuStrCt+KUnnU8cc/Qr+3qlPkuHnnxcSUuE5ql2GeJcXKwwt+h85/yhRS/U/vqHCuwDOsyQ4R9sOnI0T9dTfLRFk6vJGN/hzouS/UPuUFG80WlpBJ2Y6wBY0/VjPNwov0u2RkC+MNFbeHnbFZOzU9UVaoKLCfm1QVrFcjXnB/c3R77kQHeYggOWIkVfNMj54JsdxrYhR20bAlFGEOUSMFFohf+tm7mjO5TnHtK+cIi9mOPW64P9yvgCGHpF4uGoIkVKKVkgtJQ0PSQbVXFO3URPewmbkKboJcetNYQh4mmJXZ0tNID4cO8bwg0m/MbcdckiV26+QnJ3ux2tptlkGO3LcNBZVDyoYuOXROCqHUHGJePgXt+EiLeEcGR31Hp5D4D55dJWoM/Y1lXFx/T1FnlxGP1rMsskMf0fZdzpM0b2TnDkQsuMn5E9B0Pui9IbbuoQg1Mesd7TrCxtIPE4Oq66q9XbRzNqoEb/Za+SabcU9z3d12pspozziejA3M+A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aRVaUmjw/AXSvkpOoARqrtKgbAeLDbULG3eK9RUUISkyqjYUnZwPkUsoQ4xaqBvDJDPy8++IlcVMMwDUB5pZiDAoSNiUZNDil+IZUIkNWk0WU3iOLvVeAID7QoB1tsx4gh1TQRmsHwgaIP8cbDezUXufD0d00zIpkZ6xB8u6uik/s61au6TdSYeK3qAEL1qOee+BBXjCRQwGaDYYKTQfXUGB2qkjBk58/otNl6iM4+v3Bbwwq2DkWvgdT7WQ4A/9dgsE3yFo0r7F1IG7Ny9BI0qx5VSjBk6pj/ipaFG6N1UW7TzuHcQKWlra9kpdcCKlzs0ujzHEqJlovhk0z2gYoeDZ+LysXHtoEXT4Wx5ztuvJCwMHMXfi9WJW+SSF2trSggjzYqE1YHssi+sWe7k1SQ4KHz7zAztWZP7gPjInFMvv15dfIMr3/3+bOxOqs5Pg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:59:01.6378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fe5123-85ba-4872-725e-08de8a76ab48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271578-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6b00000:email,0.103.194.128:email,0.105.73.32:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8698C326796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Tegra MGBE PTP clock is incorrectly named as 'ptp-ref' and not
'ptp_ref' and this causing the initialisation of the PTP clock to fail.
The device-tree binding doc for the device and the Tegra MGBE driver
have been updated to use the correct name and so update the device-tree
for Tegra234 as well.

Fixes: 610cdf3186bc ("arm64: tegra: Add MGBE nodes on Tegra234")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 04a95b6658ca..18220cdac9f9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3605,7 +3605,7 @@ ethernet@6800000 {
 				 <&bpmp TEGRA234_CLK_MGBE0_RX_PCS_M>,
 				 <&bpmp TEGRA234_CLK_MGBE0_RX_PCS>,
 				 <&bpmp TEGRA234_CLK_MGBE0_TX_PCS>;
-			clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+			clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
 				      "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
 				      "rx-pcs", "tx-pcs";
 			resets = <&bpmp TEGRA234_RESET_MGBE0_MAC>,
@@ -3647,7 +3647,7 @@ ethernet@6900000 {
 				 <&bpmp TEGRA234_CLK_MGBE1_RX_PCS_M>,
 				 <&bpmp TEGRA234_CLK_MGBE1_RX_PCS>,
 				 <&bpmp TEGRA234_CLK_MGBE1_TX_PCS>;
-			clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+			clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
 				      "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
 				      "rx-pcs", "tx-pcs";
 			resets = <&bpmp TEGRA234_RESET_MGBE1_MAC>,
@@ -3689,7 +3689,7 @@ ethernet@6a00000 {
 				 <&bpmp TEGRA234_CLK_MGBE2_RX_PCS_M>,
 				 <&bpmp TEGRA234_CLK_MGBE2_RX_PCS>,
 				 <&bpmp TEGRA234_CLK_MGBE2_TX_PCS>;
-			clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+			clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
 				      "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
 				      "rx-pcs", "tx-pcs";
 			resets = <&bpmp TEGRA234_RESET_MGBE2_MAC>,
@@ -3731,7 +3731,7 @@ ethernet@6b00000 {
 				 <&bpmp TEGRA234_CLK_MGBE3_RX_PCS_M>,
 				 <&bpmp TEGRA234_CLK_MGBE3_RX_PCS>,
 				 <&bpmp TEGRA234_CLK_MGBE3_TX_PCS>;
-			clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+			clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
 				      "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
 				      "rx-pcs", "tx-pcs";
 			resets = <&bpmp TEGRA234_RESET_MGBE3_MAC>,
-- 
2.43.0


