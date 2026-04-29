Return-Path: <netdev+bounces-282379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP9nLH/+8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA149445F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EA3303DD78
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669433F9F2D;
	Wed, 29 Apr 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uL9X87Q1"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB873AA50A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466850; cv=fail; b=A32fOK/0sCReKkgd8RrCchEIg7cSTZ1i71yOMd6uDx8AsEonf1GTj8RgAFlcVapauQvsECcF96pCqnmjlwfVKXNXwdApyI/dD+jhm7LtoUtZXXzly6bOM/skinvgn0Htg3sJvoR9WAunP0LYoZyRTqHMH8nj/gaPpAyAqX4jXvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466850; c=relaxed/simple;
	bh=cog4EpdzvzbMWCKaWgooqliIlrLYzMLrTTkiqqE+mHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGGAU6sob0TFHayjZfZJPsM+GXwhzxa7Lvwe851pokvWgQvmf1mSId/uKOPSRd2AamfVHGo27q9cZ6w1VktDko8NxWlhzVcNCaPfO77p5i6/nRmaPKZWEELfZsmnQGRD6BG/xgXvBjYti6ObHsCESREBgB32n/lmZ2UivCO8Crs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uL9X87Q1; arc=fail smtp.client-ip=40.107.200.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njPNCww/LMI3S7LV9v88LNHfxuDTH03CsdETefH7w1YOvUoH+0kqXyt1vOwgx2G7v5wy5vPnBcr1/VkEE78klpE1AVZV7dy1HVTFjUbXapJB+beFoxKtgYGd1asC+1/Bs0CFetNjKNuvEZRpYS1J5DYLaw9IPQBVJkaPwd2119mGeyVnyc4Da31kpSwKDR6MQKSTndCgc3J9w+whsQFt/BTUxWaAjmwN64VTbLJObEHsb+Zbwa+VFmwYWXxz92MPrmWqULAaukEUZxrlZtUVj3xETgy0Vy8sJdCCH6MGEYWs2L7ExT7tbiNJej26dxtB/GWFKRBjkPfQnODmUTtvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMGfQv4+vvy+0wkfA0Q6BYVp2iEX8TJ18tdYwpHLKSk=;
 b=RREBvBL8bstMjj+clAf/XHwA4KYFU7i5A2rahcCtLhIuuRUXHIQUXbqjMtQwu/lFgUWJbcVAZnUgy+abuLXId2fORoPKg/wuyzdwepufy8buknGWej5Pz7egNnNIp2r6eNwfEsMhOovlTLP79myv1KeW7mMUDjvOR0iO3BcoxJOCM3mhcwmIspHDw5c55OrUYZkhjFX9n4WoQWYXo1NN8peHWCc4GnSkOHplXHXVA09c77cjDgJNnZERn+M7QrZUXFxl6ch+BjxRibYsu+UsYU9HRonpbokH7QcGTFH3ThnlQI0sI4DcS59xzdobuKIyJ14ZvOeVNp5aUUzcT1RYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMGfQv4+vvy+0wkfA0Q6BYVp2iEX8TJ18tdYwpHLKSk=;
 b=uL9X87Q1MOr711ZHbU5yh23ZF/Qd9ULUQEyqPLqWCLyql0ovSrQz3eCY7pdXbEtoR59Kjy0UfGe6Ij6eKOmtfioxwpxRwnm0Bb2M2TxFOznO5zvpg1isZI+NFeMtyO2FBQjVFLBuJDz3NkWP2+sG62fjDrw0UfKWFOR8QV+eNOr6bpG9Fu9OCPLKFKyq/3JanTaHpqpeJSAAERtlt1OBqibcRILr16BXEFDoJZeHhBqYF7e5cGBLvgB+r+cHvBs4tcKpVHJNamJjBO8tEdWExMdiGMcckafchCixfSlbSRhvdj5Y8E7G1Bku8xE/PVhNas3kEZpvAf7moVs7g/D0MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:47:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:47:24 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/3] selftests: net: Add protodown tests
