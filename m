Return-Path: <netdev+bounces-198277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CAEADBBF0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F671883CAF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D0218592;
	Mon, 16 Jun 2025 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="uRRAQTST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mpR9Fn93"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE88218599;
	Mon, 16 Jun 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109344; cv=none; b=Qqwd4KDApHjs721Do9Jj9lNVGuDVjJK6IjpybrplTqaxtFjcmlSI5oTSuWg3rwjYdR3sJweMGJ6b7dlXPEpwbs4ncIxM9pWF4jovi4VVP2vI9yDTtMf4BKKoRrIAPZsl3a8mFCJhjYVni/nUoKyeHCV3xnM25SpYlVtz1lB7VOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109344; c=relaxed/simple;
	bh=VGg1TsN3mfM+IWSHl51boEjCVoanSbODzDP6bzjB5Q4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=mm3LcV9bagzJswGi1400TUb/NPCxguuifN2TqoUwNCax7nsCBvN6Q0Z9Pptt1w0KTcHgNrqb81ZG9a+VmpaeX2KMKi/Kf7yzBKeugX9rB224+U6WKXprKDiessVo+YrDjq09/bHNYS90Grly+jcpO7Pk37/ZsZj5Qy/YIyj8ytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=uRRAQTST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mpR9Fn93; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D679311400F0;
	Mon, 16 Jun 2025 17:28:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Jun 2025 17:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm3; t=
	1750109338; x=1750195738; bh=mdU8RAyqh2SFOIUCpZcd425QI97BAbrtoWp
	EpDLU6lk=; b=uRRAQTSTOm7dROC0WKpCYT2x2ZODv/sapNQr69lofJ5bl01kuAM
	FoAZnfWJ1tieLVX1bE8vCiNMzQhzg4ZuAR/OqrYibXx6RRwNsQrjosHhRdSaBIfd
	j4fuc4vODhRUntJ+FO+QTn9SsLYajo1++1pqQWdyJCMjwiiQb7Fyfyym7Hzjyaw1
	6QQlSE7nllvxB1mnr17/r0DCgZpCiiJesrDCFxNCMo9FFmQrcL0k0yehIYto67pq
	kDr7VWextA//cYgbeTwLvsIo6m0peWOT6VpqZFq/+emhu68UAjp2sfnHDOUJmnK0
	V+jEvWXH097VM5swx/q3satOaV3fHbtVhvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750109338; x=
	1750195738; bh=mdU8RAyqh2SFOIUCpZcd425QI97BAbrtoWpEpDLU6lk=; b=m
	pR9Fn93KpLm3E9cX2l1AIbZSuQvliZ+h/jnqeczgvZkdH3g1IYXlRDU4aoGw/Cs6
	nszlDQq3hqRlRS9mfOfZjwfdgaVUNEWyKPrgeTdimIWiigVptKZW6WgVquoALEad
	8gLGEQay0LtC+EO6fqx7ic9zV1ZyXtoR3QUmU3xpF5tIPoOK7vwV/hCYOswemP1b
	e7NFs+zK+J97h6W9pnI5k8Tra0NgbG22dm1MIUv7tA7Z7h7mJtn1ilItHZnFcqww
	F0D7OGKRE84xHD2ZQbB8CF59Med6mFcsxf+Od/v6hJ8Nhvd8qB+UV5gGEPZaODer
	PNdkgP1crTj0mKiyKh+lw==
X-ME-Sender: <xms:mYxQaNskXyR3bkvB0MCO5O-s6vjmNwyd9yjf6LQ5u8JtwiK5NnUgJA>
    <xme:mYxQaGePeSOjRX5egaYcW6NZPNuZZnIMZGacpTj1-3uxf11jvFDPPZ1zFpFQlXe6w
    Dvd6So-pTUvOi4pMx4>
X-ME-Received: <xmr:mYxQaAzx7M2Jel9JAnH7JTbldVzkY_gKeNzrSy_-IXdlwBR1qyJy3rDXLc5xUgLau5Z9Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevuffogggtgfffkfesthhqredtredtvden
    ucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvg
    htqeenucggtffrrghtthgvrhhnpeefgeevtdeggfeiuedthefhleeivdduhfetheefffek
    hedvheelveduvdeuuedtheenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsph
    hothdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprh
    gtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmh
    gvpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhsse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhope
    gtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprggsvghnihesrhgvughhrght
    rdgtohhm
