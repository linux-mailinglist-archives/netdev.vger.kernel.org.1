Return-Path: <netdev+bounces-243840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD0CA86D3
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A8C43009F58
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341134027E;
	Fri,  5 Dec 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVqzuX2I"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3A341AC5
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953210; cv=fail; b=VKQiLqayMoYBCtIH9IhcSpu7tVbTmR3vOaCKFXpWvyHKC3engsOjQlo3l2gXGBrYu13h9a+qR/rcj3ZVX5w8OrMCuxLu1s0Fp6KOmTiFbATOxE7TmE0ux0Cadw0aAkOTggNCQO5u2KCQ3sbmaKHdH+zHW29eVnIMXHdDyJ0hrSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953210; c=relaxed/simple;
	bh=9muxJOC0ISis8B0fLcOKR+3zi4oy1zHacDvqq3ZEUX0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f+4+h+xOWooBOMUAJ7zlQ4Jwn0JfLUKiccnWKJTH5LKPAC5aye1J2ccK7IhP4cIHdEUHmp/c4JBmWViPqv7XiwKLRDLFVfXV/fjCoHW99P5zO3IOh8MoePZ1xG/iqeDinB5yI/W1JPYZM1nTDVi28DUlIMkgM/nvX8JAZ09qOUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVqzuX2I; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO3zhRtFRo+HZeNY9r/nFgjI13w76StW4cj0969HYeNne+ZhlO7BbsfKewWjaotvhBtV5b1RHBcD+5ru3vQxYNWl6/TSjiN8oTjmlchw0SNjyMyitb6w0yk1RU68TIb98DsB5aSDTMgGmS/8gOrkZ3MxTZU1BpR/yX2gkwbgjVwBlwmYr/GsRz0ziaiZnHNmLHbpDeDee5q3pDkyXl0TYVXauMyeISqipih2MC3r7uMv0uG1JqLyUwVoyNUXcKtjb0vFcwOQI/yZyOosRwp46RQa+nvxJW/LoeFR3UxDZ88IbScbFA/+mueeVOQiCbtuATJt5Mr/Op5l2n/MkAge8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS8g8jtCdc2rwx+OtA5wQPe3Ybgr8ZyTOhJy+JKSciI=;
 b=aaJkMdP5L8Yd2l+wNUHHsYnmyrtjCRjZAn7b2HuGzLiyBU/o2s+74LM4C+UYHaqBmGpm2W+8j062rOpAtYB2HbKwtVv4PfzVnYBTAWw48kmoFas54FOD1m2GxrEJuPpAe76WqbMpne15noJ4GPIhClqjSorQ00LbDm4eTPF/orOXBjucK1uIipOHCCGSCCmbByo5ae691IOI6dW2s/U2VsyqVVTBzSXQMQQ3RNXJK9TTNbdICrTprlI/WgQ/5b+YF65KFstbHRFcoANugoI007Q5MHHPyHMFJ25ZaLG63l5BNm27+pLXHKgP4PEXqV0C573BXmMWPoePs7AO0cyKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS8g8jtCdc2rwx+OtA5wQPe3Ybgr8ZyTOhJy+JKSciI=;
 b=CVqzuX2IvQVcuaoRKzXUcU44EFtzB/OuAdo0W9WNGPZf46vnl8d8WZNZHMt8db0OwUEviJV3OAsjKzEo+gkUSN/M7LWNNANnBN2ordBli89gu1W5fL6GlU8TzygcbUGCRacoq00xOedJ3KTQEcPpTmtpt1cg2cHPsD6iDu7p85AtliDfqSGLGYzlbK+OLcUWawg/qdlR3aQtImb9kwF1Fsi1W4GuEFQ+0/3haEZdc+mtnUL2iSHLNA99RS6qnisX+1N67K4m1YeKGAgyOwywISBckP0OhUYn34OeHvnGFoIeb8YR+JNY0111m/YMVnNTqxt4R0A3MOQ/Rfy+vmn5lA==
