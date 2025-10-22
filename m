Return-Path: <netdev+bounces-231505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB8BF9ABA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F84E110C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37C17BED0;
	Wed, 22 Oct 2025 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="b+gmQC/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtWNGzjt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BBB652
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098586; cv=none; b=fmHz/GpYzBn0S2vVluPEIO9J4Oq5y1fkm5KiIjuIszXkvBhf92KuOZbyREbv9JPbffmWhDpsbivycllvVrUwqO/X6o8jJcvWjy9I70u4dzIAZIQgJN9RmjRxJ1MqwJfIa/BP3OhDCvV79A15948CjBBrOIQ3xjjOouSRC9ZtvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098586; c=relaxed/simple;
	bh=dQFGk+5mCpGo4nwJbX4538JiZv9g8sq68/JLQXK/zIs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=JQat8A3WV+VITCPNRB9ptzvOYJX8HjH+roDW24Yq6UqE1Urst2qTW9CyhencrRHShHOa5oVUmlDCtP2zhG79fY4YEx3Uh3/LMfXD6dEC3X3tQ/5B4AlZi0tua7Qbgpj5UWR0Wrl2dvGQGuiqB7KEE7lvV/W6o0h1gIs0Uv9lV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=b+gmQC/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtWNGzjt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F61CEC00D9;
	Tue, 21 Oct 2025 22:03:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 22:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1761098581; x=1761184981; bh=up+quY9nEOW4nBTgcJ8C3
	ngbeiUTEWZkmzcGWsBU+Ww=; b=b+gmQC/dtFso92xWZhSBrrnca3kJfu5NmCksx
	oLArNU5ZELLxXOJiiexAasuCDwHSdyMPioqNYQsUzkfufBMP6MjBS8lr36ftONzl
	qZOv6vUTjLfgbRg/T2zlPr6Dl27EyiIPF3ZCug02Wf8PItMRbd89BRhm6r93+F0P
	FadESDvfrQ6utUF26LB44f//eVHuaoTDbp0spv8ZDVhG2c87u1wgs5QKzmngDET+
	YQj3uGywKHqtYbS71ahNJ0UbCIcwBLxzlirAl+p/fIYLInCPPrsxUL3zAahcCj6N
	Kvc6aKTt+IINHdOcn1ceLl53qCNAmCz/SwMnPF9+vDhGDGXJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761098581; x=1761184981; bh=up+quY9nEOW4nBTgcJ8C3ngbeiUTEWZkmzc
	GWsBU+Ww=; b=HtWNGzjtRXZXUVK3UjRh5sCCSJILftbpNrlQsCadAPV7f34QwR2
	tPrYB5Vo7c3t/84ugNs75galUOLU/d1eiuuRV0Og64eaeJgNVWzTeK/40FYxfvij
	gGhl4tT3xuzCvdhTW4vP4xweW2UaAkOEnwus4lOaBlCvmElac3w9KKQed3FAuVXw
	gZ31nXcx1Npa53jHg/9Bol7rCL73QdRPyroAqsqeEmUgjbs5CZX+PJcbq6sx5X6G
	B9t+rrrYfcyjGtGMZAtBfwoqm/jio8nwNzU98UmdHXowdlEbe2gnCz+RfnO/Q1Bd
	C+1vIqZXFeJQoA6uyuD4MHK2DKrDuPV3dPg==
X-ME-Sender: <xms:VDv4aAKv7TlK6mPjkNo_2DUI4gwyJUPczQPyIdJ1mzU7WV8Zv1KSuA>
    <xme:VDv4aIVguQlfyQbBCfw1hKEziNsE3lXiDGknn5Gx4VWmPYi4AhKOhk7RXvE_Zl-NU
    QvHzL3IX3Vw9S0xJtMmxZUA3wl6mcld6BbSVvCJtz0KgpDwgfm9aLg>
X-ME-Received: <xmr:VDv4aMRYvIrQnerezt2zRLdW90HcRq3rxgzXwpk1ZLx89qGW97DZZ78sxGRr7R121ePyPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhonhhghhgrohessggrmhgrihgtlhhouhgurdgtohhmpd
    hrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhhrghnghgsih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggv
    vheslhhunhhnrdgthhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:VTv4aIBpGnkDnCxcvLEDZKyS9xkvcLEPCZEiqF0Nz3a_dBSOX03uPQ>
    <xmx:VTv4aDIvVoSB8snFdXPT__M6vKeBhncROkGGlHND_eCx-mNTC7ry3Q>
    <xmx:VTv4aDDXFZyfSEoiDqDosT27HZ05yVpwS7pup_-YCEO3M5wglaonEQ>
    <xmx:VTv4aIvarOTHmagJJ1GyKpMz0xYB1ePYDqaEU7q8REBkU72L-CYGcQ>
    <xmx:VTv4aIDHyRQGU6KSQHx6ijlGpN68OzwOo6q3OH60cW-838PnUdKVb9Wd>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 22:03:00 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 846C09FD50; Tue, 21 Oct 2025 19:02:59 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 8373C9FC61;
	Tue, 21 Oct 2025 19:02:59 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next] net: bonding: use workqueue to make sure peer
 notify updated
