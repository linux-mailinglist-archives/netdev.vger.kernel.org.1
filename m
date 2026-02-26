Return-Path: <netdev+bounces-261212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHQQFdH9n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:01:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CF1A232E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E29E530060B6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DFB3921FB;
	Thu, 26 Feb 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hapGXO3i"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516A3806BA;
	Thu, 26 Feb 2026 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092864; cv=fail; b=IYD2KJIvbTWhRrERZjCVc+5mlwB4pzUccKfdUI/KUENGxjJUkkV/Ay3nVCt0i/npJFwe3Z4T/BEoZc17akrLglSUHCd7OiaIcNbv8JjroFotEY1bF0h+RKz6xoKw8AzkRW+zoPmgpuUXIK+b2l8ghq/OQXOH5r1N5yIE8FB+FNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092864; c=relaxed/simple;
	bh=110DNtwBWl1iEU8CXPWLyGpJXHAJw7BVoXgGhlB7fZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdtBM5IQN+1/hUPBSlnVXp6VpJQgRTf17LsZf3jAMFH/xX+pKL0Za6vFXNxthJYZAZA3V3QGIBbUI36Jvw9v5+JBpH+JsKQD0m2ZAefgqjgOkm3I0QX2I/t73WgmZT9evUpd/vDcgNg6VydTPEx4taBRgwuilmve1hJrvSlI8IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hapGXO3i; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo8HcnGfN+Rvx/HHxHqc2V3f4GON4jtZMiXWGfdjX4Pf191cWkhMGbdiz0OjsSqP1svnQu7uSLemjLaNKZ6NEbM2IDRhLord4g9UM3RhdJqsEp+4RtCB6cl26MsrM7CK81phgsJOSo6QssG26ca6z9SaGBH3UJlM9beCuxXhj4gxE+VX20HQCptYiqy23A3jFgRQQGhZHAReXNvYH5evfPNWKEDOrjvJOHCvH5MTSD3vEbahkTQqjqfDsr4VKDGv9PBEoyUXHE3F6YWtiEabHx13f1u123dNYu5jt/zyJC5pQoxHltlCZdunTIFXe8gBmTiRYguHPfy3X9R3H6eovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH4aylaQveDpwl75cnjrNvLogQay8zp7RGQNxnEYml0=;
 b=L357+ADySDiWAMRL4Xy1OyFOaqYeZIpUobEkHVUV+nkLb2AgMTwRODjaK6mG7mCl6MPJ9pdFJzAq4bW2Cpi7Ihuxs/HHw1I77lc94IEVNSTXhEfaQkx24vyMw+BiiU8gycv3DIEcIZRETeM0hej5kCXMDdnpYaR97KsQRy+vt4LqbSYj2GgJF2Hf1jbjw/6usOnGJFcrp3OU4yTS/elQD1XjWtrtRS/psV/EOvYwLQMCCYf2vBtcyAb6to661M0jyke1JSDQM9rAHVr5fqd9FFUUClAf50zkqScs6cEQRqSv60JWlboo2sQRySqJU/61fErXlNepwuWkSqtE608USg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH4aylaQveDpwl75cnjrNvLogQay8zp7RGQNxnEYml0=;
 b=hapGXO3idUblZxf0/Z5YVIyps+HzUG85/6iQWCTOe2cZMNSpnjFUDU4F1NGKBZ6T7Bg0slCSJZscQg96OkVTb/iH+ubWntNcNilP9nJyloDNmcPmHuwAe291gDdReWvWS4lthnTEck889DCBzLe/AGSyVhLmb2sAagx8e5W9bhNhqsQIKqdcqyQ9QpBYncT46yng7gd0O5TKgdx561qWb6MT6IkmMl0IuiEmUsLhpqFSEF22Y6BfhA6nylAS0XTMEpW3Dzs2U1nDXcWmhvbCQa21kSRT6C6yy6jvc0zDMyObL3YPvkBZe2ayPLdgsViFFzrrwfhhxglvhBvTzN/V/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:00:59 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:00:59 +0000
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
Subject: [RFC PATCH bpf-next 2/9] selftests/bpf: fib_lookup: Enable forwarding on second net device
Date: Thu, 26 Feb 2026 09:59:56 +0200
Message-ID: <20260226080003.524935-3-idosch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77a42cba-3b63-4b34-baad-08de750d2daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	vaaWHODP7qchnzjGni6UKNdjg3CR00UicLpsR8SFPImwrJnIV3cUOi0tKF8qUdmzXK7zmiOqqzCWLF/2RSyOSzNvS228CpUHISICsuS7qYe6NhZLOybFq1TbdA0WON0Tf3LYIvQxDRy567fcu/3ze/e6Lg3u0ZKfWdLT2xB0Z6u+kjfRBxwm5uflhfiF3AGZ2mV5kFkwOVCzi+MwA8yp2L5yuhClQ8Jwr3Ig1TYgOLCETmV8ooHYZC//+flUE1hPUG7Et256PhKW8Ylfw1gYG/gnJ95AOTSIwjcpBeZ2cEwiZF8M/Ry9znTmqOsT5izFubBuxNQSD/myniOn80UWl6NQU9qeWN9bfdSoux4vRP0o7IaMsjKvr0dq2VRJwcXjpQAkFYN6Ia+DkVdemjp84zB4znjMYbPHiawzdDAq2ln8/gZWHJ0Sl2lYENbJUko76O/u0ovxcJ1E97h0zCV6M15wY6b54JWboykNyfYuCjbyqAJobfj5M/GOtkkNqjssGpK3J0fbfUOe9fPyK9iqNaaWUdVZ8A7mBGAF0Zp12HgMFqegzrgDYtMAbIQuki0BSxug8hYGwfy3ClCqWRg/nZyU5m70gPhcpMMLsk+eN40xK5/CdYm5Ql6/J3M6spVf7bl0gjqp7aNiNP/n4LY1wIARnOwZoW/eqoZ3fb+HqtyfTuPUqzPiYK5UIwgWIj7e9nRGwgYvtqSfVMWCd8FWD3xjMVG4DDguHx7RO3SCOKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D/oWduim1v9LCPpjlCevm0U0jm8dhsUXTs1M2AxNrINIK53M6hch9NIPiM0M?=
 =?us-ascii?Q?leprFIxkym5boR4TrIXsl031owiJRO6PG5eAPVNKbRbXEDLMe1hnsFvOFEgW?=
 =?us-ascii?Q?tgeN1vB7QaxMnKgRx3Mn3TNhutceUShUOh4whcbUd5W9eAkoiHb80v74YS7a?=
 =?us-ascii?Q?v5b0m5dq64jCQQ1XN5GayNdCT4o6JBk1js5tB4EvZAh9GXny6WdlwLyeKpoK?=
 =?us-ascii?Q?2e/rTb7iJHMsBCFt5A2cjdPcNdlHCH1uOAWtJYp6StoowOK+pk8PDUm0VYMb?=
 =?us-ascii?Q?h4GpRnB8i/+9c4U2NLEfRAv1+toaA02Sv0HzfHhwfhldc1ewwJ0TFWGohzTx?=
 =?us-ascii?Q?I31+zL+7qvcBAGmBWTQiVA40v7Sh53FKtV2PxsMtKmDOOSxk/x4h+TMMlEhW?=
 =?us-ascii?Q?y3fqWT7LxNAn6iyt3anYHRWD4AV0hMifaMT9jYN0IqRJgjNf3C34v7I1Pyex?=
 =?us-ascii?Q?aU2E4zI7idKNWrYKx2eBMIC4fBfv5LxMiDjDoY39NCM12BpkBTK0HGPxqmtH?=
 =?us-ascii?Q?wHr/iQIEszUZCFiziLl1m8l0MLqfBahIIbGj9oqTWP5uhVQmb2/NHooTVcXR?=
 =?us-ascii?Q?GedeLxhN6X4yjPinhIy3y+NONiZWjR367XOwBTjYRjPgXiD7XbLVZZb5+ZPM?=
 =?us-ascii?Q?f3rz2Q/NyE81ce98QcG7EY841W5ZxswQWNQVBnufD1UV9KpDfz4rQShzlDwK?=
 =?us-ascii?Q?J5i4Q87pW9ABRT25OmLYSd9m6FUVtgq96qCpVAxtKWbdohEl2bKkW0E/KG2E?=
 =?us-ascii?Q?0qk3xEimF7vjLg6S8fUqgHTMPU8t+eNsRXWlcxJp071YHpNgge17aSQlpnar?=
 =?us-ascii?Q?VVGVcW9ganinyCSLA88E+Rg4xuJduIjHaXzoMpOp76mt+f6ggWhevKYCHxql?=
 =?us-ascii?Q?itLJEbnG4m4qcMUCz0TwDbAKd/gtntgdb6D/8E31kTHDqSCt0EIUhcWsdToK?=
 =?us-ascii?Q?Lh5EH3mwCVN49FqIUM1zh9CJWY9fSFAkNTKK6dcuh83bGXZZROoO5fa64tO5?=
 =?us-ascii?Q?psgt1qHkHQqG00+lI3ekghdIM+fXxWIwBqTn0IFMEypy2Mo8ejmYXiFwBs+H?=
 =?us-ascii?Q?yKynMunwD36EnXY+uc/Qq9QtB+osrAPS9wwHyiIMIC5/r7e6t+PBAd6m+ARq?=
 =?us-ascii?Q?EwAZpqMuQAaqlhdHF86ngMj6aSuwfpD2J+/+I9T/oJ2vDYN0+GB+Yky5daWe?=
 =?us-ascii?Q?ZYQWdePfqCt5DRg/pDyV7M03fGPnSQ+tKtwBCx+vlbhML1p3ObYQ4AgvCv/C?=
 =?us-ascii?Q?tEmmPThVYu2yUYyD0G9A+pXy5DWF7MYZsrhbRqgNQYEFR7OG+j/ninU85JzO?=
 =?us-ascii?Q?+d16FYFC3QjB3JuZHKZjMaCZIi+TjkSnB0xBl7gh8O3fALhldAuW3K6FwMUE?=
 =?us-ascii?Q?xmpcURHcxhqGJ89jNiIdU7a5aovHdafTBzWv/oJ60LcX9cwhdlNADE8E5hi1?=
 =?us-ascii?Q?xyq5+BsYRjMq9n8fDxY4DOlRhGMg/DA4kkY3oUm5FCBEtYuJQQKfMdVWwR0n?=
 =?us-ascii?Q?47ReyxgDU3D+uE9dB3pTSYKX4srGVR7Rcg2yqfI0f34BywrdvJEP6JA3MvKR?=
 =?us-ascii?Q?ckoosWJ24Ll/h0nn5cB7g37fAhQHv9nvhWOlves9oJ9lft7iCYE2roZslK7d?=
 =?us-ascii?Q?OPSPmmYwXg4sNPVnMfaSxRNQaS8go1iYk8lNwsMR0BGQJoByhnCE4RJzcxpb?=
 =?us-ascii?Q?VIub5AirCkyp69/yPPAfbs1EPoYOPkjh7set0mHJaWLMlzl/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a42cba-3b63-4b34-baad-08de750d2daf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:00:59.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ujt7FYGqxyP9nq8nUoNin7ABYIdM+yk5qgl2tEL76DYUxAT58LJK2pMdgGCGmqFLv9Fv9CetWge1tP4M6B1oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261212-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	RSPAMD_EMAILBL_FAIL(0.00)[idosch.nvidia.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: CB2CF1A232E
X-Rspamd-Action: no action

Currently, the bpf_fib_lookup() helper is only called with the ifindex
of veth1. In preparation for calling the bpf_fib_lookup() helper with
the ifindex of veth2, enable forwarding on this device.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 77f65ff7784a..14a6515a453d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -193,10 +193,18 @@ static int setup_netns(void)
 	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth1.forwarding)"))
 		goto fail;
 
+	err = write_sysctl("/proc/sys/net/ipv4/conf/veth2/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth2.forwarding)"))
+		goto fail;
+
 	err = write_sysctl("/proc/sys/net/ipv6/conf/veth1/forwarding", "1");
 	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
 		goto fail;
 
+	err = write_sysctl("/proc/sys/net/ipv6/conf/veth2/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth2.forwarding)"))
+		goto fail;
+
 	/* Setup for policy routing tests */
 	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_LOCAL);
 	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_LOCAL);
-- 
2.53.0


