Return-Path: <netdev+bounces-190162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CECAB5614
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04261B46B53
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81290146D65;
	Tue, 13 May 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="dhBm74km";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smXWycva"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828407482
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143062; cv=none; b=MWdBK45o4Tf+Bo2RyvzOKDIBZXA0Uy1UDqCMzmSj6sA6toU7H5grlYcSSrhSznCqrzn2ngJ2J+mqKhoCPkc8A4vozVzbxi7hQ3RYpLx6KuEUyFKPurrXNPzuuziFc0wRT4JpS1RPvfEnbfKD3LV3VrhpWxBeSoamRRsFy5PdMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143062; c=relaxed/simple;
	bh=dL/R+GISrnVBm4raWUcwEl4pT0A6aqnvtsT00uycvCc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=AofaAII9BZ4HBHojIcgx3ETrQY5CnFjZRaptn8rOb3bIQPs+/baAQAV5azdg6xuY3k3oy3nalaGq9ZvUJFAboZ4yqP7rk7TJ88mxKHP93W1cn5gPgsnYWkUeMkX7B0kXDxwO1IFTjV7fMyynmfngc2tgQ9qIZ0r2cspQOBUJlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=dhBm74km; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smXWycva; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F30E1380151;
	Tue, 13 May 2025 09:30:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 May 2025 09:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1747143057; x=1747229457; bh=Q2LPelCBA4aLWm6BRaEFGYdDtYsDxSB1
	9eoPj/FFaXg=; b=dhBm74kmDT+2n2xP0r8b7zUlr9fGk0+U4/AMkjdGIZ0n6v2R
	RM9C1vv5fUn5Ah/VJFQMGlwIJX9bgW9kTsHM72e3UIV4yJ86t2V5NRseOlkOnZSr
	IR/Rocuu3Dvnw6cduC6Yv2ofmRTUWHUYB6YIPnTo9sTIVB+/5CE80dz+h39lf7/t
	+tuR3R+AbnyAGrZIbUa0BIl79fMO4hrxI1zHUphOdALI6UsSj/GduHA2FXE3ObhX
	p9gxiI83o1ChGJ4j61YmSSTq71d+0e62NJi+GX0h+UkqNXtZ+DA2ENENAm3xgWNE
	e//Ol/zbRtKsA4+gVG0Tl4/HQhskLwJAH6BsTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747143057; x=
	1747229457; bh=Q2LPelCBA4aLWm6BRaEFGYdDtYsDxSB19eoPj/FFaXg=; b=s
	mXWycvaoEPgbEbV02SlsMCJz30s3MGVojb6RCA2Vjp/L7UoZSTCcPb+p4/9L8Iym
	HYeKBnSQxk5FbJWz9yuiO3UGIxf6OkI2IpIHYBH61FqDlKFO5uo/NZvcOyJ6pDre
	ohp+8p7uNngOHZFIkmhYYOYG3SJlBI+ZwAO6R4+BcDGOnAV3amBhThRu4JWAxzTJ
	Vg7jzBEevkI31UT2Dul5g6aAVBIBGjAoCaU2XY8m8hFH4hqblONn+4Fcvbm648vR
	CdDToa0gX3XA9HhrhLpg/nstfJhiuItPwtjFq/La8tNBu5QzmHNoKHstrBHPOiMh
	BrHITEfHnJUkYhYOdKRGg==
X-ME-Sender: <xms:kEkjaIU7xLU0ulSE3Oh8RSAZG-KLYbvcm3bm7BBh_E2YI7jKAl3Zdg>
    <xme:kEkjaMnxmC526S3ujU5SGWVFMJoUTxDu_4zm2cYTCMD0ktbhf8Zj8A4y3Y9sPJUf_
    1XtvLZ9-YMC93xnpyA>
