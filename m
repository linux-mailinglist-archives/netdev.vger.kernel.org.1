Return-Path: <netdev+bounces-135237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE399D157
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DF9285DED
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D2E1B86CC;
	Mon, 14 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Ln1Xrtia"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004291B4F2A;
	Mon, 14 Oct 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918800; cv=fail; b=iUIj1b701/v/b2bez6T7aRmCj2da7l5jTjwVC+cTimeMM4lmfDAWyNXifPVMCXmyybS4YUajJK9XFxLvixiW5oJ+9ID9UXfTTptIxL/Hlk8SZwR85uelm9kjwPIJHeW/PV5+IQEVwMbfQWxcdON299FvDa5+2S8vmEl+fkNYnrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918800; c=relaxed/simple;
	bh=tJ0iyqfaOtQhRg/d2qxFxSh1uZbPrtp8Mj+lzr9CT1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JthUjULtpv/C5wO2wWV4YQZKT5/Sh1p7uAqCkp1Y2ORGQx+w5X7q2K688YhcxBGTdO49ayfNFd958mbR6t9PdRSanXFuN+OrvvcGtvKEzgKmqyRW3cLhDsP+eiMwQXal24tNTz+h2bgs9cT2k2DkBwEApzbtDkLzpNclogmLVEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Ln1Xrtia; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4ky0UKhAUtgmDmMTWRt4rtgAI818ep464tBxrbH33ZM6mTswKmyQs7PFaKGKj7PAOtsERFUSh3M9e8VucmbuRXXqexC82yQG7nv7oK+QQCIOPjFpJL3XENek5wTgnhYSpbjfVtqheccQyE3XnFLpUFgnZDMhr8sNpdMLpaekSalce+eyWoUTYfY+UKbv0MWHhGxNv8zQbth7VaI49OQ4PC4gCchKeySniPrS7NKvKkfPlTRRH1TyqrdQU4MyW4Lkxu6QvIZXvIPZlstV+zxnTcS7gxXbDvRhfV+dyfBzSB4L/ozhFWZ2435YgrprkDUXYFXZdu3am6aRQf3kcE6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlFliFYEiT2k20zUehCmEE/OTyU+WRGiVUdr+buZxY0=;
 b=KIzxc4GQF+5gm06ShogoyZr2huTv7iFkalpTzD3L6gERbwJtCy3zPaNINIWvThDOMok8xiFvNS/fMAkYfOXZXUaUUmEXQ9F/YeTFlQ7cbTVcMXL0DX98J74MSrZTjifOrt7d7akOjViXrEQXpFQqL0/7wSVbMhHNrFR2PIGEgtpWZUqgOfVRCzIE76SukqOWx0oU+CWa8yTnkTpq5kYPit61QzvbOtEzlwEB6zrmppeagTp73a2E6AjHw6S2A7l7vr9IWhi6GUA1jDp3Lywdu3dZuUKd3Z+0Wwr8zGmDIfDoGS7AAjPpdRa08hixUAioRPNtN4MVrAWAWTw5uWqpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlFliFYEiT2k20zUehCmEE/OTyU+WRGiVUdr+buZxY0=;
 b=Ln1Xrtia/RcQNnaNklYXDvjqmEo3hnhHmTqNr8MgHFdKlEaKCSWJPBH6eKOHYBnVHxJDC73tV5iGJwyrYhp6HpaX/C+nq/zIqReabAyb7MwnlBGVNCF8esdAVyE9w7ESWnpF44+OVKQsk/sfZqo0jgZhiwsvdC9EXqSlcrs/7zSa9+ycvr7PQz26YWIwmKS1BGFn0VO8itEFIgRAIh7KuOgq/5yK/RqiVwGLMa2L5DXsZ9Nm/Zr5ehK5WtF7n6C0Ep2OeVtUxen352Q2xp564w9LRzjccORdjjlD1X+l3h/BtUjak3FYfrk4Q8Rb7rAIe6lWXWtrmFIYlv4FhhMSgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:11 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:11 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 04/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
