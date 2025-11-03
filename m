Return-Path: <netdev+bounces-235239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3368C2E2EA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 22:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D480A4E12FE
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD228C871;
	Mon,  3 Nov 2025 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="xVK/ufIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zKhe/MCZ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF726A0BD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206515; cv=none; b=mDBqf/lZzIDdQ9a2nc+9cz+plJ0fwFwg5M1CF++0w41+JG+WPBpcJyDgkRLtXWy5VT1/U3+r++fIA9p4Piy49dOhvBDEp5+j87qXY0KKnk+8yknHswp3LBGkG1nqE7UcnN+x74eH5FT85Rjs7mLnPggO6SkEy7ytoB32HTswSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206515; c=relaxed/simple;
	bh=BvFk0FKJieBk1C9PGF8BWWzjNbqWL+OVJ+H/EIa8xCQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KPUP1mBs/0o6EFU/M4D5SqnftqA9cEifbmWPJRO+qLNxLNc/f9EBG7wPveUYVLJk3RvRI+zEtmEg7QqgQ4w5nU5CZxFK/HG68sWIHEPUSDoBpB5VchJ+7QJ2G55KwtCE09Ss+rZoEjoyItFIMYJcKWT8oXHJzVmdJV4GwMc0kPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=xVK/ufIr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zKhe/MCZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56E2214001B2;
	Mon,  3 Nov 2025 16:48:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 16:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1762206511; x=1762292911; bh=S7jy5RbJrSURdr8lYGtHd
	NcOBbDCC0JnRHUqpcJJiOc=; b=xVK/ufIr+bX4lN2CRq6bOpkjLoAYgYQB1dKqy
	wwld9eEVaa0NXRu8EnzyXMNf3zbh94wNgD+9bPm036zNfK+MxMMPAM23RBh5Ohl6
	0+6YzuFGPF3TO5SM1gvWWyIZIgvfWlf3HmvJcYxIY8kKC06alxTBFA7ZhCVI3OxI
	SnsY2ruWUSm9YA8jwuk+0l1dfhvLniG4w1dzFafbQEeO3qA+pFgfUJmMbdl+KV1y
	af8YomwVlw7zYBclQxwjdcu5BieP8eyZ5JeEZfiVSVQAyhU9uSS94vs1o+zBAgss
	QXZ/FrlzetCOFxCJgWpekM81UZQv1SjrgD8UhLwnF0yN29DoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762206511; x=1762292911; bh=S7jy5RbJrSURdr8lYGtHdNcOBbDCC0JnRHU
	qpcJJiOc=; b=zKhe/MCZ70nnST9Z4zNEeTlVEdE4MFgbFZiN1iWomZhpDV/9hpT
	Weoxfh9iz+Ps/8iEt3XtJDc89x16/NOZK94Isl1SxPsg8Ommaxl8CI2TK0LlRiF5
	3S8STeUjXUehIcoguNPatVAU/oZkbkQDAh4NumGplfSexgOExWy4Hzat25lXU8m0
	4exKBPxNo6faeXDne8BFaCn0mQIZ/WJ47t8TgOFSXYpQKvrbs6Udb80OXGAX0e/m
	W20nk8E9L6KXyfxALwcIb4m0+tccN3GMtyJuRW7SWkJ3dSimYw2BK5kxQU/QS//e
	RlhQSNlJu/ibcO6Kbcei3ZH1eHcMuzKTrxQ==
X-ME-Sender: <xms:LiMJadGoezlsKHwBZneMC26u8UjtAk4kfcF7CyncJeGaO1-oKMexbQ>
    <xme:LiMJaai3cDRzmf0D06hqHpqaouZCzDRhT-sNR4r7PmDB3GKt18wF5R8R6UrrhuHCk
    SEYw171WrRwY8iIgoLNrJTb6xD2dyA-G61Cw71GVvsK4eFrL1nYAqY>
