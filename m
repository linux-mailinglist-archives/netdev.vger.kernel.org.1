Return-Path: <netdev+bounces-296736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gOGSD0E2J2qAtQIAu9opvQ
	(envelope-from <netdev+bounces-296736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:38:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE665AB37
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:38:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jvosburgh.net header.s=fm2 header.b=fIWuhia7;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=ffCugiVi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296736-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=jvosburgh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5223020D76
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E83AEF59;
	Mon,  8 Jun 2026 21:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD628394793
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:37:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954646; cv=none; b=QiUrxW6v+mxs15SvuOdtI5gtNWzBd64gdQwE1UhpcTQ6e0Nw0xAzpQU+1rfE1ZanpYJIrWcYcISTRDSMECgeajtlJJ+IzrkLgI5roazlQNYN0ExgdwAT5Beh/+Mk0+s8Ho+uNJroVhXLM4p9scMZJpx1N5PQ3Egmyu78UKTd97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954646; c=relaxed/simple;
	bh=NzmzpcurZ6tos4/4NlLfYYB4IKEEF3+X7raO1WddR8Q=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=D3V6OmKnGASJbV3oryFn1HmyZ/AxA0gUuJw6Gti0qdGOzDI5cviDSd/gTr00ZJm6h4I0vdLiXHN5EQSBC6fs0nP5QIs6T+rfHJTZExOeW/6DcJiEyZMgcm1H16o+pNvhAX1KzgRCESFkSG3Exa32rUVDfVN4n1tfgf5FvGFXu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=fIWuhia7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffCugiVi; arc=none smtp.client-ip=103.168.172.157
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 238491400077;
	Mon,  8 Jun 2026 17:37:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 17:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1780954644; x=1781041044; bh=+kLpmCziW1IqlS23DUjG6
	8dKYgm3aLvpO0HfQHtid68=; b=fIWuhia7lD8jC0/esio2bWx2ENer2hODy8T2S
	3QkVRJXtdKGUXUT5e7Irv1pRDnSmNeKsOu8CJCTwGp3l83ojRnxhvw9noh3xNUn0
	SddHbvyDJvjJ/WVV4HuVt4sQm52nvevOwH8pb+ZaSUf2XOICLC/LNFhWSFHdHuT5
	pGSO+ll1nCIiEVTvm4SoGBlpBqt6HtZYZ0vVp49dpk7E6svpE1kGFTSNfgVmo8uN
	S6ONpCJeA0vXuUx/6n5mSnVTPumODw5clKlqkgpBUsG6TbMx/W8nFAZzjgP/57gT
	nBcHpLUSwkufkIDf/cg2PuGJ90tVBYkAhVEJzYMsUAhe5e4XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780954644; x=1781041044; bh=+kLpmCziW1IqlS23DUjG68dKYgm3aLvpO0H
	fQHtid68=; b=ffCugiViCbdi64lcXFrY/+z9WEfnhEgA1jEe56d/WIoTdrG+kgk
	QK+svOOgK8RBudPN8/HP93oqd5JtRvABUsMHgsWbJqH8T+1yA4yilHehyALkIrUs
	tjpzoR1+e8SjYEXoPokaRXEs3weRbj6gY9F1yu5parBK+FfDe3Z02Fvdq/cMAASS
	rOZjkuBtVWyu4UnbRhfIk+Sgxthuq/DLuqhBLu4AR9C00nHPvLkPpegquvABQfaf
	DaTyRrIIQl2MubUAgGqVapoHoVAee42Kszz7E9G6VTmN7tEsh+J07GH7ckYF5VBC
	XTUJ2/NkH1JrJal46/id2ue7hHSwVbhMfcw==
X-ME-Sender: <xms:EzYnaqzR2Xumbuid3SFQzBlqcKZL_SLZNWPypRchOgHBkGUKywCxsA>
    <xme:EzYnaiE54J3WBsTFJ9x8_D2hcalTKd5KBPzNATtdfAysOcDqWQvPI1LdeegPjssB7
    c8m2CBwrbr8IbrE32WKyxRgFjw5saVKMURbCR9u04X7YBf7evSgLiw>
X-ME-Received: <xmr:EzYnansyibyo1FMISLpDn9Shfsgqxjyha9UvyOxCRdlfAXN07X-cj5hHwEXGO5B0Bspcgw>
X-ME-Proxy-Cause: dmFkZTEvJdzo4XO5EwvRLePZwnvJ3thpEh8fpGC9pndLry1OAlUNMG8kxEhoSIdzgbX2Hg
    BzEqUHgnNHQO1DHo1Lg0c54QMCEP6suyANf/tosKcEOd9UHLCKC6fO16VFbt68s7KWObBj
    N5wsmh+kMEke3yLc4IhLrEowVL63noRDXlQk9gTYyR83aES+/zQVti7UDTuImET6Bxg+Us
    1Swugzhpkf9nU+EQV97UI3DDATewu0InHUus3W633H3FzD240Ud7sUl/6aZ6PCnaDG6IqK
    IZZVTf16B4WUvb+jXZwpFluDpEgnC3IPlX0bOD/0aNVWgT1hd5GwQLB0yhtQonPNw+BULU
    Zgk4nWXvo7vSPTK6n1JhoPGU+pK/dqAJexMA5qGtOs/v0JobsBk4wtzZ6g16VxO31GwLUH
    IbnuCDx2ybq/uAQzoRzY+kRMmoIW0/VVxjry/46WBD16B51UupO/ry9zZ3xDqyefUeVoNE
    APcCMmJSMfAhtvn0e7d27tSBntxGqo3ujZjivPfqXbnlxdC3+AQpZWSDL+vQytO+ky2dh1
    KW/48f+TtroE3dhikIG8+PZzbdPzBrdhm/ubwxQjb3FZ7Ttk6m/NNw5vOcKQWHrvNsTZjE
    UoKA0IVddBXCpNUk385Kk1+PWpT5BAcCYuyWTci3ID68D9Fl0/DbIvG0HiVQ
X-ME-Proxy: <xmx:EzYnaqA91-_PbyCXASUcZxxUb5LtfXyBKB4pwU65F3Hvj-C_nWFmQA>
    <xmx:EzYnaqCTDVasMog9sdHmBR56AP61UFwGVwIgYgQIwvSH4NS96E-mpQ>
    <xmx:EzYnasps6NgaXhdPT0JcuFJ533bVyLisIBSly1lErON6EiFphXSCSw>
    <xmx:EzYnatHbhGwIERRDsj_d913ldYejA-OQW8X475HUkZ7RDRTYLVvnjA>
    <xmx:FDYnarRvlGZkJ92X-AUlHYvtBA5rx11rdZDm8mOEtqKRAkbnz1VI1OQp>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 17:37:23 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 6BEFE9FC5D; Mon,  8 Jun 2026 14:37:22 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 69A379FB80;
	Mon,  8 Jun 2026 14:37:22 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
    jonas.gorski@gmail.com, horms@kernel.org
Subject: Re: [PATCH net v8 4/6] bonding: 3ad: fix carrier when no usable
 slaves
In-reply-to: <20260603150331.1919611-5-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
 <20260603150331.1919611-5-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 03 Jun 2026 17:03:29 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1041443.1780954642.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:37:22 -0700
Message-ID: <1041444.1780954642@famine>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,famine:mid,vger.kernel.org:from_smtp,6wind.com:email,jvosburgh.net:dkim,jvosburgh.net:email,jvosburgh.net:from_mime];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CAE665AB37

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Apply the "lacp_strict" configuration from the previous commit.
>
>"lacp_strict" mode "on" asserts that the bonding master carrier is up
>only when at least 'min_links' slaves are in the Collecting_Distributing
>state.
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c     | 26 +++++++++++++++++++++++---
> drivers/net/bonding/bond_options.c |  1 +
> 2 files changed, 24 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index f0aa7d2f2171..98abb2fdd7a6 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -745,6 +745,21 @@ static void __set_agg_ports_ready(struct aggregator =
*aggregator, int val)
> 	}
> }
> =

