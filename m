Return-Path: <netdev+bounces-176572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D560EA6AE2E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB434A35C1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7424227E99;
	Thu, 20 Mar 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToEbkYPY"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590D221573
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497477; cv=none; b=JSA/yNOKlKOcfz7i5asBzXgpEgZpApBaCK1OoIMFbr2Py04GSE8DlhD7Q31w4wTk/aq/wQbFZWM2E0x7XU78UfONp1ArVP/OtiDVVeww5DDciQTgR5zU7bd/oPvTWsawvQb26aXyCTStmPuHr2VEg2OZBMXpWuHpXQsJbn0HApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497477; c=relaxed/simple;
	bh=iG16bjxs7d6TyghUHZRRP9yXNf8yiCyLFEmfzoLFtSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3LqZ3rmZ9ZTYasFLadopeaD4Q4ISaXqA4qb4fKovE+oK+Vtn4V9jR7ZgICHKHdtHcgp5k88hX17HqAnmeWj/+rcDUQb5bQxCBX+Kkf4zA71QC7IEwjqWtYgu3e+8M3pfuRVGJQssDxSmN/PVwYlw7Z5b83/NXnAx/9anKf1WEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToEbkYPY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9523E138368E;
	Thu, 20 Mar 2025 15:04:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 15:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742497473; x=1742583873; bh=599oiV4CJAxx6GrSflMdnR1WZw8fqN1xMgu
	PBDmiax0=; b=ToEbkYPYYI20ERBS8rRV4zIjp3ytGJarp1FtmN6vi/aIU9J3tMA
	ZdbhKrFwjtMOeQUNRG2b0U8MvNr1iL/K2CLKvpBOw2wmlrQIUQ9MCeaRh41poqK/
	/FsNcGbnjK8BleJJzBAv+6I46WcYwTMb5i7iEAw6uL0aqgijfrFLclLBhZdpvrH8
	V5puAkK/cv1ntzWXfONfvBoRRQ5gfcz8uh2MS+0uiBJoNeaaZtsk3KpfPAL0a26h
	+Pp3qUz4yXLaBB3kZ8j/2z9nNGqZk8WEy6MpoKmZ4vKU76tDk30DTiQxo4GegpDb
	034MJ1tMWNt1pDd/JuRLVssQsOqmtpxKfXg==
X-ME-Sender: <xms:wGbcZ3jauPxFMtiOjAnOar5Amh7oYii2SCLF0CzqyyhBdC9Pf5kq2w>
    <xme:wGbcZ0Dxkm04iLxEk0h0R6q4214ti0NyYWb_sN6Kguo92toc6XuK6iO_kEiOAQrGj
    7NXiXEen0iMYV0>
X-ME-Received: <xmr:wGbcZ3GQsIqrpWEmmpXT_X3qLi5Uuu8AVcfxrdJcSLXTO3ZMo9UGvKHE3GBDYGcb19rw3HElmhDQ_IKbLkfF89SxadB5aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepieehffeivddtheejjeffkefftdeiheeujeev
    gfetieeugeekleelfefgleetudeinecuffhomhgrihhnpehlihhnuhigrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    nhgruhhlthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtfhhomhhitghhvghvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsg
    gvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wGbcZ0RyAhpimooa-dzzUtX6Wl-HxZCA1ZsBtIt-Z4FRvoPTrXWOGA>
    <xmx:wGbcZ0yDp9CE3Pl5KyxEIZC8nYRuaQ7ha0B-lSc1Ldd7rzT4X27PNw>
    <xmx:wGbcZ67LP8q3L-FVtspJi3eQwK_9Vd60S5vlUMWDM1DGp0BTcF8mIQ>
    <xmx:wGbcZ5yeLYndZQgI9KV6E1DdQR-F0MqdymlItiVUAwY_g0uvY_6aHw>
    <xmx:wWbcZ5qAZdhyCPLbBZv9raCZAn7mXq3mFYQo5lb9TUts1f2VqEW7PKQZ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 15:04:31 -0400 (EDT)
