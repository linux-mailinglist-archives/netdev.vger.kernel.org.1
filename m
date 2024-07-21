Return-Path: <netdev+bounces-112330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D78D93858F
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6801F2111E
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD01662E8;
	Sun, 21 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="jP6ynSIq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIv7s26J"
X-Original-To: netdev@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78614F9F9
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721581679; cv=none; b=BWPdKSctdvl3MGROqltLpkALgKswFOp8dU3mqaMzAduCbB2XVO/JHZByoAAuEjUwUjcBKN4UQB0s5U4p41NhYdjL71+XArFHWGz9/ZPj5WZav2QkiwVML3dAZmU7QuWfuvoUR4e7FeiAznP9s3Y6SfOsNjKSzM811dIxXeyXj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721581679; c=relaxed/simple;
	bh=c5pUCOQ3ShCr4xR/qb1EqG8XLvFBkSu8J5+pUYistgs=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=P+jqwzKsf4khlPk3dEh5c/py1E0aBAfvJ/3GyDedmFbToj0dxhix0au5VPaWJMqveXGx5Xa0VjPIZOAu69H791aDSSZ0QNgdTfA/rig9ngZ6LXY40PDAUn7QxW3lozTGgh55eD+YQnQ6cMxuwGmK+VWroylwNFXWu8KAnnfNQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=jP6ynSIq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bIv7s26J; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailflow.nyi.internal (Postfix) with ESMTP id 3530920011C;
	Sun, 21 Jul 2024 13:07:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Sun, 21 Jul 2024 13:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1721581675; x=1721585275; bh=tKbnBtKl282CPSArOzW9BAZADFMID+mBmgN
	GaGq7pic=; b=jP6ynSIq7J5eYrujk0Bqv5EUxsBkr922tNZNhIVZ+6MyMzbIj21
	tnXwHv7tFXfWy8S8rzehps33+Pj5GNs+tMdtgo1MXK96JmcJKk/591/bNKh+jmIb
	SmyVoaJxnVgjKJ7Tbie32iKqea+ta0Ym6gpxCu9krojNs1drhdMUxwwwP2UYL7VM
	9PfbMu26Q3MJMZ2vmCVQEcxsJFT39qMnQuLTnPHC4z1YhwPRHPFz0soLqMnEgTBI
	kEzewWyrIPy18BTzGDWBVT2gjfTUZxN72Jt4f1IhVbZ3oSl70RgxZI/8qYH1RYWv
	uZWwlzRbmcsFogSJSPzVmTxEDXXgorCVjtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1721581675; x=1721585275; bh=tKbnBtKl282CPSArOzW9BAZADFMID+mBmgN
	GaGq7pic=; b=bIv7s26Juq8lmXT6gSSfl4XMSFdeO0pHQ4qQOkYkmsEzL8Zt2hf
	K9u7hvW7M6WLBvj9W10SWNqZzScNljrKEbK1I3V8DC+1Pdzi+WhzwQy/vEvggWhE
	od1k+V7bQqVwl40dxphyWfSgtyfxjDwhMaaqiS3N+aiz4iuo6Z3qYaXhDW7UsbvL
	zr2fLugv8Hym6CSTauX59B16TD4JyZlqkyOtXYX7yZAZ6CWZhavo6tfX7f2szjYI
	EWs4koHUOD2v6SHD7nGvUXNePZJgHDnx3ZB4dXWUsKGpN2L8nHaYs2xlejH1k3yI
	m9nWjzJ0ZxSUOcx1oMgKI9+5R1m9BJvTGWA==
X-ME-Sender: <xms:akCdZj_BCcF3ddcDZVEZVnO-qpJdPUAZ0pt3UcYlxlxHPpUPWRJnJw>
    <xme:akCdZvv9zwRzRjIXOfcNcCQZmY-XT49fBeYkEJEsp0cxU2OfglazN6zDiooSOHBQm
    5xF1alLdZMPI8zg1Pc>
