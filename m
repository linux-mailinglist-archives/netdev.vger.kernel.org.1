Return-Path: <netdev+bounces-249781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DCD1DBFC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38B2C30116DF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD037F8DC;
	Wed, 14 Jan 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MHIFFhVo"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37580324B3A
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384589; cv=fail; b=NPgv2067Hy/r3VxE0VAEhBXrexqextgV1C/Y0Ywqlnj1L3ceEGe0rGhcNkLhTSFXnjGQjrIzvJOD2uEHPFW3owPIjttVxXZajs64YJVUiyantneh5WXAHmJAXJOzs1wnsishSCxVtU7Hg7uigHO86XMSbIsiqKhhLdq9xSeoymw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384589; c=relaxed/simple;
	bh=JH0E5PwZGYzvO+xigZ9DqP9O3rHPDbr63HUEDkfo168=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu5XryYU4qad91Qe4Rs/aZZNeqRvyBnDAoFY4qqTLM6YrShBp2KMiPWhLKFyGK3uUD59LMLzdcgN+xNE6uF3zKorL7wuE9nIew7JzhSoZ+5g4I8oGWuGf7VkPBO/T6ReleLmW6Gd0p5WaGe3R43/Jr5yRqw+hUvWlfDYKpc2VDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MHIFFhVo; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNJ5Ede4x8nYJzujDju8mfAjXc8rdKzjMzH7YmS5B8QPSLBEgXg/WjfULnTnU8mNRLlcUD8asM2+tXijK6Gr/Dm9XDS5UL1yU9ZtKREwXRHu9goZp98XFXsInXc+CRey9AARGExpacgYhvki3FbkCFwTe0UeD/rOPn6tS+1rnQgZZKJxA8D+QTWWXbNKBL4egIMpWmeHpCoyuGq2s/nZPPujSy35N1k5VutvrAUR8Y/f4mOkDSyGMlacQiGTgzf8XfN219eqOg/y4/XdUmPORCltVcH+nKZO2NU+9n88RyNvQavO/MJ5bnCL8eJv+cB2XHNjMnd54/R5d89kswuaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+uLLePHlQNMMQVJtCBAYP2ATZHVFcW0U/uB1TjcK1Y=;
 b=DsnrgSvtPQaZAkLyxpQ9J8PNODQUAFTOxeYMXSyPotV9j8BOtcDwm++txAP5D1B5qUak4NOsUDPXIcfEyUl3/w9afozBUPN677roj7Wm++nDJckhXTDNSrSsUSkavcNN8QdKzr2RoeQ67KrjF2JKERXON4Oe1SqfnQgeyeynxTBYKXgp1wZDdaW1jM2tYsKrvicuSkl/nqwKrfXrMLuPfYQo2CpAnoxV1YcVBnw9+Dvg7OU0MPiNDNl6ygoiMqM9mAaR8siZlhcLiPqAMJpk4A3EH4fTnhVVxFR/5Hp7+bK/gCRq2cR9j/UZksWngAmNNRkc0jlk4baS3E9ABxf03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+uLLePHlQNMMQVJtCBAYP2ATZHVFcW0U/uB1TjcK1Y=;
 b=MHIFFhVo9brLtO6BxZQDcy/J0uZ/jw9dtuzYjm/bHwbe3MaafnxDV0hEDWbPvZQ/p0GSHQbvfPjVocwqd803um8ex+5kdTHJOymLuz9yUEA5SYHuWsuyc3AW5n8xxVUxf8iQXNjIbTDkW6l6SOMvn3iQgldoEUGWvxBqs1oGC2WyFUKJvV4/fUhdrAebMfNTgG0BuCriBcK6aneqczWImeUDnNDEo0xUsPyDmgOTW0B8PY+9j1SRlTRDbpcaiF5ZxBx/f3fLV9DOYRMaPWYSS3pKvt3UiMJerCc0vkjM10YUGXjm0O4Brefuwr1/emMZgCGkrDegMtpVhxzgI3bQxA==
Received: from SN7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::9)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:56:24 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::83) by SN7P222CA0028.outlook.office365.com
 (2603:10b6:806:124::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:56:10 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:56:04 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 6/8] net: core: neighbour: Reorder netlink & internal notification
