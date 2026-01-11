Return-Path: <netdev+bounces-248799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D732ED0ED14
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A120300D915
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687F33290A;
	Sun, 11 Jan 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BSWiaZuO"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D30318BAB
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133327; cv=fail; b=VmHsNAypnUtpwmwXsNWOTuk+hb+g1RDPtOYFVbuwea4oTuIo7cP55hFhbwm1G+BzVsNsKfiKO/pdhKyJt0fg9cpKYy8Zyr+g+zsgmSGajxuVlJ4BmyMLtd8IIh+eGOZZyJj9xR/s7mjfH+Yx0z+8AZuHElnmtWn8YVvg3FfBZO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133327; c=relaxed/simple;
	bh=ipGjZe1phtFr4ASIf4Js4LrUTe/9UDBbgP2djvcoDWM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nnbFsGbXoTV58n0PX71fV9JGv6IKM0I8R6weH1xARTNYmVtLSmERK9xFMqFQftrbqosa4hU2MoKORtVWK0uV/Ii4CLmWxEtJNyCziULFV2wV7bK793yYxnteekPbLkQyvXiEUaZt/RpkKetEkYgv4caCZ6EURgXWMjqlGHnlp9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BSWiaZuO; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG/Xe7pIyrXAcLlv7jwB1i7NpM5nwDxyAssKmEH9Xm+9sEr6KFhNf6L5Ik8sKLLDCSDHPWzhW9vFBvgks3EtoVXue/NMSwG6OG8fZXnGK0vAEI3PWOUNgcrugr7LZTO9P/3Bim4MhW5VEO9umKjaY2pYhU1LEO/bXe/oWOikY6qA/dcHJpYeHR6k6mceXW4icKMJ4u7ZOSoUPjqp/FxRPQjGlBniNoVCaQeGI5vS3KVguU3ptZL7LuzpZZTjviqy7nsP9R669VdyXd9y+6L8jlFCSS7KbQiT2L03iVSf0pYaYhvNUEWO0fl2jphNMLDxrwVTn5fU1hD9CM/nJ1gr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkV9Ws94bT0eXHlUt2v5mkbCBS3bOFHai06YaCLJRqY=;
 b=aaIAxVgsYZ7iQLu8hY12f+DAAlNyN3FTsLZiBxCIgnnCK/m/J/mPDaz49YBBk2/cSkvCkySgdywvRlI8SFKxx769+Mw8mvz99yDtXlgLDo4y3OmHxPbdQ79oRapkeZBa68rMg+3wf0TTb5nA5PfbCENN1bg8NYKIhstl2YwYCWNXcKRE3uXixpERYXltyuPbRv5yrK4E95k7ipYhnJB1GEU8D8IlrTnAbRT6/x+M/+a+F5uS6X/Et6Q6d6pbg4V9hMgX3uyUkHfdZhK065nimIixbg9ABoeSHKt9SNhopHYqsQStpT/9Cg/rmF2LMCtWzWh8MCcozPHo0Ecy+I9yhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkV9Ws94bT0eXHlUt2v5mkbCBS3bOFHai06YaCLJRqY=;
 b=BSWiaZuOzKJJIQ8QbilrzZCZzr+3hx4fYXtDKfuC270/syufVtkAKz2yPS+AOY7TiWpxqK1NCEtX38SmqBjEDUzH7I0e2QkEpNFZ/8QGaCeq3QeQc+VUnmbdXgs4ca4Ej8Sd1A5Q06y0etd/Cf2ck/mJRPL/2G9ExYLStto89qp/fDGHtF/UJphpbHxGMy+RuF0UU4ev7MGN9KGaD2eoQ1teCiewLw/W0GnU7B3IzzpzHfXCecVQuCEP8PROPFMUd9NsIjT0G04vFjBFSG1iE9Uh/3iQ+xCbDgc+XVaSXwfeEcO4sCdrtdJxwQu9Xqw4H4dKEqutpoWW11ZqiBfw2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 12:08:43 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:08:43 +0000
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
Subject: [PATCH net-next 0/5] ipv6: Allow for nexthop device mismatch with "onlink"
Date: Sun, 11 Jan 2026 14:08:08 +0200
Message-ID: <20260111120813.159799-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 58536198-9fdb-4d47-e54e-08de510a2a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YT6F4ZWkREC8+TXduFQo82id+98e2qk6BUB6QFhhKxLd2Nvx0FV8zrcPCu3w?=
 =?us-ascii?Q?SaXuXp+HlsszOM9EsM6KLdJMG5Qrq7LA1d/LYeYOjYedAwp2D0eEGRX0cEf9?=
 =?us-ascii?Q?R7TDoAL3D5C0Lim5Uy3Ny0XYMUOgGqJPYGUdSbUbPkpdMPmpWtLEG5R5EPi9?=
 =?us-ascii?Q?4RsbqMaqRos1J7SlwpkvRIv2RKFmXAPBw3jNEdxYfXSEOPsJnzoBVcc8sN1b?=
 =?us-ascii?Q?LcdhNchrpF1cM4/AAqXM4TXHEogh127JEwMQdsnTJ2Xnbu524clhJfHi40ao?=
 =?us-ascii?Q?9Gv1N8PJO4O9jCr9VTxkKkD9BdnOit3U/jfyCt1EiuT04FnCBuP16YZNpW8g?=
 =?us-ascii?Q?x80Yc8NYV5xmmbHwM4pi7nwN6dk9Lto3arki6wFEiyr0AqODNp7KjBhTzpiS?=
 =?us-ascii?Q?o+KQbeO394mlbvTKHdZQA0LycyKz1hzXEktSzBWItNqkFh3z3PJF8HVJBfCu?=
 =?us-ascii?Q?e6Cy0or/+zAULkVE/GpgrUBUjGHAaHl2CVn0HoB9ddAHe+z1b2KcwxOuIRqo?=
 =?us-ascii?Q?a/pzrTpgpPm7uFbhKXaCkBtqPLWTlTrTsIFeahkNuzhMkb+JqAy0FbKmtdX1?=
 =?us-ascii?Q?TISl+m50SSEFYJuG8bafrGEMJ9himjFroq0KbrFIJKe3BnnEjDbIBIJY3Nk8?=
 =?us-ascii?Q?2hcPsv07m+eTKVWonlKVbK6AvUeoTgn6ah1/lPYI8e2kJlj/NYqPgxt1v2w8?=
 =?us-ascii?Q?2kuUSvIlvVzaZFQgZMZleZn4v5GsarrswfvJjAzt5tCUFjzeDeI2j5OYZzMx?=
 =?us-ascii?Q?VQxuGTs8wbxE8z/oCrdRkkdM8v/dgcNzaaYOvwM0SkaJeSiZiv9280YYYuwE?=
 =?us-ascii?Q?Y+/BVtIIn+alJ7w//ukVq0fPXmFCzlNnxKLFjzblFocRUL4wJIjiApA5aZ4s?=
 =?us-ascii?Q?W2KNipdRpinu9Fx0eLoRMIPKrjeoEBy1w0qDSzb2Ktww0C9vpCraroFKHG88?=
 =?us-ascii?Q?1EvTlQBIcmOTc3IFdoOcSQvsqbVev0r5HoXHWAsgsSJmBdINbzkJDU5eo6jO?=
 =?us-ascii?Q?Hl0+3BtgyWQhmNiQ0XeRWIrpwL7P8OOtXNSYKe4VsMTEFjHf0RHiaTLDUm7f?=
 =?us-ascii?Q?UiciEVaC3FPeAzEJ4DIDYknpVepcqBZf0+gvCPNduCRFJ/JUJ5js1tdjO9tx?=
 =?us-ascii?Q?Mpy00SIq/b/9eeUeFTs2/9tI3JAeBckOZVGNlWi5WdQF09rSkbH1boRgENLy?=
 =?us-ascii?Q?1tLct7I61fnskHKY5MmvGEQ1uEB6ItoXz0Vqe807LypVt43bA0+hEFOexnvD?=
 =?us-ascii?Q?VwsCfyVhdi+ROC8UtaF2BTiBy0TLWjax2BBbsVSbr7OBjwZaEWsoeE9pqWHC?=
 =?us-ascii?Q?IAm6Vv+lr83GQL/m0OMnO2kYYg3HjD2X93Imn3MGSwBWeC56fDduJJ+ACdYI?=
 =?us-ascii?Q?PsY+xb8knUaKWNcW8T00Nw5u//0ImVvXTAxwaDHywL1HQlTaZQD77s4fkp9m?=
 =?us-ascii?Q?gQJOy0aXUpIW9M/bMovqq+FkJNPVLJ0L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nsNAZwyE19yIH2FVLTybxAOfwcwadr6pe0fw4kmFd/hFQuXUVUzFhzTrhunM?=
 =?us-ascii?Q?742i1KRK1PL+QKaZPspvNMJxUuOTC23NyCEjVGYZmiCPmBApyOAuBSCuc9o+?=
 =?us-ascii?Q?AFCO31oEMRBTzyzUd5C3AKawKpvbBnJXjEXQusyMGe7n3/RuhcGfrh1clqy0?=
 =?us-ascii?Q?Jw8qOJWVKqy35CMY9r3sr101QVLBsa6f2GeoCg/ICdnaTZwuceVgKn3Gee0n?=
 =?us-ascii?Q?zDd9lSXNqw5GLtEOBGuMFI1tF7k5sqY4u3oXrkz9LRlvnndDfbrK9uYXYJIY?=
 =?us-ascii?Q?vKnv+IDZ2ruPY8EW7rWadbQPnsc48tBfjMV3tQE5tms/0Bg0gLY7HVA0c2Uc?=
 =?us-ascii?Q?2K2YDBonRhV6gmz+peQ7QbXE7xIPHzFm27bngnAs54t3zsPW42BSJCaKQV1X?=
 =?us-ascii?Q?hakRbZD8KV17DvkuQIRmygxBQx9eG1fVrpRcwKI6cVOVq2G1Chgq6fwa5lK3?=
 =?us-ascii?Q?9E5id7I041psy6cCrUtsukpl8CXqANu4mjn1Hbpg2wYvezBaVW083evZilEg?=
 =?us-ascii?Q?awgZyhyPbgi9yoDHB573WB42AFdwOw2mbLBzBo1KjGUqDnPi6M7jyOX6zRZN?=
 =?us-ascii?Q?h19+jpnhfCX88QmjislRi9Gjc/Bpzwfw0EjiQZx2w4Xo4PukGnDI+pmKAwY2?=
 =?us-ascii?Q?RUAYmQw1h/YNF4PG3+gyNXca8HtpSPk1792lBMnbZiK1dFOJ2GeB5NiKgJKe?=
 =?us-ascii?Q?8ECrrN8LFjb+TzAlmPJkP9unuoXqi7QteXEfCQMwMB0WjfWJY2JU59SsI2wS?=
 =?us-ascii?Q?DCOn7p9/HoQ8PJGZt1x8NkuFtMLtxqzFCZ5pU2kipKyIh4GVw/Ps5gKjKPaL?=
 =?us-ascii?Q?u7EjYtcO2lnUyN7lwRFWrgxP3N1QhNCFuD9zoFgiuTQhrCDdrrbdki49pqA2?=
 =?us-ascii?Q?4ESqKrNzV3Ezz/WtweBeXvg0Ph54iOoCm2q+ZJXvpnqOul1ClZOqNwrrV6nz?=
 =?us-ascii?Q?kPAHUbz1NhtrjcRxSCi4NtTY/YvC55aDAsXOBgoBGQoVabvhONkuLxDElEUI?=
 =?us-ascii?Q?JtZAS4mizVKzQdbEEz0wHPq0a9roP7up2NlhYU8QsYqQEvIfS0QzQ6A9lzP7?=
 =?us-ascii?Q?cgC3gB2F9G8wGycfzzIWLbY0NAUEUH1a/N+d0WZEqrFlAJz7HmmEv7M7AoOi?=
 =?us-ascii?Q?AyyjJgGlsxWbxvu5wTJVnV/RR8lNL0RGEPZN1zX0tlRyisMm26sTU+lyWtu1?=
 =?us-ascii?Q?Ull7+MgqrAOxKCL81hzlJNKkY/u7Mimpttwp73GSkNUcWYqeRRd4hPju8Tg1?=
 =?us-ascii?Q?x5VAHlL5Ta+k8ZebxREBqBx0BS0ol7AQW91bIMvgq5Eyinvjy2WR9WHZDteG?=
 =?us-ascii?Q?L4hKUh0CrjdsA/iRVfLQnpVLGGLqKzt9sBZqFMfgqu8OIG3v1yPEHP6TB5/z?=
 =?us-ascii?Q?5VNGj4yBNrStrdUL4s1YZzclpk8UOXbzY0LB2ITvWFwqwQP70GA7Yo/brO2K?=
 =?us-ascii?Q?MFE3xHqQlspukUnb25cqaB0Y7Ao9BeUHK3LxpJUXDJB2DWN0NuDNTQBGdzro?=
 =?us-ascii?Q?CK8Na8HFutcWhTIBW3pbYix3wrLGVs5uan1mRa/UaKJH8TWI88POvsh3Ywvc?=
 =?us-ascii?Q?hBJZJuhSOD4TffSYr2ilETrOnBfJs8nnj7EZXPMQ6JrUdt0AHE/DG07mOq4E?=
 =?us-ascii?Q?F3TWf+m1taZbIRU85tdlEDpt66d7JfzqwqifNoXcnjrwongyA1Uc+KTaNrtR?=
 =?us-ascii?Q?S6RRPsbSBL7CFtqXsAva6uCPImiCiB6AtL5PpOy5g1EBoM5V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58536198-9fdb-4d47-e54e-08de510a2a53
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 12:08:43.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpkBzBla0WeCNELt8RkoXn/DvIEN2jtgj1R4WABJ7KDoBw97Mhnm5n/bKknFO64f6uYQ0IZ5v/q8nmC45lrp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

This patchset aligns IPv6 with IPv4 with respect to the "onlink" keyword
and allows IPv6 routes to be configured with a gateway address that is
resolved out of a different interface than the one specified.

Patches #1-#3 are small preparations in the existing "onlink" selftest.

Patch #4 is the actual change. See the commit message for detailed
description and motivation.

Patch #5 adds test cases for both address families, to make sure that
this use case does not regress.

Ido Schimmel (5):
  selftests: fib-onlink: Remove "wrong nexthop device" IPv4 tests
  selftests: fib-onlink: Remove "wrong nexthop device" IPv6 tests
  selftests: fib-onlink: Add a test case for IPv4 multicast gateway
  ipv6: Allow for nexthop device mismatch with "onlink"
  selftests: fib-onlink: Add test cases for nexthop device mismatch

 net/ipv6/route.c                              |  7 ++---
 .../testing/selftests/net/fib-onlink-tests.sh | 28 +++++++++----------
 2 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.52.0


