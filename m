Return-Path: <netdev+bounces-99210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC98D41F1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0121C2207B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1321CB32C;
	Wed, 29 May 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="CC1YH1J9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2139.outbound.protection.outlook.com [40.107.212.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9F178387
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024748; cv=fail; b=JDsHXTkA5eloNcCHH9prtGaqhCFWTszRIwW71wQfbVu9iCtyNMgF97NAbaCdwSeH15KPE1rVPzyZ231LtOkIgOXLEROjr44rwoD69Rbadm4BuTQ2adrF/tzi6g0E6efOK15rl3VQ4liUyreJtkSvgQHXQgU8mBGlSYxR4UhzZxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024748; c=relaxed/simple;
	bh=JcIAn9KTeojfcs4DVTLHUYlLNDGqIwNPNta6I1STXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTTyqkk8xAE2dcvByPoO+JdgK2f7+jj3ODaUDP78fri6DJ58TQXWhG1VaSMn0psuVO+SmHLt40bBXtTpQa0khK7ytpzi3pQ0xjkBjpI11EwWDQ2+8fofGnobEv8CJsCFHrFRfRVn4Q5JtI8RHX0BIGacpod59rlS7korzJnkBLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=CC1YH1J9; arc=fail smtp.client-ip=40.107.212.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN/BazTLitQOWJ0KqKO1/c8S/dAvCzPTpgVYam8HnRoAkw3QxTuKJRPQ1uBwy14HxDmQowMGEY+cVXc7/H67zyZ9HqoZeOgiiccrtpEMS83Rw2yGIcCsP4QkL8S1yq0tZYDNNvXNci98uoYwRvFgiJeESQ1uQn4rwaKsLO+rWubmGFkGNa11vFZYna1NlyB53RiKKXuVgDJC6PakVMVbKfn0L/f17DJOMWGlLdYgud0o+p8Pufoe7o7DP9VrFK/5UgDMAP8DuRMSBZcEzpZb3VsKwHzeu9wou5OS3IHvHNMZJYAYJVaAMKYi3ED3oX9nbS5lKWrdFdEdpcciHa3Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRaME/wEKZf50Yfhq+87WRmCxYS72DdLpwUNDbvlzhQ=;
 b=Vm8OZAK1sUlLlH7rQg0Cz+OoSa22gJTi/1XqbEUk8Siiec76GpnxEXCaJXiUvzqrp5Lob6hxYy4IPysS3PnnT0vm8ZP+ka8I8fZTCsywRYVWs5yIV09dcxG0f0c1D0CbFcjhpgQzKDvxWyY/MtklL49asiq4s9GVf31QnJdnOJgdGg1pTGTPLO3IeoCzJXHBtshc9xRm96t7ZujcBC9RJ7jiFpaS1oq2Tk7ZOyIDxdh9+0mFzMGqq+WRHvqXOla5yTgxyZA0E6ekBJpUNh0hYaHCyZbDcIs9VIflZA1qj1Sc78t3+ChxrhGC47sLpskcu3HH1JfqU6mLgtjkbLpWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRaME/wEKZf50Yfhq+87WRmCxYS72DdLpwUNDbvlzhQ=;
 b=CC1YH1J9yYA8VLNyko92cBxJhHas0c4oqB7Rbg+UfSDs0LtPFts9JG+I14KIP/9bXCsD9vWfk3Jxkq/4taJdpfv5+vyhsxh627oyoLTw8F09gUj1hBTvMv3i1RWHvl/hlAPi5pc8wWIK6EI6IAQH/4U+pOw52hmtkWvyD2QM4Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from PH7PR14MB5619.namprd14.prod.outlook.com (2603:10b6:510:1f4::21)
 by LV8PR14MB7648.namprd14.prod.outlook.com (2603:10b6:408:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 23:19:03 +0000
Received: from PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a]) by PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a%4]) with mapi id 15.20.7611.031; Wed, 29 May 2024
 23:19:03 +0000
From: Eric Kinzie <ekinzie@labn.net>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric H Kinzie <ekinzie@labn.net>,
	netdev@vger.kernel.org
