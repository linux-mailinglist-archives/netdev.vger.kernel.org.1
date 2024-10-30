Return-Path: <netdev+bounces-140455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849E9B690C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E7E1F21D38
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BEB2141B5;
	Wed, 30 Oct 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="kRPRNLqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjSRHhAz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B021314C;
	Wed, 30 Oct 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305273; cv=none; b=R+03txWcfrilkd+8xaWIYblB4kvOKFmHLy8SdrubUytcf+owZyBjOhqmF8AvHalKqUlBYVYX+gz5ONdHjWOJxrMI0m02C6RUqbVwlMfyOW92OKLdLEY4kX2KndJUEZ+3r/elVUBnicrHiRNnGlDFQIA/OTKX08+E5yWwUPi+TQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305273; c=relaxed/simple;
	bh=1p1sFkjDuCdzeMuT9ajs6NZyRhkgJdi9qGCMeX7JDZs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=OErU+wXjZRxI0RrkUh6mIDV9DsBOMKDdrgyAR7ga3BmoF3/+GGk+NJcwHziEjluKA/SEEjHGW053MBAzLSa4RJCP64AArQ7vkOt1pBWwnfmU23PgoKwZ4LgiPN5s/VN9OPVJwVLiTPiBbrIaOaZgRI6hzCSDgduugD36g3OVU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=kRPRNLqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjSRHhAz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08792254008B;
	Wed, 30 Oct 2024 12:21:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Oct 2024 12:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1730305267; x=1730391667; bh=i0bgNI5ER6DIumQi5vUG3oO0iwDsmVpV
	usF+uQXLQ+M=; b=kRPRNLqHWTFDZCIC4pA78cmk0Ay7wm7RpRA2bhT4LBU2+Bud
	1W7+GX3tHtoIo8ExI9VKpEdSSU8VK5UL/2siLzKAEyDZ6HtsFh3NrVs7z9y/YcZr
	wQIccOf8pEi1jK8yCsAfAKt98HKg7/htEeVFgZxkaE+cCspNWpucdROR4u/ryhf+
	z74VP5mppiHmO3nRJEHHg8t+HDgxMDWBGU191ymK+sqD2jkxzcpL/PozWDdg4fZS
	T542axhS19bob7g432jeFLzHOimVQa4XProtAbSsaE7sxiAum/3Rq94+vHJF/aAQ
	isnkCalky0EbZy+oxwWbGJdpLbjubBfLc2Cmiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730305267; x=
	1730391667; bh=i0bgNI5ER6DIumQi5vUG3oO0iwDsmVpVusF+uQXLQ+M=; b=F
	jSRHhAzXR1pTxE42LwJjRxScMUjAp3QvZ8bGG8RxWRMVrndmx6taLSaQIq7RHuV2
	HpVv1JeeFG3IZRFXzlVnE+bV8LpNhUdpW0/lZ0sXh4PbU1+eiWHdoVH7O+j46Mn2
	Lfm65V0Kt9teddGOoaosYP1sgk4m8lBP5vM8qPcz6SGG1Ng1ZRCtDvmT3TMig/IX
	BMrkzDcFmcGGGoOfqQxNbjHg5v7UiXFa2xwv8L8wX7jNhpYW7mtg7YaE56dFRrXB
	Vw70Azd/iADULRLiols1ECEEGuK7rSc576XddsiEyKj7+/jHdv83sHeY/1oFzM38
	/OViUKfv7jfViBhKx8SwQ==
X-ME-Sender: <xms:81wiZ1BW-paEPpQbJy8FlkYMMHqBbW_1Hjk4N_b_SOS687pAY_4PCA>
    <xme:81wiZzi82GtVN48t9InDDor7qnx7fxFT_j3Apfy_yyriooi4liDkaKk9EEA-UU5uW
    v7D8iLgxJj1ABt3wew>
