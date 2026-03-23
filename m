Return-Path: <netdev+bounces-270435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMlgCX8CwWlUPgQAu9opvQ
	(envelope-from <netdev+bounces-270435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:06:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B42EEA97
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06C7A3013181
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A3386C0B;
	Mon, 23 Mar 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sm3myPgG"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478F386575;
	Mon, 23 Mar 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256667; cv=fail; b=CW4OR5CWkVUJnxEA7ohA/rBqYQl5dZMi4dEpQoFKY+a/g0RHkPHsGaOZkJ0U6JgrmF5P84ZNk0OUXcd9u8hpDo5lxzYtJVPibzt4blkwuBECDF1ztQ9+b1nJwj/tnIT7tgRcpBQzR3Ag2MQCRcfuH0l5oUUbGIxv5DsMmyvuvYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256667; c=relaxed/simple;
	bh=Zd2uYa7Zq0viPxyrIqa25xV+nz+tl+wW3Dm2JcV3J9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MC2obVkzsdfTosRiDzDxyzDYg7HGp+c7XUMoEgSdOQs/u289eepWgVG5Tw6JwLFr3TOIz8i8bGGsIE2lZnjk0+z4XWvu0f6t4cwbQ1VfJZN1wNg7EgLEZLQLkK71lAXk2RheTRlhflvE8PhEZHLs3BX9kcTdfCbkyKjk/LSi3hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sm3myPgG; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8o6or44bmo9PugY8D01IEhwpwAiXSmj7m8M/8yxU+37/2+Yw5jZ4T33PPqXfukL4N+79JnjdtBc7/f7CoxEVlatQUco1Xol0nNC/gE0v5MsfyKJ2bgbx1GifdvhGoCIXipo+faPqlCFqHvr88ZmtMIVQD+Ti7ao93zGD6iBlXrKBFVawngRjLGZH3oFACMB6RLbDTpLXDjLfR8N7s5DsuBspWOXX+4dJ4IYQ1gA/OvgxhA8fOO+E+MnDO+dCWcYC7o9jOyuEhh8xvsWyMKHYVh4HMT/FJBIVXbj5yxSZaCUmZjNY3eSTBH0wYZZvFB7YOyZzYEhc3gd8Rh9CKIRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iof9wozdCNF9iBqOefC+tDROYRV+4AnTEkj1JUAX+M=;
 b=oahMorzfbEQtmxABQRopOFXRlt1dtptc5ZKC48mNE7W+TKy//e/IMUHucJLC3f7++ajmIyRKcz89WUPhPW0ei1tpcZCJVjmzFkq0tzEbIXZTRP0HeGqti45O5fgMPQx4UDrXTStQ0pEyFbCfmpxdaNj/Wf3+K8BG9VqAJzUiQsMSYAD0wnLeVmGT6ZlNXj1Txx84Xgbays7eXryFETpTlILAk9iQWmegvLkqqCwAOPegH1bB3sO68SYGqaZqb8BqP3/dyrH4jlB7vnjSkWaqegoJUCphbtXQIz+NbgihfpE8MaynPtnTMMx4RRN0RYP8wBQ5+aOcI9LaNQyt2e4wtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iof9wozdCNF9iBqOefC+tDROYRV+4AnTEkj1JUAX+M=;
 b=Sm3myPgGZN1IH8ME0qUl4B8MdIjl1jJaWPhYr6u+cvj5soKb/54d9sPkQNS3lsHn5XfxsRjh1xVBcONr1QjhfU1BaDc8FAyo17N4veDxXzGQsKh6ZQoj8tZ/aXKH/1WhQHhHX9Bhfnx2rWLM02qyh2KKMjlQqFHnnRaBmY1enos=
Received: from CH2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:610:52::36)
 by LV8PR10MB7846.namprd10.prod.outlook.com (2603:10b6:408:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 09:04:23 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::2f) by CH2PR04CA0026.outlook.office365.com
 (2603:10b6:610:52::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 09:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Mon, 23 Mar 2026 09:04:22 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 04:04:08 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 04:04:07 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 04:04:07 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62N947Ma334975;
	Mon, 23 Mar 2026 04:04:07 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62N946sA003527;
	Mon, 23 Mar 2026 04:04:07 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH net-next v4 2/2] arm64: defconfig: Enable DP83TG720 PHY driver
