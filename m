Return-Path: <netdev+bounces-278134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMqMNOgf3WndaAkAu9opvQ
	(envelope-from <netdev+bounces-278134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:55:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426323F0368
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1195A305BF24
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19605317152;
	Mon, 13 Apr 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="im0rD0z6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dbiZbLEV"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F43313298
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098762; cv=none; b=T3gwLpUaKastWy5qibgkUCrO3mJ1CjdqrLgNdIz+ngr/urCjxbBGptIvg1wHKOrHZ4XQRu+WB2sbhKpEa6eV8mbXq+P/BqKPg9QZZD8tXgw3AW+jSDbeDH5ytIAz2O45P8gtdV3buTlbhSfP+Qy0keLaYdQQDPHD02c3wt6OgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098762; c=relaxed/simple;
	bh=ks/h8kKRIxM9eYMSTC/WFZyr3P+CDhBfwY6m8vIEBKY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dvjwV+S1yGAfKF+tluNOPPQFEGQmhd8VL7TD+IxVC9Bepz6Sl+ftxW0F5fFmlT1zePvehMOThDMzLYNeZhcvhU2DvB9Pkk5WH0QRoayuuefHltFj4v4rGLnjGnXe8a8LhIKeOpKZ21dTXrEE9SP4NX3ssq7rH3HmYqSMFrsWa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=im0rD0z6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dbiZbLEV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7A8E14001B2;
	Mon, 13 Apr 2026 12:45:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 13 Apr 2026 12:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1776098759; x=1776185159; bh=Zj135ObTC51LwxtAXVczu
	Bb99xTUq3VRKVHE+FXFb9I=; b=im0rD0z6h4cAZz5GS5HMqKbPaGWXJIf6gaDn2
	nJ8C0QwSZazL6MlIgTL3Yt1huvlOOMs0QGXkrzmiB8ZdDVNjSSOYtXvqPDACDQUv
	qIBiIsmQvqWQ3iVVMAzSeHygeWUj6tuXfTWQjAdorikHXO7J51RvfkvrKCbvjmAj
	XXH9bLZShjv4QO+au6Da91eGo3y9a1BwYA9mfnay19wNdOMhTPXbx4DIUrTJd1VN
	Rzcw9XnfEBGAiR4pvorRXRv+Ug3ejso7RVVObeoBLDpwAQY370tW9W3oP5z4/Jkb
	kmt+TyOnZP1KBxrs3RbnmgAe5HHqZXpVEx4k5gMsCYJoq8Ilg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776098759; x=1776185159; bh=Zj135ObTC51LwxtAXVczuBb99xTUq3VRKVH
	E+FXFb9I=; b=dbiZbLEVs4rkFexojKEym4+ohkWteNVmnEQiXOo1ARsSdTvEaVJ
	qMhm4vU9gaFOliE27nucjPEykb4dmbCnEuahCKWKa5k58242lp4U89rgYP/5cjVF
	aJFDnD1SiV5uuKWusVGjC1dxg9SY62VkAyhyUmRjYbuC8rh9ornI84DTLHQKsZLx
	UTB8cdDchaqij+2EmfYrnh8cHbbjZk8EscZ54izQyMiAn/ldpyBRuYtUBHBBB+P6
	iinRTfH+rY2s2SeSHtVjPsQtHBYImyXQua78f/PU0LxSA6EU8xJkXEIcQogF5z4I
	yl8NdLv1FiQvSAdVwgsxZWizxj9Q0LrUWiQ==
X-ME-Sender: <xms:xx3daTyeooUZWlq8_1I8VQ3TF2bz5gIuppfQw4NuTRvhoxmvue4nbw>
    <xme:xx3daX0ug1-h9MOn9GKnvQ81Rg7YXeTRsP6QQzRxKZt8PH4l1bEI7YfejLtQwQOmr
    0TDw80DpLYHCW_MGp3rEDl2LP9lN02DLUhOHT4wAM4putUoG1onvzQ>
X-ME-Received: <xmr:xx3daRxSgTtHBZ-8fByHSriQO5IyZIto75ag8K07NUL_DXwpgNi3iO8_BzBS_ZroAAix7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    mhgrhhgvshhhsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnugihsehgrhgvhi
    hhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepfh
    gslhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xx3daUUfGrCsxgFiT2YzH_3lxNl7O-znV1ZOCDHnjQe9FyZsVDZV4g>
    <xmx:xx3daV8m8Xi8SKh5QfaqM8r9rI9R8l6LAeEsfgsfGUev2lwYDVzfIQ>
    <xmx:xx3dafsnvcGdBeeGQ4OVW4gG7UZJ0w20kcTQRD9WeUJTz-d26Q0HNw>
    <xmx:xx3dad3wmYjqA5rl2OuAQK0HsSGru-e6whID-uXqZeQPlLCnnvK96A>
    <xmx:xx3daT41XcNrRhXl5FWvhPDiD0awaNTu0zQ2IGLCp3gXkkvAi7fKB2Kq>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:45:58 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 277989FB3D; Mon, 13 Apr 2026 09:45:58 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 266CE9FB3C;
	Mon, 13 Apr 2026 09:45:58 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 1/5] bonding: 3ad: add lacp_fallback configuration
 knob