Date: Mon, 14 Oct 2024 17:05:50 +0200
Message-ID: <20241014151247.1902637-5-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87854762-5e76-40e4-c80d-08dcec62b7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EpCGuT7sRxDmEgbjlRpahncOukYHFYzHAlR+ku+wizoT6ThbLvvk32AxAwA4?=
 =?us-ascii?Q?PZmpla8ttm30J066E5s1Ww2i9dwRVM8iZGMYZWB5L2IPSzJrY2nwtzkKMWVk?=
 =?us-ascii?Q?JBkovZ0Qv2OAdySrRC50HqcwcZFnYvf9XpxEXxNdXpnhXtvsE5xlCGrFNs8W?=
 =?us-ascii?Q?QY9N3191kYs1saxBXE8IojMTv5EGowhGZCiVE6Vfi00r+VL8Iw4JVfLPqoGq?=
 =?us-ascii?Q?50RAB2c6gcOvGyyJhhyf57Cw43N4qc3IWWAwBhpqZa6DXnXX1v3hNVy1r1/a?=
 =?us-ascii?Q?tcrN3yMLN6Gy5CkWo2f4GevbUjA91y51ZOj6kFoUkpc/GWwXULXMS5B0soSP?=
 =?us-ascii?Q?E+5Kk/keRZioBMsgzP+h0o8jwn7MDcTW75nurfvJuWrQB6PR8bR4B6Z0L0wi?=
 =?us-ascii?Q?VDr1oBKLZ+Wb699IzVFvR221FTKnXdreYBNP8PwsoxkrUEIvlAjkJrJI9Fx7?=
 =?us-ascii?Q?4bkvTVXS1oS1PjzddZDkspfBcqsDlACPAAfHIzG/lSY1rmar6gN4s5W96n7+?=
 =?us-ascii?Q?+8LXRsiDyMDuKBSw5x3wZR2Ihsj+llcMj1vzhLWYM0rRFlD/PBrhD80ziZnT?=
 =?us-ascii?Q?O7xmziGyKQNz/ei10wnZGCHJ1PSmJDkFVDKuCIKfZK5TSOAHYEOW+uwlOkkR?=
 =?us-ascii?Q?GiaA2XBGxSlFruQNcK7Z7OMzVwmiqxVpEepo7A0NldP5TkD6lfDVOOyDFmCl?=
 =?us-ascii?Q?OccXuvbxk9n294oIw3X1Ej3dcsqo+yxilH0ag2WqxheQc30cKrAgy17B/pyU?=
 =?us-ascii?Q?3FqA6YY1hMFnw6mbcj/ymoSl2L+hCaFAFNNiDFbY0IyNxOx5mMRslHc1CcU1?=
 =?us-ascii?Q?vBPA6Z1jvLLI+efWSttfp//hxBJ4jjhP8Lfi5om9fkg0dbBPycCPyDY9n63r?=
 =?us-ascii?Q?F5kpHujbhqz5v36xJe5j862+oUCotAB039bzA3qW/z1vyESf7Vlrb6WdQgzN?=
 =?us-ascii?Q?f9hUMfWoLa+GH9FrYjGNvuTnyakcf8Wl9SAFqAja+bKpT5GAouWXA2zuANgC?=
 =?us-ascii?Q?1HSb1DqSGeAbYgVwHHWqtzvaw4xBIO7YmP0p6okCFfIN69mTKeRcogvx5ipd?=
 =?us-ascii?Q?wI5eXeE2Y5beA+ulEg53vJvcpFUvQahtqqdKZZy1DL/PEsXFVOqPsKPO6+E+?=
 =?us-ascii?Q?TtogrCGtcw2jYOT3WJIxl2QV0leoRL/xnrvPNJTY1pZBWnnDp2gS2G6pJTzl?=
 =?us-ascii?Q?Rfy/BOqnlDYT73x0+HL97o/J6ZcbBc7FpDl30efaGSF92AvqTV1btQvNq8Hb?=
 =?us-ascii?Q?mCACJoEfwppJ6fPO+LdXdBIbnH6/VNXazHBsI9ccPcWL+evOTX36T8Y2BWU6?=
 =?us-ascii?Q?EtFRNahJuD27mPdThmxoA6tclWSkqEZs+LxgXDaYzIBoGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tjvpMTMi4knnqH1Qh2vdBNMqKiDFoYnm+Oj0mf8MxaPQyk2D+3LAYx93tizy?=
 =?us-ascii?Q?HKpQoUD4t9xDhbO34+q43u3YSjVdHZ5CmKMhXoyLOvRczpDcjn3qZzvXbNSc?=
 =?us-ascii?Q?oAkYbeH1NJNo3Q4YMgAne4MgXlAPpznYuUSXbgzhMx2ucbJ54BVUneUN1DIe?=
 =?us-ascii?Q?Q0CKRv4yIonCNDdJbRLpZHP9pgGVHD+JnTDTJ1CknTLdElHVUD8eoWSEexZP?=
 =?us-ascii?Q?FqyTDaERDvfiLrcDvkAodW76MNXDTpvsBFofILc59a/9sosd/WhzAHnFvexf?=
 =?us-ascii?Q?Zzydoh4xN0dMlEXMUe0rHpqmtL9dIVSA5XTJEvDa6BiMt27IrUcQzQQvi5M0?=
 =?us-ascii?Q?cNlrKArfR5uRXsZRIaA6D/DRyqAUP7YwynjI88OIdAtPnsGjiNY7zPFbKEUy?=
 =?us-ascii?Q?C5g2i7lMH4DqEOC3QlCLy+eDz/A7rkZDTgpBUzFdctdKjZarh340R84n/vjY?=
 =?us-ascii?Q?WKwSbCxELkni7m1wHEBiIEWmBeypjDzlp7BDErgxY3A4sb4J8Et+f1BVx3z8?=
 =?us-ascii?Q?UkLh3RtCSYB4ajC4YSaL/zn/UvBgKnLDZsYljJYeI24a7rVuY5kluJqkOe6B?=
 =?us-ascii?Q?ec5sJmTfc1MhMH73VjlTjucivDoS4hUFK4nt1JfC+Lg7kjdWmAAZkKLKS0TD?=
 =?us-ascii?Q?b6gW1LqBMTLgika+oMcairX+PPyseANAMa0W8AsiL7W3QjrGI8P6z0a6gRfA?=
 =?us-ascii?Q?vD28X6agGSx8Z5ltepJRVHqWqCYOer9zd0lm92k8/oZ3rxpf9P7yT2o2cZI8?=
 =?us-ascii?Q?Gs2mZsqqCi3Y72SRdgTrELCt+puQoPwJf1mq/6RjOh2vHvkQFK77D2i/lUKa?=
 =?us-ascii?Q?eA0u1b65Q+h7lCc8Tk6j61crxXfQV+skdYF3iOruBzPv1GC8GNX6hYv+sCS7?=
 =?us-ascii?Q?tij3UIlfN29XsmdB0lq18ruXpY7l/FLNM/TH1a8VJM4IzkhZpQj4ERxk8DLc?=
 =?us-ascii?Q?bUVcqRtGw6wI2SAwqkfErGG7LpGM8WiW8T7hUMkJsgzbVDMNcAKx+88gmhLm?=
 =?us-ascii?Q?BwNQbqOFIUFQ069MPGi/+WRVAi5XPVq0RgEU7gMcXYxI0nrHgRmjJnilJ7rM?=
 =?us-ascii?Q?t1+iKiEU7Q1EzXh8DnNgil7ihNlDAUHA6uwjkdOhqvpCQXn8Om6iBJ079oaz?=
 =?us-ascii?Q?OhNZ1AsBAkyHjnOKgZRqgE/KCf4LESXidbx5jPODCG5e/nhghPHshp484SO5?=
 =?us-ascii?Q?gzP9L/Ju3cBBaagZdPboawiGYe1k4FYHsuHBqOqsTF7GZAvVayAPwru53MsE?=
 =?us-ascii?Q?RHTfpSmOHnI7woUWSzuHpBaVFNoYgStNPEhTn1/3w5zZma6g9axLzzvwSIat?=
 =?us-ascii?Q?koK1SaAaVh14Eh7lVZs/M2VZTK9VgvCPQYiL7PrcpVN1DReo4UqyShJHmn4K?=
 =?us-ascii?Q?WZ+jf9FhING15R4VvPLOlYL5QbRS75Kbwr3ackaKlCjkrhlZYdnQP4Xbc/4h?=
 =?us-ascii?Q?+QHFtMn/DVok9DPZYf6nWGMLCA3lsSwUkUE2f+4OcnYyn1B2VoroK6Lv1EkM?=
 =?us-ascii?Q?Os4wQbmXNbeh2uw7TJmm2j7HnBu9ED4+PtTqC5APdXI+Xlyui4zv+k+OhNSX?=
 =?us-ascii?Q?TxzYBZB5OLgog/DilOhGkVSeeGQFJNbmQxK+fsMTCE3avA6wnrKTav1u0VS8?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87854762-5e76-40e4-c80d-08dcec62b7ab
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:11.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abMmGYw7tlvMp854e9owZmIplsbRWeHNoZVf+HxOdP1y4NMDcUv21/WzuV7C5MJGmWZrL3V4ONoWxeGzBuJixpUPt5JP46QpF53JTOeadkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b84444040e0e..c47564f0c868 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2299,11 +2299,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
@@ -2321,15 +2323,15 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 
 		dev = skb->dev;
 		if (!dev || (vif = ip6mr_find_vif(mrt, dev)) < 0) {
-			rcu_read_unlock();
-			return -ENODEV;
+			err = -ENODEV;
+			goto out;
 		}
 
 		/* really correct? */
 		skb2 = alloc_skb(sizeof(struct ipv6hdr), GFP_ATOMIC);
 		if (!skb2) {
-			rcu_read_unlock();
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
 
 		NETLINK_CB(skb2).portid = portid;
@@ -2351,12 +2353,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 		iph->daddr = rt->rt6i_dst.addr;
 
 		err = ip6mr_cache_unresolved(mrt, vif, skb2, dev);
-		rcu_read_unlock();
 
-		return err;
+		goto out;
 	}
 
 	err = mr_fill_mroute(mrt, skb, &cache->_c, rtm);
+
+out:
 	rcu_read_unlock();
 	return err;
 }
-- 
2.42.0


