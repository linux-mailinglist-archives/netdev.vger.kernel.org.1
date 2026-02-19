Return-Path: <netdev+bounces-259407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Nd3LnSllmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:53:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF815C38B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C327630917B6
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D32D46C0;
	Thu, 19 Feb 2026 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UH6VFK+r"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14102D238A;
	Thu, 19 Feb 2026 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480207; cv=fail; b=E7MgmTq82U/nRAWkGQ9UKW5qM+Zw/SrJu2VDZWH59NpI5HQFXfilF3m80r/BUNE8OwfmfuJCWybU9pUy+xZznJnyphmjKS76vdjRo6uLSoZx5y+s7xlUHOP+MTuyS+vuEvHdNgZs0dk3Ymws10JCtojzS7iqj1USAu5s0O+y7EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480207; c=relaxed/simple;
	bh=ew2FtNNT6NV/1d0FD55XZ8FF8LO3BQAsdee3axpiVAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9oRD8gMY1GUglHszuj7Xbe77AZnh6lkWYAfTVJ7IWQLZzOh/vWCeMxOGorngMoIXLcDAHVUm4bNDQcWUqCnYrnY42v35viOB0WlBJQboPfKQBZjgmHfZB+6s0ZvEmVJRbME0Ebf/C7yMI7DmFJpBbwZtEusgx6cJ4N+T0lNr5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UH6VFK+r; arc=fail smtp.client-ip=52.101.53.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLyuGEdXwt+BIgR3eZpoj79mXAZ0zg8K2u1TnaKAfEzlaF/w+EbEY7Mo6RAxGzYscFVhvZv7sqTWKq2DDG4xPsIZUPGBbHAtK2woY5t3gww+RCSS32oC1QTuB6uCbXvDQV2r9ILfbwuJbw2zECY20gDyVqPEdRoyGtEXfRNHdffhjd2HmIKOkyL43ShDFqIWqd8+b5qKO1JQdkemvrSetcI2DqvmJmxBOsx236wMNVGOK5FgidFOxfM7ISkRVgRQbX9a4AqSU4+dHmqFBGrHTKFC/WGl5SXqsfrLpDzG5au/8hAGLpA15ee9i5u03R7ud0FSdCmkdgDKANWmof7l9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avaLeJBtYoBspywqZm3cVrSmUzpmP23Gb00lJ+TE0NU=;
 b=ckjKiqjVY67VZ4v+MY9cMHKd3VxhBC/NOt3Jg62VpuJ3fn8Ifuwo36S5xi8TdYGsppCy8SkdqQC7FRyNGcL4mSOapPVhZZl6hsMGylpgFU+UgUQ0LNE3oJr2HwzZKfduTg7ro1TOv9KSrqq/8gIAb8J1dUy2u6xRd65MDFtKMaYe/ZQ8jWGubaQIYQMXLkIIMLaNiAOhMHpPpOwS6AIU9lpYuSk6LDIzmyt8i03i6SX4CGY71yHSNDhSpq/xf7j8u2ZELwMIJt7cuhdUxtNH/H6Z+AjLYjju8jUpIoNKRU/saYE/tFJcLhjb7ejaOAsGV1/seDPt07VNWwqKjt/e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avaLeJBtYoBspywqZm3cVrSmUzpmP23Gb00lJ+TE0NU=;
 b=UH6VFK+rtllaKcqSPvdtQaJyLXUhglq9IEoOe303fMU/obyBulc1qR0LKxN+slUU8wuD5uYWACMndh9zhrIQ9hfxJ13HvMLZYgnA8sT8cqoiQ9/N94uvC5FeYpl4zWXKTKJ2Mky7FWKsa8chtgKoZGVUxLbQYWHO5c0H88U6zuM=
Received: from CH5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:1f1::14)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 19 Feb
 2026 05:49:59 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::87) by CH5PR03CA0002.outlook.office365.com
 (2603:10b6:610:1f1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 05:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:58 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 23:49:56 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:53 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 7/8] net: xilinx: tsn: Add PTP hardware clock (PHC) and timer support
