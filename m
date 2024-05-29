Return-Path: <netdev+bounces-99208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7A08D41EF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB62284954
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C015D5A3;
	Wed, 29 May 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="IY9okTJX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2139.outbound.protection.outlook.com [40.107.212.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B815ADBC
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024744; cv=fail; b=e9aZBDPe0TroKKRvCum8Ynw2oV96+q+/mLu42AZdLY9x4/HvYfCl290CwnpcuUFt0wZDklXF0w6hp8H2qiLswKD9faAgc2bMa2JwUAS5jhaw48YBpWFeyF4tDX6pibH6JQMduNWxq3QdJX0gu2XK0G1wYu5z2EOu0ZJIoDPODMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024744; c=relaxed/simple;
	bh=ak1iEY52P0VXqxlZ6Aawm2f5gIPI9QuybnWmbLOJsyE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sDYDJX9SCi946ND9R2psny/t/2DTiPpDe6d9LihOfM3stXqawLD8rqYPPIxCVypaONh6y4bwDzfg7p6Z7WLuyuUa7yRo5bPSKwUQVoBViTwhbT06St7qsYjPFuscMyA0eZfL2oXrRV0EuAI4CjEPLjlgFEbM/rvoxZPA+P6zK58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=IY9okTJX; arc=fail smtp.client-ip=40.107.212.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOdSv4Hg+bQDti32fw0M+rKnceQzOboAwwcHdXtmMpRkriQaJDCMAbLOQNdF2eM9/PHkhFHa5/LAR10P8lof/aH4WggNE/Ttzv78QtCNL8b7uybbpU6YzfLetmNO0AYLZwmQ3Ei4Yr68k47sk3q6zoFAbRAfmjNoZrlP8DuBujEFm1chMpQCZT6uBQC55R++r4C9GUsg46FHd8qmZRj7KR6X/uWYqZDrvb1UvUWDV8CqbpyPuE09z3lsl5YDk0r7yF1GCnySeq3wZZfN4qCWpBhFVG6FnQeZ+K5ZiggNA96J4iDYUkk0+NI6w8Tkjoavi1fvZLway+qIBwj41gKl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUZHHXm/9Sx3Y0nlYB09F931N0ZIQhVenrEpdt6daaI=;
 b=CP1JMPI71DixiB56Ftt+psfHm1pwK9peWTDvKDYdBx0+fKRZ1Z5VS+SV4xy7Ppe7Qfu1C8r9ksCOB/aqQBX1ITQxtMXLf1vEF7z7Qywc581jwmgmMXZG+Xwouixxg0N1uhzKTKF7MPL66G+fQzYEOVPrSJUsBcD1aLBBdf06OefLDQwuphAaeQa1Ojx4VnqxcP4j5t3ulGvO4kwAJ22UScyi9MiZE64xycNMjsU/pOp4H4AnJHp9eHGIDIxHz0/gpNGuZSrHcjZONHheK2FPvhW1UOKXiuRD0d/iM3Q+w0LQ4fnlhyma6P9w8DCgSwwtLNq7bI3vEsigVamd4JbtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUZHHXm/9Sx3Y0nlYB09F931N0ZIQhVenrEpdt6daaI=;
 b=IY9okTJXKrN30oJbSRnydP4Zus6LlJFMlWsVXGXyD0QMzXDwZPg4rqdhS7cVcLPWM5qb9z4R1tvuqu8yn91noaL4DiICkCjJKvPxkYQ9l2wXi8u7367s2L/N0EYSVx5VR+4mEi4g9DzkWZ+4mzZJQRs4wwuq3ECt9JnmoTQtCN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from PH7PR14MB5619.namprd14.prod.outlook.com (2603:10b6:510:1f4::21)
 by LV8PR14MB7648.namprd14.prod.outlook.com (2603:10b6:408:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 23:19:00 +0000
Received: from PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a]) by PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a%4]) with mapi id 15.20.7611.031; Wed, 29 May 2024
 23:18:59 +0000
From: Eric Kinzie <ekinzie@labn.net>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric H Kinzie <ekinzie@labn.net>,
	netdev@vger.kernel.org
