Return-Path: <netdev+bounces-257975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKNqGRMnimlKHwAAu9opvQ
	(envelope-from <netdev+bounces-257975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4D11388E
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F76C3007225
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417EE2FC000;
	Mon,  9 Feb 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEp1QQt7"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A92F6907
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661638; cv=fail; b=YsRY0Pxl+EOhkxWv81r8+hODy/+5GUfd3p73YjZRB4GIP1okT9Tc1unJqj3p0RsuV6cCPzcK0otbqrTbHPW3pmtyPXMzugR/cTzdtn78a+dOObQFnLe96nmWH2RSNMAq/GC+s+Ygq4VapgxYMTgaSUaNb9Rr2+dMv3IyQkvt26g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661638; c=relaxed/simple;
	bh=qYx5aozcVwNewxom4AMb8Z/y4+TbisEHmEVEkJFThCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELlhVP9e5hIKauO/RE44bDdHNNOX29GD76/y8a3kqA9E+K7Ofh7KNJqYfriE9+AOxocsiU+JEty49yXQVddb7k9G1p7W5fKvPJQFA2gx62DRd2RRak3hA5uqbHCf6a1OUlLJaV3huNhyOzZpaeJG9Y6/ixzQayepi5XTmE6s8gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEp1QQt7; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRKT/6r0oRUN6bEp8l0lqPk5MAmeBVsTdSow4z3M3+xL69PBLjzQYuEY8CITWrKAoV3NYnBObyhlSZH+WOplhK2zWL35iOlUMNqzooOkc94/BhRBXIuye6+s9Tv/wc4O0DhsSx/X0gRmEV0X9IiPQZy7z9qqa/lPj9c9xvAAnl15wpHC/4w1OYQJ0iCmikwQI2xm63VYm7aZyTaM8vYbSn0hLh33CIcUDDuCitnRIZ5+mE3Wd4ak8FR+hsVvDNPnqhgOVbcZAbTdRKRhQ9dKY+zAeSuYU2Wm/kikiEwcMkE1H2WFfHbt7/0UsmoPn9dR7LF9Tkm0I5w5pa0sCn4xjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlK3TzXmxDXKgm2SQ5B351j5eF+kCvDJ13uBE2Hp9o0=;
 b=OxHa/8UARroCpg6I8++wI99g+EK/Alwl77ySM/55CiHa8AlQ+ujKiQICMKFmkH0Gmpy/I8D9IDwddPw9yi9pL92YFdUHdiDdgZiGhtc7kpOjOtpAhI2TpFO2KPjTWzVWHxQlleXED5MUOWt53veERO7fI2BA+mn+0w6W4hUhday+mq5nUS90AIbwPxvZNdlKgydt5nE6iFYMr1RcCMvDFZNMI1Xyn43eydBV+wZVu532AotpnhsmFudRL/ul6aslH+PrNnEioxQs4A2mzogbZRX0MVlbyQc8Hw1IpWUMih/DZBhFEnjRqV4+KXJncuQ+aCm1htt7HnjFrV5+pDQvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlK3TzXmxDXKgm2SQ5B351j5eF+kCvDJ13uBE2Hp9o0=;
 b=AEp1QQt71QJ7kYjY91e0PgqQ2E4si48CH4HZEJFWxg11OfslJ0DwbH3w5W/XRQGHXscNLYUDloz/gVpx/PqU9F6pLWck92dFB/vt/65xRe1VfqphtMH/PIqjkbE6Jwg9jjfYOJ1Kk2kNIwonZBKkXWY0LEPxVp1SnrsM8YxcRp4=
Received: from BN9PR03CA0379.namprd03.prod.outlook.com (2603:10b6:408:f7::24)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 18:27:13 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::c9) by BN9PR03CA0379.outlook.office365.com
 (2603:10b6:408:f7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 18:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 18:27:12 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 12:27:11 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v2 0/2] xsk: Fixes for AF_XDP fragment handling
