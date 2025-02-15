Return-Path: <netdev+bounces-166719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBDAA370B5
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 21:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FDB18914DA
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B91A5BAE;
	Sat, 15 Feb 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVogE9UE"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D01A262D
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739652474; cv=none; b=el9+kwUB0T3kki7ZkSGejpCfRKjlep54rdOTeVW8whr9BB5/wxA3yS4wtpDbd9TvekASQhibUvjZQBd6FlPOJg6WTX3y3epiqjBFWwKIYqU3XzLvfIfy+lqAq1BFPrIibY+rhMakdL3UGFl8t/7+ibdVAJ0YeHqRpOSZ6YYxky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739652474; c=relaxed/simple;
	bh=VCol4brRo4NGPxg6a3Ahmke1QLEfJie0WFUgatCCnHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THuKEY/95/0Xud1X6oCBzNE6NQ5vMqVIBDbl4Idk7+oTc+8LyxEyHgJZhRSGDNvu5tgtKf57CKYGFCEP+vj7p9BXtT/WrTNyGPY97duBvOtA7AcJca5GcsIkJY16NxJSSjsXJcVVYtt90tQwPib6VVlzsl4t59ZL9yIPgd+HrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVogE9UE; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B2D81140127;
	Sat, 15 Feb 2025 15:47:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 15 Feb 2025 15:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739652470; x=1739738870; bh=WyWYXNpS9jM2I4J3xTo77GEC6Dq/7aUp+8r
	wtJDeJOA=; b=qVogE9UEYX+kjnzTrMcHCCstwIVUJ5u8khG5pf1WcA7R9vWvG/E
	/ZtA1drPoCXLFlKIuk6idVmEAh16DudtNgI35HMZUdfs9atYx3Srde2dCgiAtOoe
	6MZLRmMcsQxCfVAGGBhTILw4OxsF42fhx5AmimwMN4qYtlQo9f4xM4peqXtrIcOf
	IgPRH8Z92PIc+Z0WtNJeGQNSBzTwJJwnc9w0ZV/N0fo5Z8kmnCinjymY3xJm8L0M
	VIeUFX7qF2NCO3oRE3vga7Nk4Gv3mIr71nhXklKyyVCWR+Qz8IzqKyE8Bko7UJ98
	xf4ykZDSIYfEQsB3sthsbhYNphiNxDHdORw==
X-ME-Sender: <xms:df2wZ3R_IySn2qaeJRR_HB0S-3KRwP5buw-GFe9OAxUmZVt4vn_c9g>
    <xme:df2wZ4yYhabmYKnKsVK3RnObl7IsbXpkBywbHEIeKdangZbjr9h62H94OL1xZPHtm
    1LHgCAdTSjQ7kY>
X-ME-Received: <xmr:df2wZ80TYO6Gspn9R9NTdX6w_sNF5at21r60fytKhnRn1dJoMf6DruvQ4QKTEuk7iB4ofqM2zrdpI1lQwaiYF0YDJYcP5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehfeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeevieefveefffeltdeuheduvedtgeetudetfeef
    ueehteeltdfggfekvddtgfetieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhtrg
    hlohhsrdguvghvpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhh
    vghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehluhgtihgvnh
    drgihinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfhhmvghisehsfhhsrdgtohhm
X-ME-Proxy: <xmx:df2wZ3AIkhwH3Lk2qN_CvQCfRY_HjqXRxJM1uvMXBzb9o69AcmDyqw>
    <xmx:df2wZwj8RYFbCJ4F-YPUzhCywEzECpFTDlhswz5cCePJn3lf-NBZ3Q>
    <xmx:df2wZ7obgrPds8Iq44EXbtCenZZGcHqqHfUNKNv90ywqEScFptpfaQ>
    <xmx:df2wZ7h7ZKG_8xkQ-ZTmgq8syb02xb-O1WRjOwRF1FU_bVFFh-2FDw>
    <xmx:dv2wZ4fJVLXJLceJEBA35vgqd0Fq3Uva1msr0QkpK4d1jDnhNMBzTUQK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Feb 2025 15:47:49 -0500 (EST)