X-ME-Received: <xmr:LiMJaavkWSGFNyWYkT8hiCz3lNiC3mj9DkSp1BSlfyNenLnNzAlbhWbw80xcibW0HpZNrO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhngh
    hhrghosegsrghmrghitghlohhuugdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgr
    tghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoh
    eptghorhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:LiMJaduE1HByoObogZ-NsUeR4B3LDOknPUGam4JVl2Kwtgw2uuiIRA>
    <xmx:LiMJafGWC1XjsZWtkdhuaQ6IoYWR11C0wNhk8EVN3XbYY_SpnUy6wA>
    <xmx:LiMJaYOdnLqt_aogcsDx7tujdOfb4Pdfctz_ZzjC_kd7nTU7yPdNtg>
    <xmx:LiMJaeLdwcifUSGAXmDoJLKrWAb_65E6___5-82zDcEjK9iQUuDOWg>
    <xmx:LyMJaQtFQpwZCqCQ6iA442xutwIvUSIIVlqVqL159PEQNf9o-ongBqEl>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 16:48:29 -0500 (EST)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 76FCD1C04DD; Mon,  3 Nov 2025 13:48:26 -0800 (PST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 743A81C01BD;
	Mon,  3 Nov 2025 22:48:26 +0100 (CET)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH v2] net: bonding: use atomic instead of rtnl_mutex, to make sure peer notify updated
In-reply-to: <20251028034547.78830-1-tonghao@bamaicloud.com>
References: <20251028034547.78830-1-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Tue, 28 Oct 2025 11:45:47 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <253221.1762206506.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Nov 2025 22:48:26 +0100
Message-ID: <253222.1762206506@vermin>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>Using atomic to protect the send_peer_notif instead of rtnl_mutex.
>This approach allows safe updates in both interrupt and process
>contexts, while avoiding code complexity.
>
>In lacp mode, the rtnl might be locked, preventing ad_cond_set_peer_notif=
()
>from acquiring the lock and updating send_peer_notif. This patch addresse=
s
>the issue by using a atomic. Since updating send_peer_notif does not
>require high real-time performance, such atomic updates are acceptable.
>
>After coverting the rtnl lock for send_peer_notif to atomic, in bond_mii_=
monitor(),
>we should check the should_notify_peers (rtnllock required) instead of
>send_peer_notif. By the way, to avoid peer notify event loss, we check
>again whether to send peer notify, such as active-backup mode failover.
>
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Cc: Nikolay Aleksandrov <razor@blackwall.org>
>Cc: Hangbin Liu <liuhangbin@gmail.com>
>Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>---
>v2:
>- refine the codes
>- check bond_should_notify_peers again in bond_mii_monitor(), to avoid
>  event loss. =

>- v1 https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.=
48833-1-tonghao@bamaicloud.com/
>---
> drivers/net/bonding/bond_3ad.c  |  7 ++---
> drivers/net/bonding/bond_main.c | 46 ++++++++++++++++-----------------
> include/net/bonding.h           |  9 ++++++-
> 3 files changed, 32 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 49717b7b82a2..05c573e45450 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -999,11 +999,8 @@ static void ad_cond_set_peer_notif(struct port *port=
)
> {
> 	struct bonding *bond =3D port->slave->bond;
> =

>-	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>-		bond->send_peer_notif =3D bond->params.num_peer_notif *
>-			max(1, bond->params.peer_notif_delay);
>-		rtnl_unlock();
>-	}
>+	if (bond->params.broadcast_neighbor)
>+		bond_peer_notify_reset(bond);
> }
> =

