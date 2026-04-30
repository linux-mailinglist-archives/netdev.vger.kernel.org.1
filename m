Return-Path: <netdev+bounces-282584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHcID7+x8mlhtgEAu9opvQ
	(envelope-from <netdev+bounces-282584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:34:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C352A49C0BC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0F7A304464A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02BA26A1B9;
	Thu, 30 Apr 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R0YLTBnK"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010007.outbound.protection.outlook.com [52.103.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6726A08F;
	Thu, 30 Apr 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512814; cv=fail; b=FHyfqqVO9EjcSByW3ZRpWSaMpW8i9LV16k2S8FU5q6poYmvckIgQTMD1OLKiMs38LjMOz/8IMVrPl10VKxj/k5KH7MOniKNFTZ8sgS4IUc/ZpgvrpI8lO3fKdqVNJu6q1oAoSj9xVceSJdqIVMRJMR8TfmcJBJlEgmb6pgZrrb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512814; c=relaxed/simple;
	bh=Kz+AFWvSiA54664y2psmApukmAjcWkGiz9oDyRLihKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBd9EWk9TWdckGyqgSY1CSp/KRU3/Fg1sUf3jQwrElf1FIcDKuaI7M1gKp1LIGe6xF/eVVeZoa7w6MvN0JswJYV4fcCqdDgBAeV7AoHILfjAn4iuK3feTp5SXUGd2KfL6vdfZcI0/5IWdzqtVC6YNRCJgQk/x+hLlnRr5Ei8Z+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R0YLTBnK; arc=fail smtp.client-ip=52.103.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnnT6tUfzjrw1zx9AiFfdVjJEPFdYEzSYdYy2vm9nAoezq8VgQFF1rW4t2UC7vzJpUAJ7QfcEN82zh/WMaTyqECCzVL3oiSGvpnknAOyLbf36y6OhUVQr/9QPqROBay0+KUUsAvjxmSYrjZm45/+hubfWOidFIgRd/y/eeFrdDmADv1BLMeBUk+3zVvemKWdKQZs66ZHaaZPe987D/mIUAmb5HFcEQ/xYT5g2eaGD7+N1RISnMx+AwrkZOBEaEWpEzLwKNoCCW64RaQp/aNXAkzRDU956a6IX+qq8zxWIXRWbytn0Xi4jL8/W797+W56WzkyYX8oCyZVFkMGFFShTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2CTIwFCXjFz/GIH96OHNDkoZ4oE4e0JnOGK+0qO/Ew=;
 b=fsk9ERYGI02up7ofPXrRtNAHvi9dQDvJQzJcoj0T9wUovdgeDEs9qsu7rquCMxxN1+uY1ovi9uX6TU37sFaNX8sKtyJMVbSkn4kKP8ur86I/WB8ptORLjxCZlOEbm8w83DKxtwOUS1GuNfq7MsPCj56oVh6AI+6j3Aq09tJOcmHjxzTAKBVG3y+QSNYYldVTD4TkM7ywmRAWkbshQi/BWUI9UWTaLWFQ02mpKSVbW62FpFFsMJBVhOikyCOUsK7Ocq3K+bPl8/zeafR1eYOPxiRRtfxdkJSnZGtFUAG6O/hfgkd8QLefp6VByj0jrY66dqngPvRIAIHL45kvmQcaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2CTIwFCXjFz/GIH96OHNDkoZ4oE4e0JnOGK+0qO/Ew=;
 b=R0YLTBnKgZYEIpu/OLXAbepO4iCVMWdOcvZOqoQXuUScdfMHi2qCFj04pTNZnxRWEFRSDSLsIXBeLEe3OinexjVWFJibzNwgZaH472ZYn/xqgbLU2ZxXW9ifXiWhNNWkA6pnHv4mB/tATvL8QsKKu1CUQ9dztNuBwDFgEUZGzNlSEjU2Pc2AG/BP6Z1kMfWtDmRH8zOKzsgYUvy3JTTX9CZr1nhJlrbtpRQWFXaRkYQDGtnmNQjIGcQlWGgeODTad6Tt892dLs51ENyLuJgKC/UMArLyuFmADW4js3Z7kYq9pcBaaKV6CxA+N4+yLgQx8xCl9qf605vkFJXY+Xt05w==
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20) by TYCPR01MB9433.jpnprd01.prod.outlook.com
 (2603:1096:400:199::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 01:33:26 +0000
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c]) by TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 01:33:26 +0000
From: nmreadelf <kong414@outlook.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	dsahern@kernel.org
Cc: horms@kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	idosch@nvidia.com,
	ij@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	kuniyu@google.com,
	jlayton@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kong414@outlook.com,
	lance.yang@linux.dev,
	leon.hwang@linux.dev