X-ME-Proxy: <xmx:moxQaEPWZnLzG9CqazZNXiZfa3oLxDd6vYEhfCWr1BVc2_xUNaRXiQ>
    <xmx:moxQaN8wUfbtoXglAlA5TOlMlPQmEz1wjaZcAVRxSh6EvZTyMP0Z0g>
    <xmx:moxQaEXF9MLGbcv3oD1yrgYdVqkerIJJqPHcP6JT4IEq5NYsHx6G7g>
    <xmx:moxQaOeNrQ9c9bwisBkfaGgeOdn7t6ZY7S1IJeKsXihaO3ZlQWkrBw>
    <xmx:moxQaOCk9d3V_3APJhOx3foW1YvypsuZXgaKOmtSHanw73BmcWBP-mB->
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 17:28:57 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 44EEB9FCA5; Mon, 16 Jun 2025 14:28:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 418579FC7E;
	Mon, 16 Jun 2025 14:28:56 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Hangbin Liu <liuhangbin@gmail.com>, linux-doc@vger.kernel.org
Subject: [PATCH net-next] bonding: Remove support for use_carrier = 0
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1922516.1750109336.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 14:28:56 -0700
Message-ID: <1922517.1750109336@famine>

	 Remove the ability to disable use_carrier in bonding, and remove
all code related to the old link state check that utilizes ethtool or
ioctl to determine the link state of an interface in a bond.

	To avoid acquiring RTNL many times per second, bonding's miimon
link monitor inspects link state under RCU, but not under RTNL.  However,
ethtool implementations in drivers may sleep, and therefore the ethtool or
ioctl strategy is unsuitable for use with calls into driver ethtool
functions.

	The use_carrier option was introduced in 2003, to provide
backwards compatibility for network device drivers that did not support
the then-new netif_carrier_ok/on/off system.  Today, device drivers are
expected to support netif_carrier_*, and the use_carrier backwards
compatibility logic is no longer necessary.

	Bonding now always behaves as if use_carrier=3D1, which relies on
netif_carrier_ok() to determine the link state of interfaces.  This has
been the default setting for use_carrier since its introduction.  For
backwards compatibility, the option itself remains, but may only be set to
1, and queries will always return 1.

Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Db8c48ea38ca27d150063
Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com=
/
Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9d=
ed97163aef4e4de10985cd8f7de60d28@changeid/
Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

---
 Documentation/networking/bonding.rst |  79 +++----------------
 drivers/net/bonding/bond_main.c      | 113 ++-------------------------
 drivers/net/bonding/bond_netlink.c   |  11 +--
 drivers/net/bonding/bond_options.c   |   7 +-
 drivers/net/bonding/bond_sysfs.c     |   6 +-
 include/net/bonding.h                |   1 -
 6 files changed, 25 insertions(+), 192 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networki=
ng/bonding.rst
index a4c1291d2561..4ee20f6ab733 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -576,10 +576,8 @@ miimon
 	This determines how often the link state of each slave is
 	inspected for link failures.  A value of zero disables MII
 	link monitoring.  A value of 100 is a good starting point.
-	The use_carrier option, below, affects how the link state is
-	determined.  See the High Availability section for additional
-	information.  The default value is 100 if arp_interval is not
-	set.
+
+	The default value is 100 if arp_interval is not set.
 =

 min_links
 =

@@ -889,25 +887,14 @@ updelay
 =

 use_carrier
 =

-	Specifies whether or not miimon should use MII or ETHTOOL
-	ioctls vs. netif_carrier_ok() to determine the link
-	status. The MII or ETHTOOL ioctls are less efficient and
-	utilize a deprecated calling sequence within the kernel.  The
-	netif_carrier_ok() relies on the device driver to maintain its
-	state with netif_carrier_on/off; at this writing, most, but
-	not all, device drivers support this facility.
-
-	If bonding insists that the link is up when it should not be,
-	it may be that your network device driver does not support
-	netif_carrier_on/off.  The default state for netif_carrier is
-	"carrier on," so if a driver does not support netif_carrier,
-	it will appear as if the link is always up.  In this case,
-	setting use_carrier to 0 will cause bonding to revert to the
-	MII / ETHTOOL ioctl method to determine the link state.
-
-	A value of 1 enables the use of netif_carrier_ok(), a value of
-	0 will use the deprecated MII / ETHTOOL ioctls.  The default
-	value is 1.
+	Obsolete option that previously selected between MII /
+	ETHTOOL ioctls and netif_carrier_ok() to determine link
+	state.
+
+	All link state checks are now done with netif_carrier_ok().
+
+	For backwards compatibility, this option's value may be inspected
+	or set.  The only valid setting is 1.
 =

 xmit_hash_policy
 =