Date: Thu, 20 Mar 2025 21:04:29 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Simon Horman <horms@kernel.org>, gnault@redhat.com
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z9xmvRX_g_ZifayA@shredder>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
 <Z9SB87QzBbod1t7R@debian>
 <Z9SPDT9_M_nH9JiM@mini-arch>
 <Z9bNYPX165yxdoId@shredder>
 <Z9iP1anwinOHhjjm@debian>
 <20250320162646.GC892515@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320162646.GC892515@horms.kernel.org>

On Thu, Mar 20, 2025 at 04:26:46PM +0000, Simon Horman wrote:
> On Mon, Mar 17, 2025 at 10:10:45PM +0100, Guillaume Nault wrote:
> > On Sun, Mar 16, 2025 at 03:08:48PM +0200, Ido Schimmel wrote:
> > > On Fri, Mar 14, 2025 at 01:18:21PM -0700, Stanislav Fomichev wrote:
> > > > On 03/14, Guillaume Nault wrote:
> > > > > On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> > > > > > 
> > > > > > Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> > > > > > It seems like it started falling after this series has been pulled:
> > > > > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout
> > > > > 
> > > > > Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
> > > > > current net tree (I'm at commit 4003c9e78778). I have only one failure,
> > > > > but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
> > > > > address generation.") was applied.
> > > > 
> > > > On my side I see the following (ignore ping6 FAILs):
> > > > 
> > > > bfc6c67ec2d6 - (net-next/main, net-next/HEAD) net/smc: use the correct ndev to find pnetid by pnetid table (7 hours ago) <Guangguan Wang>
> > > > 
> > > > TAP version 13
> > > > 1..1
> > > > # timeout set to 0
> > > > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > > > [    9.275735][  T167] ip (167) used greatest stack depth: 23536 bytes left
> > > > [   13.769300][  T255] gre: GRE over IPv4 demultiplexor driver
> > > > [   13.838185][  T255] ip6_gre: GRE over IPv6 tunneling driver
> > > > [   13.951780][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > > > [   14.038101][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > > > [   15.148469][  T281] 8021q: 802.1Q VLAN Support v1.8
> > > > [   17.559477][  T321] GACT probability NOT on
> > > > [   18.551876][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > > > [   18.633656][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > > > # TEST: ping                                                          [ OK ]
> > > > # TEST: ping6                                                         [FAIL]
> > > > # INFO: Running IPv4 overlay custom multipath hash tests
> > > > # TEST: Multipath hash field: Inner source IP (balanced)              [FAIL]
> > > > #       Expected traffic to be balanced, but it is not
> > > > # INFO: Packets sent on path1 / path2: 1 / 12602
> > > > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > > > # INFO: Packets sent on path1 / path2: 0 / 12601
> > > > # TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
> > > > #       Expected traffic to be balanced, but it is not
> > > > # INFO: Packets sent on path1 / path2: 1 / 12600
> > > > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > > > # INFO: Packets sent on path1 / path2: 0 / 12600
> > > > ...
> > > > 
> > > > 8ecea691e844 - (HEAD -> upstream/net-next/main) Revert "gre: Fix IPv6 link-local address generation." (2 minutes ago) <Stanislav Fomichev>
> > > > 
> > > > TAP version 13
> > > > 1..1
> > > > # timeout set to 0
> > > > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > > > [   13.863060][  T252] gre: GRE over IPv4 demultiplexor driver
> > > > [   13.911551][  T252] ip6_gre: GRE over IPv6 tunneling driver
> > > > [   15.226124][  T277] 8021q: 802.1Q VLAN Support v1.8
> > > > [   17.629460][  T317] GACT probability NOT on
> > > > [   17.645781][  T315] tc (315) used greatest stack depth: 23040 bytes left
> > > > # TEST: ping                                                          [ OK ]
> > > > # TEST: ping6                                                         [FAIL]
> > > > # INFO: Running IPv4 overlay custom multipath hash tests
> > > > # TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
> > > > # INFO: Packets sent on path1 / path2: 5552 / 7052
> > > > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > > > # INFO: Packets sent on path1 / path2: 12600 / 2
> > > > [   36.278056][    C2] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1078005296 wd_nsec: 1078004682
> > > > # TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
> > > > # INFO: Packets sent on path1 / path2: 6650 / 5950
> > > > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > > > # INFO: Packets sent on path1 / path2: 0 / 12600
> > > > ...
> > > > 
> > > > And I also see the failures on 4003c9e78778. Not sure why we see
> > > > different results. And the NIPAs fails as well:
> > > > 
> > > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/32922/1-ip6gre-custom-multipath-hash-sh/stdout
> > > 
> > > I can reproduce this locally and I'm getting the exact same result as
> > > the CI. All the balanced tests fail because the traffic is forwarded via
> > > a single nexthop. No failures after reverting 183185a18ff9.
> > > 
> > > I'm still not sure what happens, but for some reason a neighbour is not
> > > created on one of the nexthop devices which causes rt6_check_neigh() to
> > > skip over this path (returning RT6_NUD_FAIL_DO_RR). Enabling
> > > CONFIG_IPV6_ROUTER_PREF fixes the issue because then RT6_NUD_SUCCEED is
> > > returned.
> > > 
> > > I can continue looking into this on Tuesday (mostly AFK tomorrow).
> > 
> > I finally managed to reproduce the problem using vng. Still no problem
> > on my regular VM, no matter if I enable CONFIG_IPV6_ROUTER_PREF or not.
> > I'll continue investigating this problem...
> 
> FWIIW, I have tried much, but am unable to _reliably_ reproduce this problem.

Sorry for the delay. Busy with other tasks at the moment, but I found
some time to look into this. I believe I understand the issue and have a
fix. Guillaume's patch is fine. It simply exposed a bug elsewhere.

The test is failing because all the packets are forwarded via a single
path instead of being load balanced between both paths.
fib6_select_path() chooses the path according to the hash-threshold
algorithm. If the function is called with the last nexthop in a
multipath route, it will always choose this nexthop because the
calculated hash will always be smaller than the upper bound of this
nexthop.

Fix is to find the first nexthop (sibling route) and choose the first
matching nexthop according to hash-threshold. Given Guillaume and you
can reproduce the issue, can you please test the fix [1]?

I think Guillaume's patch exposed the issue because it caused the ip6gre
device to transmit a packet (Router Solicitation as part of the DAD
process for the IPv6 link-local address) as soon as the device is
brought up. With debug kernels this might happen while forwarding is
still disabled as the test enables forwarding at the end of the setup.

When forwarding is disabled the nexthop's neighbour state is taken into
account when choosing a route in rt6_select() and round-robin will be
performed between the two sibling routes. It is possible to end up in a
situation where rt6_select() always returns the second sibling route
which fib6_select_path() will then always select due to its upper bound.

[1]
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fb2e99a56529..afcd66b73a92 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
 	return false;
 }
 
+static struct fib6_info *
+rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
+{
+	struct fib6_info *iter;
+	struct fib6_node *fn;
+
+	fn = rcu_dereference(rt->fib6_node);
+	if (!fn)
+		goto out;
+	iter = rcu_dereference(fn->leaf);
+	if (!iter)
+		goto out;
+
+	while (iter) {
+		if (iter->fib6_metric == rt->fib6_metric &&
+		    rt6_qualify_for_ecmp(iter))
+			return iter;
+		iter = rcu_dereference(iter->fib6_next);
+	}
+
+out:
+	return NULL;
+}
+
 void fib6_select_path(const struct net *net, struct fib6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *match = res->f6i;
+	struct fib6_info *first, *match = res->f6i;
 	struct fib6_info *sibling;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
@@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		return;
 	}
 
-	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
+	first = rt6_multipath_first_sibling_rcu(match);
+	if (!first)
 		goto out;
 
-	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
+	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+			    strict) >= 0) {
+		match = first;
+		goto out;
+	}
+
+	list_for_each_entry_rcu(sibling, &first->fib6_siblings,
 				fib6_siblings) {
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;