Date: Thu, 19 Feb 2026 11:19:10 +0530
Message-ID: <20260219054911.2017362-8-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260219054911.2017362-1-srinivas.neeli@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 4086e6f2-bfd4-4c8c-8fc6-08de6f7ab7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDx3nA+os6ZlTKDYHl6p7tqXXQc2BTFdV1agoPOldB223WLL6BBdOCCk7B56?=
 =?us-ascii?Q?0hqKPs6b3/Eg8ZDdTZE7spY5M/bgBJGtqdQkZibqrS49I/RsJdEP0NGyRjOh?=
 =?us-ascii?Q?GW7SGRBHn7W1B8VbN5LyMj+lLa9ki4bNbI9ss0h7Jfn4DBs+cmtPX0X3Gcpf?=
 =?us-ascii?Q?uhLbNyBUefasnauEqw1iWdB8aRSj7Lgf50ZdC4ZCy1h65/ZoBitPt6kxyogs?=
 =?us-ascii?Q?ZpXeytwIEC8zs9z9nDIyaweCAWFqO8ZC6NRcxR7WZmAHCaxmbh5NoYSjRMK+?=
 =?us-ascii?Q?OfLBYkndXIooLenRGmfaZ5c1OEYd0MZz9n/p+ZPgdOfe8AfUSYv5XFFx41lS?=
 =?us-ascii?Q?MOaHjqTZEnJUh1aJgc5eyeJ2T9metGKiE3kK+y5K4Yvs0Gn5aQSFGx883WC/?=
 =?us-ascii?Q?Mt8TFsrzNe4/MpxAmVnA76nqCBTxbq8Vwo+KFkapc/IG25JArPJRK2ExpHIN?=
 =?us-ascii?Q?JQ6NZakrz3K+JMBSUbi0h132amXMc5IJ4GRcG5SkLyrUBbf/KbiGZE0yfN6U?=
 =?us-ascii?Q?haMU6VBR+f1ocBodyahVQ10bWurS4mahc3qelv6MylFifZQdW8iCprkH4op2?=
 =?us-ascii?Q?IRFNIobVFVPDQ2TH8Xk0YRn11Mu1j4V7O1YekZNyg73/mmpOnSCbiT4GpCMX?=
 =?us-ascii?Q?PQ3XceKqerGuRSFjA9ieUDX53PZrRPYwDz3KwbZyYwz2n/1Mhf2ELTDSmkR1?=
 =?us-ascii?Q?xWEIQgEr+QmMQpY/e6sU/TEim/csgnRczhcjohfbdh/RsTju4utsBGzqDCUY?=
 =?us-ascii?Q?P32sxCZ4Rzf9nJzEYRM6h8XjZZl2lFWwDNygTHtu9IVKnQxV1q+n/ja+S3rl?=
 =?us-ascii?Q?4TD8sM+i+YsShaW2M+r6U8FOqE5HNUUyYVCI9rr0RPeC11qBTXcYTND4IEAY?=
 =?us-ascii?Q?pvNp8oUCG8HFj30k/y2tQM10iqusk8lb/oeI2MzfTQxMNVOwVc434tEFaELO?=
 =?us-ascii?Q?f+MgyTpj/a0SFxZlwh49dAK5+3Giq4KPvYECljdg4tKJFuC5uHbm9L2y7hHM?=
 =?us-ascii?Q?6d51luJTlXDfijsozoLaTwj7leXteJjSLDImY7woWpRjwOQ0ZVlETmrZvhYg?=
 =?us-ascii?Q?YYTbUqxNrkITrABd/OYBFjRhmDjiDUA/IHgwTuO9Wnr3RfvqvJ1WEsYyR+iJ?=
 =?us-ascii?Q?4v5ij3ER5mVWCkuSW29TkaKLuhY/sT5GP/IS/d6TqZA7YG79IllPg054JcFB?=
 =?us-ascii?Q?MwmgV97YJppWu0EeKBcn/Tr3vPFmJOD9gz2DSK47bJuseMDp2AQsiftodXBQ?=
 =?us-ascii?Q?xvfgMPUboEJlHszHeLfo2XTSFGV225Dy9I5vLlfi/RAp1RGGl9IUp3p8Njwl?=
 =?us-ascii?Q?yo8XD+iTIRcoBDWG1d44nskesejXlYv/TQt0wI7TICPlWmRPdERf0gTGjeeD?=
 =?us-ascii?Q?RRqA3LMx6pzLNI4IwWGnx+bYwUpUyi7CDHGY3hQwbuELFvPfRNxTb0aFgW7j?=
 =?us-ascii?Q?RqjLzH8fEuagIVCd0qpWiBS+uNwS7Zsc3L7MnUxLG7hsSTGu2/CwqVxEsb4U?=
 =?us-ascii?Q?uplkwi2vfGnLRVYU7RS8Ca5Ox+eozWjvCqghx3C6t+PjcRX83bdeaTbmphYy?=
 =?us-ascii?Q?w21HCebfO+XpGbv5JDZqG9jGMmoIfi1owTvI4NBvHFRyI2SBmSY+bjmMVOHH?=
 =?us-ascii?Q?xlMaob0Kn/AdAP1FM67bpbrxwO20Ss8PHnbRH06LqVny2U304J+3w6pAPvsq?=
 =?us-ascii?Q?eq4HzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YUNUJmnznnrAbWdLMSEFnf+Gmtkpd2Szq56IKG5yclahSwYDWWnk6BaGsXAbpFwYxKXdIde77eYL15pdBekkGwlCjA+pnKzVrEn6068ffuCKmmJ0ABdsalJIa38cwzXPAUmBtpv7jZX4nXlnxu+bJzS79IAfRNED0p3jXNXTx6CrWlLdhZWtchcVoDXdyqrj4EVrJ0YN48TABAhkAWEC6BoxYYTiFrLrfFI4pA0GKX2kA2ind5/Sy1Myceb5kkwYTUULznwQ9XnWJaFSWH+k+6ud/IxbQO+QfqnkAtamkMEC7sSgttj//yy6Ys3STSvHUBSfcDaLVJcqBp5Br5K3pFu2NO+8eLRKarwPZDSoxDdGUHInOBblR6JKm3E5VVgxVKV9A1YWCF7l0/8S1YHZV+X2dS9nWGql/+Lh5k/R3ny2yujN9Ft+JELAxtGH9X0R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:59.1412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4086e6f2-bfd4-4c8c-8fc6-08de6f7ab7b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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
	TAGGED_FROM(0.00)[bounces-259407-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 25AF815C38B
X-Rspamd-Action: no action

Added PTP Hardware Clock (PHC) support to the Xilinx TSN
Ethernet driver by integrating the TSN IP's real-time clock (RTC) and
PTP timer logic.

A new tsn_ptp_timer abstraction is introduced to manage the PTP timer
registers, RTC offset/increment handling, timer interrupts, and PPS
generation. The implementation provides full support for PTP clock
operations including:
  - gettime64 / settime64
  - adjtime
  - adjfine
  - PPS enable/disable
  - PHC registration via ptp_clock_register()

PTP timer interrupt handling is added to generate PPS output based on
the TSN RTC pulse counter. The PTP timer is shared globally across the
MAC instances and is initialized only for TEMAC1.

Support is also added to ethtool -T via get_ts_info to report hardware
timestamping capabilities and the PHC index.

This enables Linux PTP services such as ptp4l and phc2sys to synchronize
time using the TSN hardware clock.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  59 +++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_emac.c |  55 ++-
 .../xilinx/tsn/xilinx_tsn_ptp_clock.c         | 386 ++++++++++++++++++
 4 files changed, 500 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_clock.c

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index fc1c0cda0843..0faa5233221b 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) :=xilinx_tsn.o
-xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o xilinx_tsn_switch.o
+xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o xilinx_tsn_switch.o xilinx_tsn_ptp_clock.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
index 91d01313aada..0cce916825ea 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -25,12 +26,15 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
+#include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/units.h>
 #include <net/netdev_queues.h>
 
 #define TSN_NUM_CLOCKS		6