Subject: [RFC net-next 2/2] net: mpls: support point-to-multipoint LSPs
Date: Wed, 29 May 2024 19:18:45 -0400
Message-ID: <20240529231847.16719-3-ekinzie@labn.net>
X-Mailer: git-send-email 2.45.1.313.g3a57aa566a
In-Reply-To: <20240529231847.16719-1-ekinzie@labn.net>
References: <20240529231847.16719-1-ekinzie@labn.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0041.namprd18.prod.outlook.com
 (2603:10b6:610:55::21) To PH7PR14MB5619.namprd14.prod.outlook.com
 (2603:10b6:510:1f4::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR14MB5619:EE_|LV8PR14MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: acfdc8f3-8b5c-424c-40c2-08dc8035bac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i3OSmezYK5LQa4KXQuywLT7zET7IaxvLBDNQrNVI5wIOYF0IpNc5ABDcQ8Q/?=
 =?us-ascii?Q?l/c3yxWKP4T/Uo0T0lo74vmnX8A3e5mDgttyWhU2yAUQDg9a3zbxUjQ6TOLn?=
 =?us-ascii?Q?gqwapsYGJPUUiDxlL3MHwYmMmxfrWur724A/SaBsCdkyRvxNAQ5YXbOrg77j?=
 =?us-ascii?Q?6mPE3F6AfdSkSxhvhT3y/+xhnJQvBLGE3yIGLDzPkU4q4Fji3ZVoOKBsUgNt?=
 =?us-ascii?Q?B6/MoqIbannNB3WNfSOe1ZHD8G653bfsswRUIaor7r5I3gNQk44fiDOJcJql?=
 =?us-ascii?Q?Lhd7XLG4nqamJczHTw57MH2CQTy1ssHGCKk9+fRuZpvMLC7WBQSzSxalNr/z?=
 =?us-ascii?Q?GGuGq+gk0X0UNnXTtIFjqcP5bx6JdCQPbNhFafukx08l/FyUu9gtBhuZTBMS?=
 =?us-ascii?Q?YsWnO1Fb+aayrUTrqVP7Uweb7LuGvhvBnUpZ2Rt9LYDJ5CddL6rsgBqXHVih?=
 =?us-ascii?Q?HOVNq5Th70M8OJF+BlPPEIMb+k82oRAOwZ9bjoCX6wB6D7N4KYR3Edm6+WNr?=
 =?us-ascii?Q?QMOKeOV6JjVtksdfMjNae5ZsRzfGDlDG+CKEEwhV4tvh95dhMX4PZVQ1O5VL?=
 =?us-ascii?Q?GWB8u48DSB+QOTReZIZI+oA7nJ1p5QPXQst2Q0J2yL3y//VzIV3S/J6pE5oy?=
 =?us-ascii?Q?q6iZ+x0g25dWWideHy2ehiT8eKUkhCGvKUAyLNzHM/B/GRf1mFBXyPiXB/mE?=
 =?us-ascii?Q?YEVsl1lRcp8bsrGk1+kTt1NKPitrjcoQUtnsJFFmtFJyY4ORFC4ktXi4yJG4?=
 =?us-ascii?Q?XpKslj2wLeHKMZgTPalN710Wsod5113gWMJYG6BVg7NUME9Dbfi6hOidj4KV?=
 =?us-ascii?Q?SdszFnBm/eDcfnijDEOY/ejNwwBlmXVQnF+ZxoGTF/jwSPjQvh+o7Db9PImA?=
 =?us-ascii?Q?v+GiFsCufU2QSVVPQ1nCyD3FvSEi0icuIPpDR/DSv1BVrJZ8vDwvrpPeEVLe?=
 =?us-ascii?Q?Pc88e0LTMqo0wNAzvdalZHRlNNynKIHF+Gp8XCDj89OZYy3bwAjSjT61RKYn?=
 =?us-ascii?Q?bO99lEBa9slgYEadf7L14lOh3ZZnCSgvlfjiJsaCXm1zfz6Fea/l/+9tnNjd?=
 =?us-ascii?Q?+DYX9zLhBv9e0Cz77uXZboCVtaC3ICrCZusW9HXJMe8kfmp3ubY6XeZ3pb7d?=
 =?us-ascii?Q?ngOrd2avYu8y9+VahpzeSgt2DkAJYRIn7yDeWXRH0+VuxY++pIA0JfuDGLN0?=
 =?us-ascii?Q?eahIld5Q5iAzh6gWYmN+yGPw6fUjZ7UhlCibIODvtBjsRHOnWpUMrpMW2trf?=
 =?us-ascii?Q?TjKoBQHZUJbY2ZG7XcclnwmjN6Tku9ixrM4wbsxBMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5619.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOtrIlXFsV8Ore1UqmOvfTAni7DDlMVsQUPifFCRk191ZtPKuvyRyVhaZswr?=
 =?us-ascii?Q?a4Bb3dQAltXdfvi2iNPTJi+4oEH0wH2Hpmwy6+LepxvTMvmDdhyou97zpCx0?=
 =?us-ascii?Q?m0P8CwbO+BhhCl2HgNZNc7VJG+GSbnYUvoTPDE41u05me01ZeNZTz1Puj+vw?=
 =?us-ascii?Q?EZiVtQvHKUJzEc2Up34cta2KIsSuNEQcCLl7EzxG8Phlo7bhejl0ur2T0GDf?=
 =?us-ascii?Q?LsQGoeFfQaYh/XzERN3oDvuYToTbonJYziCmarlWnAavSOLKL7JlLa+zKlZw?=
 =?us-ascii?Q?Pg58aQnl3Ab4C8sTdPYrDrSpHgltCKiic4RUdX56IKtowgam5pgcRPKlvQCn?=
 =?us-ascii?Q?fiLLiLxeVBan7pj4Gsp9mO2ht1hRMcM2T40N54L55q5H3XgOUN8D2LgEgHBZ?=
 =?us-ascii?Q?6wANXBPa6PUJoDoQhkkM6VPdnyFGxL3+wQG8BCVhNjQRSSphjo2gTaWqBkzg?=
 =?us-ascii?Q?dodDEo74SDH1KJ3Ep4pTQ76xQYS7DJuJNm662EFCpsIjyOaJTFn40YxJSor2?=
 =?us-ascii?Q?BHgN5qN/9taleBkvBMCHIkYDbNLy+k8CF8eYHcxyHFxkAY6Ou0g17Pi5Vk2l?=
 =?us-ascii?Q?nYDCvXtB7vZIAc1Ga/7qvyT5J+ekcNU1UqdzCrlxIe3487iO1H92aiGpX43q?=
 =?us-ascii?Q?myIRA9gbJc8wxNsOVKV1/ijUBj3aXGgubXobonssu1il8gWyA1TZhcdXtRF6?=
 =?us-ascii?Q?ZKUxGbdbu7ifA+kRBMEjg2a8sR9gzCBodfBkaanhYjI5GEQ3zrPErfXFT3db?=
 =?us-ascii?Q?bqEF6InsuVOpYCOisRt2tQ8gLBD4szNLfbiOlX8UzzizxWYS22AlhtCdNNj3?=
 =?us-ascii?Q?39t4qL+xHpRwQoj69KjIHQTzsC30zvqaTiWk/QbqaWqzpuTuc+QIq0cuHhCZ?=
 =?us-ascii?Q?Y0QSs108T8otYyeZVOlyA2VKM2Lugbe94ee7PmbV64B0jl8FjSvd8NJABFgf?=
 =?us-ascii?Q?pPRymtw7FWkAnTC5cibrT0CR4TM5UwhcFj+cbdJzBOfOBpGlCE/WIuntuQeQ?=
 =?us-ascii?Q?9BH70MQBdKVmXj3WKHcYFyXLinJwS8lTqulljrWSp1H2CUB18rdgKlIGANT3?=
 =?us-ascii?Q?2x6BIOrH2igZl7nI+vFYHi62zH/V00Qe5EcSF3OfPdiDZWIiowJTBiAV01f+?=
 =?us-ascii?Q?GrZk5ZdfXUmXqEQFaiL2tg/F2V54mKQjv+7uE8GM5MNYHan4u2mxCOcYZ2oP?=
 =?us-ascii?Q?m6BVXUPVxXAZ3pcNVPuVManodSsfD2OIoAB6rdpEJ8RJOb3L9BC6bwkC+JVJ?=
 =?us-ascii?Q?P8kApNd8KpdDcXKUhxf1rXsB8NK3rcoZvhQG6MW1SReL9hNkAfpgP22CNChH?=
 =?us-ascii?Q?qoAT7G/AA+7uMV7NK6/oJxmZkxeXvWothpokcdOvVK1wwyi1ZLf7pIC37F1F?=
 =?us-ascii?Q?Q93CuK/f9jIUDQkv50bPMuv2XyKboi8jB1r+B3YE0K1c16OkvJU5jtWuhnF0?=
 =?us-ascii?Q?ZVFxfipl3ByjUwBbWAVqiJi6U4kYyARLveZu0SMDCo0yFPyyQNovUOsSbk62?=
 =?us-ascii?Q?2hMJkn57dEFy49KWeBxka4CaiXQ5i+LoCrBZTkjDq3JM4Xbq0fwu1zDZFEaN?=
 =?us-ascii?Q?bIQqqUNxvDLWjOVzOfG5UTl/YFXG/EDu/GM2rOBA?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: acfdc8f3-8b5c-424c-40c2-08dc8035bac7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5619.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 23:19:03.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3MLWJECoyp4JirdSTVcqaFYqG2zaGInn6lRMOeaZVQc7VPxbV9ESEHnl/iM9NnJ9OO3NWrW/Y3/3UahVZIotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR14MB7648

From: Eric H Kinzie <ekinzie@labn.net>

MPLS can multicast packets through point-to-multipoint LSPs.
The structure mpls_route has space to store multiple next-hops for the
purposes of multipath forwarding.  Alternatively, use this area to store
multiple next-hops for p2mp.  This change is consistent with RFC5332
section 4 for downstream-assigned labels, in that it continues to use
the unicast ether type (ETH_P_MPLS_UC) for multicast Ethernet frames.

p2mp routes are added by declaring a route type to be RTN_MULTICAST.
For example:
	ip -f mpls route add multicast 100 \
	  nexthop as 200 via inet 10.0.2.1 \
	  nexthop as 300 via inet 10.0.3.1 \
	  nexthop as 400 via inet 10.0.4.1

Signed-off-by: Eric H Kinzie <ekinzie@labn.net>
---
 net/mpls/af_mpls.c  | 218 ++++++++++++++++++++++++++++++--------------
 net/mpls/internal.h |   6 +-
 2 files changed, 153 insertions(+), 71 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 2dc7a908a6bb..e7f39ee05c19 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -339,76 +339,18 @@ static bool mpls_egress(struct net *net, struct mpls_route *rt,
 	return success;
 }
 
-static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
-			struct packet_type *pt, struct net_device *orig_dev)
+static int mpls_forward_finish(struct sk_buff *skb, struct mpls_dev *mdev,
+			       struct mpls_entry_decoded *dec,
+			       struct mpls_route *rt, const struct mpls_nh *nh)
 {
-	struct net *net = dev_net(dev);
 	struct mpls_shim_hdr *hdr;
-	const struct mpls_nh *nh;
-	struct mpls_route *rt;
-	struct mpls_entry_decoded dec;
 	struct net_device *out_dev;
 	struct mpls_dev *out_mdev;
-	struct mpls_dev *mdev;
 	unsigned int hh_len;
 	unsigned int new_header_size;
 	unsigned int mtu;
 	int err;
 
-	/* Careful this entire function runs inside of an rcu critical section */
-
-	mdev = mpls_dev_get(dev);
-	if (!mdev)
-		goto drop;
-
-	MPLS_INC_STATS_LEN(mdev, skb->len, rx_packets,
-			   rx_bytes);
-
-	if (!mdev->input_enabled) {
-		MPLS_INC_STATS(mdev, rx_dropped);
-		goto drop;
-	}
-
-	if (skb->pkt_type != PACKET_HOST)
-		goto err;
-
-	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
-		goto err;
-
-	if (!pskb_may_pull(skb, sizeof(*hdr)))
-		goto err;
-
-	skb_dst_drop(skb);
-
-	/* Read and decode the label */
-	hdr = mpls_hdr(skb);
-	dec = mpls_entry_decode(hdr);
-
-	rt = mpls_route_input_rcu(net, dec.label);
-	if (!rt) {
-		MPLS_INC_STATS(mdev, rx_noroute);
-		goto drop;
-	}
-
-	nh = mpls_select_multipath(rt, skb);
-	if (!nh)
-		goto err;
-
-	/* Pop the label */
-	skb_pull(skb, sizeof(*hdr));
-	skb_reset_network_header(skb);
-
-	skb_orphan(skb);
-
-	if (skb_warn_if_lro(skb))
-		goto err;
-
-	skb_forward_csum(skb);
-
-	/* Verify ttl is valid */
-	if (dec.ttl <= 1)
-		goto err;
-
 	/* Find the output device */
 	out_dev = nh->nh_dev;
 	if (!mpls_output_possible(out_dev))
@@ -431,10 +373,9 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	skb->dev = out_dev;
 	skb->protocol = htons(ETH_P_MPLS_UC);
 
-	dec.ttl -= 1;
-	if (unlikely(!new_header_size && dec.bos)) {
+	if (unlikely(!new_header_size && dec->bos)) {
 		/* Penultimate hop popping */
-		if (!mpls_egress(dev_net(out_dev), rt, skb, dec))
+		if (!mpls_egress(dev_net(out_dev), rt, skb, *dec))
 			goto err;
 	} else {
 		bool bos;
@@ -443,10 +384,10 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 		skb_reset_network_header(skb);
 		/* Push the new labels */
 		hdr = mpls_hdr(skb);
-		bos = dec.bos;
+		bos = dec->bos;
 		for (i = nh->nh_labels - 1; i >= 0; i--) {
 			hdr[i] = mpls_entry_encode(nh->nh_label[i],
-						   dec.ttl, 0, bos);
+						   dec->ttl, 0, bos);
 			bos = false;
 		}
 	}
@@ -477,6 +418,139 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	return NET_RX_DROP;
 }
 
