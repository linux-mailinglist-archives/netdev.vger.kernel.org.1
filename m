Return-Path: <netdev+bounces-229180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52CBD8F91
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305CB541D11
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640E3054F6;
	Tue, 14 Oct 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxmrxy1N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zbZ/nI60";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxmrxy1N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zbZ/nI60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D031DFCB
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440803; cv=none; b=bTCSQDAy8LM4FD535vQngcpj0gPrsITXS+8F9BCDFwqLad4Po1HEu3MmjXCuLJ+g2Y4PkZ/sT+CGlbhgHyGcwbEi7GgneywJkIl8n7deoBf0LrMwE2c/Q/U0H6QacLQSCQFM9X2INWm3ZmHRGYQjChPDr7x7SyiheQu0cwca+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440803; c=relaxed/simple;
	bh=U/auo143VJ85BvhtyL9XhhbRQAUlnGcN2529+NFWXxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuyDZTWPcWrRX+OkyTx8rbCGh2hOi03hINs7SaoyyOPCNV+e4NMvlMQie8jxBafY5HfmEHVdkB2Unj++Wk0tFgQWD/eDera6Ula2nOf3ksCcHMCufGpJnvGcLJ3RScmTkTaoV76uacHs7yUtsn3U8kCrK99YCJMOlQ6N+NCfL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxmrxy1N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zbZ/nI60; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxmrxy1N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zbZ/nI60; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49C8321D4D;
	Tue, 14 Oct 2025 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760440800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyySx3Vn13uIolp/cPWfESZ5tDenKJk2YrIi2GnBu7Y=;
	b=hxmrxy1NgUz8cwnlrvUpui0VrqJjjNWq1EFF2Ht2Z3e2kCPuIpxFaf1yPv4gIesRk97FXt
	F6eU7k+ZBzUh96M2fF8bWr5oyK1FHyY/h39XGVoaV1TuEpy6ktNy3qWMbOXkSKzHjduBmd
	I3evO6aHrSGfKi0ElZ4IyoNyGKe289c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760440800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyySx3Vn13uIolp/cPWfESZ5tDenKJk2YrIi2GnBu7Y=;
	b=zbZ/nI602Z3e14kxeRKhHcLugAT0ksgry/oK2ibwHElzg579VFcaFcSLXXkTA6+wiMyPyW
	3SWNEKy2ldtddVCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760440800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyySx3Vn13uIolp/cPWfESZ5tDenKJk2YrIi2GnBu7Y=;
	b=hxmrxy1NgUz8cwnlrvUpui0VrqJjjNWq1EFF2Ht2Z3e2kCPuIpxFaf1yPv4gIesRk97FXt
	F6eU7k+ZBzUh96M2fF8bWr5oyK1FHyY/h39XGVoaV1TuEpy6ktNy3qWMbOXkSKzHjduBmd
	I3evO6aHrSGfKi0ElZ4IyoNyGKe289c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760440800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyySx3Vn13uIolp/cPWfESZ5tDenKJk2YrIi2GnBu7Y=;
	b=zbZ/nI602Z3e14kxeRKhHcLugAT0ksgry/oK2ibwHElzg579VFcaFcSLXXkTA6+wiMyPyW
	3SWNEKy2ldtddVCA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 18EA620057; Tue, 14 Oct 2025 13:20:00 +0200 (CEST)
Date: Tue, 14 Oct 2025 13:20:00 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
Message-ID: <tdxplao4k3tru2ydqrjg5wzt4mmllblmilys456y7latayvdex@3l7xabhdjf2d>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
 <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
 <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mu3p2otexayvooin"
Content-Disposition: inline
In-Reply-To: <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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


--mu3p2otexayvooin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 01:27:13AM GMT, Eric Dumazet wrote:
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..932c21838b9b 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>                 sk_peek_offset_bwd(sk, len);
>=20
>         if (!skb_shared(skb)) {
> -               if (unlikely(udp_skb_has_head_state(skb)))
> -                       skb_release_head_state(skb);
> +               if (unlikely(udp_skb_has_head_state(skb))) {
> +                       /* Make sure that skb_release_head_state()
> will have nothing to do. */
> +                       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> +                       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> +                       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> +                       skb_ext_reset(skb);
> +               }
>                 skb_attempt_defer_free(skb);
>                 return;
>         }

Tested this version on my system (with DEBUG_NET enabled) and everything
seems to work fine so far.

Tested-by: Michal Kubecek <mkubecek@suse.cz>

Michal

--mu3p2otexayvooin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmjuMdsACgkQ538sG/LR
dpUxtQf8CGv6WMAr+Lh0kJfq7Mo2z57CcZ7CtzHxoDor/uQLgvkrg2ucoAuOxG9T
4SGgUGlUfsykx6p8OtUt7o/vNIAJO8KZs9Cffm1uUwBT7KhpOg2o6NTYP+KQoBcA
cQsb3NavuaY8gEqaqnbWFsyVBwrM1yTEjzeBetXVNxLgbzSIBu3enjfT4KlMWNiZ
2SvVlIXq/IQ9ACJtoSiBrHbVKzUlS06x+wM2UXZPbgrBy1ZolccBFlOWgy9hHg/U
FKws5E2gnPXrE0nUnqH/ZEP+MhecYfisHUbppNxVstdfZBYCDQQNfvXEodLUOHp4
H0DP7ePhp1zt0UtbDO7G374gTt6JRg==
=yVDn
-----END PGP SIGNATURE-----

--mu3p2otexayvooin--

