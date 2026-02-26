Return-Path: <netdev+bounces-261221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMe0AoX+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB871A23C3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFAF23033BF8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E0392C2F;
	Thu, 26 Feb 2026 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACOs5gGd"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9664392C27;
	Thu, 26 Feb 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092929; cv=fail; b=BDgOb8da7T/EAil7+657cZIDmrovPirRkgMgymXKGyA4U5jH15S6Pe5Kqqgvh89IjrAAfcOuSGndmJAOJx6ZxXMWXaWb7j/UePnyf8JoryoOQQkOA9JU/spwXKt58VYtFuEL1uo67jJQnLA5P+Jq9xTEsrsy1+9UMb+OB+8impw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092929; c=relaxed/simple;
	bh=hhtyOrRgYrK6f+WSECuGQ/U6RnTmUdi9UEWa7HxXzbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1Q61MBuG9gbTrsgoF/SjYQcdf/IUf+3OVXvaGiXZOnhasojivTtQZgt442+NvvE/Z/DD0a2FWp//r8c1jDgpRObtog6pi7dKQBaPmD/xbzkHqcMfUQHJVzw3DfIHdyRAv2ljdYeRxWvFuYhTW6Z0zp3DuNGfcDuNxTUzpngB8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ACOs5gGd; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0LVeWV6n0hY2vavljGw8bST1/qiqIKBsixoB6xu/kEGYXIyVWyRf2/OgSEaf9RNDS/dZKokZDKrnWA2ny0sCvKKgyH9eWuvaPDL7W/BOegtQMUuIkfsVg4F7PAEBsz134Muvf/PTDv99OGxrSG5IG07I1XJRcHOYnI2y+YRvj03ohgJ4OWeCeYoohwJt6OMNbwm2efZUvpLKQTkNSoCTs9S8L/WtxdoyHCYcVJGs44UAB9Q4C75LSVxt7SN2RZReX1T9u/8GJKT3OI+KMeM2JKE386dKgXLz588+ozPMwSJzSD1QyyOU6ajVNZ7ybiwHIkI4xqu1KWleSjLY2WMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leApNsE4ZZUN9qdNyT9Irog7tqSCHBLSH+p9MHr5l10=;
 b=f8amkGP87efWqikxHE2kUKVB/K7kr4bqeH+bA+Pi6u8gMHsDoVt2jZBzBOfgf46q8d9rC9U8LfwkI8BqLjT+pQPdccECy+bt3ExGCmtjFOvu+XuomqKUjO81V9qlPB0ekEvtDokKznNFvx5abRm/0OIwvASvhJ/9vYOnc8N0L8s3ipV7oA2bQwIepMiTw29VV9Nlyd6ezu/4d6/6qJJW06XhestGD1n0W3J/xd6XOGC5XgCL/9V5GOjRlXlOH4PEmBas3UQxaTqI7XoBWKYKIUc3CSheeS7V5oQqJ89zPkFhtanLxFt3EqLJkkXHWBIF1JE4B9ZYMCYe/W1ndp3xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leApNsE4ZZUN9qdNyT9Irog7tqSCHBLSH+p9MHr5l10=;
 b=ACOs5gGdH+890peyJJxKkgUF6eUYDSZaXBypdnqj5X/I3SkgzXoc98//2H3bnM5VxaO8m4gFHPotb/lbL+UvDCIvCqTsIR2q386WTk9ucx6GBZyOlXcGQzeQngw/y3GXDsy3wvgurDDDEE4Y5toxUC5URLfes29i0jtEU1gwarj5niCsDsjYHWXxFYWp3107pTebD6upKuEGbWIo8/8vNy1czPpfYxqQwYovCxmTLz4xOTu4X0vX7Ql4F5nJJ/40akRVIj7f2pFDuc5dJpI0QLJ8eJtXu50yZKY9iGhUWSFHHlfVBhlA7OOq+LiiKBUFcoPFX76V7+/afJEHqo6EoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:02:04 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:02:04 +0000
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
Subject: [RFC PATCH bpf-next 9/9] selftests/bpf: fib_lookup: Add IPv6 link-local tests
Date: Thu, 26 Feb 2026 10:00:03 +0200
Message-ID: <20260226080003.524935-10-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0cbbf7-5a76-4898-c928-08de750d5485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	EGa7pT7ZdJeShMu+JvAzAoqlfhVVKTmbVYCZgPE2q9uFWb6PosIBoz0lkdcRMctxpU6EoHZSgzo5oHontEx0BtT4vJpdaMpwMDFS8QnMhrSGIYzGc0JbmfsvdiXw+bv9p3owkGg1KMKYNOkP8cIQohtnE4NMk4IAs0aqJ99ZqHIGDNjBUxcFBciPoWGLEiK/MOXVCY9Xt4Gq8aoYMi8H8CRbJ+xFRld41w4aOlvCaMARSNcoSh0mx8qTimZN/hzmBtIFTSfwhIqJ9pZM8JsZFkiWKrKBsbe5uArVyCSnUn5mezMdlFXbHxIKC3p39I/YJRRkx3n1R6QiCrPw66XJ7l1D3lxPOwKLpNeE+2raQyp+3Ht8M8JYtlL8ECOtO9Qgk5Ysqqvxna7aGzCrHy8d/9WanijOf6KuWuoHnCFQRH766exoBEHOYKTuGwFyC+whwasQZhPccKSVrYQlmCANV3no4iBkFGJZy/ZoMTu5LwNi0bfhf8EcYrwuwzXdqI813GlqcKqCkl2x7B9vXvDbkfhmTNSNW7RrCHHciZ3Sa/yJfCprsR3zf0buGgaC5eILhH/Boam6XBFxxr2g8OvBl1H8VE+ZRt9dPsIAhJIaazpOv424o8WKR0IrVX0cLkNV7PFqOS0uXGx7df/1lUKQ+ctbJQrq/1I/JjoAwbpjs86Tec1V1/8Q/lmRFSJHsi+WJgHZPZtw0E76NdtZrGaWIoMV7bX1lNeNpMSDxqCsSKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iaQhoepiAh3ayQg7hwCU1NYfq+Yjn8izmthdOvk8DiIvCeQ22P5bBpc3LgW?=
 =?us-ascii?Q?1Qe9czD0u5vz/LM5xB3q8WeXXIM22LpOTZa2zW5u6fXIFyMiZ2gU35q5Sx4y?=
 =?us-ascii?Q?3qLFLUuOhq+usTOO/Boq6qveRzRDM+LqHgpfC3BMrcoPJxfJRIsIDahGMqhA?=
 =?us-ascii?Q?XsN83JKsD64yBMfcyI+czBeM6uz8q661147P5GK0S+oKap91Wq/iGAMnI1QU?=
 =?us-ascii?Q?g/h2tAoFB+aGM+Y/EdmGU9eot0lPbxAcu+qNV1a6RfqfUgATx+8Mz8SsTlL7?=
 =?us-ascii?Q?9MLMYJA8qYlsrRzkSwDigaW9oz48c1BndElcDM1GUficSW3OZhmzBLDCfOTU?=
 =?us-ascii?Q?/C+Yf4EGN+t6VnyekS7XuDxiQDHu/92xW90PaSTSmDW+MPCNqWOE5xPPv9WD?=
 =?us-ascii?Q?B9Emhi+VQC6tU6suL1n4pdngu6NmdpofBmdNUFsBVPzCTv3j5DxoCZdjvKlC?=
 =?us-ascii?Q?Xr7EhO7Lx3hh1WE7qQyd49XGjM+OWpGVAafQt06z5IE1agSnYM2cilstemle?=
 =?us-ascii?Q?ckcYHrPk+X8PB1qRsobdTsRzSw7qMY10nsSlxglqC4s3QZHGFOddH+WSzGfW?=
 =?us-ascii?Q?3h21OmE2ySO6o+BIY7eSmDnAwc1UlGYH6dhzG0voNN9Ej39M/kXpYXdYvm/L?=
 =?us-ascii?Q?THH2aTbE9iBpPeXnuJL6H6Co2reEEfiqGlpWH2XgFDY42mV7BpD4mjBoVvOT?=
 =?us-ascii?Q?d5wTV0a08LuKAHLqJlGZbVPOEPMWo0KW8ZbauqBcHmnpVbSc9KVxbU4NBtat?=
 =?us-ascii?Q?SMjxf+ZrVnQsoK0iQi+j3rDk5K8KXFiiLWZebvdZQH8QjvnjmMpVcm71wGSS?=
 =?us-ascii?Q?0p5+gJ/33O4sqB4aqY5Ye+HujDd+7c0Ayzmg78xtatp0qQ+Jz375FZQsF9ia?=
 =?us-ascii?Q?gd/2HKlEHAr9nzCUDaBGlCGGAeVUKESKQCY6cJjwqm7stimxpDhvR9fxhUMW?=
 =?us-ascii?Q?F1H/zaYwc1dWtfhImJ4ttZpbDMgm3I+HkUjAnO2Eqpg0OjEGHb7xxJoTcgob?=
 =?us-ascii?Q?/WGKa5xpjNTlMMdcjLik0aRSsbC/ZhZzUkG4r/QWEh3pPa3sOCL2O9hzSNA7?=
 =?us-ascii?Q?xLNH0MTxo3or6Wp0nizJa8MHRoLQXr+v2ubPDNXW/N/tMzx9wooufkCiSiye?=
 =?us-ascii?Q?OdIPu5V6DG2lJ9qhVefb4OcOZlHp3l6e8pT/Rd31FbDOMLlLK12OhN6v4PWy?=
 =?us-ascii?Q?aTcZHKbRVPUW+l5/TKi30IOvaQTmHbKowxBDvOof+qtYC04Q+qBgpOWkFaFa?=
 =?us-ascii?Q?TwFFtY2xzbJ6qKQNY+KsFcTgc1gbf1g4XcIe9r3W7a3dPcCD8tzA8T4x8FFD?=
 =?us-ascii?Q?uewYmUWfhj5kFTZ35e+lmxcs7K+F13Q5JBtX8uMU6by2CXAxUjmzOCkvlzJv?=
 =?us-ascii?Q?hAHLmQELYOhSs0Icf/gmy131rv0HEZaNB3ZAF72YNhdKyLBPZ7uswv4hMb1W?=
 =?us-ascii?Q?SqwSYU2PA26bkWKjdlXvLRkkf20Pr1uvL189TgHXH/8LR5u7vNT9IMhvpcYZ?=
 =?us-ascii?Q?LD2NPnKAu1/5lySEoT6+dBkXp8tiekNcBA32MM57JKU4Mnd3pNsvBopaw304?=
 =?us-ascii?Q?PJ0mmOJ90t5TomQiXJtQmhFopegYzvPf74n8kXtCNYb5tnoRePsZzuzpvdaB?=
 =?us-ascii?Q?ApGHFODyeCark6Mj5In4M73Ey/mrklMf2H2C/2L1XvTBifwblg6iHNWzqvYk?=
 =?us-ascii?Q?9XSUkPeiXZg7VEJr4aiP7c7GgjvEDCVTNOU+oJU+rQXuvJrg3rD1GU4evNMD?=
 =?us-ascii?Q?PxLl6NHBdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0cbbf7-5a76-4898-c928-08de750d5485
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:02:04.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7mXppbs4NLe5OYPfP055oWEhIpa6OcVdWfAWIRMMXAUAG+OjHRdQXtC/7WP2ez8Tt4P686kQ7PJzsuL00dlAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261221-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DB871A23C3
X-Rspamd-Action: no action