+static int mpls_forward_p2mp(struct sk_buff *skb, struct mpls_dev *mdev,
+			     struct mpls_entry_decoded *dec,
+			     struct mpls_route *rt)
+{
+	unsigned int nh_flags;
+	int one_err;
+	int err = 0;
+	u8 alive;
+
+	if (rt->rt_nhn == 1)
+		goto out;
+
+	alive = READ_ONCE(rt->rt_nhn_alive);
+	if (alive == 0)
+		goto drop;
+
+	for_nexthops(rt) {
+		struct sk_buff *clone;
+
+		/* Skip the first next-hop for now and handle this one
+		 * on the way out to avoid one clone.
+		 */
+		if (nhsel == 0)
+			continue;
+
+		nh_flags = READ_ONCE(nh->nh_flags);
+		if (nh_flags & (RTNH_F_DEAD | RTNH_F_LINKDOWN))
+			continue;
+
+		clone = skb_clone(skb, GFP_ATOMIC);
+		if (!clone)
+			goto drop;
+
+		one_err = mpls_forward_finish(clone, mdev, dec, rt, nh);
+		if (one_err)
+			err = one_err;
+	}
+	endfor_nexthops(rt);
+
+out:
+	nh_flags = READ_ONCE(rt->rt_nh->nh_flags);
+	if (nh_flags & (RTNH_F_DEAD | RTNH_F_LINKDOWN)) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	one_err = mpls_forward_finish(skb, mdev, dec, rt, rt->rt_nh);
+	if (one_err)
+		err = one_err;
+	return err;
+drop:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
+			struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct net *net = dev_net(dev);
+	struct mpls_shim_hdr *hdr;
+	const struct mpls_nh *nh;
+	struct mpls_route *rt;
+	struct mpls_entry_decoded dec;
+	struct mpls_dev *mdev;
+
+	/* Careful this entire function runs inside of an rcu critical section */
+
+	mdev = mpls_dev_get(dev);
+	if (!mdev)
+		goto drop;
+
+	MPLS_INC_STATS_LEN(mdev, skb->len, rx_packets, rx_bytes);
+
+	if (!mdev->input_enabled) {
+		MPLS_INC_STATS(mdev, rx_dropped);
+		goto drop;
+	}
+
+	if (skb->pkt_type != PACKET_HOST)
+		goto err;
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto err;
+
+	if (!pskb_may_pull(skb, sizeof(*hdr)))
+		goto err;
+
+	skb_dst_drop(skb);
+
+	/* Read and decode the label */
+	hdr = mpls_hdr(skb);
+	dec = mpls_entry_decode(hdr);
+
+	rt = mpls_route_input_rcu(net, dec.label);
+	if (!rt) {
+		MPLS_INC_STATS(mdev, rx_noroute);
+		goto drop;
+	}
+
+	if (!(rt->rt_flags & MPLS_RT_F_P2MP)) {
+		nh = mpls_select_multipath(rt, skb);
+		if (!nh)
+			goto err;
+	}
+
+	/* Pop the label */
+	skb_pull(skb, sizeof(*hdr));
+	skb_reset_network_header(skb);
+
+	skb_orphan(skb);
+
+	if (skb_warn_if_lro(skb))
+		goto err;
+
+	skb_forward_csum(skb);
+
+	/* Verify ttl is valid */
+	if (dec.ttl <= 1)
+		goto err;
+
+	dec.ttl -= 1;
+	if (rt->rt_flags & MPLS_RT_F_P2MP)
+		return mpls_forward_p2mp(skb, mdev, &dec, rt);
+
+	return mpls_forward_finish(skb, mdev, &dec, rt, nh);
+err:
+	MPLS_INC_STATS(mdev, rx_errors);
+drop:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
 static struct packet_type mpls_packet_type __read_mostly = {
 	.type = cpu_to_be16(ETH_P_MPLS_UC),
 	.func = mpls_forward,
@@ -491,6 +565,7 @@ static const struct nla_policy rtm_mpls_policy[RTA_MAX+1] = {
 struct mpls_route_config {
 	u32			rc_protocol;
 	u32			rc_ifindex;
+	u8			rc_flags;
 	u8			rc_via_table;
 	u8			rc_via_alen;
 	u8			rc_via[MAX_VIA_ALEN];
@@ -1029,6 +1104,7 @@ static int mpls_route_add(struct mpls_route_config *cfg,
 	rt->rt_protocol = cfg->rc_protocol;
 	rt->rt_payload_type = cfg->rc_payload_type;
 	rt->rt_ttl_propagate = cfg->rc_ttl_propagate;
+	rt->rt_flags = cfg->rc_flags;
 
 	if (cfg->rc_mp)
 		err = mpls_nh_build_multi(cfg, rt, max_labels, extack);
@@ -1837,9 +1913,11 @@ static int rtm_to_route_config(struct sk_buff *skb,
 			       "Invalid route scope  - MPLS only supports UNIVERSE");
 		goto errout;
 	}
-	if (rtm->rtm_type != RTN_UNICAST) {
+	if (rtm->rtm_type == RTN_MULTICAST) {
+		cfg->rc_flags = MPLS_RT_F_P2MP;
+	} else if (rtm->rtm_type != RTN_UNICAST) {
 		NL_SET_ERR_MSG(extack,
-			       "Invalid route type - MPLS only supports UNICAST");
+			       "Invalid route type - MPLS only supports UNICAST and MULTICAST");
 		goto errout;
 	}
 	if (rtm->rtm_flags != 0) {
@@ -1988,7 +2066,7 @@ static int mpls_dump_route(struct sk_buff *skb, u32 portid, u32 seq, int event,
 	rtm->rtm_table = RT_TABLE_MAIN;
 	rtm->rtm_protocol = rt->rt_protocol;
 	rtm->rtm_scope = RT_SCOPE_UNIVERSE;
-	rtm->rtm_type = RTN_UNICAST;
+	rtm->rtm_type = rt->rt_flags & MPLS_RT_F_P2MP ? RTN_MULTICAST : RTN_UNICAST;
 	rtm->rtm_flags = 0;
 
 	if (nla_put_labels(skb, RTA_DST, 1, &label))
@@ -2386,7 +2464,7 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 		goto errout;
 	}
 
-	if (rtm->rtm_flags & RTM_F_FIB_MATCH) {
+	if (rtm->rtm_flags & RTM_F_FIB_MATCH || rt->rt_flags & MPLS_RT_F_P2MP) {
 		skb = nlmsg_new(lfib_nlmsg_size(rt), GFP_KERNEL);
 		if (!skb) {
 			err = -ENOBUFS;
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index b9f492ddf93b..585dd9ac1076 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -153,10 +153,14 @@ struct mpls_route { /* next hop label forwarding entry */
 	u8			rt_nhn_alive;
 	u8			rt_nh_size;
 	u8			rt_via_offset;
-	u8			rt_reserved1;
+	u8			rt_flags;
 	struct mpls_nh		rt_nh[];
 };
 
+/* rt_flags */
+#define MPLS_RT_F_P2MP                 0x01
+#define MPLS_RT_F_UPSTREAM_ASSIGNED    0x02 /* upstream assigned labels  - rfc5332 */
+
 #define for_nexthops(rt) {						\
 	int nhsel; const struct mpls_nh *nh;				\
 	for (nhsel = 0, nh = (rt)->rt_nh;				\
-- 
2.43.2