@@ -107,6 +111,55 @@
 #define TSN_EMMC_LINKSPEED_1000		BIT(31)    /* 1000 Mbit */
 
 #define TSN_MAX_EMAC_NO			2
+#define TSN_TEMAC1			1
+#define TSN_TEMAC2			2
+
+/* PTP Timer Register Offsets (relative to timer base) */
+#define TSN_TIMER_RTC_OFFSET_NS		0x00000  /* RTC Nanoseconds Offset */
+#define TSN_TIMER_RTC_OFFSET_SEC_L	0x00008  /* RTC Seconds Offset - Low */
+#define TSN_TIMER_RTC_OFFSET_SEC_H	0x0000C  /* RTC Seconds Offset - High */
+#define TSN_TIMER_RTC_INCREMENT		0x00010  /* RTC Increment */
+#define TSN_TIMER_CURRENT_RTC_NS	0x00014  /* Current TOD Nanoseconds - RO */
+#define TSN_TIMER_CURRENT_RTC_SEC_L	0x00018  /* Current TOD Seconds Low - RO */
+#define TSN_TIMER_CURRENT_RTC_SEC_H	0x0001C  /* Current TOD Seconds High - RO */
+#define TSN_TIMER_INTERRUPT		0x00020  /* Interrupt register */
+
+/* PTP Timer bit masks and constants */
+#define TSN_TIMER_MAX_NSEC_SIZE		30
+#define TSN_TIMER_MAX_NSEC_MASK		GENMASK_ULL(TSN_TIMER_MAX_NSEC_SIZE - 1, 0)
+#define TSN_TIMER_MAX_SEC_SIZE		48
+#define TSN_TIMER_MAX_SEC_MASK		GENMASK_ULL(TSN_TIMER_MAX_SEC_SIZE - 1, 0)
+#define TSN_TIMER_INT_SHIFT		0
+#define TSN_TIMER_RTC_NS_SHIFT		20
+#define PULSESIN1PPS			128
+#define TSN_TIMER_GTX_CLK_FREQ		(125 * HZ_PER_MHZ)  /* 125 MHz */
+
+/* PTP Timer Register Base Offset */
+#define TSN_PTP_TIMER_OFFSET		0x12800
+
+/**
+ * struct tsn_ptp_timer - PTP timer private data
+ * @dev: Device pointer
+ * @regs: Base address of PTP timer registers
+ * @ptp_clock: PTP clock instance
+ * @ptp_clock_info: PTP clock information
+ * @reg_lock: Register access spinlock
+ * @irq: PTP timer interrupt number
+ * @pps_enable: PPS output enable flag
+ * @countpulse: Pulse counter for PPS generation
+ * @rtc_value: RTC increment value
+ */
+struct tsn_ptp_timer {
+	struct device *dev;
+	void __iomem *regs;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_clock_info;
+	spinlock_t reg_lock; /* Protect ptp register access */
+	int irq;
+	int pps_enable;
+	int countpulse;
+	u32 rtc_value;
+};
 
 /*
  * struct tsn_emac - TSN Ethernet MAC configuration structure
@@ -218,6 +271,8 @@ struct tsn_endpoint {
  * @tx_chans: Array of TX DMA channels
  * @rx_chans: Array of RX DMA channels
  * @num_emacs: Number of EMAC instances
+ * @ptp_timer: Global PTP timer shared by both EMACs
+ * @phc_index: PTP Hardware Clock index
  */
 struct tsn_priv {
 	struct platform_device *pdev;
@@ -240,6 +295,8 @@ struct tsn_priv {
 	struct tsn_dma_chan **tx_chans;
 	struct tsn_dma_chan **rx_chans;
 	u32 num_emacs;
+	struct tsn_ptp_timer ptp_timer;
+	int phc_index;
 };
 
 /**
@@ -310,4 +367,6 @@ int tsn_mdio_setup(struct tsn_emac *emac, struct device_node *mac_np);
 void tsn_mdio_teardown(struct tsn_emac *emac);
 int tsn_switch_init(struct platform_device *pdev);
 void tsn_switch_exit(struct platform_device *pdev);
+int tsn_ptp_timer_init(struct tsn_emac *emac, struct device_node *emac_np);
+void tsn_ptp_timer_exit(struct tsn_emac *emac);
 #endif /* XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
index 26a533e313a2..b7d7ba0de717 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
@@ -147,11 +147,46 @@ static void emac_get_drvinfo(struct net_device *ndev,
 	strscpy(ed->version, DRIVER_VERSION, sizeof(ed->version));
 }
 
+/**
+ * emac_get_ts_info - Get timestamping and PTP information
+ * @ndev: Pointer to net_device structure
+ * @info: Pointer to ethtool_ts_info structure
+ *
+ * This function provides hardware timestamping capabilities and
+ * PTP hardware clock index for ethtool -T command.
+ *
+ * Return: 0 on success
+ */
+static int emac_get_ts_info(struct net_device *ndev,
+			    struct kernel_ethtool_ts_info *info)
+{
+	struct tsn_emac *emac = netdev_priv(ndev);
+	struct tsn_priv *common = emac->common;
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
+			 BIT(HWTSTAMP_TX_ON);
+
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_ALL);
+
+	if (common->phc_index >= 0)
+		info->phc_index = common->phc_index;
+	else
+		info->phc_index = -1;
+
+	return 0;
+}
+
 static const struct ethtool_ops emac_ethtool_ops = {
 	.get_drvinfo	= emac_get_drvinfo,
 	.get_link	= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_ts_info		= emac_get_ts_info,
 };
 
 /**
@@ -235,10 +270,19 @@ int tsn_emac_init(struct platform_device *pdev)
 			}
 		}
 
+		/* PTP timer initialization - ONLY for MAC 1 */
+		if (emac->emac_num == TSN_TEMAC1) {
+			ret = tsn_ptp_timer_init(emac, emac_np);
+			if (ret) {
+				dev_err(dev, "Failed to initialize PTP timer for EMAC %d: %d\n",
+					emac->emac_num, ret);
+				goto err_teardown_mdio;
+			}
+		}
 		ret = register_netdev(ndev);
 		if (ret) {
 			dev_err(dev, "Failed to register net device for MAC %d\n", mac_id);
-			goto err_teardown_mdio;
+			goto err_remove_ptp;
 		}
 
 		common->emacs[array_idx] = emac;
