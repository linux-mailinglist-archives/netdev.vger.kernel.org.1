Return-Path: <netdev+bounces-269259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHDFCDhUu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:41:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5062C4946
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D9503031AE7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DD33263B;
	Thu, 19 Mar 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="gOAVNtdf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VI2Z3BaM"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370D261B9B
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884461; cv=none; b=ntYFo1g2pbYbnNKaNTPbcp6WAfx7U3EnMVQclToeMyrcP8Ok+tYRXlZxEFl5pso6L2rP6zJ9rzuSoEK63XE2AfhoRh1kAU6LHc8UhQQKuOlU/toVK/2eu9f3F9yQvaMXVsG27ComTbpAsD6NfWi70uORUfBR26VP5jlo6kzD2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884461; c=relaxed/simple;
	bh=cxFvYQ8y3iS/fOCB3hf4kcz06uASXTNSWhratmXO6rg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=c4COHUFV22TZvV6cpIIwPATswSkScfYBhWkrVbIUC3hdBkP3qZC1WN9WReb2qDcRMHtQZRNZbGzL2njb3PbE0azztcbELRyzJz9HbDeZJgEx0h0yuCdBf0KcMmdi1S+0MCPoK+LdNA0HVHAcb3GxbZvJ1oH1+lhMtn3eTZc4O3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=gOAVNtdf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VI2Z3BaM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0087CEC01C4;
	Wed, 18 Mar 2026 21:40:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 21:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1773884449; x=1773970849; bh=4jEpm6nX0ht5I3nuSpRKG
	pfOv4NRHJd7oPJaX0b+NLY=; b=gOAVNtdfiQkF8YmueH6FlNtePX/tn+OAYIOM2
	RT2huTXAPsSgwok2p51oJRwly6EefkouCc0bPJc/rxIZik1Jx/IIY3mldHmW8PNw
	xkUnTDzqOwWLGDVtCyzHPLI3qPpgR2p6Xq3HiBLXYSftJwbq6BH6E9htSPTe5giu
	+vWl8efi1hGHL62LrqZSIJzOQ2xYkDLcri1iiJsLnNnbkA7+1/IWe5I/UMfqHtAu
	ciZ62IXUIg+rKcjc+kaMDha7mV8n0OCCpJkZ3wcJOuRpJAhqvbgZ32S1S71Z81ED
	l3G9DOpSIAYDN3QUY10//OswGxzXenNJrWNw4RjNP7fbY0w8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773884449; x=1773970849; bh=4jEpm6nX0ht5I3nuSpRKGpfOv4NRHJd7oPJ
	aX0b+NLY=; b=VI2Z3BaMzzZ4Z8EUi83vKheTeloBfYyHrYSB8t2rleZK1PZZDyB
	1U8vwxOyNeADIbfGIpUbcC4ukilMl3Vf/8uCqUuLwchrKQJ3tM6rYAjMnUfjOeyQ
	FlroAZYFmmDdHDpkJRD3spL2MGrPD4T0AkqvpR0DGHxm29qcUvP+Yu8q1CJyhVJ4
	oGDanHIzhRkSwQegvehl8FkJ19VdMAxefUQ/BloUYNG5atBrB0qKfVBHkwnVmvHc
	YlgatLPzTu8uQLjrDEWumzFNSp/86xLLCjnuam059W1aHyBYg8hDTXZzJYHWmw+d
	d4LcLHQpVHqn8Zi/aAWzM/f3uZq6O2mtc9w==
X-ME-Sender: <xms:IVS7aUqq8O-mbnsmj4J-AdKa1i_YZIAUxeyPts9A5tWICqEqoNavDg>
    <xme:IVS7adPdYr2f0itF7nKBly7MgarVya1n2hsTvn3B3-PHvvcVprZCpMVwsdq3FX8_a
    T9ZEXlAziPiNhRpPThhhauAVbbOXEq_yKWuCqZMayg_yR_hCitH3Pw>
