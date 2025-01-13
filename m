Return-Path: <netdev+bounces-157712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C1A0B5B6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8963AA017
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04B2343A1;
	Mon, 13 Jan 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpeMCG+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zl7iOry9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpeMCG+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zl7iOry9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF522F168;
	Mon, 13 Jan 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767702; cv=none; b=Whn1gcjbNKar7+s5WYfwnZ9rfbmx2w9ASKZs3dpNQKF9wKHK3zmiZgP99ThCn4CLOD2gq08lVu/FEPOOIt+4J4b871pgyclVg+L1ZubYiB/vS1jXu+hFjgj7Wvq0RaOEkp2lh7+yakDemH8LuHCbk6RnEuWQVWE2om+Qn1Rguyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767702; c=relaxed/simple;
	bh=R3SAXDUv9oT3MyZPXevWumvmiS39zz0xqnqnQlUcCF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcYxhGHQmseJK8JILcnh8qKCRR2+cPK9JcxhdTSqYzANkvPcd8LRfdwIbkBCAojhLbA2rZ6YOPw0SBvSIhxv5wBmF/iLsa/YWOh2zEIdpVAXZY6hMeD+k/xrLgUW3OcjQiWroYuuHUV5cX3/TLzsdkCBjg5jJSktaKDe9qF4beY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpeMCG+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zl7iOry9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpeMCG+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zl7iOry9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E4C11F37C;
	Mon, 13 Jan 2025 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736767699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JB8L3khgZ7943Mv0Y6c8ojhdJ/p5YtisxZKCWLf9ro=;
	b=qpeMCG+PHU/jvSYNB+2rqeHd7e3xz9gpkEAoHTOu0XVS4vIAvDMevhBeuUmL/vzrslx8Wf
	nLV3YZqwnbLqmkGanR2Q7ogT4pQVnPY3ktskequfYzA+O3svdcsf88z0c2zXDvKkm7SCTT
	nCb6R2m67lPbjkR8q8y8fkLroBUBOcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736767699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JB8L3khgZ7943Mv0Y6c8ojhdJ/p5YtisxZKCWLf9ro=;
	b=Zl7iOry9gLRfksbxyLQW8mt7eFMEWu501X+DebCe8PbP9q4b6/TzVEJhW/h1A26/Hq/bJ1
	62g+eQERkBi/tJCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qpeMCG+P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zl7iOry9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736767699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JB8L3khgZ7943Mv0Y6c8ojhdJ/p5YtisxZKCWLf9ro=;
	b=qpeMCG+PHU/jvSYNB+2rqeHd7e3xz9gpkEAoHTOu0XVS4vIAvDMevhBeuUmL/vzrslx8Wf
	nLV3YZqwnbLqmkGanR2Q7ogT4pQVnPY3ktskequfYzA+O3svdcsf88z0c2zXDvKkm7SCTT
	nCb6R2m67lPbjkR8q8y8fkLroBUBOcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736767699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JB8L3khgZ7943Mv0Y6c8ojhdJ/p5YtisxZKCWLf9ro=;
	b=Zl7iOry9gLRfksbxyLQW8mt7eFMEWu501X+DebCe8PbP9q4b6/TzVEJhW/h1A26/Hq/bJ1
	62g+eQERkBi/tJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 656D213310;
	Mon, 13 Jan 2025 11:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f6a9F9P4hGchfQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Mon, 13 Jan 2025 11:28:19 +0000
Date: Mon, 13 Jan 2025 12:28:18 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
Message-ID: <20250113122818.2e6292a9@samweis>
In-Reply-To: <CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
References: <20250109142724.29228-1-tbogendoerfer@suse.de>
	<CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8E4C11F37C
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

On Thu, 9 Jan 2025 15:56:24 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Thu, Jan 9, 2025 at 3:27=E2=80=AFPM Thomas Bogendoerfer
> <tbogendoerfer@suse.de> wrote:
> >
> > gro_cells_receive() passes a cloned skb directly up the stack and
> > could cause re-ordering against segments still in GRO. To avoid
> > this copy the skb and let GRO do it's work.
> >
> > Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
> >  net/core/gro_cells.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > index ff8e5b64bf6b..2f8d688f9d82 100644
> > --- a/net/core/gro_cells.c
> > +++ b/net/core/gro_cells.c
> > @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcells, str=
uct sk_buff *skb)
> >         if (unlikely(!(dev->flags & IFF_UP)))
> >                 goto drop;
> >
> > -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> > +       if (!gcells->cells || netif_elide_gro(dev)) {
> > +netif_rx:
> >                 res =3D netif_rx(skb);
> >                 goto unlock;
> >         }
> > +       if (skb_cloned(skb)) {
> > +               struct sk_buff *n;
> >
> > +               n =3D skb_copy(skb, GFP_KERNEL); =20
>=20
> I do not think we want this skb_copy(). This is going to fail too often.

ok

> Can you remind us why we have this skb_cloned() check here ?

some fields of the ip/tcp header are going to be changed in the first gro
segment

Thomas.


--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