@@ -246,6 +290,9 @@ int tsn_emac_init(struct platform_device *pdev)
 		common->num_emacs = array_idx;
 		continue;
 
+err_remove_ptp:
+		if (emac->emac_num == TSN_TEMAC1)
+			tsn_ptp_timer_exit(emac);
 err_teardown_mdio:
 		if (emac->phy_node)
 			tsn_mdio_teardown(emac);
@@ -275,6 +322,8 @@ int tsn_emac_init(struct platform_device *pdev)
 		dev_info(dev, "Cleaning up MAC %u (array[%d])\n", old->emac_num, array_idx);
 
 		unregister_netdev(old->ndev);
+		if (old->emac_num == TSN_TEMAC1)
+			tsn_ptp_timer_exit(old);
 
 		if (old->phy_node) {
 			tsn_mdio_teardown(old);
@@ -314,6 +363,10 @@ void tsn_emac_exit(struct platform_device *pdev)
 		dev_info(dev, "Cleaning up MAC %u (array[%d])\n", emac->emac_num, i);
 
 		unregister_netdev(emac->ndev);
+
+		if (emac->emac_num == TSN_TEMAC1)
+			tsn_ptp_timer_exit(emac);
+
 		if (emac->phy_node) {
 			tsn_mdio_teardown(emac);
 			of_node_put(emac->phy_node);
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_clock.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_clock.c
new file mode 100644
index 000000000000..1f6bc932fc6b
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_clock.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "xilinx_tsn.h"
+
+/**
+ * rtc_iow - Write to PTP RTC timer register
+ * @timer:	Pointer to TSN PTP timer structure
+ * @reg:	Register offset
+ * @val:	Value to write
+ *
+ * This function writes the desired value into the corresponding TSN
+ * PTP register.
+ */
+static inline void rtc_iow(struct tsn_ptp_timer *timer, u32 reg, u32 val)
+{
+	iowrite32(val, timer->regs + reg);
+}
+
+/**
+ * rtc_ior - Read from PTP RTC timer register
+ * @timer:	Pointer to TSN PTP timer structure
+ * @reg:	Register offset
+ *
+ * This function reads a value from the corresponding TSN PTP
+ * register.
+ *
+ * Return:	Register value
+ */
+static inline u32 rtc_ior(struct tsn_ptp_timer *timer, u32 reg)
+{
+	return ioread32(timer->regs + reg);
+}
+
+/**
+ * tsn_tod_read - Read current time-of-day from RTC timer
+ * @timer:	Pointer to TSN PTP timer structure
+ * @ts:		Pointer to timespec64 to store current time
+ *
+ * Reads the 64-bit seconds (high + low) and nanoseconds from the RTC current
+ * time registers. Values are masked to valid ranges.
+ */
+static void tsn_tod_read(struct tsn_ptp_timer *timer,
+			 struct timespec64 *ts)
+{
+	u32 secl, sech, nsec;
+
+	nsec = rtc_ior(timer, TSN_TIMER_CURRENT_RTC_NS);
+	secl = rtc_ior(timer, TSN_TIMER_CURRENT_RTC_SEC_L);
+	sech = rtc_ior(timer, TSN_TIMER_CURRENT_RTC_SEC_H);
+
+	ts->tv_sec = (((u64)sech << 32) | secl) & TSN_TIMER_MAX_SEC_MASK;
+	ts->tv_nsec = nsec & TSN_TIMER_MAX_NSEC_MASK;
+}
+
+/**
+ * tsn_rtc_offset_write - Write time offset to RTC offset registers
+ * @timer:	Pointer to TSN PTP timer structure
+ * @ts:		Pointer to timespec64 with offset value to write
+ *
+ */
+static void tsn_rtc_offset_write(struct tsn_ptp_timer *timer,
+				 const struct timespec64 *ts)
+{
+	rtc_iow(timer, TSN_TIMER_RTC_OFFSET_SEC_H, upper_32_bits(ts->tv_sec));
+	rtc_iow(timer, TSN_TIMER_RTC_OFFSET_SEC_L, lower_32_bits(ts->tv_sec));
+	rtc_iow(timer, TSN_TIMER_RTC_OFFSET_NS, ts->tv_nsec);
+}
+
+/**
+ * tsn_rtc_offset_read - Read time offset from RTC offset registers
+ * @timer:	Pointer to TSN PTP timer structure
+ * @ts:		Pointer to timespec64 to store offset value
+ *
+ * Reads the current RTC offset value from the offset registers.
+ * Values are masked to valid ranges.
+ */
+static void tsn_rtc_offset_read(struct tsn_ptp_timer *timer,
+				struct timespec64 *ts)
+{
+	u32 secl, sech, nsec;
+
+	secl = rtc_ior(timer, TSN_TIMER_RTC_OFFSET_SEC_L);
+	sech = rtc_ior(timer, TSN_TIMER_RTC_OFFSET_SEC_H);
+	nsec = rtc_ior(timer, TSN_TIMER_RTC_OFFSET_NS);
+
+	ts->tv_sec = (((u64)sech << 32) | secl) & TSN_TIMER_MAX_SEC_MASK;
+	ts->tv_nsec = nsec & TSN_TIMER_MAX_NSEC_MASK;
+}
+
+/**
+ * tsn_ptp_adjfine - Adjust PTP clock frequency
+ * @ptp:	Pointer to PTP clock info structure
+ * @scaled_ppm:	Frequency adjustment in scaled parts-per-million
+ *
+ * Adjusts the RTC increment value to fine-tune the clock frequency.
+ * Uses adjust_by_scaled_ppm() helper to calculate the new increment value
+ * based on the base RTC value (calculated from 125 MHz GTX clock).
+ *
+ * Return:	0 on success
+ */
+static int tsn_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct tsn_ptp_timer *timer = container_of(ptp,
+						   struct tsn_ptp_timer,
+						   ptp_clock_info);
+	u32 incval;
+
+	incval = adjust_by_scaled_ppm(timer->rtc_value, scaled_ppm);
+	rtc_iow(timer, TSN_TIMER_RTC_INCREMENT, incval);
+
+	return 0;
+}
+
+/**
+ * tsn_ptp_adjtime - Adjust PTP clock time by offset
+ * @ptp:	Pointer to PTP clock info structure
+ * @delta:	Time offset in nanoseconds (positive or negative)
+ *
+ * Adjusts the RTC time by adding the specified delta offset.
+ * Reads the current offset, adds the delta to it, and writes back.
+ *
+ * Return:	0 on success
+ */
+static int tsn_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct tsn_ptp_timer *timer = container_of(ptp, struct tsn_ptp_timer,
+						   ptp_clock_info);
+	struct timespec64 now, then = ns_to_timespec64(delta);
+
+	guard(spinlock_irqsave)(&timer->reg_lock);
+
+	tsn_rtc_offset_read(timer, &now);
+	now = timespec64_add(now, then);
+	tsn_rtc_offset_write(timer, &now);
+
+	return 0;
+}
+
+/**
+ * tsn_ptp_gettime - Get current PTP clock time
+ * @ptp:	Pointer to PTP clock info structure
+ * @ts:		Pointer to timespec64 to receive current time
+ *
+ * Reads the current time-of-day from the RTC timer.
+ *
+ * Return:	0 on success
+ */
+static int tsn_ptp_gettime(struct ptp_clock_info *ptp,
+			   struct timespec64 *ts)
+{
+	struct tsn_ptp_timer *timer = container_of(ptp, struct tsn_ptp_timer,
+						   ptp_clock_info);
+
+	guard(spinlock_irqsave)(&timer->reg_lock);
+	tsn_tod_read(timer, ts);
+
+	return 0;
+}
+
+/**
+ * tsn_ptp_settime - Set PTP clock time
+ * @ptp:	Pointer to PTP clock info structure
+ * @ts:		Pointer to timespec64 with new time to set
+ *
+ * Return:	0 on success, -EINVAL for invalid timestamp
+ */
+static int tsn_ptp_settime(struct ptp_clock_info *ptp,
+			   const struct timespec64 *ts)
+{
+	struct tsn_ptp_timer *timer = container_of(ptp, struct tsn_ptp_timer,
+						   ptp_clock_info);
+	struct timespec64 delta, tod, offset;
+
+	if (!ts || ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	guard(spinlock_irqsave)(&timer->reg_lock);
+
+	/* Zero the offset first */
+	offset.tv_sec = 0;
+	offset.tv_nsec = 0;
+	tsn_rtc_offset_write(timer, &offset);
+
+	/* Get current timer value */
+	tsn_tod_read(timer, &tod);
+
+	/* Calculate delta */
+	delta = timespec64_sub(*ts, tod);
+
+	/* Don't write negative offset */
+	if (delta.tv_sec < 0 || (delta.tv_sec == 0 && delta.tv_nsec < 0)) {
+		delta.tv_sec = 0;
+		delta.tv_nsec = 0;
+	}
+
+	tsn_rtc_offset_write(timer, &delta);
+
+	return 0;
+}
+
+/**
+ * tsn_ptp_enable - Enable or disable PPS output
+ * @ptp:	Pointer to PTP clock info structure
+ * @rq:		Pointer to PTP clock request
+ * @on:		1 to enable, 0 to disable
+ *
+ * Enables or disables the PPS (pulse-per-second) event delivery.
+ * The TSN IP generates 128 pulses per second, and this function controls
+ * whether those pulses are reported to the PTP subsystem via ptp_clock_event().
+ * Only supports PTP_CLK_REQ_PPS request type.
+ *
+ * Return:	0 on success, -EOPNOTSUPP for unsupported request types
+ */
+static int tsn_ptp_enable(struct ptp_clock_info *ptp,
+			  struct ptp_clock_request *rq, int on)
+{
+	struct tsn_ptp_timer *timer = container_of(ptp, struct tsn_ptp_timer,
+						   ptp_clock_info);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		timer->pps_enable = on ? 1 : 0;
+		return 0;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * tsn_ptp_timer_isr - PTP timer interrupt handler
+ * @irq:	Interrupt number
+ * @priv:	Pointer to tsn_ptp_timer structure
+ *
+ * Handles PTP timer interrupts for PPS (pulse-per-second) events.
+ * The TSN IP generates 128 pulses per second. This ISR counts those pulses
+ * and delivers a PTP_CLOCK_PPS event once per second (every 128 pulses) if
+ * PPS is enabled via tsn_ptp_enable().
+ *
+ * Return:	IRQ_HANDLED
+ */
+static irqreturn_t tsn_ptp_timer_isr(int irq, void *priv)
+{
+	struct tsn_ptp_timer *timer = priv;
+	struct ptp_clock_event event;
+
+	event.type = PTP_CLOCK_PPS;
+
+	timer->countpulse++;
+	if (timer->countpulse >= PULSESIN1PPS) {
+		timer->countpulse = 0;
+		if (timer->ptp_clock && timer->pps_enable)
+			ptp_clock_event(timer->ptp_clock, &event);
+	}
+
+	/* Clear interrupt */
+	rtc_iow(timer, TSN_TIMER_INTERRUPT, BIT(TSN_TIMER_INT_SHIFT));
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tsn_ptp_timer_init - Initialize PTP timer and register PHC
+ * @emac:	Pointer to TSN EMAC structure
+ * @emac_np:	Pointer to EMAC device tree node
+ *
+ * The PTP timer is shared globally - only initialized once for TEMAC1.
+ * TEMAC2 will skip initialization and share the same PHC index.
+ *
+ * Return:	0 on success, negative error code on failure
+ */
+int tsn_ptp_timer_init(struct tsn_emac *emac, struct device_node *emac_np)
+{
+	struct tsn_priv *common = emac->common;
+	struct tsn_ptp_timer *timer = &common->ptp_timer;
+	struct device *dev = common->dev;
+	struct timespec64 ts;
+	int ret;
+
+	if (timer->ptp_clock) {
+		dev_info(dev, "PTP timer already initialized (PHC: %d)\n",
+			 common->phc_index);
+		return 0;
+	}
+
+	memset(timer, 0, sizeof(*timer));
+	timer->dev = dev;
+	timer->irq = -1;
+
+	timer->regs = emac->regs + TSN_PTP_TIMER_OFFSET;
+
+	spin_lock_init(&timer->reg_lock);
+
+	timer->irq = of_irq_get_byname(emac_np, "interrupt_ptp_timer");
+	if (timer->irq < 0) {
+		timer->irq = platform_get_irq_byname(common->pdev, "interrupt_ptp_timer");
+		if (timer->irq < 0) {
+			dev_err(dev, "Failed to get PTP timer interrupt: %d\n",
+				timer->irq);
+			ret = timer->irq;
+			goto err_cleanup;
+		}
+	}
+
+	ret = devm_request_irq(dev, timer->irq, tsn_ptp_timer_isr, 0,
+			       "tsn_ptp_timer", timer);
+	if (ret) {
+		dev_err(dev, "Failed to request PTP timer IRQ %d: %d\n",
+			timer->irq, ret);
+		goto err_cleanup;
+	}
+
+	/* Setup PTP clock info */
+	timer->ptp_clock_info.owner = THIS_MODULE;
+	snprintf(timer->ptp_clock_info.name,
+		 sizeof(timer->ptp_clock_info.name), "TSN PTP");
+	timer->ptp_clock_info.max_adj = 999999999;
+	timer->ptp_clock_info.n_ext_ts = 0;
+	timer->ptp_clock_info.pps = 1;
+	timer->ptp_clock_info.adjfine = tsn_ptp_adjfine;
+	timer->ptp_clock_info.adjtime = tsn_ptp_adjtime;
+	timer->ptp_clock_info.gettime64 = tsn_ptp_gettime;
+	timer->ptp_clock_info.settime64 = tsn_ptp_settime;
+	timer->ptp_clock_info.enable = tsn_ptp_enable;
+
+	/* Register PTP clock */
+	timer->ptp_clock = ptp_clock_register(&timer->ptp_clock_info, dev);
+	if (IS_ERR(timer->ptp_clock)) {
+		ret = PTR_ERR(timer->ptp_clock);
+		dev_err(dev, "Failed to register PTP clock: %d\n", ret);
+		timer->ptp_clock = NULL;
+		goto err_cleanup;
+	}
+
+	/* In the TSN IP Core, RTC clock is connected to gtx_clk which is
+	 * 125 MHz. This is specified in the TSN PG and is not configurable.
+	 *
+	 * Calculating the RTC Increment Value once and storing it in
+	 * timer->rtc_value to prevent recalculating it each time the PTP
+	 * frequency is adjusted in xlnx_ptp_adjfine()
+	 */
+	timer->rtc_value = (div_u64(NSEC_PER_SEC, TSN_TIMER_GTX_CLK_FREQ) <<
+			    TSN_TIMER_RTC_NS_SHIFT);
+
+	rtc_iow(timer, TSN_TIMER_RTC_INCREMENT, timer->rtc_value);
+
+	ts = ktime_to_timespec64(ktime_get_real());
+	tsn_ptp_settime(&timer->ptp_clock_info, &ts);
+
+	/* Store PHC index */
+	common->phc_index = ptp_clock_index(timer->ptp_clock);
+
+	dev_info(dev, "PTP timer initialized (PHC: %d, IRQ: %d, offset: 0x%x)\n",
+		 common->phc_index, timer->irq, TSN_PTP_TIMER_OFFSET);
+
+	return 0;
+
+err_cleanup:
+	timer->irq = -1;
+	common->phc_index = -1;
+	return ret;
+}
+
+/**
+ * tsn_ptp_timer_exit - Cleanup PTP timer and unregister PHC
+ * @emac:	Pointer to TSN EMAC structure
+ *
+ * Unregisters the PTP clock from the kernel PTP subsystem and
+ * cleans up the PTP timer state. Sets phc_index back to -1.
+ * The interrupt is automatically freed by devm_request_irq().
+ */
+void tsn_ptp_timer_exit(struct tsn_emac *emac)
+{
+	struct tsn_priv *common = emac->common;
+	struct tsn_ptp_timer *timer = &common->ptp_timer;
+
+	if (!timer->ptp_clock)
+		return;
+
+	ptp_clock_unregister(timer->ptp_clock);
+	dev_info(common->dev, "PTP timer unregistered (PHC: %d)\n",
+		 common->phc_index);
+
+	timer->ptp_clock = NULL;
+	common->phc_index = -1;
+}
-- 
2.25.1


