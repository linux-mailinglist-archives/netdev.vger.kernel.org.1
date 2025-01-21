Return-Path: <netdev+bounces-160022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E710A17D40
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 12:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0071163459
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C3F1EEA46;
	Tue, 21 Jan 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ionYYaPk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jnnnw6AX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ionYYaPk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jnnnw6AX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733E15098A;
	Tue, 21 Jan 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460296; cv=none; b=LNAELfW1q7H1cDMDfqQ8osJIoY458/X3FEdv+k/la2a2nGVCeKbEzadmLVIV/JE73e56Im6wF4yN4/FOS74ReZTlxb7RmP+IyHTwCX3txRnuFQHcnxMWjrLjweKEufpDYOppZQwZ7wfJnpyWLw041sAJ2zzrqd1sUDZcW6AC3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460296; c=relaxed/simple;
	bh=uRE6i9z0g4n7pVrn/oGYsUh24uDrC3hJ56CgkpTLQug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxVR8QhBXzh3/93SdluOpqZHFxcpbYMUGU5MXuk+8f57MAS7j2tnUT5xnThKD9RYesUNUAl75aBod3fcDlw5b/WeOUV/roMzrKaUL/5AayTjFdPTT3RtGRgNZn+sTv9LGErNFqK4XpTkcLw6i+nB64oG6eK/rbLgtvveUSDZvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ionYYaPk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jnnnw6AX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ionYYaPk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jnnnw6AX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6086F1F397;
	Tue, 21 Jan 2025 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737460292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb+NLZ795qX3bqAQX1h71DvcPTGfIXH1iYgp38cxjM8=;
	b=ionYYaPkQwuYlS9abMD5KhDCfPI1UrBSvhCpcmvBtItyj1zCZP9NZGrloFzoQ5FlcpB8i6
	/YSpp23FV6DvmzGwRhZx412dlA+c156a1VKJ8O1vipHt/xQf04Z3f2pObITIccc8wNxAki
	JPTmFfijb6Q/J49A9WDhC9itxMlFWBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737460292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb+NLZ795qX3bqAQX1h71DvcPTGfIXH1iYgp38cxjM8=;
	b=jnnnw6AXFztbk0uCDaTW+49tUuYCFnKAglGIe3GxuLofiXIhQalb1EQbsQhDm/qJ9OUZy6
	PLbLCG1TMlWuiRAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737460292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb+NLZ795qX3bqAQX1h71DvcPTGfIXH1iYgp38cxjM8=;
	b=ionYYaPkQwuYlS9abMD5KhDCfPI1UrBSvhCpcmvBtItyj1zCZP9NZGrloFzoQ5FlcpB8i6
	/YSpp23FV6DvmzGwRhZx412dlA+c156a1VKJ8O1vipHt/xQf04Z3f2pObITIccc8wNxAki
	JPTmFfijb6Q/J49A9WDhC9itxMlFWBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737460292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb+NLZ795qX3bqAQX1h71DvcPTGfIXH1iYgp38cxjM8=;
	b=jnnnw6AXFztbk0uCDaTW+49tUuYCFnKAglGIe3GxuLofiXIhQalb1EQbsQhDm/qJ9OUZy6
	PLbLCG1TMlWuiRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3712713963;
	Tue, 21 Jan 2025 11:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KHpsDESKj2e3JAAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 21 Jan 2025 11:51:32 +0000
Date: Tue, 21 Jan 2025 12:51:30 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
Message-ID: <20250121125130.5a909e84@samweis>
In-Reply-To: <CANn89iLLWZ3v46KfCuHKzskQb58tW2mp0d-uibX_GV+=ZG9iUA@mail.gmail.com>
References: <20250109142724.29228-1-tbogendoerfer@suse.de>
	<CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
	<20250113122818.2e6292a9@samweis>
	<CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
	<20250120153156.6bff963c@samweis>
	<CANn89iLLWZ3v46KfCuHKzskQb58tW2mp0d-uibX_GV+=ZG9iUA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon, 20 Jan 2025 15:55:26 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jan 20, 2025 at 3:32=E2=80=AFPM Thomas Bogendoerfer
