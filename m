Return-Path: <netdev+bounces-137565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D86C9A6F0A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E961C2030F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4D1CFEC1;
	Mon, 21 Oct 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="vxQ5XsXo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8uPGvKK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5F1CBEA1;
	Mon, 21 Oct 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526719; cv=none; b=ZmwJ2LnzD/Y9hHfIZCnhVbTjRvUTJQsOWYqZxLMm3WPPAsaax6oAmccGyjQU5NpaIfR+F6TntMKgOWdDz5oU7g13HjtnW0jepXmcegmMYsW/dPWVsCCXbKGUURHxZrQoPes+Uuy2TkTt9mY18yzje25177slokYjpH2KGbd+hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526719; c=relaxed/simple;
	bh=bwYkQ3sWDCi32JQEcQ6eLwG1gLM9hPV5hAJeIZmKDcE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=uSBpsS2ZkeG926KvE9TukR5bz6ACJfviaH8m2q+RoDD9zBjgs0LlyMjrXzLbHt2WiGkzH1S+c1rzABoSZkqsvu7hQc3MAp4icMGTUCh8qxDqhCC3r7fz8lCfWyMwnmzuTEDZhIph2xJOFqfgQdyP+P53GCR0RWFspOJuPILh52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=vxQ5XsXo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8uPGvKK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AF1A11400C8;
	Mon, 21 Oct 2024 12:05:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 12:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1729526715; x=1729613115; bh=+BVtPjQ3pduOT1KYrMmhkoLb12zHyfqI
	06iQvVn/JV4=; b=vxQ5XsXo5BQQPOpRDIcpPBEfW8yeOboeRW4tHiJZqYoJAOy4
	zDGGmbOC5wAmK1W7QlXz5PTgGTVjq51O9UuTK+wEF5Tm1iymSJKKo7pDndlA+TN4
	YXPcGVtT3bnkADERD5hTQYhFu25WnB+y1Wkg8fvRI4fUn2RandHQev4pDvH1JABT
	iTZL/gR2iwB8JX1mkSyfSqGgZnPXANnVaIvjV0FQEbZeESZjWEprV5xdlfn51tck
	AgFYk+rseMFyqXEmXm6+Z1ypj4ZGjg4bGKK+fW8gMQfvIytpgpsDGPDZZyxUp1kd
	sMYI1XwJCrgnkBgYRsXuRE8yn+t+4Xg1MrKmvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729526715; x=
	1729613115; bh=+BVtPjQ3pduOT1KYrMmhkoLb12zHyfqI06iQvVn/JV4=; b=F
	8uPGvKKy7SyE8HfcJ688Fa126xdBhq+jNNgCuShBg83Y7Dyl7T5vKyoeTfkBm2VT
	Cdn1trxVr0W1LVycuzD9Km4XHSRBAMELguXTH5/il7OQB8LtGwfSOJQE9PPazGcR
	/hNyOclP17uxtkEPGy7G+goS/oVvUCnUJLvQzl3B/itnF3VpRjWUgBz7Fdgtwtlf
	hWafKWtQ/bpDR+9HK9Rfdao6UhVSdhTYQrAabBEOrhHcRyuxqHdeoUiwI1u4XHd5
	iTbNB366KEGeb9dsslh3dSNq/6YV7I4SWXX+vaQc56OTMuZScP743k7yNsHg2E5O
	ytvgiYl4YzfhBjdq7ryqg==
X-ME-Sender: <xms:unsWZ-1Umi3dWC0GTA0i7W3RqJk7ASsOdVco1Qvq70RjJKNwFQMwGg>
    <xme:unsWZxEzdSvV6_CoxCUlckmIOxsZZs4JsghiwqQrhNxVpP4mFuga5ovwS5zgBBYwN
    j7UrwFLm9OSKVVbBiQ>
X-ME-Received: <xmr:unsWZ25c1JUKY-CPn6kh-zvB7f_TIjpiJbbhFvohffiD09CZ8DovVpKGtDm3iNugurryo-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgleejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:u3sWZ_2awXR6lRVDtC07vkDFoJ4bFdsjg46IgCMemdfYPVpN4TpGHA>
    <xmx:u3sWZxEQLiuh127m3nc0Df0HllU2xVQbFUKFYgKQwtYuLxzi73yyYQ>
    <xmx:u3sWZ4-5ntMsNQMcEvfHIAKa7WLbPsJqlaCMWnlFy7oORPGCUppSRA>
    <xmx:u3sWZ2kNvTkl4FML3z2Rsy1x68Aq8SCz2jdGgJRBOWSL98tYDCduLg>
    <xmx:u3sWZ5_I7IrhMKwyk91mcB23WCZoW6_cUtI1X2iRLFFkAcHbeIrMb4qT>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 12:05:14 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 7173C1C0461; Mon, 21 Oct 2024 09:05:11 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 70B2E1C00DD;
	Mon, 21 Oct 2024 18:05:11 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: add ns target multicast address to slave device
In-reply-to: <20241021083052.2865-1-liuhangbin@gmail.com>
References: <20241021083052.2865-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 21 Oct 2024 08:30:52 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2024 18:05:11 +0200
Message-ID: <58777.1729526711@vermin>

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
>Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

	This seems fairly involved; would it be simpler to have
