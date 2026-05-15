Return-Path: <netdev+bounces-288435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPcyIPN2B2pL4QIAu9opvQ
	(envelope-from <netdev+bounces-288435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A222F557065
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08233304E478
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F98339020C;
	Fri, 15 May 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8yp3G37"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051638F629;
	Fri, 15 May 2026 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873060; cv=fail; b=XeQj8ifMC+cmlJfOkutmEPsxL6Og+y0VwYi1leN7HqwCP73QLhGOZyMXXZMIwU1e1ly6D2iPyXKR9GfakAU6V0jp9R1Iy0fBtLW2wrRc3Cxd0CRR8wZM8h2Jw1ejIfZZIF38RLCSDfknWbzzuSo6h/a7wnGWRuOC6o6+bpJqprE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873060; c=relaxed/simple;
	bh=5/cu2rKk/oC8itj4a7tiaETzab0hw724OBdPxkx61wU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WyM8vzBRFejav/X+VO52NlMoTe/NA2E3tkWjLwThOUTEuz/D7mWF6doigaxWM9UQB4GWEDWuFvnXj9DX5593YNO88+lkQ5IGWwjakTS8kN3x1AHpvkh9A+AWuFBUQ7LQIGHl5cHG8WVg9rLkdDrMOpk8IxesqTWiSlFGo69Ge4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8yp3G37; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcD/MkGvyKfeD50j1EjwZbZItqIPGur67G/p5baVBW8L1zoD8JY0dV9BSlUYkkSfr8WPoi0ykIw8iKdO0to4uldthF/n2MnPpnb+LP+/We+JWSDWF+8rmhOO5l9qPIxk8e0rnhYX+ungzy9Hvhppiq6pYSn0zqEDst3SAyBl80v8en301hkVBySzMO9ttyxdUPtJJ3FgGMvAc79R2P8ZV0gN8+mPvEjesMtUeuNZKnXfOTNcvqiR91HlIIXp6lhu1JfcscWaalMXHyef76U2yrnqJPeV8ApYZQhv9ZKwnl/UL2FEUq8OrFhOg8l7c6N+byZOUrEBG31FMY1onbFqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDLOzti0L6H/I3jM4YOZoC6JTjOnluiLFJrW2V5x0Vs=;
 b=rlfABgN6g2tqtDXDwl/IGJbVHoPvJCcGT1B2Rp28uw44daM2WTcdTCmZFty0V8CVi3kGohaBmcbKzUM1SGwfy2P/baBfFgUsjb5BAMAvNherbx8hdS/HhGjg6WLA5bnqohKH3BDBMxdnRMbWKb3AVYKX7toVDHi9TkPNuyztSHkp83tT3PTD3j77KYnRVwdoeQpfLn4y29zvD/3bJAHcaBczXobREDZ28L3+pzE5XVol3WYpnU0fR085wMr4FcC6NZ7zA7c5t1OXLmDTiQb6NdhoSkflKg4qdygpXOBFG6E0W/dGZhpDWIb7wCFtif+P+64WvXZTkDzc+jrT+bvEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDLOzti0L6H/I3jM4YOZoC6JTjOnluiLFJrW2V5x0Vs=;
 b=o8yp3G37W/GqmpyUfwafzKJ8q5GI0n/DkIlLN7nmeJXZe5pzhTMKSgYaV7FDM0WflNDb4fTPotBxRCwnlrx3lDT4x/HnWsNbu4qkzMsnjfNQTMdSPCm6e3I9zv5HirHf+6MES0ubCZI5doZGrX8HoYuKOTeVduoYnHumyKsPAJabAGzLMM/rZIdJpCQ7N6KH+4aMxLN3atLR0rhtxolP84CIQHmwlq6ZPJsaV6U3OhFFIrW4IzpdRlrVaR4eoKCriDQj/ZJEYL3K0um95//bibCBgqIId/1vtTM75W2Zvs+QyEhQUCgc9ciO5qMXSTozSmxk6VC/vnpc09Wyl7cN4Q==
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 19:24:13 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::66) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 19:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 19:24:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 12:24:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 12:24:02 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 15
 May 2026 12:24:02 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net] net: lan743x: permit VLAN-tagged packets up to configured MTU
