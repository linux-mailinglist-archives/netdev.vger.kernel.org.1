Return-Path: <netdev+bounces-261216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHO9OAX/n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 496891A2432
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE2D231195B3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA90392C22;
	Thu, 26 Feb 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q8+HBGTA"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A0392C4A;
	Thu, 26 Feb 2026 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092892; cv=fail; b=DGOOcmbl6mwtAwpWzTUCUKF5axDO/1EPg8FdhyzQjiBDHZjKD03WFr500fDnaxFqK9UYy9eUqLfpH5f9DgL2b4/LjaQudanYJjpvkAQ7m3UZUZVU7Qe8igGw+X3+//AyFUaVgvIfjgLIAVXlGxIrJVb9X9JgISX0k2NH17B2Pd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092892; c=relaxed/simple;
	bh=rg+az095yJ8eM5st/s5tUvis8f/UFDObEooALeb6F8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QzIc/TO+szLahCAhokzITebq28s8C2oqu148h7cYHvq/aIMMfwuRD+oNteCBkBQG5+7x+qKOC7SFYILF44rMafayR/BMC6r5tJWDXdz5iW165u1Qs0u874Md+jQhaFq/N+scm9I5nc1l9Q+hzr3LyLZOindLQMDLGQjP6MqW3bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q8+HBGTA; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtxPxVZzuDwpE5eYFTpBtBmXwxE0GnJE7PRqW7nIHJ0D/dFUVpS4EM0vIaaqdwGLoQQPvTBhFZ5FcbaNQiuVXubloKV3Pvn1+dgjryCigqfGpZQDDx308GQ/MYGhuu6Po3NBmmbxORUum4Z6mY21GxZBiWgRva+4MMgRl+guhc5DGzTrpolMabkxEY6y/CQMiPzadaBzvz2IpEq4zi1N71vBRXDQf/a/Lbq/65vi34PXw1Y7Jp65n9Uy70WBSB2+4iC49m4cSH8FldGZrJCM9prOIU+/qsRk4m3dcWHp9QoeYMnfpDq9nl4LrRw+ZZLL64jdx3gDPg3z/HDnmCEEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i88nz5fkd3r6QCrTVCVUMclbvIqK8umCE41Pdb8a8hM=;
 b=lZFJh8WaO0f6fwlWnJCGFkslD/oS8OcN/SP+iAND6vPq9UNlN+XKeIZtqB82TC4wJmDUEpCNwT9DCw+gjeLR1//gv5QeU6SujCUEUfeMT1FMNIkK3HCSYnGDZZms8KzHkRvNke9RCPE843Xt3ImbPYjZd1I2CzLimc/hLNdIxejKr4CTc871NVqTONW+viQe6PnT8r9KwtdcQEh+9QiuNT8Ym5O4qgZXGUoH4J691n3587BNray/85/TMQp84PrKHUXExXdv7af99E6/eAuCAOSfp1bRkDTKjZaFL4JJxk5DQ4wFDhBYft0XkQaAKcwKPuum/58fHcznae+8JQ00+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i88nz5fkd3r6QCrTVCVUMclbvIqK8umCE41Pdb8a8hM=;
 b=q8+HBGTAiw+zY1vUO0Iz7/ZYHsuOq6+ygvlphQ/oG9IQ0vgqMWg5LH/0gPKLchB6eneySfN1ZBUrpzvFwu4X0aBeK0wpUkjBUw2F8Swjq/e9cm50zc+lLdv5S0b27ONWUPVedHi9/27qgxUWSuGgXAYILiiVxCqwaMmMeVLfKeX7l1CQwaoldYeVwq8kbujytAq3tJvf43arc2Vktd7hFmiwZ/M6zQwawjRCmnFdG+XiSEck9kH40DADoAWBCw/gHvCRs+2ntCvrCtTnRhGS4l0oTifu6hO+svxoJ0Bb38OTF8e0NlHM0PGISdIsNoBFsTlFj6rgCozMVcuIkmu35A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:01:27 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:01:27 +0000
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
Subject: [RFC PATCH bpf-next 5/9] selftests/bpf: fib_lookup: Add IPv4 output route tests
Date: Thu, 26 Feb 2026 09:59:59 +0200
Message-ID: <20260226080003.524935-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdc8ca9-6c86-4bd0-945a-08de750d3e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	+mlvHBdH366cbrg7WN5OOPc4uhy8ie2N9uqisG1Z+5I6b9oNLo4vtqGRrQxNy5xtxCUrXwkplka23OpKNOqQT8Radn4VVAkJeMJLP+vM9fgQ15bQevwCrn5ODc38RbBbvBZFLfe9uuS99hbZD1B0nYlAw1h9FCL67SGqwTnEVmNw07Sf5d7s+JFFq8mWvvQjzU5ICPO8qHUJ/r+9bwIGIEmHqbPJhnK3Zd5rB7y+6lx50jqsm9BeKukS3rG3VVIC7soKLLWtCrPSjsd3ye/vCkp1dR77LQ7+M1JebQhI6TB6jXpB7dPyPK/83sjatpMmdzHGg1Fd3FUlmmpzBmfghayuAAzTRZviPTkx1IXFmak+7IwM2qWBuKgjDSdq1Cl7vl7uV+57qQZP/65F8V4orzDW5bPTkYoCqVwRrTjGf2jZ3oEAMvRi1bkiHRL9TfM61auiq2u6hhJIjv1h7O8KCWETjymclXbrGhyKESlLLh/6u1viuZ7IAffl37gvmw7pb+xRo5JsmcNGxYQVI3iBW7n2HtM5ds73K8+bACHtLs4Qo25XLr0LDNgGzGk8QNaU3/UJ/LXdrNM88I3cS7sDT/5JEGBUvuTGneqlgL30KO/Crd2NwKa7PmZonARmPElFtJsJzUCkz/OWuXK4O5xdc0fxSPFLAdQQOsVg9IIWGHg+sCGTJmu0RcMrejXCRpZaORhb9cuNSJZG2jTaRJSvLBhKKdaPgaObie0IEBN64yE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yz1/d6Uq/h5n+UqUCNaXiFOWx4p6xOMj0Q2nkyEl6AjFw1trUwcroU5LUqh3?=
 =?us-ascii?Q?QlGfh/ZCjAm5qectyyICkAgoQavwLXv2M4XGsVg8+6nhHMJNL0/bchFjLMKP?=
 =?us-ascii?Q?nUIcyoLxyNrz6mOGXcY899DT9rx6Pi8tO97KWfHMtWAiQYgsKNZi4/+l7Z+s?=
 =?us-ascii?Q?jbMHzMPgAkPKbm20y9OWK3GULg+XpP6vYJEK7ZMkBT2o7MP38n3d4EU3GtSO?=
 =?us-ascii?Q?pnLrLmS193983dP046D6VE7ijQH4uc87JVvLcwMifI/P4dcpJ6h/j9Jyzd6+?=
 =?us-ascii?Q?bDAMo1EtysXHg1YQJ8I8Jy1YPfTbDVIejmivVGNMWJAaaWp9nkCVMZ3ePRjt?=
 =?us-ascii?Q?NSxF8+5VJjhnjVRqVdeegAMs/aK/gYsOGCWLmscP7mQ1TqDn5pc7gK30rswJ?=
 =?us-ascii?Q?MKcZjYQbg3sgMT8aUWodMPTq+oDbg+JyGDDsTY1elq4VZ9KNd9cApA0UuxGH?=
 =?us-ascii?Q?OFddRyOIhmur5vx4YaVxT1sGa9slggU2FXzHIVtywfWo0GP/5JKy2EA5zC8K?=
 =?us-ascii?Q?DzOCKf8O4O5nL2qo9D/Ox85FVMh/ABQu7C+xuV4k4UsVSoZ2J7CNk/PsKyNg?=
 =?us-ascii?Q?kwK1ift7giE69KTdipG+YZW/DLWwxD6nTvuDIaBHKJHDW1karDGZYPkr+QXj?=
 =?us-ascii?Q?qNVZsxcD1Aja/RKUgPYv4B8pnx64Cv3p5YkWPgRw83pbUfKd8/TwBPiZCqSm?=
 =?us-ascii?Q?pIv81xE62MnyKQn5ItGeyI3GoD9Q5PiQnzoQuuoh2sEVsIX8+vAZvC1jtynQ?=
 =?us-ascii?Q?youC79Didb7S7iJ6X0BPwVmAvjy7ggEXUmH/KTPpqrhppVDJUSf3ouOxcHoL?=
 =?us-ascii?Q?ahCFWV+pm4yUeCeJxignzeOutThGCVaS42NUBlCHgWlAolfCg4O99mVhFjA0?=
 =?us-ascii?Q?XBC2d3EigFJnqKsf6Cq6wvlWX6A3+v22BSO5Fd+iSI4la5cMXyiIS4tCF4Tb?=
 =?us-ascii?Q?6Fw7C6O8WSStoo8FC17t4IOKi+4f28QS14QAaUzK9HrPUxXZOIp0NQcaq/FD?=
 =?us-ascii?Q?2iR+u2nPRk2tmDpV+HPUNo+bMHVy0uQeE4ahXMlAtvFtLSknGABENsncn/PK?=
 =?us-ascii?Q?gu3I5/LXUZa8UITdDyYi4dBNTOBQYtt8jBznw6vNIhxd3FvBbbSWkTS6+atm?=
 =?us-ascii?Q?bBTec0krdogvMJ0iSAA2FHaNwkwY3eje23vN+ExYLvfF8ak5QbJtymoNwswN?=
 =?us-ascii?Q?1RKfPOG+Hoxr6WPcDcuaJoQ+7iy6HXKzKycBDUC6Wim5+Q1eYhUhUNeXDq4m?=
 =?us-ascii?Q?TE16J1IwkDWDEAZWR/08widvBuZrk1b4yG2eP3Rt4CT6Ornm1y6vmvVlQK1q?=
 =?us-ascii?Q?ZSCqVmjibZ4sZe1Cm2PlAPue+bRffpQv577lsPd5MHD0YBNM1OkS/ni/qziu?=
 =?us-ascii?Q?VR+SOr1STqW/a2gjmhq/VBfGr7VvuQmQJDo9oD4X4m5n7DTvBLqrH6Bz8F5h?=
 =?us-ascii?Q?IauM+ouhDEHp2z7Hakulb7rXVDvz8N1HYSHm4ZxwMsLzrmcPa3meNIzoNaWE?=
 =?us-ascii?Q?cFll9zTSDCANqbiAXv7bi6CpDIXd6aLMQoE9x/vBArpL1XEQ/b6GaFz1OG+I?=
 =?us-ascii?Q?bU+m49wqAZDiEBMpIeSM1Jq+ifpl5rx7Kbo+tl+7d4CiF/HmQsmcuMi2Lgm2?=
 =?us-ascii?Q?DE6XHXXoD/VnrV2qS4z1L4y3y+EZArSEVtEGnGjIpClcnwULhc7SB6XMx6KA?=
 =?us-ascii?Q?m4tfFUP7HCcRBAipWc4A5wfZfWrPEihJxjaWH8nNn1NzsRCkZBzDq2yOEKx3?=
 =?us-ascii?Q?Uez2yQ+Uaw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdc8ca9-6c86-4bd0-945a-08de750d3e12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:27.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVYE7kV/xI32y1JLqUunNekqHpGqTIJQM3tpEPIHw6+JOmLtTE5dqZhivurNv+LH1cvmQhmnipW7f0Zv+iEU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261216-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 496891A2432
