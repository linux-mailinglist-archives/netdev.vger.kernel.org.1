Return-Path: <netdev+bounces-248801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A65D0ED0B
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 158F53010A90
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0F333451;
	Sun, 11 Jan 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+kXMQwv"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9B33290A
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133348; cv=fail; b=eUlW3PvvdvfUrX5BXbnogmBEQZqOAsvEzhC2dBGBm5Pn2cXY4FxlmqeZWqhH7qZ1YB9vdK4LI4CR4VK+bPYnmLrpAGdiByHSJWHgIZTKWtesrYgMseNAmis3oN+I7I4QmCRCzK21MDQBxdmstjbnNLGa87QTzh/X92NBERmAXNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133348; c=relaxed/simple;
	bh=EYhiuohj0kU+uPdf3NrZriATmtN83feRPybloFI72pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVD6CIYZz9Dz41MBT4UcX8l8mG5FR6c3dfcCkaGfWWNSam1hyRh3dv4ohT7AiFiIOWxTyE9s2ZyGLicmXJhRDkPxTR/pXnka7ISvCMx+aTCTkWaA4Q3UIeRlz2YRtN8HHbTcObUvyrtPymRbwuWoSTp3D28RJFusRcRAkgPBCUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q+kXMQwv; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgh0wze9n29GA5Oddeo+JTOhH2OMTP6cGQtcW8t8HgC2rASNs8ofPdnatbMRMaeqFWLfyaH39F0N/t5k1wBzLlyUGltwszuNP9Focbv1Xf/tp9fOvFUbVA9G8zLcviej3i/krl19H3VKo6kZSvrdUXzw4SHLktKoL5UlIBeUXH0IGX5fJARipSF7p+bQYfzK32Zt9Rn2nye+KXH9Z/P1dRJQ0a44hgeCg6DIMG46CK4sA1iEcztuE1yMVGABAxPoD1NRyoYFOngKzRe8zXhYfU8y750VLTRLeuq84No5QuBBxoVtt9fYTkwaWuV2SObkaU43y4X33473bj7Vyhz4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wirBtbXJ0REFTkG+23IGTNsVwb5gSUklprnTbAa1Etg=;
 b=W9HP5kS6B01Z6JM2o8nqbESYOKpDWhOKQfPVKejuqYyQRiTUC/3i+Q6ryFjERFQltCShRm2B6L+98pwE7gAFgy2ozT0rmcRGj+UPMBmoEQP4RzDFtLWUaRIv5Z7OtY/7iQWlcXe1udZHClUMlUC9zP07hHeMkv3xImoDjTJQtDEwteL2VhYfFFoVRSllqPDV43T36oxmE0FtFFwAiY1lsI7jddMr9v3xCXJKH20GGgu9q6oTcEHq+vz294TDkmmbzQJMSxlHuk8jLp9eZWpEu9nR3LTIN94OYvTuY7g18XOZCrsI+S8Wx2hRKY9vdOwE24oto2KOn5ePLhN1Qu5aXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wirBtbXJ0REFTkG+23IGTNsVwb5gSUklprnTbAa1Etg=;
 b=Q+kXMQwvv8jQjJihdD5uSu2TuVP03+wGRjTsoJHpuPPVGe8lpgUp25MYkN9F+c6aVwexz4a9L3xg7FmwjAa0dFfEnxwACOPlhIevRDLjojX2vz+neXv7uS0CgspwKvJBVmHFWiJoGXZwso82YyP9Oj6xE3ttJ8+IGpUDMaMq4axZmcE9JE4836vz59NSDq7rFME8kGjg4T/sDhwNWiTH990lWwM5GRmpwIssbtelUAGNWxtlnd0B5rHsRfCWLio0O+DRJYgIWdp7qA8GJSfzF9zggAY2zISKGusRsnRw8WaVlfc99LA3S+5RSMuW5kpf7FJGkFnp3mM9adfjwU6P8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 12:09:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:09:04 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/5] selftests: fib-onlink: Remove "wrong nexthop device" IPv6 tests
