Return-Path: <netdev+bounces-260682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIZaOfo8nmkrUQQAu9opvQ
	(envelope-from <netdev+bounces-260682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9B18E48A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 372BD3015443
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D49443;
	Wed, 25 Feb 2026 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbWzenpY"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AAE571
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977950; cv=fail; b=CtFESF1+jN4ca/L84ID6O9us3r+s1RQhp07xMtcY4zMV3HLqu1DqlGD7wc/dLArYEHIAQ4A+BxofwVCH+wyQZYFaQ2dXwijieYsUZNLU+jb06bOZP/8pJcq94JsbX1iUHMdydganceu3Gz944fGWnYNzArKan4F9GrHL5iNK4vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977950; c=relaxed/simple;
	bh=Irw92gNx3w2lTAuZ2H1LAs1omTKuJaHlJ6aFoM1YtDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DzVgg2ipMiTpGBvo1OlCgDgFONB626PCgHgMz6VppdGBRJrju694we4KQM478rQsmIzpw1lECtiQ8txvrKgC4y32RRRIvEvbATNDkXKwp3mJmXcP0Ii46nNBf8CHD9p0ysh8kT0z/1RcxjAs3xLIOGFSPx20bakasUG8IeiCiF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbWzenpY; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5y+j9ghbeWxgrvWLOA0kWUY59m6EOhUOQUSdKY1tOvWHi29hNbfRWxKqKpc2vEL3xy54h1JXIVEIt4IJJfafXcQ0xCPpByyQn5Si2dQo41z9zqcMiPZisH7rqTV9VzvhbOlqwU0XiDrxXXPD303SybD0jOBKsD3L+58s7CPVPBYcDadNEw/BLwCB/miBfYSKn2CP4Gi/hPQXF3ImHQOdrmtuO+/iynND8hxIuti1G8rHh2ErB6EZuFoaIaDuXTey0ErxnrOcVmxqcXxURi9M3KctJIPLoGMjrPJ/w5wBdJPwvtsR6GM1OfvzOH6rFcbdqYSqXjrGVsXVGtUSiymIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1fyp8WRZVHsNQi41MuMTId8YGuL9XA5vTVt+ok1TH4=;
 b=dLDj2FR0j4HiWUlbDpbPG8IqVZV2xel1WKEsImyDE8ox7gpRqY/I9q72HvyAyecUnnpMjqFHUyARAkbFH9xNqiR/YSrekvjsd42imVGMTGzKmqYUBqRdHLHBoMTUmhKVytPsaddAXStJEYexWRLKnXvt36NhPjncG0eAlDTD45SUg9JJiqS6oSIbkH9BLzGuJI9Hmt3rFP0Tjf/3lXbf2uGSm86dkTgTC0+Ei523NI0+q2Rl+T5nOuN5q8fkedUMg59RApTsWCHLgkD4YYxD5RcudrHVsEXDEZiUOz4auh8T3xIFgi8FPM5L/09XwQ30QscEmeGPf+/eZO/Mjq4tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1fyp8WRZVHsNQi41MuMTId8YGuL9XA5vTVt+ok1TH4=;
 b=gbWzenpYMx/Wrp46MufUQwt11f8z3Hm6Xq/1iDiFMLeD/W/LPvas+oN9l/4GEHl1qbZAxTu4mJm4GA2Eb0if5ysAAzSpNO5Pfk7/jGYAEOM9/CYwWZBeEPnLma+Ze+COzfNNQeHhrfQ/49kzRXINWMTads67ep5zLUQIayjJ73g=
Received: from SA1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:2d3::7)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 25 Feb
 2026 00:05:45 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::60) by SA1PR03CA0008.outlook.office365.com
 (2603:10b6:806:2d3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 00:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 00:05:45 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 18:05:41 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v5 0/2] xsk: Fixes for AF_XDP fragment handling
