Return-Path: <netdev+bounces-143585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A127D9C3226
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52617280FC3
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F5DDAB;
	Sun, 10 Nov 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kM3tardL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9ACC13C
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245248; cv=none; b=i22YEjaf+y1/HTC504mAghvsRF/TvQlGkJWAT4hONZ9NHv09KADy1aIaXQ+23QYLkCBGTbOsDPPhGwvnVBTQ87XnrJKKpAkvfiItwidMCq85xApZnjSBJR0gefqutyL81ZwJLiZW0UyHbwIY4BVgVUOOvyP/5ki40290vfRG9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245248; c=relaxed/simple;
	bh=1KOQt8DB0idz97+9Um3VLEJ4gYPNrIIAcQrNlKJQs7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADh4DoT9tGasggODHMCDyKJ4uryU2r4fTxyXOAdQKG5GNDsMSFLTUZEm4RzD6I+4MB8fbmmsV2BDT31OB+RrdFCtXeASRnBM3/qtNWUyCbWU2chmqmTFc2MemMGrOcrlsXX8FjHZxgO2WdbEu7fGJ35AKe8v8KB1PiWZmIYhTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kM3tardL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A35ED25400D0;
	Sun, 10 Nov 2024 08:27:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 10 Nov 2024 08:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731245244; x=
	1731331644; bh=6ldWSvwi2ZEj3exHfZGcz6/xnWszJz9/l1UTaJ8RI0I=; b=k
	M3tardLz6T89RRvtfm48xdLl4HqGU+yJoUN0fKfBnPN1y9Of76eAqnb3R2N6SMH3
	F7I/MJduKx4dV3LwS+PAjNqKA7sOftmFyxZuaZNZqQ4zu4xGp9jQ/09h4lkbtWYK
	f3ABWaSEtQRBFW9EpkwiamCsNNxvuzs09qFCWVNR6jF6hgU/uHcft/GHVrTqM6ho
	0GtHrVmXWBdqr4QisZ9TMuKIJ8lh0flroOJK+7slY/j3f48gm8iFCpBXHucKeZK1
	KBWWz/lqQD+4sDIG/sBYy5lhT7/Psm9viDq/+UU5NqAky+SmUKGrb6rdrrFaiVGV
	KI/T9M9DL4UBKtY4RTtZA==
X-ME-Sender: <xms:u7QwZ00eGItvfEansqUjZM05Xf7loaz92dZxurSDgN0f4BflqDqlXw>
    <xme:u7QwZ_EwcOGAYGeCmGaQsYSBObtc4IjqkEu_oWKjROkKaEPX8SUPgukPY7UCtn2-N
    j0RJ8H1cAGjtMQ>
X-ME-Received: <xmr:u7QwZ860SdzPZzcYiInsBIgTl68V4Yc1j5QMCbekl-hN1k1MrX6JPBb4ed2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepgeehkeduvdeujedvtddvgfdtvdfgvedukedttdet
    veduvdekteevfedtveeujeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlvghmuggvsghruh
    hijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehfvghjvghssehi
    nhhfrdgvlhhtvgdrhhhupdhrtghpthhtoheprghnnhgrvghmvghsvghnhihirhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvggu
    hhgrthdrtghomh
X-ME-Proxy: <xmx:u7QwZ917npo9MaXS5Xb-83mmCPpzxHHyPORf4vrH958gs4e9eOvn9A>
    <xmx:u7QwZ3EPw0rfYZqdsObl4qkfBeP0RAx9Tk2tIwDrjCgtLmUvV8Zd5w>
    <xmx:u7QwZ2-1_8-5ciJ7Yd3dqywUS6AoQ5vgMVtWEImv-5k69s_TUYFATQ>
    <xmx:u7QwZ8mL00M6MFLf581aJAyv4wl8Kzyo93kQ4ZRga6hj4ocM83DnMQ>
    <xmx:vLQwZ86wrcczA_xGhjSWdFelM1zWcppWWiFDzOrItxLMkC2kMshXQ4bm>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 08:27:23 -0500 (EST)
Date: Sun, 10 Nov 2024 15:27:21 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Ferenc Fejes <fejes@inf.elte.hu>,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>, netdev@vger.kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 3/3] selftest: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Message-ID: <ZzC0uV1RqEnpAkwf@shredder>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
 <20241107132231.9271-4-annaemesenyiri@gmail.com>
 <672cf752e2014_1f26762945a@willemb.c.googlers.com.notmuch>
 <672e246394d26_2a4cd22945d@willemb.c.googlers.com.notmuch>
 <00df52aa503fdc1a795ec1574ef9a17f2475230c.camel@inf.elte.hu>
 <672fbe6d15101_37aab4294b8@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672fbe6d15101_37aab4294b8@willemb.c.googlers.com.notmuch>

