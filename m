Return-Path: <netdev+bounces-285258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PY6H+Fy/GkyQQAAu9opvQ
	(envelope-from <netdev+bounces-285258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7454E73FC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58BAA30262E6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9C36E478;
	Thu,  7 May 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2zBgZoq"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7E36CDE8
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151646; cv=fail; b=O412e8VY/SN/9/s8SDzViZ5ILqi+VBoUOuqYjydn7OtvEXHWw6i5gFvWrwQRsPB27Ehuq1RW/2kRLxEIkuiAZXlDjzkRJNJsIZv/8H64AL8KG7cuoSnpcFC7YuIwvYGJgpaIS+PuXA2G9xG1Ozgu6dFqHHHuz0kUtF760hRj/Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151646; c=relaxed/simple;
	bh=DdWM+5IR632CK6S+9132VfWIXCxiBcQPlgUt757LDPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zf6oAbCnHCIu17uLpz9I5AS1AxsXbxwyGVPjcxvgYpdbNANOsKtYXLNvo9OQpL2ncvcCXQO2xgzOU10MxASYuGiOTTXDesWwuVn9x5a+OcO9oRKxz7t3PHUHJ1gcOVETZaPyUpb7omujxxmstQ63v5OKzeIuGjZwMl/Zqrc+7hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A2zBgZoq; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUxsHh+Nb+CfrY5zhqyPFx7MHMcGTZmXdSOwj5ipPEa9m4Fl9REiY0LhlKt0mUtrfWfHhpHQHVGkyLcDzHEy0j4mJkrJ4TPny4pxqWbGxAf8vkBhOjGKY0Gq1Dqj2CPWUg5YZSftiDbM71yMwNSPvwMooA5baZmw1HDHwkRHOraQLYpXQL4Ex7NaKDLJDoOLxsOD6aJtZ+rVO2JDFO4wmp6dgRG7Oy3uXrC2rMnnW8qGcsWohHDDhk8hq1zsDukSrgjU8HWd0y0RQfJXCUSLsMFnBBLocwuAYhjXmkAkIp04MZF10dWnIhKHt5xzreBsCxuQdPdWOUi2J1tlrqlylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVt2ySETTdn8xKoxCteXHAR131ffgTLHq67EP7C7xC0=;
 b=fDvlVwhAL8T//r3SQl8d2U1C3eX61HOpx6wWvLPGC9Hfm2b8zJ99hN1iYhYaDu8OsF+efp4XmEqipdtYrkV23den12soqjlOPMI3XuafduQpioFnxkru2UO9J9RujDHAo9X+4DvdnPZKyCduNWLJG2UPiqYCTBQ+JhBlNWNnqaZyaNNwTjJ1FiFzEzu+pjF2uG9JgyjdN8qpQ0GfSXMKe6eEX9EjHZUzdkWoF3bVD74BiCNJBt+yxLvKiZSTY9JiE9+5WHgvgamgNTtpgo6pnH4uN/v9Z3bZnURHKkrN172nY0zgSeXJ7RF+5gdKnoWtCnpSci5Wmu1dORMTWKYi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVt2ySETTdn8xKoxCteXHAR131ffgTLHq67EP7C7xC0=;
 b=A2zBgZoqlDcXKxMbnQZINHIlNwoS714xfzFCVC0VFwPXnGwz9vG9KHYYqcX6k0rGBESyu+LUX3kpTxl86DXzsU+EFwj6+iSVyNldF87cBOta1aeQ/vfZxHTNqWd8Ou+jxZo6yVA1TXuMA7wPaP1TvlRkx2lWkTLA5dTB1FGOfSif/D6urZZ5dYMu0Xmf0onuSVaAraMwUsG2V2JVBeowO6mJKZYQQ3TI9AlM1oY1w+SBH+P1TZcYvzKVnA6/0nMgPn2asl5FWHOlSahlJxkvmeeH8C80/pbEJUeADrGj0AJ7vt4tESZMSneLcG3c2gh+mDjmNi3m9nBjIbA+DdY6cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 11:00:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:00:36 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 4/4] selftests: net: Add protodown tests
