Return-Path: <netdev+bounces-228955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55FBD664D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFA240150F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179902EAD0A;
	Mon, 13 Oct 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7IPMAVN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDdWPbWo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7IPMAVN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDdWPbWo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FA2D738A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391876; cv=none; b=a8mUt439rcNrknJozMuyNNDsI1VG+Kb8uKi3h9yZRAf7Mw3nGvYy+6J5hesVJCp1dM1SU7FPIX+B6syz0vFEBgHfNx648zDXAtOuEyQIRyA46RIHWCwZcXJmVpicNFcFYWcF24lBaqYtlgiypEcdzld2r9StsdfUabNLBZxqwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391876; c=relaxed/simple;
	bh=lh9MCjYL6rgmGC3R1kLTmNuNL6c+Tw/7UTOuHqIc7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzdP4w1qMp1m7p8LxfmUEpS+PuGJSgK4HICs+1HfO2IHv6goWoxSXXRlRbsvqpYNitLuXh+4pdMNa94yD39eh4Y1TcARIgnurHfMrfoxHMeZn8TyhsiErOuzlBoLd3aIFNGPPjvGP3e7xLS6egRJrhl106BcK2bP25Qr0PacCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7IPMAVN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDdWPbWo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7IPMAVN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDdWPbWo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 732B72236D;
	Mon, 13 Oct 2025 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760391872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgFsYxfzSrkJMlmZUyRhEeO+PCyaMQMmKtBADIrchFc=;
	b=V7IPMAVN9Rg3VCezWy+WCHvxAdYUEkt2Qt8sTgPRVf2IKoAgxtOAHxdYSw3b6vtNjq1qx7
	9HpBFFt0ecnjyX/38m8e6+Z/1YrDBrTNiIVBOvOxXiC4afH7gFvcjEBLs7Y+Fs1no9cXN3
	P1+s+2tlp8RqpyAGEIUjbGRUkukq1wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760391872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgFsYxfzSrkJMlmZUyRhEeO+PCyaMQMmKtBADIrchFc=;
	b=aDdWPbWoUU0nI1ahHgn7z/w9748OqVDgsLBQE8IrlkyH+FV65Y9ZOVensWnOeXLCx71SmT
	A6Dk0lUtEjh8TRAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760391872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgFsYxfzSrkJMlmZUyRhEeO+PCyaMQMmKtBADIrchFc=;
	b=V7IPMAVN9Rg3VCezWy+WCHvxAdYUEkt2Qt8sTgPRVf2IKoAgxtOAHxdYSw3b6vtNjq1qx7
	9HpBFFt0ecnjyX/38m8e6+Z/1YrDBrTNiIVBOvOxXiC4afH7gFvcjEBLs7Y+Fs1no9cXN3
	P1+s+2tlp8RqpyAGEIUjbGRUkukq1wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760391872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgFsYxfzSrkJMlmZUyRhEeO+PCyaMQMmKtBADIrchFc=;
	b=aDdWPbWoUU0nI1ahHgn7z/w9748OqVDgsLBQE8IrlkyH+FV65Y9ZOVensWnOeXLCx71SmT
	A6Dk0lUtEjh8TRAw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 50F3A20057; Mon, 13 Oct 2025 23:44:32 +0200 (CEST)
Date: Mon, 13 Oct 2025 23:44:32 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [REGRESSION] xfrm issue bisected to 6471658dc66c ("udp: use
 skb_attempt_defer_free()")
Message-ID: <gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-11-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cfbkzohclohupiwg"
Content-Disposition: inline
In-Reply-To: <20250916160951.541279-11-edumazet@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,secunet.com,gondor.apana.org.au];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.40


--cfbkzohclohupiwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 04:09:51PM GMT, Eric Dumazet wrote:
> Move skb freeing from udp recvmsg() path to the cpu
> which allocated/received it, as TCP did in linux-5.17.
>=20
> This increases max thoughput by 20% to 30%, depending
> on number of BH producers.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

I encountered problems in 6.18-rc1 which were bisected to this patch,
mainline commit 6471658dc66c ("udp: use skb_attempt_defer_free()").

The way to reproduce is starting a ssh connection to a host which
matches a security policy. The first problem seen in the log is hitting
the check

	WARN_ON(x->km.state !=3D XFRM_STATE_DEAD);

in __xfrm_state_destroy() with a stack like this:

[  114.112830] Call Trace:
[  114.112832]  <IRQ>
[  114.112835]  __skb_ext_put+0x96/0xc0
[  114.112840]  napi_consume_skb+0x42/0x110
[  114.112842]  net_rx_action+0x14a/0x350
[  114.112846]  ? __napi_schedule+0xb6/0xc0
[  114.112848]  ? igb_msix_ring+0x6c/0x80 [igb 65a71327db3d237d6ebd4db22221=
016aa90703c9]
[  114.112854]  handle_softirqs+0xca/0x270
[  114.112858]  __irq_exit_rcu+0xbc/0xe0
[  114.112860]  common_interrupt+0x85/0xa0
[  114.112863]  </IRQ>

After that, the system quickly becomes unusable, the immediate crash
varies, often it's in a completely different part of kernel (e.g. amdgpu
driver).

Tomorrow I'll try reproducing with panic_on_warn so that I can get more
information.

Michal

>  net/ipv4/udp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 7d1444821ee51a19cd5fd0dd5b8d096104c9283c..0c40426628eb2306b60988134=
1a51307c4993871 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1825,6 +1825,13 @@ void skb_consume_udp(struct sock *sk, struct sk_bu=
ff *skb, int len)
>  	if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
>  		sk_peek_offset_bwd(sk, len);
> =20
> +	if (!skb_shared(skb)) {
> +		if (unlikely(udp_skb_has_head_state(skb)))
> +			skb_release_head_state(skb);
> +		skb_attempt_defer_free(skb);
> +		return;
> +	}
> +
>  	if (!skb_unref(skb))
>  		return;
> =20
> --=20
> 2.51.0.384.g4c02a37b29-goog
>=20
>=20

--cfbkzohclohupiwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmjtcroACgkQ538sG/LR
dpUFAgf/daI+OdBjTzCu9/mkqZHsFPeLe28ONTAuGcWjgPU4LpRf6LJIW7z9tmrH
vIHs1k5ceVB11AI6b1pmc4nQWcgRhmOfxxaULrTbyZwi8L28hkiA0MqINP8XiY8d
Ge07KMWsy7A6o/+4FpE1u2Omfy95QtoQaFWwKl4dCHfEnX+zCwNOO+qweYfD6N1G
c6jevNLnR1VKoHdQEqsVPDqCVLqdn3p+5cunWhCK+heYcy/97Qb1qNpVYxdIk4aQ
Tt6AT8KHQnzLDX2yFFheJGMWstSNvchU6CqabVqih9JLeU0LEEgVwJItaCS9gYdn
K5/wOvcJbUTmyo4df74zI9zmMxJRfg==
=lSLt
-----END PGP SIGNATURE-----

--cfbkzohclohupiwg--

