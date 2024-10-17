Return-Path: <netdev+bounces-136702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B29A2B38
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374F11F228AC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC91E04BA;
	Thu, 17 Oct 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Ai0cAhS+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE61DFE2A;
	Thu, 17 Oct 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186932; cv=fail; b=FYJl9QJeH9QbqAnvL01stSukteTY9RWTIhR4MSjmyF6pFxZIsH2OVDEEe+J/DPxuBgwM3KMY24ZWxZmXBtWr2hKTgiz4sVBVoKqlkKwV4JjTRq6M2Iq9hKi719EPjRPYO7AXeFCslVyapzwu50AF6SYRGSEJ51g17ibbL7rtPeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186932; c=relaxed/simple;
	bh=7XajWwwKYUyPnHl4RxdyG7BDoP7pfbQwp3SHYG4Utqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OEf8gG3+l5F8478TGypdXPjWeohMM12GxkWZEX0ODcxfht0gUGEPsWGRacnoblYCJThjgoFe/8/TxQgq6WRFQyVLbZdR6vKttC0LDLK2eGM1zRlTX+NMNTNkgQL1wN0k0xhvVz8M4VB6XEYwp4aJ2pau9VhxzmRLAOlwPZ5e3r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Ai0cAhS+; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS4qNxEolNDCR48G19KkWlHDOflaT2rITI616EnYwQ+T1THOAe0vz80qtUSVTtycXD9ICrhqxYxx1pgVeP2v9Z/NgCddtZFC7KmLo9UFVlQsQU6eWJ1/MN9PB+BWEITfgK8nxSJ/8uUh/80l62CSrKqenQ5WDgx81nT+SoSGlfhCypycrgJPhmTUXiWTNwXFBvkh0fF7KXs8jAozMezlEJc+AJIuXjN5KGTUjSjT0K/4XaAEMCnfy8pVHcdnerjR1+U0PbKQ9JFh2a0I9+yWbZxPvzUc4kfVRG5qlgqLj4izMvicZJW04OGgIscluIiiumM1VCUiFrUkHb1XDRvNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3+JfUc7sae+MSPXt5wBH65gqbhnwiyq8IxPP5WrClY=;
 b=G1x/vE6BVmPxsbn3mHAu9yn7rbwB2wf3F6UaESiiNNswAtVKEYWzIAgWL3EKetHF8PQcvoEsydIG0a8nYXaxAB83FbB4mwxm3AcUWj4K3kKqIROIpfcHNe+eNgZbC1TUzk/i3bOiwVG5ImzgrVE6X5Pv5Fyj19ZV90qnoUAZJmku8X39LyUMTlI7AHVIL4pn3Jevd+EssQ1DsRK5ZFOW8J5Il/BcAjvc8d/voibDhI0Y/+soReSfEB/SrxlFzFYHNp4+KiLYh1P3RXR9GZIIVbF1eEr+xdVv6nkGNEVNK+GQ4ABll5CTXTJcnP34fERAsGhqudlBN8Qns9ubYUQB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3+JfUc7sae+MSPXt5wBH65gqbhnwiyq8IxPP5WrClY=;
 b=Ai0cAhS+tKbUs4C9TVfasxdLufeorAOYygcdSyJqVWCfNQOPP/Q4B+MFUgGyR4WOJQ7lgToa+pCKEV2uZCWZ1sU8iWcLD8fibGnw5KIfAsQ4bLoi6qa6M62y/ug58P54ee+xTycAqqRS6rSI6XTL/iLNCYedsBMPEnRiRhJbl0wo3TFy/SoLIx3i7KZEZ605g9KehH014ug35IcJwHMRYx9D0xU4ykD51VXAueAgj88ASHa5juNe00xWITZZiAwb58rRd98NY6m3z9qH7Fjxr/8yaRdVfPflTu+y2Y70XFw9RNxiI8SmEk5/EBFrHvCq+jYBrdpg7nC3TBpkWZtluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:41:53 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:41:53 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 04/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