@@ -2029,22 +2016,8 @@ depending upon the device driver to maintain its ca=
rrier state, by
 querying the device's MII registers, or by making an ethtool query to
 the device.
 =

-If the use_carrier module parameter is 1 (the default value),
-then the MII monitor will rely on the driver for carrier state
-information (via the netif_carrier subsystem).  As explained in the
-use_carrier parameter information, above, if the MII monitor fails to
-detect carrier loss on the device (e.g., when the cable is physically
-disconnected), it may be that the driver does not support
-netif_carrier.
-
-If use_carrier is 0, then the MII monitor will first query the
-device's (via ioctl) MII registers and check the link state.  If that
-request fails (not just that it returns carrier down), then the MII
-monitor will make an ethtool ETHTOOL_GLINK request to attempt to obtain
-the same information.  If both methods fail (i.e., the driver either
-does not support or had some error in processing both the MII register
-and ethtool requests), then the MII monitor will assume the link is
-up.
+The MII monitor relies on the driver for carrier state information (via
+the netif_carrier subsystem).
 =

 8. Potential Sources of Trouble
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
@@ -2128,34 +2101,6 @@ This will load tg3 and e1000 modules before loading=
 the bonding one.
 Full documentation on this can be found in the modprobe.d and modprobe
 manual pages.
 =

-8.3. Painfully Slow Or No Failed Link Detection By Miimon
----------------------------------------------------------
-
-By default, bonding enables the use_carrier option, which
-instructs bonding to trust the driver to maintain carrier state.
-
-As discussed in the options section, above, some drivers do
-not support the netif_carrier_on/_off link state tracking system.
-With use_carrier enabled, bonding will always see these links as up,
-regardless of their actual state.
-
-Additionally, other drivers do support netif_carrier, but do
-not maintain it in real time, e.g., only polling the link state at
-some fixed interval.  In this case, miimon will detect failures, but
-only after some long period of time has expired.  If it appears that
-miimon is very slow in detecting link failures, try specifying
-use_carrier=3D0 to see if that improves the failure detection time.  If
-it does, then it may be that the driver checks the carrier state at a
-fixed interval, but does not cache the MII register values (so the
-use_carrier=3D0 method of querying the registers directly works).  If
-use_carrier=3D0 does not improve the failover, then the driver may cache
-the registers, or the problem may be elsewhere.
-
-Also, remember that miimon only checks for the device's
-carrier state.  It has no way to determine the state of devices on or
-beyond other ports of a switch, or if a switch is refusing to pass
-traffic while still maintaining carrier on.
-
 9. SNMP agents
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
index c4d53e8e7c15..3534561fd932 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -142,8 +142,7 @@ module_param(downdelay, int, 0);
 MODULE_PARM_DESC(downdelay, "Delay before considering link down, "
 			    "in milliseconds");
 module_param(use_carrier, int, 0);
-MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in mi=
imon; "
-			      "0 for off, 1 for on (default)");
+MODULE_PARM_DESC(use_carrier, "Obsolete, has no effect");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Mode of operation; 0 for balance-rr, "
 		       "1 for active-backup, 2 for balance-xor, "
@@ -828,77 +827,6 @@ const char *bond_slave_link_status(s8 link)
 	}
 }
 =