Add tests that verify that bpf_fib_lookup() is able to resolve the
destination MAC for an IPv6 link-local address when specifying the
BPF_FIB_LOOKUP_OUTPUT flag.

Output without "bpf: fib_lookup: Allow output lookups for IPv6
link-local addresses":

 # ./test_progs -a fib_lookup
 [...]
 Testing IPv6 output route, link-local, via first device set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
 test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
 test_fib_lookup:FAIL:fib_lookup_ret unexpected fib_lookup_ret: actual 4 != expected 0
 [...]
 Testing IPv6 output route, link-local, via second device set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
 test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
 test_fib_lookup:FAIL:fib_lookup_ret unexpected fib_lookup_ret: actual 4 != expected 0
 [...]
 #119     fib_lookup:FAIL
 Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Output with "bpf: fib_lookup: Allow output lookups for IPv6 link-local
addresses":

 # ./test_progs -a fib_lookup
 #119     fib_lookup:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../testing/selftests/bpf/prog_tests/fib_lookup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 9e933daf56d7..3dca6fde249b 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -47,6 +47,8 @@
 #define IPV4_OUTPUT_DST		"192.0.2.1"
 #define IPV6_OUTPUT_NET		"2001:db8:1::"
 #define IPV6_OUTPUT_DST		"2001:db8:1::1"
