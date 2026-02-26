Return-Path: <netdev+bounces-261215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ4fBJD+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9151A23CA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D4D9301DDA0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445B392833;
	Thu, 26 Feb 2026 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTGWaxrR"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973439282C;
	Thu, 26 Feb 2026 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092882; cv=fail; b=TTcmv8mReZROyt6SQLCToH7CrshHjjrx9JZl8QOQOWnX4NA299N3KgAB8Fubn64NJV8tvEajIBp/FO+qudFODsa6PxIls8iU7SIXOh//6RlGwNuuJAdjjG9aHoAxOU1KayZNwo8YK5F7+8x5dlESVORPaugrFdYEvF8IrXloFUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092882; c=relaxed/simple;
	bh=ISz57vpOd6FVf9m65yBjZEwvN44s4wtCvnCu8AVFNzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdbmOU1Xv2YdxFP/U4YfBS1mV8ZumSCksB/YqyZ+pz+VRWuk1r0xT4HGZQrD/+nkSYix9iSCcLexjZYlOECMgcX/hgHUZBXalKfva+x10bOHHTZMI1UkHBg+md0TkDHALeR1seov5Fen2/kvCOKswbemB58BJoi646j3PzI6GiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTGWaxrR; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVADKD5aUMyiUvW/tSWHJempnmUAH9L7plHs3RFXC2dMix7AtOOc9mH9LEiCVT41XA49/+/GDS6d2mRC686RIgISz4nTzRzpaBjzHlzTI3wynxVbgiWretXtfVe49GrfZHWQgZcBtibvvBpYl3Qoxv6NS4kFRvcIalU5P+375e3ierMC7XUL3CpI9LxS5TfVcahhWQocUaiymgIkGetJDhaKYuEoY2uF3ztIPrYlzDZzUBB/I8NGyc1z909RqYr/cQhBGEcG0qjw4yNhEtqQ6jXP2tqTuxrz/zdp0LeGr/wqUd8iVEZegqPQxgXJF/Smtgs2Xoo/mzqmM3ESvWLJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39OAyl4aWUZs7kKZVJIfor+oDM1IxYKKaeFlrESsxnc=;
 b=LDbkeYjO/kIA1zrH2dVv7Q/R1aH+BFsWGvDPcpu5X0Nxi5ZQEIbcge562UuwgOKeDmAZKx5jLqTxtmHprq59AjIs2+dQ7KlOYx4GDwp9cKZodS/mcs7IjnQdygv/oK/8zyfxUSbJ8Q+MqZD0uE2KKkQ+7JxDxox6DjdZGO9ciVfNnfSPOyb0q9cktJa+4Dp+KvVW5dM8MouZ0aIM+i7KNb88vGMagxiYSZhsvRkuNi4BT55a1EQ2ly/yREeijtICH4Os586p2AVA3z4+CQkHpIgTnvum28w4jA2x6fZj5HapIaZMbiP918Ix3HmW7uwfWYvF8NRlYNVakJJ324/KUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39OAyl4aWUZs7kKZVJIfor+oDM1IxYKKaeFlrESsxnc=;
 b=iTGWaxrRrAuWoD+/Z8BhOQZI7O1H0t0xrLSrh3/ROeqE/Z85Bq+QgwKRF1sh+OdDSLNo/5qBvlWRhsEdVsmz00MyZBs0z/KvF9hFyteDP8Tgc+l2K+iwA6WyG0f5RUmzYi7ZD8nlHdQKBIRINwNPEeLI8l6IHmR3XUonXA3jWYdI7mMRaOLgy9JU3ZgRvC3tNpQn/eQn+4hxw11iPCjjzj/yQ8W0Tx1XiihZlUVhYdOt1uXM3Ac0pvKYpMqX+5TCCEuNSOFCw1kVF0dzGsdTBMdDkEK6xgUrw9k6g36xI4Qns1edCdrUlsTw27FnpXKxLAigenxjGyU1pkDzbMYeYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:01:18 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:01:18 +0000
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
Subject: [RFC PATCH bpf-next 4/9] selftests/bpf: fib_lookup: Allow testing for expected ifindex
Date: Thu, 26 Feb 2026 09:59:58 +0200
Message-ID: <20260226080003.524935-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b25d9fe-76b5-4e81-5c91-08de750d38de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	iuvs10iww5xpIeQ+F7Y01eDL/Rprl+dW0pIBHNF/dINsFIb2B2Ti8mCq2UmzCAAWOIunmpfwwRuVwBAaxUa5kLMqJLE30TER2HnFghnfw/IQ6klTPcmghdpxCBp+K1Exj0DXCGVWHQha2AXaVMD3ZFauT1culT63g3vpgQcnwK6jsvCkxQLT1WHh2FY+Fy93JVpmVa2hhJBiHCuje5ccqMjvJMaNJUNxMZO39ptnK/E0BP5UiiYMjmZnviyE3b6KiTndnbxfTZ9cakj8iAyRUHpTS3Hu1AQJY7M9zATOctmW19AyDfg7ZMGk+FsWE29KGJTIult7DLxpPvgctIhJIPslyjgj+j+7PoM1NYgtGuKUILXlbckAGCCmze+U1uaUU0Uk19iFfZikVImXHfLHHPo3dtuF2aY7WhMjo7qKTIP9tHzSqwj6mYdgU+g7eFzRrNYRiHCcZSH/jdvHM4DACBkksQlzoTKZAtUwDfqeZvTqPvdkrmqajyeqwfJxv842RGnzzUfll1yUk5YSMwfNj6A3LZVAuA8ul4Oz/pn982Ccx33GvMZ8dRBGNfOhu2PVOnh8uA60kPvrYmFZ48IVuAFxHtxrk7GHeJSe/eXyLcYosGCJ2T4jL3aY6YBh4iXsbh0BED+GNTPcUijhMUv6HnwwAdRPkKLeGMFs+Cmf1KIQoay9Q17GiX/M6IlDfZc3T5Nnn5Ghha0aeuRfANUSTUB6MCXJWXFvnbjeSuKCyJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBnBcfnLyfBGVG/PnPJ8uOvQXuN398mgwgqM9te4cBd2jR3V7am/o3hyEhoY?=
 =?us-ascii?Q?etQ7CDDcDsu5K0wxwVzTpYfjeZ0+jm8NnAbMjwE1lBiYXCjF5c0wPdACTLc8?=
 =?us-ascii?Q?59gs0y0CH6gbxsouS6Mo0mz3KNqChUtdyC/1UTXrq5LWILVHCHZ8RYlh90EM?=
 =?us-ascii?Q?aqWi0FCl9ojwyRhQddpEvRLTanb4IdjtrfDJiPBPABckL4eqGXVIR7bZEWiS?=
 =?us-ascii?Q?rQRjvLlgKbo4rdatWQk69Vvxgrd7JLQaQ11ybmytjinXqnUHVpCOCXLDaRQl?=
 =?us-ascii?Q?9SsM5zdcktzs7cuOpuk6ndXdwUvRC/fxJPt3I7CNQbPzRHrLwx4OmEX3szXC?=
 =?us-ascii?Q?zHOIHn2RYi6BxmUFzl1F/pTBUdYfqE+ksHUQsQDYTA5LUbgmPhaJ1JWnru+H?=
 =?us-ascii?Q?O+3fuTns50YJfFg42NBT+CJ5J4WClpKQ0tRoqhcQMg60MZbTk9F4tK6v4/jH?=
 =?us-ascii?Q?o9gmf7oGQnntTwe+MhbrfPyRJukxNjLTZWgAMtsAg480VE4HTonES4NUxwjh?=
 =?us-ascii?Q?dT7qKfZShKp4PcTecJMZend+h7AjWR2h+gJ8sIXUDzSCbFqtprZTYEjH4rOr?=
 =?us-ascii?Q?Fg4X8rL7SBi5Mf1BEQ/4Fh5mNei2L//TxPmbZPwGQpgWmAYO4JAN994jQUYF?=
 =?us-ascii?Q?sY58MJedk/Z4KKErEYeYivp3x1B/rC670vyCM0nqzbeTqMPQTE25tn1FBiw+?=
 =?us-ascii?Q?TSmEmQ1vCVt5oCmW2ttHN0mZ7yOffHovrkD5oFqzVnI7vBmPVpU3qHLbTxCR?=
 =?us-ascii?Q?xthfkbfjFjYvaCcfnuhw9wFQsu5/QU0vmCRIB/iBKugd5GhilJsFy9eN32LA?=
 =?us-ascii?Q?pgCX9XcGVR5z/BYY87S653XYqhmePhaviOb+eM/tLU+IInHFY5QB0zktbNG5?=
 =?us-ascii?Q?VjWl35Ba/H5zSHZYBw9ILV61k2lNl3qeXK6r3W/02d+1cRXfPzytAse6P+RN?=
 =?us-ascii?Q?1D6CRjfKFyQNGn+90AIzM7kQE4nKwSj14dBotQ5h4SPorwINCGx2U1EIHRtt?=
 =?us-ascii?Q?525VlknImzFcaEzpWNjEYeetzGUjiMejd/Q5gfQzktiTPqRiR1VWUXBW0AjF?=
 =?us-ascii?Q?IpGWPa2oBTAO2WGwcUCfRHuPU1XcSDApSV6VBJbW7fr6ryWc3SaMN6/HXWIX?=
 =?us-ascii?Q?PGwGJALV/BkBjZWigaAfF9HTPJwbtpLHg62lCmlDD8Z6gQDkgzNtoab44Cx8?=
 =?us-ascii?Q?MDslNO+umiisEz85ftQ+eqakWQTS8taplaxh0/KPPaX3aM0r5zn4CIuKlFdo?=
 =?us-ascii?Q?SYqGQ5oaPA4kIo4Jw2mhNrCzAUrGgySLabUF54EO5EmaKPNbSlYb1NRAam6X?=
 =?us-ascii?Q?8FQD9fB6/u6auIA6CUGdk3SnS/mYc3arD1kmg7jUoPF6FuQBF/RQQSuOMa0k?=
 =?us-ascii?Q?4fHtjKh5yHeLwjtCbd4ED64Ie8ThLgDkGC66WK2PU1GgRSAOZ8GGPgYYaD0s?=
 =?us-ascii?Q?6yy2rFHgmAJ8LvtDsVfCC4zYgrxvJDpXeMIbsyNlH4aVPZPmRDFGZXS9WI9k?=
 =?us-ascii?Q?ijV+1seB4Qt/wsh9dmEBdAIdexNTgQBiJTMnxAHfXUYkAacK4wNobEJVwohL?=
 =?us-ascii?Q?jch73LMJ3jiF3nn0QVC9uArJUAO+i8qgSQ+2rWwlLQPxijkz7qMqsqo5tw2g?=
 =?us-ascii?Q?VcbgtsgpeAf1aW7XYCFX5YaVYbllmX31KtuxiGCN1fsjWMkZOTVadTPZAElk?=
 =?us-ascii?Q?XgpcMqrp+D9U3/EUxz4xX7PYle/ZGgX1CXp09iNlLRE6wjZH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b25d9fe-76b5-4e81-5c91-08de750d38de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:18.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHQ4eYtpJLMhb0FbYQdRCO2ZA1u1gaLG59b2vmd49iw9qp5vLg4JdfCyBFwZr6jZAfSAiaqvpVve1rU2wMwqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261215-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 7C9151A23CA
X-Rspamd-Action: no action

In preparation for output route tests, allow test cases to specify an
expected ifindex and verify that it matches the ifindex of the nexthop
device. Default to not verifying the ifindex.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index cd306bd4819a..0541fd982e63 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -55,6 +55,7 @@ struct fib_lookup_test {
 	__u8 dmac[6];
 	__u32 mark;
 	int ifindex;
+	int expected_ifindex;
 };
 
 static const struct fib_lookup_test tests[] = {
@@ -359,6 +360,10 @@ void test_fib_lookup(void)
 		if (tests[i].expected_dst)
 			assert_dst_ip(fib_params, tests[i].expected_dst);
 
+		if (tests[i].expected_ifindex)
+			ASSERT_EQ(fib_params->ifindex, tests[i].expected_ifindex,
+				  "ifindex does not match");
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
-- 
2.53.0


