Return-Path: <netdev+bounces-189468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4CAB23DB
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB24C1E7C
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09015221726;
	Sat, 10 May 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="KGJZVHvW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbZy5Ff3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C124EF90
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746881088; cv=none; b=WQecJEtqBsl5XFz6hFc/tGHvSqeQNV/WD18xftcJ54zh7KUyDao11p4zQ7MUYN8roXGoXSaEQCboNuVLG2uyAzpp1r1mqUvbyxgettWFr/dLbmF9DgnoeGgn7pYhWEjnECLERRT918s7aXrXR7tYsJoxyYx/U4o7hLDAanO70NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746881088; c=relaxed/simple;
	bh=vz+jAX6UGU+1fI2A5yY9cPsJKMoXqcG5xyrgX7gzzKA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=OKLUBlTU3/hAbvzLqXVfNhcFSZmWAbBIw9g2n7vAF663B/7bJjzFvK6W/qqkHk7HRcUH5oqryQ51mJRGNIpt8sXFofircmYs705jY5wjD/M3psk8wB04EKHua0Qkt3niKRRRHveIUPhBMuz5U1sZOFE3e8nFwFo6OKTR7L19Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=KGJZVHvW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbZy5Ff3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB7C92540153;
	Sat, 10 May 2025 08:44:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 10 May 2025 08:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1746881082; x=1746967482; bh=wJuI1siOCnATQBDZZuw2C
	1GmMfaGkF6UC7KEclo07rM=; b=KGJZVHvWNIZTw0GXkgupgpUNemGADUICuK7kw
	X9zCV4QT/RkgKzGji0wj7VCY5iyVM9dpLhzC5MjxWrnGefFx4SCrKZ4lNH5Lbbl4
	qvc7Lhe8AE+CY3/FarI8VyqTNxNPE5hn9szIW7GFcJRcTTdmxC//+qlr0nzFm/Vv
	PiV3G/ATfQn/4h9g/eHkCLl2J55iW6WYy/PTq5m5b5vKHDbyH22E+XgVz3uzeGeu
	PYaVG1dYe719LnelnmFSsLuCukO2rCXxxlsRJem/vRp22OhQF4nwIoDEh7InIOwP
	tDZ951RZex8dH2Ghvu/C0v1GN23n/rd32FUQdksPgoqGuY0SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746881082; x=1746967482; bh=wJuI1siOCnATQBDZZuw2C1GmMfaGkF6UC7K
	Eclo07rM=; b=HbZy5Ff3Vtz7cK0/ubYgyIYdpCGHaH7fw5fskgAO3GrmfeZ/QUs
	LOQ5dsozMXTBQT15oRQ05q2Us1rtIm61JyoEbHvN7NR9ydazQp1d7ApnXSr+UOBn
	jvEIT9rn6bbCYGiVdi4nU5ZO2/f/fDMjmNNORdm17pFpIbbDiD9Bj4h7BFJOerJV
	3JlNpE9T256pNJp52w5YvS/r6N75f4UsgxW5glqxF0tBEhEGxUY3b/lktWzeh1n8
	aW7mpXC6ExHzQ0XHMcNefgbXwd4X81ohRGUVA9vRaFW6loNDBgl51y/KSe+2GJMs
	yj3JA+BZKclxKcoUvPBnadbCqO0sl9eqlCQ==
X-ME-Sender: <xms:OUofaO-FpYje2iAp3mlaVTvrmbaBZTtT2nO6JOpVXiekZl_hX5ojKA>
    <xme:OUofaOvcGOdwEP1-UlL22siIUxH06Q7FV0Ib01l5MYm-te0U-N1uFlJQXqCKNbh0D
    hCOqTh11fJmTBJlsHU>
