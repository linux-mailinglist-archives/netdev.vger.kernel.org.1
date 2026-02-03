Return-Path: <netdev+bounces-256329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBmELYANgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:00:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDADAF42
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2005A30517EA
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527193AE704;
	Tue,  3 Feb 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5oakCpF3"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C82F513;
	Tue,  3 Feb 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130658; cv=fail; b=ehIVQsZVWmeTFjNfRQ9wkb8WZkvfR/ycDFXgxkcDlgyPjaQ4vCi4C6pwFJiXG1pd4k+Dc0wrWXwsKdlcFgYmJy4uqCeu934iLuaJbNWTLIWbCs2c78hAsM21RCyt7E3NTFOPV+eVRB8tydhF2tBS9hn7PjKbPqHBE2h7CP28qPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130658; c=relaxed/simple;
	bh=6NrJHic2dBVi0NvnHceA0wLjNXIIuE+dsoTYtCUO6Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mmdxer8rwPlfnKOldoJi55QSerF2VKRvBbTTPIJgmcBSwL6x44It31jzuOw7sB0hFEm/jsbbITrcCT9j+pnc5lJQeNAiBTuKRMdkKd+d9iXglheqYqjtMaqjl9I/1MTAGWoZFjwUesYHvklIDIll7Q+emVjeAiZjZJ4nn9ioTy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5oakCpF3; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El/V8j76G9Yt+r90YqPhlMs13Nbgk7GHnxaKQtZWval8F7QDkSzimQy4brjTIl8iRZyMYd0M7P5/h1xfoFnTptv/Pv9khDUzpb6RqpyergdwS0CTrihji9xiAA2V9K6Mvk5NQRASg9Bgt66JMiHtuRA5g517YdNpWPac6+b348AFTOyVOYJHL1ymZ/YEXqsqX3Y3WPLO5zPuoJ21+/GqE6CTQ2D37pcPaIO6KvlAB9YTuMl0/wx7L8xBRJdj1ppTtzY9UL4RowZEmnA9qxYyzNwJr1OAbuz3l/lBbL8NjMtRvELpR7I3wZI2OpRqZdYydutDzp3tTbBwIOh6qF+DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp4HoRxHe+wc6ytdh8OMg+gHEkMO8oRrB9sxs1kGkkc=;
 b=CZnSD40S0ZoYNu/BpxOnbqWRxz4Jh7d0GvG7hAD0/de2rdww7C0Efz7SL3Cb2ZtpRon3S7TjemhKcE563VjYEms+/itDv8D2GP1j5RO3Ck4pCFFAsXEzXY0dHJAdN6GuQkT32O9UxzAuuha2fcO6/39GySn07Pbnve1zoYvCkoSozwd3q0k+iN1xQCJNT+Aizj4cmW/8p0u0wpY26ziwJOaJAuexTXXQiaGj+H/u6OU3/DmPw1vave2AaxdBwwTvCPTBeB0/GwpZGRH/efouDTjaUk+O1lpZ9LH6NWitCu5VcH46KT+seAXLgi6d7DQINEzG/qs3JIu6ae9KPbUcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp4HoRxHe+wc6ytdh8OMg+gHEkMO8oRrB9sxs1kGkkc=;
 b=5oakCpF37rqC/ZB0/K0RTsqIcB5AEeyckzpGyMS0Vi0/5TnZh5pve3DJz9UOPGS1rAgHpefbMwW0CfpKczmsYtumvc+5dWbG0TgQIr6I78UI2fgyBjFIDK5Q1Kw4vCWMD10IGn8DrTIKA23Ktyn1lz4OpcvE3FDlHGuybTa0R3I=
Received: from PH7PR17CA0033.namprd17.prod.outlook.com (2603:10b6:510:323::7)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:57:27 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::e5) by PH7PR17CA0033.outlook.office365.com
 (2603:10b6:510:323::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 14:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:57:27 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:57:22 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v2 1/4] amd-xgbe: do not select NET_SELFTESTS when INET is disabled
