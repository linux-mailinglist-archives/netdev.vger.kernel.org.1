Return-Path: <netdev+bounces-190935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED2AB95B1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3334A1BA818C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60C221289;
	Fri, 16 May 2025 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="eM8nyuoI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJe2XtV1"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACC221FC9
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374809; cv=none; b=lLoku78IySa2i3xgZiyG4DbGVp1yf7yICMEObGcJEd0B1En5RdaWboH6i2kj910ygg7NphlwRLufhwy1/ApKyhD2cscQ8nybfthQMupYGUBt3uC2Djf1dXBX/4n+NaGOatiL4irsVswDDnc2OH5r/ZidAQRhZKnLAzyyCMwPSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374809; c=relaxed/simple;
	bh=nDEsPxDCB7LvXxWFv7lx8BFA6tnwGVFDadrigShWAmg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=fchlQLKJv32ZsYf7HpmRbkBGwINnBzuseZyVgYZ/T8wClg1pVlKiN0LY1CiiSXQMbGGf4LIY9Go1R7qwA7JJU7ibyv0VoxE61FXDxqYJorXpxuZ4eZk4txC8p6gMZkuY8z/DvMeev3PtDTdGwKwuI7hnhhPyZ/Jf4VXH8GmSAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=eM8nyuoI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJe2XtV1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 03684138024D;
	Fri, 16 May 2025 01:53:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 16 May 2025 01:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1747374804; x=1747461204; bh=Ez5qcdcoht0ZeWMNoleYKbTLwe505YxO
	GRwpw3ICVIs=; b=eM8nyuoIhoStYN04APxjz3sSRRwIcZth8iAqLdR5UK2SDlcs
	JjoQJT1FVvqpJO/fnHY7yx/uTArHaEIO7gMYwJV9UryDDZhZRsoCVOzQG3/MapLg
	Ol/OSAKJ8ok2QDdxGw6cxR6xs5PCuvMTwjuuvnLW5tGpDlQdua3ztLf/7B7lk/Ku
	XMhDix2HNXrnaaym9c+MxYIX2y5C+n17JwaYJ6LRZAHx9zCtRwJ2BlE3ePN5jmsH
	sufUXYiOOhNTxYlg1DLLz+QtwXkEIbAbcNAaehxbC3I1N4YnoH1/UazkUDs8o7Gx
	VjOLcwG1gnsF6tjPV/l28zKthKC+5J9Re69g7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747374804; x=
	1747461204; bh=Ez5qcdcoht0ZeWMNoleYKbTLwe505YxOGRwpw3ICVIs=; b=S
	Je2XtV1MsSYD5UraIbDXyYXro2q1yh+wEe4NzD/gbHIVYtz9cFbNWcxwTvFqH7mA
	/9ayVvFTe4fGtsztQFTY4+YzWWplHpeXvS2MnBroJyyI7NdYfu8dDQPGejmvI/ag
	uyyNPJqvBtqCqX5kimXkUbO+EoPCHjqo4oEZb1DHNgXCjHvDUdpKpKEHeBwB29zJ
	kDNvfJ44dMnbY9oo/dwmcP9jnrFwFumMc9dXdJh0ILtV2qTrIkRY1O7lv7FLEG7b
	8/fSlVhP52h4lGCWZj+29h9R+WX1GlFnGBhjRnhHA3ZYlOwPQ6nnRtXFLVpUCJPI
	G2OeNvLdHxDzTTVdbBo+Q==
X-ME-Sender: <xms:09ImaFU-C4UIcRvtdshD5Cu-QaFJOgCzvEOpgIoIvRwGCpCq5AFqWA>
    <xme:09ImaFkEHDTG2y61abtlDcMOzB-SctnBLAPXCqiprHUiCAYxPFUkYBxbXkuCtNxTc
    0gpQszmezb42ne4AY4>
