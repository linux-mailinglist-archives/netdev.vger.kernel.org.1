Return-Path: <netdev+bounces-135242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8799D163
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFDF286099
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4671C7B6F;
	Mon, 14 Oct 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="d+utkF6b"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2E1C302E;
	Mon, 14 Oct 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918804; cv=fail; b=gC8Y6F8BMr06zTGQ/rwOT9qea+P9Epq5QlmLO8xsWsh7ezC/I+mb79x4gafA75tKtIA+k2HcAiSIIzbwBttBrCPIz0fB4Eco3yFFlPKrNMikwW13nV71AEJfkSp5YPg46KBQYMSndSomjvID14Snux0BkoaQNBohSk5S1S4c9ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918804; c=relaxed/simple;
	bh=v9mYVK23KMrFTQ0SBulN6xa2/1MW4F8z+gjj3zmk10o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trNGeEOBKaFS3tOIeYfMnvpxag1++1IC8LydggmKhS27di0U4XMKTlAf2UA3IA42qnqnXruwkiB/7BdgihTxd4qv8jtTatcVTJ8pypCxpZBppuIxM+qx5Yv9tVeZWw1sgOrHaWGO/RxHCXMBopAxO9omCdwG883u85rTSp+7+G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=d+utkF6b; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc2OWgWU8yKS31MV+3hu/w5YefAgQuwCHyhrX38XQkUtX4hO4CrmevSqrD/FeO1+Q6qg+qTqfUzOSYntJtx5SYgpwFJ0e5m3jZf1LlRJlPZM8VOHcnglfofh083CuucFnevQs5agvK9yCKbXa3i4x1hv2eXe7w27Q8h6u+mPjEEhUNO7K2E+MMyz+Q8uj1eDc9E0W0HFVr2U3BgHaCL2GZzbqlx23lyaQPslvLkY5FOnAoEZt6agVyeMCI7t2+XrIo2jpNAp08I5imSVvmQ/d/ORAG1EOZVL0rBnAiW01i7LqBHFI5YP4JGHkxoqwQNpqSQISIenBZiWKZ+Gkb0NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkA1Pnin4WrNswcShBwME0jInUjGTAbG5vZOR/OAaGE=;
 b=suGPc0HlsV2Fedr+fkf0FcUc9lMfIYWdAbugQlAL9ThcEwBLTOfc9ykvuwIRSpKzssmgL+rDmd6iefFjnWZDUuUcD6SRXtDkgVLE8mFeWxIge/kr0hCd//hvYC6fjY2RKsU86Uay3GJFFQE1IMFWRNOHyTj3va6neL8iS0BP7B+w4FvpoPfoN6WjdaNmujaXWmic/XPQgj3Gj6PusEwrpwRgKXsmTL65A23ADXMMi8zTlO1510IKxF/PZ5/U1RNEtBlz2lNvca2WDUd/twhGmZH3qLFLKtd157wsX71L77EzXv1PLl/juxri3v6mdO7AqJ+D180MWETpCgfAcpdwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkA1Pnin4WrNswcShBwME0jInUjGTAbG5vZOR/OAaGE=;
 b=d+utkF6bYysfdqxjHKnp8CH5RvuQs1qZsTQvND8RcbM5TUj8HsOc9kkUk39hbd6tNWi/pyizpatmleI71+M9cCoLyQ8Vg3637ve11JFdJaEn0eCn8IzvSNw4Ko9XjGuybcI4PD7VkT0BCKEfoLXOd7X+y4W81qppZUiwY4w9Euxi6r5KkZJbe9ePzTluej+lmRHYIZf/TUbeWEvTm+OIObQVjiMDLStrCT4NlHtXOxkWpyT9IY/ov1V/zuL5o/1RdhWTxwiUJeMP0rXKZyovE7KbkT9sgmpbU4832E5o5OujYEYDtWamk2X+G5lYAHaJIkrcgpbnxWAb0kbXCyMXhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:15 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:15 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 09/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_rtm_getroute()