Subject: [RFC net-next 0/2] MPLS point-to-multipoint
Date: Wed, 29 May 2024 19:18:43 -0400
Message-ID: <20240529231847.16719-1-ekinzie@labn.net>
X-Mailer: git-send-email 2.45.1.313.g3a57aa566a
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:610:55::18) To PH7PR14MB5619.namprd14.prod.outlook.com
 (2603:10b6:510:1f4::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR14MB5619:EE_|LV8PR14MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a02d340-4865-4f07-c16b-08dc8035b843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+ckxdprBute+UPbKBhwBhnsApPCU4nB7rLoRDEGliAz3Tde1jkcBchK/7Xj?=
 =?us-ascii?Q?P1mdp48zzFM9BI1C2VcDodwPFRYjZiRAMkO9XVWz4+AifWBtZ4IAPMM9pvka?=
 =?us-ascii?Q?9llketeC9+2SC4sDI2j8psl9hQTgW3XfgNutgVgXxBQWNS1gQHsXfLrm5oZG?=
 =?us-ascii?Q?d2dHR4hhrluZe8KobrAF0r/6b8wY36rJzXFWza4bljtT3m8Wqp4MV2RC0byQ?=
 =?us-ascii?Q?RZRgELRkT9yQh+tEzZx5+k2KSDOMvO9eIf4z3JMjjmPD8ieIqB+R2gjwZ08D?=
 =?us-ascii?Q?+yWpDSv7URco6KTudgeuiYXBSwpRZtZM0C2nFc96LK2oV9l1DTK1X12F3ZCL?=
 =?us-ascii?Q?TaDeJ5VKv5HgqN3sMW38U4JZQarXoFLaxx1HA5ShbMr7E0166g5YPzdIJxun?=
 =?us-ascii?Q?cynnEpIXOBAJu67k8KPpu+ukNuj5VCyUsgOb6STr/1rFeOSthbekFlgMpKBn?=
 =?us-ascii?Q?zqZblg+/9TNHU/A3NRFro8lpBNw+3JE6i2LDhuWANfAP6aMBSIZr1MxwTZfa?=
 =?us-ascii?Q?f2RBhTIXNbtdXSLdOjmxMirheZlxP0m+jx5kPnnSDQ7qMtyhWiXaYvZ6pEXF?=
 =?us-ascii?Q?D4Mug/prLr/AX4TZRVUuL6VL8FOF7B4ZCUoK97Ql4apKCJ5jTvYuutXtNdAO?=
 =?us-ascii?Q?Kal3gZK2SwcUWeIRhbIdPDGXfhnONEZGkfgrMqM9qNvas6ErGNsLvaBFyrue?=
 =?us-ascii?Q?odsALFa67kSbTxEkI1J20u5MqHMj9CYVs2AY8NPZjCd+mfE2GfUWU//BBRhc?=
 =?us-ascii?Q?clKvtWmipHMYxajxF3ohWt46qiQD5My5TgCDBNa4VSZ9Pof8BoR57HCv91RD?=
 =?us-ascii?Q?ZGlYG7BlcHpd7LhLtNTGBCxOgWUu/dHyoi1ikJIIn4XVVDYzP3GmQO7IFTQ0?=
 =?us-ascii?Q?dAWIdX98U6xwC7jeZ7sLziXiQc1PpX2T+e+/u5VwyMYOHtXwPD7cbiibb2s8?=
 =?us-ascii?Q?ox0PggndPNOiXDroIafuWz0d/+JTumx/WZb/9Y/E4XgvjlY4fduWaZ+l8bsy?=
 =?us-ascii?Q?JVV3xcqmdV287fUGkA8UEReHddvTxmP/ChvCHVUsCCVgnpjCYFPoUsynlfou?=
 =?us-ascii?Q?HP3rKoVRCR2AGuGgzhKPhyY0Uwm44r/6qv7MPq22NnGm1nBsNSExQPhN4B2s?=
 =?us-ascii?Q?26136C0sm/XkybMpxqyZ9HPBjZrINFCrJpB3hfk/545kG7/X8dQfljh5LLq6?=
 =?us-ascii?Q?d6C/KJJ2r6noa3KS3M+FlS3vwSqOzltpl6Dt3uFpWZk6GMl5Ri6FmslnzVls?=
 =?us-ascii?Q?aiXRKsNzz8CaEuRM44L5GWIFY+dntru6e0IW8Ahdog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5619.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7hwKkLVqLh2TDf1KbBo3ztxXVIfZIRGJwNvM8jhuAm8mlpYMeHt/LrrY55o?=
 =?us-ascii?Q?cK4+swl1DyuaBWCLSsc4Y0R586e/lmxDn8kCL3+9pNHmLoMeaA+AgEWq+Kbp?=
 =?us-ascii?Q?9JXm0RoYP6zZHZkVvTnxkufOJ2KCow7TmAvj6Nf5LzCXGe4Yrb67FSxV4SBg?=
 =?us-ascii?Q?pnrIp8C7KpYrEo0upMawm6KuAOc2eIB0ui2tm0/syKOzwi/gZcAdzuVyL/rm?=
 =?us-ascii?Q?uinBdLs524gZTKE7B85yHI7luUEJSQdaTN+LSm6ciVAAB+YWbZd+D+cU5kSe?=
 =?us-ascii?Q?roIIL/RzWFKMPgnBcaSH/QZMVfGCyKHOmsR8aOTYgzl6plmwfz1h2KssadQ4?=
 =?us-ascii?Q?oAAGLcBuO8xJjqOZXdtFTEqS/lm5G9gsWSrQ7X0UlpwfB+LEmO3vgU7xysKf?=
 =?us-ascii?Q?vLECsGOcgmef062ZPzA6oqnbzAC0+k5hFB2ghHQ7G1EdubSJBbi5CVGu5mzB?=
 =?us-ascii?Q?0/6XZeCkiJryvlDDorop1HwPBpu5DRz2Uuq+54QK41iOCox4uJdT/SRegPyJ?=
 =?us-ascii?Q?b1PjhKTSLtCrNNM44v9Dr2fSZ+NybaMl+49AGE8gC+Zbu+qnRZLXA621rAtE?=
 =?us-ascii?Q?62rIOW79JIKc81sw1vu6bIyP1HzL32KrCQ6IOZWVZY+piO9z8MRW8wgl0DfT?=
 =?us-ascii?Q?0uLBK9++suQrNPGiVixudhpmvsGSNNILIfkVUG4MUhkISY2ftHdpF4prfol+?=
 =?us-ascii?Q?nIql/AaPEP6f7L8Q4hIt/dkTIYHCNSQWK/WMDSs1Oy/KtTQBA9pZURRMBi6j?=
 =?us-ascii?Q?c1FPf4VR0k7IJGOvWcVnK/EbJxEWi1xQ4qjTsJUaEMVCJAkVhDlkICg+glB9?=
 =?us-ascii?Q?08+hN1wUKf/zkFPuJgXcgXEvOhZjGRkMFjOoTFSt+kxHn7jwnojW+J8C3GiQ?=
 =?us-ascii?Q?RwaxTajnUh9k4/0G3qdsBIWF1NlChyqTIdAlE8q7c7WSIzV5+koSrbgf5EGN?=
 =?us-ascii?Q?wcl1XvooC6ZVrWrKwcDdW49J/9l18D30j6nCqHXxtS1vH9LOLp6wfP4zd+ZQ?=
 =?us-ascii?Q?YwOA7afZNJAryhrT49tpDOFM/PYeKELtHe6uDadPCfztcfow8F5RzGOgNBr5?=
 =?us-ascii?Q?p26LH429F8yETKTZeEcUQjH415hdUkdtd1yprH9QW+7YhmG9dbByQNFDTbui?=
 =?us-ascii?Q?J5yMEnWgVDduF0OLr8FE6e/suifZZqGiGhwTb0SpmD0Q8qY4Hr2bw3Q8rs7J?=
 =?us-ascii?Q?tzrYxW9uuVogDW+QxcaKIUUzYXHEAzsEY6L5xHpdd8AGD/eFUObWccOtkJYM?=
 =?us-ascii?Q?w9WpeLMwwweMomo+cwqW5lT9Ia/bv/TGXwUZkrAubAKHBq6wjrDxfWqQy6kZ?=
 =?us-ascii?Q?9CU8vd7EOEd2Cj7W96+Qak1AUCJdXCYpcUrXrpRfHESC69stR7gPCL4b6mrd?=
 =?us-ascii?Q?j1qR6dDPeiIG4r/UcUgOaTABtIjiEi+EZU92ceVoOc7qOrsJbQsMQDjJNxqY?=
 =?us-ascii?Q?KRF/H8inrUf177xxq8CnnrDp75la56iR2v9ldu0Vgd8NI0CJOmaOPDh2IsEQ?=
 =?us-ascii?Q?k2WvFqStNH36bhLanNDFU+vNPknYNd8nJW++UeKHVqKxdn7UB8QmMCeXsIdi?=
 =?us-ascii?Q?UsjGxfvBkaMmDMzYQSMOqzHUwvsid2wGz/N8atDE?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a02d340-4865-4f07-c16b-08dc8035b843
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5619.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 23:18:59.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrbfBefziO4uoxi5v9otD54PHVpm2v76mveLRKp7NRnmJsA+ULpHtD475dIMAapHEpOFEElggDMzGwTOoOKMHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR14MB7648

From: Eric H Kinzie <ekinzie@labn.net>

This series introduces point-to-multipoint MPLS LSPs and fixes a bug
related to sending ARPs for MPLS-tagged packets.

ARP/ND: I fixed this problem where it was observed (arp_solicit()),
but I'm not sure if this is a good long-term solution.  Other options I
considered were (1) adjust ip[v6]_hdr() to make sure the outer header
is actually IP and (2) add a field to struct sk_buff to track layer
2.5 headers.  The first option might add overhead in places where it has
more impact than addressing the problem in ARP.  The second option, of
course, makes struct sk_buff bigger and more complicated, which doesn't
seem great, either.

P2MP: This splits up the mpls_forward() function to handle P2MP LSPs if
the route's multicast flag is set.  It uses the same array of next-hops in
struct mpls_route that a multipath configuration uses.  It is convenient
and I can't think of a use case for p2mp+multipath, but I'm curious if
there are reasons not to overload the next-hop array this way.


Eric H Kinzie (2):
  net: do not interpret MPLS shim as start of IP header
  net: mpls: support point-to-multipoint LSPs

 net/ipv4/arp.c      |  15 ++-
 net/ipv6/ndisc.c    |  13 ++-
 net/mpls/af_mpls.c  | 218 ++++++++++++++++++++++++++++++--------------
 net/mpls/internal.h |   6 +-
 4 files changed, 176 insertions(+), 76 deletions(-)

-- 
2.43.2