Date: Thu,  7 May 2026 13:59:06 +0300
Message-ID: <20260507105906.891817-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507105906.891817-1-idosch@nvidia.com>
References: <20260507105906.891817-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbc436c-e895-44a7-1601-08deac27ddee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Tpnj7ZQAeAXLAPLVNGvKz43ER8JPV1pBS5JPtN6XefoJM4/kQxEEeeBwUfBEFr13R/C2QPPJ0MeVeuLc023/LzFqu4Fb8nCQfdydIqguboW3200zTAhKpzB+87E+npZNi6VuW2CtWmev7MZPz7WztqwySqKTR7TYk7/7TakrNHjf5SRo6/+G+i/qjeEI6zCojGUNKFYLP1LE+Q/2Kk6WG5JJjCsyw6r5HKvUNYnWcQoZ23QNaUupdv/fCJjeWUt14zAZHQWkPEHKef1+fklv+1GWJ5kunKCqi86e5nvEfQ7B/UJnMLDX8R59QBOViJum8Jr7uQ60p4ii4Q4spB+DNkT6AYig6SF0uZSOVgxZ8VLa6KaqN8pFDotu+bfZYfbRAkgdBgO6uqTWgWiC1PcijSpm2AbqJ28tAKRuFUMAP8HPzhiU3FgPyBg67EvUjSlhmA22TKEZ+mU8aYkCXcNqePAgOw5f7jZym0TJZDONK5qmLmuNe1wXNjTCnHhoMMFrbTDMTXV9KjknCcEA81dTdKMDD2VEeR57tkj664NsnrTRILUp66nHVvXHlc3eU/aX4VvKmGsn60leUA5Z3vDmTAS6IbesQsPQP2klZY76dpcC/AkVirA19626+4/6FTNekVUxVK1J9QVQyc0QWtD1cuwdrp63wjbTrhQGtMb7IBybBOfUk/w47Whl2YJfxxLy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0rBJtqPvxdly7/wNe2YbX6G01AO01VEDev0GmulCBUm9sA/GWLAyiTVW71u?=
 =?us-ascii?Q?+1cRDTGg+0j1AGpHv1P6kYPeBfGjtn6S3Y/fqaHS8/BypPxzNBm4m2IfZhSC?=
 =?us-ascii?Q?DuASIGoayUXsl8qc3SfNXSHGUNcGgtguvbra9bnVsKjm4lK+2Q8HIkQy55uD?=
 =?us-ascii?Q?N4akpHFpSrcxiQuUIOaS55EiYs1RfBOgDA3kXOsFnm2tZHMWu97jHOJvsXA7?=
 =?us-ascii?Q?SB7MMVQSz+hM03wnC9DI+Y0/CPS4Cz84utUPKaYowSgQSMtHPvdVHFqs7d3X?=
 =?us-ascii?Q?kwMdzhpMRB0KgjZXqhNTcaYLP1IEY5gXKJrIFo4uUToeFpJwlEHRaZEq1tth?=
 =?us-ascii?Q?atIjH6x0m5eMSkH6eta2bH3M0UN9+rb6kZAVLHh5RLFaK8i+PzQmkFQLy5vU?=
 =?us-ascii?Q?dVIbmEUf0QoPGfufk7aB0D9ZbYvuWXWyoLU64Q+0EnlpzDsKFHzZO+blwtGb?=
 =?us-ascii?Q?EQJRvBl6U0ZEbU2VPZWT41/TyblNqvS7nxysAEEImcsD+YtFNMfmN/GXfVIp?=
 =?us-ascii?Q?fVdiADQaXixAJ/UKNY3MJ6smjqWJZKJIiiNqOhGG0+abbBEcn8spCQX2c6Ew?=
 =?us-ascii?Q?2MFsU83M4tfdWwETqC/xTgSZ/yWir/mRLuNNx/bJpFKQm5r2UXYFBzp3812d?=
 =?us-ascii?Q?2V9ZT+PHxb43anfrVnyhPHnIZF4yhmva/ElVyM9ZVmYnXwWLT6dqwLHKxw7B?=
 =?us-ascii?Q?dAZrFv6fOS3uZEOGD4yHNihbEfzwCSPuEoVtDiLnetnbzBws2I3kKd5JlpG6?=
 =?us-ascii?Q?JHsJsy0CFWYLNGT9I2Tp4MrRDSZyhQPpm7ElR/G4OyAVNqJ5Rtizrn01ArN+?=
 =?us-ascii?Q?jq7v3o4DkzVXRSlpjMF0cvqwzws5BShzJQNYHYakbH155L64ChpGe1309gyn?=
 =?us-ascii?Q?7gnlRvE8XmA+NVDAgYmARB3erm6lPNJpbd2eBFea3wP5Wh7Tca56tkdr+/Ae?=
 =?us-ascii?Q?eOV1EPz5WP/4bTlm3sf+eOD7n8rDQzvyVGQruqOfLD2XCVcXeQYUIeKRP8yg?=
 =?us-ascii?Q?eOWm2fWDZP4MfD8tyLTX0Zuelpv8qR4V6R35ExYFI+RhmNH2qrHdbb3t0Gn5?=
 =?us-ascii?Q?nmlVwdo6jAl4AMZNLEhPY64y7nANjeRNiqBshumyDNDglZXleXeKqsJ5mxl4?=
 =?us-ascii?Q?yU6xBMq/nwDp4Z3WluTGREDG9aWxcW1d+23mlz3IQVsxfEiuLjJgsqmgaPGE?=
 =?us-ascii?Q?u0AZm3bk/5iqb424uFLZIgWSAq/kR2M51GcWJYkaxUsAZDiLd/UTBTFxvO3k?=
 =?us-ascii?Q?oC0Bu54Sh7Oh3bKprM+0jVlOqxGuCgaoyqFSWgcS71c4UmHrhu1D8Rdes5XY?=
 =?us-ascii?Q?g19dXB0Wdy5P22sOYlsWmD9KjDJVSHzizAT3XPejqzYsZ48kO1Vrs0Z+N7sW?=
 =?us-ascii?Q?GP3BSbJLU6w3cusLdl4OHf2Au5AEjAgex1Chq/SclrOq5jz3lShiFbBV9qTP?=
 =?us-ascii?Q?7jZTg/zeY2u4HhHvVqH9FVaZCE937peDKpejWa1GmuL8k/OnCNXJoy3f+CQ+?=
 =?us-ascii?Q?DV2YI1WJFi8TnQfvUkNVppawsOcxaQhRbA7IMVYpJ6QB9URf++lsuuyXJCVj?=
 =?us-ascii?Q?mSGDAM9EziWh7mxlj/Np2IfcahF7sAPd+uIYD7U1Z6ij4oniT9DTV86u+WeJ?=
 =?us-ascii?Q?agvBhgh8gB9b0hC5Lz/tIBQFrckDnXpPAk7AdL3KRufopO1YGL541B7OrwBC?=
 =?us-ascii?Q?qbHwio9ZWQ6D2YOJnOCQ9vYGYF6x+RiGpqxeP4GeSCkdn/iI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbc436c-e895-44a7-1601-08deac27ddee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:00:36.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avV1i8TYTMb2SS2GMf37fpCfCYeE8RTzgNmVKKB0ZR1bd3O8uGgLLfAcAyYl4/7ZVtsz9mRXRD/j5ADLIDZleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Rspamd-Queue-Id: CD7454E73FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285258-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,protodown.sh:url,lib.sh:url]
