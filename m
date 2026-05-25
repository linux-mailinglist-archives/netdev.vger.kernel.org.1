Return-Path: <netdev+bounces-291389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI17JDmIFGqPOAcAu9opvQ
	(envelope-from <netdev+bounces-291389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:34:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2A5CD680
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC07300BC93
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4430C147;
	Mon, 25 May 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXpRUunP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B4292B44
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730486; cv=none; b=aqNqnrIvYBAR59ABqsnuajtvUp2/Qi1j5IPXFJ5izYICykEsnkuR/9LgzQEO0g7MJNhc004WBtnf5eOGAf0I3nJg+c1dFDXpVEwydzAhC1cocdpzQEzvKvqzPMs/Ln9e+4i8PPLwKsgOeXUCLTTB1M+/XuhZUw2RHviRBjpVQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730486; c=relaxed/simple;
	bh=QrMbVbdSYS6HFc03CAApBgEHA6NDUnvx1qj5zJt2CvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REpI9uAey3Z9zFixtvWDQJ9brq4sJvDAsltS0LSpnOAMYtystffqH9r50+JJ09cRuUm1uoAi7E5mdiJYG7gjCKlIEL+7234Y5YtZf+ZMQaGp5DZJ7sl8uiEnVq+FYW5DadE7IJHaStnb9x8Yoqz8bQV8XHRMJgrVz7trDZOmoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXpRUunP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13BA1F000E9;
	Mon, 25 May 2026 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779730485;
	bh=e6AEyysnUiDhdJH6TY0JDaFSLzgkUarDpIoG9uM58AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JXpRUunPv/7OVGnmMqRKFGDcGpB4Ox+7vQVqMFJ8rLIe+8P0Fqjd1BqmmICmns/XF
	 nezZMN9K0yKkG4+SfybmmeQqIMHGf57ZtNvfu24A6wfBdvK9SK7xSPCxhqunYeUCuC
	 7K/8mbJfY56NPgVvS5woN5rGKeMY27Vvudu4bCPtqKvzl+AHbzyD3BtWOL5dfDSBnB
	 wMj2wTr0cdpyEIhtvwiNKzpIqN9VENQ0KkhUOXXD5N6yZbYzgKFojvZT0urGoHqyBh
	 0J9z0vafx9GXPYaYSC4JfVVaNMvmIb8g09RqqaFVPRSwjKb5F/PzDC1nMJBQWMVM83
	 PoDoGDatN2UmQ==
Date: Mon, 25 May 2026 10:34:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260525103443.1da3e406@kernel.org>
In-Reply-To: <CAM0EoMmjg+qrc=E+1nSVcCUPFh9yUfw59ASLCOM4jcEvRtw4jg@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
	<20260521084640.683c1ee6@kernel.org>
	<CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
	<20260522084611.390fd0a6@kernel.org>
	<CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
	<CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
	<20260522175507.02b4fe83@kernel.org>
	<CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
	<CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
	<20260523094641.2bef6580@kernel.org>
	<CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
	<20260525083932.234f26df@kernel.org>
	<CAM0EoMmjg+qrc=E+1nSVcCUPFh9yUfw59ASLCOM4jcEvRtw4jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-291389-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00F2A5CD680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 12:22:40 -0400 Jamal Hadi Salim wrote:
> On Mon, May 25, 2026 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > So as an alternative to the piece i posted? i.e this:
> > >
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index 79921b8d89ba..8f0f84b50c85 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_bu=
ff *skb,
> > >                 if (write_offset < 0) {
> > >                         if (skb_cow(skb, -write_offset))
> > >                                 goto bad;
> > > +                       if (write_offset + (int)sizeof(hdata) > 0) {
> > > +                               if (skb_ensure_writable(skb,
> > > +                                               min_t(int, skb->len,
> > > +                                                     write_offset + =
(int)sizeof(hdata))))
> > > +                                       goto bad;
> > > +                       }
> > >                 } else {
> > >                         if (unlikely(check_add_overflow(write_offset,
> > >                                                         (int)sizeof(h=
data), =20
> >
> > Yup! Even better. =20
>
> Dude, it's hard to follow you sometimes ;-> It's hard to grok what you
> mean the problem of "we are writing to frags".

Long threads have the tendency of losing focus.
Better to just repost the whole diff than tossing snippets at some point.. =
;)

> Let me try to be verbose and you can narrow it down. There are _two_
> codelets dealing with "frags" both of which can be written to.
>=20
> 1) The patch from Rajat deals with zero copy from app with shared
> flags. That's whats being exploited in the wild.
> There's a piece of code there that does this in Rajat's patch to handle i=
t:
>=20
> +       /*
> +        * If the skb has shared frags the user is likely using zero-copy
> +        * (e.g. sendfile).  Those page frags may point to page-cache pag=
es;
> +        * writing into them would silently corrupt the page cache.
> +        * Linearize so pedit operates on a private copy.
> +        * TL;DR: if you want zero-copy, don't use pedit.
> +        */
> +       if (skb_has_shared_frag(skb)) {
> +               if (__skb_linearize(skb))
> +                       goto bad;
> +       }
>=20
> After you posted, i thought this is the "we are writing to frags"
> issue you were referring to.
> I if-zeroed that code and indeed it does not seem that the exploit can
> be executed even with that taken out.

I don't want the skb_has_shared_frag() being added, that's my ask.
TBH I missed that skb_ensure_writable() when reading the patch.

If we use skb_ensure_writable() before all the writes we can delete
the skb_has_shared_frag() (as your test proves). This is the extent
to which I care about the patch, anything else - no strong opinion :)

> 2) There's the frags coming from the other (driver) direction in
> particular when skbs get cloned. That is what sashiko2 (nipa variant)
> pointed out. IOW, there's no active report for that specific one but
> Han Guidong responded after i posted this:
>=20
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *=
skb,
>                 if (write_offset < 0) {
>                         if (skb_cow(skb, -write_offset))
>                                 goto bad;
> +                       if (write_offset + (int)sizeof(hdata) > 0) {
> +                               if (skb_ensure_writable(skb,
> +                                               min_t(int, skb->len,
> +                                                     write_offset + (int=
)sizeof(hdata))))
> +                                       goto bad;
> +                       }
>                 } else {
>                         if (unlikely(check_add_overflow(write_offset,
>                                                         (int)sizeof(hdata=
),
>=20
> Saying he was able to recreate that scenario with a kernel module. And
> that this patchlet fixed it.
>=20
> Hope you are still following at this point ;->
> So when you said we can use skb pulls - I thought you were referring
> to removing the above patchlet and instead to use an skb pull approach
> (for which you posted a sample patch).

Yes, skb_ensure_writable() does a pull already. So the only problem
with existing patch was that the negative offset branch was missing=20
a skb_ensure_writable(). Your snippet added it, plugging that hole,=20
so skb_has_shared_frag() can now be 100% safely removed. Hence my
"LGTM".

Please also remove the skb_store_bits(), and skb_header_pointer().
Unless I'm missing something these are dead code.

> I mentioned the two issues:
> 1) It will likely break the negative offset that work with pedit
> already (skb pull could conceivably be tricked to assume a large
> positive number)

Your snippet looked fine tho unnecessarily complex in practice.
(AI generated?). I'd go with skb_ensure_writable(sizeof(*ptr))
as the worst case. Packets shorter than 4B are irrelevant in practice.
But again, up to you.

> 2) that skb clones could result in writting into the shared data
> (which i said i may be overthinking).
>=20
> So which one of the two are you referring to? Or maybe it is both.
> Should we keep #1? or this the one that should be replaced?
> Are you ok with patchlet for number #2? Or do you want that replaced?
>=20
> Provide as much context as you can so we dont go back and forth ;->