X-ME-Received: <xmr:09ImaBYoQoN9TsGdWAA2FMn-ikXT8D1xElonU6Aqp03s78H6UXyMSZ5-fXI7WU6pPF9obymc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tdejnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhephfdvlefftdegvdehgfdtveekfedviedvhfet
    hfdtleejheeileegffekffffgedunecuffhomhgrihhnpehruhhijhhivgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhv
    ohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepthhuii
    gvnhhgsghinhhgseguihguihhglhhosggrlhdrtghomhdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    nhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheptghorhgsvghtse
    hlfihnrdhnvghtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:09ImaIVBWqCUBUuwgQIfn4FJZYbeakxYBHImYtEeJJySeAUN1b0AAQ>
    <xmx:09ImaPknK1aQrrDQwCBjNzGR-n4Igvzgz1o6Fxnnzsfg-mFTgrIiow>
    <xmx:09ImaFdXvL50GG2ZM2fhAaOgi1nDOj_HJzxRx_y84YgeojQTyEoIWA>
    <xmx:09ImaJHretUtozuClOv5AxPrb-Bf8lq2ge78eNKShQZWH6JepJfPoA>
    <xmx:1NImaO4weH5sBAbVbN3KWiVWEFl6loKahLQtL6SvJsvhPcQ2ZohYMilc>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 01:53:23 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 787941C03B4; Fri, 16 May 2025 07:53:21 +0200 (CEST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 77AB21C0127;
	Fri, 16 May 2025 07:53:21 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next v3 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
In-reply-to: <5A473EF9-677F-4DE5-AA92-E4EBA8C09946@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com> <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com> <1338977.1747215491@vermin> <5A473EF9-677F-4DE5-AA92-E4EBA8C09946@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Fri, 16 May 2025 12:19:52 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 May 2025 07:53:21 +0200
Message-ID: <52315.1747374801@vermin>


Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>> 2025=E5=B9=B45=E6=9C=8814=E6=97=A5 17:38=EF=BC=8CJay Vosburgh <jv@jvosbu=
rgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>=20
>>> Stacking technology is a type of technology used to expand ports on
>>> Ethernet switches. It is widely used as a common access method in
>>> large-scale Internet data center architectures. Years of practice
>>> have proved that stacking technology has advantages and disadvantages
>>> in high-reliability network architecture scenarios. For instance,
>>> in stacking networking arch, conventional switch system upgrades
>>> require multiple stacked devices to restart at the same time.
>>> Therefore, it is inevitable that the business will be interrupted
>>> for a while. It is for this reason that "no-stacking" in data centers
>>> has become a trend. Additionally, when the stacking link connecting
>>> the switches fails or is abnormal, the stack will split. Although it is
>>> not common, it still happens in actual operation. The problem is that
>>> after the split, it is equivalent to two switches with the same configu=
ration
>>> appearing in the network, causing network configuration conflicts and
>>> ultimately interrupting the services carried by the stacking system.
>>>=20
>>> To improve network stability, "non-stacking" solutions have been increa=
singly
>>> adopted, particularly by public cloud providers and tech companies
>>> like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing=
 switch
>>> stacking that convinces a LACP peer, bonding in this case, connected to=
 a set of
>>> "non-stacked" switches that all of its ports are connected to a single
>>> switch (i.e., LACP aggregator), as if those switches were stacked. This
>>> enables the LACP peer's ports to aggregate together, and requires (a)
>>> special switch configuration, described in the linked article, and (b)
>>> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
>>> packets across all ports of the active aggregator.
>>=20
>> Please reformat the above to wrap at 75 columns, otherwise the
>> text in "git log" will wrap 80 columns (because git log indents the log
>> message).
>Ok, I will format every commit log of patch.
>>=20
>>> -----------     -----------
>>> |  switch1  |   |  switch2  |
>>> -----------     -----------
>>>        ^           ^
>>>        |           |
>>>      -----------------
>>>     |   bond4 lacp    |
>>>      -----------------
>>>        |           |
>>>        | NIC1      | NIC2
>>>      -----------------
>>>     |     server      |
>>>      -----------------
>>>=20
>>> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-cente=
r-network-architecture/
>>>=20
>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Simon Horman <horms@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>> ---
>>> Documentation/networking/bonding.rst |  6 ++++
>>> drivers/net/bonding/bond_main.c      | 41 ++++++++++++++++++++++++++++
>>> drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++
>>> include/net/bond_options.h           |  1 +
>>> include/net/bonding.h                |  3 ++
>>> 5 files changed, 86 insertions(+)
>>>=20
>>> diff --git a/Documentation/networking/bonding.rst b/Documentation/netwo=
rking/bonding.rst
>>> index a4c1291d2561..14f7593d888d 100644
>>> --- a/Documentation/networking/bonding.rst
>>> +++ b/Documentation/networking/bonding.rst
>>> @@ -562,6 +562,12 @@ lacp_rate
>>>=20
>>> The default is slow.
>>>=20
>>> +broadcast_neighbor
>>> +
>>> + Option specifying whether to broadcast ARP/ND packets to all
>>> + active slaves.  This option has no effect in modes other than
>>> + 802.3ad mode.  The default is off (0).
>>> +
>>> max_bonds
>>>=20
>>> Specifies the number of bonding devices to create for this
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>>> index d05226484c64..db6a9c8db47c 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -212,6 +212,8 @@ atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
>>>=20
>>> unsigned int bond_net_id __read_mostly;
>>>=20
>>> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>> +
>>> static const struct flow_dissector_key flow_keys_bonding_keys[] =3D {
>>> {
>>> .key_id =3D FLOW_DISSECTOR_KEY_CONTROL,
>>> @@ -4461,6 +4463,9 @@ static int bond_open(struct net_device *bond_dev)
>>>=20
>>> bond_for_each_slave(bond, slave, iter)
>>> dev_mc_add(slave->dev, lacpdu_mcast_addr);
>>> +
>>> + if (bond->params.broadcast_neighbor)
>>> + static_branch_inc(&bond_bcast_neigh_enabled);
>>> }
>>>=20
>>> if (bond_mode_can_use_xmit_hash(bond))
>>> @@ -4480,6 +4485,9 @@ static int bond_close(struct net_device *bond_dev)
>>> bond_alb_deinitialize(bond);
>>> bond->recv_probe =3D NULL;
>>>=20
>>> + if (bond->params.broadcast_neighbor)
>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>> +
>>> if (bond_uses_primary(bond)) {
>>> rcu_read_lock();
>>> slave =3D rcu_dereference(bond->curr_active_slave);
>>> @@ -5316,6 +5324,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave=
_get(struct bonding *bond,
>>> return slaves->arr[hash % count];
>>> }
>>>=20
>>> +static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>>> +    struct net_device *dev)
>>> +{
>>> + struct bonding *bond =3D netdev_priv(dev);
>>> +
>>> + if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>>> + return false;
>>> +
>>> + if (!bond->params.broadcast_neighbor)
>>> + return false;
>>> +
>>> + if (skb->protocol =3D=3D htons(ETH_P_ARP))
>>> + return true;
>>> +
>>> + if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>>> +     pskb_may_pull(skb,
>>> +   sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
>>> + if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>>> + struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>>> +
>>> + if ((icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION) ||
>>> +     (icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>>> + return true;
>>> + }
>>> + }
>>=20
>> I'd recommend you look at bond_na_rcv() and mimic its logic for
>> inspecting the ipv6 and icmp6 headers by using skb_header_pointer()
>> instead of pskb_may_pull().  The skb_header_pointer() function does not
>> alter the skb (it will not move data into the skb linear area), and
>> would have lower cost for this use case.  With broadcast_neighbor
>> enabled, every IPv6 packet will pass through this test, so minimizing
>> its cost should be of benefit.
>Ok
>>=20
>>> +
>>> + return false;
>>> +}
>>> +
>>> /* Use this Xmit function for 3AD as well as XOR modes. The current
>>> * usable slave array is formed in the control path. The xmit function
>>> * just calculates hash and sends the packet out.
>>> @@ -5583,6 +5620,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_bu=
ff *skb, struct net_device *dev
>>> case BOND_MODE_ACTIVEBACKUP:
>>> return bond_xmit_activebackup(skb, dev);
>>> case BOND_MODE_8023AD:
>>> + if (bond_should_broadcast_neighbor(skb, dev))
>>> + return bond_xmit_broadcast(skb, dev);
>>=20
>> One question that just occured to me... is bond_xmit_broadcast()
>> actually the correct logic?  It will send the skb to every interface
>> that is a member of the bond, but for the "non stacked" case, I believe
>> the correct logic is to send only to interfaces that are part of the
>> active aggregator.
>>=20
>> Stated another way, with broadcast_neighbor enabled, if the bond
>> has interfaces not part of the active aggregator (perhaps a switch port
>> or entire switch not correctly configured for "non stacked" operation),
>> the ARP / NS / NA packet has the potential to update neighbor tables
>> incorrectly.
>If sending the packets to inactive ports, the switch will drop the packets=
 in our production environment, because lacp state of the port is down. I a=
gree with you, the bond brodcast_neighbor enabled should only send packet t=
o active ports.

	The situation I'm concerned with is probably outside the scope
of your particular depolyment, but would nevertheless be a legal
configuration.

	Bonding can negotiate LACP with multiple separate LACP peers,
traditionally this would be separate switches or separate channel groups
on a single switch.  Either way, bonding will have multiple aggregators
(sets of ports aggregated together via LACP), and select one to be the
active aggregator.  The other aggregators will not be used to pass
traffic, but LACP protocol exchanges still take place.  If the active
aggregator were to fail, then bonding would switch over to another
already established aggregator.

	In this situation, with multiple aggregators, the current
broadcast mode logic would send packets to the non-selected
aggregator(s), which would likely process the traffic.

	-J

>>=20
>> Assuming that's correct (that it should exclude interfaces not
>> in the active aggregator), that raises the question of what is the
>> correct behavior if there is no active aggregator, but only ports in
>> individual mode.  I would expect that in that case it should utilize the
>> usual LACP transmit logic (sending on just the individual port that
>> bonding has selected as active).
>>=20
>> -J
>>=20
>>> + fallthrough;
>>> case BOND_MODE_XOR:
>>> return bond_3ad_xor_xmit(skb, dev);
>>> case BOND_MODE_BROADCAST:
>>> @@ -6462,6 +6502,7 @@ static int __init bond_check_params(struct bond_p=
arams *params)
>>> eth_zero_addr(params->ad_actor_system);
>>> params->ad_user_port_key =3D ad_user_port_key;
>>> params->coupled_control =3D 1;
>>> + params->broadcast_neighbor =3D 0;
>>> if (packets_per_slave > 0) {
>>> params->reciprocal_packets_per_slave =3D
>>> reciprocal_value(packets_per_slave);
>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/b=
ond_options.c
>>> index 91893c29b899..7f0939337231 100644
>>> --- a/drivers/net/bonding/bond_options.c
>>> +++ b/drivers/net/bonding/bond_options.c
>>> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding =
*bond,
>>>       const struct bond_opt_value *newval);
>>> static int bond_option_coupled_control_set(struct bonding *bond,
>>>    const struct bond_opt_value *newval);
>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>> +    const struct bond_opt_value *newval);
>>>=20
>>> static const struct bond_opt_value bond_mode_tbl[] =3D {
>>> { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>>> @@ -240,6 +242,12 @@ static const struct bond_opt_value bond_coupled_co=
ntrol_tbl[] =3D {
>>> { NULL,  -1, 0},
>>> };
>>>=20
>>> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D {
>>> + { "off", 0, BOND_VALFLAG_DEFAULT},
>>> + { "on",  1, 0},
>>> + { NULL,  -1, 0}
>>> +};
>>> +
>>> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
>>> [BOND_OPT_MODE] =3D {
>>> .id =3D BOND_OPT_MODE,
>>> @@ -513,6 +521,14 @@ static const struct bond_option bond_opts[BOND_OPT=
_LAST] =3D {
>>> .flags =3D BOND_OPTFLAG_IFDOWN,
>>> .values =3D bond_coupled_control_tbl,
>>> .set =3D bond_option_coupled_control_set,
>>> + },
>>> + [BOND_OPT_BROADCAST_NEIGH] =3D {
>>> + .id =3D BOND_OPT_BROADCAST_NEIGH,
>>> + .name =3D "broadcast_neighbor",
>>> + .desc =3D "Broadcast neighbor packets to all slaves",
>>> + .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>>> + .values =3D bond_broadcast_neigh_tbl,
>>> + .set =3D bond_option_broadcast_neigh_set,
>>> }
>>> };
>>>=20
>>> @@ -1840,3 +1856,22 @@ static int bond_option_coupled_control_set(struc=
t bonding *bond,
>>> bond->params.coupled_control =3D newval->value;
>>> return 0;
>>> }
>>> +
>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>> +    const struct bond_opt_value *newval)
>>> +{
>>> + if (bond->params.broadcast_neighbor =3D=3D newval->value)
>>> + return 0;
>>> +
>>> + bond->params.broadcast_neighbor =3D newval->value;
>>> + if (bond->dev->flags & IFF_UP) {
>>> + if (bond->params.broadcast_neighbor)
>>> + static_branch_inc(&bond_bcast_neigh_enabled);
>>> + else
>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>> + }
>>> +
>>> + netdev_dbg(bond->dev, "Setting broadcast_neighbor to %s (%llu)\n",
>>> +    newval->string, newval->value);
>>> + return 0;
>>> +}
>>> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>>> index 18687ccf0638..022b122a9fb6 100644
>>> --- a/include/net/bond_options.h
>>> +++ b/include/net/bond_options.h
>>> @@ -77,6 +77,7 @@ enum {
>>> BOND_OPT_NS_TARGETS,
>>> BOND_OPT_PRIO,
>>> BOND_OPT_COUPLED_CONTROL,
>>> + BOND_OPT_BROADCAST_NEIGH,
>>> BOND_OPT_LAST
>>> };
>>>=20
>>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>>> index 95f67b308c19..e06f0d63b2c1 100644
>>> --- a/include/net/bonding.h
>>> +++ b/include/net/bonding.h
>>> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct net_=
device *dev)
>>> #define is_netpoll_tx_blocked(dev) (0)
>>> #endif
>>>=20
>>> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>> +
>>> struct bond_params {
>>> int mode;
>>> int xmit_policy;
>>> @@ -149,6 +151,7 @@ struct bond_params {
>>> struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>>> #endif
>>> int coupled_control;
>>> + int broadcast_neighbor;
>>>=20
>>> /* 2 bytes of padding : see ether_addr_equal_64bits() */
>>> u8 ad_actor_system[ETH_ALEN + 2];
>>> --=20
>>> 2.34.1

---
	-Jay Vosburgh, jv@jvosburgh.net