X-ME-Received: <xmr:akCdZhD-gq8gjV2fsvbndtQVl4MdF4kIhK30oXDUug-whMsyBOo5FA6P6xthyNz4n4yRpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheehgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefuofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepkeetudffjeduieelhfetudffieehfeejjefhteejudduueelveffhfegkeeghfeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvth
X-ME-Proxy: <xmx:akCdZvf4q8YWJIO5qTOJ6dVZalMJyr9zWoHbB-cly0qBwk_r3UUkyQ>
    <xmx:akCdZoOv3gr0r6enrP_5xoOTsoVXiam3Iyy7045qsElJYNfeZp5l0w>
    <xmx:akCdZhkJK5qR6g51qEs3gDfqx0u4HwsB8FwdL1D8jZRwsorwpKCBDw>
    <xmx:akCdZivnKNJqtKxRw-Ozr64Ti1-cjfOTJstZppwuILJFZLvCj1rgbQ>
    <xmx:akCdZivcb6kA0W0Ou9NKBI-Q4va-svFZKBfrk673I9fYwMgSGSZu14tH>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jul 2024 13:07:54 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 911449FC9E; Sun, 21 Jul 2024 10:07:52 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 8E1F39FB97;
	Sun, 21 Jul 2024 10:07:52 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: netdev@vger.kernel.org
Cc: Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH RFC net-next] bonding: Remove support for use_carrier
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2730096.1721581672.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jul 2024 10:07:52 -0700
Message-ID: <2730097.1721581672@famine>

	Remove the implementation of use_carrier, the link monitoring
method that utilizes ethtool or ioctl to determine the link state of an
interface in a bond.  The ability to set or query the use_carrier option
remains, but bonding now always behaves as if use_carrier=3D1, which
relies on netif_carrier_ok() to determine the link state of interfaces.

	To avoid acquiring RTNL many times per second, bonding inspects
link state under RCU, but not under RTNL.  However, ethtool
implementations in drivers may sleep, and therefore this strategy is
unsuitable for use with calls into driver ethtool functions.

	The use_carrier option was introduced in 2003, to provide
backwards compatibility for network device drivers that did not support
the then-new netif_carrier_ok/on/off system.  Device drivers are now
expected to support netif_carrier_*, and the use_carrier backwards
compatibility logic is no longer necessary.

Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com=
/
Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9d=
ed97163aef4e4de10985cd8f7de60d28@changeid/
Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

---

	I've done some sniff testing and this seems to behave as
expected, except that writing 0 to the sysfs use_carrier fails.  Netlink
permits setting use_carrier to any value but always returns 1; sysfs and
netlink should behave consistently.

 drivers/net/bonding/bond_main.c    | 107 +----------------------------
 drivers/net/bonding/bond_netlink.c |  11 +--
 drivers/net/bonding/bond_options.c |  13 +---
 drivers/net/bonding/bond_sysfs.c   |   6 +-
 include/net/bonding.h              |   1 -
 5 files changed, 7 insertions(+), 131 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