X-ME-Received: <xmr:kEkjaMbgBWtXkBXKfdHwI0Lebp4cU3IUAwy-SKzfs1oX642b_RrS3Fr0ZpXFltwX60ZShGeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tdejnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhephfdvlefftdegvdehgfdtveekfedviedvhfet
    hfdtleejheeileegffekffffgedunecuffhomhgrihhnpehruhhijhhivgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhv
    ohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprhgt
    phhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehtuhiivghnghgsihhnghes
    ughiughighhlohgsrghlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvg
    htuggvvheslhhunhhnrdgthhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:kEkjaHUE3gi2Jbf1tSY1ubb-aoC4ye8orzU6sPWt8-rxdl9pVqDNbA>
    <xmx:kEkjaCnIqAyEAhorttCFjOuZYj2Nyzs2YvmOjqaxjsf2ra00TJR-8Q>
    <xmx:kEkjaMerZJz6lCzvHefS3uDcFDCzrBtz-bxfV5-gF3x8cvKHHMpTOg>
    <xmx:kEkjaEF_Q2nYKLgS9tnW-ah5NP2AK-YgXcLX7wHWsHe5hvAXBii12g>
    <xmx:kUkjaNqPXC8Ivlh7xnQywmO9FE86X9bVFHE7CN5YF--BCycZ5rUgKw4M>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 09:30:55 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id BD7E41C0468; Tue, 13 May 2025 06:30:53 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id BBA4D1C0466;
	Tue, 13 May 2025 15:30:53 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next v2 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
In-reply-to: <d0e0379e-79fb-4a95-b160-6c1ca4276081@blackwall.org>
References: <20250513094750.23387-1-tonghao@bamaicloud.com> <4270C010E5516F3B+20250513094750.23387-2-tonghao@bamaicloud.com> <f690dc4a-fde8-411d-84d8-67980555f479@blackwall.org> <191F1618-E561-4B82-84E3-1E19E22197F3@bamaicloud.com> <d0e0379e-79fb-4a95-b160-6c1ca4276081@blackwall.org>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Tue, 13 May 2025 15:20:00 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 May 2025 15:30:53 +0200
Message-ID: <1319073.1747143053@vermin>

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On 5/13/25 15:13, Tonghao Zhang wrote:
>>=20
>>=20
>>> 2025=E5=B9=B45=E6=9C=8813=E6=97=A5 18:18=EF=BC=8CNikolay Aleksandrov <r=
azor@blackwall.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> On 5/13/25 12:47, Tonghao Zhang wrote:
>>>> Stacking technology is a type of technology used to expand ports on
>>>> Ethernet switches. It is widely used as a common access method in
>>>> large-scale Internet data center architectures. Years of practice
>>>> have proved that stacking technology has advantages and disadvantages
>>>> in high-reliability network architecture scenarios. For instance,
>>>> in stacking networking arch, conventional switch system upgrades
>>>> require multiple stacked devices to restart at the same time.
>>>> Therefore, it is inevitable that the business will be interrupted
>>>> for a while. It is for this reason that "no-stacking" in data centers
>>>> has become a trend. Additionally, when the stacking link connecting
>>>> the switches fails or is abnormal, the stack will split. Although it is
>>>> not common, it still happens in actual operation. The problem is that
>>>> after the split, it is equivalent to two switches with the same config=
uration
>>>> appearing in the network, causing network configuration conflicts and
>>>> ultimately interrupting the services carried by the stacking system.
>>>>
>>>> To improve network stability, "non-stacking" solutions have been incre=
asingly
>>>> adopted, particularly by public cloud providers and tech companies
>>>> like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicin=
g switch
>>>> stacking that convinces a LACP peer, bonding in this case, connected t=
o a set of
>>>> "non-stacked" switches that all of its ports are connected to a single
>>>> switch (i.e., LACP aggregator), as if those switches were stacked. This
>>>> enables the LACP peer's ports to aggregate together, and requires (a)
>>>> special switch configuration, described in the linked article, and (b)
>>>> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
>>>> packets across all ports of the active aggregator.
>>>>
>>>>  -----------     -----------
>>>> |  switch1  |   |  switch2  |
>>>>  -----------     -----------
>>>>         ^           ^
>>>>         |           |
>>>>        ---------------
>>>>       |   bond4 lacp  |
>>>>        ---------------
>>>>         | NIC1      | NIC2
>>>>     ---------------------
>>>>    |       server        |
>>>>     ---------------------
>>>>
>>>> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-cent=
er-network-architecture/
>>>>
>>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Simon Horman <horms@kernel.org>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>>> ---
>>>> Documentation/networking/bonding.rst |  6 +++++
>>>> drivers/net/bonding/bond_main.c      | 39 ++++++++++++++++++++++++++++
>>>> drivers/net/bonding/bond_options.c   | 34 ++++++++++++++++++++++++
>>>> drivers/net/bonding/bond_sysfs.c     | 18 +++++++++++++
>>>> include/net/bond_options.h           |  1 +
>>>> include/net/bonding.h                |  3 +++
>>>> 6 files changed, 101 insertions(+)
>>>>
>>>> diff --git a/Documentation/networking/bonding.rst b/Documentation/netw=
orking/bonding.rst
>>>> index a4c1291d2561..14f7593d888d 100644
>>>> --- a/Documentation/networking/bonding.rst
>>>> +++ b/Documentation/networking/bonding.rst
>>>> @@ -562,6 +562,12 @@ lacp_rate
>>>>
>>>> The default is slow.
>>>>
>>>> +broadcast_neighbor
>>>> +
>>>> + Option specifying whether to broadcast ARP/ND packets to all
>>>> + active slaves.  This option has no effect in modes other than
>>>> + 802.3ad mode.  The default is off (0).
>>>> +
>>>> max_bonds
>>>>
>>>> Specifies the number of bonding devices to create for this
>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bon=
d_main.c
>>>> index d05226484c64..8ee26ddddbc8 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -212,6 +212,9 @@ atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
>>>>
>>>> unsigned int bond_net_id __read_mostly;
>>>>
>>>> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>>> +EXPORT_SYMBOL_GPL(bond_bcast_neigh_enabled);
>>>
>>> No need to export the symbol, you can add bond helpers to inc/dec it.

	Agreed.

