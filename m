Return-Path: <netdev+bounces-190363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22BAB67BC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8624F172263
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62522170A;
	Wed, 14 May 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="QrYfJUaA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQTk6gp2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA11F4C98
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215500; cv=none; b=p8qPVPRcZsyklupqwbDAgjZgSNlRWZ2dGnfcHtnVZKO1Mp7jn8Obe3AytqiQiEoc5CtohTZ7sA8B8nGoQ9BUbgdeYMd3kGf+kNiDwagKZz5lHt4tV+nZ9r+9FmFJmQvyJSSJULwjpsxw5XozqjdHkR0H5YW79UdLOWnN4MCsSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215500; c=relaxed/simple;
	bh=bK0HvDGpASfI2UlcRhyGmukRHnw5XeY+sWGYPRKeYt8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=u/8DTDPPjcaYFCwYKxChVuBoKGu5P131+K9umYEZYmfBO0uWVOuBGB1eP90LAEEV0rTIaIykkiNbKMT4gsZqytTS53KnVEKVlVND6xcdFNPpyRLt4/QwEeSp4p5TMr6HDucT0hdL/eCse3CoACo1ns9H+Atd+iOjV13JGcxaXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=QrYfJUaA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQTk6gp2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B023A25400E7;
	Wed, 14 May 2025 05:38:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 14 May 2025 05:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1747215494; x=1747301894; bh=fvrzus7gxFeZoU1Ahux/g
	7mMmAhBXX4hzQXfmluovy4=; b=QrYfJUaAGrYV9dNioH9+k+X5k4D3Yy7T6Eln5
	tqomm1611WY4jfqOE5KCuAeNdq8qKvaWAX7s/s5ufio/EmvCbjKJMcKBz2bN33xb
	t6iu5AKxiMcOCvCRXatt7fuR/JVCpZzZSbCxasftexBTBajGdCQZFo+9MWG6JIs9
	LcO9DtL6Ip/EvpyVh0w1+IS3oNv6gZ/8LTYbrkTRxIHddfy6WG4vgfVKFsHpUfna
	9O77Df5O/9Mdy/y8K0+IIw/rBYTNrQrOMAMH+cKgJXgyu2JqTXZiG0Z0+fJyKXHW
	6r1FvlK29Yp58GUyljN+K7tEdaExaCLfyorKKSW+MC32gulVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747215494; x=1747301894; bh=fvrzus7gxFeZoU1Ahux/g7mMmAhBXX4hzQX
	fmluovy4=; b=OQTk6gp2gwHw0Zgs2qjfF1SC/5Kie+cAGMY4mLYbjOoEGFReHL/
	Bfatz7vga3g8UncD/2TTf57N0iAWo7aKzwuiup/tPnHkf2KzxtpVDD40QoI2Db19
	mJhucl4JlfFWaLIRxkIQGbNcM/kHpUEsTESnb/xyvAlmfvkJhLpfPWbeZAd3IbqA
	fhBSq4xQVhZj2zwZFKNO3DG34pfElwBLkR5iAhlmLSDHS9vmnIaV4zefLryWsXSf
	KicxuoK3osJmL0Z8m1897hnH8P6e1FS6WfELTFP2O/XxDBvDsHThIYc1QIZqUEIJ
	IUG5vy3T5C7ZIFDsm2uH8uoeq9uqrD4DzCQ==
X-ME-Sender: <xms:hWQkaNarkn17fsreFCdb9Wh8SOsCFU-XZoVCjVSf3hq8o5ZFiywpZg>
    <xme:hWQkaEaKE4MydI0DtgdZU8gaioI8t0YxLonjVP_YQihNTGUIDnRGV5gT-XEu4rD4w
    F08RITVes9YC3hns3Q>
