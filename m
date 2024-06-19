Return-Path: <netdev+bounces-105027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26990F757
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E641C20BF3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31851422A2;
	Wed, 19 Jun 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MLEIOLRW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE674E09;
	Wed, 19 Jun 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827565; cv=fail; b=dMtdxpaguyTZZ6ldGrM5oJbr1r041c5ZEnfUWthboQVQVCEABd7GwuWWe/M0aM/4hukG797AnLKj4xHk1YhluV+p+KWLiSrHDDzK8EJbqnvlZrNjtd8n+WqBbKoyr7k30Zb165hSHMha0htE5PF3gp7wJh7bfIcWRIXbkV5M95w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827565; c=relaxed/simple;
	bh=Oh7wKNN6jayplrPEEk7JQYaez20MeyG48j0bge0AZws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdHBSZ0W8wjhV4yp0X0hYJR65nLF7wS9y3ov8/kpWAawzmjXLYG2tEgz2vXIxHdfZCMyb2qmRCKyWMT00XfbkmN0PbrOAApa5XHTOMipu1W07/5GNWkae/mfEMJMERA5DFLUU4UywPFVa2KkGIgflMM12wqYpG6SuG7sA1Y00ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MLEIOLRW; arc=fail smtp.client-ip=40.107.92.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/f/JIC0eklErrD5Nkj1k/v0eQ29HRkWQDBVIcm1HanfJ25CNQRzwKuIdvgUORoEoPBLIaC5YNi9SDxRZCxDgJ2AnCTRLjvDnQF49sF5Q2BZytt17n2n1ibK+QKRbpOMFd18mIRFZ+/V1WzkEXW9qcuikWzWiy+Eu4GNGB8+1e427k8vNGT1Z0L2VrjzWYZKm1+Vnq/dtZ/Y3DN8Hx8ABY6P/nTAl1T47BWnlayS5A5xvvnaj9wY+1TzM64lZuDv6Sh4P/VGIKwak0oBGhy7uWxBgCXhyw5YN1dhyNIgp+v5KZ8T6caPx5ALPQ7YgH0fpg3b7rMv7lBnbWZ/5JgCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExYOcHeihOUtO1eJCCYKdu2oizyCOicy7jygqlkG5gI=;
 b=jeYsc64E4q7hNQmE7vAIVK64QGesE+Hkgoral9VtyTldjSKCJyOJqfASHNWfFqYVDlg02TQUeVB5FCHt7V2F0yCINbY+ze3Xwku0agIv4oGToETL2QGLSUwOzLlLV2S+sSbIk2M7PBxNqwrKgavg702qpzG7DWCdym1/kQIXdcQYE7utWsui7SZLD/ciahRpMTiTWhKQfrtGiOFpNj44QYYWBi2x5hbA3F6uEwwZEGCXMvAIgFI6aPJkuzGSqdsoDyUyEetTB98X9V2vDOuOsBPPmoOB4tluZB5y0nvYTOnR27k3FEKKmkvJpM6PQqefTN/J6PcELch2mC+U5nEewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExYOcHeihOUtO1eJCCYKdu2oizyCOicy7jygqlkG5gI=;
 b=MLEIOLRWQ+T0YpfRcxt0PQOkfQp6oxJK2siL28e30c5ORuto48KBtkQQYWjZUMdy0am7s1HpPfQ13hm2O672BqjE21JZJz+KgWJCikaGwj05jIaJ6DNDMU+JZcG8jcZ31BoMEL+ubvDK+x1gQKJ1vBhBnYwjpbqT2H/c/0gX9sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB7086.prod.exchangelabs.com (2603:10b6:408:14a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 20:05:59 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 20:05:59 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] MCTP over PCC