Date: Mon, 23 Mar 2026 14:33:58 +0530
Message-ID: <20260323090358.632329-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323090358.632329-1-m-malladi@ti.com>
References: <20260323090358.632329-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|LV8PR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: ad378663-5d37-4546-2fdb-08de88bb2ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UevXR2MvgcYnuKl6Q/VRnaGeflb9CGUw+9NnLYTmp9cDU92KoDhdVh1NwDh/u9czXv095r6B9b8788gXK8LqL3AHzxMMeAzqPvvOjkRb7ng7WjL04glNiPeKO0WC5Q/jZ7GWzpFh0fj8e3meoGQ7BP4ZIfwt2Jrk17fAyMpYKzDqsKXIziFT5mpLeuMElUJPl8JtCk9abd1ZwvGqs19W4nWNcJBrGwBhd8QjO7Zz0gsd9E5QGar9p2RJnc54GT8EpgJCX6KLgEOSZZZTn9NiRTHCHIq8nysoAUt6aEXfyUdtTMoOXlMVOJy3XFEe1tguuJ6EvObYJAlJf06u+y7UrP+APX4pPQDLQzX1ARBsYNeNmPFLgRomXmRNmmgUIQfgUbbETaUiZWVAEtrh0rS7zfQebY4BccqwF9rYJdudMYq7zQKipVN6sOpTdDgiY49HSDPR1H1OpOXZPKaxP8NlDQsNYr7zV1cDX9a+9Cgr/6M3WrfvxiAYqHJZ29QerMQ93EUmP38XK3nRXbh9gKjAnSaYo+vfnZs0wPmJ6yvuKSgPiUpDJh4r+oOn8yqdvqfr4Thk0IrQU2ziS9NK5irU6EQZ22FL8LiVo5iORVMyVOW75SBAoLpU47wVeD+1qmGIHAfWfs69o7/Up5QzQ2b3jnFaGMjDbXSRhwDyGEOYN7T7JgI32C1LU8fwriReciYfRHQywP86LhDQnfbwO39fvaM/SXwjLwGq8GHd5ADuNPg9MNz3pNfDMd9/PStrml7Kv65YSdNfNsWCkt1iQkrFXA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m4oHhCVPDvEs0bT1ZPwjNhuB0OvOSjVilauJQ7aoQjNUBNB+BYJKP4tTjVihSU78Mt/ZsFI5RpEglNl2Vh0/Sa3Oi+R8gP5Uyq+uB4naHDf7ouHXmLpzTRpqluiHaGama78B7R8iuBKOP/F9l2rPhNT5m8EHM2aLRmA+2l90JmxXU1dFX4tRANMs5JSc0/ppPxWjvJrPIkD/UyVvpqBG1vWYvFwVzaLldAeZPYL1Oni1Y2VrTAZwkj4BfiM9C8kPmoHeLZ7u4MwnNuRS+7OtKVq/+SJNOzMDN4WcxLdhsuCFJvEftxfSSyQfchxoAxCrlwZ4bGAM1sBU/LGave3rlU7tR9yqUG8zKoREmJjF7iaMsB02I3kAWsq53i7F/rjtTrYyrZgiQBXz0hfS0f3vHxwfaMcTdKbMkbHinQ3jma5RWyH9nLLFhDqRGWqU8+g+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:04:22.1340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad378663-5d37-4546-2fdb-08de88bb2ca2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7846
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270435-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 233B42EEA97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable DP83TG720 PHY driver as a module to support TI's DP83TG720
1000BASE-T1 Automotive Ethernet PHY. This is required for the
DP83TG720-IND-SPE-EVM daughter card used with AM642 EVM ICSSG0
interface.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..3b88df2ca5e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
 CONFIG_DP83869_PHY=m
+CONFIG_DP83TG720_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_XILINX_GMII2RGMII=m
-- 
2.43.0


