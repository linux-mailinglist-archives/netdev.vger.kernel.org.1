Return-Path: <netdev+bounces-284257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQ0ON+n+WnF+gIAu9opvQ
	(envelope-from <netdev+bounces-284257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADA4C88E9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5B03029253
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6E3E9F71;
	Tue,  5 May 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVpq/Bn7"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7013DD53C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969085; cv=fail; b=Nphrx0uSgaaZdoDQWsE+cDIGna7rDHTOD/oZr0px02r+CXIYhQmNC876PPaJnCSTaU2aP4IFoQvp+VgCWYbYa+otGQdIh6ibW99vskTWdKh/sag2SWwQd3k7k6CAkbbza74ixEYHewwHeXfaSFagEls7R333KcCVhAYfvSmCmbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969085; c=relaxed/simple;
	bh=2QXn5SZB+EbhxZoOV08ML1WpVrXBjsPjmRE3QFQwj1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4cY+mPH1pXESz9Cs108e6w1yFItP7DRdaVZj6vjRCFe/lCatFNioqEsXz8ryXs3J6JXiSzJBUTFFO33h3U1AWetJGlf8UoedS/iBYwV39R+mImFiHL1P9enhYP6RUB+2IJNBMALqwj8mbCUaaVHTzvr4MN2Mx7Vm0i2om00QKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVpq/Bn7; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oks2sHa/EqXRopduQL4aPkvBl+esLuvZFMLXcpcqqHGBf7KjrbfwYzeQ11X1O5oqAl45xaJBdCqDWzkCyORl4AAjul0lGsowhxxWg8eWcF0vz/z/rYyQSV9Oizs8DI4EmarqKH/sz5cvC/vYUiDovZVaFN5yrLYXD6FmBTlLHcy10wZKxcX+dmCxelZKXdLeb8i8LhVMprkb5yMIUYwe28cvvzS64JMM3jiNI24sPcSGdHralNgjUNJh/DA3crB5B0HlGvQK+8KMnWQz6nvMpBvp4QOMsgycXxpy6eGrJGOYIdWtbX8VsZTnNvckuJugsqKbjBLPa6IX2+FKbhqIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcGaDIoGhU2nEI9M7iGulUn2fm4v3hf7VujY+QfMOz0=;
 b=ljY6lb7Vb6EYMt4bvb8600C4BQWArKBWm3Ru085KvWbCuuv5GxtHVxVMSY9JgXgCjtcVhp8IZ5DDZTK9U6IdDkVrE5YVd3VPAjxDQmhxL3oE1V7JZv7A7ppmc9v1slOQ9MrYWepzYYe6p5XD1p7KCXbcdOPHJIY5y8wgE/Na01D7+6lWujGp8ZVVl7+8G1wKIK73Mud/QXOoBs6JqYIDoCmYmgQXlk+IT5L5/sC93vH2G4LWP4g3mFyQdunCNN0dBPCfreOllGl+Kx3PoUNAnYrYWXS5Fwc+sVCmKUDi2uw0OkXHuvO2shJh7LXj2bY4ri/Kfi7HOjfU+wkOuGsYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcGaDIoGhU2nEI9M7iGulUn2fm4v3hf7VujY+QfMOz0=;
 b=LVpq/Bn7O02MNHvsiWjySNvQwESYX5A00TO5rXjHAoADiyEROFatlmFSYKgIk5YG5mastGeCIrHMVh5uKlx2fuA3HoUQV5rA+9EKvS8V/XICqcMLAXP4CDRSZO3JCwnqfSbFExk5JIm7e693kSU+pwTmOEm8Q0Q5y9hpw4tlA9r8r4K/c5L31lpIsJMUrS3w/E+HuZLMS0r+L8yAlWraYGGWuOMV3Fm+iZJnJQZc1TARjn7Y/ULRPPhXjuRe9HU5uYoktC3TLEBltksqY45NmbVv6x7O5jF4Xhy9lzEtPdo4h7teACE6ia0cTRSrVINnaXyqh5AMlE8HSMbN4Mc3Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:18:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:18:00 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 3/3] selftests: net: Add protodown tests