Date: Sat, 15 Feb 2025 22:47:45 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Stephen Hemminger <stephen@networkplumber.org>, lucien.xin@gmail.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org, fmei@sfs.com
Subject: Re: Fw: [Bug 219766] New: Garbage Ethernet Frames
Message-ID: <Z7D9cR22BDPN7WSJ@shredder>
References: <20250210084931.23a5c2e4@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210084931.23a5c2e4@hermes.local>

On Mon, Feb 10, 2025 at 08:49:31AM -0800, Stephen Hemminger wrote:
> Not really enough information to do any deep analysis but forwarding to netdev
> anyway as it is not junk.
> 
> Begin forwarded message:
> 
> Date: Sun, 09 Feb 2025 12:24:32 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 219766] New: Garbage Ethernet Frames
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219766
> 
>             Bug ID: 219766
>            Summary: Garbage Ethernet Frames
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: fmei@sfs.com
>         Regression: No
> 
> I am currently troubleshooting a very strange problem which appears when
> upgrading Kernel 6.6.58 to 6.6.60. The kernel version change is part of a
> change of talos linux (www.talos.dev) from 1.8.2 to 1.8.3.
> 
> We are running this machines at hetzner - a company which is providing server
> hosting. they complain that we are using mac addresses which are not allowed
> (are not the mac addresses of the physical nic)
> 
> In the investigation of the problem I did tcpdumps on the physical adapters and
> captured this suspicious ethernet frames. The frames do neither have a known
> ethertype, nor do they have a mac address of a known vendor or a known virtual
> mac address range. They seem garbage to me. Below an example. More can be found
> in the github issue. This frames are not emitted very often and the systems are
> operating normally. If I would not be informed by the hosting provider I would
> not have noticed it at all.
> 
> I also tried to track it down to a specific hardware (r8169), but we have the
> same problem with e1000e.
> 
> I checked the changelogs of the two kernel versions (6.6.59 & 6.6.60) and
> noticed there were some changes which could be the problem, but I simply do not
> have the experience for it.
> 
> Can anybody check the changelog of the 2 versions and see if there is a change
> which might cause the problem? Can anybody give me a hint how to track it down
> further?
> 
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on enp9s0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 22:07:02.329668 20:00:40:11:18:fb > 45:00:00:44:f4:94, ethertype Unknown
> (0x58c6), length 68:
>         0x0000:  8dda 74ca f1ae ca6c ca6c 0098 969c 0400  ..t....l.l......
>         0x0010:  0000 4730 3f18 6800 0000 0000 0000 9971  ..G0?.h........q
>         0x0020:  c4c9 9055 a157 0a70 9ead bf83 38ca ab38  ...U.W.p....8..8
>         0x0030:  8add ab96 e052                           .....R
> 
> 
> Issue with more information: https://github.com/siderolabs/talos/issues/9837

Adding Xin and Eric as I believe this is caused by commit 22600596b675
("ipv4: give an IPv4 dev to blackhole_netdev"). It's present in v6.6.59,
but not in v6.6.58 which fits the report.

The Ethernet headers of all the captured packets start with 0x45, so
it's quite apparent that these are IPv4 packets that are transmitted
without an Ethernet header. Specifically, these seem to be UDP packets
(10th byte is always 0x11).

After 22600596b675 neighbours can be constructed on the blackhole device
and they are constructed with an output function (neigh_direct_output())
that simply calls dev_queue_xmit(). The latter will transmit packets via
skb->dev which might not be the blackhole device if dst_dev_put()
switched dst->dev to the blackhole device when another CPU was using
this dst entry in ip_output().

I verified this using these hackish scripts [1][2]. They create a
nexthop exception where a dst entry is cached. Two UDP applications use
this dst entry, but a background process continuously bumps the IPv4
generation ID so as to force these applications to perform a route
lookup instead of using the dst entry that they previously resolved.

After creating a new dst entry, one application will try to cache it in
the nexthop exception by calling rt_bind_exception() which will call
dst_dev_put() on the previously cached dst entry that might still be
used by the other application on a different CPU.

