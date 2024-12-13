Return-Path: <netdev+bounces-151611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F689F0321
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618DC2847FE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468DE149C53;
	Fri, 13 Dec 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhP8cu4S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836CA1547CC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060958; cv=fail; b=InvlMok50BPvWaUNx8KkoRQZwkXgezJ210LBfb8cDVY0CZEm1py9YjTaV6PqJzfYXtlCRdC8DA3/mSWbiOKBCSXPr+6SZf1OYyjcoWDFYua1vmeUizhj/+B8LxbePmDENs9b7+hlrjdzwKgOvpBYw0xC6FJVZgBcw41/wRAVBPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060958; c=relaxed/simple;
	bh=ulTTErDE/cu9W6M/f92qbr3YVFYWIU9keEukYfyIImA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uzd5iN3NkuHBceT0U7iXnro1w6ea967PkrI37GxPDykQgFHMsaeFkizSQUh80glUMvvdUt4b4+qqE2K5T5MOuRDRXH6QqOeNjZghDT2WanAlUgJKYldIqgoI/+Lv86peQMD6rl8XlMP7crEi+PgzHT75RtbJfzI7o1U9kj2aweU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AhP8cu4S; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9DEs9IIOFn4OjIQLwgzBrZDch06+ADyoNgzyC4Fi/NuK94CoJ0l7XENuh2KX8ZHRx/N4uJAbE02y0zWPmtnDEoegN1+eYcAYB9CD21kPAU1W4sxODN/4f3Szr1h7m1BT8GApymqfD9S9frqLzQmoqnQnfaNM9u00y4ssQY21LaF7jr9MJUJp5b1SNhQtlINxeT0bMp4AYku3QHFLxO8ge0OJMjdV5NrNa2Sbfur+xD3LN/TzIdRC6JLi6eFCd+RNG64n7JCPrO+l+X9irW9D/hWptS3mfNe9GZdpfkIqMd4yeAva/FmFv3RS0ZaHZpkjK4kraCRZh/Tqi3xs1NGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBWD+ElbdAS0JCzhWE2UTGoUZ3ulh4K0Q1XwJQMeae4=;
 b=F8al1dlIx8kufh925MC0T6HTnCm9nI5xxnZEHz4RK/zi5O0t85TKyEyOLtWXRUEFqJeHfTszo2wgRnXlmLbp6MoteVFTABdLMHhm66t9HnakEu9ugI83Bq6OVIoownfzxJmzyAJpnD15k+KxxowfrkgMFsuPvW2AaZ7j9BGV8XpRMb39jKAIwWfxXTG8mrAcyUHvPaCCeuMrykqfKIjtZpvQJ3i5h92V1tSz9vYqd2EhDx4OKSi7pXIdiiLLUCKY09Osvtka4hu9AcfGdttWbb5Vn3LsEBYJKsb7ehe9PaF+wPhfwh3Dyc4QLqGq7SawVh+1/s3WPr/0hzD6ZbazBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBWD+ElbdAS0JCzhWE2UTGoUZ3ulh4K0Q1XwJQMeae4=;
 b=AhP8cu4SAZuQhhymHlWNiCHRCt1flUXHo7cffK4p+qwaCRWOLJ8DVFGZEnZIbQTQZgi9V/v+iQOgLwDeO207A6AtJiLdSdDeP8wMchHfRhrx+a7161nA/lADtct0MtoMPovsT7JfOW1BB6nOwFOUsdvriO3rV5sY96jv5K+akwXoA8vNFlhYQOIVuzj9DadQocgH4XZia3hIJMuXogCBiRNuLD6/5Mo4O8/ahKf49k5EI2yfa9JE6MkVnAd6HZ6pZhhYAUs7RvbaiN8bCCmuZnfIQP//pCyDIDczLtOhCPvvkDvp986GCR8aMozdEPCgIYdCVC9T5rDNMEuTLrWSMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 03:35:53 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:35:53 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: [RFC v2 net-next 0/2] bridge: multicast: per vlan query improvement when port or vlan state changes 