Date: Tue,  5 May 2026 11:16:55 +0300
Message-ID: <20260505081656.463158-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505081656.463158-1-idosch@nvidia.com>
References: <20260505081656.463158-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d03e16-9731-4768-071d-08deaa7ed257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	23exasqInHCXFDbOdN0q2zA33KIMCmBCR4eTXpLeE1s+6FgH6aulvoj0R0AWvbZaldF3sf5nslW/hA0DJqukMdzqRlCg/tIRj1CM6vLL1AoSYifjB3hCMePw6viPP5G9QQlFOQt4TQRCIDQGB2eFEDv84OBy6i2q8unLcGWGKgKwOMVZZ0bKBHiesVExSz7EkuoRVpG9dmTyVPSiuCroVwrnxzy0H5f7Cun/JTUywRdIHaflej6evCEMEn5R0GFqo8I4fjbdApn/QYbxopRtDjCHYcQkqabTt9A20IkEL1orMmrF80hcyT7+4aGh+qC/sOyH7brhi2KFBNTl4GRSj1gYWcggLt0+WOUdK/JQ3N+I2PBfs2RtbyklKEJY14DG/CN2dwGxfYKcxNNZVNe00R1aHUQCZ/mWB+M3OZzCJagPor1lXO4eeVb2Kg/kX4tZUKSj8XeBrGe4gKVSGXkXkfcAteAiuKxkeud3YMSagVGdsB2tzOBm/Cw9QnJ6bzp8SwnD05fTttQL3xICyRCTqRWMwH8XAzfywIX7U3O8BP8ETKnUB+6Ve3ZITlCeZmkSV6+t0REUflloCxTmN9KF/qDs+ndRMw2Sm8ivDUUD808ZvtOs3LL5bh9Sg89KZafqiz5ew8k8jE1I+STtvUK1M99KL9eCpHdMAQkFfAqZ8HbmreoFzkJEwmyQz0JKtzUE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pnZlN9v3yO2lFR0bO88tpeP7NYVNyKbRy6A4z0qLAepsCTbFrrVYF0FRf0nk?=
 =?us-ascii?Q?jJQJINzd/oxQIpkNdBt/8YNbNKBzIF+pQ4k9QOYWuEVJHNfR9+hfMbZh9Xjj?=
 =?us-ascii?Q?lUoSniT6IHTf9ST3GGFtlTpQRBDXX0kvjpEJFtbbiBUW5lsRXbtPa3ptaHY5?=
 =?us-ascii?Q?gqyqdUXbUSP/rONrbpzs0dU4Us+xn7N+nWHpYrCb4dhrGel+oZ25x6/PmFIV?=
 =?us-ascii?Q?4GFvvqks/aW/3ZAA32HZgnIUBtxiGU4fF/Xa7ohXCXwDQ4XMk6lHnAXjTLYj?=
 =?us-ascii?Q?DxpE60AhMquRfdMaLjYyuPYAS5kY0zrVoebuxwcPxTHhTO90CWOKy6JHf9W8?=
 =?us-ascii?Q?vAS9THVgHOU/7tE3UuqETq7S84MUs9y1PMPB4zWWi4te4v2tinL+g3XmiJ0t?=
 =?us-ascii?Q?weaJA865LT4L1uHzHGkpJwUO4rMSNQVvSIAMb4V6+/Wn0ReQgB9rl86QaVUz?=
 =?us-ascii?Q?CBDxTLM+B6kzcQnSKKCNvkOb79aSDLo6qoc00SlPYgnYFTAss+Ke9mNAdI1k?=
 =?us-ascii?Q?Uk02zQGJIZtjVmw2tCcsFOeksasCnZ8vNJndVfQuT2691CQGNIjl0TaQypaW?=
 =?us-ascii?Q?72A59OqVMYNxxxw5eJ0CWzN7eTSI5lvz3cjxN1HNafnCibRYTzkgKm6mc+Af?=
 =?us-ascii?Q?f9kVRKU13jwAFXd/HFgS5jB1OcBJoBFsm7kWXJfQl4EoRVcpjx8FWyCdSO4b?=
 =?us-ascii?Q?dQpolr9K/dzcEbzzqvMijQRXs49ApmmQxXD3bQO8fA9Anc/yg0IQ5qBwxYsm?=
 =?us-ascii?Q?5juLn3WRwzAavO4TjAapSc6Q5Bn8Z1J0jTTsoIEjuqKei9rMhxh95bEdXSZ1?=
 =?us-ascii?Q?aGDnUN6Cn8/ZS53ikhSSDtJRzsVmMTHmSAFT6bFLjQfBZ83H9PC0OQOvJK70?=
 =?us-ascii?Q?5z1J721AXmADIF33nwhx2aW8bUCMqaphK7iNGQh1EzWCC2JxqsRA1j9uRU2b?=
 =?us-ascii?Q?K4olooKcO4OR4QRrBAR5sFN8VtpQzFCNdcCfGjno6rkDxmw6qf3JxlvQ0XcQ?=
 =?us-ascii?Q?oBHYjDxJy4OnGJuIsFtY3SkHsxa8Ow1Fn01Ab0v9jk3G1o9zUnN/fydgROwf?=
 =?us-ascii?Q?0x/3npkn9qXHYtBvAiYXWuFqmiAkToVauPxLXjdXQe5a8QK/mhIDhc59N5iB?=
 =?us-ascii?Q?5e6SC00EjSU+HO14+OlFpaP0QylLctwhDG0aV0l7Un+GkyvBxXo1DENxVEp2?=
 =?us-ascii?Q?gydmzodJEE0WOQVZ5E+Tsk65H2rZVKul1GakZLJXw/589VHY1BVsitgsUiy8?=
 =?us-ascii?Q?UqYDAyP8tc2gJDHwXHxXdjJao81R4DGmxgY4gNs4YerDORtVJGGKa9rDpC0y?=
 =?us-ascii?Q?z1gTFXPME+cuGM63d+U/hKkROk0Ehs+A9I6MCFpkg8OhTbd0jTbLOCENXs1u?=
 =?us-ascii?Q?dQxyiVdt3fiLd7KwN5ttFrQVAm32dBerZ11bdD6z/FOmuT8MbIP/Qdb0OdgT?=
 =?us-ascii?Q?Rti+J05KsXv0bXnB8uJBvgu9byrJmoAwfaZsBzkHGn2Kzqp5aXUunfz53XuJ?=
 =?us-ascii?Q?ocMjxeI7owEMGk+f8nU6Qi0q2g0M8CqZO7ZWaLBe8zDV1KK4bDqNMU3T7935?=
 =?us-ascii?Q?aKzHnEG97KD5QrBiVA1CF8feRU1g8kxuEtBnpYeTq1cbo/CGHgT1B2jUQZlA?=
 =?us-ascii?Q?Xhs/qPbKcRZs+04nZx11Qrk0Eua1N26FvJjltoCc9ioofB6ASw2Kd7MkCtRg?=
 =?us-ascii?Q?48MOaXX/j0DFplluwfYAKwSZ9x+ZddpDScr7X6pj0gyL6Lyu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d03e16-9731-4768-071d-08deaa7ed257
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:18:00.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFGBtRV8ymW0Tuo7D6LBVnXAThAlvCfUsSdSSAwBM8mjrX+egy3zBsY/Xnh8kZ7GScZM7HVtD5NLuSv62jeijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Rspamd-Queue-Id: 41ADA4C88E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284257-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