Subject: [RFC PATCH net-next 3/3] tcp: netns: optionally inherit IPv4 TCP sysctls from parent netns
Date: Thu, 30 Apr 2026 09:33:10 +0800
Message-ID:
 <TY7PR01MB17205C69BBB690323CDA7F3FDE0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
References: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20)
X-Microsoft-Original-Message-ID:
 <20260430013310.4048623-3-kong414@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB17205:EE_|TYCPR01MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 803702ed-ffd1-4b9a-a542-08dea6587963
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999013|15080799012|16051099003|51005399006|37011999003|23021999003|25031999004|24021099003|19110799012|461199028|8060799015|41001999006|40105399003|440099028|3412199025|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6nQh/mR8ZvDwA07jGyjGIjvHktIZdqx+b0FR+1Vh3uSUFZeSFyMHUEdH0Ww4?=
 =?us-ascii?Q?2asrnXpckZEWdtNz01QXSTML/3u7AriY30OXfpsoLFol9fo36N0C09DIqZdw?=
 =?us-ascii?Q?hQY66FBjDI/CKUPnIL+M2GwWTpEwQVRelWashDGCSYir7+ehMH7S1CJK4FgY?=
 =?us-ascii?Q?n3q4gCCqRIDhbBASCPg5nvUJoqR2MrhzCiNJWvISCFZLgS3yaboo+4KZ3q3k?=
 =?us-ascii?Q?ZaeQoQO+jHmzVlyWROd2W2IyzpVdK589XoqPMxgQMPyWxJspnXVRcep0CsDd?=
 =?us-ascii?Q?WSSQM8kmTJfjPPIyGXaKukQKlLFdAz/i+VvW2lwuFLdxX5mh41ywd5aM234x?=
 =?us-ascii?Q?RUX+m5me9bs354rMSUT5ehuKKOk9HppDq/1h/v6/NZfs7aiA3j6Lo0NFM/ki?=
 =?us-ascii?Q?FHWDESSUejixMQez0nLyWXrClll6G57ROI1Q2vGXPsJlsm8KDhkt/6hQvjVP?=
 =?us-ascii?Q?V7u9nd9K8OGx5jX4t93VtUhZ0PjdG6MZCFW14vPfULgwGZsZcBsb3N16+mgg?=
 =?us-ascii?Q?uneRCwxIBp2D3o1V/1/SsrF8SoS6h3UKOCUVHn05g6v3qBf5LRparVrrpL4c?=
 =?us-ascii?Q?Kck+RZ2QfvpLUplU1XfFoCPIUVn7RFcb/cvTjQBNHA60ZCP9JebB7Hp296zR?=
 =?us-ascii?Q?4HJN90pI5DIMzoniNPhXPLLUJGnS0X9E5lycYsXgZE6NQ5ZIovR/DReIL7T0?=
 =?us-ascii?Q?l1/o9tnzvNbdWz3PvUzinLBDu5DS77ZtwhjSXsM4uGlPGGqxELOodAddO8jv?=
 =?us-ascii?Q?+0QnJKO0SQrygBocds3unBDqkbzlh7k/z3qoKkudBaUmiHFsa9w/6jx6clIo?=
 =?us-ascii?Q?vLQOMgD9VBtNEcIibe4hN8n0J/vclgrkTPA70M5v30nxFsxLRCv4RzPDMeSs?=
 =?us-ascii?Q?Ak3uIrfWKcJJqrobQj0gNw6U7NL9gy9LADj/Uqp6iu1moseM5Y3Bfs1vmWR1?=
 =?us-ascii?Q?e6ljMUTQbbzXhIG+2lr0oVCJhNSzf4FU3Cpj2oRCzYbBjRDEbdmdF7oGdI3p?=
 =?us-ascii?Q?HHTzkoTiznoOfeHuxX9ReZ7/SCflv95iA7ou2Wbg5m6DMvnYRDtQscGIL/Ib?=
 =?us-ascii?Q?7MSCIR2zD9WbXisR+Mw7wX/xZWHLltsMxiWYIXNap3aZXE3HpZ5n6wEQPwAa?=
 =?us-ascii?Q?uceIUTvNWzCndfr/CjepGz//o1n/AlT47A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdK3cDcDN4YgM0lIuvowK4kGbGUW8mUqeHxWPDZ08+6ZQWP82uoZ/8I+CrSr?=
 =?us-ascii?Q?xU6dc8UjSLEwKPy9lnM+FdcXBglf7ZI98bD+EOu7eM3Zly5wplf4ivQWVBGr?=
 =?us-ascii?Q?9ufvMJivlcIh8M0Oe0UZ47zxLceX4RAq0z9/ovaOhul+XSnCWddxSjbOSwnY?=
 =?us-ascii?Q?0H1rQOOW3ma3g/Rhj4MpLqlsCI0oid2a8jT6jgDCG0YzlJCK1eeHijoonHik?=
 =?us-ascii?Q?JZ5oLbZMEGyulYUyRC4ttu25rJFM+hY2Te7NbZC0FCtP57MpRaQUe1z4nvCq?=
 =?us-ascii?Q?bfx5+q2mdwpaxa2jcClxrdAc3YpnH5PJAoFIB9n6q/VKqPti5wzQGm0btKun?=
 =?us-ascii?Q?y47xHZ323SUKbND0ptpo1TiJKh6LRFKlQoAh6x0epQf1Uoa4M/OKv+IcfDBW?=
 =?us-ascii?Q?QnJfn1TGnd9v1sjTmtC4IPmDXPye40YMU4VtgXhm+Bx0VPDN01/nNQeWzILp?=
 =?us-ascii?Q?mFdKLUkTgP9XEDMXivvs1Pd2DnKwdSnn6PBzSQF62A4gM/PKK5LRGI1yhE0o?=
 =?us-ascii?Q?eXa8oXy+NxM0tuNP2pegfJe+1+uQeV7RNebsP5CmXWSDJbZp/UC7USxRXyQ+?=
 =?us-ascii?Q?FjEA8c5xaLHdowwG8kqld/VNRFE/SD5Fah8zehYW0XM0qSWw6geGWErEnfcG?=
 =?us-ascii?Q?H4vSRMNk3tqlOHh/LUVrJYb4n2NK86dM2icGe0z52AglSXFHo9QRatzQN2gF?=
 =?us-ascii?Q?+QNQLOEsUvUCyr6yPhne2n/4k169+aKY29SzPi7RZ7lqLSUeP2iOu0ZAr4a2?=
 =?us-ascii?Q?dqc7g9Gts+o71mGxyYhG/ClKqsu5G8kNJWJC2dsw7hqgKkhAPsYY6smr1k4Q?=
 =?us-ascii?Q?zkbmsxZ6q7GcX4xOutd4YByIVJrcsQu04TD1Sv1RYroZwekiJ1HFGc/cBUyr?=
 =?us-ascii?Q?lUVbm4Ap02aAINlXwCVwOGvGFV4vT2EV4QUI4XQtGhMhhP4iCS9Tcp0mMHGd?=
 =?us-ascii?Q?4ZA8BPtB1FzuOX1ggEnozwD9qkGP7RcBArTWKo3lC8AhLqBDTGD96lpNJnhB?=
 =?us-ascii?Q?8mfMOIyHA/D/pkBePIsbmI2YTD6CkPhfUzxY9ZXR5pzR0OXzbjjj4Y2PiIoL?=
 =?us-ascii?Q?yKm1YqKUIBA1FfUjiTb7cdDioB87g+VGdLCHBzHVcg52nxKPiSJOQDYF/rGg?=
 =?us-ascii?Q?C77DKKVFZHTLOCw3n0NSCDvKkJaTkDHVSTKgcwiiJhNxtP8gKA3fEyOO8R1q?=
 =?us-ascii?Q?6nlKTX16ub4p4Qx4iiDqNIbVe+5MeGjExmMHQNo8SGqHwP+hWqHi5HCZOYDp?=
 =?us-ascii?Q?/qkYSbaZduQ73bpYrUyq2X9zL5o7+z4K5YPeIPCgrJbqKHIE7rZfOTCOAbAV?=
 =?us-ascii?Q?+jm006TlEZxOPGqeFy7ZU6qOyVczmXcfV6jDc+ypalkvy/kU56ZNsPb8beSn?=
 =?us-ascii?Q?rOcGhy3FH7Lqr9Q9bCM0pkxYFV+O?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803702ed-ffd1-4b9a-a542-08dea6587963
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB17205.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:33:26.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9433
X-Rspamd-Queue-Id: C352A49C0BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nokia-bell-labs.com,nvidia.com,suse.cz,google.com,vger.kernel.org,outlook.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282584-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kong414@outlook.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