X-ME-Received: <xmr:81wiZwnMYq82dStsJSJhSRkCY7KvnPrzGtlUFAt0MOqk_a4sifxnDi0AOYRrzSuwDOfEJGc3GJCCkR5a2iYOtSAkG2e9hdXQ8lmazL52c48mnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertdertdej
    necuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdt
    uddtfeffueehleegleeiuefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkh
    ifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhguhiesghhr
    vgihhhhouhhsvgdrnhgvthdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:81wiZ_xhkJuCjGDhXQvh5XUv6yj2cSWGyH9GkYZ_7DgVxXbGyrZ8pg>
    <xmx:81wiZ6TkFQ0NyNKLhfQO6nKTsazeX5_Fg4vDC5K5C85_A8jOX9wu2A>
    <xmx:81wiZyZO1L0P0CmHfqszqGTVy6nGaws2tfDcwCwhwGUbGoEBU4s0Bw>
    <xmx:81wiZ7T7QAM5QSZCvsrI4XFfud3pLh6J9CzMqr_FMBOmleXC1L1yMA>
    <xmx:81wiZ_LnDikaZw59RVJjpQJebSPTQLjpMWqIUI-EgFtIqRKfESonx0hf>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 12:21:07 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 4ADCF1C0479; Wed, 30 Oct 2024 09:21:05 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 4A1251C0095;
	Wed, 30 Oct 2024 17:21:05 +0100 (CET)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: add ns target multicast address to slave device
In-reply-to: <20241023123215.5875-1-liuhangbin@gmail.com>
References: <20241023123215.5875-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 23 Oct 2024 12:32:15 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2024 17:21:05 +0100
Message-ID: <213367.1730305265@vermin>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Commit 4598380f9c54 ("bonding: fix ns validation on backup slaves")
>tried to resolve the issue where backup slaves couldn't be brought up when
>receiving IPv6 Neighbor Solicitation (NS) messages. However, this fix only
>worked for drivers that receive all multicast messages, such as the veth
>interface.
>
>For standard drivers, the NS multicast message is silently dropped because
>the slave device is not a member of the NS target multicast group.
>
>To address this, we need to make the slave device join the NS target
>multicast group, ensuring it can receive these IPv6 NS messages to validate
>the slave=E2=80=99s status properly.
>
>There are three policies before joining the multicast group:
>1. All settings must be under active-backup mode (alb and tlb do not suppo=
rt
>   arp_validate), with backup slaves and slaves supporting multicast.
>2. We can add or remove multicast groups when arp_validate changes.
>3. Other operations, such as enslaving, releasing, or setting NS targets,
>   need to be guarded by arp_validate.
>
>Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
>v2: only add/del mcast group on backup slaves when arp_validate is set (Ja=
y Vosburgh)

	Sorry for the delay in responding, I've been traveling.

	For the above, I suspect I wasn't sufficiently clear in my
commentary; what I meant wasn't just checking arp_validate being
enabled, but that the implementation could be much less complex if it
simply kept all of the multicast addresses added to the backup interface
(in addition to the active interface) when arp_validate is enabled.

	I suspect the set of multicast addresses involved is likely to
be small in the usual case, so the question then is whether the
presumably small amount of traffic that inadvertently passes the filter
(and is then thrown away by the kernel RX logic) is worth the complexity
added here.

	That said, I have a few questions below.