X-ME-Received: <xmr:hWQkaP8bdYGXvyeRPyJGzRjCwXgS6TGcE-cTlzd9qnemSKBgsPnAYtvAmneHeHHb18AW2nCD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepffekfefgudfhuddvjefgvddtveehheekudev
    jeetheegleetgefgffeuffdvueevnecuffhomhgrihhnpehruhhijhhivgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhv
    ohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepthhuii
    gvnhhgsghinhhgseguihguihhglhhosggrlhdrtghomhdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    nhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheptghorhgsvghtse
    hlfihnrdhnvghtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:hWQkaLpx-4vmIGeXVUsk8mn0Oy9KaZUnKZ5RRWK3CnbA79IvZFEtRA>
    <xmx:hWQkaIpM-OGGQXlFBrGPa4zECT0d_lnzqisJojZ_TulBbBGUZhtj_A>
    <xmx:hWQkaBQvmwf4sxxbejiyjBqhWADpnraCl0Drce6UG1bqWAW8MO4dKg>
    <xmx:hWQkaAqVbNrwVQKFU1tPEGSUku5iBQNk23XGqti5LThEKFAdaT2TXA>
    <xmx:hmQkaC-edmD3P6N33bwbUXGVrbjCCiBbhihm1C2P35ryuY9OtgKlnwoL>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 05:38:13 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 68F1B1C0468; Wed, 14 May 2025 02:38:11 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 681971C0466;
	Wed, 14 May 2025 11:38:11 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next v3 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
In-reply-to: <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com> <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Wed, 14 May 2025 15:13:36 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1338976.1747215491.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 May 2025 11:38:11 +0200
Message-ID: <1338977.1747215491@vermin>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>Stacking technology is a type of technology used to expand ports on
>Ethernet switches. It is widely used as a common access method in
>large-scale Internet data center architectures. Years of practice
>have proved that stacking technology has advantages and disadvantages
>in high-reliability network architecture scenarios. For instance,
>in stacking networking arch, conventional switch system upgrades
>require multiple stacked devices to restart at the same time.
>Therefore, it is inevitable that the business will be interrupted
>for a while. It is for this reason that "no-stacking" in data centers
>has become a trend. Additionally, when the stacking link connecting
>the switches fails or is abnormal, the stack will split. Although it is
>not common, it still happens in actual operation. The problem is that
>after the split, it is equivalent to two switches with the same configura=
tion
>appearing in the network, causing network configuration conflicts and
>ultimately interrupting the services carried by the stacking system.
>
>To improve network stability, "non-stacking" solutions have been increasi=
ngly
>adopted, particularly by public cloud providers and tech companies
>like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing s=
witch
>stacking that convinces a LACP peer, bonding in this case, connected to a=
 set of
>"non-stacked" switches that all of its ports are connected to a single
>switch (i.e., LACP aggregator), as if those switches were stacked. This
>enables the LACP peer's ports to aggregate together, and requires (a)
>special switch configuration, described in the linked article, and (b)
>modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
>packets across all ports of the active aggregator.

	Please reformat the above to wrap at 75 columns, otherwise the
text in "git log" will wrap 80 columns (because git log indents the log
message).

>  -----------     -----------
> |  switch1  |   |  switch2  |
>  -----------     -----------
>         ^           ^
>         |           |
>       -----------------
>      |   bond4 lacp    |
>       -----------------
>         |           |
>         | NIC1      | NIC2
>       -----------------
>      |     server      |
>       -----------------
>
>- https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-=
network-architecture/
>
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>---
> Documentation/networking/bonding.rst |  6 ++++
> drivers/net/bonding/bond_main.c      | 41 ++++++++++++++++++++++++++++
> drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++
> include/net/bond_options.h           |  1 +
> include/net/bonding.h                |  3 ++
> 5 files changed, 86 insertions(+)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index a4c1291d2561..14f7593d888d 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -562,6 +562,12 @@ lacp_rate
> =

> 	The default is slow.
> =

>+broadcast_neighbor
>+
>+	Option specifying whether to broadcast ARP/ND packets to all
>+	active slaves.  This option has no effect in modes other than
>+	802.3ad mode.  The default is off (0).
>+
> max_bonds
> =