> <tbogendoerfer@suse.de> wrote:
> >
> > On Mon, 13 Jan 2025 13:55:18 +0100
> > Eric Dumazet <edumazet@google.com> wrote:
> > =20
> > > On Mon, Jan 13, 2025 at 12:28=E2=80=AFPM Thomas Bogendoerfer
> > > <tbogendoerfer@suse.de> wrote: =20
> > > >
> > > > On Thu, 9 Jan 2025 15:56:24 +0100
> > > > Eric Dumazet <edumazet@google.com> wrote:
> > > > =20
> > > > > On Thu, Jan 9, 2025 at 3:27=E2=80=AFPM Thomas Bogendoerfer
> > > > > <tbogendoerfer@suse.de> wrote: =20
> > > > > >
> > > > > > gro_cells_receive() passes a cloned skb directly up the stack a=
nd
> > > > > > could cause re-ordering against segments still in GRO. To avoid
> > > > > > this copy the skb and let GRO do it's work.
> > > > > >
> > > > > > Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > > > > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > > > > ---
> > > > > >  net/core/gro_cells.c | 11 ++++++++++-
> > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > > > > > index ff8e5b64bf6b..2f8d688f9d82 100644
> > > > > > --- a/net/core/gro_cells.c
> > > > > > +++ b/net/core/gro_cells.c
> > > > > > @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gce=
lls, struct sk_buff *skb)
> > > > > >         if (unlikely(!(dev->flags & IFF_UP)))
> > > > > >                 goto drop;
> > > > > >
> > > > > > -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gr=
o(dev)) {
> > > > > > +       if (!gcells->cells || netif_elide_gro(dev)) {
> > > > > > +netif_rx:
> > > > > >                 res =3D netif_rx(skb);
> > > > > >                 goto unlock;
> > > > > >         }
> > > > > > +       if (skb_cloned(skb)) {
> > > > > > +               struct sk_buff *n;
> > > > > >
> > > > > > +               n =3D skb_copy(skb, GFP_KERNEL); =20
> > > > >
> > > > > I do not think we want this skb_copy(). This is going to fail too=
 often. =20
> > > >
> > > > ok
> > > > =20
> > > > > Can you remind us why we have this skb_cloned() check here ? =20
> > > >
> > > > some fields of the ip/tcp header are going to be changed in the fir=
st gro
> > > > segment =20
> > >
> > > Presumably we should test skb_header_cloned()
> > >
> > > This means something like skb_cow_head(skb, 0) could be much more
> > > reasonable than skb_copy(). =20
> >
> > I don't think this will work, because at that point it's skb->data poin=
ts
> > at the IPv6 header in my test case (traffic between two namespaces conn=
ected
> > via ip6 tunnel over ipvlan). Correct header offsets are set after later,
> > when gro_cells napi routine runs.
> >
> > Do you see another option ? =20
>=20
> Anything not attempting order-5 allocations will work :)
>=20
> I would try something like that.
>=20
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index ff8e5b64bf6b..74416194f148 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -4,6 +4,7 @@
>  #include <linux/netdevice.h>
>  #include <net/gro_cells.h>
>  #include <net/hotdata.h>
> +#include <net/gro.h>
>=20
>  struct gro_cell {
>         struct sk_buff_head     napi_skbs;
> @@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells,
> struct sk_buff *skb)
>         if (unlikely(!(dev->flags & IFF_UP)))
>                 goto drop;
>=20
> -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +       if (!gcells->cells || netif_elide_gro(dev)) {
>                 res =3D netif_rx(skb);
>                 goto unlock;
>         }
> @@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi,
> int budget)
>                 skb =3D __skb_dequeue(&cell->napi_skbs);
>                 if (!skb)
>                         break;
> -               napi_gro_receive(napi, skb);
> +               /* Core GRO stack does not play well with clones. */
> +               if (skb_cloned(skb))
> +                       gro_normal_one(napi, skb, 1);
> +               else
> +                       napi_gro_receive(napi, skb);
>                 work_done++;
>         }

works perfectly, thank you. I've sent a v2 of the fix.

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

