Return-Path: <netdev+bounces-198359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD2ADBE37
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC9117221A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28174040;
	Tue, 17 Jun 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="DacdE2j4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNo/5hD4"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE37CA6F
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120624; cv=none; b=Yvfdm7hy9KdYWtTjgRRokAHl1jHWUybfT7jNu36CzZCEU3tv7a5tS45n0MzXXMxQYnokeR5xM8Sv+PC/GPGAH2LPclbKoulhyoaHKwIA69eSC3RLI7hrM4DZQf2RX90lv0RQfmdLFDTgNvPwq+/cPM75MJWJiEzwdlvg4OemDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120624; c=relaxed/simple;
	bh=ychfaVMDGF8/+1gY1CsuK8rjHStkhgwY5FgsRil/cHQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=CxN6Uq8cuIVXm4thY2hvAdoGFbXdC+gna0y/S0Yef1j0e6wiHE74DBdm/k+CC6pPe52Osrt2OFpHw/Eb3GR0SCrEzvDk8oVervz5UKktSYApGiR46zeSPRrKA2jvAuRhLJn4WN4TfUMFXWqRdOzuq4KASr2+rsSVdNhe8Ipyij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=DacdE2j4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNo/5hD4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C97391140168;
	Mon, 16 Jun 2025 20:37:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 16 Jun 2025 20:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750120620; x=1750207020; bh=/SysyYknhLPuVE5TKfQWi
	Gocky9hZCj0XcUTGqSkchE=; b=DacdE2j4L1ZwBEGhcWQevidNRVHcHlyEAfHrf
	0POK8YibqpQ6SKd4FnQNI4yrHc4S3fp+cLrqGD+YOL9xWcOSthBchLXEMgCGeQr2
	5pUTtz3iOto/M1AmbTJOX5Fmy6mJezi35QWVIAf0XB6Lzw4m3kGNsl5+5abHAnkg
	ZgAciVN2FBtRcqp7uSWQZf4H2W3q7b5o9bCleTi4UoriExHYxBgkt3r3Ppw3hloe
	F+c8WXUh7Gz9EXiRfXbjFpEzxDyMAVIoAL7aPOb7q+P03X621v3aFgWeFXBTQVKp
	PTNjwKMSpVDz/4nmucRjH9fSmCSqy8tqvslDCVJlt3R7opF5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750120620; x=1750207020; bh=/SysyYknhLPuVE5TKfQWiGocky9hZCj0XcU
	TGqSkchE=; b=SNo/5hD4p9fqP6A9xlB1NR+6Kvwj92DVIYVJ3hYk48QbZdafZKv
	aS1Lpbz+EV0vmAmVjAKD0k6cKonYjpT/+M8lo295v8juE/Nymj3/9J53B/x0tJqs
	cL9YubHR7tm2rwBBU9DmVjgYq6LZ1HDFmgYqryDygIIAn4UewA8oVuoT/Sdx9OHa
	xZzK3rjuY+5MGh7AiEm1idkEbbpgujzYq3DRX/YjP2Ew1+UQe75OjBxuAZOGcsEB
	yhs2TuzE4yVWQddhH9DJfEPnL/hNa7OOW4gek0p7IRope4MtpqPBVnLXUEv5e+wx
	yLg3PxLjF7FtYvAPkrDWOvh5kjmL6ozoXeA==
X-ME-Sender: <xms:q7hQaF-ZXNf3OJrUqo32AFrT11WVd8ykeGXldxBYGiLN0OUflXFtoA>
    <xme:q7hQaJvDwvFCpTM3Lt_9i9X0x-RNNDw0N-BdvsADvYFF_5DidMUde_RIHVrk8_Oil
    Tzao6ZNZ-l_DVSInGg>
X-ME-Received: <xmr:q7hQaDDj7p80Nb3vNamh1DpAgZrqmeAzCe5SQ3Utsb6w5zhGPqWKoKt2Shm0u7FGOXu6rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeeifedvleefleejveethfefieduueeivdefieev
    leffuddvveeftdehffffteefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhnghhhrghosegsrg
    hmrghitghlohhuugdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhl
    rdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopehtuhiivghnghgsihhnghesughiughighhlohgsrghlrdgtohhmpdhrtghpthht
    ohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtg
    hpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegvughu
    mhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q7hQaJdH9w1sC3lwZnwp3r-Y9iTgh-9aDRPszv2W_8bBRNBU9p-dYA>
    <xmx:q7hQaKPpEkpaIIx1UMRgOesxskRxSAkIPaTjXffskXfEfyqfPgUCog>
    <xmx:q7hQaLmIIMXCSLxnGelIC3m-MLNPWu1RSN--IjeaRTFmpY4jhyLmtw>
    <xmx:q7hQaEv-2RTWR7OA6JCaPhsAbirpF3GTV6zagvjl7SMPVX8tZi_k0A>
    <xmx:rLhQaB_RC2ZKczz_9Nvf6CWdf-os6cpDyQxlT6d1tRG8yXgJok5GACgG>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 20:36:59 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 763BB9FCA6; Mon, 16 Jun 2025 17:36:58 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 752E39FC54;
	Mon, 16 Jun 2025 17:36:58 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Steven Rostedt <rostedt@goodmis.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [net-next v6 3/4] net: bonding: send peer notify when failure
 recovery