X-ME-Received: <xmr:OUofaECKFSZi7Irr6BqA6Ah9mnYaoOf7HSWsEJiTU7oeSiusm6lZqMa6T492KoIKTeLhazaK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepffekfefgudfhuddvjefgvddtveehheekudev
    jeetheegleetgefgffeuffdvueevnecuffhomhgrihhnpehruhhijhhivgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhv
    ohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepthhonhhghhgrohessggrmhgrihgtlhhouhgurdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheptghorhgsvght
    sehlfihnrdhnvghtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OUofaGfJRMn0EJ1tk4Yp7ISTL5P9ittyXNaGfJlezzoLGWvsA1vmQQ>
    <xmx:OUofaDMPdLj7WHkYnv5k20YKtmx29LCaG-zZvbN5fzn-TVrEUgybdA>
    <xmx:OUofaAnn_IwBo311MyjoISRu0x_XCz2PzHPIMyiaAa_aVeKtjllDaQ>
    <xmx:OUofaFsGKnwSjsQHuobHnl_B3_r7ymlxiKvJWb_fWB4_tCAclzfLOg>
    <xmx:OkofaKD--8g2h63ptwbRA7G8zENVm5jvQOQVVp89ylm3OkjuNHRr2fr5>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 May 2025 08:44:40 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 10C211C007C; Sat, 10 May 2025 05:44:37 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 0E1761C007B;
	Sat, 10 May 2025 14:44:37 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: tonghao@bamaicloud.com
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
In-reply-to: <20250510044504.52618-2-tonghao@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com> <20250510044504.52618-2-tonghao@bamaicloud.com>
Comments: In-reply-to tonghao@bamaicloud.com
   message dated "Sat, 10 May 2025 12:45:01 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1133229.1746881076.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 May 2025 14:44:37 +0200
Message-ID: <1133230.1746881077@vermin>

tonghao@bamaicloud.com wrote:

>From: Tonghao Zhang <tonghao@bamaicloud.com>
>
>Stacking technology provides technical benefits but has inherent drawback=
s.
>For instance, switch software or system upgrades require simultaneous reb=
oots
>of all stacked switches. Additionally, stacking link failures may cause
>stack splitting.
>
>To improve network stability, non-stacking solutions have been increasing=
ly
>adopted, particularly by public cloud providers and technology companies
>like Alibaba, Tencent, and Didi. The server still uses dual network cards=
 and
>dual uplinks to two switches, and the network card mode is set to
>bond mode 4 (IEEE 802.3ad). As aggregation ports transmit ARP/ND data
>exclusively through one physical port, both switches in non-stacking
>deployments must receive server ARP/ND requests. This requires bonding dr=
iver
>modifications to broadcast ARP/ND packets through all active slave links.
>
>- https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-=
network-architecture/

	I didn't really follow the explanation here without reading the
linked article.  I think it would be better to explain the basics of
what this "non-stacking" architecture is, then describe the change to
bonding necessary to support it.  This description need not go into
great detail; assuming I understand correctly, perhaps something along
the lines of:

	"non-stacking" is a method of mimicing switch stacking that
convinces a LACP peer, bonding in this case, connected to a set of
"non-stacked" switches that all of its ports are connected to a single
switch (i.e., LACP aggregator), as if those switches were stacked.  This
enables the LACP peer's ports to aggregate together, and requires (a)
special switch configuration, described in the linked article, and (b)
modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
packets across all ports of the active aggregator.

	Is that a fair summary?

	Regardless, the commit message should stand on its own, even if
the linked article is gone at some point in the future.

>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>---
> Documentation/networking/bonding.rst |  5 +++
> drivers/net/bonding/bond_main.c      | 58 +++++++++++++++++++++-------
> drivers/net/bonding/bond_options.c   | 25 ++++++++++++
> drivers/net/bonding/bond_sysfs.c     | 18 +++++++++
> include/net/bond_options.h           |  1 +
> include/net/bonding.h                |  1 +
> 6 files changed, 94 insertions(+), 14 deletions(-)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index a4c1291d2561..0aca6e7599db 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -562,6 +562,11 @@ lacp_rate
> =

> 	The default is slow.
> =

>+broadcast_neighbor
>+
>+    Option specifying whether to broadcast ARP/ND packets to all
>+    active slaves. The default is off (0).
>+

	I'm happy to see documentation updates; however, please add the
caveat that this option has no effect in modes other than 802.3ad mode.
Also, the text is not formatted consistently with the options around it
(block indented one tab).

> max_bonds
> =

> 	Specifies the number of bonding devices to create for this
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index d05226484c64..c54bfba10688 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5316,23 +5316,31 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_=
get(struct bonding *bond,
> 	return slaves->arr[hash % count];
> }
> =

