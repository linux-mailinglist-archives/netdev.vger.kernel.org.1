Return-Path: <netdev+bounces-261213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKtoJ3f+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BAB1A23B5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206D83013880
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114C539281A;
	Thu, 26 Feb 2026 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UlGkyQrG"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4E3921FB;
	Thu, 26 Feb 2026 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092873; cv=fail; b=l8vNVt4tZpcJdJ7x72miXnGW0RC2QIxi0oirmTAE79GGiCWT6+TFIhBLNVaypwwPjrpajg9z+rBfKFTQlh6kGR9u9scAnoqFBzdMGonsyqkPMy8Os/8UmkczMgbgt1pugg87XCuexwKXS80Z4nKlSu9n0cMVDLLp7mxsoz3l/xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092873; c=relaxed/simple;
	bh=nMV1uDZEtjneIEdlHo+XnIaUBx/H4+bqZBkXwQj+C7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSgsdHuHoqUg9UIwgFaP7YiNsiN9zDSVoc79jFXs7BoQ17yxpWupS+0U6SVNF+yCVWDazX9r07iBHAxnIHA6GXDIiLhNy+dpRIjTmIeU115X9jFIJOTN5ie2hsziTs8LSvxbheq2sLiyHKY9eq9/uy729zDTFAj4OQHibjka2mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UlGkyQrG; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5E3UKfExCpjhaaXeoTAkosEptKZ/OiaUMO9m+6hbGDznLtMz3c1HS5Y/H/kzYVZQ6ssRMxIRbBtvGzxmQE3h8M3N3bAvX2NSmSpAtv4v6iTDY1UT4XNwo9cQJH2JH0SF/MqgDAxLpe1FP/Na+K163BF8SOcGbgvFihkzrh0H+UHME7qLvL/n4ev8gnhlpZm3rmRQk1Mblcn5BBNwgjHJfg1l6AOHBRtiJf2CYZs/si6bye00LXku/4RXx1ZbKvY91IDCNusJAOoW4594+y3v9QhJdEsTCy5fZj0FEUI1iHEEbEnvaSjOTwNxCxowYM61a4b9AlrbFWhvPfhaN7vNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVgjdpb6P5ClKoyPEyBRFoOlIoJ2PXg6MZ3ixzDKnzM=;
 b=CQXxlA2aTvkLEVjYXK8SUJS4CG4lkXiP+0/Bgtq9cffjMAhB4wBcORZF+boUKIlTHsIISfQFwPvwiFzWQ0zg0b+U9kkt3/KHNPhZB3NPV+qVBSJnrtD6ZydSZ3iCayqIjy47sjA6KsNXAzTJFzZoTWXWE5YUlTUcKe4duSLFt8QYtMf3mAVC2lzQXUSvd2S019eDkoefWGW4ySQAZxNq1b6Nhs8yuXcfWYl9r/vqeuCNkqEYEhXQC0IS435HlpZh9m1AT28GjFO8HYrFFvRcYpUgjPkEtkYGUFBrJTkGeqoNe/vjBj23ZotwQO3xml3zX/0jrnnBlETqVpj1ZtnwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVgjdpb6P5ClKoyPEyBRFoOlIoJ2PXg6MZ3ixzDKnzM=;
 b=UlGkyQrGq/NpGYdzpxEd78OVsOIIMz1VbBJm+T86o3XjSSq1zeaSPg6YePFmLbo08GULFIoJK+i79Tvr04jKYA3lEC3Svo8QndTv9dUIjBevZOq1Og4NebhFXu2Upjt5NM/m3ETKSbLowlsgWIDV0a6C0Wm/lZADk7U9UN6bqZ5GkYiRicdh15If5owcvKrVgnShLrlxhrBDXRin4K5FbYBHoYyRYGDBbo/SeKoWgHTWn8n5ZT+9la8HT9C5zSh4gYBgDFW7bTw4cu+BWHHMp6BwvAgzk53VH4CNJdLtgtgLD8eKR90htZbudH781tbosktkHhCyNAcY6u3fFP43Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:01:08 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:01:08 +0000
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
Subject: [RFC PATCH bpf-next 3/9] selftests/bpf: fib_lookup: Allow parametrizing ifindex
Date: Thu, 26 Feb 2026 09:59:57 +0200
Message-ID: <20260226080003.524935-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 43aefe5b-a9e1-43dc-d7a6-08de750d3301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	MwmLEbTTfCDUn9TcL5JPd5Wf/4cIFKrLZbWPkTUS4KVOU0/5OUCsS2Un3hmnTNmsf6yQYfjymLhAm9mLV93fxZvS2HpJ08erzvptKf8KURQ4ds5WomzV+HBCWCFZHFpLWYjqZugiZUaYWhjVLtw/iDN6EdOXmkGOZsJx4L2yK8CzHmYoB8HiENBWrWRoMUtlSJi51frYpLaIuiejulSQFoxRvXOPtwUhEAq20NC6U24vKXAqOuwfq+EawA0vAGUCKOxoTz4L5Ao9xXpWIIT8+vj5PrsrvAySlYvEfMtvqoFqePZkf+tGxFP9D5ZE3fC/fFL1ak/maq01uC3uz4H5bzOPSOK8PMmwRvAEZtRc/PJCnC4odvvC5rOZ+byInp9jzL+B+MXCQ6gSINeWoxleQBCe9CE7F/9P1SuRxpyHz4GpNe31jCBl1s1Uyh1tca+hXD5216DjXU1sUpMfnCVYe1QjIpSrihQnMI9X/cCPSVLeB+zUkR1kRLje0azjQTy3RHu/IDoC4M4WLXO1i1wT++IOpG542VxcFN00/JvKCbJyhySNfK3AJWRHX1LoGBGlIwOsQXQy/Mqvo660vqBaZ++dGc/IfAtY/G77z0YINaZZ43FPVw7KnrUDtgQOzE/gDiI0tormADh3mrKGyxjIxdwtBFCRPywDsgVMGUH7EPaY3nC9nRVtO6bv+W3lTBE56eZyVXi8+n70KBxrslR3rGwk8vJAAo2n0isNx3JHhGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hc4YrU5cFM6fO54XcY2v6EG6DwqDI9GYtTe5mSxdzwUGLYcz3idLEwVTDURo?=
 =?us-ascii?Q?cIyQIMxt2EaNjGRKYaeIQHn/3gtotSbeH/PXs5EC9/QZQNn8ZFjCmrJLDDO4?=
 =?us-ascii?Q?CZbJ2BGVywmaDM4e0OI0TOvnEPQUGCihRAH/yd4i04dXAvzquUVSy3QId9k4?=
 =?us-ascii?Q?tutx98F98fJ4mi1Xpr7Gkj0UhCoJ295KNt9APk+5d7Kz8mDVLqu4c+kkakMM?=
 =?us-ascii?Q?cM1GuH3sO03CAc9bZd9D6UiB6linIzzDBM4UcNBmZWUB05BlIfHyYecUNYZw?=
 =?us-ascii?Q?krlAxB8Y8F35n5iwLJOJ3d2HZs1a8jYEoEBIN/6MxzG0VNBGW4VvGzgS5EOn?=
 =?us-ascii?Q?17KJT+M0l+rERg4hzVR5JIpPWoR/cTwFYp8owqqzH1sgl+Y3JrfZG7XpgfSE?=
 =?us-ascii?Q?t8cauR6qViFS5xlPsrGsGq4v7Zl0m0PO7B91vsrqBgXoyzIWXTXZ0gTzNvJW?=
 =?us-ascii?Q?pONC4IPXdQEeHLdwoNtEtPsCiR7MQQHRNpMgdii+r0qeaGEMmICoAMVTJ8My?=
 =?us-ascii?Q?sJRJDsYhyqUtdjaGNUgieeB778bZ/Ifu/og2Vgc1aLJhqjpGKmyeoZacsKlP?=
 =?us-ascii?Q?0ub3gMSK7OYMrHnSeDzFi8wz0LxhF9fXh7g0Y9ftYicNqxfAwd5jP19n2gm4?=
 =?us-ascii?Q?7tGQj4SZw3fPtOnftHpp1aHtW0gEKIkiUzEDfreltBBLCiIehHgpLfYCturK?=
 =?us-ascii?Q?ZUN3qzs/A0p1FByDi5GdgSOJ5h29Y7hlEKvl80eldUh5gsnxy4nW7M1gosFK?=
 =?us-ascii?Q?0z8VOCkmX6UzJnHf2/Ne4Sitov4XMrS3C+PkIONBKvFwKEa3kkwAiowqO/rc?=
 =?us-ascii?Q?2lHD3kdHTeWgdPiQ+gbKwUFX1w61K4reQmIbzA2hH73HJ0L7dNBtqYf2GWvb?=
 =?us-ascii?Q?NRPVu5PJHTpgjnv8L5S25Bz0pso0dPkd59O61vCAoSKnR+7I/eMgQIIk5y9A?=
 =?us-ascii?Q?a2Or3fUKTGia+4Lhb4j9re3jpJOSkwSUKR5D30a0IjJQ6GShejAeZAu0qkI3?=
 =?us-ascii?Q?v6mk/K8uc1ytLmb1PWb5rrstiJ2MZBFXv6pxML67CsZGrTHUIe0+JCa/ayYO?=
 =?us-ascii?Q?kNW8D+jPYvYBa4I7yeUBbmWz8acwsZP0HhbpDgfakZU+KstPSICfmX3iUdZl?=
 =?us-ascii?Q?8hg0f46QsaCyelkR3mEGW46juwXXfi8hyfyBHTZMiuFI/UI8GPWjklJtOyVp?=
 =?us-ascii?Q?sfRNoFQ4x5WUWxSOctO3Kf0lCMrYI8bK3eQiu0vjnSG0TZ+jSee+dMPoHkku?=
 =?us-ascii?Q?ZDn4gTZc7GFwPMEafgFT49XY9asai8iFTJgwRzgDBWoHcpSrVaQCXOofdSzo?=
 =?us-ascii?Q?iSk82htq9oMgQiW4rFFj9VNlwyKYWFWI7Kg+WwA2dt3AJ+NYqF0w36h7drF3?=
 =?us-ascii?Q?AIDHTth7q4mVykq66ZjTPy8aDn/JDWCiQZc/kEbtSoYJBw8DUr4i9T6KLE1O?=
 =?us-ascii?Q?aqe5dlb+fMj3g4BzgBVnPZ8aXhvlu5iMMAzmNES7C+fysJL3T8QX/Se7q+16?=
 =?us-ascii?Q?D1WfaR9s2y4xJd4BH2U+mK7t3H0W44SIdwWdcKUFsl2uJ5Yct3mU1YkdFQdh?=
 =?us-ascii?Q?EHftYAq5Hb68RR6AGR+lt1RT3uXmQKjQGm5oCctM3IiopvU1OQ2m6yYbiBef?=
 =?us-ascii?Q?x9kMdNri5kqOsRMpVNFYbnnnFm5dJt8kNkhd1gpD6Rran1mEcHoJe814tl/i?=
 =?us-ascii?Q?JEe4xo6pm1oaKoZRUaQF0apG59stHSQ3LTriAcZT4GgLL9B6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aefe5b-a9e1-43dc-d7a6-08de750d3301
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:08.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUFVywRZt453sC0jwqBI8OAR+4q1wA0Qx6TMQWrLrwcp75Z0KaoNc9vvc7baLuEEHVdeCmP9rHpnCf9fL5E1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261213-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 30BAB1A23B5
X-Rspamd-Action: no action

