Return-Path: <netdev+bounces-261211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHepFmT+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:03:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA21A23A7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2CB3087E27
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835238B7DD;
	Thu, 26 Feb 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAsuf7IS"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA53806BA;
	Thu, 26 Feb 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092857; cv=fail; b=hqL5OMxSQNOEpFEWqYPAmWuJ8MAfpOPHiw/1b2rG63UbePrbNsy0eG4AfDXteVZWjb0mxl2dOsCikQxh/MLO5w7aeYMbDwkK5tjflJ+jg8z2AJfzws2s/YI/osAputwT93RKWHZyL1pHmOPEb7RUQGji0g4MZ/0Bt3i2j3yhEGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092857; c=relaxed/simple;
	bh=vjNZRasqhmlYTj6Qs0W4NQo87pELlZz5hI5lzWZy4Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMxScUSudgylwZqT6KcPYkwMIdmjvzBlIyRBe6Y/rgO+MstqmA+HA79F/R8O4W/DcwZB49sk1EcfvRVBpHUWyf6mqJDxCRdtDoaA/+QoMgdhfDxjBqI4U54bo625awYReZ6PtM8B3o/KFuJkx6CMIWdIffQ37toWbICaa1A0LuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kAsuf7IS; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpjxWnD7nHnvEMGVAfab47ThHno2OnfjDyxx936Zd8n0oHHNFuvu9gqCoeZ66r+O68k9/GQT5DsgdoyDY5xiJx84s1WCkUjwKr+Kvo9hnezRZ/Nhy8MDKvcr2vkdVXhNnm1N+1Ar3OYkn4spvUHkQHjQp5yhrC1a+IZmljyK96Q3+SxgTpdc3QGO+G5peAJwfFSBHtpwCxZmgj9nETUVNk2e2IKI42Btky5jZSL4QSorJX7x+5FrpZQJROQSrwh+2ALPGnHXsDPXrSncr6H90j9zgDuv0AZdY17qvcTS7WRfyypth7tI/+wt0KFTzactSBE4qGlOg6CXFpiidnH5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvWNxn7rgrt57GsZYUIF1kqzBFlI259Y2MG47P8Iayk=;
 b=Xpm2MXtyjHxqD+OclERR1gjhYgm7ZBKY0XmZPA2DgCJxBlUNLc1CvwLd2IzWSpACT8XtqG6Nz7cQOf9FI79lYdQ847Ns2ZXAw2qrFtfOazWSEKTm89lo02Wb8yrHAsb7C7tpLHE+ANaWo2PyG6hIuqeUTScfLZh4LXPtL02IFT4yLP+o97QFkcWObhcgeYxug9vwgtyQW25e8E2V2wPNu4CTHdZ8TclSnZ185Shxwa1nUA9kXRzMcAa+KPr15sN/7lqEBXfx4aAsNcFOqO63V7T9Pr+KrH4Fz0UCwdO95Toioh+fQ+zE6OBjD6abycdXoa3TSffKB8lcLgkE08txag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvWNxn7rgrt57GsZYUIF1kqzBFlI259Y2MG47P8Iayk=;
 b=kAsuf7ISU5f6zV+iJfIhlL5OZUW2VB2uiROctzfOUatGGuIr5dn2kJbowVydaE53sTIc/GBhBPGWuTnxSSAweof5xpVZk5rLqrycR9Swmu9yocMTmeP57tCPb14ENzJX6HezIEcwjsFgK97OrFzdI1H5hOIfn2bLVpFw9j8lteHlwyg957QGaudM3Bogh+45FAGbNxH5OVKOOyAE3Xes99/V+OKap5WSp5Gz7IFG/ysaRMuj5spmPjfdqQKx7IGDyQfSdKQqj2visUicXE5O/KdRUAYjx3szJK8xT6QiFbdQWxnp3eQJxaV5+9+Nr9jjEFv2LZcSdqzjN3LVpEXPKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:00:51 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:00:51 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@gmail.com,
	petrm@nvidia.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH bpf-next 1/9] selftests/bpf: fib_lookup: Force specific interface indexes