>>>> +
>>>> static const struct flow_dissector_key flow_keys_bonding_keys[] =3D {
>>>> {
>>>> .key_id =3D FLOW_DISSECTOR_KEY_CONTROL,
>>>> @@ -4480,6 +4483,9 @@ static int bond_close(struct net_device *bond_de=
v)
>>>> bond_alb_deinitialize(bond);
>>>> bond->recv_probe =3D NULL;
>>>>
>>>> + if (bond->params.broadcast_neighbor)
>>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>>> +
>>>
>>> This branch doesn't get re-enabled if the bond is brought up afterwards.
>> This is not right place to dec bond_bcast_neigh_enabled, I should dec th=
is value in bond_uninit(). Because we can destroy a bond net device which b=
roadcast_neighbor enabled.
>> If we don=E2=80=99t check broadcast_neighbor in destroy path. bond_bcast=
_neigh_enabled always is enabled. For example:
>> ip link add bondx type bond mode 802.3ad ... broadcast_neighbor on
>> ip link add bondy type bond mode 802.3ad ... broadcast_neighbor off
>>=20
>> ip li del dev bondx
>> In this case, bond_bcast_neigh_enabled is enabled for bondy while broadc=
ast_neighbor is off.

	So it sounds like the flow should be:

	- increment the static key when:
		- option enabled on IFF_UP bond (transition from off to on)
		- bond set to up with option enabled (bond_open)

	- decrement the static key when:
		- option disabled on IFF_UP bond (transition from on to off)
		- bond with option enabled is set to down (bond_close)

	The unregister path in unregister_netdevice_many_notify that
calls bond_uninit will call dev_close before the ndo_uninit, so I don't
think we need to handle the static key in bond_uninit separately.


>>>>>> if (bond_uses_primary(bond)) {
>>>> rcu_read_lock();
>>>> slave =3D rcu_dereference(bond->curr_active_slave);
>>>> @@ -5316,6 +5322,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slav=
e_get(struct bonding *bond,
>>>> return slaves->arr[hash % count];
>>>> }
>>>>
>>>> +static inline bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>>>
>>> don't use inline in .c files
>> As suggested by Jay, inline the codes for performance. I think it is bet=
ter to keep inline. By the way, there are many inline function in bond_main=
.c and other *.c
>
>This is a general rule, the compiler knows what to do. The inlines in bond=
_main are old
>and can be removed. Do not add new ones.

	To clarify, the intent of my question was to ask whether or not
the compiler was inlining the existing code in Tonghao's earlier patch.
I did not intend to suggest that an explicit inline should be added.

	That said, I agree with Nikolay in that inline should not be
added explicitly.

>>>> +  struct net_device *dev)
>>>> +{
>>>> + struct bonding *bond =3D netdev_priv(dev);
>>>> +
>>>> + if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>>>> + return false;
>>>> +
>>>> + if (!bond->params.broadcast_neighbor)
>>>> + return false;
>>>> +
>>>> + if (skb->protocol =3D=3D htons(ETH_P_ARP))
>>>> + return true;
>>>> +
>>>> + if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>>>> +    pskb_may_pull(skb,
>>>> +  sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
>>>> + if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>>>> + struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>>>> +
>>>> + if ((icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION) ||
>>>> +    (icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>>>> + return true;
>>>> + }
>>>> + }
>>>> +
>>>> + return false;
>>>> +}
>>>> +
>>>> /* Use this Xmit function for 3AD as well as XOR modes. The current
>>>>  * usable slave array is formed in the control path. The xmit function
>>>>  * just calculates hash and sends the packet out.
>>>> @@ -5583,6 +5618,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_b=
uff *skb, struct net_device *dev
>>>> case BOND_MODE_ACTIVEBACKUP:
>>>> return bond_xmit_activebackup(skb, dev);
>>>> case BOND_MODE_8023AD:
>>>> + if (bond_should_broadcast_neighbor(skb, dev))
>>>> + return bond_xmit_broadcast(skb, dev);
>>>> + fallthrough;
>>>> case BOND_MODE_XOR:
>>>> return bond_3ad_xor_xmit(skb, dev);
>>>> case BOND_MODE_BROADCAST:
>>>> @@ -6462,6 +6500,7 @@ static int __init bond_check_params(struct bond_=
params *params)
>>>> eth_zero_addr(params->ad_actor_system);
>>>> params->ad_user_port_key =3D ad_user_port_key;
>>>> params->coupled_control =3D 1;
>>>> + params->broadcast_neighbor =3D 0;
>>>> if (packets_per_slave > 0) {
>>>> params->reciprocal_packets_per_slave =3D
>>>> reciprocal_value(packets_per_slave);
>>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/=
bond_options.c
>>>> index 91893c29b899..dca52d93f513 100644
>>>> --- a/drivers/net/bonding/bond_options.c
>>>> +++ b/drivers/net/bonding/bond_options.c
>>>> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding=
 *bond,
>>>>      const struct bond_opt_value *newval);
>>>> static int bond_option_coupled_control_set(struct bonding *bond,
>>>>   const struct bond_opt_value *newval);
>>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>>> +   const struct bond_opt_value *newval);
>>>>
>>>> static const struct bond_opt_value bond_mode_tbl[] =3D {
>>>> { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>>>> @@ -240,6 +242,12 @@ static const struct bond_opt_value bond_coupled_c=
ontrol_tbl[] =3D {
>>>> { NULL,  -1, 0},
>>>> };
>>>>
>>>> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D {
>>>> + { "on", 1, 0},
>>>> + { "off", 0, BOND_VALFLAG_DEFAULT},
>>>
>>> I know the option above is using this order, but it is a bit counter-in=
tuitive to
>>> have their places reversed wrt their values, could you please re-order =
these as
>>> the other bond on/off options? This is a small nit, I don't have a stro=
ng preference
>>> but it is more intuitive to have them in their value order. :)
>> Ok
>>>
>>>> + { NULL,  -1, 0}> +};
>>>> +
>>>> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
>>>> [BOND_OPT_MODE] =3D {
>>>> .id =3D BOND_OPT_MODE,
>>>> @@ -513,6 +521,14 @@ static const struct bond_option bond_opts[BOND_OP=
T_LAST] =3D {
>>>> .flags =3D BOND_OPTFLAG_IFDOWN,
>>>> .values =3D bond_coupled_control_tbl,
>>>> .set =3D bond_option_coupled_control_set,
>>>> + },
>>>> + [BOND_OPT_BROADCAST_NEIGH] =3D {
>>>> + .id =3D BOND_OPT_BROADCAST_NEIGH,
>>>> + .name =3D "broadcast_neighbor",
>>>> + .desc =3D "Broadcast neighbor packets to all slaves",
>>>> + .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>>>> + .values =3D bond_broadcast_neigh_tbl,
>>>> + .set =3D bond_option_broadcast_neigh_set,
>>>> }
>>>> };
>>>>
>>>> @@ -1840,3 +1856,21 @@ static int bond_option_coupled_control_set(stru=
ct bonding *bond,
>>>> bond->params.coupled_control =3D newval->value;
>>>> return 0;
>>>> }
>>>> +
>>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>>> +   const struct bond_opt_value *newval)
>>>> +{
>>>> + netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
>>>> +   newval->value);
>>>> +
>>>> + if (bond->params.broadcast_neighbor =3D=3D newval->value)
>>>> + return 0;
>>>> +
>>>> + bond->params.broadcast_neighbor =3D newval->value;
>>>> + if (bond->params.broadcast_neighbor)
>>>> + static_branch_inc(&bond_bcast_neigh_enabled);
>>>> + else
>>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>>
>>> If the bond has been brought down then the branch has been already decr=
emented.
>>> You'll have to synchronize this with bond open/close or alternatively m=
ark the option
>>> as being able to be changed only when the bond is up (there is an optio=
n flag for that).
>> I will check bond_bcast_neigh_enabled in bond_unint() instead of in bond=
_close().
>>>>>
>>>> +
>>>> + return 0;
>>>> +}
>>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bo=
nd_sysfs.c
>>>> index 1e13bb170515..4a53850b2c68 100644
>>>> --- a/drivers/net/bonding/bond_sysfs.c
>>>> +++ b/drivers/net/bonding/bond_sysfs.c
>>>> @@ -752,6 +752,23 @@ static ssize_t bonding_show_ad_user_port_key(stru=
ct device *d,
>>>> static DEVICE_ATTR(ad_user_port_key, 0644,
>>>>   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>>>>
>>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>>>> +       struct device_attribute *attr,
>>>> +       char *buf)
>>>> +{
>>>> + struct bonding *bond =3D to_bond(d);
>>>> + const struct bond_opt_value *val;
>>>> +
>>>> + val =3D bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
>>>> +       bond->params.broadcast_neighbor);
>>>> +
>>>> + return sysfs_emit(buf, "%s %d\n", val->string,
>>>> +  bond->params.broadcast_neighbor);
>>>> +}
>>>> +
>>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>>>> +   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>>>> +
>>>
>>> sysfs options are deprecated, please don't extend sysfs
>>> netlink is the preferred way for new options
>> I think it is still useful to config option via sysfs, and I find other =
new option still use the sysfs.
>
>This is wrong, there are no new options that have been added to sysfs rece=
ntly,
>the latest option being "coupled_control". As I already said - sysfs has b=
een deprecated
>for quite some time, don't add new options to it.

	Agreed, no new options in bonding's sysfs.  We are intentionally
encouraging the use of netlink / iproute for bonding configuration
instead of sysfs.

	-J

>>>> static struct attribute *per_bond_attrs[] =3D {
>>>> &dev_attr_slaves.attr,
>>>> &dev_attr_mode.attr,
>>>> @@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] =3D {
>>>> &dev_attr_ad_actor_system.attr,
>>>> &dev_attr_ad_user_port_key.attr,
>>>> &dev_attr_arp_missed_max.attr,
>>>> + &dev_attr_broadcast_neighbor.attr,
>>>> NULL,
>>>> };
>>>>
>>>> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>>>> index 18687ccf0638..022b122a9fb6 100644
>>>> --- a/include/net/bond_options.h
>>>> +++ b/include/net/bond_options.h
>>>> @@ -77,6 +77,7 @@ enum {
>>>> BOND_OPT_NS_TARGETS,
>>>> BOND_OPT_PRIO,
>>>> BOND_OPT_COUPLED_CONTROL,
>>>> + BOND_OPT_BROADCAST_NEIGH,
>>>> BOND_OPT_LAST
>>>> };
>>>>
>>>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>>>> index 95f67b308c19..e06f0d63b2c1 100644
>>>> --- a/include/net/bonding.h
>>>> +++ b/include/net/bonding.h
>>>> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct net=
_device *dev)
>>>> #define is_netpoll_tx_blocked(dev) (0)
>>>> #endif
>>>>
>>>> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>>> +
>>>> struct bond_params {
>>>> int mode;
>>>> int xmit_policy;
>>>> @@ -149,6 +151,7 @@ struct bond_params {
>>>> struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>>>> #endif
>>>> int coupled_control;
>>>> + int broadcast_neighbor;
>>>>
>>>> /* 2 bytes of padding : see ether_addr_equal_64bits() */
>>>> u8 ad_actor_system[ETH_ALEN + 2];
>>>
>>>
>>>
>>=20
>

---
	-Jay Vosburgh, jv@jvosburgh.net