>+static int __agg_usable_ports(struct aggregator *agg)
>+{
>+	struct port *port;
>+	int valid =3D 0;
>+
>+	for (port =3D agg->lag_ports; port;
>+	     port =3D port->next_port_in_aggregator) {
>+		if (port->actor_oper_port_state & LACP_STATE_COLLECTING &&
>+		    port->actor_oper_port_state & LACP_STATE_DISTRIBUTING)
>+			valid++;
>+	}
>+
>+	return valid;
>+}
>+
> static int __agg_active_ports(struct aggregator *agg)
> {
> 	struct port *port;
>@@ -1179,10 +1194,10 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
> 		switch (port->sm_mux_state) {
> 		case AD_MUX_DETACHED:
> 			port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>-			ad_disable_collecting_distributing(port,
>-							   update_slave_arr);
> 			port->actor_oper_port_state &=3D ~LACP_STATE_COLLECTING;
> 			port->actor_oper_port_state &=3D ~LACP_STATE_DISTRIBUTING;
>+			ad_disable_collecting_distributing(port,
>+							   update_slave_arr);

	Is there a functional reason to move this?  I don't see anything
obvious in ad_disable_collecting_distributing() that depends on the
actor_oper_port_state.  Since you want this to be backported via stable,
fewer actual changes reduce the chances of an issue applying the patch
to an older version.

	-J


> 			port->ntt =3D true;
> 			break;
> 		case AD_MUX_WAITING:
>@@ -2105,6 +2120,7 @@ static void ad_disable_distributing(struct port *po=
rt, bool *update_slave_arr)
> 			  port->actor_port_number,
> 			  aggregator->aggregator_identifier);
> 		__disable_distributing_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs an update */
> 		*update_slave_arr =3D true;
> 	}
>@@ -2128,6 +2144,7 @@ static void ad_enable_collecting_distributing(struc=
t port *port,
> 			  port->actor_port_number,
> 			  aggregator->aggregator_identifier);
> 		__enable_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs update */
> 		*update_slave_arr =3D true;
> 		/* Should notify peers if possible */
>@@ -2151,6 +2168,7 @@ static void ad_disable_collecting_distributing(stru=
ct port *port,
> 			  port->actor_port_number,
> 			  aggregator->aggregator_identifier);
> 		__disable_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs an update */
> 		*update_slave_arr =3D true;
> 	}
>@@ -2830,7 +2848,9 @@ int bond_3ad_set_carrier(struct bonding *bond)
> 	active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
> 	if (active) {
> 		/* are enough slaves available to consider link up? */
>-		if (__agg_active_ports(active) < bond->params.min_links) {
>+		if ((bond->params.lacp_strict ? __agg_usable_ports(active)
>+					: __agg_active_ports(active)) <
>+		    bond->params.min_links) {
> 			if (netif_carrier_ok(bond->dev)) {
> 				netif_carrier_off(bond->dev);
> 				goto out;
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index d358b831df77..94b7b0851f16 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1706,6 +1706,7 @@ static int bond_option_lacp_strict_set(struct bondi=
ng *bond,
> 	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
> 		   newval->string, newval->value);
> 	bond->params.lacp_strict =3D newval->value;
>+	bond_3ad_set_carrier(bond);
> =

> 	return 0;
> }
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