Date: Wed, 25 Feb 2026 00:00:25 +0000
Message-ID: <20260225000456.107806-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c7f714-7923-447d-c8ea-08de74019f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyEsY2DjvVxBbq1KBk8jwfEBQraxnrjTHO0ijYgqFGVRcYkKyys4G8zbRvZ9?=
 =?us-ascii?Q?Yqpv5sTKl1RywrSWJEjDmRLTeuTLL9Pgu3DOZApqqVz4C/vplwLRezJIcgqr?=
 =?us-ascii?Q?HHAufxdOKiUD/m9E65DgR2mLRHE0zLOaDrsxaXzbHrJKPW4xGiIINYE9SIiD?=
 =?us-ascii?Q?ShNCSoz6+Tmjt2psn/sdvN7i2rDLaLfofmMveA1apNdS3QQgm2eFjf5gmDCr?=
 =?us-ascii?Q?POl3C6hCaxuP0rRjN9HYP2S/+2d3YLCAHsu7t4SWWv4aTUY78jqtXRknDDVt?=
 =?us-ascii?Q?YSH924A/Byd2qMUUsbwpO9PJP90TGc39YQi3CDl2VdPjQTb0q9e8s9U6sw3M?=
 =?us-ascii?Q?37kzm8prwHYhQfefyGwAqjiXCzVTCkT8xs1XJCqvywSgJANYvDPqVu73nuZN?=
 =?us-ascii?Q?LHSmlAeyYnctDQs7X9JI1DPdQmEUfoCxUsJzcUklBVWjW0/5xbyYYhdDk68Y?=
 =?us-ascii?Q?po/XLK5Ry7sRAQJf/dAz8A/smm7hvnGbcl1BvdrtUVaOmHB1LsDhENnDgsoT?=
 =?us-ascii?Q?TDa4/89mUcb5szM8/Zkmdmc6JEKeqocFqPdxpDOec4Nwzilywvc7F36nybMI?=
 =?us-ascii?Q?4eDKlcVOEv2KYIRqVGcso7uDEBvpY3dWKKiKV7xPxS0ZFMT8c5Y8iRy9Ew07?=
 =?us-ascii?Q?bAu7p955n2tf74k+qvW66uFgybe/D76zbKd1YnNbS68LsjU15FFLtvomE1AX?=
 =?us-ascii?Q?J8szbTks5JdRj02/1NpdG/vmDJxqewLYzEwL/V5gYwZaSPoLzbaeTkiTGnLP?=
 =?us-ascii?Q?K6M3u4WyVGCTAy1VzuvuFClE633DctzEBJnty3d9BNtKmVYgnPokRbV6n7lm?=
 =?us-ascii?Q?FuZox7hPsr+kIFXg2tjdI7Mh0aINPlbJoJgsDRGGy6HGkL8rPLlURfme+F28?=
 =?us-ascii?Q?mjNLdldjZfywU02eG2Stjpl1+FXvmiTowygm0vzsmr8FmffB1TNLrrwnGK8Q?=
 =?us-ascii?Q?EsHEgIjd/tJ+6Cr1jhU5YNdT/pEXX4lrEO1JjwrqSsGHbo/6FVRjLhXRs+z0?=
 =?us-ascii?Q?R9duIq00RXlHEj1OIpgAahH1THM2DoTCizTiegx7yg1cc+nsNYLxn8ZxFzR0?=
 =?us-ascii?Q?h+J3TvVrRbf8oi+bcpfTpgZEBwqYrw4EwoRLWQhcksOuadzjoFRnCyuyQtNx?=
 =?us-ascii?Q?H88zq7JCplTTNJzXwCSDsTVj38huScvdBKysI4KWS0dav3XoPTACA6Q25Lm+?=
 =?us-ascii?Q?PVAO1gFBSwN029MQJmvkTX+lCAS1Y98uCI8pIyoeVg6skMzRdRWCseRrRYP+?=
 =?us-ascii?Q?Q1af1r+RucFWERSmExWgDbwAhb8hdqF1Low5+1UOT+kvcIU0mK7ej3ypXLgs?=
 =?us-ascii?Q?z6EE7843F+2pJbDBTa7s+UoJMeq0A4VJ1W3mhfA8n8Ao5uJxsNzvTw+LIjgX?=
 =?us-ascii?Q?SCNSHleg5P90gJkqT7sBXqIqDX5XWViopvpZaBpj6eCxJRnNoHhsOnqRh5Y7?=
 =?us-ascii?Q?QumQrISjSGrKc3T9DD8vrtFPhsTDoMKqL7EqoCV09dJKswltttb6VVkJhTEa?=
 =?us-ascii?Q?+eYq5AELEc6qHCbjdbxzPgxjhSdXxuvQiCGVQMFT1zyWSxNMR66xkj/qevwM?=
 =?us-ascii?Q?VaNWudps56TkeW599HXgtvwJOqreA7lSw1WARUO9l7xvf1k1CObDSE+MzRFC?=
 =?us-ascii?Q?Ezv/s5u1aiOpSa+m50sDmJxYT8rJs1xXzZe6OtHyLiSUBTQOa6BLoEMlbEWX?=
 =?us-ascii?Q?lBScMp5dyF6TyP59xD9BTPryv9U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GPigSLudgFgvWRVasoX2siaU8JgzMIPaY01JjlIVmuLF38QP3kOKy13SgJTxCXy5FB+doeuzGTPdS5Cas5YePX8C+jcXuDYkGO8/ukiD1WqESSdltBFEVoTuQwb6ZPAQ9dxFSdTmOJs+vC14KOPupG/Z4LaaCHo5jqFzD5Iu+1rq3DJSmU/1Dx1/3KOjFgjFdNszUrb63SIXMj/EUAeZISt2Ek4Nc5n/pT96oTPn3hQLDzZpVLBF7reLmjWmUeGFXnCtpoM8yuo1zvPEEOfQuNkRYK3/1t2CYhReIFQPKsO6Z3N/jnXWjpy8Os9yIoqe0VBQTRDXiKUpKwHdmpjaY09WrPfFG03pypir05dia5JF+WgMFhtjymiznmuuIESBPGlk9XXixV4FIWj4hoKwa5+MBQHRrEnqVafUmISOuVX5PKtwB54g2pXlRbbDJrko
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:05:45.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c7f714-7923-447d-c8ea-08de74019f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CF9B18E48A
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

v5 changes:
 - Patch 2:
   * Use early return for non-fragment case for better readability (Jakub)

v4 changes:
 - Patch 2:
   * Fix uninitialized err when sufficient space for all
     fragments is not available [2]

v3 changes:
 - Patch 1: Carried Acked-by tags from v2 on patch 1
 - Patch 2:
   * Check for free space only for the multi-buffer case, this preserves
     single buffer performance (Maciej)
   * Fix return without freeing buffer when sufficient space for all
     fragments is not available

v2 changes:
 - Fix indentation issue reported by kernel test robot [1]

[1] https://lore.kernel.org/oe-kbuild-all/202602051720.YfZO23pZ-lkp@intel.com/
[2] https://lore.kernel.org/oe-kbuild-all/202602172046.vf9DtpdF-lkp@intel.com/





Nikhil P. Rao (2):
  xsk: Fix fragment node deletion to prevent buffer leak
  xsk: Fix zero-copy AF_XDP fragment drop

 include/net/xdp_sock_drv.h |  6 +++---
 net/xdp/xsk.c              | 26 ++++++++++++++++----------
 2 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.43.0


