Return-Path: <netdev+bounces-190663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E98AB829C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71973A580B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3521B3F3D;
	Thu, 15 May 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LqNIjSrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmzF7MQI"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FC46B8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301424; cv=none; b=E6G6FO14/mCsdBsvgjuo8KCpCgPOIA7T3H64Y/xZ2OqALb+x9FFkyRburD03iarzQLZNimb3wIMORtrAuFEICD2s4vvjljCJRo+oy0rV3u4qZqz85CrCaeqJhhcHZpb2uAVphbCdaaRDumAaT99kvULCRWIuflhrmY0nH4XpxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301424; c=relaxed/simple;
	bh=bYvEtPvmXnP4SbtSqemWse3Np2uAh9nejY99WJoroXA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=K8UfHzdYKFcPQ7DgPZD137fDGgMgS4F9X9HamMNrWz4jj9l8MQPQqvK4sBe3qlPChgh0ZGmkqVE02Jiz/pAxluHMgBWiaY7Wa+joY/ORSIkgBU9MlUSvfhvxgYDCcro+WKdsY9r2Oub4T/PFj/cuOCKu1kycdYX32AvfYO25dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LqNIjSrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmzF7MQI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B113F11400F9;
	Thu, 15 May 2025 05:30:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 May 2025 05:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1747301417; x=1747387817; bh=aUqCHZDZgc5+gZ1AYSnTX
	wJiisJw5ic5vj9RDmqpntA=; b=LqNIjSrUAw2/G/5FQ1MTJUS862lxhzC0HNEQx
	hb3wwNuz1r1SKFOknFciLw/1wI+Z1oCoxKQCPveVpUgAgGXjdV+wWqVccmJz/4Hv
	XVOd4fgr54Xy2567XnSXyNgcGFOK6f6IThjH+fliDdIhHUymjleRalUEV2X3e7NM
	MWwo/CZ6MW69LQ5UOuLzIlRlX645w7DR6nkkDR1qFenLzLnW/OveDwLz3bEuEyqJ
	gOhtmsQYS4sNSG42TLFaIdXV8Aio36lK4TWk9Tbmw5hsORnfu1LzGPItFZwbDAGg
	6+mIYjI7KwQQ77+xEYEVV6bYSLxG0PKjafxiRzTaXExKhlKvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747301417; x=1747387817; bh=aUqCHZDZgc5+gZ1AYSnTXwJiisJw5ic5vj9
	RDmqpntA=; b=AmzF7MQI/ICj3UfdodJ5DtKETVuWtoyE9VOKdimk/mLQmmtZI2F
	TOo73oB6RLcFdjKqQoYwHLwsPdamSGuDfWPNGTX9cANcXiW/05TxsT1KokaOF6lk
	d4bu27Er1S9rMw0lQ7Bg+YTFTlk91nfzcMoyaLkTBUHlXwc/iX3He+/FO0Vh9xbe
	MN5mDtTsN2j7CHhYwTlRo9ozOIh4r5bAByi+zGkwcO/aEI3vt2NpvgBvmkL8sV5B
	pqKNHepbJH96scZJYPgc5Hy7/Wdo37pmLpa4b6M1obILoxCLyVzqxsBs3UVlhOF+
	YIodwcE3KkUna7mCvKVSmXR17q0XzhzZMug==
X-ME-Sender: <xms:KLQlaD70hu-b4ZdJpcqya3Z0c3Eet01B0mrV_WYWwxZ45PZJ8Zn_qg>
    <xme:KLQlaI7OA3EMe1BYmx5MMuKnOw5C5LqmGBzRCI2HZCCF6fkoM9IgCGUMjoBapJDTH
    _v57oTLWWqnPaUvfJU>
X-ME-Received: <xmr:KLQlaKfeehBy2yHoMu9JJsKms4BJKqldQqhdYH_wTUjbw4ohSmLdb7sHxKnatGBYw5qBKSm->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhonhhghhgrohessg
    grmhgrihgtlhhouhgurdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopehtuhiivghnghgsihhnghesughiughighhlohgsrghlrd
    gtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgt
    hhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:KLQlaEJDMsHHQn9epKG4g2P3q2Ly__KE5ndSr99GWCdfz7kkNiNCdg>
    <xmx:KLQlaHKz7-OZjvwxuBVSMiDYnsZhibscdHTY1nrzh9sdsL4V_maETQ>
    <xmx:KLQlaNxvRjJAWymmwyZiIXQYv9Owk0qmfcn7sa7pQs8wEaPm8-xkog>
    <xmx:KLQlaDLa6glVMPAW89x33yV5Iy45f9dNNVPDVEbnYqrgJfsvIdd4mw>
    <xmx:KbQlaJfMT3PzAC9GCCF_pDBGDarruzB-dR1wG-o4Y_NPkD9Lte0GtBCU>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 05:30:16 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 3159F1C0469; Thu, 15 May 2025 11:30:14 +0200 (CEST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 2F3AD1C0468;
	Thu, 15 May 2025 11:30:14 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next v4 4/4] net: bonding: add tracepoint for 802.3ad