There's a counter at the end of the test that counts the number of
packets that were transmitted without an Ethernet header. The problem
does not reproduce with 22600596b675 reverted.

One possible solution is to add the dst entry to the uncached list by
converting dst_dev_put() to rt_add_uncached_list() [3]. The dst entry
will be eventually removed from this list when the dst entry is
destroyed or when dst->dev is unregistered. However, I am not sure it
will solve this report as rt_bind_exception() is not the only caller of
dst_dev_put().

Another possible solution is to have the blackhole device consume the
packets instead of letting them go out without an Ethernet header [4].
Doesn't seem great as the packets disappear without telling anyone
(before 22600596b675 an error was returned).

Let me know what you think. Especially if you have a better fix.

Thanks

[1]
#!/bin/bash
# blackhole.sh

for ns in client router server; do
	ip netns add $ns
	ip -n $ns link set dev lo up
done

ip -n client link add name veth0 type veth peer name veth1 netns router
ip -n router link add name veth2 type veth peer name veth3 netns server

# Client
ip -n client link set dev veth0 up
ip -n client address add 192.0.2.1/28 dev veth0
ip -n client route add default via 192.0.2.2
tc -n client qdisc add dev veth0 clsact
tc -n client filter add dev veth0 egress pref 1 proto all \
	flower dst_mac 45:00:00:00:00:00/ff:ff:00:00:00:00 action pass

# Router
ip netns exec router sysctl -wq net.ipv4.conf.all.forwarding=1
ip -n router link set dev veth1 up
ip -n router address add 192.0.2.2/28 dev veth1
ip -n router link set dev veth2 up mtu 1300
ip -n router address add 192.0.2.17/28 dev veth2

# Server
ip -n server link set dev veth3 up mtu 1300
ip -n server address add 192.0.2.18/28 dev veth3
ip -n server route add default via 192.0.2.17

sleep 1

# Create a nexthop exception where the dst entry will be cached.
ip netns exec client ping 192.0.2.18 -c 1 -M want -s 1400 -q &> /dev/null

# Continuously invalidate cached dst entries by bumping the IPv4 generation ID.
# When replacing the cached dst entry in the nexthop exception,
# rt_bind_exception() will call dst_dev_put(), thereby setting the dst entry's
# device to the blackhole device.
./bump_genid.sh &

ip netns exec server iperf3 -s -p 6000 -D
ip netns exec server iperf3 -s -p 7000 -D
ip netns exec client iperf3 -c 192.0.2.18 -p 6000 -u -b 0 -t 60 &> /dev/null &
ip netns exec client iperf3 -c 192.0.2.18 -p 7000 -u -b 0 -t 60 &> /dev/null

tc -n client -s filter show dev veth0 egress

ip netns pids server | xargs kill
pkill bump_genid.sh
ip -all netns delete

[2]
#!/bin/bash
# bump_genid.sh

while true; do
	ip -n client route add 198.51.100.1/32 dev lo
	ip -n client route del 198.51.100.1/32 dev lo
done

[3]
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c..f40f860c0bec 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1461,7 +1461,7 @@ static bool rt_bind_exception(struct rtable *rt, struct fib_nh_exception *fnhe,
 			dst_hold(&rt->dst);
 			rcu_assign_pointer(*porig, rt);
 			if (orig) {
-				dst_dev_put(&orig->dst);
+				rt_add_uncached_list(orig);
 				dst_release(&orig->dst);
 			}
 			ret = true;

[4]
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index c8840c3b9a1b..448f352c3c92 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -244,8 +244,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int blackhole_neigh_output(struct neighbour *n, struct sk_buff * skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int blackhole_neigh_construct(struct net_device *dev,
+				     struct neighbour *n)
+{
+	n->output = blackhole_neigh_output;
+	return 0;
+}
+
 static const struct net_device_ops blackhole_netdev_ops = {
 	.ndo_start_xmit = blackhole_netdev_xmit,
+	.ndo_neigh_construct = blackhole_neigh_construct,
 };
 
 /* This is a dst-dummy device used specifically for invalidated