+#define IPV6_LL_ADDR		"fe80::1"
+#define IPV6_LL_DST		"fe80::2"
 
 struct fib_lookup_test {
 	const char *desc;
@@ -207,6 +209,14 @@ static const struct fib_lookup_test tests[] = {
 	  .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
 	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
 	  .ifindex = IFINDEX_VETH2, },
+	{ .desc = "IPv6 output route, link-local, via first device",
+	  .daddr = IPV6_LL_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT, .dmac = DMAC_INIT,
+	  .ifindex = IFINDEX_VETH1, .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv6 output route, link-local, via second device",
+	  .daddr = IPV6_LL_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT, .dmac = DMAC_INIT2,
+	  .ifindex = IFINDEX_VETH2, .expected_ifindex = IFINDEX_VETH2, },
 };
 
 static int setup_netns(void)
@@ -289,6 +299,11 @@ static int setup_netns(void)
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud perm", IPV6_OUTPUT_DST, DMAC);
 	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud perm", IPV6_OUTPUT_DST, DMAC2);
 
+	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_LL_ADDR);
+	SYS(fail, "ip addr add %s/64 dev veth2 nodad", IPV6_LL_ADDR);
+	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud perm", IPV6_LL_DST, DMAC);
+	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud perm", IPV6_LL_DST, DMAC2);
+
 	return 0;
 fail:
 	return -1;
-- 
2.53.0