Date: Wed, 14 Jan 2026 10:54:49 +0100
Message-ID: <ed8cd1d500745e9707128d168d670e07586bb23a.1768225160.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768225160.git.petrm@nvidia.com>
References: <cover.1768225160.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7ae1ad-63b2-4846-a338-08de53532ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8B0cTTMlwF+uqaAKCgZh/5hHQCtkFZhfsTspFlY9nyiJE9+2AbFnh6ipzW9x?=
 =?us-ascii?Q?KDKh5ZCNrxB26gl33WBHJS24sBhGKApzDBLxlcPDOS7lMQTFzSjhh95GFwt9?=
 =?us-ascii?Q?/68IwTXx9jdv0bpORqf1VWrmlcfJFHgjjUHyphUSms1Fk608jclMw2hZQLb7?=
 =?us-ascii?Q?zx9MkyRHYBc6wZ5WVOuhovr5O5wu/f4HGTmIj/ylUjLSm04017n6CKPeDyp7?=
 =?us-ascii?Q?oviqQ4KARxfbFBU890F1CJu8uJ37TgbS/rbgUjl+4iRL7/CGnJ5GWl56dyNB?=
 =?us-ascii?Q?NPPMdF+oln7fW4ZyK5OuEpcnghoXaQfphSiOCtnjGjUsjcrILF7w3nyeugpm?=
 =?us-ascii?Q?5X43rhpHXiQRDOwDs1ZJ9faMVrPDXUs212KbN4z1FzEW2aWavXOLVTiocmpH?=
 =?us-ascii?Q?1mpckd7nwWoAEsAlwIix2arR6xJ8Y6gBTnWsYP95vys81lr4JCVtbrPmvNWG?=
 =?us-ascii?Q?3reeo2OdEVS8/Cnw+8Ss58qLXxrvGMKF0A9GpSYJnUy6qg0/5RdAP9KtY0Gz?=
 =?us-ascii?Q?dwz2VaHnPgwIrFlZYPbZBuv3vy4HH7CY8TiyPN7uNUDk1bOi7T/KKRtjysO0?=
 =?us-ascii?Q?1ndrvQfenjsIjaeqmsQVvxyxeIFuN+4gGehR0Dc6LUtIVFuaJvz26QkoHk9y?=
 =?us-ascii?Q?KEmr0G8siZ6WD7SnABptQpWmJuIN3kOC+LzYq1T9+T397dWxD7sEGL0TD217?=
 =?us-ascii?Q?9uGNM+i85CV8icihKDYCwrBD7CYTITkv4lZGIrdpWWJVueluHd27PbSFTIr7?=
 =?us-ascii?Q?RGyIzEmWCyMZ+exJQZEa7J0jI87GcKHCyPYKt19ATB1/d/aZEbxE2IFXfz5i?=
 =?us-ascii?Q?T983JPLiOZ/RpCxdMKcS94dSuJ2jkKqXKimsUHvnNpvMxy14vMKbFGRQbOS4?=
 =?us-ascii?Q?IJr/7Uce6ShKsOTMe/zjz+W7IuBW9DiaRlWgGGDamWJOa4xFeIcCaVe/OyH9?=
 =?us-ascii?Q?vIpDfljTYi0Mt9Zbak6Pa0040pbqB7Yfw7jcnhRO4G01uPEBjBOVNPellOtE?=
 =?us-ascii?Q?HSjXOPdpi2ko7EZmmomVZCMZ4ETp1V3a7tG6kXYBbptFEl1IFtRMDoODLJzJ?=
 =?us-ascii?Q?C6nDqAAfdqOzytKsgGDE1byqUH3/8H98csfIE5EdAyVbFgDg/dDjm05XZ9Yx?=
 =?us-ascii?Q?qWgKwNnHVMUr79Huce6bVWRsLibA5ZhzJSW/zzKRCSD0XA+UXL24/Qu3Wg4Q?=
 =?us-ascii?Q?lgHTfEE7IWhLUy5OlUkNl7oQBl/iPNJQJbkWaMi0xO3n/OjTeHE9z40Y7CSY?=
 =?us-ascii?Q?LFTGpgHrz6YYuZQ9KrdCEDv0CSeGRxqLXV3CFfWTZgyd48xLN4qqcwHRsAgy?=
 =?us-ascii?Q?ltH2SAYtGza3mOGHnFLysLXuazZMfepeZS86BSajuODEs7pvwgqxV+3T4afr?=
 =?us-ascii?Q?gdKBCaMmjOyX+6sw4b6Nt24GCoF0A3qnmiv5x/T+CYyKdIscalemb1Lefmig?=
 =?us-ascii?Q?vV6kiINF6WxX75emldwsR77bUu66FmcwsJwxm3P7V2i6GhKcX5fTAIuCN5w4?=
 =?us-ascii?Q?1vd9sXzTIC211/UmbHuo4bsNJvnwIEFem2Vwb9hJA/S+gZzVUMRonk5DG/5S?=
 =?us-ascii?Q?o4nArelNP7bFzwWFSWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:23.2537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7ae1ad-63b2-4846-a338-08de53532ce8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249

The netlink message needs to be send inside the critical section where the
neighbor is changed, so that it reflects the notified-upon neighbor state.
On the other hand, there is no such need in case of notifier chain: the
listeners do not assume lock, and often in fact just schedule a delayed
work to act on the neighbor later. At least one in fact also takes the
neighbor lock.

This requires that the netlink notification be done before the internal
notifier chain message is sent. That is safe to do, because the current
listeners, as well as __neigh_notify(), only read the updated neighbor
fields, and never modify them. (Apart from locking.)

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e37db91c5339..ada691690948 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1187,8 +1187,8 @@ static void neigh_timer_handler(struct timer_list *t)
 	}
 
 	if (notify) {
-		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 	}
 
 	trace_neigh_timer_handler(neigh, 0);
@@ -1523,8 +1523,8 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_update_managed_list(neigh);
 
 	if (notify) {
-		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 	}
 
 	trace_neigh_update_done(neigh, err);
-- 
2.51.1