Date: Thu, 17 Oct 2024 19:37:46 +0200
Message-ID: <20241017174109.85717-5-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 2905dc10-1fda-4910-8ceb-08dceed2f6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4/BPqGqtw01PLo/2hDvY2Z5Xk50OTBxzJ0w+a6pN1D7EQDyOxqL0G+axIp3?=
 =?us-ascii?Q?9u3MRx8nSqXueGPpFFg+5szvJtZu/oGSamF0dToMSfQJxfy2Vt7co9Maogl6?=
 =?us-ascii?Q?P0y2sAnkjij5vcZbDSN8Pm+vpFB5u4gA6O6498N6Vy7IUJAvYB6wpk4tSRAC?=
 =?us-ascii?Q?zFtYBTv9Ob5kazoJQOnRZWK3ef/l3bjiQXg06zTdTYcHGWLx5O/f0D80WXNu?=
 =?us-ascii?Q?MzLXbqOJnSci9/i9RzGVyvaLayn4pvyIybeK8/94A0V7T9OejfW6TwAH7SAQ?=
 =?us-ascii?Q?RklJ4eOqMkNMFCOwliFvmR50pJh6Ay/bBpoFZepjdKuvZkp4ocFELivrXIId?=
 =?us-ascii?Q?9F4vcIfiu1zuMGu8aqZ+/NZqiXpJmKvrCxE6HkzcBrtgkefK0rR3SAtB7Pi1?=
 =?us-ascii?Q?OMTVxOIvfxQCscxVEXpvdTFXhWm1N5drmqCw0lBxzZ/e1yDuf+rb9cpyvJoB?=
 =?us-ascii?Q?EvowTyITjT/jRPcocOWuBUu+DVQiTOR+Sm3N0Wpm5jiZBd6P0fFwDbCxrJbv?=
 =?us-ascii?Q?VwGGj6hOIUayclSDaKdRVDV7krQPf77UeoK3piHPjihFXwqf7UVB6UNGQwcV?=
 =?us-ascii?Q?uyYLZwBs8sOygQoxIr3gyFl6Vl7v+2Meyp+A3w6/68sBhwrh+kgu6M0k4t9h?=
 =?us-ascii?Q?Xhu2/a3KidXvO8rFOM4oenqGzx1oQUhTVWp6kvVhPhJE41rFrQLNryq3Jsl3?=
 =?us-ascii?Q?zcrD2Qq+yvz+JfBcS6Zj5+Xu0/4LNaZM6TzYaaHghJMOkGziWTgW9Qp94VFj?=
 =?us-ascii?Q?2jkKVRYtGXCPK+O0cfRtuf5/em7m782d115gaTDnWc2ibLH1TPuPIpTOofXu?=
 =?us-ascii?Q?0Y6p6VL29+YcFx0zGFUW2Jo5xTjnUdfCtT4v+q0ih0sJTikUHbEJJi5GIwwo?=
 =?us-ascii?Q?dSdshHDEa3fawEg1GVK+yFOu/vOuUQBaqrubypX7G5mq3fo8a2g0y2haw+du?=
 =?us-ascii?Q?q6UhdfxRnQDhvWSd1kqLZkHzyJdKYFowXE8iSfuR39T6mnycDqkMq8Acg9At?=
 =?us-ascii?Q?+Zf/XcjV1QzgQUVI0p2lkECOZ/6fdcm1aswhKMf80o626KNNV8Yw3iwTGcy3?=
 =?us-ascii?Q?NwpFklGlIavzoIqENvU4XPs8nzU6QIuNjbrSn7CObC0zsvBd1H2I/oN4gmrE?=
 =?us-ascii?Q?lpNur8utOxtEJdLapP+3Gi9EqjOHGFujsMJdjWwXao1voGZy4hw5UjxyWVxI?=
 =?us-ascii?Q?+k5ChyVhi/F1AZ9WZIfRIBDsQWuVfXLnrA7BCw5OU5DE7CMZDZcVwYkmw/iB?=
 =?us-ascii?Q?J2yoGQoKBTyJKPzxVVVKyvDIuyiCf+rHpCqIGKb3rjbeIc8GsBufL5BuAEP+?=
 =?us-ascii?Q?o/Eu4+YyiG5oCf/d406GGWg6YUgUMwzBcQiD4QZsQJZIgKAfBWtgMenoBjFY?=
 =?us-ascii?Q?ln/BGF8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWvR96hykHKLqNqxqmnUwLg0ftJfD/p8Xwybk77Ow/c6Ajcpe0TeRpqt6ytR?=
 =?us-ascii?Q?wl92lvM0psHG8HQ1bWUsN4sRrnIknm9bCRsIduo1fSQN0kHr3xYo2WAJ8nS3?=
 =?us-ascii?Q?sLqVss5W5SLRWtp20ypT5ws6zE5uRqBMiXc5bFYx9EKMjd85Xo9xrEyyYJOi?=
 =?us-ascii?Q?nynib+MNZIeZ4DZ0Kp2lOHD9tw5fuGq24Ji2enKWzVarLk/YzBb5SuY0zNR7?=
 =?us-ascii?Q?q6sJv/XyssMmBrGEqWNkEyC/lTQdsvEWWv8iFh/9mv7YN250cnXZ4TjYvXnq?=
 =?us-ascii?Q?Ghexl2cetsmUUd+BgfDxXYZKu6dti+y3r5NRUSOP4erdOeBGzRxMNzjVj/xg?=
 =?us-ascii?Q?YIHQRLdXJlexobCvXpaPiNT5Fld9tanIHiSVqtrOOyIRWb+tZV9wIT8Xe+H/?=
 =?us-ascii?Q?qKtbn21m1eWisoKhxEz8ZGbwofz6GJR8Qi4ssVhIWXmpnGYruIvZ/i9CM9a4?=
 =?us-ascii?Q?fxsXGOWbe9+CgXKX+4XlYhLrpmx2o6AwwRFp4RM2FsOCO7aaqiBGnlhktdPt?=
 =?us-ascii?Q?gkEH0xVCWngoZ1W5M2xmz3skyLqZn5AEivqnN+437GSrbTWBMimgJxxfzBFP?=
 =?us-ascii?Q?hU2H7ne2Lr3S+fPVyhFIlhkCyghD1jFhu1mUd9Fnix1dWS9LIyKFSFsUvdqE?=
 =?us-ascii?Q?cxIGIFz4BfDnxM+x69O6AKdj1DUMAzb4tWzDWUmMPExhSuF9U9ZRKSTZTE71?=
 =?us-ascii?Q?YxmEE6xBXAY2sRmayuctPvFzeLwD68foNofGSH2Z//rEZumkK4ixPYRdHaCo?=
 =?us-ascii?Q?wYtd0lQGtR6Upx3obfrYK+EcjWYsBKuJdF3feA6Xl+LSZQ5L6aiE4G8dvTVn?=
 =?us-ascii?Q?I3MSoitj2OMz7TWLaZ1zN2l0bc/KucmndmKVxrvjNNF1f8fhuMC8iyOT0n76?=
 =?us-ascii?Q?Sj+Kkdz/pZPpQmNiLQUxK3YBijiQuzEq3OmtN/duQKEw9oUHpI9XJrG+5dGK?=
 =?us-ascii?Q?UcCqJg6HTPu6eENaw7xdLqMvkiZogR//Wilqlwxqyk3cEkltKNlAYCcy7I9k?=
 =?us-ascii?Q?dTGV1z/6GJEknKDHhI9yBYSG8qF9wAOFHXaxcsAdlShrOk4x0HPhdkySyUXv?=
 =?us-ascii?Q?Ddrr3sicz2hXRs2qY/1rckHlP56ZqsvRtOISkRFfdIYFF2bOcyQ64iF7AaFY?=
 =?us-ascii?Q?dEYyLNa8vN+Gd5TIIxQDKiwvuw05h0Iv3xJEUjjd9uQkd99fqWwPeF2jJq4Q?=
 =?us-ascii?Q?Pyj8J7+yuku3iW89RK4PJuZXmRb0wQjMgykirMafA93x4w4d99mHJUlksY9R?=
 =?us-ascii?Q?QH/588IvMu+8uwOiyTrwOVwOGhkev059ufJQXT1JZj1kOXfYkfZYbsxBdDUs?=
 =?us-ascii?Q?xUDoKVvhHDzgoT05O/PlbNsUWw7yNIhlIkIdEytp/URyOgaSNtqFXN96diUp?=
 =?us-ascii?Q?+wrK27BJk6+3FUCinTS84sHt681ehAcBxSP3G1zOTg1GjSfd6ZMyDKgH5BEg?=
 =?us-ascii?Q?cba5Bq/jOKjrNRVQOKEly8CleIqQOT2Yd1wHG/pa4g70C3exKBO2Yr8PTjs8?=
 =?us-ascii?Q?n6tSH8s/kf5Rkd2nIrcCdvcq6Tiu32CMbnm64AuWQZLoWDSOfohCU112Ptz3?=
 =?us-ascii?Q?5eNqWub2yPawHgdtKZQ3a4IpXaTdrJmfGTPEbLuao5ULX6sSheeK3jBir5Y2?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2905dc10-1fda-4910-8ceb-08dceed2f6a9
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:42.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pV4uBIijan+ywtYRhskFxGl86Sc/R8jn0g1pdxPh3iFOf+5kiHbyOmRwCq1w/CI/EbLnsK2lnxWnVDkygub+lpihOGFYX2NdfMmirZ3BqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 968642bde8f8..017f9e31edfb 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2303,11 +2303,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 
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
@@ -2325,15 +2327,15 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 
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
@@ -2355,12 +2357,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
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