Currently, the ifindex passed to the bpf_fib_lookup() helper is always
that of veth1. In preparation for output route tests, allow test cases
to specify an alternative ifindex. Default to that of veth1 when ifindex
is not specified.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 14a6515a453d..cd306bd4819a 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -54,6 +54,7 @@ struct fib_lookup_test {
 	__u32 tbid;
 	__u8 dmac[6];
 	__u32 mark;
+	int ifindex;
 };
 
 static const struct fib_lookup_test tests[] = {
@@ -221,15 +222,14 @@ static int setup_netns(void)
 }
 
 static int set_lookup_params(struct bpf_fib_lookup *params,
-			     const struct fib_lookup_test *test,
-			     int ifindex)
+			     const struct fib_lookup_test *test)
 {
 	int ret;
 
 	memset(params, 0, sizeof(*params));
 
 	params->l4_protocol = IPPROTO_TCP;
-	params->ifindex = ifindex;
+	params->ifindex = test->ifindex ? : IFINDEX_VETH1;
 	params->tbid = test->tbid;
 	params->mark = test->mark;
 
@@ -335,13 +335,12 @@ void test_fib_lookup(void)
 	if (setup_netns())
 		goto fail;
 
-	skb.ifindex = IFINDEX_VETH1;
 	fib_params = &skel->bss->fib_params;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		printf("Testing %s ", tests[i].desc);
 
-		if (set_lookup_params(fib_params, &tests[i], skb.ifindex))
+		if (set_lookup_params(fib_params, &tests[i]))
 			continue;
 
 		skel->bss->fib_lookup_ret = -1;
-- 
2.53.0


