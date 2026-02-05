Return-Path: <netdev+bounces-256886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GpXADLig2kxvQMAu9opvQ
	(envelope-from <netdev+bounces-256886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:20:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118AED689
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7065D3004601
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150C5FDA7;
	Thu,  5 Feb 2026 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbMEPDfL"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061E8F7D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250797; cv=fail; b=GKyh/VR7q+DNF/KxooKJwqGKmv1x5Lg1zFLEd5/b6LslnMI10WuV05vL3YqPPN5188wg0cMJ9YVo16K68ANSjayaGOLhbY+NMZRwOKrpdHinBjRJ9mT/8hCB8qDkEg75eKR2YUM2Rwj0yjWe6EDUr69fKRZpSv4/X/z5WdC0PrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250797; c=relaxed/simple;
	bh=azMThw3nZqSe9ClqUMDOgUvTtIkh2Y3pVn2UnP4G1Vs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BJOthCov41Rsjv38p7snR3VHASVE76PtzrxN50XLF0zEcDy2TkdzdQ7k0xYNm1d+P0ER7u90WC0jWFR7LD9tEod8jJxi8v4c548sXtCuBtRqL8QRA1o+7zsqMLo9pFYXWfSuPk+vgF2NwUlk18HZFESeDoNs4Pnh4IKsa9G0Y00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbMEPDfL; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou2bMTjaWgReVLGLcJTMbDZToGQZhE8JkufqPHAiwoMsVk6tIakL8xv2QOHXw5Zk0E8ZhoMAckKDYpSowNNh3jEQFYUtErM7mfdw65+M77NH/Hiw/RYM1vtn1+61us65TasMLqWCuPK+KgA2aeBIQzMfxqQiLfLO7uDpkjmqLUjaxWp7x1nTtl8Vpki7nU/nJv1US95mVDBnfLD1Uuho9/H2VnBvXCQzWAfsGDKnn55mbibx82p5hm+VwHfms8bz5L0nyaHO92BpOZoc4ECBk9/Il+lGlHi9we6MYAI8vZli14mIBKGc1LWl0GSpKlFtpWf3QgXRDhuBzu2k4rHtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED2cfS9LE95MkPktPSoq3Y+7ABIFk3fdczDjGtingh8=;
 b=C1qp04YpzdVHPagsIYi9Zl0ZIahDJ3SJCe0Fizov1QVXYNTqWRIScGnoO0JkOjNrueW/SVIXSKnfe0kASxzrsFKMsSBS4ueo155u0BzAYeyvc/mVpdNuGbRCKF26uyXLZdMM27sB9Y/+rHOfaML7R8K6UIePQK6BHBLyYGNLuDvNEELJ8tQrc1qTinIANXdQmP5dNZeeCEbelHR+KUUqQjMdXu8oEMirtkPJbP++RaDaXV24uugG00QyKpdVmQVplcpvoKHLW2wv402X2gYvFPpJxrCotRv1PGh7RRuBqiG7EDZeZYr9TQiTNlyIHBUqgXzmxPRGqkeF1ZU+YR2ylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED2cfS9LE95MkPktPSoq3Y+7ABIFk3fdczDjGtingh8=;
 b=nbMEPDfLvKp0WW9Oou6KfZIyWaS6TYv7ePHLnKYoKqTdbgpcKOJ+zL0iVD0QwKW8qaiJ8cAxk0d7Hn60wbA4KWHoktPi2wCxoGuzQRy+gM+nagYkVklGXDd60URtJBaT0bBZUR4tBuysq6aF6ZBeP4HXeZa8KqYpJ8BEmICjVn8=
Received: from SN7PR04CA0075.namprd04.prod.outlook.com (2603:10b6:806:121::20)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 00:19:52 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::51) by SN7PR04CA0075.outlook.office365.com
 (2603:10b6:806:121::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 00:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 00:19:52 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 18:19:51 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
Subject: [PATCH net 0/2] xsk: Fixes for AF_XDP fragment handling
Date: Thu, 5 Feb 2026 00:18:13 +0000
Message-ID: <20260205001935.11562-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: b9493a34-a4f8-4bd9-2175-08de644c482b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?je3MxqELogd9Tg11bKl4VuDFlEaDDX168EjsvwWtkiaQ5zpno0w9Xj43ibsR?=
 =?us-ascii?Q?My1AuruZ/N2Imq8d8YMqj4HUEH7XM6B6UFA8PNF67Iif8UyIgRB5jd9/V7EG?=
 =?us-ascii?Q?iHofYLVyL4PRxMSKKgcmgXUI2RbVcI4DafRdoev3E1J0F47uRHg+X3X4d5Go?=
 =?us-ascii?Q?+ZUuhgGz8HqDfvr4jvwga1du3zUUbn0SQ1eXEprlPmtMn1YkjWrm7ZOv2N2u?=
 =?us-ascii?Q?8WXPecVhDyGpeSVER43J6t3FzSYt7n4FESxXvOIwNaOo6zmG+188GGTtj/eA?=
 =?us-ascii?Q?dI1hBHv75+jFlvmzbwEZ0lSK9dSAxbf59KJQohce8tFrozqcoVZvR0B7Gq5w?=
 =?us-ascii?Q?++SIdB7ZQYFXPnU9Zs7lNriP7t11nNi6HNGkbuLe8TpsTU8XK/maZytVroaw?=
 =?us-ascii?Q?YSj7RxggjdPdYnzQZuQeH2ARJiTNuu2fmszEvxUV6AQzCop2rBBS76FpxE43?=
 =?us-ascii?Q?FB6VibV0gK9sHd8RkFhNMciqIN8kR7V8T4yFd0tdM1cjAsFW5ydEiz3OtHeA?=
 =?us-ascii?Q?aeouuWt+E1xDE/ge2awvKJx2lcezJAH5FSRWD45K0o6rruNTgbgX49/dCm4D?=
 =?us-ascii?Q?l/bNmD4c2DNgoD88D5BSKS4i7hOvmVHIz5r988LBvA/nuihlFy74HThWIfMI?=
 =?us-ascii?Q?4i6ohygSERf/OwIW71uSR5F0GziMtJ/32fbjwVXWllY+BBFJ7B9Lf302mqWm?=
 =?us-ascii?Q?Mx+b55Q+dpqk0aMF0r9O5u9MRWgKQ9+nmscz6eFGcu9HrxA966UcmSmrImE4?=
 =?us-ascii?Q?cvvsheiCIteEBUCHwN1W+FOhmTyW/OTavVjLvC7sYm+VJ7z7jpUPaSHueNR0?=
 =?us-ascii?Q?TKXsjcMJI59IE8TGzTyOg7dCOFbzy+zDmTWaPCI+WOR8tZSerlxlUc7L3wo7?=
 =?us-ascii?Q?F2TBevOIK7BadaB3p94ENAtjNJPtqOa+HpHQPSirWUAUfOW15QVUaFYhQ2fK?=
 =?us-ascii?Q?ravE9hR/WvzVDQZv76/JgLxrO+2HsojNczq6uFiSPdMVdzLQfeniem4qjatA?=
 =?us-ascii?Q?31cgKMwIzdoC+X/he8nIzElddFumMOO6ZbUBP4L2KMjLgvJEsY0Gh9jLNnrw?=
 =?us-ascii?Q?HA8F2uppNgKbyrgTqevn0siQNxfLvtVKLrL7Q4AYJv1caiqmeFuaOjdMxGZW?=
 =?us-ascii?Q?mvRYeGagVYsEENSGmSrmpxkCPhrmZUr7z9dzfPFhxtem3S0dUMuJuTMnayXL?=
 =?us-ascii?Q?yACr2y7mjPTLOJTiDLdGGWU4AoLhuxmIzR/iYvseju74HdAJyBNCp8PqotHv?=
 =?us-ascii?Q?PV/3/v/J6X2+UI5XtVjiW0ebI0ywMobmZROuZ/LfAApXoFTvEVZxlpeCPGY1?=
 =?us-ascii?Q?4GAnzHmn+Ia7+mulHp6LjNc6e7p7YlwucOCCbHtk883aJ+LcJOpjyu1oO7w+?=
 =?us-ascii?Q?aiZw8LuZMGoGyfrBIhv9ShMcHHXQM3u8crW2ni189/ruir9Sfw4FcuokrhRW?=
 =?us-ascii?Q?jpsBcE8IdwDeMETJ7prm+Gp9JH7iaxBa/olNJFJmO5+F9nAdj97v79bjoiGQ?=
 =?us-ascii?Q?+xuAWOqemDkmJOUI6WVrPE6PD1m2XHGelqQZ9vK25VKLrvpOzCbcAiX8jmpT?=
 =?us-ascii?Q?WzSOjlr8er0vkZNKxEXt13w9QdRSqL6x+igXdvKoiJAWvCvx4fDGKRvYWr6e?=
 =?us-ascii?Q?5iOYu2j2dTdAtTON32ICja/d0xzODNG/GbQsqSJTagmlbykoNPwCyi4FQu1N?=
 =?us-ascii?Q?UCrqxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hzcAnmrHasSJYBX/dgqPRWIzfSoGZY5PydFkOsrupiXsU0o9PdQXzpFw4ygcNtSRJ3qrQbFkjVxBlpuR0Rh2njvpAY/B5zCMjY91gMm8IFbTy6r41ayL3KFO/4K+3r1w4IBAFADnDg1xISKn9CP1nTunpPNUZw+xDu10rgTDyYxCQPrvZwBwrArZ/LLBlgHSxNWTsdDYzXQ3oo8WIHUG2YCt5lJdBsjxzPeyt/Z5LaZN1t6nwePzvyNqBPv3KE/I49fUYzWh076ZrAv3wlEC9UUVMWDMLijGLtSymGQ9l8UEn7oQetucALMVgdFklhTTGAN5dS0PUb6ZAoi0NI4A2MJ8li3aY2EOOSVzQCJx5hJ1humvWsKh5fvoo8DAExbg3JvVS7VM6BxfSH+rurJpUGvbuBDHp95hTGAKqF6pGE6JtUuD0SmRMDAXQS0HI734
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 00:19:52.3650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9493a34-a4f8-4bd9-2175-08de644c482b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-256886-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3118AED689
X-Rspamd-Action: no action

This series fixes two issues in AF_XDP zero-copy fragment handling:

Patch 1 fixes a buffer leak caused by incorrect list node handling after
commit b692bf9a7543. The list_node field is now reused for both the xskb
pool list and the buffer free list. Using list_del() instead of
list_del_init() causes list_empty() checks in xp_free() to fail, preventing
buffers from being added to the free list.

Patch 2 fixes partial packet delivery to userspace. In the zero-copy path,
if the Rx queue fills up while enqueuing fragments, the remaining fragments
are dropped, causing the application to receive incomplete packets. The fix
ensures the Rx queue has sufficient space for all fragments before starting
to enqueue them.




Nikhil P. Rao (2):
  xsk: Fix fragment node deletion to prevent buffer leak
  xsk: Fix zero-copy AF_XDP fragment drop

 include/net/xdp_sock_drv.h |  6 +++---
 net/xdp/xsk.c              | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.43.0


