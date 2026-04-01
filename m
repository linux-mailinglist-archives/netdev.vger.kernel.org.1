Return-Path: <netdev+bounces-274030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCt3L/T2zGl9YQYAu9opvQ
	(envelope-from <netdev+bounces-274030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF668378B4D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB28A30DE6AE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8D3E2766;
	Wed,  1 Apr 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwAG4vcl"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD73E9F80;
	Wed,  1 Apr 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039409; cv=fail; b=IXTXQ3+uFGjtrxV34sIl+SzlgD0bgtQqC22pU3E5HLtreZJfMOsLjYY8d/xp5VtTmQ4Us3xj1mGd4Hlx4avqVqE4kQwa3aQwmM2rb+dHttEDjusWmBEmAvrSc5Lda5LerABWbXZrREC5pYk/fndr+wJaoCzA7my5ePlqMF7n3nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039409; c=relaxed/simple;
	bh=ZMTV1k/QE6uMO8wykmjOlz/A5p6Gp4fV0o5ZF6Z8JKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0Xe4q0E7OTQBBcg+hO6SXNLf84M21bevGBvIYGNv1vXWuwvUIdLajzOVwLgIK/wKVFbE1vgHBtQTchWP/fR4htULrvYgASWh9jqTDrSwQvOFxhOTDEcSPxZCsRmuTktIBKqFYMPDRjCSXdCSnEOJELPheJinQlCsNAsnKQGRTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwAG4vcl; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD5As2GgEm5k1lYOMRvjdScPNlBfVnqRtfU62OJjrRMeyYlEO21RNR0pbyxY3F81mou0FD/jNEOqMXanZWf1sTxwXfMpxs0HV9Tz3Eqmq2H5xBoRHs+V3F0QFqspJq3fryw0o8nn3/jW8yN5rkKDVp1lnr/ZL62gAoElakV0+Fd3Nr76cqlEz672JQ497YaMkqMplU1ZT93jqS42eTPbn7AuEVMzntlDRdaz2WZwGT1FSVQXe/Nb6iY64sssnnirmcjZ2+IRxxS8++sRUl7Z5PRNMg1ncuITbkiS3sV7/m4nc+MQmA6iPpf0ImDo54k63R2EOmcHFDvNBlovyiRz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8vN+vtHXSQ3OFYqOXFRL959FkxAHQMx2hpsYwbvuho=;
 b=IEUmYQ5TXhg0rp9JDorqdhLOf9W/Dv+pOxCv90m4BcOg20gD68hGVLjNhjpktmpMJiliN8Z6ZhEvBuJFJlMqJ28RMFi9E1IZLu40wnXUzOhLXDBcwpTqbV83FCllO5cKprFFhRofT+Uc4im8uWBg5R002vwuM0QJXTZfQepi6tcTOKsk9s8FfeIq7tF4nfnGM118VJL0ev2XipkFCjv+h6cryDj1LT64x4Q+qbGW+dxTXUuE3/3OB3AcbqEbO8oPXAgzQXOV81DpAhsqMi8EOsYn2rWmCqO0AdsaC1rH7hKxEwrOBL4UcnpfGpenBRR5IJcs1d16rqDOYNWQUpyvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8vN+vtHXSQ3OFYqOXFRL959FkxAHQMx2hpsYwbvuho=;
 b=mwAG4vclgkWzaw/9hT4Vc4t90NREeZGaLuJso15yuCWAC+zIa5xpe2D/RYqbcAc6ndNQIJymM9OGiUPAzetRcBDmCwbDMpBNdoFJ5buYv5fSg5CTC8Vapc/gBDHBMnJwer79c8ze7eIZTY7iROYcF5KdUIifhBsW1txzQj4hcrojLgSKWZp1Cx2PR+drGUdL1rNgdtisCujQOIw2jNGOor1l6qE5sofsx+Wte+59dOG2zF5Arpinw+bveYsQ2vjBSMsCSfk/2jL0YfWuaa/yyUEGZAqZVVjX7JkBowAwoVkyITW9+armDeaEKJBbZUZUBsUaOjQIyA0fBdmEAdQfBQ==
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 10:30:02 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::31) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Wed,
 1 Apr 2026 10:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:30:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 03:29:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 03:29:58 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 03:29:56 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V4 3/3] arm64: tegra: Fix Tegra234 MGBE PTP clock