Date: Wed, 19 Jun 2024 16:05:49 -0400
Message-Id: <20240619200552.119080-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d809d0-ab88-46d6-0f99-08dc909b3cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|52116011|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?McfYlccKyupoIpzhJSFwgvnzeDk00i+N6qkOjb8h8Bab4CkSCCOoksNqj1dB?=
 =?us-ascii?Q?mmP/2Vhorse5U1lnFigU/InIg6tuoFp1WeOwA852T5iiclex9QdodxfJaX6G?=
 =?us-ascii?Q?dk2WvVOgXh0UXZhoVw9O73Ku8e+2m8cVmksq/JTFbPTyTbBZhskssWl4KDEj?=
 =?us-ascii?Q?5FmoukqXH6YYqyPMAm61PQj72/enokr4z6PSJJn14RnhpPIpoBwQR4FuO+MN?=
 =?us-ascii?Q?rRcBNGcSTSg8lUpdn+4DaBQrAYn22JDOqhKw9bvQaqON3Kg4SND4gECMUTmj?=
 =?us-ascii?Q?RK6/qYsPDp8T83V+EoY5uw40tSPyi7k04wQl8DhFynFFTPJ8/xiLXiOZszu8?=
 =?us-ascii?Q?qfnVVvx8NQ6ew/giyT9t0oRwTMnxPKnGQZF7TwePdUcE17akYNXD4tUEAFJo?=
 =?us-ascii?Q?oZ55/JR7QL/aMChh0HEQKNSua8ZffL7LNMy+6u8wfDCzBfTQDuB7hVdMiuwz?=
 =?us-ascii?Q?8bHKyjOn1KeiPAblQG/73n9VHwFa9YLnnfq+EYm3ZLq25kA0+GoAYJDeiVfM?=
 =?us-ascii?Q?37Uyijh5tT92lmXSIv5LuLDLvFFLQBGtMFUnW6I8Zyb0H5RV4r96Ch8IkEla?=
 =?us-ascii?Q?IpkBuE6YcyOsgiCQPmOD5LZT2Z3iFeaf72FpN+S2tcDyJvHrPTEO9qSzoIzr?=
 =?us-ascii?Q?FJKwNZvZ+uWOhYa1jIzMczzAG5UTpfPbqWSjfhhuC4Hs53iSe7Q1l+7FvKiT?=
 =?us-ascii?Q?G+vYncIzLgVFRSHlKRTpz8XsvYZ+TRLbqfNn9GxCpwOdCBaWJr9Ud9UZyBon?=
 =?us-ascii?Q?Xllw3jZlAu1/NdKgL745nCBAp+HEa+c1X2GFuUq8e2q4JSDiSnKJAqWLkBbO?=
 =?us-ascii?Q?3o2yPiwusF292VEIm74lDAVxUiwAgaTZxR6N4ycbbAwuMoPK2yj8qHVes8Cf?=
 =?us-ascii?Q?98SiewGuJ5btgWyoBEL5gYsIwyz6FWmFzKgK+j7kc/aBkysUHH2qRGVb76wi?=
 =?us-ascii?Q?Jo7izmheZQ41l5vcEcb5MuwrIk+iFMbVBT0EKlbUuET4YikSHEAlzDyhviF7?=
 =?us-ascii?Q?FPO/mGeEv3eWC1MyEwt+TEGRE9fR448xu01aPmyGeqxMmgv11SjvXwF0B8Aa?=
 =?us-ascii?Q?f+1BB/X/gurSAO7ulXDmED0cqLRoyxrzP5+HX8TxPh0L4W/EKN8BbZ5neyVw?=
 =?us-ascii?Q?EC8OI8pVg5caTXYji2F9PRcheTCZnGSA2m0w6bxazxOXV+fSRAnyVd7CB4vc?=
 =?us-ascii?Q?4Lqq/XCCYrqe2BKwH/YciD6q2WkAFChXl9xRrCzvtJM8B3SnJAesg1dw5P21?=
 =?us-ascii?Q?33AnucSibybEJijiv843R4HirzTK+SQwklz0fx7CJfdMKhgtVCAQB//n2Omz?=
 =?us-ascii?Q?s3JvKnQsBxcH9I/23DIwgh/Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7vwbb08360rxm1nfyTWQoNrZDb4f7uLFJSYSIn4/VXTlmDnIGLDvTbwOl6ng?=
 =?us-ascii?Q?1tHnqpY6JwJqjLTGcvxMkBJP3mht3Gw7CuZ7Jix4qAupXaRUY5venxgkKBRO?=
 =?us-ascii?Q?wyqy7K7lgQM9cptwHjMC2ybs8ULbxjj5pq/B7sM4kfpMdnseZwD6NsAg7e7/?=
 =?us-ascii?Q?Bih5Pmvre4bWCt4ynVCU68J5h+9mT/vx4DQWmbeEECk6AoTxhAWxdAM3qVzk?=
 =?us-ascii?Q?hx2fPNULdnEuSZoUQC/fGrvSrwsrVFj+E8iyIbG+MmMiS0PpWV+toj5z1arF?=
 =?us-ascii?Q?55I1qCQdQx5ephnqggnNj0MdaddBy0JfHRInbSewt71qnfb9HJpBqCfKMM5o?=
 =?us-ascii?Q?T8IXQs0GjsX+5eClWrUlRWJt8VkPGijn0rGCtJp9AJX9JQAJCXpIDHQ0m0PU?=
 =?us-ascii?Q?k+DOFoeBt+whIXOcBwKxaTEMnvcXo46YSfvtkhtCpFmnrCT9V46lzP5rjoQJ?=
 =?us-ascii?Q?4qUfs3/vE+6xqFLOyxoaGit06kfKQZoDdXkOJo+vQcS0tsq9DZ1nD47iV6/E?=
 =?us-ascii?Q?c+H6JHuTfIQ5pnFZcZ+BMJKunPftvwWnjXbyF1+FnW3G2eIrbg2LuYGxmKqS?=
 =?us-ascii?Q?+BD+jN+jD5HrJgPWWs1HngB5XDxWhLIrOaiLvB0X9HBw1VQWHx//6opWiR0l?=
 =?us-ascii?Q?RQvc+W5oAgAQ1mypRWZPEODbORfG/vkSF6pYbBgtBdNpDejg4HBOuGOBPOc8?=
 =?us-ascii?Q?2b/7pLqMez7J6XtZVQhL0tvi6fuZ4a5ljsJsAeY4vRiLEPPK5VI6ZYxt4hVf?=
 =?us-ascii?Q?MuZWjfIUVEAGPgOM5heVTReht0HSM8Irfdf2ohP1dCOiyRgJ+EyqqGm4TqM0?=
 =?us-ascii?Q?NRyKJSKlHIJuRZlq9Grn7S3mxrDVB9cwWPLexwkOvPR3Z7t+Mo6L3jkydTTv?=
 =?us-ascii?Q?Sqf9DajsrCkEG7y6uWjgDVc8Ne5hW152t2y00kYda03oJb2yVw04y3aPqxEv?=
 =?us-ascii?Q?JNBGCOGPmIrywIe70ICCuf9sGahY42Se5sVnEH2QKSFC4frmmu1lnWP8iJNY?=
 =?us-ascii?Q?tn0dpsJZJ8/gKsPAFvaHjVDMW/NqWVRv0adsIY9nrBQtpnmVFws86dDkadMU?=
 =?us-ascii?Q?ZR2f2HoyMgzKSGNXTPnvjHw0iJJq1UBmHCreP9LojuvBdMNpSetUZggZDK+q?=
 =?us-ascii?Q?wlMPvexpr8wjRPGTvfE3xU6GMpQ2F1xNExHUNGoGnYp5Vc+77ZzQrw+Y+xTa?=
 =?us-ascii?Q?6/R83W7cz8+IFDlToxjySIYBWCqSr5XuWsPhQ7/m8x1fumRlkABfvLslXMw2?=
 =?us-ascii?Q?HEynwFAApC4jphGJv6/yZJF+PrD6BnaHokbAXBh1qAikJFsyY8D2+UGy8V2A?=
 =?us-ascii?Q?jb4kQKukfTsiSTjcOPusZo8PmJIXaK996er3aj+89CR8LHdJLKTrC/M+IoFn?=
 =?us-ascii?Q?sxeEOAGaLot9FH1JzOZmOQ79+N0wPWiCCrX3dYpvZJhyiGZbLjSHrGYV/p46?=
 =?us-ascii?Q?nk80Q7cJHLe8NB4rOt4uOmEeNwZCTuBITm5D1hIDTyA1ZmiiAIXYf0fXbYdR?=
 =?us-ascii?Q?FLMv7IYn0j9H/ecuNkN0C7/CX2esE4YLHmWwzkJIzBAULMgNkZoQWtcgSKFl?=
 =?us-ascii?Q?wFW7j8WkaNqwYfV5DRF+TlEU2gxqrZ4m0z8VgjpehOBulb/pzgtFLs5Ot0t4?=
 =?us-ascii?Q?PzMrfXpKg1jV8kxfJQz8HMpEiXkrqDymEDG2zgIc7V1Ztpjeh6YvB8ABRbHm?=
 =?us-ascii?Q?pqP86g0Op6d6Err0mM6gaKifW2Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d809d0-ab88-46d6-0f99-08dc909b3cc4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:05:59.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zvlh2nS3uYMByeQzN8FY+5E/WfqVFVBVyjs89fZDKtAE0/5tGi6Z+dNuBEqnr+cdtV8FIbU1p3P7sAd4MwIlDgvwDyT85egqIzXAQ/bv4Vlwwbhdy7BzkfvduIh1lhtb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7086

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