X-ME-Received: <xmr:IVS7ac3ZBXb3ozubX2x8gNO9cpPG8PQSSTvA5WZt38P8UcI-CcB4n43Ko3gnyYKVQ8KnLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghnugihsehgrhgvhihhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjrghnughrvgifodhnvghtuggvvheslhhunhhnrdgt
    hhdprhgtphhtthhopehfsghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghmmhhinhhgvghrsehvhigrthhtrgdrtg
    homh
X-ME-Proxy: <xmx:IVS7acCftB6ndmcFi_5UO7ak9NXqLY1qrhKUgdh_JAuH4AY6VGnV_w>
    <xmx:IVS7aZK07qB0BApwY5_7Ri9iP4dOP2bImCmp_9TcLlQU3YohHxrz0w>
    <xmx:IVS7aVnEFyDZCSHFYNXeFPUpprIjDak8jCY8Gnb3eZHnwGGZDApPmg>
    <xmx:IVS7aSaMmf2hFrRXqsB3uAYednTlnZxOBY15ghTTzuzl39yd9-MNEw>
    <xmx:IVS7aSNNQtwtUXs8zmg0iDq14Rb7Ig2trGVoXHsP4UkXK3vZBdz_JitT>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 21:40:49 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 88D359FC7E; Wed, 18 Mar 2026 18:40:48 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 853169FB65;
	Wed, 18 Mar 2026 18:40:48 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, jandrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com
Subject: Re: [PATCH net 2/2] bonding: 3ad: fix mux port state on oper down
In-reply-to: <20260316131838.3257889-3-louis.scalbert@6wind.com>
References: <20260316131838.3257889-1-louis.scalbert@6wind.com>
 <20260316131838.3257889-3-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Mon, 16 Mar 2026 14:18:38 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1944594.1773884448.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2026 18:40:48 -0700
Message-ID: <1944595.1773884448@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269259-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jvosburgh.net:dkim,jvosburgh.net:email,messagingengine.com:dkim,6wind.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8B5062C4946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>When the bonding interface has carrier down due to the absence of
>valid slaves and a slave transitions from down to up, the bonding
>interface briefly goes carrier up, then down again, and finally up
>once LACP negotiates collecting and distributing on the port.
>
>The interface should not transition to carrier up until LACP
>negotiation is complete.
>
>This happens because the actor and partner port states remain in
>collecting (and distributing) when the port goes down. When the port
>comes back up, it temporarily remains in this state until LACP
>renegotiation occurs.
>
>Previously this was mostly cosmetic, but since the bonding carrier
>state now depends on the LACP negotiation state, it causes the
>interface to flap.
>
>Fix this by unsetting the SELECTED flag when a port goes down so that
>the mux state machine transitions through ATTACHED and DETACHED,
>which clears the actor collecting and distributing flags.
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 7d7661972c5e..367d89977000 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -716,6 +716,8 @@ static int __agg_ports_are_ready(struct aggregator *a=
ggregator)
> 		for (port =3D aggregator->lag_ports;
> 		     port;
> 		     port =3D port->next_port_in_aggregator) {
>+			if (!port->is_enabled)
>+				continue;

	Your commit message mentions clearing SELECTED, further below,
but not the new two tests for port->is_enabled.  In this change,
__agg_ports_are_ready is testing that all ports of an aggregator are
READY_N, but if a port of the aggregator is not is_enabled, then
logically it would not be READY_N, either.  So why exclude it here?

	Is a this is an optimization to settle the aggregator state more
quickly, as an !is_enabled port is likely to be transitioning out of the
aggregator?

> 			if (!(port->sm_vars & AD_PORT_READY_N)) {
> 				retval =3D 0;
> 				break;
>@@ -1570,6 +1572,9 @@ static void ad_port_selection_logic(struct port *po=
rt, bool *update_slave_arr)
> 	struct slave *slave;
> 	int found =3D 0;
> =

>+	if (!port->is_enabled)
>+		return;
>+

	Same question as above, why exclude !is_enabled ports here?

	-J

> 	/* if the port is already Selected, do nothing */
> 	if (port->sm_vars & AD_PORT_SELECTED)
> 		return;
>@@ -2794,6 +2799,7 @@ void bond_3ad_handle_link_change(struct slave *slav=
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