On Sat, Nov 09, 2024 at 02:56:29PM -0500, Willem de Bruijn wrote:
> Ferenc Fejes wrote:
> > On Fri, 2024-11-08 at 09:46 -0500, Willem de Bruijn wrote:
> > > Willem de Bruijn wrote:
> > > > Anna Emese Nyiri wrote:
> > > > > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > > > > ancillary data.
> > > > > 
> > > > > Add the `cmsg_so_priority.sh` script, which sets up two network  
> > > > > namespaces (red and green) and uses the `cmsg_sender.c` program
> > > > > to  
> > > > > send messages between them. The script sets packet priorities
> > > > > both  
> > > > > via `setsockopt` and control messages (cmsg) and verifies
> > > > > whether  
> > > > > packets are routed to the same queue based on priority settings.
> > > > 
> > > > qdisc. queue is a more generic term, generally referring to hw
> > > > queues.
> > > >  
> > > > > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > > > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > > > ---
> > > > >  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
> > > > >  .../testing/selftests/net/cmsg_so_priority.sh | 115
> > > > > ++++++++++++++++++
> > > > >  2 files changed, 125 insertions(+), 1 deletion(-)
> > > > >  create mode 100755
> > > > > tools/testing/selftests/net/cmsg_so_priority.sh
> > > >  
> > > > > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > > b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > > new file mode 100755
> > > > > index 000000000000..706d29b251e9
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > > @@ -0,0 +1,115 @@
> > > > > +#!/bin/bash
> > > > 
> > > > SPDX header
> > > > 
> > > > > +
> > > > > +source lib.sh
> > > > > +
> > > > > +IP4=192.168.0.2/16
> > > > > +TGT4=192.168.0.3/16
> > > > > +TGT4_NO_MASK=192.168.0.3
> > > > > +IP6=2001:db8::2/64
> > > > > +TGT6=2001:db8::3/64
> > > > > +TGT6_NO_MASK=2001:db8::3
> > > > > +IP4BR=192.168.0.1/16
> > > > > +IP6BR=2001:db8::1/64
> > > > > +PORT=8080
> > > > > +DELAY=400000
> > > > > +QUEUE_NUM=4
> > > > > +
> > > > > +
> > > > > +cleanup() {
> > > > > +    ip netns del red 2>/dev/null
> > > > > +    ip netns del green 2>/dev/null
> > > > > +    ip link del br0 2>/dev/null
> > > > > +    ip link del vethcab0 2>/dev/null
> > > > > +    ip link del vethcab1 2>/dev/null
> > > > > +}
> > > > > +
> > > > > +trap cleanup EXIT
> > > > > +
> > > > > +priority_values=($(seq 0 $((QUEUE_NUM - 1))))
> > > > > +
> > > > > +queue_config=""
> > > > > +for ((i=0; i<$QUEUE_NUM; i++)); do
> > > > > +    queue_config+=" 1@$i"
> > > > > +done
> > > > > +
> > > > > +map_config=$(seq 0 $((QUEUE_NUM - 1)) | tr '\n' ' ')
> > > > > +
> > > > > +ip netns add red
> > > > > +ip netns add green
> > > > > +ip link add br0 type bridge
> > > > > +ip link set br0 up
> > > > 
> > > > Is this bridge needed? Can this just use a veth pair as is.
> > > > 
> > > > More importantly, it would be great if we can deduplicate this kind
> > > > of
> > > > setup boilerplate across similar tests as much as possible.
> > > 
> > > As a matter of fact, similar to cmsg_so_mark, this test can probably
> > > use a dummy netdevice, no need for a second namespace and dev.
> > > 
> > > cmsg_so_mark.sh is probably small enough that it is fine to copy that
> > > and create a duplicate. As trying to extend it to cover both tests
> > > will probably double it in size and will just be harder to follow.
> > 
> > I'm afraid we don't have "ip rule" match argument for skb->priority
> > like we have for skb->mark (ip rule fwmark). AFAIU cmsg_so_mark.sh uses
> > rule matches to confirm if skb->mark is correct or not.
> > 
> > Using nftables meta priority would work with a dummy device:
> > add table so_prio
> > add chain so_prio so_prio_chain { type filter hook output priority 0; }
> > add rule so_prio so_prio_chain meta priority $SOPRIOVALUE counter
> > 
> > Is there anything simpler? I am afraid we cannot use nftables in
> > selftests, or can we? Thanks!
> 
> I'd use traffic shaper (tc). There are a variety of qdiscs/schedulers
> and classifiers that act on skb->priority.

When I initially suggested the test I was thinking about creating a VLAN
device with egress QoS map and then matching on VLAN priority with
flower. Something like [1]. It is just a quick hack. Proper test should
test with all combinations of IPv4 / IPv6 / UDP / ICMP / RAW / cmsg /
sockopt (like cmsg_so_mark.sh).

[1]
#!/bin/bash

ip netns del ns1 &> /dev/null
ip netns add ns1

ip -n ns1 link set dev lo up
ip -n ns1 link add name dummy1 up type dummy

ip -n ns1 link add link dummy1 name dummy1.10 up type vlan id 10 \
	egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
ip -n ns1 address add 192.0.2.1/24 dev dummy1.10
ip -n ns1 neigh add 192.0.2.2 lladdr 00:11:22:33:44:55 nud permanent dev \
	dummy1.10

tc -n ns1 qdisc add dev dummy1 clsact
for i in {0..7}; do
	tc -n ns1 filter add dev dummy1 egress pref 1 handle 10${i} \
		proto 802.1q flower vlan_prio $i vlan_ethtype ipv4 \
		ip_proto udp dst_ip 192.0.2.2 action drop
done

for i in {0..7}; do
	pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
		| jq ".[] | select(.options.handle == 10$i) | \
		.options.actions[0].stats.packets")
	[[ $pkts == 0 ]] || echo "prio $i: expected 0, got $pkts"

	ip netns exec ns1 ./cmsg_sender -4 -p udp -P $i 192.0.2.2 1234

	pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
		| jq ".[] | select(.options.handle == 10$i) | \
		.options.actions[0].stats.packets")
	[[ $pkts == 1 ]] || echo "prio $i: expected 1, got $pkts"
done