MCTP defines a communication model intended to
facilitate communication between Management controllers
and other management controllers, and between Management
controllers and management devices

PCC is a mechanism for communication between components within
the  Platform.  It is a composed of shared memory regions,
interrupt registers, and status registers.

The MCTP over PCC driver makes use of two PCC channels. For
sending messages, it uses a Type 3 channel, and for receiving
messages it uses the paired Type 4 channel.  The device
and corresponding channels are specified via ACPI.

The first patch in the series implements a mechanism to allow the driver
to indicate whether an ACK should be sent back to the caller
after processing the interrupt.  This is an optional feature in
the PCC code, but has been made explicitly required in another driver.
The implementation here maintains the backwards compatibility of that
driver.

The second patch in the series is the required change from ACPICA
code that will be imported into the Linux kernel when synchronized
with the ACPICA repository. It ahs already merged there and will
be merged in as is.  It is included here so that the patch series
can run and be tested prior to that merge.

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Code Review Change not made

- Did not change the module init unload function to use the
  ACPI equivalent as they do not remove all devices prior
  to unload, leading to dangling references and seg faults.

Adam Young (3):
  mctp pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Allow PCC Data Type in MCTP resource.
  mctp pcc: Implement MCTP over PCC Transport

 drivers/acpi/acpica/rsaddr.c |   2 +-
 drivers/mailbox/pcc.c        |   5 +-
 drivers/net/mctp/Kconfig     |  13 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-pcc.c  | 373 +++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h           |   1 +
 6 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