>-/* Use this Xmit function for 3AD as well as XOR modes. The current
>- * usable slave array is formed in the control path. The xmit function
>- * just calculates hash and sends the packet out.
>- */
>-static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>-				     struct net_device *dev)
>+static bool bond_should_broadcast_neighbor(struct bonding *bond,
>+					   struct sk_buff *skb)
> {
>-	struct bonding *bond =3D netdev_priv(dev);
>-	struct bond_up_slave *slaves;
>-	struct slave *slave;
>+	if (BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>+		return false;
> =

>-	slaves =3D rcu_dereference(bond->usable_slaves);
>-	slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>-	if (likely(slave))
>-		return bond_dev_queue_xmit(bond, skb, slave->dev);
>+	if (!bond->params.broadcast_neighbor)
>+		return false;
> =

>-	return bond_tx_drop(dev, skb);
>+	if (skb->protocol =3D=3D htons(ETH_P_ARP))
>+		return true;
>+
>+        if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>+            pskb_may_pull(skb,
>+                          sizeof(struct ipv6hdr) + sizeof(struct icmp6hd=
r))) {
>+                if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>+                        struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>+
>+                        if ((icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_SO=
LICITATION) ||
>+                            (icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_AD=
VERTISEMENT))
>+                                return true;
>+                }
>+        }
>+
>+        return false;
> }
> =

> /* in broadcast mode, we send everything to all usable interfaces. */
>@@ -5377,6 +5385,28 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_b=
uff *skb,
> 	return NET_XMIT_DROP;
> }
> =

>+/* Use this Xmit function for 3AD as well as XOR modes. The current
>+ * usable slave array is formed in the control path. The xmit function
>+ * just calculates hash and sends the packet out.
>+ */
>+static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>+				     struct net_device *dev)
>+{
>+	struct bonding *bond =3D netdev_priv(dev);
>+	struct bond_up_slave *slaves;
>+	struct slave *slave;
>+
>+	if (bond_should_broadcast_neighbor(bond, skb))
>+		return bond_xmit_broadcast(skb, dev);

	I feel like there has to be a way to implement this that won't
add two or three branches to the transmit fast path for every packet
when this option is not enabled (which will be the vast majority of
cases).  I'm not sure what that would look like, needs some thought.

	Is the call to bond_should_broadcast_neighbor inlined at compile
time?

	-J

>+
>+	slaves =3D rcu_dereference(bond->usable_slaves);
>+	slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>+	if (likely(slave))
>+		return bond_dev_queue_xmit(bond, skb, slave->dev);
>+
>+	return bond_tx_drop(dev, skb);
>+}
>+
> /*------------------------- Device initialization ----------------------=
-----*/
> =

> /* Lookup the slave that corresponds to a qid */
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 91893c29b899..38e8f03d1707 100644
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
>+	{ "on",	 1, 0},
>+	{ "off", 0, BOND_VALFLAG_DEFAULT},
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

>@@ -1840,3 +1856,12 @@ static int bond_option_coupled_control_set(struct =
bonding *bond,
> 	bond->params.coupled_control =3D newval->value;
> 	return 0;
> }
>+
>+static int bond_option_broadcast_neigh_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval)
>+{
>+	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
>+		   newval->value);
>+	bond->params.broadcast_neighbor =3D newval->value;
>+	return 0;
>+}
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 1e13bb170515..76f2a1bf57c2 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -752,6 +752,23 @@ static ssize_t bonding_show_ad_user_port_key(struct =
device *d,
> static DEVICE_ATTR(ad_user_port_key, 0644,
> 		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
> =

>+static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>+					       struct device_attribute *attr,
>+					       char *buf)
>+{
>+	struct bonding *bond =3D to_bond(d);
>+	const struct bond_opt_value *val;
>+
>+	val =3D bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
>+			bond->params.broadcast_neighbor);
>+
>+	return sysfs_emit(buf, "%s %d\n", val->string,
>+			bond->params.broadcast_neighbor);
>+}
>+
>+static DEVICE_ATTR(broadcast_neighbor, 0644,
>+		   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>+
> static struct attribute *per_bond_attrs[] =3D {
> 	&dev_attr_slaves.attr,
> 	&dev_attr_mode.attr,
>@@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] =3D {
> 	&dev_attr_ad_actor_system.attr,
> 	&dev_attr_ad_user_port_key.attr,
> 	&dev_attr_arp_missed_max.attr,
>+	&dev_attr_broadcast_neighbor.attr,
> 	NULL,
> };
> =

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
>index 95f67b308c19..1eafd15eaad9 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -149,6 +149,7 @@ struct bond_params {
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