Date: Wed, 29 Apr 2026 15:46:24 +0300
Message-ID: <20260429124624.835335-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429124624.835335-1-idosch@nvidia.com>
References: <20260429124624.835335-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ae5358-14b8-48d5-0046-08dea5ed764a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xoLFlS6xJafKTFJqNNWMisEAr9N4hcD8/ZzgxAAS39YGSTbKRjzFprB3hrfMdyQCI1kErdwsk6oZbrymcOQz8hzbrgIJ5bIzhX4XauORtry8c/82zKV0b7c3Wiafj4p/1X4u+HRWdXttzxPaiCaQIe08y+CfOD7CTivQmOBhs32QC2rGfR3pf36bb8YT/EUZRbcdiPXbH5DlPOQd+cXoHjHhfkRKQ/C/xndSys9t51NsQYJJhrKhG7sRKVixFHVD2mUaVf0yAuR7AJDwKkTcBFvTZq3+ug0GAM3cweHmnnLzcuNHh9wE6Sw7c8eBJY44gRqw2LmWyBpV3lQHOfoeGPvAKs3rrDyDBPjTQs+wA4292BJuQOFr2WWcRa0vrgqwrvsqJazKYXzROaHERP+ztqH6hRAWF5B07nXKGqf4UiMb2uf0UcGnRrBSamZhWf6/jbxDHKajiW0ZiFXxyplR7qRWP0gjO9lvaYLu69VKCuRGApMpyFpTnSFPP1kw7Mw+Ou6lSS6HcsaDcNDM4H2paLEA0PtD0mU2QX4bTyaw/AfY6RlwYy8l3G9/6lIjNGtzGb26ORs0ID86Msn4S+BdURv7HoC3Zq/3WyGaD3Kfj6OWTIzC22PxeqYsOb8U5MdcwLn/UafOSY0TGBUsnZuDM6guC2ytoea4eyFQKhSLOP81RORQsJx29jAgjSfIGZmf8Llfa7TLCFV3GhR0OTIqEsOh7SbJPK6HWARDRVMyyp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJ0seUdFFDmcaaOhZ+feClbUr5IdVIzgiVOLdeNqYIjeFM0YDi+tFJ9QMOwK?=
 =?us-ascii?Q?hw++c3M7UYCvtID0gJOnLYFco2sSZ7r6QbgaZVxYtRp1kcZk156upeRzIAsu?=
 =?us-ascii?Q?xARlWmqz3h1I3HzhRDNfqMidp7+sNs0iJhv0kMgY/y1SgaZMIFOMqI73rJ+d?=
 =?us-ascii?Q?Y7fdORq1K65cx1qPGojx/10nBxxzjiIKMO4YKUTEOEKWnvcHjhzEMZKghcOK?=
 =?us-ascii?Q?0nG6wBUulnwzhmg6t0sEpyUbqqAyMg/PzkPgN1t+eaFfpy9iMO1Pf6lezts9?=
 =?us-ascii?Q?8eINuAdMLx4wHFjcHPW2+Y4FebWw7k1oLL4GZNiCbPIOyaICdENY1q6XdTNO?=
 =?us-ascii?Q?tOOHZaQZbHGX+uHScwvgrrYH5BtKC9ER+qJYxhMhQRNR3BznhdLxZxqsQBZg?=
 =?us-ascii?Q?TPgw0vddVgxLIPg0kBmrOqZ94RwdNrcXyaV6twY6iHXFOZq5f/41lKfrQjlL?=
 =?us-ascii?Q?JSiKdXZOC+ZX1aoLLP1xoocIhtcAjlhJ2R6eGsvO5uiX6BN9dbbsE36wNQB0?=
 =?us-ascii?Q?IZ1qtVeWFbLG3xuc1fZSllgXYe1DJXkppJOuhX6GVXfFjdM+k3nZ4UbS4zrD?=
 =?us-ascii?Q?dlkVpGQY5nQdnLuueMdfsnjDXrMS6kMQEFxw08mimRi4ftLM2YXUkkZedw7w?=
 =?us-ascii?Q?UZs/Lo1A4nnJ8UPPFacY4TTZakuXlD0I3VRMb+1FkAKys6hncZk++Ftd63Lo?=
 =?us-ascii?Q?mMBUGjzdAKNiF+pHMCv4LhdNPCJk6iynmas0Jfe+4RFIlPR9qRnuvA1lyMQZ?=
 =?us-ascii?Q?WOlcKhYO4aAunYCTTEF/YjHC7g+JtprtF2uDzyDsm7/KmacVrRBv7GAwPsHH?=
 =?us-ascii?Q?GawfV3GLLpZZQycsgeXG8jAizwIwHlPaY0Af/1f3le3WvlesHZERF/hufOf/?=
 =?us-ascii?Q?9P0CrBol83TIuXdDJZfG+laqOOD9a/zYqrAuaMACUKdNEVEew4USc+DeJzcv?=
 =?us-ascii?Q?U/FS6ldXb5G5gTgkcwa3rJqSbz9EZs8fhikBsoIx5sCiX1Q0RUXoGRr6IUjv?=
 =?us-ascii?Q?2wxehm9gWrWNswOqCiATXktwWxGHvKIBSEddbxBDadn1gk2p3mkrrtoCtguo?=
 =?us-ascii?Q?Gz5BdkaPkWY6o/Bp99OxcC929KZPRyJZfkePAiozO30POF+dG0MmNnnnOfGL?=
 =?us-ascii?Q?BbuqA3jkuGwxFynffReeAuREaBPCmavqbo3cCAXk2G1mjzmC+RWtUsFOaKpZ?=
 =?us-ascii?Q?zWXmeWFx5Z6RrzTsH+D32ue+FAIU5DV3ijzcW2VbAk3C1I4NGP0TB9nuoPm4?=
 =?us-ascii?Q?zUJZggclDLmFmxNqFGF//UceGYFCDJoqPdmF3qdt+xA0HllJmsl1zVYrLzr3?=
 =?us-ascii?Q?yoEJgNKjkenrr+VVWciQ7smmWNzH8jE0GY6O3OZVjUWNcaaWKe+kb1pYUgjH?=
 =?us-ascii?Q?wsPtlW9OyyBy4XkRHor6hklaMk8C+5RxwWYKpgog3TyZKfqY4JTD8JB4PuAY?=
 =?us-ascii?Q?NSPbLjuCkzTmVXPO2fmGO25cWacfwSFJD84z+EZge+/yfYA0AiDuP3M/vdnp?=
 =?us-ascii?Q?tY1AcUqyU2he6lj6O+tqs3fE+RceLQ84ko69jZhjHyf9ZOZKvFvOslEGiYic?=
 =?us-ascii?Q?HGtfiLc3KEOlEr+OwFScJHOzSaa9qpbQjVKHsguSv38gNZq6uNrki/ITGbEW?=
 =?us-ascii?Q?PNabpK7PmNVo3r4t+7BxBwnV3JI/JTkIFBDnusXCAMTUODXa+6a+3HTO9qAu?=
 =?us-ascii?Q?Jx0yezdVIAzP0tso/riSWW7J/OeqwNPkzgx3UwmA59myklPa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ae5358-14b8-48d5-0046-08dea5ed764a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:47:24.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2o0fybyjN8hEmZFLT/m1GW531rCbz7wH3rC2cmWqEqmrelP3RQFeSvyvMwnXuPesPs0IdBPh9qS6YY52d8UNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