>    arp_validate doesn't support 3ad, tlb, alb. So let's only do it on ab =
mode.
>---
> drivers/net/bonding/bond_main.c    | 18 +++++-
> drivers/net/bonding/bond_options.c | 95 +++++++++++++++++++++++++++++-
> include/net/bond_options.h         |  1 +
> 3 files changed, 112 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>index b1bffd8e9a95..d7c1016619f9 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1008,6 +1008,9 @@ static void bond_hw_addr_swap(struct bonding *bond, =
struct slave *new_active,
>=20
> 		if (bond->dev->flags & IFF_UP)
> 			bond_hw_addr_flush(bond->dev, old_active->dev);
>+
>+		/* add target NS maddrs for backup slave */
>+		slave_set_ns_maddrs(bond, old_active, true);
> 	}
>=20
> 	if (new_active) {
>@@ -1024,6 +1027,9 @@ static void bond_hw_addr_swap(struct bonding *bond, =
struct slave *new_active,
> 			dev_mc_sync(new_active->dev, bond->dev);
> 			netif_addr_unlock_bh(bond->dev);
> 		}
>+
>+		/* clear target NS maddrs for active slave */
>+		slave_set_ns_maddrs(bond, new_active, false);
> 	}
> }
>=20
>@@ -2341,6 +2347,12 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 	bond_compute_features(bond);
> 	bond_set_carrier(bond);
>=20
>+	/* set target NS maddrs for new slave, need to be called before
>+	 * bond_select_active_slave(), which will remove the maddr if
>+	 * the slave is selected as active slave
>+	 */
>+	slave_set_ns_maddrs(bond, new_slave, true);
>+
> 	if (bond_uses_primary(bond)) {
> 		block_netpoll_tx();
> 		bond_select_active_slave(bond);
>@@ -2350,7 +2362,6 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev,
> 	if (bond_mode_can_use_xmit_hash(bond))
> 		bond_update_slave_arr(bond, NULL);
>=20
>-
> 	if (!slave_dev->netdev_ops->ndo_bpf ||
> 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
> 		if (bond->xdp_prog) {
>@@ -2548,6 +2559,11 @@ static int __bond_release_one(struct net_device *bo=
nd_dev,
> 	if (oldcurrent =3D=3D slave)
> 		bond_change_active_slave(bond, NULL);
>=20
>+	/* clear target NS maddrs, must after bond_change_active_slave()
>+	 * as we need to clear the maddrs on backup slave
>+	 */
>+	slave_set_ns_maddrs(bond, slave, false);
>+
> 	if (bond_is_lb(bond)) {
> 		/* Must be called only after the slave has been
> 		 * detached from the list and the curr_active_slave
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond=
_options.c
>index 95d59a18c022..2554ba70f092 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1234,6 +1234,75 @@ static int bond_option_arp_ip_targets_set(struct bo=
nding *bond,
> }
>=20
> #if IS_ENABLED(CONFIG_IPV6)
>+/* convert IPv6 address to link-local solicited-node multicast mac addres=
s */
>+static void ipv6_addr_to_solicited_mac(const struct in6_addr *addr,
>+				       unsigned char mac[ETH_ALEN])
>+{
>+	mac[0] =3D 0x33;
>+	mac[1] =3D 0x33;
>+	mac[2] =3D 0xFF;
>+	mac[3] =3D addr->s6_addr[13];
>+	mac[4] =3D addr->s6_addr[14];
>+	mac[5] =3D addr->s6_addr[15];
>+}

	Can we make use of ndisc_mc_map() / ipv6_eth_mc_map() to perform
this step, instead of creating a new function that's almost the same?

>+
>+static bool slave_can_set_ns_maddr(struct bonding *bond, struct slave *sl=
ave)
>+{
>+	return BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>+	       !bond_is_active_slave(slave) &&
>+	       slave->dev->flags & IFF_MULTICAST;
>+}
>+
>+static void _slave_set_ns_maddrs(struct bonding *bond, struct slave *slav=
e, bool add)
>+{
>+	struct in6_addr *targets =3D bond->params.ns_targets;
>+	unsigned char slot_maddr[ETH_ALEN];
>+	int i;
>+
>+	if (!slave_can_set_ns_maddr(bond, slave))
>+		return;
>+
>+	for (i =3D 0; i < BOND_MAX_NS_TARGETS; i++) {
>+		if (ipv6_addr_any(&targets[i]))
>+			break;
>+
>+		ipv6_addr_to_solicited_mac(&targets[i], slot_maddr);
>+		if (add)
>+			dev_mc_add(slave->dev, slot_maddr);
>+		else
>+			dev_mc_del(slave->dev, slot_maddr);
>+	}
>+}
>+
>+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool =
add)
>+{
>+	if (!bond->params.arp_validate)
>+		return;
>+
>+	_slave_set_ns_maddrs(bond, slave, add);
>+}

	Why does this need a wrapper function vs. having the
arp_validate test be first in the larger function?

	-J

>+
>+static void slave_set_ns_maddr(struct bonding *bond, struct slave *slave,
>+			       struct in6_addr *target, struct in6_addr *slot)
>+{
>+	unsigned char target_maddr[ETH_ALEN], slot_maddr[ETH_ALEN];
>+
>+	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
>+		return;
>+
>+	/* remove the previous maddr on salve */
>+	if (!ipv6_addr_any(slot)) {
>+		ipv6_addr_to_solicited_mac(slot, slot_maddr);
>+		dev_mc_del(slave->dev, slot_maddr);
>+	}
>+
>+	/* add new maddr on slave if target is set */
>+	if (!ipv6_addr_any(target)) {
>+		ipv6_addr_to_solicited_mac(target, target_maddr);
>+		dev_mc_add(slave->dev, target_maddr);
>+	}
>+}
>+
> static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slo=
t,
> 					    struct in6_addr *target,
> 					    unsigned long last_rx)
>@@ -1243,8 +1312,10 @@ static void _bond_options_ns_ip6_target_set(struct =
bonding *bond, int slot,
> 	struct slave *slave;
>=20
> 	if (slot >=3D 0 && slot < BOND_MAX_NS_TARGETS) {
>-		bond_for_each_slave(bond, slave, iter)
>+		bond_for_each_slave(bond, slave, iter) {
> 			slave->target_last_arp_rx[slot] =3D last_rx;
>+			slave_set_ns_maddr(bond, slave, target, &targets[slot]);
>+		}
> 		targets[slot] =3D *target;
> 	}
> }
>@@ -1296,15 +1367,37 @@ static int bond_option_ns_ip6_targets_set(struct b=
onding *bond,
> {
> 	return -EPERM;
> }
>+
>+static void _slave_set_ns_maddrs(struct bonding *bond, struct slave *slav=
e, bool add)
>+{
>+}
>+
>+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool =
add)
>+{
>+}
> #endif
>=20
> static int bond_option_arp_validate_set(struct bonding *bond,
> 					const struct bond_opt_value *newval)
> {
>+	bool changed =3D (bond->params.arp_validate =3D=3D 0 && newval->value !=
=3D 0) ||
>+		       (bond->params.arp_validate !=3D 0 && newval->value =3D=3D 0);
>+	struct list_head *iter;
>+	struct slave *slave;
>+
> 	netdev_dbg(bond->dev, "Setting arp_validate to %s (%llu)\n",
> 		   newval->string, newval->value);
> 	bond->params.arp_validate =3D newval->value;
>=20
>+	if (changed) {
>+		bond_for_each_slave(bond, slave, iter) {
>+			if (bond->params.arp_validate)
>+				_slave_set_ns_maddrs(bond, slave, true);
>+			else
>+				_slave_set_ns_maddrs(bond, slave, false);
>+		}
>+	}
>+
> 	return 0;
> }
>=20
>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index 473a0147769e..59a91d12cd57 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -161,5 +161,6 @@ void bond_option_arp_ip_targets_clear(struct bonding *=
bond);
> #if IS_ENABLED(CONFIG_IPV6)
> void bond_option_ns_ip6_targets_clear(struct bonding *bond);
> #endif
>+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool =
add);
>=20
> #endif /* _NET_BOND_OPTIONS_H */
>--=20
>2.46.0

---
	-Jay Vosburgh, jv@jvosburgh.net