Date: Thu, 12 Dec 2024 19:35:49 -0800
Message-Id: <20241213033551.3706095-1-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 507c77a8-f541-4f4f-2102-08dd1b273ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJyRubNEVe13dinBuF09+7gxxWBFEs8TzNV27OwHRHfjC5iE7mJjzhqSw5kw?=
 =?us-ascii?Q?LjMzvHGcHcVnpecZWtqYASg66iEBhC+hwbJFJhnFcCPxKv4qReEoJKnD6Y8i?=
 =?us-ascii?Q?Ru2xAKBLiEy0KegD0OLALByeDSItMIXLawlOHwuHc7z7QAvIL4Blg4v3Uncg?=
 =?us-ascii?Q?yRn56TJ+Xg8HVe8zLyjC10Ukd1LOUS4lcQS5CU/v3H12A4PC0zalhUoHRb8l?=
 =?us-ascii?Q?xkjr9kIQj8uGvgjHrhReXpQxvtxomMmCMD04t6qKBfuJ2EKaDPT32xGdGmYD?=
 =?us-ascii?Q?nwoLLip+k8d9tjafCXUszGmDu0nmnvnHbB725zkp6aWuuJXuUaDxi77qQCay?=
 =?us-ascii?Q?hv/YPkxoEjYb/FlY5cHdFLrjgvPT1mORNAFQh4FCQ2LYSgywppQaZEz7LvMg?=
 =?us-ascii?Q?+DCXqxi9/D3F8wOwMXaGOzKzxwuqnL6OYA+K+CltJiopoaRxv6rrQIcu99Pv?=
 =?us-ascii?Q?AdcPJy7T797N3dvLFeB6jLGlfoK9S1FejAwc5KKC46Wshr+lRqH05o4nSAww?=
 =?us-ascii?Q?EUePScXKgg8VHtjhCY0Jde0EHif+ij2DYZG75kiUyGWRW1Xuk4e8QxmIkcSv?=
 =?us-ascii?Q?k1pdnd6uaaS+09eEANEumWNjkhMz3Ecamyh4SuuZleauOmjiBkOj7NfZ5zru?=
 =?us-ascii?Q?6q5j0T3yOLfUBFkDMwEeg8cXnZZtJ9ZudkMtmzAG1R11G8TcE61Z0QRPnOIw?=
 =?us-ascii?Q?9m6M0g7p2WJPbWBzAdbHOsAyyBNRInWgKgr8KVS6GPrHpsluoshU/M4hQSy0?=
 =?us-ascii?Q?b5rkCvTk9HFMJXjZP5iONFN1pPxRHOGkymkSmu7Gr6J0Lz4bBNYfsCqtBQSj?=
 =?us-ascii?Q?hLWZRh7wuhPZ40DCphFYBnqMRFwAXGGGqwKPQp0EaVw/arVgn+lXozojo55F?=
 =?us-ascii?Q?O6ZOX/B6caVwvlmRmInRyIZgmJ4VY1CVjfsBLwvPEfH2CJSZ8vsgw1ZyM+i7?=
 =?us-ascii?Q?pHzR7/B7DSgN720/WID/QertB93OUBN2Js8IjAOP8s7VX94pnauKr2y+FTSe?=
 =?us-ascii?Q?tuRMrGdH5pTvdwQwElxpk6AVgrr35TRcdLz6azfD3PuZY7D3Qgp8aBTilTRN?=
 =?us-ascii?Q?1XZILXzm/3kytwoIaQq5QCEZT25SQ9BKcTQ6B8TNtV70zEi+uGB4744JBurm?=
 =?us-ascii?Q?/a7dRimer+RKXUOATi3vOOJ10l9DLXGZVFkIf7Pz/g0/SH3OfXmOK5eXlnJP?=
 =?us-ascii?Q?5Baywgth10maDYtntHtxLZgttwtZOPKdDiQ0zVQulAodHcCS/PbTK8gV3pVA?=
 =?us-ascii?Q?ozjrs4q+uRpw71vK4xP0TuqM6UBVGgEOK22USXYOhvK4ANB6I3ha9/grPuo6?=
 =?us-ascii?Q?OYYsoxbOqZixm+2CNAxkp8/a9xXOkziDtFKVJIHaCyFg/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crkOatJ0snE0VDkAPZ2StoXbRuWDHnchHJi22tgmfaXsqoQXQiDmqFR8Zy0P?=
 =?us-ascii?Q?anD55NDsqsIgfrDvdBlxVuDDj3vM+9JDrKcScfgAXkqWOXcQP17rZ9nnbhPt?=
 =?us-ascii?Q?9tpMSRYyGtkUNFGxFo1BaegOo/p/BqNHtqWsMVSImVpsduIRXFLjFJMZtcuG?=
 =?us-ascii?Q?oGgKivQLG9vum8ljHAf6nxxyWYYIMr7px/b53oVRons8uZewqIfZE+5GOdPW?=
 =?us-ascii?Q?4UAz5HgyLgOyscla4eAY8NaLnW6BvvYjfiwSlDCeYmjiu0IHcw66Nfqu82PP?=
 =?us-ascii?Q?4Szl/QxthoYNJz6F6wA2GSHrqO48xHHZjrHmnRPpIQyo1L6nJIgIMTnaR1ni?=
 =?us-ascii?Q?yTwg7tiijSRqGOdPfZikdbQhlc6ZfmlG1a5NB5i9yN5eYCp4sItu9Yflaj3l?=
 =?us-ascii?Q?iy3fh56xPWCsaE6DEYBnegOL3fo334wBOf/pd/uf/HHGFIUx7y1r0ez2jx/m?=
 =?us-ascii?Q?1dzMLzQYWIHjUt+AcIx3CZNGUjperC3/IMLkL/Q9NFwbZbtw+mPJ4Rk7ExoE?=
 =?us-ascii?Q?2zacsayORdYTgud6iKp/G5y9greefQ9/iSLmMuBP1m++JY3IFPeiGmjMFk7w?=
 =?us-ascii?Q?DJEsEko1mfJQPVDbBWzQYOiBFwGPaRY4i8dbY3rC3MeYU4w7FV0yE27N2gQ5?=
 =?us-ascii?Q?3OubwUcvxL96BjTyGEs4JSqUVUuxJJqgsVtefX05HXs/d0TGp4ebsM5O7pm7?=
 =?us-ascii?Q?P46vp1SejUZEAAxUAmbaBmcDNTckRC1+iuBYRnXyuZWSTHY0ePfGto5OE3vc?=
 =?us-ascii?Q?SkB1pNw84jlWxH0DpmdonaG5RqCU3x4UhOunxBAm8Ye45muZKPYXH81eVgkE?=
 =?us-ascii?Q?7TXMSYywr8bSNgRVHtvr66YstPN9A3cLCyvQmnRLMiBMag/KxAbyjYGix7db?=
 =?us-ascii?Q?iWpmXHtqpWMUmXJuVGmbiqmdNvqRVcXHRwdql/nkko20q8hzeU7QlAlK7t+/?=
 =?us-ascii?Q?+mdXliapD1qpDeok0aBe1r1xFus+B2ZrREciwt+RIjBpyvxLHMEqdDZELCH3?=
 =?us-ascii?Q?hfFI03+IxNFqwIp/DlWEaAwcFVRzIYZ2cKnhAPbqURvIEHqDL3qvYLYj1uba?=
 =?us-ascii?Q?14rKx8JSRjq54CzLJq3xv8zPVWgx92KTlFfQ0QbUomg0AU4LkM/M1o6vmRLY?=
 =?us-ascii?Q?3zlATldiSQMjdAZLTFrmNRmvgbQ6wqTtK42r2HDhWqhLFjmGWCcEXUTL//1h?=
 =?us-ascii?Q?8LPtKImwEo8CnsI/hIi9bxa36SwGr8mwezRYCQEF5v/eeCdufVSL17g5jmv4?=
 =?us-ascii?Q?MAVI3qOxeMD9t/2uuYLUP4iYLgNrEnfnFRFqVcsvQejc/Q2DEaLrmul+9qtt?=
 =?us-ascii?Q?AgCra19fIfwbat7IyZ5NUP7KmCk1d3/3nMX48KK7Vx2TlfyCsgeJEqieRmX7?=
 =?us-ascii?Q?rxonBB1vlTdpPeR3iSDZS/yA6gEjPzxGca0hoBV9e3n3rZLuw2H6QnSP+3dz?=
 =?us-ascii?Q?gT+ISUFZikwQ9N1g76ZBJ5X1Nq9PHWj8YNJL0xQhiIcMTy1SZjhre49H+zUb?=
 =?us-ascii?Q?nZGuQxseN/1TaVNgam6325EADpHiyNhO6W+ylkQBEmTUPTM9anUQwf/azGEc?=
 =?us-ascii?Q?Ji5GtSW3mrqcz9EVohE7QViJ6ctOhMnRBAkL7s6D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c77a8-f541-4f4f-2102-08dd1b273ec3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 03:35:52.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtDsubQhyoMrLpzwV6F6Yy1jp6COX8L4wh4FFLqZeI+VjdgzAgmO47nS6C4nUi49iOu8r8iFxjCmcGxI5Qgaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