In-reply-to: <20251021052249.47250-1-tonghao@bamaicloud.com>
References: <20251021052249.47250-1-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Tue, 21 Oct 2025 13:22:49 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <955200.1761098579.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Oct 2025 19:02:59 -0700
Message-ID: <955201.1761098579@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>The RTNL might be locked, preventing ad_cond_set_peer_notif from acquirin=
g
>the lock and updating send_peer_notif. This patch addresses the issue by
>using a workqueue. Since updating send_peer_notif does not require high
>real-time performance, such delayed updates are entirely acceptable.

	Would it be less complicated overall to convert send_peer_notif
to an atomic_t, and handle updates via atomic_inc/dec/etc instead of
messing with workqueues and RTNL just to change one variable?

	As you say, it's not performance critical, and, despite your
previous patch that moves some send_peer_notif code inside an RTNL
block, if using atomic makes the code less complicated that may be
better in the long run.

	-J

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
>Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>---
> drivers/net/bonding/bond_3ad.c  |  7 ++-----
> drivers/net/bonding/bond_main.c | 27 +++++++++++++++++++++++++++
> include/net/bonding.h           |  2 ++
> 3 files changed, 31 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 2fca8e84ab10..1db2e34a351f 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -986,11 +986,8 @@ static void ad_cond_set_peer_notif(struct port *port=
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
>+		bond_peer_notify_work_rearm(bond, 0);
> }
> =

> /**
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 2d6883296e32..5791c3e39baa 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3990,6 +3990,31 @@ static void bond_arp_monitor(struct work_struct *w=
ork)
> 		bond_loadbalance_arp_mon(bond);
> }
> =

>+/* Use this to update send_peer_notif when RTNL may be held in other pla=
ces. */
>+void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long del=
ay)
>+{
>+	queue_delayed_work(bond->wq, &bond->peer_notify_work, delay);
>+}
>+
>+/* Peer notify update handler. Holds only RTNL */
>+static void bond_peer_notify_handler(struct work_struct *work)
>+{
>+	struct bonding *bond =3D container_of(work, struct bonding,
>+					    peer_notify_work.work);
>+
>+	if (!rtnl_trylock())
>+		goto rearm;
>+
>+	bond->send_peer_notif =3D bond->params.num_peer_notif *
>+		max(1, bond->params.peer_notif_delay);
>+
>+	rtnl_unlock();
>+	return;
>+
>+rearm:
>+	bond_peer_notify_work_rearm(bond, 1);
>+}
>+
> /*-------------------------- netdev event handling ---------------------=
-----*/
> =

> /* Change device name */
>@@ -4412,6 +4437,7 @@ void bond_work_init_all(struct bonding *bond)
> 	INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
> 	INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
> 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
>+	INIT_DELAYED_WORK(&bond->peer_notify_work, bond_peer_notify_handler);
> }
> =

> static void bond_work_cancel_all(struct bonding *bond)
>@@ -4422,6 +4448,7 @@ static void bond_work_cancel_all(struct bonding *bo=
nd)
> 	cancel_delayed_work_sync(&bond->ad_work);
> 	cancel_delayed_work_sync(&bond->mcast_work);
> 	cancel_delayed_work_sync(&bond->slave_arr_work);
>+	cancel_delayed_work_sync(&bond->peer_notify_work);
> }
> =

> static int bond_open(struct net_device *bond_dev)
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index e06f0d63b2c1..4ce530371416 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -255,6 +255,7 @@ struct bonding {
> 	struct   delayed_work ad_work;
> 	struct   delayed_work mcast_work;
> 	struct   delayed_work slave_arr_work;
>+	struct   delayed_work peer_notify_work;
> #ifdef CONFIG_DEBUG_FS
> 	/* debugging support via debugfs */
> 	struct	 dentry *debug_dir;
>@@ -710,6 +711,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct =
net_device *start_dev,
> 					      int level);
> int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)=
;
> void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay=
);
>+void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long del=
ay);
> void bond_work_init_all(struct bonding *bond);
> =

> #ifdef CONFIG_PROC_FS
>-- =

>2.34.1
>
>

---
	-Jay Vosburgh, jv@jvosburgh.net