-/* if <dev> supports MII link status reporting, check its link status.
- *
- * We either do MII/ETHTOOL ioctls, or check netif_carrier_ok(),
- * depending upon the setting of the use_carrier parameter.
- *
- * Return either BMSR_LSTATUS, meaning that the link is up (or we
- * can't tell and just pretend it is), or 0, meaning that the link is
- * down.
- *
- * If reporting is non-zero, instead of faking link up, return -1 if
- * both ETHTOOL and MII ioctls fail (meaning the device does not
- * support them).  If use_carrier is set, return whatever it says.
- * It'd be nice if there was a good way to tell if a driver supports
- * netif_carrier, but there really isn't.
- */
-static int bond_check_dev_link(struct bonding *bond,
-			       struct net_device *slave_dev, int reporting)
-{
-	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
-	struct mii_ioctl_data *mii;
-	struct ifreq ifr;
-	int ret;
-
-	if (!reporting && !netif_running(slave_dev))
-		return 0;
-
-	if (bond->params.use_carrier)
-		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
-
-	/* Try to get link status using Ethtool first. */
-	if (slave_dev->ethtool_ops->get_link) {
-		netdev_lock_ops(slave_dev);
-		ret =3D slave_dev->ethtool_ops->get_link(slave_dev);
-		netdev_unlock_ops(slave_dev);
-
-		return ret ? BMSR_LSTATUS : 0;
-	}
-
-	/* Ethtool can't be used, fallback to MII ioctls. */
-	if (slave_ops->ndo_eth_ioctl) {
-		/* TODO: set pointer to correct ioctl on a per team member
-		 *       bases to make this more efficient. that is, once
-		 *       we determine the correct ioctl, we will always
-		 *       call it and not the others for that team
-		 *       member.
-		 */
-
-		/* We cannot assume that SIOCGMIIPHY will also read a
-		 * register; not all network drivers (e.g., e100)
-		 * support that.
-		 */
-
-		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
-		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
-		mii =3D if_mii(&ifr);
-
-		if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIPHY) =3D=3D 0) {
-			mii->reg_num =3D MII_BMSR;
-			if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIREG) =3D=3D 0)
-				return mii->val_out & BMSR_LSTATUS;
-		}
-	}
-
-	/* If reporting, report that either there's no ndo_eth_ioctl,
-	 * or both SIOCGMIIREG and get_link failed (meaning that we
-	 * cannot report link status).  If not reporting, pretend
-	 * we're ok.
-	 */
-	return reporting ? -1 : BMSR_LSTATUS;
-}
-
 /*----------------------------- Multicast list --------------------------=
----*/
 =

 /* Push the promiscuity flag down to appropriate slaves */
@@ -1949,7 +1877,6 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev,
 	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
 	struct slave *new_slave =3D NULL, *prev_slave;
 	struct sockaddr_storage ss;
-	int link_reporting;
 	int res =3D 0, i;
 =

 	if (slave_dev->flags & IFF_MASTER &&
@@ -1959,12 +1886,6 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
 		return -EPERM;
 	}
 =

