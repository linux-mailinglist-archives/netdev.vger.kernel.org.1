Return-Path: <netdev+bounces-159787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D223A16E76
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A73A550A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A52D1E2823;
	Mon, 20 Jan 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cpaco6Wy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42TX9kHH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cpaco6Wy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42TX9kHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3B9450;
	Mon, 20 Jan 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383523; cv=none; b=qBQuWhyU93gcVudbxTf8p1z6NK5Mpz22sRqc81GmfZz4gt2oAsZ/e81BVOK55NEhS9msheOjW9tZ6QjakLN3r1/PussXhCF+MMDfsPegssCJeZ+mQCwbPcfhie63T+i2oGHldtcyC+09MfrRRtYfv7jDHxjIRGjPBauLNMKNg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383523; c=relaxed/simple;
	bh=iGvkPatlqiX3kDfiQAZNUNDmNss7D4IxsoTzPQz28a0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fz7+5GbypWMkCgrb/uHEUqVQt2hquIM+tQ/UwbvZlmv3GhmfegK7GBJFkqipVeVTk07JZ4QNAioCKm9jdacocjh/DlVjup6AVlonSVqxKKRXoXETYCK80KqH4yCRhz+HvddeXuv1HP/SdRiAYp0S1n4NUxB/a7/bwJXmtvKmArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cpaco6Wy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42TX9kHH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cpaco6Wy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42TX9kHH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CC0821182;
	Mon, 20 Jan 2025 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737383519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVrEaHjsEWer1AuBM5n9dOwNAlGxbzOaDYMUr7HjQCY=;
	b=cpaco6Wy0yDCNXRu3tYNalvgOyERqA+E+iqhS5ZGAou5FA9QzrO/xv5C/Eb1coewu7ElMG
	B0OTbdnSr2GNSrNtALHrTKI/pCoRim2c3sRP6eYOfCIqxqGq9q2UXARklfsu2tJ+42dmFq
	xMI1xtoBTuPL73//uAg/4jhFwNCB7Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737383519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVrEaHjsEWer1AuBM5n9dOwNAlGxbzOaDYMUr7HjQCY=;
	b=42TX9kHHxjGYLON4QKnngYXfoX+NS0FNdfs/wEcuRgmrqVwZOFPukKpCWBwSR8rC7WiVY1
	DBq/GuVkZvqIwXCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cpaco6Wy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=42TX9kHH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737383519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVrEaHjsEWer1AuBM5n9dOwNAlGxbzOaDYMUr7HjQCY=;
	b=cpaco6Wy0yDCNXRu3tYNalvgOyERqA+E+iqhS5ZGAou5FA9QzrO/xv5C/Eb1coewu7ElMG
	B0OTbdnSr2GNSrNtALHrTKI/pCoRim2c3sRP6eYOfCIqxqGq9q2UXARklfsu2tJ+42dmFq
	xMI1xtoBTuPL73//uAg/4jhFwNCB7Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737383519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVrEaHjsEWer1AuBM5n9dOwNAlGxbzOaDYMUr7HjQCY=;
	b=42TX9kHHxjGYLON4QKnngYXfoX+NS0FNdfs/wEcuRgmrqVwZOFPukKpCWBwSR8rC7WiVY1
	DBq/GuVkZvqIwXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26FBB139CB;
	Mon, 20 Jan 2025 14:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oXSHCF9ejmdoBQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Mon, 20 Jan 2025 14:31:59 +0000
Date: Mon, 20 Jan 2025 15:31:56 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
Message-ID: <20250120153156.6bff963c@samweis>
In-Reply-To: <CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
References: <20250109142724.29228-1-tbogendoerfer@suse.de>
	<CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
	<20250113122818.2e6292a9@samweis>
	<CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4CC0821182
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 13 Jan 2025 13:55:18 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jan 13, 2025 at 12:28=E2=80=AFPM Thomas Bogendoerfer
> <tbogendoerfer@suse.de> wrote:
> >
> > On Thu, 9 Jan 2025 15:56:24 +0100
> > Eric Dumazet <edumazet@google.com> wrote:
> > =20
> > > On Thu, Jan 9, 2025 at 3:27=E2=80=AFPM Thomas Bogendoerfer
> > > <tbogendoerfer@suse.de> wrote: =20
> > > >
> > > > gro_cells_receive() passes a cloned skb directly up the stack and
> > > > could cause re-ordering against segments still in GRO. To avoid
> > > > this copy the skb and let GRO do it's work.
> > > >
> > > > Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > > ---
> > > >  net/core/gro_cells.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > > > index ff8e5b64bf6b..2f8d688f9d82 100644
> > > > --- a/net/core/gro_cells.c
> > > > +++ b/net/core/gro_cells.c
> > > > @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcells,=
 struct sk_buff *skb)
> > > >         if (unlikely(!(dev->flags & IFF_UP)))
> > > >                 goto drop;
> > > >
> > > > -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(de=
v)) {
> > > > +       if (!gcells->cells || netif_elide_gro(dev)) {
> > > > +netif_rx:
> > > >                 res =3D netif_rx(skb);
> > > >                 goto unlock;
> > > >         }
> > > > +       if (skb_cloned(skb)) {
> > > > +               struct sk_buff *n;
> > > >
> > > > +               n =3D skb_copy(skb, GFP_KERNEL); =20
> > >
> > > I do not think we want this skb_copy(). This is going to fail too oft=
en. =20
> >
> > ok
> > =20
> > > Can you remind us why we have this skb_cloned() check here ? =20
> >
> > some fields of the ip/tcp header are going to be changed in the first g=
ro
> > segment =20
>=20
> Presumably we should test skb_header_cloned()
>=20
> This means something like skb_cow_head(skb, 0) could be much more
> reasonable than skb_copy().

I don't think this will work, because at that point it's skb->data points
at the IPv6 header in my test case (traffic between two namespaces connected
via ip6 tunnel over ipvlan). Correct header offsets are set after later,
when gro_cells napi routine runs.

Do you see another option ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