X-Rspamd-Queue-Id: 39EA149445F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282379-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,protodown.sh:url]

Add a selftest for the protodown mechanism using a macvlan device on
top of a dummy device.

Four test cases are included:

1. Basic protodown toggling: Verify that setting protodown results in
   DOWN operational state and clearing it restores UP.

2. Protodown reasons: Verify that protodown cannot be cleared while
   there are active protodown reasons, but can be cleared once all
   reasons are removed.

3. Operational state inheritance: Verify that toggling the lower
   device's carrier while protodown is on does not cause the macvlan to
   inherit the UP operational state.

4. Lower layer down: Verify that toggling protodown while the lower
   device has no carrier does not cause the macvlan to transition to UP
   operational state.

Note that the last two test cases fail without "macvlan: Do not transfer
operational state when protodown is enabled" and "net: Add
.ndo_clear_proto_down":

 # ./protodown.sh
 TEST: Basic protodown on/off                                        [ OK ]
 TEST: Protodown reasons                                             [ OK ]
 TEST: Inheriting operational state with protodown                   [FAIL]
         Macvlan operational state is not DOWN despite protodown
 TEST: Protodown with lower layer down                               [FAIL]
         Macvlan is not LOWERLAYERDOWN after clearing protodown

Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/protodown.sh | 160 +++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100755 tools/testing/selftests/net/protodown.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..70e0ab43dc5d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -69,6 +69,7 @@ TEST_PROGS := \
 	nl_netdev.py \
 	nl_nlctrl.py \
 	pmtu.sh \