In-reply-to: <20260408152353.276204-2-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-2-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 08 Apr 2026 17:23:49 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <707554.1776098758.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 09:45:58 -0700
Message-ID: <707555.1776098758@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278134-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 426323F0368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>When an 802.3ad (LACP) bonding interface has no slaves in the
>collecting/distributing state, the bonding master still reports
>carrier as up as long as at least 'min_links' slaves have carrier.
>
>In this situation, only one slave is effectively used for TX/RX,
>while traffic received on other slaves is dropped. Upper-layer
>daemons therefore consider the interface operational, even though
>traffic may be blackholed if the lack of LACP negotiation means
>the partner is not ready to deal with traffic.
>
>Introduce a configuration knob to control this behavior. It allows
>the bonding master to assert carrier only when at least 'min_links'
>slaves are in collecting/distributing state (or collecting only
>when coupled_control is disabled).
>
>The default mode preserves the current (legacy) behavior. This
>patch only introduces the knob; its behavior is implemented in
>the subsequent commit.
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> Documentation/networking/bonding.rst | 33 ++++++++++++++++++++++++++++
> drivers/net/bonding/bond_main.c      |  1 +
> drivers/net/bonding/bond_netlink.c   | 16 ++++++++++++++
> drivers/net/bonding/bond_options.c   | 26 ++++++++++++++++++++++
> include/net/bond_options.h           |  1 +
> include/net/bonding.h                |  1 +
> include/uapi/linux/if_link.h         |  1 +
> 7 files changed, 79 insertions(+)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index e700bf1d095c..465d06aead27 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -619,6 +619,39 @@ min_links
> 	aggregator cannot be active without at least one available link,
> 	setting this option to 0 or to 1 has the exact same effect.
> =

>+lacp_fallback
>+
>+	Specifies the fallback behavior of a bonding when LACP negotiation fail=
s on
>+	all slave links, i.e. when no slave is in the Collecting/Distributing s=
tate
>+	(or only in Collecting state when coupled_control is disabled), while a=
t
>+	least `min_links` link still reports carrier up.
>+
>+	This option is only applicable to 802.3ad mode (mode 4).
>+
>+	Valid values are:
>+
>+	legacy or 0
>+		In this situation, the bonding master remains carrier up and
>+		randomly selects a single slave to transmit and receive traffic.
>+		Traffic received on other slaves is dropped.
>+
>+		This mode is deprecated, as it may lead to traffic blackholing
>+		when the absence of LACP negotiation means the partner is not
>+		ready to collect and distribute traffic.
>+
>+		This is the legacy default behavior.
>+
>+	strict or 1
>+		In this situation, the bonding master reports carrier down, allowing
>+		upper-layer processes to detect that the interface is not usable for
>+		collecting and distributing traffic.
>+
>+		The master transitions to carrier up only when at least
>+		`min_links` slaves reach the Collecting(/Distributing) state,
>+		allowing traffic to flow.
>+
>+	The default value is 0 (legacy).
>+

	1- Please wrap text at approximately 75 columns.

	2- I don't agree with the nomenclature or language of the above.
The existing behavior is not going to be deprecated or considered to be
legacy, and the option nomenclature should reflect that.  I would
suggest naming the option "lacp_strict" and having it's possible
settings be on or off, with the default setting as off.

	I think the behavior can be described along the lines of

	off or 0
		One interface of the bond is selected to be active, in
		order to facilitate communication with peer devices that
		do not implement LACP.

	on or 1
		Interfaces are only permitted to be made active if they
		have an active LACP partner and have successfully reached
		Collecting or Collecting_Distributing state.

	The default is value is 0 (off).

	-J


> mode
> =

> 	Specifies one of the bonding policies. The default is
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index a5484d11553d..02cba0560a39 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6440,6 +6440,7 @@ static int __init bond_check_params(struct bond_par=
ams *params)
> 	params->ad_user_port_key =3D ad_user_port_key;
> 	params->coupled_control =3D 1;
> 	params->broadcast_neighbor =3D 0;
>+	params->lacp_fallback =3D 0;
> 	if (packets_per_slave > 0) {
> 		params->reciprocal_packets_per_slave =3D
> 			reciprocal_value(packets_per_slave);
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index 286f11c517f7..1f92ad786b51 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -130,6 +130,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_=
MAX + 1] =3D {
> 	[IFLA_BOND_NS_IP6_TARGET]	=3D { .type =3D NLA_NESTED },
> 	[IFLA_BOND_COUPLED_CONTROL]	=3D { .type =3D NLA_U8 },
> 	[IFLA_BOND_BROADCAST_NEIGH]	=3D { .type =3D NLA_U8 },
>+	[IFLA_BOND_LACP_FALLBACK]	=3D { .type =3D NLA_U8 },
> };
> =