> 	Specifies the number of bonding devices to create for this
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index d05226484c64..db6a9c8db47c 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -212,6 +212,8 @@ atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
> =

> unsigned int bond_net_id __read_mostly;
> =

>+DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>+
> static const struct flow_dissector_key flow_keys_bonding_keys[] =3D {
> 	{
> 		.key_id =3D FLOW_DISSECTOR_KEY_CONTROL,
>@@ -4461,6 +4463,9 @@ static int bond_open(struct net_device *bond_dev)
> =

> 		bond_for_each_slave(bond, slave, iter)
> 			dev_mc_add(slave->dev, lacpdu_mcast_addr);
>+
>+		if (bond->params.broadcast_neighbor)
>+			static_branch_inc(&bond_bcast_neigh_enabled);
> 	}
> =

> 	if (bond_mode_can_use_xmit_hash(bond))
>@@ -4480,6 +4485,9 @@ static int bond_close(struct net_device *bond_dev)
> 		bond_alb_deinitialize(bond);
> 	bond->recv_probe =3D NULL;
> =

>+	if (bond->params.broadcast_neighbor)
>+		static_branch_dec(&bond_bcast_neigh_enabled);
>+
> 	if (bond_uses_primary(bond)) {
> 		rcu_read_lock();
> 		slave =3D rcu_dereference(bond->curr_active_slave);
>@@ -5316,6 +5324,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_g=
et(struct bonding *bond,
> 	return slaves->arr[hash % count];
> }
> =

>+static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>+					   struct net_device *dev)
>+{
>+	struct bonding *bond =3D netdev_priv(dev);
>+
>+	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>+		return false;
>+
>+	if (!bond->params.broadcast_neighbor)
>+		return false;
>+
>+	if (skb->protocol =3D=3D htons(ETH_P_ARP))
>+		return true;
>+
>+	if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>+	    pskb_may_pull(skb,
>+			  sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
>+		if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>+			struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>+
>+			if ((icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION) ||
>+			    (icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>+				return true;
>+		}
>+	}

	I'd recommend you look at bond_na_rcv() and mimic its logic for
inspecting the ipv6 and icmp6 headers by using skb_header_pointer()
instead of pskb_may_pull().  The skb_header_pointer() function does not
alter the skb (it will not move data into the skb linear area), and
would have lower cost for this use case.  With broadcast_neighbor
enabled, every IPv6 packet will pass through this test, so minimizing
its cost should be of benefit.

>+
>+	return false;
>+}
>+
> /* Use this Xmit function for 3AD as well as XOR modes. The current
>  * usable slave array is formed in the control path. The xmit function
>  * just calculates hash and sends the packet out.
>@@ -5583,6 +5620,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff=
 *skb, struct net_device *dev
> 	case BOND_MODE_ACTIVEBACKUP:
> 		return bond_xmit_activebackup(skb, dev);
> 	case BOND_MODE_8023AD:
>+		if (bond_should_broadcast_neighbor(skb, dev))
>+			return bond_xmit_broadcast(skb, dev);

	One question that just occured to me... is bond_xmit_broadcast()
actually the correct logic?  It will send the skb to every interface
that is a member of the bond, but for the "non stacked" case, I believe
the correct logic is to send only to interfaces that are part of the
active aggregator.

	Stated another way, with broadcast_neighbor enabled, if the bond
has interfaces not part of the active aggregator (perhaps a switch port
or entire switch not correctly configured for "non stacked" operation),
the ARP / NS / NA packet has the potential to update neighbor tables
incorrectly.

	Assuming that's correct (that it should exclude interfaces not
in the active aggregator), that raises the question of what is the
correct behavior if there is no active aggregator, but only ports in
individual mode.  I would expect that in that case it should utilize the
usual LACP transmit logic (sending on just the individual port that
bonding has selected as active).

	-J

>+		fallthrough;
> 	case BOND_MODE_XOR:
> 		return bond_3ad_xor_xmit(skb, dev);
> 	case BOND_MODE_BROADCAST:
>@@ -6462,6 +6502,7 @@ static int __init bond_check_params(struct bond_par=
ams *params)
> 	eth_zero_addr(params->ad_actor_system);
> 	params->ad_user_port_key =3D ad_user_port_key;
> 	params->coupled_control =3D 1;
>+	params->broadcast_neighbor =3D 0;
> 	if (packets_per_slave > 0) {
> 		params->reciprocal_packets_per_slave =3D
> 			reciprocal_value(packets_per_slave);
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 91893c29b899..7f0939337231 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding *b=
ond,
> 				      const struct bond_opt_value *newval);
> static int bond_option_coupled_control_set(struct bonding *bond,
> 					   const struct bond_opt_value *newval);
>+static int bond_option_broadcast_neigh_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval);
> =

> static const struct bond_opt_value bond_mode_tbl[] =3D {
> 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>@@ -240,6 +242,12 @@ static const struct bond_opt_value bond_coupled_cont=
rol_tbl[] =3D {
> 	{ NULL,  -1, 0},
> };
> =

>+static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D {
>+	{ "off", 0, BOND_VALFLAG_DEFAULT},
>+	{ "on",	 1, 0},
>+	{ NULL,  -1, 0}
>+};
>+
> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> 	[BOND_OPT_MODE] =3D {
> 		.id =3D BOND_OPT_MODE,
>@@ -513,6 +521,14 @@ static const struct bond_option bond_opts[BOND_OPT_L=
AST] =3D {
> 		.flags =3D BOND_OPTFLAG_IFDOWN,
> 		.values =3D bond_coupled_control_tbl,
> 		.set =3D bond_option_coupled_control_set,
>+	},
>+	[BOND_OPT_BROADCAST_NEIGH] =3D {
>+		.id =3D BOND_OPT_BROADCAST_NEIGH,
>+		.name =3D "broadcast_neighbor",
>+		.desc =3D "Broadcast neighbor packets to all slaves",
>+		.unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>+		.values =3D bond_broadcast_neigh_tbl,
>+		.set =3D bond_option_broadcast_neigh_set,
> 	}
> };
> =

>@@ -1840,3 +1856,22 @@ static int bond_option_coupled_control_set(struct =
bonding *bond,
> 	bond->params.coupled_control =3D newval->value;
> 	return 0;
> }
>+
>+static int bond_option_broadcast_neigh_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval)
>+{
>+	if (bond->params.broadcast_neighbor =3D=3D newval->value)
>+		return 0;
>+
>+	bond->params.broadcast_neighbor =3D newval->value;
>+	if (bond->dev->flags & IFF_UP) {
>+		if (bond->params.broadcast_neighbor)
>+			static_branch_inc(&bond_bcast_neigh_enabled);
>+		else
>+			static_branch_dec(&bond_bcast_neigh_enabled);
>+	}
>+
>+	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %s (%llu)\n",
>+		   newval->string, newval->value);
>+	return 0;
>+}
>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index 18687ccf0638..022b122a9fb6 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -77,6 +77,7 @@ enum {
> 	BOND_OPT_NS_TARGETS,
> 	BOND_OPT_PRIO,
> 	BOND_OPT_COUPLED_CONTROL,
>+	BOND_OPT_BROADCAST_NEIGH,
> 	BOND_OPT_LAST
> };
> =

>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 95f67b308c19..e06f0d63b2c1 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct net_de=
vice *dev)
> #define is_netpoll_tx_blocked(dev) (0)
> #endif
> =

>+DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>+
> struct bond_params {
> 	int mode;
> 	int xmit_policy;
>@@ -149,6 +151,7 @@ struct bond_params {
> 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> #endif
> 	int coupled_control;
>+	int broadcast_neighbor;
> =

> 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
> 	u8 ad_actor_system[ETH_ALEN + 2];
>-- =

>2.34.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