Date: Fri, 15 May 2026 19:23:57 +0000
Message-ID: <20260515192357.3631802-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a807aa-222c-4c58-c04c-08deb2b78c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pvsOCsxo5Lw9Iw3RXBU3b00oBD6kbxKhMV63zl0JJEADQsg254iTvqNpaSiwsKKtVRMrx+33Ii4si8t+qHzc1IItussFvWVGlDFyEP/m3rZ//0jeVdgx0FacwiRW4TBWS1Ya+9h6tnwZ0RoUtUb9HyIi3QFgzsDj7r1BzSYbxmNEvGY/bGpRlPvFvLdFzJNJuDi5TBo3v3OetVn3TKhSE1Ad8pGQxc7OxkEl75AguNoZPE+DPvseyjW/ozZWIktuNCgqci5+6H12MGhiAVPERvXB6czzBzAR+Q+GsVcdY4dJjE0HRwfzz4y8ZOVexzqDoUZcPHVvlC7EUFBqPSXkxU9/5oKGOs6G6d1PmPKGSGglWP63Y+3jA62Xd989Qa1sIh/LIArLuB+MTI0qvhE5OGEx5jv47dMN3UOPjZHHTPVSect/qwcHarnN8qyeHX3AXyJaOQTItaMlo6ZzGbT15qHJkddFE8gWBlN4VpC4gMwMYvwDBR/q57U4UEGpD6BZNDCbiJ+hWxKouvmp4FydLanXGLClqYDmQpc75P+Bu920yXzO+8LKW3ru7IbWUfSK6V+nuoikL3rl0CoEQx7c3iLgeiiTd+fvVuHqyY4+mCL8dYO+1IF0AGOG/aKHlxlc7I/CMylGgCIsDc+tZORjJpztSTbLhL5saNntlEX9k4yks0HwduNVCmVrssphN1OUuC/zV4i6bKuWQ9vq4JKQ1pcLcUcFdCc6SBwJc0ppZAw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h0gXYUyhBwwT3zrb8e2TR7xny4U+wi5rjVRNXPdKYeBT4wmBhYxVsKIKQvr2U8ep6EkyrL6XTJKOAGxD5poZ0G45Std7ptBSndv85FnPKDIWLSx1ZvVMDc6+/sW1k18MQOkC8RBXjS7I+vGIPKR/eO7Yk8Nr9ruYJf/4zoTsOpds4kIsktRVWf/vx1uWB9K6fsh2Y5w2/DRaTdM6j4PBEGnHSOulwGqbu2qI+3XAaqVSuOoD9Pv8GD0yuMcRFZoVMapUvwC7iV9K5sRVmLkB5DGwhgOkfKh/fpqI65iwpKpfv6rq94SZxaRKBGSsDUtOH3rPvxBoUEpBs4faFFQhhX9IODbxZq/SuT57P332jv3zzd3fBd+j3+uhG0L5ADxZQwCyhAAtOXcu5qklTZZkgvSeQJGYobe0jnLF1w0vgeyuWf2lp2KPXlmtWbbgqDrm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 19:24:13.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a807aa-222c-4c58-c04c-08deb2b78c01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
X-Rspamd-Queue-Id: A222F557065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288435-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

VLAN-tagged interfaces on lan743x devices were previously unreachable via
SSH and failed to respond to large ping packets (e.g. "ping -s 1469" given
MTU=1500). In these scenarios, "ethtool -S" reports non-zero "RX Oversize
Frame Errors". According to Microchip AN2948, the MAC_RX FSE (VLAN field
size enforcement) bit determines whether frames with VLAN tags exceeding
the base MTU plus tag length are discarded.

The driver must set the MAC_RX.FSE bit before setting MAC_RX.RXEN to allow
VLAN-tagged frames up to the interface MTU, preventing them from being
treated as oversized. As a result, both the base and VLAN-tagged interfaces
can use the same MTU without receive errors.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 ++
 drivers/net/ethernet/microchip/lan743x_main.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..6c840f8dd9c3 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1266,6 +1266,8 @@ static int lan743x_mac_open(struct lan743x_adapter *adapter)
 	u32 temp;
 
 	temp = lan743x_csr_read(adapter, MAC_RX);
+	temp |= MAC_RX_FSE_;
+	lan743x_csr_write(adapter, MAC_RX, temp);
 	lan743x_csr_write(adapter, MAC_RX, temp | MAC_RX_RXEN_);
 	temp = lan743x_csr_read(adapter, MAC_TX);
 	lan743x_csr_write(adapter, MAC_TX, temp | MAC_TX_TXEN_);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 160d94a7cee6..1573c8f9c993 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -182,6 +182,7 @@
 #define MAC_RX				(0x104)
 #define MAC_RX_MAX_SIZE_SHIFT_		(16)
 #define MAC_RX_MAX_SIZE_MASK_		(0x3FFF0000)
+#define MAC_RX_FSE_			BIT(2)
 #define MAC_RX_RXD_			BIT(1)
 #define MAC_RX_RXEN_			BIT(0)
 
-- 
2.43.0