In-reply-to: <DDF908383E15A2CE+20250514092534.27472-5-tonghao@bamaicloud.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com> <DDF908383E15A2CE+20250514092534.27472-5-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Wed, 14 May 2025 17:25:34 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28673.1747301414.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 May 2025 11:30:14 +0200
Message-ID: <28674.1747301414@vermin>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>Users can monitor NIC link status changes through netlink. However, LACP
>protocol failures may occur despite operational physical links. There is
>no way to detect LACP state changes. This patch adds tracepoint at LACP s=
tate
>transition.
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
> drivers/net/bonding/bond_3ad.c |  6 ++++++
> include/trace/events/bonding.h | 37 ++++++++++++++++++++++++++++++++++
> 2 files changed, 43 insertions(+)
> create mode 100644 include/trace/events/bonding.h
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index d1c2d416ac87..55703230ab29 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -16,6 +16,9 @@
> #include <net/bond_3ad.h>
> #include <net/netlink.h>
> =

>+#define CREATE_TRACE_POINTS
>+#include <trace/events/bonding.h>
>+
> /* General definitions */
> #define AD_SHORT_TIMEOUT           1
> #define AD_LONG_TIMEOUT            0
>@@ -1146,6 +1149,9 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 			  port->actor_port_number,
> 			  last_state,
> 			  port->sm_mux_state);
>+
>+		trace_3ad_mux_state(port->slave->dev, last_state, port->sm_mux_state);
>+

	First, wasn't someone trying to integrate the LACP state changes
into the usual "ip monitor" netlink notifications?  What happened to
that?

	Second, the "3ad" nomenclature is obsolete; it refers to the
original IEEE 802.3ad standard, which was replaced by 802.1AX in 2008.
Most of the time, though, folks refer to this as "LACP."  Anyway, my
point here is that the name, assuming we go with a tracepoint, should
have "lacp" in it instead of "3ad."

	-J

> 		switch (port->sm_mux_state) {
> 		case AD_MUX_DETACHED:
> 			port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>diff --git a/include/trace/events/bonding.h b/include/trace/events/bondin=
g.h
>new file mode 100644
>index 000000000000..1ee4b07d912a
>--- /dev/null
>+++ b/include/trace/events/bonding.h
>@@ -0,0 +1,37 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+
>+#if !defined(_TRACE_BONDING_H) || defined(TRACE_HEADER_MULTI_READ)
>+#define _TRACE_BONDING_H
>+
>+#include <linux/netdevice.h>
>+#include <linux/tracepoint.h>
>+
>+#undef TRACE_SYSTEM
>+#define TRACE_SYSTEM bonding
>+
>+TRACE_EVENT(3ad_mux_state,
>+	TP_PROTO(struct net_device *dev, u32 last_state, u32 curr_state),
>+	TP_ARGS(dev, last_state, curr_state),
>+
>+	TP_STRUCT__entry(
>+		__field(int, ifindex)
>+		__string(dev_name, dev->name)
>+		__field(u32, last_state)
>+		__field(u32, curr_state)
>+	),
>+
>+	TP_fast_assign(
>+		__entry->ifindex =3D dev->ifindex;
>+		__assign_str(dev_name);
>+		__entry->last_state =3D last_state;
>+		__entry->curr_state =3D curr_state;
>+	),
>+
>+	TP_printk("ifindex %d dev %s last_state 0x%x curr_state 0x%x",
>+		  __entry->ifindex, __get_str(dev_name),
>+		  __entry->last_state, __entry->curr_state)
>+);
>+
>+#endif /* _TRACE_BONDING_H */
>+
>+#include <trace/define_trace.h>
>-- =

>2.34.1
>
>

---
	-Jay Vosburgh, jv@jvosburgh.net