Received: from BY5PR16CA0009.namprd16.prod.outlook.com (2603:10b6:a03:1a0::22)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 16:46:31 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b7) by BY5PR16CA0009.outlook.office365.com
 (2603:10b6:a03:1a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 16:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 16:46:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 08:46:15 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 08:46:12 -0800
References: <20251203095055.3718f079@kernel.org> <87bjkexhhr.fsf@nvidia.com>
 <20251204104337.7edf0a31@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [TEST] vxlan brige test flakiness
Date: Fri, 5 Dec 2025 17:16:56 +0100
In-Reply-To: <20251204104337.7edf0a31@kernel.org>
Message-ID: <87345oyizz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5321929a-b212-4409-9aa0-08de341dd7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDz/YP/IuqflSQ1zPpzgsg20oJ8DOS8t9yjVRKItmA4TzpCWAe3I12LcuBcF?=
 =?us-ascii?Q?4lAKn8VMcQWUMYPrlIhvtlbSn5IVOMVb+dZvOFZNhr/F1tZ55lVACmyo4SWh?=
 =?us-ascii?Q?oR/JV00xCnfrdILPRkqJ3RkXqFS+Jyy/ib5WNkr734/oER7TTc3Vo1cuUbcR?=
 =?us-ascii?Q?FRELdVP2JtWNc2md/onB41d5P2wNMQlQX+Gvt4qPozzeCBlDts4eVdQtmkoJ?=
 =?us-ascii?Q?SPyxIL0eBJAcvGTo8N/hdIxSncikb9dtV7/rsZoQUQ/QXWfDhCw+td1ons+b?=
 =?us-ascii?Q?fKy5ikq5xy1+2VPRpFy2W7uz/nHULUnq4FUrcB8LPf8kelYKQC7MuB67CQD8?=
 =?us-ascii?Q?kYn6Z7kxs3sLoU5LYpZqXuABGW0/Ac5YAb8fmHY07VAf0y7gc51K/SEF4qz3?=
 =?us-ascii?Q?YWIBUZEVG9lFtX42w7tnVzZR/U0piWhK+FLxXJtuCitGNpmGmIyKkdyUcWi6?=
 =?us-ascii?Q?oTCXmSI09Mbr9uku8LLC052/HkaNRMpNIrCq5xO3f2/GVIAxrvemMrMHWsqe?=
 =?us-ascii?Q?XRnTJftay368H/VNoz9e6RNfSjkzp0+7iCS4cYrI6m235+pZFSB2U4x2V7xj?=
 =?us-ascii?Q?GEBtkrQLi3mojl1zaxtWSkRLMrGyQAdOSZ/zZfvcU5kZ3qaSqSpP+fkdZiQC?=
 =?us-ascii?Q?xrBvb0pN/vo/VhjiPQL3yupVmKOLYTeVVgaai98guxwGno7piau1E04A+r7y?=
 =?us-ascii?Q?tuwhptkMHcxxfJ623qalnszXYF9lx9JJ9bjDiTFvXfIZ9M89CpJ33UHRxuic?=
 =?us-ascii?Q?eUansVnpgA1ZeS/BQTEGAsFyY4QwOqi7lPwQtRK7F3swVTqmM14InXMdeCVW?=
 =?us-ascii?Q?cV5TXOb+1DGY3Xm6Z+Nadb7JX2MWpNjnYoW6fwAl+zstIsf2OIUjFE3uGsu3?=
 =?us-ascii?Q?X4A++UTPLT+RuLd5Le33lAy4oqMnjVVvnKZa7aQCirAEc5K0uT8D1Sd0V2j6?=
 =?us-ascii?Q?E7lAB0MkfYSSs6J3k07L1G9/FM2NMMLrbRNTlPkCDRt+yTJGePSfp0SY7AAH?=
 =?us-ascii?Q?jSyM8LwRAqYuW3cgvCNq2uVkQ3GHKVXSBJ0UZzcEoWSs1SZ2Qul04EyKXq4M?=
 =?us-ascii?Q?lW6A0Phet/w6ntMjP2t7dguHtczU5OfP0kF64Au+27VozsN1uMbGrh85UPNh?=
 =?us-ascii?Q?IMaOxxxZKM2h0xf6prsMrcIB8Ok74sldtB6COZ6ElzOvX8/qlyW6+DTgsRz1?=
 =?us-ascii?Q?dB1mWK/Y/ZS4Nw3fBj0G4MVmmZ1PqmFcpTRo09L87V+UNq3rb/HZ6PULqyvi?=
 =?us-ascii?Q?AMPbgJyzxoWGCMoDt1HgAmrlZ3lx8JM9nJ0USe9ewWYvJcspXsDHPq4UfJa2?=
 =?us-ascii?Q?oGK+w6wx+Hlb8+I2CKcGHuYfkmonjM0e7bX7VB+M2b9FV/GZhrL+BEyVJ/7K?=
 =?us-ascii?Q?3F3pfJZ2wdCrJfNahA6Fe5FdifccPicAxKo6DqApDU6vQ4dkns4+3F/MSLBx?=
 =?us-ascii?Q?URxh///Cr5ajPy4zmNsPWIF33son/lE5D972hg3x2A3lrMMau9/4ZOtYxWMl?=
 =?us-ascii?Q?ITTfA3jGDf63oPVX1oS2t9BRv+5ZAWubk39fOkpAb3+4I0xDu5FF6kyGJ6Fm?=
 =?us-ascii?Q?FfTPWKQPGB+aEy8wnII=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:46:31.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5321929a-b212-4409-9aa0-08de341dd7f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 4 Dec 2025 18:46:30 +0100 Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > We're seeing a few more flakes on vxlan-bridge-1q-mc-ul-sh and
>> > vxlan-bridge-1q-mc-ul-sh in the new setup than we used to (tho
>> > the former was always relatively flaky).  
>> 
>> You listed the same test twice, so that's the one that I'm looking into now.
>
> Ah, I thought one of them was 1d but indeed the CI was just reporting
> it twice because of different machine running the test. It's just one
> test case that's flaking on two setups.

OK, cool.

I think the following patch would fix the issue. But I think it should
be thematically split into two parts, the lib.sh fix needs its own
explanation. Then there is a third patch to get rid of the
now-unnecessary vx_wait() helper.

I think it makes sense to send it all as next material after you open it
in January. But if the issue is super annoying, I can send the two-part
fix now for net, and the cleanup in January for next.

Let me know what you prefer.

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index ce64518aaa11..93a61c217cc3 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -28,6 +28,7 @@ CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_VLAN=m
 CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_U32=m
 CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_EMATCH=y
 CONFIG_NET_EMATCH_META=m
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 6a570d256e07..5ce19ca08846 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -138,13 +138,18 @@ install_capture()
 	defer tc qdisc del dev "$dev" clsact
 
 	tc filter add dev "$dev" ingress proto ip pref 104 \
-	   flower skip_hw ip_proto udp dst_port "$VXPORT" \
-	   action pass
+	   u32 match ip protocol 0x11 0xff \
+	       match u16 "$VXPORT" 0xffff at 0x16 \
+	       match u16 0x0800 0xffff at 0x30 \
+	       action pass
 	defer tc filter del dev "$dev" ingress proto ip pref 104
 
 	tc filter add dev "$dev" ingress proto ipv6 pref 106 \
-	   flower skip_hw ip_proto udp dst_port "$VXPORT" \
-	   action pass
+	   u32 match ip6 protocol 0x11 0xff \
+	       match u16 "$VXPORT" 0xffff at 0x2a \
+	       match u16 0x86dd 0xffff at 0x44 \
+	       match u8 0x11 0xff at 0x4c \
+	       action pass
 	defer tc filter del dev "$dev" ingress proto ipv6 pref 106
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index a48f29b5f3b2..b7179b01b546 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -280,7 +280,8 @@ tc_rule_stats_get()
 	local selector=${1:-.packets}; shift
 
 	tc -j -s filter show dev $dev $dir pref $pref \
-	    | jq ".[1].options.actions[].stats$selector"
+	    | jq ".[] | select(.options.actions) |
+		  .options.actions[].stats$selector"
 }
 
 tc_rule_handle_stats_get()