Date: Sun, 11 Jan 2026 14:08:10 +0200
Message-ID: <20260111120813.159799-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111120813.159799-1-idosch@nvidia.com>
References: <20260111120813.159799-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1015de69-b01a-466b-0a97-08de510a36e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?115xRxOH+0BBN0Oq9lfHwNGr0lV9vBdWpKuidaFfYSfzTi8KSDAhlS+CsqQJ?=
 =?us-ascii?Q?WlHHn0tDsbvSsMxMdpQq4vhhMIbmkNl/sHeutxoC+hheFEV2jrpvwKPyVROx?=
 =?us-ascii?Q?uQyxFcgJEbzEJ5eQhxk9YbiGzVaIHM4SIiaF6EfJWw3XkhR7G4SnJ12kmcB0?=
 =?us-ascii?Q?dyk/sbjmUH4wmrWZzPka6arUr8G7nbzAR9Oxga45B1U9Fq7jIK/M04uBJmIT?=
 =?us-ascii?Q?yQW9D5k/CVfjo+HuKrBRpU4k8RMWRxLPyfk0PZXhCpc1JzX2FijEndCLMV0j?=
 =?us-ascii?Q?N+pnAuRuiYUgeeWld5sbdEb3CCdC9I9gVP000oeoowr2/ayRhf9WrGHlWD88?=
 =?us-ascii?Q?xezgd1Qrb6Giwlfth4o/Ka5dg5ACZer5Ckox6nbT1nMA71OUpM0eUyupPnvQ?=
 =?us-ascii?Q?hD7fWgwbW/45xZ+aaq/QIJR4RJppjEdKuxeN+Np34rWRvE4XYzdXIMTgx51q?=
 =?us-ascii?Q?Iy0wi+IIixxZlwU6KczRbFIAB8U8rO4kJd0zSJoblHJMbCgkljYzxj5URQaJ?=
 =?us-ascii?Q?k64A3jh583qo24opifb/wZfZU8HVWa6ynpTQgI/ax/EdkTPlAI8s301+YFmg?=
 =?us-ascii?Q?xNReqHTKyE1dLgpHJGqn9TZqJInuO/ZA0nWu2rpo52tWw67oI7vlYdNBs0Px?=
 =?us-ascii?Q?oDezcLJcIjcxkeBpFWm5VhmwZWIkvGBsvOlOjQ2Qg8179/GZVAS3ZnqI6grx?=
 =?us-ascii?Q?ls8Zqj3xEnC4O2EBuEy5RRpUdDR9CMPtqNeADCtIb6nPpgg8oKkUHLHnqOi3?=
 =?us-ascii?Q?yYXTDCNWuC2/Y7YagdtV9lyEVgLrF2WPse4ZT485pNaclRFcGPWJy4Zr7SKC?=
 =?us-ascii?Q?1197lYJ3Ru98DYIGHYq2NyfzI5ATBFkVOuKLbAtq4BlxvlZ1htmH77fSWgJb?=
 =?us-ascii?Q?l5gXE+8GuCKIZ8O+gLHJ0eOs8t4i3oVXvmVqaJl854hkw5CSGD566uE8ehVy?=
 =?us-ascii?Q?q5WYNLzwpTNzgUEsBeJhsZ2NRUBNiibEvBIYM9ZPhcyhsnzUQUxWo3/sqc5w?=
 =?us-ascii?Q?+iqmzN0qi37Jsvv5yIuB90h05mKiPhFA9MsowXmhiVRyMZD5SWYSNnV2Q76P?=
 =?us-ascii?Q?Z7wBHqpw0WqDe76PedE2kMzR7cilaHq7NiMc8unOS7E/DIQIQwPpYBbDsIXG?=
 =?us-ascii?Q?sFFhvwgtMMNIxKiM4VMhNGM8VTbN7aTYnkjRnb5Cs8K0FUVKiYscyGTVCM71?=
 =?us-ascii?Q?nQ4ovcPaqHGte8ze05zqgbocj6+U0EOwnOV4jq4AfW8rocVR4skUYON+QAEN?=
 =?us-ascii?Q?F4wdCfOYiVpUFSK+/zZ276Zn0OQcXBuBLURFNZVVsBz6B7qehr/BZz5uHLVY?=
 =?us-ascii?Q?Bbza3IXnkDv9LA+vmvdKDIEmaNidYomM5J5l6+N/ZG6ONWZMrh0L3+TX6ijs?=
 =?us-ascii?Q?2mxMY2MfPa+R1uAmYENIM0OBiGXoCNH3K8uye2bqV5S5onI02SG29pBW1nWG?=
 =?us-ascii?Q?OPiYCqLv6uUo4rKh4WE6rshiJsHJDk42?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ryRaM/gF/KXoVFwMjve6+4+vZE6Fxf7ij8n1e+CLZsD0Wzmwvw2ns0j/Hm9?=
 =?us-ascii?Q?aw8jUikeeF2Sp4PfePCECjiKFrgtPM0/Q0Vhdfjsz6hRZnbhJL56X3Ipb5tx?=
 =?us-ascii?Q?Z+SwYHYqvQ+32U5SaeGB91/1btg9sh6NfQp3tCgta1QqHWF8MHYwnG8HyT0V?=
 =?us-ascii?Q?D2qa5IvmhuETyLui4xr6UbXzlSUdy6ahF9M7xiBwNJalifoy7rfLDmP0N6bb?=
 =?us-ascii?Q?YTpCtrelwdTWAkRUvD57nL0LX42/8uA4KrZZTRMytTiw82pbqJRzxXKQRjau?=
 =?us-ascii?Q?sjzfvIZacSIl+wyVB4drcgXLsh8RPGd/wSzKXF7sdNj89xvBAW9hp6coejms?=
 =?us-ascii?Q?eT4z9pfjyi+soEchRl/SGPr2cZI0mbI9z+NRfvRPo7q1ONYaSRCMKCxzTvt+?=
 =?us-ascii?Q?kqfyTu5FFB/JchfJ1GpAbGkfsZBHSCJ2mG5/FCdT998942PputQu+U6idh2S?=
 =?us-ascii?Q?2oFh9KkuyIJ7fYsbb8f1cGsE3Dg4G6w6pF2wKFhyKndqWyZCJVTOa9kcIujd?=
 =?us-ascii?Q?18HksEg/Qa5CqeHBrpj7jwpKrQaA6zvQGihV1ombJuP/bPy0fks/04F/4cg2?=
 =?us-ascii?Q?SFLnNoo5lm579yZrw2HpY/7icKyOffAmkmUgEMzQEvHHLoZP08NcTQWkR+bM?=
 =?us-ascii?Q?tUYTJdTAWIt4CSiczzQk3xKNPRV9uiFWitneKpHb6E0S/GcHs0EMsy1UhFM8?=
 =?us-ascii?Q?VKmUlBJiaussAqx/6zCf6wwkCTxIPlvwBoCbfMoE++vSMV2HshAkYq3bvTHC?=
 =?us-ascii?Q?1OPj76fcjxtbU+PbLvRSh30dJJjkVIBqnCek5i7HAilYSsssD6jmBPsKw5T5?=
 =?us-ascii?Q?8PBzRlBpZSqrLCi7mZL2npxKglplEZSk+pTbkIQGYZPn5VrDKr9ZAVNbwOJ8?=
 =?us-ascii?Q?ALKG5+Kri7TyrJuXDVt8qK3FOjcB/kyxp6ukmLx7EUZY9Hx4G0fp/HdUffCc?=
 =?us-ascii?Q?H3rzAH45vnch8MdBr/IupEMxHGZRNDixg3BqGPbdiv/8Kv4mlvg7a1Z+Q4g3?=
 =?us-ascii?Q?29J5fXtgJ5qbKrUIYxcNPY4uRgaG3N1yLbG36SzQv86xaCK5qsvYKyqcSCzm?=
 =?us-ascii?Q?MaX9fQ2ncHRPvY0aRXF0x5P5o3e4sy3DlkpYDZCx6TARQv9Ro2hzFtYRAfVN?=
 =?us-ascii?Q?rIJTTGpQHbc2Vsvw+GyOURzQUt1jOvDQn3Iwr2UMx/FUJRhExVbTSRPFAL+x?=
 =?us-ascii?Q?e1tqLbQVedB7d68v4cxju0U+Y2k19ukzQVf4qzEf19T8h2FogcjOWkTr6IZ0?=
 =?us-ascii?Q?MZErgR03pS9TJwxc4WjFXnYU1OGVgPsfLmMmF9R/0KeiMcjDmdsHEM3cJptr?=
 =?us-ascii?Q?wyfjz0u7yE9ofGBqa7yWY1wfAuDj9V5cCisgSwWMQSDWWtLvLExM2pF26mzW?=
 =?us-ascii?Q?FPwI+NBaLWRyA6dKK5L+DtDPELp6QM1pdQf0yx8Ij5uuNmJIa47dzNtXnWxU?=
 =?us-ascii?Q?0TxZuExIwu39Pa0ZvhOhkQlmIpb5M7IgvEetMYyf6MhDrBi74NBlgA3cITDc?=
 =?us-ascii?Q?F3fNe9FUoVp323zmBL9YfDiTP1m2XKf+R94o0G16SRYag61KThA8AXbgN8hx?=
 =?us-ascii?Q?s1qua20Nfk5Ykia5uy15/P/ww9+Nay+4SMqvxu7zgHEaKRmzZ7ZfYEjVaJCG?=
 =?us-ascii?Q?xbrbVXRF2R9XiqcgoXwFxYz+odTrHVs8n+GlXfHkzn+Z20BQI4oB0XmtpqaG?=
 =?us-ascii?Q?KYBtbJGm/CXbV8DJ1MY605zHO6cUZ7UcjdLJyUeZ/+x9eU22?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1015de69-b01a-466b-0a97-08de510a36e8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 12:09:04.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpRqhJs9XzISYEPAOCfRUrrD0Q/FZwjJtOkIUE3/IUVVYnEbaWwKZWPRzAqIqng1eMRXplq47AfO4kIGflyiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

