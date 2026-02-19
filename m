Return-Path: <netdev+bounces-259400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i+0MGnOklml5iQIAu9opvQ
	(envelope-from <netdev+bounces-259400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:49:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3915C2CB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C39301FA5F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAAB296BBD;
	Thu, 19 Feb 2026 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4h3hsATN"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E21862A;
	Thu, 19 Feb 2026 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480176; cv=fail; b=WR00D7qFLGbTO6AxWn2tonGpSoexQIH6a9wK75uoTtsyVRBrP2wK/aoxsrQgfVpvMFm5JBGAbPvwrD16SnqV3BiEiLwbAa9Dg7+2GB8VDuvXPLUa7Kvck/djBCyTycgDfiBhSZe9OWcRV1bgN/fjzxqSPFnCVUKwfkDUe8eV22A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480176; c=relaxed/simple;
	bh=nGOy1se7yQpPbwxTc2xQyTQ3TOGrGsi/zNz+Ib/kgLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ARdU3RzoiABt/l9BMLBv1C8QDekatxAHR+ymaNV9begIh1LFvFQBfRWDGtjECErnyDx94LWEqPod/9GO/Sb0MN777L/VRzL/PmcT8XeF9T8OthhcmH6qabVcyCbtLHpYSqxvyWDCGXmGu5AHQUoK3tkcqX9dYBxT4NZQ+nuUybw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4h3hsATN; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN/CVOF0/ldvwxM28DqOkfmXCAHh6W2st3BqUOy/lTZWzLqSFlrPunxW6S6qeZ1YnidQCoodNoxLitQSJO/BTvqOUnua7bYImbCunXHL0fQkl5otS3x0engPOky7jFPvxLtOn6TE+0cihs5EhBonwOLaXT7mIEZyoBSuZ9mkFBz5HD1eslI/gc6DI3VB4p9TBA6XnGwhQbdEmT0ylNOXsQEx/euCgK5LksF2G1TQTt2HkiGkRRRZGmiPRncOZxL7gia1ffrLF/2j0/+DnGIj1MVwoX85j+2SJ3v7/dIgTpn1DCqqO1vBo3k+PZdu1TRrM/sPQ6NaZzpC6ZRKVyXQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC9pLHunu0UpJSIlaY/C0W5dpmboxj7FPo96aP/lW78=;
 b=Y0hFhQjWU5cYfQsYKn42KMbhAGepdvqNoqcy9GMdwh9iihwCsKUKpfWwtpuFGDowzyBqPZD4qSIv46gNsghwa1rR9k/BTLIdkS+aYYsHNHeDkP3AqtnG6R0/Ip128Cw1QI8Q8w7xv+NJfE3Cp3sNJqBTARhP+lKAVdu9KvHfmN/vDAJKmcq4oA+EfyeecA/AejpsHTVGup3d7j6RGYQUYYTrxzH9nar0jm2kUhC1/RaUodbsY0K0cZYz6Fxzqu3sTz4pEUxevUV5ul7E1j3JC77E2TgyCEUZ1Jks7ye6opW7YDTQhmu99wNUXbzJJLNPYxtoXOWc0hQg1ULqcu5E6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC9pLHunu0UpJSIlaY/C0W5dpmboxj7FPo96aP/lW78=;
 b=4h3hsATNYG7yTcsBYhn/wFUQAk8AaQ1jbwfwai154PfVO0DMhUSPEMifqqc+NwOYtunDhDJp8Oi38qIlgFC2jvAIERt4UXKBDuPvm17M40g2OI0X1a9xb1vWb9kWUW2koCFXwGZhkmd+jozTwRouPhtexgvq4vld/KleuHVDI+I=
Received: from BYAPR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:e0::16)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 05:49:29 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::99) by BYAPR05CA0075.outlook.office365.com
 (2603:10b6:a03:e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Thu,
 19 Feb 2026 05:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:26 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 23:49:25 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:21 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC driver support
Date: Thu, 19 Feb 2026 11:19:03 +0530
Message-ID: <20260219054911.2017362-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: srinivas.neeli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbc278a-8f3e-412f-0d96-08de6f7aa4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|30052699003|7416014|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+v1xA6J40QC/UxFksQOr5bRo+2iXylRwUk16JqXHab2ol0A7wmJfZwUxryPr?=
 =?us-ascii?Q?cNMouXpNVEQ6XonzO8emTfH8Xyw9714xXEWxrMONyjfnqq0/2y9KZlvREdlg?=
 =?us-ascii?Q?7/c+YSVC7KLoIUMda4MC/jOG6zQqWyYmdb/z22Kc+6yFZEF1w33YQMKdc7ln?=
 =?us-ascii?Q?8LwBjBpa68nm3I5Lmwpe4/pa4c3g2/8OcbZjZfG77fxTue4btV6p3OST5f3S?=
 =?us-ascii?Q?qOdBQ8ave5pOnqL/1uRsvOFBgakNmY8lA+aJIhlkvBX0oqbkENufEYZE8bsC?=
 =?us-ascii?Q?o5JacSE3B5xCHuB2Z3m6/9ybPzL/BvCFlvT4WwbPUxo4GGq+X6SmXfrw768s?=
 =?us-ascii?Q?pcYsYM6JXaBmUgl1Y4fpRC1aYTdyyy1DvYuMZlPB5wWH4SeZ/epQyLqN/KQq?=
 =?us-ascii?Q?20E7VHjm42aRV98txsn5pRCA/tXS+RDakCJPWsG4S7k4dnDVe35d1JxlxVvZ?=
 =?us-ascii?Q?yaUHTQ5NIlns8AJUckwIfDZr38vf80D4C9px5qwd1FayJnpslZ+fJqGkKi1P?=
 =?us-ascii?Q?0DgZH6LARIBB+GWLw5SyRYd8MbfWjv7XTlGJ2DPLYYCDCmfnlKfhnffjiJb+?=
 =?us-ascii?Q?fBkHKEyWpc2dSJVvoBGJR9l7MaIQgP1uQ7MluuYkdP4KrqSY2PoAGZ2fJGgW?=
 =?us-ascii?Q?nX+q0aos/0FM9sCC1OfgR1ThGDJNBE6WVMbtYKrDHmtNBs8xsw0w1b5osamZ?=
 =?us-ascii?Q?PPVFWSpfB+/gxELQ1cAq9vVs0rfYbS+VEVedB7i4Gn9hPe0oBwu2dSDWwyvI?=
 =?us-ascii?Q?7tqtx7/4od5/rONaPteoa133E23//dPOlJ1v747DrFjnxHbeCw9+6rW4feS/?=
 =?us-ascii?Q?r7Je0QZec80ZRwPVXzNYabDpM1PUZSN6Ah0eXDwUlNKnPJ94rbePF3D7fk/a?=
 =?us-ascii?Q?aOwYKlXrSTzAb8eCmX0FFaZmkBiRL02tmTP7tbtbdXXErLTnzN0EuQVzLuz/?=
 =?us-ascii?Q?JXMvXkkJuaV7zaV6gZd5fdJHIKmlq2eOb7WMlbHtJjYERrF4Oe/aYWnKDWx5?=
 =?us-ascii?Q?t+jNveMrSMK7ZNqnJkC0Ws7PujeOWdDixDwO6tKAw8Nf+Cw0VU1sFvAD3PuD?=
 =?us-ascii?Q?yuDcWEzOVvTdpPUOFEc2CdddQs5+EJpdBEsSl1nDV/cpLnM98UoI00ntsoJ7?=
 =?us-ascii?Q?H2065tJpBWS4aw3BXXDwc8YprZDfAUa7/Vv+saALtclIdbJ/RTuS0uInB3f0?=
 =?us-ascii?Q?F9VihOupRrXPMYarqNFHKUQBMzf6zTjQ/1NboIsut/+FQ1EbhgumjXq/I0Sn?=
 =?us-ascii?Q?QxpNUbknwIcSIYOdn7YCi9YM7z5Sl2KkPBWjGI9QIYNLCW8sGn74WP2VRV0c?=
 =?us-ascii?Q?jbRKF88i0MuF/wjPF3SQJGpWE8/NFI7tN1KnfsICLHk0rDK3Jnu5STdkgLna?=
 =?us-ascii?Q?3X4q7dtprY6bqNI/L1kic3WkWwXLd+7PCmCVBCf4STd9Fq0MrURSirkmxrAP?=
 =?us-ascii?Q?Sh5jQgsZTLLi8E2ihK7IelFj4ny7rRXxSbBzr7xEKg93yTFVgM+sDPv97YuF?=
 =?us-ascii?Q?KRHbxvFCROhfHHyjeODg1h08XBo+3G5Kob1Dw7KyUuqDz9ZG5z7HlTT1/iBW?=
 =?us-ascii?Q?xuE6SbXmmNqekSObbG2eUNbiG54B4tra7YkkGfVNzftI/qQEPaAjzqUWgtQ5?=
 =?us-ascii?Q?0NNzZ3JoNG3vEhv5OPJeYoPeKiw9EvlqYFhEzLVZ/YBZQnwCuyYni9vOhK/k?=
 =?us-ascii?Q?U26kcV0YfkrmUfPxyiqEdmZnJUc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(30052699003)(7416014)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	abvHrcQ05ltADJulPWrk7yT2iYjxCwiyICnYvtKy9mxAtR+WI36lWS8IhUIQY8X0Gcqjsqx6BMrTbNUQqSaCJhDLrIKsfZqHAAEoPXXwdy9c5osBKVA7hDXYu5ZTptB1ytDRnmB9NZV2zxQKgKSyyUpQ0zHzg2vjwkdqRsf7QvpLtsQcVGzz/eg4DbSvxczHGkxjrKgdrxgww9PC36kc/iNCTuY/ubAh+P9mBOCWsRd9JmO9LM7ZomOCSdHBjnxS0bbhUjrG4OmpPpefl6zaySqq2qJAGQGvULIr4OlM8P6IKxlQ3M2EMo78BkckXdR0ezX0IcWZfqADDvvyXIZIihubAWcPgMeY5PttAETk6smFGSf+9hiWam/7/cf8Sz4R7RGsfU2rXVUOOSGKfM93ToDCbMOTAwGuASYPkuMNZP14pHTKNdUTPeE03zfDMG/f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:27.6608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbc278a-8f3e-412f-0d96-08de6f7aa4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259400-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F0B3915C2CB
X-Rspamd-Action: no action

Introduce a new network driver for the AMD LogiCORE 100M/1G TSN
Subsystem IP, also known as the TSN Endpoint Ethernet MAC, which
implements IEEE 802.1 Time-Sensitive Networking (TSN) features for
deterministic and low-latency Ethernet communication in real-time and
industrial automation use cases.

IP Core Overview:
The AMD LogiCORE 100M/1G TSN Subsystem IP solution (named as TSN Endpoint
Ethernet MAC IP in the IP catalog) implements IEEE 802.1 Time Sensitive
Networking (TSN) Standards and provides a low latency Bridged Endpoint or
Endpoint only solutions. The bridged endpoint solution consists of a 3-port
switch that connects to an endpoint including Linux software drivers. For
Bridged Endpoint (Switch Endpoint), two ports connects to the network and
one port connects to an internal Endpoint. It supports the use of
GMII/RGMII interfaces connecting to a physical-side interface (PHY) chip
with full duplex 100 Mb/s and 1 Gb/s operations.

Features:
- IP Customizable to generate TSN Endpoint or Bridged Endpoint solution
- Supports interface to network software stack
- Designed to comply with the following IEEE standards
    - 802.1AS  : Precision Time Protocol (PTP) synchronization
    - 802.1Qav : Credit-Based Shaper for traffic shaping
    - 802.1Qbv : Time-Aware Shaper for scheduled traffic
    - 802.1Qbu : Frame Preemption for ultra-low latency
    - 802.1CB  : Frame Replication and Elimination for redundancy
- IP is customizable to enable various TSN feature-sets
- Supports three priority queues for scheduled, reserved (IEEE 802.1 Qav
  Credit Based Shaper) and best effort traffic classes
- Provides feature rich Ethernet Switch that caters to various network
  needs
	* 3-port Switch (2-external, 1-internal)
	* Programmable cut-through and store-forward operations
	* 4-port Switch (2-external, 2-internal) extension through
          'Endpoint Extension' and 'Endpoint Packet Switching' features
- Solution validated on ZCU102 & ZC702 AMD Evaluation boards.

Sample hardware architecture diagram for Bidge End Point like below:

             +------------------+
             |      MCDMA       |
             +---------+--------+
                    Q0---Q7
                       |
          +------------------------------------------------------------ +
          |            |	 TSN sub system(Bridge End Point)	|
          |            |                                                |
          |     +------+----+  Port 0   +-----------------------+       |
          |     |  EndPoint |<--------->|       TSN Switch      |       |
          |     |    (EP)   |           +----+-------------+----+       |
          |     +-----------+                |             |            |
          |                                  |             |            |
          |                              Port 1         Port 2          |
          |                                  |             |            |
          |                            +-----------+  +-----------+     |
          |                            |  MAC-1    |  |  MAC-2    |     |
          |                            |  (ETH1)   |  |  (ETH2)   |     |
          |                            +-----+-----+  +-----+-----+     |
	  |			             |		    |           |
          |				     |              |           |
          +-------------------------------------------------------------+
                                             |              |           
                                          RGMII           RGMII
                                             |              |
                                      +-----------+  +-----------+
                                      |  PHY1     |  |  PHY2     |
                                      | (Port 0)  |  | (Port 2)  |
                                      +-----------+  +-----------+
									  



Software Driver Overivew:

This patch series targets for Bridge Endpoint design(Two EMAC's ,
one Endpoint and Switch block) with Multi channel DMA.

The TSN driver architecture mirrors the hardware structure by dividing
functionality into multiple sub-blocks(Endpoint, EMACs, Switch, MDIO, DMA).
Each sub-block includes its own init and exit routines, called from the
core probe and remove flow, enabling flexible configurations and clean
error unwind. Please check detailed explanation of each sub-block below.

Core Driver (xilinx_tsn.c):
- Acts as the central entry point for the driver, implementing platform
  probe and remove callbacks.
- Handles device tree parsing to discover configuration parameters such as
  DMA channel counts, queue priorities, and child hardware nodes.
- Manages clock acquisition, enablement, and disablement using the
  kernel bulk clock APIs.
- Maps the top-level register space for the TSN subsystem and prepares it
  for use by sub-blocks.
- Establishes initialization sequencing, ensuring that the endpoint is
  initialized first, followed by EMACs and MDIO, and finally the switch
  block.
- Provides a central driver context (struct tsn_priv), containing locks,
  statistics counters, configuration parameters, and references to
  instantiated functional components.

EndPoint(xilinx_tsn_ep.c):
- Implements the primary host-facing net_device interface (tsn_ep), which
  acts as the main application access point to the TSN subsystem.
- Manages multi-queue TX and RX descriptor rings using the dmaengine
  framework for high-performance packet transfer.
- Handles DMA submission and completion callbacks (tsn_dma_tx_cb /
  tsn_dma_rx_cb) to ensure efficient packet flow and completion tracking.
- Includes a VLAN PCP-to-queue mapping mechanism, enabling priority-based
  traffic classification and scheduling.
- Implements standard net_device operations including open, stop,
  start_xmit, set_mac_address, and select_queue for seamless integration
  with the Linux networking stack.

EMAC & MDIO (xilinx_tsn_emac.c and xilinx_tsn_mdio.c):
- Discovers and initializes individual Ethernet MAC instances by parsing
  child "ethernet-mac" nodes from the device tree.
- Allocates and registers a dedicated net_device for each MAC port,
  enabling independent interface management.
- Maps and configures register space for each MAC instance, including MAC
  address programming through UAW0/UAW1 registers.
- Establishes PHY connectivity using of_phy_connect() and manages link
  state changes. 
- Updates MAC control registers dynamically based on PHY state transitions
  to ensure correct operational parameters.
- Optionally sets up an integrated MDIO bus if a "mdio" child node is
  present under the MAC node, enabling PHY access and management through
  the standard PHY framewor.

Switch (xilinx_tsn_switch.c):
- Handles initialization of the optional TSN switch block by mapping the
  "switch" child node from the device tree.
- Provides per-port state control (Disabled,Forwarding) via a hardware
  change-bit handshake mechanism with polling and timeout handling.
- Adds frame filter configuration support based on unicast source and
  destination MAC addresses.
- During driver initialization, all switch ports (Endpoint, MAC1, MAC2)
  are configured into the Forwarding state to enable data flow across the
  fabric.
- On driver removal, all ports are transitioned to the disabled state to
  ensure clean shutdown and traffic isolation.

xilinx_tsn_ptp_clock.c:
- Implements PTP Hardware Clock (PHC) support for the TSN subsystem's
  RTC/timer block.
- Provides ptp_clock_info operations (gettime64, settime64, adjtime,
  adjfine) for time synchronization.
- Handles RTC offset and increment register programming for clock
  adjustments.
- Implements PPS (Pulse Per Second) generation via timer interrupt
  handler, generating events at 128 pulses/second and delivering them
  to userspace.
- Registers PHC using ptp_clock_register() and exposes PHC index via
  ethtool for use by PTP daemons (ptp4l, phc2sys).
- Initialization is performed only for EMAC1 (MAC ID 1), as the PTP timer
  is shared globally across all MAC instances.
- Calculates RTC increment value based on fixed 125 MHz GTX clock
  frequency as specified in TSN IP core documentation.

xilinx_tsn_ptp_xmit.c:

- Implements dedicated PTP packet transmission and timestamping path
  using hardware PTP buffers.
- Manages 8 TX buffers and 16 RX buffers in hardware for PTP packet handling.
- Provides 32-bit aligned memory-mapped I/O helpers
  (memcpy_toio_32, memcpy_fromio_32) for efficient buffer access.
- Implements TX path (tsn_ptp_xmit) that copies PTP packets to hardware
  TX buffers and queues skbs for timestamp retrieval.
- Handles RX path using circular buffer mechanism with ptp_rx_hw_pointer
  (hardware write position) and ptp_rx_sw_pointer (software read position)
  for synchronized buffer access.
- Delivers hardware timestamps only for PTP event messages (Sync,
  Delay_Req, Pdelay_Req, Pdelay_Resp) by checking message type field.
- Uses interrupt-driven approach: RX ISR calls tsn_ptp_recv() directly,
  TX ISR schedules work queue (tsn_ptp_tx_tstamp) for timestamp delivery.
- Implements proper error handling including NULL checks for skb
  allocation, TX buffer overflow detection with netdev statistics updates,
  and cleanup paths for interrupt unregistration.

Future work:
- Plan to add hardware statistics support for EMACs.
- Plan to add support for PTP(1 step), QBV, preemption, FRER features.
- Adopting switch dev frame work for switch configurations.

Test information:
- Performed ping,iperf3 and 2 step ptp tests on the ZYNQMP platform.

NOTE:
- The changes depend on a few patches in the Xilinx DMA driver
  (xilinx_dma.c). Some of these patches are already posted, while
  others are still under review. The corresponding lore links are listed
  below, and links for the remaining patches will be added once they are
  submitted.

https://lore.kernel.org/all/DDB5J5V1IM0E.34WP32K550WIU@folker-schwesinger.de/
https://lore.kernel.org/all/DDB5IRSNB09F.3HRTZZOZQ7J6@folker-schwesinger.de/
https://lore.kernel.org/all/DDB5IDDEOVBT.NHJF03FYW2BN@folker-schwesinger.de/


This RFC is the initial submission of the driver and aims to gather
feedback on design, structure, and subsystem integration before
further upstreamization work.

Srinivas Neeli (8):
  dt-bindings: net: Add TSN Endpoint Ethernet MAC support
  net: xilinx: tsn: Introduce TSN core driver skeleton
  net: xilinx: tsn: Add TSN endpoint and MCDMA support
  xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO support to the TSN
    driver
  net: xilinx: tsn: Add TSN switch support with port state and frame
    filter control
  dt-bindings: net: Add PTP interrupt support
  net: xilinx: tsn: Add PTP hardware clock (PHC) and timer support
  net: xilinx: tsn: Add PTP packet transmission support

 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml   | 362 ++++++++
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/Makefile          |   1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig       |  14 +
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  | 430 ++++++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_emac.c | 547 ++++++++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 211 +++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 794 ++++++++++++++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c | 308 +++++++
 .../xilinx/tsn/xilinx_tsn_ptp_clock.c         | 386 +++++++++
 .../ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c | 451 ++++++++++
 .../ethernet/xilinx/tsn/xilinx_tsn_switch.c   | 546 ++++++++++++
 13 files changed, 4053 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Kconfig
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Makefile
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_clock.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_switch.c

-- 
2.25.1


