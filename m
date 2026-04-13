Return-Path: <netdev+bounces-278136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA18IV8l3WlcaQkAu9opvQ
	(envelope-from <netdev+bounces-278136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:18:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E20923F123A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51A03103394
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE631619A;
	Mon, 13 Apr 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="tFla3PGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vT0nUSWr"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5C317141
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098997; cv=none; b=bjehUBGviAg4El9ADl+24VG3IJQUnF5/LpwpscK/MvuSdl/UzrSiMNN5o0bD/Upk/KAzWe2NMNsd4YQIKPEIPhuEou5o0SySINhDYNg7deUxDS/sdWOoRH/2uSbeuf7m3WFb4DG6Ey7ekvVgpeYVT/Lf++sAGdOMxsL3UZn2hRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098997; c=relaxed/simple;
	bh=rd+SrPjNwZ3cHs2dt1EXHrjTAbLf2SkzPf1coaIwYdc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=OndA4GQdt7LHKAWGku6iBL2SeVl0OxS06BMcSPdC04OsYlodPrYEn6wtJLt0DnKW7+Yc1tY5IhodQCjzkWmnNMKaiEYtz8A5vubAPRCVCXRuDqZYhLXFCv0Ee9JQvxMwNqg9pVEJxVGnltUMVpDs/LGAPJazkj598BEspr6kzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=tFla3PGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vT0nUSWr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DAE68EC04D8;
	Mon, 13 Apr 2026 12:49:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Apr 2026 12:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1776098995; x=1776185395; bh=hKNVFN/yOQ5Zc1eGnCFBW
	uhsQ9tysRhfu9+x6ZY22Y0=; b=tFla3PGdzXlvTC7RhUXZcGk1UUcFIfvRfV2yR
	Z67R1rHlRP/pRzhcr0PWVFkQ9E7Scedqno8Vu3JI/1Uymu/LYfRlpqdF/C5UyOIK
	dKdOmpMFITwDq8FJYlKtviKxNovMeO5qr8ZIiX+BwbQIAri4OBwMlVPDQ8Em0tcl
	3pHmZ1e6xqfr9OIzhwx1fB9wf2xoA8buuonLyhIEfgZ+y1pY/aH4biYnV4VYKXFB
	Hpx8zvJUbL817Ifl2mQdKZac9HcfzUG6ezHMxpM9luNhYcgIzbKQeFQSqD6II9xh
	ymTwcpu3Yv7EXJMf8vmI8m7yJxTKtCrktUzzA4rVK63/nKnJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776098995; x=1776185395; bh=hKNVFN/yOQ5Zc1eGnCFBWuhsQ9tysRhfu9+
	x6ZY22Y0=; b=vT0nUSWrARsKoAVWoeyLrCBeDIkONL51Xf/iprBotJDwPSOXdPB
	DQuQKEqubzeSWa5ljd45do/4PWuBPLzKvYjELw/W2i0lMmVbN+zk6qoK3ZW4TV/h
	GxoIQ1Q4jFPJ0Rj5jJGWvvI5JofRYEgys3kCXgG1UK8Ifj3j8KzxUlzXTX4PptiJ
	+9m6Ut461YQ+iojNTfnHuW2zpBVPDbsPCjiReGvYgBv6QsydklP0GIOSTyJxwpLQ
	ct1MikdLlbGX6OTpI0QtJ/D6yw4w5IIYLpAJbRRlWe/+DfR3USW3S5Lo/+/dqRHJ
	FDa2TLUnHHF5kHzQ0fX+4qCdWefAH//v3nQ==
X-ME-Sender: <xms:sx7daQvyIhZAWMUFj0eoBTqjXPaGOPbuL7E1D4pz86MRJdgMWbUKEA>
    <xme:sx7daaDXRvYbBFsEPdvzrMayEOXvMMQqd4CSKthxUWAleR2-6eJAlNhhLVqM9fe0G
    SIMNOD-_6ReBfbVJCB-8U84aDfuPbx0noHA0H3I-6M2s3XtF0b61Q>
X-ME-Received: <xmr:sx7daQPICX1yEgei3ZX9vfaXl3ex5MK0qoOiMLjldmRODLGP7_g-C8Vn4C8sLR21ds4KWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:sx7daaDcFTQoTNo-Sbq09lVGJVU3V-E1HWiowGE9_nHheQtptO0FvA>
    <xmx:sx7daR6IJFHCzJ_LsZuQ5HFHZdBymI0GpwtcZKmxeKRW6_mHM2528A>
    <xmx:sx7daU5gg7eTx5zI29x9d64yOSkCCJWQQjPODMU5UuvLyrr2gUOsCA>
    <xmx:sx7daTR-HishRSk5cxKfFhvDi3jdCso9P3q7K0MpGx1uhvI1ntLzsw>
    <xmx:sx7dadUMLcvZRTO8Lok5BlbGezTA_v_b17Z8L2stBJVUiO4uOhbarWNB>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:49:55 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 96C909FB3D; Mon, 13 Apr 2026 09:49:54 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 95DB59FB3C;
	Mon, 13 Apr 2026 09:49:54 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 3/5] bonding: 3ad: fix mux port state on oper down
In-reply-to: <20260408152353.276204-4-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-4-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 08 Apr 2026 17:23:51 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <707641.1776098994.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 09:49:54 -0700
Message-ID: <707642.1776098994@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278136-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E20923F123A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>When the bonding interface has carrier down due to the absence of
>valid slaves and a slave transitions from down to up, the bonding
>interface briefly goes carrier up, then down again, and finally up
>once LACP negotiates collecting and distributing on the port.

	Instead of "valid," I would suggest "usable."

>The interface should not transition to carrier up until LACP
>negotiation is complete.

	If the new option is off, i.e., does not require successful LACP
negotiation, it should wait some time before asserting carrier up.  If
negotiation fails, however, how long should it wait?

>This happens because the actor and partner port states remain in
>collecting (and distributing) when the port goes down. When the port
>comes back up, it temporarily remains in this state until LACP
>renegotiation occurs.
>
>Previously this was mostly cosmetic, but since the bonding carrier
>state now depends on the LACP negotiation state, it causes the
>interface to flap.

	"now depends" -> "may depend"

>Fix this by unsetting the SELECTED flag when a port goes down so that
>the mux state machine transitions through ATTACHED and DETACHED,
>which clears the actor collecting and distributing flags. Do not
>attempt to set the SELECTED flag if the port is still disabled.
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index b79a76296966..3a94fbcbf721 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -1570,6 +1570,12 @@ static void ad_port_selection_logic(struct port *p=
ort, bool *update_slave_arr)
> 	struct slave *slave;
> 	int found =3D 0;
> =

>+	/* Disabled ports cannot be SELECTED.
>+	 * Do not attempt to set the SELECTED flag if the port is still disable=
d.
>+	 */
>+	if (!port->is_enabled)
>+		return;
>+

	I think the change is fine, but the comment seems redundant to
me.

	-J

> 	/* if the port is already Selected, do nothing */
> 	if (port->sm_vars & AD_PORT_SELECTED)
> 		return;
>@@ -2794,6 +2800,7 @@ void bond_3ad_handle_link_change(struct slave *slav=
e, char link)
> 		/* link has failed */
> 		port->is_enabled =3D false;
> 		ad_update_actor_keys(port, true);
>+		port->sm_vars &=3D ~AD_PORT_SELECTED;
> 	}
> 	agg =3D __get_first_agg(port);
> 	ad_agg_selection_logic(agg, &dummy);
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