-	if (!bond->params.use_carrier &&
-	    slave_dev->ethtool_ops->get_link =3D=3D NULL &&
-	    slave_ops->ndo_eth_ioctl =3D=3D NULL) {
-		slave_warn(bond_dev, slave_dev, "no link monitoring support\n");
-	}
-
 	/* already in-use? */
 	if (netdev_is_rx_handler_busy(slave_dev)) {
 		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
@@ -2178,29 +2099,10 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
 =

 	new_slave->last_tx =3D new_slave->last_rx;
 =

-	if (bond->params.miimon && !bond->params.use_carrier) {
-		link_reporting =3D bond_check_dev_link(bond, slave_dev, 1);
-
-		if ((link_reporting =3D=3D -1) && !bond->params.arp_interval) {
-			/* miimon is set but a bonded network driver
-			 * does not support ETHTOOL/MII and
-			 * arp_interval is not set.  Note: if
-			 * use_carrier is enabled, we will never go
-			 * here (because netif_carrier is always
-			 * supported); thus, we don't need to change
-			 * the messages for netif_carrier.
-			 */
-			slave_warn(bond_dev, slave_dev, "MII and ETHTOOL support not available=
 for slave, and arp_interval/arp_ip_target module parameters not specified=
, thus bonding will not detect link failures! see bonding.txt for details\=
n");
-		} else if (link_reporting =3D=3D -1) {
-			/* unable get link status using mii/ethtool */
-			slave_warn(bond_dev, slave_dev, "can't get link status from slave; the=
 network driver associated with this interface does not support MII or ETH=
TOOL link status reporting, thus miimon has no effect on this interface\n"=
);
-		}
-	}
-
 	/* check for initial state */
 	new_slave->link =3D BOND_LINK_NOCHANGE;
 	if (bond->params.miimon) {
-		if (bond_check_dev_link(bond, slave_dev, 0) =3D=3D BMSR_LSTATUS) {
+		if (netif_carrier_ok(slave_dev)) {
 			if (bond->params.updelay) {
 				bond_set_slave_link_state(new_slave,
 							  BOND_LINK_BACK,
@@ -2742,7 +2644,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 =

-		link_state =3D bond_check_dev_link(bond, slave->dev, 0);
+		link_state =3D netif_carrier_ok(slave->dev);
 =

 		switch (slave->link) {
 		case BOND_LINK_UP:
@@ -6189,10 +6091,10 @@ static int __init bond_check_params(struct bond_pa=
rams *params)
 		downdelay =3D 0;
 	}
 =

-	if ((use_carrier !=3D 0) && (use_carrier !=3D 1)) {
-		pr_warn("Warning: use_carrier module parameter (%d), not of valid value=
 (0/1), so it was set to 1\n",
-			use_carrier);
-		use_carrier =3D 1;
+	if (use_carrier !=3D 1) {
+		pr_err("Error: invalid use_carrier parameter (%d)\n",
+		       use_carrier);
+		return -EINVAL;
 	}
 =

 	if (num_peer_notif < 0 || num_peer_notif > 255) {
@@ -6439,7 +6341,6 @@ static int __init bond_check_params(struct bond_para=
ms *params)
 	params->updelay =3D updelay;
 	params->downdelay =3D downdelay;
 	params->peer_notif_delay =3D 0;
-	params->use_carrier =3D use_carrier;
 	params->lacp_active =3D 1;
 	params->lacp_fast =3D lacp_fast;
 	params->primary[0] =3D 0;
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond=
_netlink.c
index ac5e402c34bc..98f9bef61474 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -258,13 +258,8 @@ static int bond_changelink(struct net_device *bond_de=
v, struct nlattr *tb[],
 			return err;
 	}
 	if (data[IFLA_BOND_USE_CARRIER]) {
-		int use_carrier =3D nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
-
-		bond_opt_initval(&newval, use_carrier);
-		err =3D __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
-				     data[IFLA_BOND_USE_CARRIER], extack);
-		if (err)
-			return err;
+		if (nla_get_u8(data[IFLA_BOND_USE_CARRIER]) !=3D 1)
+			return -EINVAL;
 	}
 	if (data[IFLA_BOND_ARP_INTERVAL]) {
 		int arp_interval =3D nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
@@ -676,7 +671,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			bond->params.peer_notif_delay * bond->params.miimon))
 		goto nla_put_failure;
 =

-	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
+	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
 		goto nla_put_failure;
 =

 	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond=
_options.c
index 91893c29b899..98dbee2b6aba 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -185,7 +185,6 @@ static const struct bond_opt_value bond_primary_resele=
ct_tbl[] =3D {
 };
 =

 static const struct bond_opt_value bond_use_carrier_tbl[] =3D {
-	{ "off", 0,  0},
 	{ "on",  1,  BOND_VALFLAG_DEFAULT},
 	{ NULL,  -1, 0}
 };
@@ -411,7 +410,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAS=
T] =3D {
 	[BOND_OPT_USE_CARRIER] =3D {
 		.id =3D BOND_OPT_USE_CARRIER,
 		.name =3D "use_carrier",
-		.desc =3D "Use netif_carrier_ok (vs MII ioctls) in miimon",
+		.desc =3D "Obsolete, has no effect",
 		.values =3D bond_use_carrier_tbl,
 		.set =3D bond_option_use_carrier_set
 	},
@@ -1068,10 +1067,6 @@ static int bond_option_peer_notif_delay_set(struct =
bonding *bond,
 static int bond_option_use_carrier_set(struct bonding *bond,
 				       const struct bond_opt_value *newval)
 {
-	netdev_dbg(bond->dev, "Setting use_carrier to %llu\n",
-		   newval->value);
-	bond->params.use_carrier =3D newval->value;
-
 	return 0;
 }
 =

diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_s=
ysfs.c
index 1e13bb170515..9a75ad3181ab 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -467,14 +467,12 @@ static ssize_t bonding_show_primary_reselect(struct =
device *d,
 static DEVICE_ATTR(primary_reselect, 0644,
 		   bonding_show_primary_reselect, bonding_sysfs_store_option);
 =

-/* Show the use_carrier flag. */
+/* use_carrier is obsolete, but print value for compatibility */
 static ssize_t bonding_show_carrier(struct device *d,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct bonding *bond =3D to_bond(d);
-
-	return sysfs_emit(buf, "%d\n", bond->params.use_carrier);
+	return sysfs_emit(buf, "1\n");
 }
 static DEVICE_ATTR(use_carrier, 0644,
 		   bonding_show_carrier, bonding_sysfs_store_option);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..6fdf4d1e5256 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -124,7 +124,6 @@ struct bond_params {
 	int arp_interval;
 	int arp_validate;
 	int arp_all_targets;
-	int use_carrier;
 	int fail_over_mac;
 	int updelay;
 	int downdelay;
-- =

2.25.1