Date: Mon, 9 Feb 2026 18:24:49 +0000
Message-ID: <20260209182642.237904-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffbe037-3b53-4c4a-9e57-08de6808d83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3YFENE/MFYU6grRCwiLik1AOAjtipvWv/GOSL5+9AJ8lW2xnnL+PKwcT4eMb?=
 =?us-ascii?Q?dokWf9CyjmpGupQbdVpEK1CogcY/sH80f506LTorwouxEaAb4sDuo/M94N5J?=
 =?us-ascii?Q?8ACKghI9E/BxCAyCX4Zh9SA+xrWRMe4VPkIAcqGd7/G+JPE19mhWhYPu57Or?=
 =?us-ascii?Q?ScQ7UkEcBReFaBIlmW1HsR0PZL79FMoWxGufkHWanJMX40oUcuP3GJ1vHSwC?=
 =?us-ascii?Q?zLFPAeVKWSsWQhAEiMQ9ndn//ojNEl4qEf4/8xRg23lCX0zFIGsKQEVsdv2K?=
 =?us-ascii?Q?34teqt166RiPdYIgc/rNd6D4+pbEyN+/Mugnw8OIB/ZUxB83r7t3GdGm7W2i?=
 =?us-ascii?Q?e5jFg6Pn3OT4BAPm18T7gS+8aRLjYEsPHfj73lHtCeVv4XXwlNpCjxJFV+jP?=
 =?us-ascii?Q?rSLIRDH/v/jrj+aaDujI2rjMhebcQLW2mBGC6nmfRtbxWrTISfo+tkX5NIi/?=
 =?us-ascii?Q?bow7WecJGoWgQzykVeO1RxnqQm2wbbOeDiMnV2yRtkISJhmx9rqLxVEdKBkZ?=
 =?us-ascii?Q?iZ9rKndC/H6YzD4unq+2Lp664c3Oh8JSqT7bJo3HnBVl3I6MWacz6HWsn/H7?=
 =?us-ascii?Q?kNdJ8xnvoVsiEd6bzT3PlCmSlrGzCZ5PR2VwKHRMJcw12K7hkjmNP3qgYz9Q?=
 =?us-ascii?Q?OhIHfMAtbIV2zQZlLgS5SzKCd3UuMGHphLbPzWpajDiZX2ZKHt4at0GYjkBP?=
 =?us-ascii?Q?elrXUG2e4gGI1R26l/PWsv3xTNsC01z4BP4BCYlnlMmoU53unsGtIDzU9sO9?=
 =?us-ascii?Q?sHO9sCiLd3JtMv3GrHGtIoQ2UyQwuRhYt8TDIMHDmjGxlxqNuE9OPRzvr9Ak?=
 =?us-ascii?Q?SJ+KnlbZqupXMZBA2FdAQO2GLGsGJREPeAfGUK1zvwgM+iEjw3e/PP0HHsK2?=
 =?us-ascii?Q?8wCEDsGfOKz8ONWOpBhLHKl3H7EPhbajDwhXoBz4dmGUMb4N5NLQxYHW96Kg?=
 =?us-ascii?Q?tPnPjJkxAxfoCkZmo7GFAoOfwU/rrh0bEQIycxAf2FEzfKEJHHSblQqeDiiD?=
 =?us-ascii?Q?GsBBwd9k+1BHpZGG/lFnhCSOQJOkZsp1368nPm4sG7/2YfoPeTIzTWw4vs1y?=
 =?us-ascii?Q?NiYSW1P/isGTJDEqNnBFldhq1xilXuVEfcdTFS2bUeI59kJVCzpp3ZPNvz6p?=
 =?us-ascii?Q?t721AinHkY4ZvJmu0mWKIQSB7IorpymQHbwtwUwBRzHhmlymC0okOIGR0glw?=
 =?us-ascii?Q?TCCAHVQkHadJcyEwBPqJ/7KZloWk8NLoaKJb+e2tD5IfATqgJZkdzV3TShuz?=
 =?us-ascii?Q?kgatGQglkQWTygc13cmBQo/912/Y3kuUENelhrpvBpVb7in3GJ7B1xt420YY?=
 =?us-ascii?Q?8FwHf3ENZAKLBpGtFAUm5O4w+8MvcsjkXrtE3NL8gLxXrPWUEsN9XX7hekke?=
 =?us-ascii?Q?3vDEOPs5ClTC3ftWBRd32ZrplVpwuhXqCdl/G4J4prsEfmEP7M0EcaVc8wjX?=
 =?us-ascii?Q?E+cFKa7We/MqknJEjVIiINlFKt3kzvE/83D9ZWUVD7G/QCMCaghrMJ+O3Svx?=
 =?us-ascii?Q?AeDx6hjE0UfxotxevDVoZX9fawIcWbMDKIDNhDDTcw4i51Jzg1RS3gSc5O0P?=
 =?us-ascii?Q?hWfgTdRg3E5mybx+mmr7oH7uEy31rYDjaNhz+I3TCPryR8o7iY397r2l6JKU?=
 =?us-ascii?Q?TrQHWpqYwif38PN7eMXkwTmKUAwo1ldPUd2oWbgMcAKmLWfV/ay3w1pImkyu?=
 =?us-ascii?Q?mtPV9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s9UwsKeIH1ZvdiOPwCOQLNA6/ZFqDFHdV5rR8ICfmtvexW8Dw5yTJSVTD2hXxH25BquXBFsAxiobZICmWfnIYc4EeeV7EYU5IiazpW+lVLCmiNul9dPbC0AGWe5s10jWJw2V1L0Dmim8hEK8d+k2BXVLq2RnVhXRVdkvPkr8MIrcxICrr380KRdQbdETfmPrzicXMTNOa88iBTsYic1U1LNy7EqOGYolAoWS7zDFooL3rMwxG+2qeZt0awIkM3tA72OPCytCGvBVMT0E5tqYYq5ZvQ0uKMXWcPYeSWOour1LInkYnPoczIt67cXlbqP39TKH3talPTaodYvrbK4JufaAfL5IPaxAtbjPUm78cUHdUsjyRl8aT6gK5trrotNSplLbgiWqVg8XkOj1cGIzVMrRK5872/2OI6/ff50d4fTYZ14gf6V42MgyMz9N6WuV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:27:12.9774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffbe037-3b53-4c4a-9e57-08de6808d83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257975-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7FF4D11388E
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

v2 changes:
 - Fix indentation issue reported by kernel test robot [1]

[1] https://lore.kernel.org/oe-kbuild-all/202602051720.YfZO23pZ-lkp@intel.com/

Nikhil P. Rao (2):
  xsk: Fix fragment node deletion to prevent buffer leak
  xsk: Fix zero-copy AF_XDP fragment drop

 include/net/xdp_sock_drv.h |  6 +++---
 net/xdp/xsk.c              | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.43.0