In-reply-to: 
 <81185ef7f9227cff906903fe8e74258727529491.1749525581.git.tonghao@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <81185ef7f9227cff906903fe8e74258727529491.1749525581.git.tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Tue, 10 Jun 2025 11:44:44 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1931521.1750120618.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 17:36:58 -0700
Message-ID: <1931522.1750120618@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>After LACP protocol recovery, the port can transmit packets.
>However, if the bond port doesn't send gratuitous ARP/ND
>packets to the switch, the switch won't return packets through
>the current interface. This causes traffic imbalance. To resolve
>this issue, when LACP protocol recovers, send ARP/ND packets.

	I think the description above needs to mention that the
gratuitous ARP/ND only happens if broadcast_neighbor is enabled.

	I'll note that the documentation update does include this
caveat.

>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Cc: Masami Hiramatsu <mhiramat@kernel.org>
>Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Cc: Nikolay Aleksandrov <razor@blackwall.org>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>---
> Documentation/networking/bonding.rst |  5 +++--
> drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
> drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
> 3 files changed, 32 insertions(+), 7 deletions(-)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index 14f7593d888d..f8f5766703d4 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -773,8 +773,9 @@ num_unsol_na
> 	greater than 1.
> =

> 	The valid range is 0 - 255; the default value is 1.  These options
>-	affect only the active-backup mode.  These options were added for
>-	bonding versions 3.3.0 and 3.4.0 respectively.
>+	affect the active-backup or 802.3ad (broadcast_neighbor enabled) mode.
>+	These options were added for bonding versions 3.3.0 and 3.4.0
>+	respectively.
> =

> 	From Linux 3.0 and bonding version 3.7.1, these notifications
> 	are generated by the ipv4 and ipv6 code and the numbers of
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c6807e473ab7..d1c2d416ac87 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, struct =
bond_marker *marker)
> 	return 0;
> }
> =

>+static void ad_cond_set_peer_notif(struct port *port)
>+{
>+	struct bonding *bond =3D port->slave->bond;
>+
>+	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>+		bond->send_peer_notif =3D bond->params.num_peer_notif *
>+			max(1, bond->params.peer_notif_delay);
>+		rtnl_unlock();
>+	}
>+}
>+
> /**
>  * ad_mux_machine - handle a port's mux state machine
>  * @port: the port we're looking at
>@@ -2061,6 +2072,8 @@ static void ad_enable_collecting_distributing(struc=
t port *port,
> 		__enable_port(port);
> 		/* Slave array needs update */
> 		*update_slave_arr =3D true;
>+		/* Should notify peers if possible */
>+		ad_cond_set_peer_notif(port);
> 	}
> }
> =

>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 12046ef51569..0acece55d9cb 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1237,17 +1237,28 @@ static struct slave *bond_find_best_slave(struct =
bonding *bond)
> /* must be called in RCU critical section or with RTNL held */
> static bool bond_should_notify_peers(struct bonding *bond)
> {
>-	struct slave *slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
>+	struct bond_up_slave *usable;
>+	struct slave *slave =3D NULL;
> =

>-	if (!slave || !bond->send_peer_notif ||
>+	if (!bond->send_peer_notif ||
> 	    bond->send_peer_notif %
> 	    max(1, bond->params.peer_notif_delay) !=3D 0 ||
>-	    !netif_carrier_ok(bond->dev) ||
>-	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>+	    !netif_carrier_ok(bond->dev))
> 		return false;
> =

>+	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>+		usable =3D rcu_dereference_rtnl(bond->usable_slaves);
>+		if (!usable || !READ_ONCE(usable->count))
>+			return false;
>+	} else {
>+		slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
>+		if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
>+				       &slave->dev->state))
>+			return false;
>+	}
>+
> 	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
>-		   slave ? slave->dev->name : "NULL");
>+		   slave ? slave->dev->name : "all");

	Is it actually correct that if slave =3D=3D NULL, the notify peers
logic will send to all ports?  I'm not sure why this changed.

	-J

> =

> 	return true;
> }
>-- =

>2.34.1

---
	-Jay Vosburgh, jv@jvosburgh.net