bond_hw_addr_swap() and/or bond_change_active_slave() insure that the
MAC multicast list is configured in the backup interface if arp_validate
is set appropriately and there's a NS target configured?  That will make
the MAC multicast list more inclusive than necessary, but I think the
implementation will be much less involved.

	-J

>---
>Another way is to set IFF_ALLMULTI flag for slaves. But I think that
>would affect too much.
>---
> drivers/net/bonding/bond_main.c    | 11 ++++++++
> drivers/net/bonding/bond_options.c | 44 +++++++++++++++++++++++++++++-
> include/net/bond_options.h         |  2 ++
> 3 files changed, 56 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>index b1bffd8e9a95..04ccbd41fb0c 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2350,6 +2350,11 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 	if (bond_mode_can_use_xmit_hash(bond))
> 		bond_update_slave_arr(bond, NULL);
>=20
>+#if IS_ENABLED(CONFIG_IPV6)
>+	if (slave_dev->flags & IFF_MULTICAST)
>+		/* set target NS maddrs for new slave */
>+		slave_set_ns_maddr(bond, slave_dev, true);
>+#endif
>=20
> 	if (!slave_dev->netdev_ops->ndo_bpf ||
> 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
>@@ -2503,6 +2508,12 @@ static int __bond_release_one(struct net_device *bo=
nd_dev,
> 	/* recompute stats just before removing the slave */
> 	bond_get_stats(bond->dev, &bond->bond_stats);
>=20
>+#if IS_ENABLED(CONFIG_IPV6)
>+	if (slave_dev->flags & IFF_MULTICAST)
>+		/* clear all target NS maddrs */
>+		slave_set_ns_maddr(bond, slave_dev, false);
>+#endif
>+
> 	if (bond->xdp_prog) {
> 		struct netdev_bpf xdp =3D {
> 			.command =3D XDP_SETUP_PROG,
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond=
_options.c
>index 95d59a18c022..823cb93d2853 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1234,17 +1234,41 @@ static int bond_option_arp_ip_targets_set(struct b=
onding *bond,
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
>+
> static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slo=
t,
> 					    struct in6_addr *target,
> 					    unsigned long last_rx)
> {
>+	unsigned char target_maddr[ETH_ALEN], slot_maddr[ETH_ALEN];
> 	struct in6_addr *targets =3D bond->params.ns_targets;
> 	struct list_head *iter;
> 	struct slave *slave;
>=20
>+	if (!ipv6_addr_any(target))
>+		ipv6_addr_to_solicited_mac(target, target_maddr);
> 	if (slot >=3D 0 && slot < BOND_MAX_NS_TARGETS) {
>-		bond_for_each_slave(bond, slave, iter)
>+		if (!ipv6_addr_any(&targets[slot]))
>+			ipv6_addr_to_solicited_mac(&targets[slot], slot_maddr);
>+		bond_for_each_slave(bond, slave, iter) {
> 			slave->target_last_arp_rx[slot] =3D last_rx;
>+			/* remove the previous maddr on salve */
>+			if (!ipv6_addr_any(&targets[slot]))
>+				dev_mc_del(slave->dev, slot_maddr);
>+			/* add new maddr on slave if target is set */
>+			if (!ipv6_addr_any(target))
>+				dev_mc_add(slave->dev, target_maddr);
>+		}
> 		targets[slot] =3D *target;
> 	}
> }
>@@ -1290,6 +1314,24 @@ static int bond_option_ns_ip6_targets_set(struct bo=
nding *bond,
>=20
> 	return 0;
> }
>+
>+void slave_set_ns_maddr(struct bonding *bond, struct net_device *slave_de=
v,
>+			bool add)
>+{
>+	struct in6_addr *targets =3D bond->params.ns_targets;
>+	unsigned char slot_maddr[ETH_ALEN];
>+	int i;
>+
>+	for (i =3D 0; i < BOND_MAX_NS_TARGETS; i++) {
>+		if (!ipv6_addr_any(&targets[i])) {
>+			ipv6_addr_to_solicited_mac(&targets[i], slot_maddr);
>+			if (add)
>+				dev_mc_add(slave_dev, slot_maddr);
>+			else
>+				dev_mc_del(slave_dev, slot_maddr);
>+		}
>+	}
>+}
> #else
> static int bond_option_ns_ip6_targets_set(struct bonding *bond,
> 					  const struct bond_opt_value *newval)
>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index 473a0147769e..c6c5c1333f37 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -160,6 +160,8 @@ static inline void __bond_opt_init(struct bond_opt_val=
ue *optval,
> void bond_option_arp_ip_targets_clear(struct bonding *bond);
> #if IS_ENABLED(CONFIG_IPV6)
> void bond_option_ns_ip6_targets_clear(struct bonding *bond);
>+void slave_set_ns_maddr(struct bonding *bond, struct net_device *slave_de=
v,
>+			bool add);
> #endif
>=20
> #endif /* _NET_BOND_OPTIONS_H */
>--=20
>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