Date: Wed, 1 Apr 2026 11:29:41 +0100
Message-ID: <20260401102941.17466-4-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5d83fb-0f57-47c4-73d5-08de8fd9a1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pCUKP/nJcCqqJ2L+MgI2JhipyOg/JaQeEIgL7AcrkPCR6GZyCTJLNNI2n4BVKuN8fFWF03RLMaR0p/IQW/1bsp4YVZA/6DEqASsm8OSUv/7Wt6tZYVn7UJsyz5/XFW4iwGLf53nfuSfp4a2BB0ed+xHmAgAoVbnG0vqy7AkgFMKo491IGSsWmaL+OpI81Cscga9zZ3ljStzgzzuDjvajnKD6GvUCpKCqPWZd5DIs5ksrZcf5hD4pJhYcL87SM4w+sPALbHOr6Ot4CIgS00Kj8tnUBTAwYuD61/ZPyAJpRmm7WmT5+mIdXx0vcVFRCXDmAIlMXd8P855sATZqxDUgAcE4kGaV1ZOsK/kaEtshFuf5/sJ/0CCLeR05pDT9holqAF2+IzF6W4W7Vy9id9HhifcSwjYmZ3bdSs+PuFdjczPNYTbNzheFdD37kSeq7FHM+dSRxr81+AdKyN35LvOhxiYgmgKe5bzKWOfNUdyp4RWd5OaSCpUI10c8MpSF8kWGUymd0lGH8biSPoTFgB1ovWqVWJjZ2WLE6XDRwz8qS5irpcvXJtUXT3HoNMfPHG04tnlySOCS3AJWIK9nVLMrq8e98TAwY5Fb1z3hyZPej+yz+aHR4fUwcuhohgj4R4NO6MHWa1VnQN6MVn/+qQDJmobygObIGzcLvg+qU3vUrfU26aDpK+PNvY7Lyq0j3OiJGjbKEiDfcL8fEvNnfE3ZiIgECDJIU2v/GoIe5eN3Xbc7WLUlzETWsJJxL8Ro6weJ69wy1AcX1zXzq9VJJvC5kQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CP7WWGlOE1wzHw2xWV/3g/MsmIAKo7Nn78Iu1U7OGLdmXpDA91JzELMkCgSgMsIoFHM+8zyw27/2qP/SptIGU+QGHRD3bf3t2w1yEH5RG7eSjlxBTd6i+MeizWf6AN5BN5lizcNi4ZFaZEjdRi5mP3JoXAGwQjh11O42/VK1gnf5LQLtFpeELc7eljWhs/PFQ4HDBjGLd/sx20fcup8pe9xW6Ikb9GuUUv+j3GooxXqWJHKhvf9t8vJrSHmeOAIvtdS7Fxyp8dC5IdeEwXvg8b99wPxmJbmhjeOkeBTn/a1rRTANuXzkAorV4AYPo/c4d0sMyXZA8FmpTMqfQj/m0VE/EiZJDT9R+3cl6GmeyzxGh0qavW5TNSADg8VzQXAU0OUoobKzDwFkfoZjsJCke3mxazapdSmZMUvQoXMybEcOdPIpg+BFoGpzs1Jq+1g/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:30:01.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5d83fb-0f57-47c4-73d5-08de8fd9a1bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274030-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6b00000:email,6a00000:email,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.105.73.32:email,Nvidia.com:dkim,qualcomm.com:email];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.103.194.128:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EF668378B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Tegra MGBE PTP clock is incorrectly named as 'ptp-ref' and not
'ptp_ref' and this causing the initialisation of the PTP clock to fail.
The device-tree binding doc for the device and the Tegra MGBE driver
have been updated to use the correct name and so update the device-tree
for Tegra234 as well.

Fixes: 610cdf3186bc ("arm64: tegra: Add MGBE nodes on Tegra234")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


