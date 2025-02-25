Return-Path: <netdev+bounces-169364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE01A43927
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44823BE2E3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835A266EF9;
	Tue, 25 Feb 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PAF8Lr9d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922D266EE8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474667; cv=fail; b=lw5HLxY62B1siu/xRUzWtNebqR6pag2nexVuG5m0FjG5VP3NTrlHZ4H9Ggib3aBQ0wix7B+g8t6HvlEeYqJZJF/y/oKhdHncjp8AHcFBhx681OndUUDZjBZaecdSdWFO8K+yHHznQm572GvmzqIq0qQwZUAs8NMo+ftSh7CC0jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474667; c=relaxed/simple;
	bh=v3Vo8bJjvpGIjuCxsQ8Yr6pt8dfEvhLsQPMO57Fwhi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5yL9UMfesw7i52X53najGrQXNbz8gVEeEcOMfvEq/t4FOrvrCZe5ioQI/KC04+c2jV6X1cU4CcZ3gUcip78EJh2AoXsX+1ESygJvKA6LRCCZ0P/9MtKzUVBsRIZRSicCG5GpjYtCGYZfnWlByEoxVFIfsGx50w7nRYrPbpMTFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PAF8Lr9d; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5V/mMlVebU7QWDkKOpfE0iCCoCjoZSO3Y+Whwm4Ox833wZKfCmc4DKuyEVfAjEJN26fu6YL9jb8FOHQOeCxgKeP+xxAMalX+arkfQADc4gA8izJOlvCZMJiHbdZZIItE5rP1fwldV49zwXkCA9NFeunKCL3EFMNMEbPhJig4N3G0/6+NW+Ps9Mlj23JiC8eylChjViS8yAYCYnwzk5w6E6vH1CSxoBCLjYgG49Pn+QXhTSDRYMcpExrpeYTJRIZ0MeI3OnGljVqBDZsTJl8cM8BKd9vguNe6tpvc87CLZty3PQc9tdsuLCenMG3ror6/5i5tJuEDzq8B/7v2QEHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu0Wu9M9G6BGlLgS574l6skZEZfBwqyd7RN53Fdhu+s=;
 b=WvCCYvpI7V8Sw9vyi8QLQo3kirE6R9FO9sqj0LMro7L3YvVvwd0Bm6ZCvAW4b8r8Gw1Ta0Tz9LmsTFC5RkbOmbjcpPi3W6Br1Uvd164Ng0oEnO7OnjaNzDjimJ7UFBDdjFXpSfejTCsQ2eCe4njIj5xb9AMGcZztfl1BdZph70o+9i5r3wuMv+8AJsVbs7XpBEgwmZdevAWAWL9YqeSi1Mi/hr8Oxhyb4hDhPl/hoNxnR3ok2KrdgtVNqdRvRFg41Ue+zVJcg60rnxN7BvWIE25gywWxibMzUNarMe5FTXQ9gTwAzwn7GblBTRa18s1WeWPFve16fqizFDtzrjEflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu0Wu9M9G6BGlLgS574l6skZEZfBwqyd7RN53Fdhu+s=;
 b=PAF8Lr9dt0HWET7DKpSiroPSnCZXM06kVhYxeNHBuartyzymbZnLmsqqJohmwqk4gohxaoSIjAS3EOjFMhxA7KtrOwN1n5is4XCKwMIv4BUqFxkvMmGRawp7WALOb12eg9QWjG2lng5Gobi1NLNdpwOKTjJ57X2aG9NAA7DTZM8UxwROoCLr9PAeqkGNJVMytVO3aAwXTCVoTc9WFLIxOhonRaQzewJ4ZScuaPQspI2qLa/KuAq9UDdLa76ARbHEfUbENGsl3pvdOfED1ukQMltAhJ8Xce+jwPW2yi48bSDCl/M8jEADUHFZE4nSAzi5w7GEX8WKvEyzpVL2lBguEA==
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:11:03 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::9c) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 09:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:11:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:10:48 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:10:45 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 3/5] iprule: Allow specifying ports in hexadecimal notation
Date: Tue, 25 Feb 2025 11:09:15 +0200
Message-ID: <20250225090917.499376-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225090917.499376-1-idosch@nvidia.com>
References: <20250225090917.499376-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fd5be4-ef45-43f5-2f1e-08dd557c5426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lS1P4wODcuL9MdX0OLTHbey1TTMu9cRmR+KbKS80qhVpCKFprBPxquzqxyib?=
 =?us-ascii?Q?x/dkW6CmjS0arew78iYQ5jWP1ZjY3F6jR4LyDN9VStb7XzjqUpxqMdO/JXRA?=
 =?us-ascii?Q?dvoWT6Eu51+HKHB7xxcw7bjX5GpeYUFwVwvM8Zb4A1zwnM06xMRBV7/F3Uk8?=
 =?us-ascii?Q?3N1t3rQGyLPAoZ1Kl1c6tE1Dxlk9/HU/R5C9G2Q00zVZqaOxrDMbkr6mlAZL?=
 =?us-ascii?Q?BfvsWxgmESbOhY4KyhbBxMDHoPs1kA37xai284u9D2FVlzvSauBLa3CykPjM?=
 =?us-ascii?Q?4pBjlkgq80szWAKg0oVPalClnzavfWKL4/9H/lZkqx8hKrbmEpycNlaK7WG2?=
 =?us-ascii?Q?+EdzRsPNlfG/fcMCh+YUWS0UD2D2rYwaMmMYeBqVxutQI2uiiDX1MMBeV9Tc?=
 =?us-ascii?Q?2dOPmnZG7uqaHLIOMMiU5JGI8ScR+z0qolsYtG/35+NDhreqaGmHzyqTPLzB?=
 =?us-ascii?Q?uY6Bf1e+ROlPSlCSEVeygrLjCpUnlEimAFY4O69cWET5vhV4HjNHpkPm7iOE?=
 =?us-ascii?Q?P1gKEZVkAAD6njaOvDdfy3xgv5JU2KOKEPLPy3C5zAvy+aZkVnnc3frerPG7?=
 =?us-ascii?Q?+rIMqK5UArNygCw3J4ALTzWrcE5akvOt3aSEqaxpMyJj0xiKtFfv+eUZOcuh?=
 =?us-ascii?Q?E6qmpWFBA9LgJ31y/RTXd14HZFOnmiUDBcMM/paEJG47lM0vTvRSveUZ4SSN?=
 =?us-ascii?Q?H/uBL9udbByPJYI/Abzt27/SAFF4qMDxpFEg/MShTauzz7sCr79yOzvRU+r5?=
 =?us-ascii?Q?zHTI3ArJwZufe9VAoMfyRbDmY+q0qldLQ1Rd4XlsfzGIA9ZyjwKSvLk3OgiN?=
 =?us-ascii?Q?mn3hhyXHmZyru6cBYzR+Zqo8BPxLysL3HK76pFfon2PMXbsDk6gIjLCuO6q+?=
 =?us-ascii?Q?Q9Rn335V3NytaS27IPiRyBa3HHVN64FLqgSfSus/GmLirLsphOHoOMEF9AGT?=
 =?us-ascii?Q?h6vRXswfCwwwkZAH4x0qHL9ghCGKdM4YoByVbOskECrywwpgQXGefNRxDoV4?=
 =?us-ascii?Q?SHoo0i8rhfOm3T1QNt4d/91yv5AFjN1hje/K5bj/87S8XdioduxzPn58AIBX?=
 =?us-ascii?Q?b91Kz5zKx53ybgH7KEsBuMJF6k4GGsEIqLhRHZ0VSZQE+c/tWEaukk/8UA1+?=
 =?us-ascii?Q?ldjM3gAS5jBFf7jG1CknPjrW8Z3A+fNLwpQ4Qd9G/oR/PZcPe+njv+DxztfX?=
 =?us-ascii?Q?fwiDfKF1uNATU/ACySV5fFUWYaM0PrF0YY9btt5OKc6iHtocicO8wuZMC6mp?=
 =?us-ascii?Q?e3wYAAe/eKZ4AIRp5wJkXO1rd050Mb7LvlBKK7N/ypzQnvFB708wQc7qjiJg?=
 =?us-ascii?Q?BxDndbsL6iU5GTOaD7G6OfR7dsZfykTkRPgk1DnEDo5kyEBU+lLoYJiVMc2e?=
 =?us-ascii?Q?WxCbD3rsDUY9vp/W5DcO5Q4KtYVA/NszWC4agBi+SeplFT5SlRVfAREqj0Zs?=
 =?us-ascii?Q?nggC1td25UcQ2FpArTnTrXwc65DdlHj78DH0OWMHwDy6r2j2yOSolyURGJZ3?=
 =?us-ascii?Q?XCiiKF8YCcTXdU8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:11:02.9760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd5be4-ef45-43f5-2f1e-08dd557c5426
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

This will be useful when enabling port masks in the next patch.

Before:

 # ip rule add sport 0x1 table 100
 Invalid "sport"

After:

 # ip rule add sport 0x1 table 100
 $ ip rule show sport 0x1
 32765:  from all sport 1 lookup 100

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 ip/iprule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index 61e092bc5693..64d389bebb76 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -608,16 +608,16 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
 	if (sep) {
 		*sep = '\0';
 
-		if (get_u16(&r->start, arg, 10))
+		if (get_u16(&r->start, arg, 0))
 			invarg("invalid port range start", arg);
 
-		if (get_u16(&r->end, sep + 1, 10))
+		if (get_u16(&r->end, sep + 1, 0))
 			invarg("invalid port range end", sep + 1);
 
 		return;
 	}
 
-	if (get_u16(&r->start, arg, 10))
+	if (get_u16(&r->start, arg, 0))
 		invarg("invalid port", arg);
 
 	r->end = r->start;
-- 
2.48.1