Date: Thu, 26 Feb 2026 09:59:55 +0200
Message-ID: <20260226080003.524935-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6089767d-d6e6-49a7-50e3-08de750d28ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	RzeiHAJDHHD8Hz0eo6v9dVxJ0KzJPLVRcLKaZ6LsnWvR2xn1Qr6aUqeRG/5rvpOhZmrimSEA8NEICEL7Dj75tZ/pza2K8WrbPP3h8z4cPW/dQ9pw8qqY6napULKg+DN2NbNYmM9VxLm5iiGJF6JpReGmSnk/j5LIs1Du6hI5k6UQzG23uKKxe1xZYQCFRW6o01CNwS4slOnERuEjSoWz7yPWAUJU6pbzj0NPg7+SwLQGpbQGhJwmI8FBnlj9+xx8kyU2wJjZt8IdQl+Mdv8h5yCWerEK4rFdZh3YS3glF+FKXH6sfKr2e1Ov+RlpukEJf79KhJaAJ0nTDqXcrtY9ZD4YNBkPTWO8CqP2U1bGuZsKXrRXBCGMs3enTfRJ4hEcU4TJ1LWjNaGfIz46qZuWr4B1T4Nae6wjAUGNZ3KOShbZ//rkd7oj8+Drt94ExMxQgvlf5dNjq477zYzRV2WOE1rktM56QM+x+FFiOsALw5ECh+JUC5mVWZKXvkB3OFE+EkB2NfcYPurRWfMh69tU+9cvqJW4h/WuUZiLf1etfaRasGac/6AJ2K2m0HfVmo4AaiDAs3jeixuLUtAetG+rac8Ski3D2PO6CrZdbNbLsnbPjn8GHlpJs+CzILdblOFDNlibAJdoimnOuPpQ9/56LE5AibExw+IzBaW9dGiPRAbKU5lHqdZ/cVomYt7gBqrDUy9MR7l2YPLBgUAD+B5PJp9OL1XhcOUe4ub8bnasKhU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8oTkCG+RLP3G2OdCrxWrkO5JQO9J6ZrQUSuZ2q6pH+g7reRyQT9Rh34pf3dq?=
 =?us-ascii?Q?TvE5pBS6aLK9OYT4CX9Cx9vBpwhyphcxX6dZD5XJeLr9HJg/VV4w3SQatnG2?=
 =?us-ascii?Q?kQPQc9Zoqx2LWASF+hRdLwOnSmRJAD3pVTzqoF0jddiBA2WQLho4C3guZBU+?=
 =?us-ascii?Q?yZ/BNzXEO+pNLh/8jMAqOklqaZx77zYTfzoZJ2rDjQZgdnmQ76FRzhsucCb/?=
 =?us-ascii?Q?yj3AGj0CdM3yP33Gp/YT8iemnl4fOe6oJnKalqLQUMK4IKjX5A1poqNDpIOE?=
 =?us-ascii?Q?CkIJV5lM5BjFRPJ0YXfrHBWlvmZZ+qFwpL5Hj3Ka5Ac3+5SfPq+IOII4SCtF?=
 =?us-ascii?Q?QbvJaO48ACykQ5jeDSlti3G3WuzaQIS6tN9cAAwH/nU7gp35y14D9rwjBtgw?=
 =?us-ascii?Q?rSmOFYDUwlSybsxU1Hhk4RD0FuS9ZwSJcbJiuVbwgBhqalT1JaQiJCnzKLwL?=
 =?us-ascii?Q?Sqvno+jlkWe3C4FQ2YBqWKUExXXxhVYBl9zaauq4dbOILx0QFhRRGt0ckFT1?=
 =?us-ascii?Q?d+PN3eTc34jMz8WMUmI5XmVFAsTmi1W8xihU823rSNBmM2WlWMifxbeWmKeH?=
 =?us-ascii?Q?NIqOKsZyf+RCxS2Q+iBh4O6uaU8+HsFAMVTAO1Xei+kFeZWLy7NopnBV3eqk?=
 =?us-ascii?Q?QZyIQsXQGXG1uP3DlFCWlmrpVEUL1y2NifmFiK+wQxUHdh+ByMPlqPaWJ82V?=
 =?us-ascii?Q?CCah5PF/p5gnL91aiTYYNt1piefuxsyd0PsIOeXTd88GBxd80sOq15e486BN?=
 =?us-ascii?Q?cxYHnI7SGde4ZXkTwFwD4/QQfQBj+xtJc6aD0x5NzbpD3nWtvIHl9/NE/faE?=
 =?us-ascii?Q?smYGOKcY0T9GykFmNeaeUPvomtxjdOwbrDAa9Z+P/1f5kl/CVRNnKCrrASji?=
 =?us-ascii?Q?oM05vikPckGMMN7l2wfoGwpdUqcBTQSAJqFQXWZvHw8UddhdarpK5v++uPaa?=
 =?us-ascii?Q?s9pL9yif6gmimDUcebrZMp63kFQM3KJHJPgkVc9ORM/XWz64M1YQ+iC2bxi8?=
 =?us-ascii?Q?bve+EWwdKQbKuUHc0kCugC6lEJvrIEsSanoJ4PceiQwOoMD0gYB4htb91xtR?=
 =?us-ascii?Q?S7gqH66C35WWgRCAGE5XmWAveD/OmNOtJb6TCnfc4BKQ9+W8kJunsHHbZzwV?=
 =?us-ascii?Q?E5fBMFrEUVy46cTDYOJLV4GCatN/SF0BMb6DwXl40WLb/b/PilYYERJUbzwA?=
 =?us-ascii?Q?9pamXoX65mpb4ciTwPKBwNULGRb8igzkgYhr2U63PK4hTcsNPSDKmKW7l5tl?=
 =?us-ascii?Q?A97nDjP3WOQ9PoNOiySJT+fkQljGhLlz/4e0LMDMcVuOtqRmNPnsq7ZcIUCB?=
 =?us-ascii?Q?qzDZZ+rwoy0Znvu3AaLh2HAY39/IiUbQ8D03FHcsO6ol5PySTkIU/3HKbiYw?=
 =?us-ascii?Q?ohxi3+prHmxwcM8Ly/aFiu76jG+hWZfEncw+bOhEvabhBcRzMX0vQfKy2U/k?=
 =?us-ascii?Q?udfkuEwLjwULW79/TJjUWx/LGpO4rkWFRUwjz+soFFq4Z4Dtbxj8FTlTPees?=
 =?us-ascii?Q?866PmY3QlX9uYsWFpdl5L5ygn/NK5wcupZ0MnwwGu2e7eMCvdMPhVsYfOks1?=
 =?us-ascii?Q?Pa9wXioAUjSPJuuaVfigzL9ARQiVBWwF60drWu1W2HKhNqdYw1+aZIhREK6u?=
 =?us-ascii?Q?s2i2Ppnx7klWG2IvFZr0KX9FJSYMmNlkMXULAY6N5B7Xr+VZdTJY8fiRPw7T?=
 =?us-ascii?Q?uvM67ojusPQECdZjOfftpDCRuV2xgs1+FL7PZcdUDXM6u/hJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6089767d-d6e6-49a7-50e3-08de750d28ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:00:51.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njWVg4Ga6M0fWI54fs9dx6zrltVGvjwKOZnpwcriWNUojDrH6iKDsALRO0rdM1jd/u98SH0ANWDQDoX26Tjhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261211-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1FA21A23A7