The command in the test fails as expected because IPv6 forbids a nexthop
device mismatch:

 # ./fib-onlink-tests.sh -v
 [...]
 COMMAND: ip -6 ro add table 1101 2001:db8:102::103/128 via 2001:db8:701::64 dev veth5 onlink
 Error: Nexthop has invalid gateway or device mismatch.

 TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
 [...]

Where:

 # ip route get 2001:db8:701::64 vrf lisa
 2001:db8:701::64 dev veth7 table 1101 proto kernel src 2001:db8:701::1 metric 256 pref medium

This is in contrast to IPv4 where a nexthop device mismatch is allowed
when "onlink" is specified:

 # ip route get 169.254.7.2 vrf lisa
 169.254.7.2 dev veth7 table 1101 src 169.254.7.1 uid 0
 # ip ro add table 1101 169.254.102.103/32 via 169.254.7.2 dev veth5 onlink
 # echo $?
 0

Remove these tests in preparation for aligning IPv6 with IPv4 and
allowing nexthop device mismatch when "onlink" is specified.

A subsequent patch will add tests that verify that both address families
allow a nexthop device mismatch with "onlink".

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index 1bb1c2289650..63477be859e3 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -432,13 +432,6 @@ invalid_onlink_ipv6()
 
 	run_ip6 254 ${TEST_NET6[1]}::101 ${V6ADDRS[p1]} "" 2 \
 		"No nexthop device given"
-
-	# default VRF validation is done against LOCAL table
-	# run_ip6 254 ${TEST_NET6[1]}::102 ${V6ADDRS[p3]/::[0-9]/::64} ${NETIFS[p1]} 2 \
-	#	"Gateway resolves to wrong nexthop device"
-
-	run_ip6 ${VRF_TABLE} ${TEST_NET6[2]}::103 ${V6ADDRS[p7]/::[0-9]/::64} ${NETIFS[p5]} 2 \
-		"Gateway resolves to wrong nexthop device - VRF"
 }
 
 run_onlink_tests()
-- 
2.52.0