+	protodown.sh \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
diff --git a/tools/testing/selftests/net/protodown.sh b/tools/testing/selftests/net/protodown.sh
new file mode 100755
index 000000000000..4ad795d3d011
--- /dev/null
+++ b/tools/testing/selftests/net/protodown.sh
@@ -0,0 +1,160 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test the "protodown" mechanism. Verify basic protodown toggling, protodown
+# reasons, operational state inheritance when the lower device carrier changes,
+# and correct operational state when the lower device has no carrier.
+
+# shellcheck disable=SC1091,SC2034,SC2154,SC2317
+source lib.sh
+
+require_command jq
+
+ALL_TESTS="
+	protodown_basic
+	protodown_reasons
+	protodown_inherit_operstate
+	protodown_lower_layer_down
+"
+
+operstate_get()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip -n "$ns" -j link show dev "$dev" | jq -r '.[].operstate'
+}
+
+operstate_check()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+	local expected=$1; shift
+
+	local current
+	current=$(operstate_get "$ns" "$dev")
+
+	[ "$current" = "$expected" ]
+}
+
+setup_prepare()
+{
+	setup_ns NS
+	defer cleanup_all_ns
+
+	ip -n "$NS" link add name dummy0 type dummy
+	ip -n "$NS" link set dev dummy0 up
+
+	ip -n "$NS" link add name macvlan0 link dummy0 type macvlan mode bridge
+	ip -n "$NS" link set dev macvlan0 up
+}
+
+protodown_basic()
+{
+	RET=0
+
+	ip -n "$NS" link set dev macvlan0 protodown on
+	check_err $? "Failed to set protodown on"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 DOWN
+	check_err $? "Operational state is not DOWN after setting protodown"
+
+	ip -n "$NS" link set dev macvlan0 protodown off
+	check_err $? "Failed to set protodown off"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 UP
+	check_err $? "Operational state is not UP after clearing protodown"
+
+	log_test "Basic protodown on/off"
+}
+
+protodown_reasons()
+{
+	RET=0
+
+	ip -n "$NS" link set dev macvlan0 protodown on
+
+	ip -n "$NS" link set dev macvlan0 protodown_reason 0 on
+	check_err $? "Failed to set protodown reason bit 0"
+
+	# Cannot clear protodown while reasons are active.
+	ip -n "$NS" link set dev macvlan0 protodown off 2>/dev/null
+	check_fail $? "Clearing protodown succeeded with active reasons"
+
+	ip -n "$NS" link set dev macvlan0 protodown_reason 0 off
+	check_err $? "Failed to clear protodown reason bit 0"
+
+	# Can clear protodown when no reasons are active.
+	ip -n "$NS" link set dev macvlan0 protodown off
+	check_err $? "Failed to clear protodown with no active reasons"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 UP
+	check_err $? "Operational state is not UP after clearing protodown"
+
+	log_test "Protodown reasons"
+}
+
+protodown_inherit_operstate()
+{
+	RET=0
+
+	ip -n "$NS" link set dev macvlan0 protodown on
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 DOWN
+	check_err $? "Operational state is not DOWN after setting protodown"
+
+	# Toggle carrier on the lower device. The macvlan should stay DOWN
+	# because protodown is on.
+	ip -n "$NS" link set dev dummy0 carrier off
+	ip -n "$NS" link set dev dummy0 carrier on
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" dummy0 UP
+	check_err $? "Lower device is not UP after carrier on"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 DOWN
+	check_err $? "Macvlan operational state is not DOWN despite protodown"
+
+	# Clear protodown and verify the macvlan comes back up.
+	ip -n "$NS" link set dev macvlan0 protodown off
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 UP
+	check_err $? "Operational state is not UP after clearing protodown"
+
+	log_test "Inheriting operational state with protodown"
+}
+
+protodown_lower_layer_down()
+{
+	RET=0
+
+	# Bring the lower device carrier down first.
+	ip -n "$NS" link set dev dummy0 carrier off
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 LOWERLAYERDOWN
+	check_err $? "Macvlan is not LOWERLAYERDOWN with lower carrier off"
+
+	# Toggle protodown on and off while lower has no carrier. The macvlan
+	# should not transition to UP.
+	ip -n "$NS" link set dev macvlan0 protodown on
+	check_err $? "Failed to set protodown on"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 LOWERLAYERDOWN
+	check_err $? "Macvlan is not LOWERLAYERDOWN after setting protodown"
+
+	ip -n "$NS" link set dev macvlan0 protodown off
+	check_err $? "Failed to set protodown off"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 LOWERLAYERDOWN
+	check_err $? "Macvlan is not LOWERLAYERDOWN after clearing protodown"
+
+	log_test "Protodown with lower layer down"
+
+	ip -n "$NS" link set dev macvlan0 protodown off
+	ip -n "$NS" link set dev dummy0 carrier on
+}
+
+trap defer_scopes_cleanup EXIT
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.53.0