X-Rspamd-Action: no action

Subsequent patches will add tests for output routes (i.e.,
BPF_FIB_LOOKUP_OUTPUT). In these tests, the bpf_fib_lookup() helper will
be called with different interface indexes to make sure it is resolving
the correct route. Make it easier to add such tests by predetermining
the interface indexes.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index bd7658958004..77f65ff7784a 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -41,6 +41,8 @@
 #define DMAC_INIT { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, }
 #define DMAC2			"01:01:01:01:01:01"
 #define DMAC_INIT2 { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, }
+#define IFINDEX_VETH1		10010
+#define IFINDEX_VETH2		10020
 
 struct fib_lookup_test {
 	const char *desc;
@@ -148,7 +150,8 @@ static int setup_netns(void)
 {
 	int err;
 
-	SYS(fail, "ip link add veth1 type veth peer name veth2");
+	SYS(fail, "ip link add veth1 index %d type veth peer name veth2 index %d",
+	    IFINDEX_VETH1, IFINDEX_VETH2);
 	SYS(fail, "ip link set dev veth1 up");
 	SYS(fail, "ip link set dev veth2 up");
 
@@ -324,10 +327,7 @@ void test_fib_lookup(void)
 	if (setup_netns())
 		goto fail;
 
-	skb.ifindex = if_nametoindex("veth1");
-	if (!ASSERT_NEQ(skb.ifindex, 0, "if_nametoindex(veth1)"))
-		goto fail;
-
+	skb.ifindex = IFINDEX_VETH1;
 	fib_params = &skel->bss->fib_params;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-- 
2.53.0