Date: Tue, 3 Feb 2026 20:26:55 +0530
Message-ID: <20260203145658.2936778-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
References: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 572670e3-d3d8-4bbe-1059-08de63348c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aa8+TrMpkt6oQz9Evc4NiXs1aM8IuuJVQ78Nw+W7rGLsdj5Niu+7Uo7DRUxt?=
 =?us-ascii?Q?tJapKVxomUXdasS6B1dhNMNzCZQTLkL9Cpetzg7EpywriIYv6Jf5NPBmeXuv?=
 =?us-ascii?Q?PJ5Cc29u0uoyj8Iv8+PZ9LjmKUnoJW3Rlurf5OHLv87QC2hpY3W61fZoQ7yB?=
 =?us-ascii?Q?vE/h9PujM/CGWhuTN2u1CgzL9vHvgCULft4akqZqUWb6D4xWkGOiNPcXz6SD?=
 =?us-ascii?Q?4JVJlB7/1Wgv+AWUVI/sKFvjewTcqFYBanoJrct6fksraW8d3ru9MDuddKcK?=
 =?us-ascii?Q?wjmBUH2EFjHQN3gVfQK6149c5Uff53bAGeqsrDRUhRH2EQlORExRjBAuR/BN?=
 =?us-ascii?Q?4InNovNVR3LpcQ+ENUuOex5Lg550owwNP1TUVKDlmcLbf+vn1OBzniAPNLH5?=
 =?us-ascii?Q?iOfkLTh7r1JWOfNFIsgyu1HUABly44bhEe3TVXAvLGjhuoFjvhiJyrAa1nC6?=
 =?us-ascii?Q?wfdevnV2jl7ZylTMplIAvakrWBQ+fJqQXVswWtmDYN0O/aCAzJVwNl9ONmc2?=
 =?us-ascii?Q?VVvkGEXygOEk9ATEnl2FC3fp9+4OqEEWWSeM2t69I6GillHLvuY1QJ6VXF1s?=
 =?us-ascii?Q?FK4g+go9mSKi1ec9sDl1XA0K1IzOibfAYp76k+lzPKUdKWxpT16Ga4+ukCEh?=
 =?us-ascii?Q?e0egtlmRGBYD29PFkp8juiiXW2ilPg29rx2l1F8Xr0S59GG6Fs8q/RtJLgZe?=
 =?us-ascii?Q?IodfwCpg4MBsAgp1CoExdbBd0Z4KomXDUHnY1/FZpZPHerUAL344QQYcWFd4?=
 =?us-ascii?Q?bZ0NZ9qYK1fdj2atzSLSNWooRKe1k9HcLY0z154T12JphyNJRvewMCEkmrhM?=
 =?us-ascii?Q?HYm8pmqXTYbXAWjX2x6et9U+w5eZr8tTkunqatvBXyG16tWxQHWjgY9UC86v?=
 =?us-ascii?Q?emIAhb1ab3teEadt1wziVV/mo5prccDnB0wb6xpoMoKBsCuJYE5qxUVLuK6d?=
 =?us-ascii?Q?MBrQj6w+imw+nMhMrAnHiXq8jMNpgDjh+oP5aJ4MEyCbjw2GavkPSSmOqnOk?=
 =?us-ascii?Q?BKwr3SeRF9Tm5H0UgWHDz90AKGdsX32jenaxKGEMUTS2KIHMyN9RDKD2BvoQ?=
 =?us-ascii?Q?vpgrfHFusulSfhjNj6VGRdVtYw6Aw1so7IitNBLUpqNYytcqq1TBIgkurpAt?=
 =?us-ascii?Q?ARvVh5fxWrUbpiy01qepcU6928Z4oihKfoLUwLm1RWLjszLfJSHTFTIlEZTL?=
 =?us-ascii?Q?alch4YMAP4F2PZ99kjtoUeVXCotII0l2P8/3mjxpRBMOAMXqsfVMYmJfbA6q?=
 =?us-ascii?Q?NkAQVZzC8zTCgWry+tlQG+q30O7otzN38RitgK4HCZEBTdhT0bPX0ptxFALi?=
 =?us-ascii?Q?MVohQxJHRUYM1LttQVmz6lnvuSVkVi+yyQ9QKYtq8ZPpiUtmBECp0Q0IUcNm?=
 =?us-ascii?Q?EMqoBqI+hKleAlf3eLiijmrY1atR124qOvGeEJcNVUuM86mh7jtuws4EMWHZ?=
 =?us-ascii?Q?DD3jGYbRNb1LR0gk/z7c4RVWpQbw0J3VklHArSfaKjJyuYkm+if3L8Kr+KDM?=
 =?us-ascii?Q?l/hu/RUsRjDqQe7U7ZvEMXz9B15Nz5DNCDBsiSU00FZ9NdIGsyI5iT/7lw4F?=
 =?us-ascii?Q?YCVByIkM2rqJwzSGOHq7E/uY17GFUBMN0rPqzCfkl4gQDtwSVi1sYT2Pp19G?=
 =?us-ascii?Q?4+JiNMQFrQ5mxIISvrEHlMeXaAPfkCOa36bP8lY/HKFZDGeMJanc5HNM7WVa?=
 =?us-ascii?Q?uP4bLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jO48/gyAD36+8w1fs4uHub4KPIgX+JwSQHUbMXB369vi1/0aYWMAf7SvqLioV4hj1257yF+Mfb8bFi5pktTSiVUisS3kQUnX+8Fr2rkiBNYmWtBtkSKjdys+YlMasujl2lyurc8KnMVm9sFnidTru9VplxUojsBUDLZVy1GZgsAdYRZdhF4oWpiEAGxGCleua03qAEtDYGj4QN1vH8ev9wUYQlfjIaPYgIufHHCmAKvaiunih59++r0LTwLKIZkqkTLPVp8PXWOu9iADadMxmnrRoM22aWqc+GB6pDXbdnHSUo/d7fMMu21CVwmXnSjPa4IU7zEr0xlR/cGmxHzUOFM0+dh/b6HYIOw/30tuSWqUznKxo3Ttpjtp3BTfcuLMIYukv8z1vM/aUcs+SJ0653Idh6xOMqV48emjWjcFb+D+20A6QH8Byi8lTdW7IExa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:57:27.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572670e3-d3d8-4bbe-1059-08de63348c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256329-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5FBDADAF42
X-Rspamd-Action: no action

AMD_XGBE currently selects NET_SELFTESTS unconditionally. Since select
does not honor dependencies, this can force-enable NET_SELFTESTS even
when INET is disabled (e.g. INET=n randconfig builds).

Fixes build issue when INET is disabled.

Fixes: 862a64c83faf ("amd-xgbe: introduce support ethtool selftest")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602030920.SWN7cwzT-lkp@intel.com/
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
- Added this patch to address the build failure reported by the kernel                    test robot.

 drivers/net/ethernet/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index d54dca3074eb..45e8d698781c 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -165,7 +165,7 @@ config AMD_XGBE
 	select CRC32
 	select PHYLIB
 	select AMD_XGBE_HAVE_ECC if X86
-	select NET_SELFTESTS
+	imply NET_SELFTESTS
 	help
 	  This driver supports the AMD 10GbE Ethernet device found on an
 	  AMD SoC.
-- 
2.34.1