Add a selftest for the protodown mechanism.

Five test cases are included:

1. Basic protodown toggling: Verify that setting protodown on macvlan
   results in DOWN operational state and clearing it restores UP.

2. Same as the previous test case, but with vxlan.

3. Protodown reasons: Verify that protodown cannot be cleared while
   there are active protodown reasons, but can be cleared once all
   reasons are removed.

4. Operational state inheritance: Verify that toggling the lower
   device's carrier while protodown is on does not cause the macvlan to
   inherit the UP operational state.

5. Lower layer down: Verify that toggling protodown while the lower
   device has no carrier does not cause the macvlan to transition to UP
   operational state.

Note that the last two test cases fail without "net: Do not inherit
operational state when protodown is on" and "net: Do not unconditionally
turn on carrier when turning off protodown":

 # ./protodown.sh
 TEST: Basic protodown on/off with macvlan                           [ OK ]
 TEST: Basic protodown on/off with vxlan                             [ OK ]
 TEST: Protodown reasons                                             [ OK ]
 TEST: Inheriting operational state with protodown                   [FAIL]
         Macvlan operational state is not DOWN despite protodown
 TEST: Protodown with lower layer down                               [FAIL]
         Macvlan is not LOWERLAYERDOWN after clearing protodown

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/protodown.sh | 182 +++++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100755 tools/testing/selftests/net/protodown.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index baa30287cf22..c6ff7b504e97 100644
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
index 000000000000..de6ab90c521a
--- /dev/null
+++ b/tools/testing/selftests/net/protodown.sh
@@ -0,0 +1,182 @@
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
+	protodown_basic_macvlan
+	protodown_basic_vxlan
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
+	ip -n "$NS" link add name dummy0 up type dummy
+
+	ip -n "$NS" link add name macvlan0 link dummy0 up type macvlan mode bridge
+
+	ip -n "$NS" link add name vxlan0 up type vxlan id 10010 dstport 4789
+}
+
+protodown_basic()
+{
+	local dev=$1; shift
+
+	ip -n "$NS" link set dev "$dev" protodown on
+	check_err $? "Failed to set protodown on"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" "$dev" DOWN
+	check_err $? "Operational state is not DOWN after setting protodown"
+
+	ip -n "$NS" link set dev "$dev" protodown off
+	check_err $? "Failed to set protodown off"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" "$dev" UP
+	check_err $? "Operational state is not UP after clearing protodown"
+}
+
+protodown_basic_macvlan()
+{
+	RET=0
+
+	protodown_basic macvlan0
+
+	log_test "Basic protodown on/off with macvlan"
+}
+
+protodown_basic_vxlan()
+{
+	RET=0
+
+	protodown_basic vxlan0
+
+	log_test "Basic protodown on/off with vxlan"
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
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 LOWERLAYERDOWN
+	check_err $? "Macvlan is not LOWERLAYERDOWN after setting protodown"
+
+	ip -n "$NS" link set dev macvlan0 protodown off
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 LOWERLAYERDOWN
+	check_err $? "Macvlan is not LOWERLAYERDOWN after clearing protodown"
+
+	# Bring the lower device carrier up. The macvlan should transition to
+	# UP.
+	ip -n "$NS" link set dev dummy0 carrier on
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" dummy0 UP
+	check_err $? "Lower device is not UP after carrier on"
+
+	busywait "$BUSYWAIT_TIMEOUT" operstate_check "$NS" macvlan0 UP
+	check_err $? "Macvlan is not UP after lower device is UP"
+
+	log_test "Protodown with lower layer down"
+}
+
+trap defer_scopes_cleanup EXIT
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.54.0


