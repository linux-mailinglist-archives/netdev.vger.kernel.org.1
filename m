Return-Path: <netdev+bounces-189469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45FAB23E4
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64220189FEDB
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7470805;
	Sat, 10 May 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="MImy58os";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="re7ubqeV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A333A8F7
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746882090; cv=none; b=YYqJOy2KPOX+PbujNUwG+Hxisr2CjZSkSHkIObFU01vfQW7jwMkMYVb5tELmTs3liseO4r+Rl1jJY/DxGyiaHQFKFxJyFq29KicOTHmbX+6WTOfIr0puUNnyxbV7MPEuWFiVZ8rRCmOf09dxlEPTphq9Yeq+W/VEH7KGppPK8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746882090; c=relaxed/simple;
	bh=JMj+tjE9UC0FCzBPBOj3gxq1SaluCqtYuJfrOBscfPM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=uGcnjdiyDCQfM69pAaVBhMFF6osZBbGF6lq7VRSMjd9oMa2oSEdCZPqKFE7B/3v/6Fjjiy1vy79iz+od54+CO5DcbqjilnpHCOjQh7jeVo8cy5iFSWomCUCoqiXY8kOcWK3SZbogHMkfk494Hg06t9Efzt9hBB7FjXvi5vYOuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=MImy58os; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=re7ubqeV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B6F811400E6;
	Sat, 10 May 2025 09:01:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 10 May 2025 09:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1746882086; x=1746968486; bh=9TXZqi5+Ss+JxSenKvTXr
	JDw5c3A+tp0b20A4pC/ZRo=; b=MImy58osOnMmNuHjZ59OvhVDZWpN4A8pe2lJU
	1yrGnR+wbDiUzG/t0dmhtOuh/zwBXNrVNfG052uSZLEJkTloP+P0VOIeD8gVLHi1
	BGndRvtPFF+JCgjCjIaorC73ZuQhawQxvM7S2hfDzYPomNIwROZ+uJgiXgPlILo2
	lEjclInuAnRufOy3dAW6uAZfhGTqg3afnDUbONJj2CV+4TlubPkcQikeKYd55Os3
	f6ZOSTYWXIYZ3+YFF4jvoEkObBw7AifjxznpX6E+jL5x2CX4mr21CclOFMPwoceV
	hwwnflOzezRWilp0XuwSKIjaO6eQHhcw9wxkcIXR4MkzES+fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746882086; x=1746968486; bh=9TXZqi5+Ss+JxSenKvTXrJDw5c3A+tp0b20
	A4pC/ZRo=; b=re7ubqeVgdjQ9AqnmHJ0UOzCvPZZCXb/Z7TOG3qRd3RCG2RUnLD
	VdJfn8ZwU/PU797QBltp6xpNMHsLf7anndmllYdwI8PsnrXP8uAP4teMkgbRl70B
	KqmD9zKPXersnNAWauiVc7/rvAXNCAy0SjD1XjZgDtvqbp+Hylt2nNpnSpPWjfob
	uKbLwq8FNhfM4QwxaMHGcgxnJTeyP8tNL3WevtrMWY+80JWSIygW+zyulvoADmAn
	TgmX1AMG1cGn5/ghsnNP9hIScrd8kz7FxjWJYxleHYFyi+KcK+RfMD4t0aCLJe5M
	g+rsKAaFUEaesmES/2wPzVUqhxtPuqK3SAA==
X-ME-Sender: <xms:JU4faLcG9m_yuU1WIqgOUs6uzrbgKoQLH-QTdfiNz33C5gZEuYvzsQ>
    <xme:JU4faBNic-DWFe4U4MuucZ8uiB68A6JEu5Qspcv01PrNJYIyLy5mYF4HajH3oOS19
    mW3ZgDGc82JB5qKOu4>
X-ME-Received: <xmr:JU4faEgsIhY92co9zpVFwQDziRCG4VA4YH9OF6ONobZtMAuPvT2etvOgHp80QbBrTt6uPtDp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleehheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhnghhhrghosegsrg
    hmrghitghlohhuugdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhht
    rdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrd
    gthhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JU4faM_2mKcXMpiT3VXv3jF4XsykiuCaDXYLU68-WyyWO1nq7a18lg>
    <xmx:JU4faHvU9g531X9QI3P4xi0cQnVsvXTahNtVXP6p0_FrD7dw-m-fLQ>
    <xmx:JU4faLGWSS7MZ7_AB6k17VpXVTSw1ioFkhgZ1j7FeXX6jZqxbX0-pA>
    <xmx:JU4faOPAga6Lnjgn64CyZ2n3HOCeKW5sqPlaQlSlmsDlgelT96CBMg>
    <xmx:Jk4faAmLVlPNJXAJIJjpIrHOyfPRrUp2rhTRinik7DTn3vBeH-C1yX5S>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 May 2025 09:01:24 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id ECC201C007C; Sat, 10 May 2025 06:01:21 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id EAC811C007B;
	Sat, 10 May 2025 15:01:21 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: tonghao@bamaicloud.com
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 3/4] net: bonding: send peer notify when failure recovery
In-reply-to: <20250510044504.52618-4-tonghao@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com> <20250510044504.52618-4-tonghao@bamaicloud.com>
Comments: In-reply-to tonghao@bamaicloud.com
   message dated "Sat, 10 May 2025 12:45:03 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1133779.1746882081.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 May 2025 15:01:21 +0200
Message-ID: <1133780.1746882081@vermin>

tonghao@bamaicloud.com wrote:

>From: Tonghao Zhang <tonghao@bamaicloud.com>
>
>While hardware failures in NICs, optical transceivers, or switches
>are unavoidable, rapid system recovery can be achieved post-restoration.
>For example, triggering immediate ARP/ND packet transmission upon
>LACP failure recovery enables the system to swiftly resume normal
>operations, thereby minimizing service downtime.

	I think this comment needs to be prefaced with something that
explains that this logic is for the "no stack" architecture.  It don't
need the entire blurb about what that is, though.

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
> drivers/net/bonding/bond_3ad.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c6807e473ab7..6577ce54d115 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -982,6 +982,19 @@ static int ad_marker_send(struct port *port, struct =
bond_marker *marker)
> 	return 0;
> }
> =

>+static void ad_peer_notif_send(struct port *port)
>+{
>+	if (!port->aggregator->is_active)
>+		return;
>+
>+	struct bonding *bond =3D port->slave->bond;
>+	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>+		bond->send_peer_notif =3D bond->params.num_peer_notif *
>+			max(1, bond->params.peer_notif_delay);
>+		rtnl_unlock();
>+	}
>+}
>+

	I'm not a fan of the function name, as this doesn't actually
send any notifications.  Perhaps "ad_cond_set_peer_notif"?  I.e.,
conditionally set peer notifications on?

> /**
>  * ad_mux_machine - handle a port's mux state machine
>  * @port: the port we're looking at
>@@ -1164,6 +1177,7 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 			port->actor_oper_port_state |=3D LACP_STATE_COLLECTING;
> 			port->actor_oper_port_state |=3D LACP_STATE_DISTRIBUTING;
> 			port->actor_oper_port_state |=3D LACP_STATE_SYNCHRONIZATION;
>+			ad_peer_notif_send(port);
> 			ad_enable_collecting_distributing(port,
> 							  update_slave_arr);
> 			port->ntt =3D true;

	This is in the AD_MUX_COLLECTING_DISTRIBUTING case, I think you
need another one of these in the AD_MUX_DISTRIBUTING case a few lines
further down to handle the situation when coupled_control is disabled.

	-J

>-- =

>2.34.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