index af9ddd3902cc..98d77a9e5cf1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -141,8 +141,7 @@ module_param(downdelay, int, 0);
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
@@ -723,73 +722,6 @@ const char *bond_slave_link_status(s8 link)
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
-	int (*ioctl)(struct net_device *, struct ifreq *, int);
-	struct ifreq ifr;
-	struct mii_ioctl_data *mii;
-
-	if (!reporting && !netif_running(slave_dev))
-		return 0;
-
-	if (bond->params.use_carrier)
-		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
-
-	/* Try to get link status using Ethtool first. */
-	if (slave_dev->ethtool_ops->get_link)
-		return slave_dev->ethtool_ops->get_link(slave_dev) ?
-			BMSR_LSTATUS : 0;
-
-	/* Ethtool can't be used, fallback to MII ioctls. */
-	ioctl =3D slave_ops->ndo_eth_ioctl;
-	if (ioctl) {
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
-		if (ioctl(slave_dev, &ifr, SIOCGMIIPHY) =3D=3D 0) {
-			mii->reg_num =3D MII_BMSR;
-			if (ioctl(slave_dev, &ifr, SIOCGMIIREG) =3D=3D 0)
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
@@ -1832,7 +1764,6 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev,
 	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
 	struct slave *new_slave =3D NULL, *prev_slave;
 	struct sockaddr_storage ss;
-	int link_reporting;
 	int res =3D 0, i;
 =

 	if (slave_dev->flags & IFF_MASTER &&
@@ -1842,12 +1773,6 @@ int bond_enslave(struct net_device *bond_dev, struc=
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
@@ -2050,29 +1975,10 @@ int bond_enslave(struct net_device *bond_dev, stru=
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
@@ -2601,7 +2507,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 =

-		link_state =3D bond_check_dev_link(bond, slave->dev, 0);
+		link_state =3D netif_carrier_ok(slave->dev);
 =

 		switch (slave->link) {
 		case BOND_LINK_UP:
@@ -6044,12 +5950,6 @@ static int __init bond_check_params(struct bond_par=
ams *params)
 		downdelay =3D 0;
 	}
 =

-	if ((use_carrier !=3D 0) && (use_carrier !=3D 1)) {
-		pr_warn("Warning: use_carrier module parameter (%d), not of valid value=
 (0/1), so it was set to 1\n",
-			use_carrier);
-		use_carrier =3D 1;
-	}
-
 	if (num_peer_notif < 0 || num_peer_notif > 255) {
 		pr_warn("Warning: num_grat_arp/num_unsol_na (%d) not in range 0-255 so =
it was reset to 1\n",
 			num_peer_notif);
@@ -6294,7 +6194,6 @@ static int __init bond_check_params(struct bond_para=
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
index 2a6a424806aa..e35433cd76b1 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -257,15 +257,6 @@ static int bond_changelink(struct net_device *bond_de=
v, struct nlattr *tb[],
 		if (err)
 			return err;
 	}
-	if (data[IFLA_BOND_USE_CARRIER]) {
-		int use_carrier =3D nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
-
-		bond_opt_initval(&newval, use_carrier);
-		err =3D __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
-				     data[IFLA_BOND_USE_CARRIER], extack);
-		if (err)
-			return err;
-	}
 	if (data[IFLA_BOND_ARP_INTERVAL]) {
 		int arp_interval =3D nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
 =

@@ -674,7 +665,7 @@ static int bond_fill_info(struct sk_buff *skb,
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
index bc80fb6397dc..ab5db55e27ea 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -183,12 +183,6 @@ static const struct bond_opt_value bond_primary_resel=
ect_tbl[] =3D {
 	{ NULL,      -1},
 };
 =

-static const struct bond_opt_value bond_use_carrier_tbl[] =3D {
-	{ "off", 0,  0},
-	{ "on",  1,  BOND_VALFLAG_DEFAULT},
-	{ NULL,  -1, 0}
-};
-
 static const struct bond_opt_value bond_all_slaves_active_tbl[] =3D {
 	{ "off", 0,  BOND_VALFLAG_DEFAULT},
 	{ "on",  1,  0},
@@ -410,8 +404,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAS=
T] =3D {
 	[BOND_OPT_USE_CARRIER] =3D {
 		.id =3D BOND_OPT_USE_CARRIER,
 		.name =3D "use_carrier",
-		.desc =3D "Use netif_carrier_ok (vs MII ioctls) in miimon",
-		.values =3D bond_use_carrier_tbl,
+		.desc =3D "Obsolete, has no effect",
 		.set =3D bond_option_use_carrier_set
 	},
 	[BOND_OPT_ACTIVE_SLAVE] =3D {
@@ -1064,10 +1057,6 @@ static int bond_option_peer_notif_delay_set(struct =
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
index b61fb1aa3a56..2977a9bc343b 100644
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

2.34.1