Date: Mon, 14 Oct 2024 17:05:55 +0200
Message-ID: <20241014151247.1902637-10-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 444b7f27-1458-4c0b-55ec-08dcec62ba1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?by3uf5gE23WyZLcSiOyCO7uJfXDcSxBTe7sbIoRt5OycGFicDpg335wFtRw5?=
 =?us-ascii?Q?cvc1QygWecK9fyQrCyfRLKpPbJRT2bzNjTXFTvMaLVKeiT/+ZxNwDERjmju5?=
 =?us-ascii?Q?EBfV09JTvL1Ne6sPTzISyDZD8nbu34zLnWDfdGG8lLoN5uteAPMkZxzEw/px?=
 =?us-ascii?Q?KSr2MxKOSjVt1yW9qHntbV4jWHxBBQHtouLrNX/xOai4Yjt46SEqW7FNI6HK?=
 =?us-ascii?Q?9Rux/Ocj/2fGt926pcnQYIjvQfskVjWyEFHzlw7bsNp4gqTorQVxNm+EJV3l?=
 =?us-ascii?Q?Ry4pa8N1CGI7oy7kfj6BEG1mpU3gwnN7FJZ0MPdK9rgigNUJ4AEXhQEz2aDt?=
 =?us-ascii?Q?huhzP96QiCGF8xdiR43KbcZFbOMyTwJ2x12kz+TgFBISfW6POXUBeuv6JFJP?=
 =?us-ascii?Q?B6fDIOdqPhVDoI8RVu/0zl9kx5RpJJJ8uFznmHJnqASUJy9i9zFevYxcxnD8?=
 =?us-ascii?Q?hC7NCkda2nKJVZsO4HHno+/5iTqCyaPw6SLshWTS+P7QvLSyUplyB/nh+E3z?=
 =?us-ascii?Q?UCIlrgCfkIM6VmqDrhEMIxQBhkB/Vzni1OnPvIKRUeqZwAITWgJYguDKNDAS?=
 =?us-ascii?Q?aImzWWAIz39/TEpeC1YCjvT9hu1vdLe3sCsj8nceCifftLaWFLhmzbE9iFS2?=
 =?us-ascii?Q?SORJqx9kjP/ifMb47VP4Z6dyztuXc0pwUW02gPCH7AVuhalPx+I8at2D1KzC?=
 =?us-ascii?Q?IkMWnZs3UG708gvAisX3ofP0+Z5IW1aSpz90odmwk/WobyAcf7nWAMtyyugz?=
 =?us-ascii?Q?vdwmRDIR3nptCgcx9d+SiQBHTBJGqJUFATqcOHMSvNlrBCaWtbammJfddZEC?=
 =?us-ascii?Q?WT+/9pcwN6uesPipPpXRve5B/6bLAhtlV59nfP3fUAXavbTPR6O4KBOrLes8?=
 =?us-ascii?Q?uyA9NfkPq/lHBkMKDE8Q9gAsy9g/ZcHYmcIDdkPW1xzstIKEcwz54edzhdyJ?=
 =?us-ascii?Q?C68d2eiKa/roKsIA7ilzuzJhPhKM5TiHvrW9keSw0hxpLTF/JageyUDZMycE?=
 =?us-ascii?Q?at0zdFIcmhXsgxB+QaqqPOzc4nRGUAE0QVoR1mXsAFa9wPjAkk/gtg3s9nFF?=
 =?us-ascii?Q?gBtrD6oGo+De8EbAYpQdTiGFIslbgPGHsR4HTZOu2QmZeJ88MVl6iU06dK7p?=
 =?us-ascii?Q?T6VH/UP5ghgJRvKaCp3vQTxapoHlUMlmjRLo1u9jZll0EFSOj5G+HO7eKsYt?=
 =?us-ascii?Q?447kiVDIzHERkwUtQG/MdEffBR7l+mesVEm0oSUyoQDkwBrZtFP2LvUEItZ6?=
 =?us-ascii?Q?Cpa2o6cvCsVn499MvyiJNguEK4SIMK/AfXGHVfraWpqfNTj2plfwe9eIgki6?=
 =?us-ascii?Q?bCuRBclRmlO+ye7CE8SIYBe2zYA4Bj72qTGqAegtEMPxfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X55ItipCsCGIl3HKOpCC5WOG5V4+I/C1CFlOc6fm118rpMK2rl5agVbD21q4?=
 =?us-ascii?Q?/3UuGV+tzcYIRCbb53e0Kuwl0aacF86O+1RMnl78L0kZ+a2GFy89AnSco1jm?=
 =?us-ascii?Q?Pmw7mW9e4bTRIFfiIuuqpt+HLyGzT4I0wr81eegPn1wW5YjUQR2PGpXud+T0?=
 =?us-ascii?Q?N4nqmrN8L848gUD03Ce9LK3Xgb0v9vvKKo+dZQfQuF0LLV0omf5I8y5xEJwg?=
 =?us-ascii?Q?TLuTyEeln++H8Y6gRQTbZ0nPCSI8xGrgxDcgM9wmeQwY8iYrWzUiFep8rXUO?=
 =?us-ascii?Q?CdJTznXXA6QcC+DzRAjItYPTXHJ7rVDWeW0SsPF+SXQmSIdUb7FZxrLQnBy7?=
 =?us-ascii?Q?HVXlQuUokoETYk1NxkwF4X6ka7EgWPy4Cd00to9fMs8H1J7+4/eEc+SZXtuO?=
 =?us-ascii?Q?dX6Hrl+EL7H7+q/F1NBgyXmCGTjpPkEYT1l7D3dZyIUWiu01KMnxglwXZLjf?=
 =?us-ascii?Q?IAOtsvvAx6+4GAHykarhfvxl7AkCV9mgGjW5pV8qU8wIy+6mLKSeUKVb+llp?=
 =?us-ascii?Q?H4tJjpz+lMYkje/Gm5MhR6gRjaPibYlMqlK4KjsooeGtmXMXmmi5nr9jtz13?=
 =?us-ascii?Q?vHAV+V1OPQrBHOo5AMye8i3podWHIvvSxQxdeBevw688C8zWsBc0eHv8vWDX?=
 =?us-ascii?Q?tpqxVe7Yzbl7JccaKhc7mpv3tEh++KuYvjxi12qQco4+5qAbf6FHq345yK+P?=
 =?us-ascii?Q?Cz38kxy5SrVzOCzmjmRnFy2/7sVWsYKIWMZp+XU7gY0wLJFXruz6sU5AgSXd?=
 =?us-ascii?Q?luki3iv2iG1JfliQaaNajlbV0Se5eXajTRIj8+OPu7XLZphdkDICfrQCLSjl?=
 =?us-ascii?Q?MDczoMMZF8W15EPuryqJIt8lfB3gV2HtBi1npoNkhyHftXAQB8ES52taYp9e?=
 =?us-ascii?Q?tURGDuu3KHrDJd2BTn6Tls6You908+SVkdRzKH08dLsAUMIOVHLyTpFXgGZE?=
 =?us-ascii?Q?HX/GGykE6HWbKyCbv1odAMCg7bJRlwThfGgnTXaYTeI+tJxgyt3MhIpNpia0?=
 =?us-ascii?Q?xFzJUf0QDh/PlbjdR7ZA1OGhcQcki8bpZXX+J9hYsC3O6f/f/kndLHHnge7l?=
 =?us-ascii?Q?8AnPGudVLFbsmbkmY1GALZFS7+QOtPiZl0SYsiqAmBJnvr6UlaM5WsltCtEP?=
 =?us-ascii?Q?saM/Lsb866Lsfogca7mYGdu3CajogtL05SDPxLTlXYR8zJZwHeZ5w30AHwjY?=
 =?us-ascii?Q?L53BraSCA+dfPCTxHpbYrZzLc4Vjt7aXojXn2soW1NBPbaKL968u6u15J/wZ?=
 =?us-ascii?Q?OWH1jKfljiVXmEWOg7lBXK9J0Tk9NzThbanVwSN8wRm13KlSqBLPX+fh8k15?=
 =?us-ascii?Q?sRLkKrNYvQsFQmGF2FAC3VinOVFbXKYPQ5oUSbrtM6+cJBF2X2EOKQH3R8Qv?=
 =?us-ascii?Q?zeSHXjxQDhyXtpOZQvhUe8IiWBV/z4VG4xjsfYYBxryFuehFssp8UPOCJDum?=
 =?us-ascii?Q?tcphNJlOiOK9NzJwYUo1xghpETfL1LJqgv1aSUU6e2i9Q5mkHWduE+axQrGV?=
 =?us-ascii?Q?yZfYwtYDuQYL4xYDmlYYxronBPVWWyBWil+BQAscexUzIL+PuUW6kcS+idsB?=
 =?us-ascii?Q?GI2NyYdqmNF5C2dH9Je4cU2wnDmXNnWK6l0WcT1M9Y0FkXue09hXmwxSh5aG?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444b7f27-1458-4c0b-55ec-08dcec62ba1a
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:15.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJe1yELAMx5wKH10/spBk3/ruifR3gIuirZ5Wi3s7Rdu1ID7kfkd5ipPVY263i2DlO7UfReg9Bmnq8RwNHsjKDOrlkUbT69ZjLI2wj/9gpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index af921e9731ec..01b58156e06a 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2594,14 +2594,15 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
+		rcu_read_unlock();
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
 		return -ENOENT;
 	}
 
 	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &src, &grp);
 	rcu_read_unlock();
 	if (!cache) {
-- 
2.42.0


