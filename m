Return-Path: <netdev+bounces-198356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD15ADBE20
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C42188D691
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514E15A85E;
	Tue, 17 Jun 2025 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="b2ZMZ2N0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n4y18LxS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8101494A9
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120138; cv=none; b=nXT7qk4Q7D9ynsZ2lNqA2dc2b3lUYX/+C25qBzBu0MhJRDje67QIrBARNS2A1vEZrGltEH5/Z0w4T1hoLLrYVDWO3sSmZnsUCXe5NEtNm8kvegoRjJYawsD9orFwrrRNR7oWDEwoggFxJmSmAWMmtfdJfDdIeMnivDV/ZOwBmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120138; c=relaxed/simple;
	bh=ac/MxxOu3LJfvFlSmFbH9GJMvEK+Sz63pZKUF/Fxpvw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=IjufHEQylzAiSiPp/R7T14oJ0dS14hX/sEG30LyscWebPKKJOirDowcL56sICoOJ5lhqI7JaK/khyUuKVN0mT8xY289mvNAPCUPWSPjvPgUkdV0TuEAHu5v5MeK7KxkWTSgpD631LtBbGD838FrkLQ1oMofPk/1wSu7EgeLhZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=b2ZMZ2N0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n4y18LxS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 79A06114016E;
	Mon, 16 Jun 2025 20:28:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Jun 2025 20:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750120133; x=1750206533; bh=el+hE7re0j5/KipqUc0Lh
	emW9EFu9H9uCZGYMaiv+UI=; b=b2ZMZ2N0spBTfmxkB77I1R5NbRtLahNejwxsR
	kd8OpYdWH4d2YOC0IH+vM9BeNEkGjaLVsUXhdCuHEGFr7bw86SdUGP2ylI8nHkI8
	5q84iTDjDniaP9Q7Mmb7yb13NCBGO7TXGei/Nd6xgfA8X0tH5YoQC/Scsql3mU5Z
	pJZI4xXXfIOJ4MViYaXurpDyQpUXqscXjHjcG/P1rAYB5Nv1Tbe/cwZLo586kcSE
	Pz1xfucYwBjk8VoqaDm9+aRvoJm3GP1gaDm6SnRPygjHEJ+Mpt+LTAm4eT94aUNg
	8grFcCoszGhPIzu1mUcbKHatdAIQlEZ0zIwpiZuidTJzeEwEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750120133; x=1750206533; bh=el+hE7re0j5/KipqUc0LhemW9EFu9H9uCZG
	YMaiv+UI=; b=n4y18LxSP40onvnBBMloyW1AojynNM/JaqsyhVjyAX5sC2PpwYH
	e+eRj5Be4GQB4b0RmW9mcdiOoS/YErsH26SvBEWWQz5dZNGqwoI8AycYdVCGs/by
	fzzkmuP6AEVatIgq74yjM+NU1PhLaisuciYf0B438Il5Ej9kQ6/CTUUoVpfuImO9
	3R2uqa6xhHRBj4bvvqnKigaNFpqNlv53x72n6T9E4pl/aniFsGMqrgpefC0BUu2J
	R0IawbIyh2HQwb/xbu0PCy+1LlAeEES+pGqBVgHbBOTJaZ7h9PL4YXIHR+MgxGaF
	jF/xSUziozb9hemxCnplNIwkeanvIkyyEhw==
X-ME-Sender: <xms:xLZQaOmOFU9nvKumVPWe74sXkJkGlxspSLpuywPaBkoDbT0vFP9RRQ>
    <xme:xLZQaF1LVR9Jyy8BNU_udZr_6BK5FSq35dbAEwsRWK4ZSRxOhSYxLwyTRQXDBSirX
    BOrECJm_OvDf1P6tqw>
X-ME-Received: <xmr:xLZQaMr8IhB5PpvYS4LQDsv0-PIitgvurJdqEmrr8sac-fGLFcb4DXCCt8pq-1SUkXRpPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkedtvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:xLZQaCmKHslvzzyGrll07lfBoH4zr-euxBbqHsgbTVxvgY5WZWEolQ>
    <xmx:xLZQaM1tMTpIXo06Yaz07sW56TQXtQPFo6OPigAXqmjyos1MQlxwaA>
    <xmx:xLZQaJuKlK9llhzFrOH19T_5bhU0KEFTBG6VyYKItpIJuguY3hBC7g>
    <xmx:xLZQaIXXR9rsQt2jFepOCKokDnz2zpa68D-JKyIzaXvhGO7u8K6DJQ>
    <xmx:xbZQaLkTa593VPk0yR5uerK4VS3udoV4AJ_LuKE7072VdHaZ4WVoV-mH>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 20:28:51 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A89529FCA6; Mon, 16 Jun 2025 17:28:50 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A782B9FC54;
	Mon, 16 Jun 2025 17:28:50 -0700 (PDT)
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
Subject: Re: [net-next v6 4/4] net: bonding: add tracepoint for 802.3ad
In-reply-to: 
 <10b8f570bd59104a1c7d5ecdc9a82c6ec61d2d1c.1749525581.git.tonghao@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <10b8f570bd59104a1c7d5ecdc9a82c6ec61d2d1c.1749525581.git.tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Tue, 10 Jun 2025 11:44:45 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1931180.1750120130.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 17:28:50 -0700
Message-ID: <1931181.1750120130@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>Users can monitor NIC link status changes through netlink. However, LACP
>protocol failures may occur despite operational physical links. There is
>no way to detect LACP state changes. This patch adds tracepoint at
>LACP state transition.

	This patch really has nothing to do with the rest of the series
(it's unrelated to the broadcast_neighbor functionality), and should
really be sent separately.

	That said, I recall asking about work that was proposed some
time ago to create netlink events (visible to ip monitor, et al) when
the LACP state changes.  That would be a cleaner method to watch the
LACP state machine (as it would integrate with all of the other event
infrastructure).  Maybe I missed the response, but what became of that
work?

	-J

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

---
	-Jay Vosburgh, jv@jvosburgh.net