> /**
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 8e592f37c28b..ae90221838d4 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1167,10 +1167,11 @@ static bool bond_should_notify_peers(struct bondi=
ng *bond)
> {
> 	struct bond_up_slave *usable;
> 	struct slave *slave =3D NULL;
>+	int send_peer_notif;
> =

>-	if (!bond->send_peer_notif ||
>-	    bond->send_peer_notif %
>-	    max(1, bond->params.peer_notif_delay) !=3D 0 ||
>+	send_peer_notif =3D atomic_read(&bond->send_peer_notif);
>+	if (!send_peer_notif ||
>+	    send_peer_notif % max(1, bond->params.peer_notif_delay) !=3D 0 ||
> 	    !netif_carrier_ok(bond->dev))
> 		return false;
> =

>@@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding *bond,=
 struct slave *new_active)
> 						      BOND_SLAVE_NOTIFY_NOW);
> =

> 		if (new_active) {
>-			bool should_notify_peers =3D false;
>-
> 			bond_set_slave_active_flags(new_active,
> 						    BOND_SLAVE_NOTIFY_NOW);
> =

>@@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding *bon=
d, struct slave *new_active)
> 						      old_active);
> =

> 			if (netif_running(bond->dev)) {
>-				bond->send_peer_notif =3D
>-					bond->params.num_peer_notif *
>-					max(1, bond->params.peer_notif_delay);
>-				should_notify_peers =3D
>-					bond_should_notify_peers(bond);
>+				bond_peer_notify_reset(bond);
>+
>+				if (bond_should_notify_peers(bond)) {
>+					atomic_dec(&bond->send_peer_notif);
>+					call_netdevice_notifiers(
>+							NETDEV_NOTIFY_PEERS,
>+							bond->dev);
>+				}
> 			}
> =

> 			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
>-			if (should_notify_peers) {
>-				bond->send_peer_notif--;
>-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>-							 bond->dev);
>-			}
> 		}
> 	}
> =

>@@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct work_struct *wo=
rk)
> =

> 	rcu_read_unlock();
> =

>-	if (commit || bond->send_peer_notif) {
>+	if (commit || should_notify_peers) {
> 		/* Race avoidance with bond_close cancel of workqueue */
> 		if (!rtnl_trylock()) {
> 			delay =3D 1;
>@@ -2816,16 +2813,15 @@ static void bond_mii_monitor(struct work_struct *=
work)
> 			bond_miimon_commit(bond);
> 		}
> =

>-		if (bond->send_peer_notif) {
>-			bond->send_peer_notif--;
>-			if (should_notify_peers)
>-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>-							 bond->dev);
>-		}
>+		/* check again to avoid send_peer_notif has been changed. */
>+		if (bond_should_notify_peers(bond))
>+			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);

	Is the risk here that user space may have set send_peer_notify
to zero?

> =

> 		rtnl_unlock();	/* might sleep, hold no other locks */
> 	}
> =

>+	atomic_dec_if_positive(&bond->send_peer_notif);
>+

	Also, it's a bit subtle, but I think this has to be outside of
the if block, or peer_notif_delay may be unreliable.  I'm not sure it
needs a comment, but could you confirm that's why this line is where it
is?

	-J

> re_arm:
> 	if (bond->params.miimon)
> 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
>@@ -3773,7 +3769,7 @@ static void bond_activebackup_arp_mon(struct bondin=
g *bond)
> 			return;
> =

> 		if (should_notify_peers) {
>-			bond->send_peer_notif--;
>+			atomic_dec(&bond->send_peer_notif);
> 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> 						 bond->dev);
> 		}
>@@ -4267,6 +4263,8 @@ static int bond_open(struct net_device *bond_dev)
> 			queue_delayed_work(bond->wq, &bond->alb_work, 0);
> 	}
> =

>+	atomic_set(&bond->send_peer_notif, 0);
>+
> 	if (bond->params.miimon)  /* link check interval, in milliseconds. */
> 		queue_delayed_work(bond->wq, &bond->mii_work, 0);
> =

>@@ -4300,7 +4298,7 @@ static int bond_close(struct net_device *bond_dev)
> 	struct slave *slave;
> =

> 	bond_work_cancel_all(bond);
>-	bond->send_peer_notif =3D 0;
>+	atomic_set(&bond->send_peer_notif, 0);
> 	if (bond_is_lb(bond))
> 		bond_alb_deinitialize(bond);
> 	bond->recv_probe =3D NULL;
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 49edc7da0586..afdfcb5bfaf0 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -236,7 +236,7 @@ struct bonding {
> 	 */
> 	spinlock_t mode_lock;
> 	spinlock_t stats_lock;
>-	u32	 send_peer_notif;
>+	atomic_t send_peer_notif;
> 	u8       igmp_retrans;
> #ifdef CONFIG_PROC_FS
> 	struct   proc_dir_entry *proc_entry;
>@@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct net_de=
vice *dev, struct sk_buff *s
> 	return NET_XMIT_DROP;
> }
> =

>+static inline void bond_peer_notify_reset(struct bonding *bond)
>+{
>+	atomic_set(&bond->send_peer_notif,
>+		bond->params.num_peer_notif *
>+		max(1, bond->params.peer_notif_delay));
>+}
>+
> #endif /* _NET_BONDING_H */
>-- =

>2.34.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