The current implementation of br_multicast_enable_port() only operates on
port's multicast context, which doesn't take into account in case of vlan
snooping, one downside is the port's igmp query timer will NOT resume when
port state gets changed from BR_STATE_BLOCKING to BR_STATE_FORWARDING etc.

Such code flow will briefly look like:
1.vlan snooping 
  --> br_multicast_port_query_expired with per vlan port_mcast_ctx
  --> port in BR_STATE_BLOCKING state --> then one-shot timer discontinued

The port state could be changed by STP daemon or kernel STP, taking mstpd
as example:

2.mstpd --> netlink_sendmsg --> br_setlink --> br_set_port_state with non 
  blocking states, i.e. BR_STATE_LEARNING or BR_STATE_FORWARDING
  --> br_port_state_selection --> br_multicast_enable_port
  --> enable multicast with port's multicast_ctx

Here for per vlan query, the port_mcast_ctx of each vlan should be used
instead of port's multicast_ctx. The first patch corrects such behavior.

Similarly, vlan state could also impact multicast behavior, the 2nd patch
adds function to update the corresponding multicast context when vlan state
changes.


I can add selftests if the approach is good.


v2:
- patch #1:
  - add br_multicast_toggle_port() helper function
  - add lock protection when access vlan flags
- patch #2:
  - remove br_vlan_set_state_finish(), move implementation inside
    br_vlan_set_state()
  - add lock protection when access vlan flags


Yong Wang (2):
  net: bridge: multicast: re-implement port multicast enable/disable
    functions
  net: bridge: multicast: update multicast contex when vlan state gets
    changed

 net/bridge/br_mst.c       |  4 +-
 net/bridge/br_multicast.c | 96 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   | 10 +++-
 3 files changed, 99 insertions(+), 11 deletions(-)


base-commit: f3674384709b69c5cd8c4597b8bd73ea7bd0236f
-- 
2.20.1


