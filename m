Return-Path: <netdev+bounces-268949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jb7Kat2ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:55:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB32B983B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D9B30268B2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6823B7B77;
	Wed, 18 Mar 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yNNPNxiz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F513A6F16
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827640; cv=none; b=edZQjjwRss/pvfHmI4LwGYt8KrZRW95P2+R4dSheh3uL2IGLetQ/9paZFO8r4ELj5y+i4W+RaRD1C97/gCsqlHDQl42y+xu6Rf96lOGykn/l0BZCqVnxZ7zt/o9aN3TxuKxcctl9aVWGw4bQxHn1T1Ne5o73YYa0TyRIju3wtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827640; c=relaxed/simple;
	bh=PtzHHweeSyTewKASZ5KFtJHN+kg72UkdBKzWfqyc728=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=mWePtqmo0p2xgpduyzDqIk2rNd6zeD7px6w9d/sgszGDCIjdgz2oLfnhghxNFjJxdH0/tLjIsGZGAKYRku4/tPYdrsf/85JfQsqeVzEJ5TuLReTkfOIrblV1EA1/4mM54l2RFhk5qQua1i3PCdqz8j2IqSXhZ7O89aScoq7N9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yNNPNxiz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (unknown [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C156DC55069;
	Wed, 18 Mar 2026 09:54:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 529D16004F;
	Wed, 18 Mar 2026 09:53:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07FAC10450758;
	Wed, 18 Mar 2026 10:53:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773827619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fNFG2r8DTWr2ETzMLU5H9gpDxf7fg1r9QXDFSFaarzc=;
	b=yNNPNxizrIFOKjE3BLWJ2prS+HhJF0heVbyAG9uzddUxPCOHjEyRVqRg5kxPgm9tngiuzJ
	uYaIHFrWRVoZBT5pARWXX0NHo5U4brUOh/OWPLMlA0LG//QIBy/svpP0mV2VAm6TPNaL1p
	hDUUYuw5oBxX1PPS8GEh9VHAkZkjUbMiqUq18v7zCpwya9dDR6C372ojM9OkUwuP/JX/Le
	zBf1KnJfSKZU+GzK9cG4UkaIeLvjOTl8BUz2ulw0TQArllx6yOEELKivflvdk/bv5VEVMs
	hWFc/mG0UveCGUAYrhyT0PrjUQVL7eA49cnjdBg26LnC8qoadvw5aP1gq6yv+A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 10:53:37 +0100
Message-Id: <DH5TETVK34CG.V7P9P9Z1AAKL@bootlin.com>
Cc: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260316092720.39198-1-nb@tipi-net.de>
 <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
 <20260317152330.32998fdd@kernel.org>
 <1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
 <20260317162303.4065e307@kernel.org>
In-Reply-To: <20260317162303.4065e307@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268949-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gnu.org:url,bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 1EFB32B983B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Mar 18, 2026 at 12:23 AM CET, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 23:58:21 +0100 Nicolai Buchwitz wrote:
>> On 17.3.2026 23:23, Jakub Kicinski wrote:
>> > On Tue, 17 Mar 2026 18:00:02 +0100 Th=C3=A9o Lebrun wrote: =20
>> >> Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> =20
>> >=20
>> > I told you recently that open / close is not allowed.
>> > So why are you putting a rb tag on a patch which does exactly that?
>> >=20
>> > https://lore.kernel.org/all/20260306190948.44d23f8f@kernel.org/ =20

Ah, I might have misunderstood at the time.

   > allocate all necessary resources upfront then just swap them in
   > and reconfigure HW

In .set_channels() context, does "upfront" mean
(1) alloc all queue buffers at probe (and never dealloc) or
(2) alloc new buffer at operation start, swap in, then dealloc?

I had understood #1. I didn't see how that applied to this series (an
MTU change) which of course must realloc. But now it seems it was #2 as
you pointed to fbnic as reference and that's what fbnic_set_channels()
does.

>> Just checking if I got the idea before submitting another approach.
>> Something like:
>
> Hm, not really. Take a look at fbnic_set_ringparam()
> You need some struct that's config + pointers to all the resources.
> And make all allocation helpers operate on that without touching the HW.
> Then you can just allocate a new struct, give it whatever config you
> need, call all the alloc helpers with it. Now you have a fully
> populated struct and haven't touched the HW yet at all. Stop HW,=20
> swap the resources, start HW.
>
> I did something similar for the nfp driver but that code has been
> slightly adulterated since I left Netronome so fbnic is clearer :)

Do you feel we should (1) clone the full `struct macb` as done by fbnic
or, (2) just partially, with the few interesting fields. Something like
`struct stmmac_dma_conf`.

stmmac is not the greatest example. They have this struct that carries
their buffers but they still "close -> update -> open" on operations
versus the optimal "alloc -> reconfigure_hw -> free".

With #2 we could use an unnamed structure field.
https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html
See commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").

struct macb_buffers {
	struct macb_queue queues[N];
	...
};

struct macb {
	struct macb_buffers;
	...
};

Goal is to keep `bp->queues` & co as before, to minimise the diff.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