During netns creation, setup_net() initializes IPv4 TCP sysctls. Add an
optional follow-up copy step in copy_net_ns() so selected IPv4 TCP sysctl
settings can be inherited from old_net when
net.ipv4.netns_inherit_tcp_sysctls=1.

The copy uses the tcp_sysctl struct_group plus selected related fields
outside that group, guarded by BUILD_BUG_ON checks for layout safety.

Default behavior is unchanged because inheritance is disabled unless
explicitly enabled in old_net.
---
 net/core/net_namespace.c | 72 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a6e6a964a287..d6587362d450 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -548,6 +548,74 @@ void net_drop_ns(void *p)
 		net_passive_dec(net);
 }
 
+static int __net_init copy_net_ns_tcp_sysctls(struct net *net, struct net *old_net)
+{
+	if (net == old_net)
+		return 0;
+
+	/* Make sure TCP sysctl fields are contained by tcp_sysctl group */
+#define CHECK_SYSCTL_TCP_FIELD(lhs, rhs) \
+	BUILD_BUG_ON(offsetof(struct netns_ipv4, lhs) !=                \
+		offsetof(struct netns_ipv4, tcp_sysctl.rhs))
+
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_ecn, sysctl_tcp_ecn);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_ecn_fallback, sysctl_tcp_ecn_fallback);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_base_mss, sysctl_tcp_base_mss);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_keepalive_time, sysctl_tcp_keepalive_time);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_syncookies, sysctl_tcp_syncookies);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_fin_timeout, sysctl_tcp_fin_timeout);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_sack, sysctl_tcp_sack);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_window_scaling, sysctl_tcp_window_scaling);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_timestamps, sysctl_tcp_timestamps);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_rto_min_us, sysctl_tcp_rto_min_us);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_rto_max_ms, sysctl_tcp_rto_max_ms);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_recovery, sysctl_tcp_recovery);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_max_reordering, sysctl_tcp_max_reordering);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_challenge_ack_limit, sysctl_tcp_challenge_ack_limit);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_pacing_ss_ratio, sysctl_tcp_pacing_ss_ratio);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_pacing_ca_ratio, sysctl_tcp_pacing_ca_ratio);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_comp_sack_delay_ns, sysctl_tcp_comp_sack_delay_ns);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_comp_sack_slack_ns, sysctl_tcp_comp_sack_slack_ns);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_fastopen, sysctl_tcp_fastopen);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_fastopen_blackhole_timeout,
+			       sysctl_tcp_fastopen_blackhole_timeout);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_plb_enabled, sysctl_tcp_plb_enabled);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_plb_cong_thresh, sysctl_tcp_plb_cong_thresh);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_shrink_window, sysctl_tcp_shrink_window);
+	CHECK_SYSCTL_TCP_FIELD(sysctl_tcp_syn_linear_timeouts, sysctl_tcp_syn_linear_timeouts);
+
+	memcpy(&net->ipv4.tcp_sysctl,
+	       &old_net->ipv4.tcp_sysctl, sizeof(net->ipv4.tcp_sysctl));
+	net->ipv4.sysctl_netns_inherit_tcp_sysctls =
+	   old_net->ipv4.sysctl_netns_inherit_tcp_sysctls;
+	net->ipv4.sysctl_tcp_min_snd_mss =
+	   old_net->ipv4.sysctl_tcp_min_snd_mss;
+	net->ipv4.sysctl_tcp_reordering =
+	   old_net->ipv4.sysctl_tcp_reordering;
+	net->ipv4.sysctl_tcp_notsent_lowat =
+	   old_net->ipv4.sysctl_tcp_notsent_lowat;
+
+	net->ipv4.sysctl_tcp_early_retrans =
+	   old_net->ipv4.sysctl_tcp_early_retrans;
+	net->ipv4.sysctl_tcp_tso_win_divisor =
+	   old_net->ipv4.sysctl_tcp_tso_win_divisor;
+	net->ipv4.sysctl_tcp_tso_rtt_log =
+	   old_net->ipv4.sysctl_tcp_tso_rtt_log;
+	net->ipv4.sysctl_tcp_autocorking =
+	   old_net->ipv4.sysctl_tcp_autocorking;
+	net->ipv4.sysctl_tcp_limit_output_bytes =
+	   old_net->ipv4.sysctl_tcp_limit_output_bytes;
+	net->ipv4.sysctl_tcp_min_rtt_wlen =
+	   old_net->ipv4.sysctl_tcp_min_rtt_wlen;
+	net->ipv4.sysctl_tcp_moderate_rcvbuf =
+	   old_net->ipv4.sysctl_tcp_moderate_rcvbuf;
+	net->ipv4.sysctl_tcp_rcvbuf_low_rtt =
+	   old_net->ipv4.sysctl_tcp_rcvbuf_low_rtt;
+	atomic_set(&net->ipv4.tfo_active_disable_times,
+		   atomic_read(&old_net->ipv4.tfo_active_disable_times));
+	return 0;
+}
+
 struct net *copy_net_ns(u64 flags,
 			struct user_namespace *user_ns, struct net *old_net)
 {
@@ -594,6 +662,10 @@ struct net *copy_net_ns(u64 flags,
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
 	}
+
+	if (READ_ONCE(old_net->ipv4.sysctl_netns_inherit_tcp_sysctls))
+		copy_net_ns_tcp_sysctls(net, old_net);
+
 	return net;
 }
 
-- 
2.47.3


