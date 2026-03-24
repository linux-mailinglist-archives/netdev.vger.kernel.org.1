Return-Path: <netdev+bounces-271019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAJgICyCwmlneQQAu9opvQ
	(envelope-from <netdev+bounces-271019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:23:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC3308228
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D83D316675A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176323F20FB;
	Tue, 24 Mar 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0UmszLE"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD33E6DE1;
	Tue, 24 Mar 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354638; cv=fail; b=sdPmffSKjdkCvuTXtcq7RKt2RSzjRDuhN6i1jqC9cqbLuqZnNTzJQJGNbDws2rxRz/eF3hWu+RBiRGnoQHVc0RyuCUt1HmDCy3XtwqKHsRS9Xnl1pZm0f80ySC9vIdtfqQjoJcWOhwbVVMS/RpTHtj7xf2B/3Jedbxkh3SUAgSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354638; c=relaxed/simple;
	bh=wQKDbvRMyX8fhP1Fbq7C0BtKZAK7gKj5100zLD8nxOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z48FyGJHsia3n57Dl2uXCmEasQBoNaeBViXbLnOBQ5C4aVmvdzwFa2xinLDJoDWYzPOw4BxW1iAF3kI24MA/gptUkG4ulZuPUstq43FyqfqxHKnI1eX3RLGXICipQbPscW22/js1QfaefmfTTuqBBptm7tSjRZiafMBVX3mdzHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0UmszLE; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1rB/3WNSc3hLVVetoFdlzW6H6MHdFTPR6liHX3F0iQ3wLNyDG5c8VfU6fzYvyKGneEZMfz01/Q4l8DXnUc6z2hRbPpjcUV69XqTotgUFqkvZEpEu1M5hIUNMUeJGBP/sWPrBx33v7Vde0bW/YHpkGJqie9NABHA5jGh4HHcFsKNKs5ozifnv/es0u65M4WvjtZK7ESMknNuI+OimhJgBPuaBgCpF3Z4lPNhm3HECT0FA/Foy7zOSihYxF8k1BVbHsLl/L3ODT0dhgX/hydujTMzdUoVrFuZN7DcQkW5/FDHUnWFuWhZejmSzz2vzHPWFhIdhdazE5a0B6Q2L1VSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0ajSBreS153DEhbagaXKI/IS7EYWXn6jiDxs1ZQ6+4=;
 b=kTtEf9DoXqh/0l7xXfY4OZXv434R+ePUzSBDS+emIkvP7R613D+f3TRmZOFldhhBwiOOXIyQc5xfZcTRirf0b1sCxtlzFsXbsfMATbNOun7iEab+TJxb7fyxfEAfHcrihbsL/uM9xsB367aKLJCrodMNCzeYRTcpoY3p2wN8dNAzEK/okqK3BP+Q9JsjK38FoX9Yw0BxisGdMaToLn65OVRHrK48e6AEucggR4azQWnEP1TWXyCZQ1mjuIwAPwyOgLkkBsrupEI9RccNme6/caDip3DrdBdL1XAwcq0qkA0jWUJufy1tGaQ4Zj7d1IMDuPWELO6KASKKJCFSYqrkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0ajSBreS153DEhbagaXKI/IS7EYWXn6jiDxs1ZQ6+4=;
 b=r0UmszLEFoXCi8turPcin21rWtJJ7bDj3Iax/fYmk6r2fOZN/LV927BQzX0jNyRsTBbUDfwxOU6iae4yinXrzVTH/Fc584Q+3ghfHADTS2T0Lu/6g62beONd96s7Qpw8wUj2IRdOTpIF+lCb6VnM5peweXRhOZI/fG34LutiLV9fSomlb6LwOD25j/uamJiJD86oxwFI00+ifglB6GoHTaV4X12bR8GbZQgYoNS+PhbNYcZSpTSU2zHyTX0fRqB0D5phvszgdsO/mKDUgxNU4vn68uPvP5zZrIB2vztTfbRExUtGqiwsFuGJJRAyEHmq1kqMp1AGRtjyiNmRV4QJmA==
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:17:05 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::50) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:17:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:48 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:16:45 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 3/3] arm64: tegra: Fix Tegra234 MGBE PTP clock
Date: Tue, 24 Mar 2026 12:16:31 +0000
Message-ID: <20260324121631.771628-4-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fe5ffc-e491-4159-b73b-08de899f42e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SzZ7gX0C05mT1bk+23fcqpXnnN+pB3nG5cXJrqXEFJcX28wXWhIQi5WuryzmIRbqMDmrwExhZJUDdp+rwfMDHwL9rNojZ4EzuEBgb16a5w+YO5m/Fr46o6FubE70ye1my9JmOYplBG1PxRqNsh7moqRNJiO1Q+Qbu5Tr6E7r304Aaosb1Pp6oCdg55vtvGlyejFYszjl/ZEoKJYXE5MMgiV5sP5lps3jH600syps09O01XYMQTi17zf0z4mjUMghjTkFBVaYROekDYuwaYehh1OIQ1tb5zeDtw2KwoI0ROcprAw6FU1/MGmDu5ADH8XgtpW9eaOXlWXrWKR94L1YjvKMSDdEgDvf/Ut2rk+kGr9AvMU6nnry6mEbeSGJ+BD3JEzHPM88Vc0GH2R1nV4PO2lOSETN9tltbb+iZWDU7d25es/inXc2RnqgAacQzr270tGFehTddrzS3ez5bXXcMX0Z71XliPdUagaanr7qpjAJHfjIDvf3dEcR/r3tCX0EX2jixHCZdTUodHHezeH76ykIoYx6LsEeNnTFFVGE9OYAiEZ0kAdn7PVMsoeiX5sV752lar6o0RyedK1+2xsnzYMk9xgyYQ3+kvfjeJkuxhT6l5PQvT71gQDgSn+EIkn2UgZVTSlCViTWu8VDIZhUApJtDUCBu+Q8IAS5U4F3RWQOVHnaMhA4zHPN3zgPbmi2BaOut4DJPP3vGhG2q7Gnb/Bdb7xmnr2ZjOBPX1e24vnZmsM98pH+LIQSrWQ+q7wX3o0pjGAwGL7FOnI9cYBV6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u1dB3clG/1hOok+Wmc8M/CT24IckcW+ORrCBA6cDqB7tzV1NJN59x6OasMN4i/Z//CR36bIOF92yw2IZbI7CTKTvxuDK7Q3g1dXw81OcAbj4w9scB1aV5VJbGDmObgcKmT7e2X+JvDfa7uU/ACmf/aW3TI0YT7SMYNff5TnYYbtw7hgHiqoxHkJujPL4deP/I5Ov9wsuaKBPjEhTuhrlLK02Y/7T8D94E/A3XEEOujcBNDJZ2ikxEow1NqZtfUBIsoXfEq6PzcsANdA3G6i0Ct4p4TlzHdBCOXDw6i+ikxNih2N6OXpa3pG++Raz6NWyy1E2lktvCqg1VmJd5K79Gb9nptbWURMuro9lfd4nUgE9gB/8mb6035iFIX1Bu+uz0Pd4Qbb8ZDxEakKTvF36fYHe1a33DRIzfF6/NHqmN7i6tNjSU3w3Ioym1hN6FP2T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:17:04.6573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fe5ffc-e491-4159-b73b-08de899f42e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271019-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.103.194.128:email,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,6a00000:email,6b00000:email];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.105.73.32:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1DAC3308228
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