> static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1=
] =3D {
>@@ -586,6 +587,16 @@ static int bond_changelink(struct net_device *bond_d=
ev, struct nlattr *tb[],
> 			return err;
> 	}
> =

>+	if (data[IFLA_BOND_LACP_FALLBACK]) {
>+		int fallback_mode =3D nla_get_u8(data[IFLA_BOND_LACP_FALLBACK]);
>+
>+		bond_opt_initval(&newval, fallback_mode);
>+		err =3D __bond_opt_set(bond, BOND_OPT_LACP_FALLBACK, &newval,
>+				     data[IFLA_BOND_LACP_FALLBACK], extack);
>+		if (err)
>+			return err;
>+	}
>+
> 	return 0;
> }
> =

>@@ -658,6 +669,7 @@ static size_t bond_get_size(const struct net_device *=
bond_dev)
> 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
> 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
> 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_BROADCAST_NEIGH */
>+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_LACP_FALLBACK */
> 		0;
> }
> =

>@@ -825,6 +837,10 @@ static int bond_fill_info(struct sk_buff *skb,
> 		       bond->params.broadcast_neighbor))
> 		goto nla_put_failure;
> =

>+	if (nla_put_u8(skb, IFLA_BOND_LACP_FALLBACK,
>+		       bond->params.lacp_fallback))
>+		goto nla_put_failure;
>+
> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> 		struct ad_info info;
> =

>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 7380cc4ee75a..b672b8a881bb 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -68,6 +68,8 @@ static int bond_option_lacp_active_set(struct bonding *=
bond,
> 				       const struct bond_opt_value *newval);
> static int bond_option_lacp_rate_set(struct bonding *bond,
> 				     const struct bond_opt_value *newval);
>+static int bond_option_lacp_fallback_set(struct bonding *bond,
>+					 const struct bond_opt_value *newval);
> static int bond_option_ad_select_set(struct bonding *bond,
> 				     const struct bond_opt_value *newval);
> static int bond_option_queue_id_set(struct bonding *bond,
>@@ -162,6 +164,12 @@ static const struct bond_opt_value bond_lacp_rate_tb=
l[] =3D {
> 	{ NULL,   -1,           0},
> };
> =

>+static const struct bond_opt_value bond_lacp_fallback_tbl[] =3D {
>+	{ "legacy", 0, BOND_VALFLAG_DEFAULT},
>+	{ "strict",  1, 0},
>+	{ NULL, -1, 0 }
>+};
>+
> static const struct bond_opt_value bond_ad_select_tbl[] =3D {
> 	{ "stable",          BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
> 	{ "bandwidth",       BOND_AD_BANDWIDTH, 0},
>@@ -363,6 +371,14 @@ static const struct bond_option bond_opts[BOND_OPT_L=
AST] =3D {
> 		.values =3D bond_lacp_rate_tbl,
> 		.set =3D bond_option_lacp_rate_set
> 	},
>+	[BOND_OPT_LACP_FALLBACK] =3D {
>+		.id =3D BOND_OPT_LACP_FALLBACK,
>+		.name =3D "lacp_fallback",
>+		.desc =3D "Define the LACP fallback mode when no slaves have negotiate=
d",
>+		.unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>+		.values =3D bond_lacp_fallback_tbl,
>+		.set =3D bond_option_lacp_fallback_set
>+	},
> 	[BOND_OPT_MINLINKS] =3D {
> 		.id =3D BOND_OPT_MINLINKS,
> 		.name =3D "min_links",
>@@ -1684,6 +1700,16 @@ static int bond_option_lacp_rate_set(struct bondin=
g *bond,
> 	return 0;
> }
> =

>+static int bond_option_lacp_fallback_set(struct bonding *bond,
>+					 const struct bond_opt_value *newval)
>+{
>+	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
>+		   newval->string, newval->value);
>+	bond->params.lacp_fallback =3D newval->value;
>+
>+	return 0;
>+}
>+
> static int bond_option_ad_select_set(struct bonding *bond,
> 				     const struct bond_opt_value *newval)
> {
>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index e6eedf23aea1..5eb64c831f54 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -79,6 +79,7 @@ enum {
> 	BOND_OPT_COUPLED_CONTROL,
> 	BOND_OPT_BROADCAST_NEIGH,
> 	BOND_OPT_ACTOR_PORT_PRIO,
>+	BOND_OPT_LACP_FALLBACK,
> 	BOND_OPT_LAST
> };
> =

>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 395c6e281c5f..d8cb02643f8b 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -132,6 +132,7 @@ struct bond_params {
> 	int peer_notif_delay;
> 	int lacp_active;
> 	int lacp_fast;
>+	int lacp_fallback;
> 	unsigned int min_links;
> 	int ad_select;
> 	char primary[IFNAMSIZ];
>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>index e9b5f79e1ee1..7ad3fc600c71 100644
>--- a/include/uapi/linux/if_link.h
>+++ b/include/uapi/linux/if_link.h
>@@ -1539,6 +1539,7 @@ enum {
> 	IFLA_BOND_NS_IP6_TARGET,
> 	IFLA_BOND_COUPLED_CONTROL,
> 	IFLA_BOND_BROADCAST_NEIGH,
>+	IFLA_BOND_LACP_FALLBACK,
> 	__IFLA_BOND_MAX,
> };
> =

>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