X-Rspamd-Action: no action

Add a selftest for the protodown mechanism.

Five test cases are included:

1. Basic protodown toggling: Verify that setting protodown on macvlan
   results in DOWN operational state and clearing it restores UP.

2. Same as the previous test case, but with vxlan.

3. Protodown reasons: Verify that protodown cannot be cleared while
   there are active protodown reasons, but can be cleared once all
   reasons are removed.

4. Protodown with lower device being toggled: Verify that toggling the
   lower device's carrier while protodown is on does not cause the
   macvlan to gain carrier.

5. Protodown with lower device down: Verify that toggling protodown
   while the lower device has no carrier does not cause the macvlan to
   gain carrier.

Note that the last two test cases fail without "net: Do not turn on
carrier when protodown is on" and "net: Do not unconditionally turn on
carrier when turning off protodown":

 # ./protodown.sh
 TEST: Basic protodown on/off with macvlan                           [ OK ]
 TEST: Basic protodown on/off with vxlan                             [ OK ]
 TEST: Protodown reasons                                             [ OK ]
 TEST: Protodown with lower device toggled                           [FAIL]
         Macvlan operational state is not DOWN despite protodown
 TEST: Protodown with lower device down                              [FAIL]
         Macvlan is not LOWERLAYERDOWN after clearing protodown

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/protodown.sh | 182 +++++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100755 tools/testing/selftests/net/protodown.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 88c7573a8295..ff1d58625589 100644
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
index 000000000000..0a7b78c63c37
--- /dev/null
+++ b/tools/testing/selftests/net/protodown.sh
@@ -0,0 +1,182 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test the protodown mechanism. Verify basic protodown toggling, protodown
+# reasons, operational state when the lower device carrier changes, and correct
+# operational state when the lower device has no carrier.
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
+	protodown_lower_toggle
+	protodown_lower_down
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
+protodown_lower_toggle()
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
+	log_test "Protodown with lower device toggled"
+}
+
+protodown_lower_down()
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
+	log_test "Protodown with lower device down"
+}
+
+trap defer_scopes_cleanup EXIT
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.54.0