X-Rspamd-Action: no action

When the BPF_FIB_LOOKUP_OUTPUT flag is passed to the bpf_fib_lookup()
helper the expectation is that the helper will resolve the most specific
route whose nexthop device matches the specified ifindex. This is useful
when we already know the nexthop device, but need the helper to resolve
the destination MAC.

Add test cases to test this behavior. To that end, configure two
identical routes that differ in their metric and nexthop device and test
that the correct route is resolved each time.

Also test the scenario where a matching route for the destination
address exists, but with the wrong nexthop device. Expect the helper to
return an error.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 0541fd982e63..6ceeecbdca43 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -43,6 +43,8 @@
 #define DMAC_INIT2 { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, }
 #define IFINDEX_VETH1		10010
 #define IFINDEX_VETH2		10020
+#define IPV4_OUTPUT_NET		"192.0.2.0"
+#define IPV4_OUTPUT_DST		"192.0.2.1"
 
 struct fib_lookup_test {
 	const char *desc;
@@ -146,6 +148,35 @@ static const struct fib_lookup_test tests[] = {
 	  .expected_dst = IPV6_GW1,
 	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
 	  .mark = MARK, },
+	/* output routes */
+	{ .desc = "IPv4 output route, without source, via first device",
+	  .daddr = IPV4_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SRC,
+	  .dmac = DMAC_INIT, .ifindex = IFINDEX_VETH1,
+	  .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv4 output route, without source, via second device",
+	  .daddr = IPV4_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SRC,
+	  .dmac = DMAC_INIT2, .ifindex = IFINDEX_VETH2,
+	  .expected_ifindex = IFINDEX_VETH2, },
+	{ .desc = "IPv4 output route, with source, via first device",
+	  .daddr = IPV4_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT, .dmac = DMAC_INIT,
+	  .ifindex = IFINDEX_VETH1, .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv4 output route, with source, via second device",
+	  .daddr = IPV4_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT, .dmac = DMAC_INIT2,
+	  .ifindex = IFINDEX_VETH2, .expected_ifindex = IFINDEX_VETH2, },
+	{ .desc = "IPv4 output route, oif match",
+	  .daddr = IPV4_NUD_STALE_ADDR,
+	  .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .ifindex = IFINDEX_VETH1, .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv4 output route, oif mismatch",
+	  .daddr = IPV4_NUD_STALE_ADDR,
+	  .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .ifindex = IFINDEX_VETH2, },
 };
 
 static int setup_netns(void)
@@ -217,6 +248,12 @@ static int setup_netns(void)
 	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
 	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
 
+	/* Setup for output route tests */
+	SYS(fail, "ip route add %s/24 dev veth1 metric 100", IPV4_OUTPUT_NET);
+	SYS(fail, "ip route add %s/24 dev veth2 metric 200", IPV4_OUTPUT_NET);
+	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud perm", IPV4_OUTPUT_DST, DMAC);
+	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud perm", IPV4_OUTPUT_DST, DMAC2);
+
 	return 0;
 fail:
 	return -1;
-- 
2.53.0


