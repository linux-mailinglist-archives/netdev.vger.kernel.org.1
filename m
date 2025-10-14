Return-Path: <netdev+bounces-229239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55FBD9B27
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4DF19A768D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73148314A63;
	Tue, 14 Oct 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r09D+YGg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+UxYIzB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r09D+YGg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+UxYIzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0802313E23
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447894; cv=none; b=tGtxUx8Uk/ZRTOuClUsGm7LXZYIPt5mXfVcQbRgplMaBKZNMd9QCP4cMCx1/etl44OK6HaWZe5eG10NAOGtTYdSw+dnj2HHzWPhJW+ycoZZ1kj1OWJcy2Axvl/dRuv7GdGP2MXYJSKUvnB5D7av3JqpGQ/eVQwJz1FtZQe8wR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447894; c=relaxed/simple;
	bh=43IxCYB8nyulBaryFG9ltEZv7OyJJ8+lu5nw3KOlzUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCQ/44C50CuHAWqDVzfuqUBHiDySmghl7xVvSv4FuhQF9bUjgSZUTU0pPTFQoz8MwsYnWsfDwO/qKmH7wydtAEH51gb2o1OpUuATY8wx6lqWY19w6jqU8h4TP2rhmINVBWS7rTZLpfGwYsslF0DT2qH6n6T8OmLhUfUGKCZ4hUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r09D+YGg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+UxYIzB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r09D+YGg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+UxYIzB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABDF221B55;
	Tue, 14 Oct 2025 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760447890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBCyMM5i5P6gE5PlPISuUvA7edE1AzNe4Rzk7DqHbf0=;
	b=r09D+YGgn/d/i5Fs8TbOaPzIbuFv15hmgQ0dpSTOVyHP6K5EH7ZGn/pmGcPr74hNLk9ibT
	un1Bxopp6r5MdqIbkY7lnF3PwnZ7s9QMUnzcXihyhnxax/Ipq3PAFlqDs7sw7mL5jrF/RK
	Dp5IVTNLymLtb86+487y+msqpObVBxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760447890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBCyMM5i5P6gE5PlPISuUvA7edE1AzNe4Rzk7DqHbf0=;
	b=m+UxYIzBf/GFI9lsns53jzNgE8rZeqdi6t9WE7FUSp3c3G+G/JirR0EuiFa8W7RRVb0Xan
	aIK8kqseYMRLK0Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760447890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBCyMM5i5P6gE5PlPISuUvA7edE1AzNe4Rzk7DqHbf0=;
	b=r09D+YGgn/d/i5Fs8TbOaPzIbuFv15hmgQ0dpSTOVyHP6K5EH7ZGn/pmGcPr74hNLk9ibT
	un1Bxopp6r5MdqIbkY7lnF3PwnZ7s9QMUnzcXihyhnxax/Ipq3PAFlqDs7sw7mL5jrF/RK
	Dp5IVTNLymLtb86+487y+msqpObVBxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760447890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBCyMM5i5P6gE5PlPISuUvA7edE1AzNe4Rzk7DqHbf0=;
	b=m+UxYIzBf/GFI9lsns53jzNgE8rZeqdi6t9WE7FUSp3c3G+G/JirR0EuiFa8W7RRVb0Xan
	aIK8kqseYMRLK0Dw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 7B2A820057; Tue, 14 Oct 2025 15:18:10 +0200 (CEST)
Date: Tue, 14 Oct 2025 15:18:10 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
Message-ID: <7omoigy5336yecxrm3mqiavs6ptrbmcmdxzxraj34646td3bln@zystzgpdkslr>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
 <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
 <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
 <tdxplao4k3tru2ydqrjg5wzt4mmllblmilys456y7latayvdex@3l7xabhdjf2d>
 <CANn89iKQYN1qTZoSW4+1v6scDgH53zi9pP_O_mEbTdYQYie1uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mwbzvna2ttgvaxn6"
Content-Disposition: inline
In-Reply-To: <CANn89iKQYN1qTZoSW4+1v6scDgH53zi9pP_O_mEbTdYQYie1uQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,queasysnail.net,davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.40
X-Spam-Level: 


--mwbzvna2ttgvaxn6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 04:34:52AM GMT, Eric Dumazet wrote:
> On Tue, Oct 14, 2025 at 4:20=E2=80=AFAM Michal Kubecek <mkubecek@suse.cz>=
 wrote:
> >
> > On Tue, Oct 14, 2025 at 01:27:13AM GMT, Eric Dumazet wrote:
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 95241093b7f0..932c21838b9b 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> > > sk_buff *skb, int len)
> > >                 sk_peek_offset_bwd(sk, len);
> > >
> > >         if (!skb_shared(skb)) {
> > > -               if (unlikely(udp_skb_has_head_state(skb)))
> > > -                       skb_release_head_state(skb);
> > > +               if (unlikely(udp_skb_has_head_state(skb))) {
> > > +                       /* Make sure that skb_release_head_state()
> > > will have nothing to do. */
> > > +                       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> > > +                       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> > > +                       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> > > +                       skb_ext_reset(skb);
> > > +               }
> > >                 skb_attempt_defer_free(skb);
> > >                 return;
> > >         }
> >
> > Tested this version on my system (with DEBUG_NET enabled) and everything
> > seems to work fine so far.
> >
> > Tested-by: Michal Kubecek <mkubecek@suse.cz>
>=20
> Thanks for testing. I will follow Sabrina suggestion and send :
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..d66f273f9070 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>                 sk_peek_offset_bwd(sk, len);
>=20
>         if (!skb_shared(skb)) {
> -               if (unlikely(udp_skb_has_head_state(skb)))
> -                       skb_release_head_state(skb);
> +               /* Make sure that this skb has no dst, destructor
> +                * or conntracking parts, because it might stay
> +                * in a remote cpu list for a very long time.
> +                */
> +               DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> +               DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> +               DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
>                 skb_attempt_defer_free(skb);
>                 return;
>         }

Running 6.18-rc1 with this patch right now, everything seems to work as
well. Thanks to everyone for quick response.

Tested-by: Michal Kubecek <mkubecek@suse.cz>

Michal

--mwbzvna2ttgvaxn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmjuTY4ACgkQ538sG/LR
dpXSCQf+JDiTmyba9wDfRAJJMF8cVpxQPdS4eKABkwnF0NBHqTazJCHVV3pg2I1l
nXSihWFb8zKEZQrm6/C+IhzZD8AXc1QGPdKCMuNcQhGFl4lSNq2rq75H2ZZIYxva
vTffxwthVDPE9Y4KCeB6heZpy23vs+L3/IOoSDU1n0M/HVzKyaVuGPg6ywH4IsR5
t5DY+i1dQzDS519bb828NM8G2F6Tly+o/jHJAczf9fpu6r/MIUgkFEbcU/XadK1s
+0JRl/Q5yj2E0EW1atEYVAhoZYDhPdpmYZxWKDhzXHgz1u8v/5p166Xh220z2RgD
unWYqgsr81lUmGg8vnsiMrRe7L8y6Q==
=rJ3A
-----END PGP SIGNATURE-----

--mwbzvna2ttgvaxn6--

