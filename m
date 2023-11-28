Return-Path: <netdev+bounces-51780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC37FC048
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F8D282BAD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4345D900;
	Tue, 28 Nov 2023 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGAp20VK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E410A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701192571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0MElT7rwEN0SaykH2dO3OT1jZCKyJDqcLTwsNXebzYo=;
	b=SGAp20VK/x/DjOOFkpqkM2Z7p6dTIntMEeYPNsKRtka9WI941ErG0XRo6EfaRz2lh9gUYn
	M0NjgLwTKeq4tKu7PRY7ajYdvkODRJ/6XkH8YpFctdCkghje0OUFtZzpxJRsIxhIOJVocG
	AIS3kimeoEKwLe62CW5C4WqpprQWZ0w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-WUGgGwEkPi-Ch60RRNTpwA-1; Tue, 28 Nov 2023 12:29:30 -0500
X-MC-Unique: WUGgGwEkPi-Ch60RRNTpwA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332d213c2bbso3955503f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 09:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701192569; x=1701797369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MElT7rwEN0SaykH2dO3OT1jZCKyJDqcLTwsNXebzYo=;
        b=TM9QCn+qXEmH6EC01fLNWib70Sl8JsMLR3YXMrMHhGXwLTa2nsaP0d122I1S5n2noI
         X+7I6eROUUIkdl7GtOIdPpXhtePHsUc3f4maf8msUU5OmNE0M8dK3xC94Cv4Ds4FzU9x
         W235++LLS41wLgDNw2hcQ/XiBQAGNuXv/PvcOokNNso/SOGfIY0Zc1TrKFbQvdJcBKKf
         jxIFezdsGJdoQh5vGEfX1WRnIyBimifYGU/EOxdO6tDGvgtAtw2Kv3tqOL0+KAR/tcNb
         mLtdQgrX34UGNUxkapeN/FUFlaN4QnqFKGLnD+oX2NguOxkT5d0ua4M8d9rqolmXYlBH
         9x6w==
X-Gm-Message-State: AOJu0Yw4phLwhe30mEoUmrjtj7IMw/bGAMP2HPy5U76WERI4NwY+iMLL
	hgbuUDDAvZrvdX2+UN6WI72Xa698L/rRZskf9ZO03jIecrBLf4L8yyZ/Xf0BXUsLsCU7r9ImRFl
	kaSfr9uqwiw++YUil
X-Received: by 2002:a5d:6484:0:b0:333:145e:f529 with SMTP id o4-20020a5d6484000000b00333145ef529mr256672wri.33.1701192565710;
        Tue, 28 Nov 2023 09:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEleDtTtI8s+JD3FBrOw6Zjt0dVOM3F5/mRTRnu3JFQI7HoKK12Jzzgi5mhXXDDyQzZbKQgOg==
X-Received: by 2002:a5d:6484:0:b0:333:145e:f529 with SMTP id o4-20020a5d6484000000b00333145ef529mr256538wri.33.1701192562844;
        Tue, 28 Nov 2023 09:29:22 -0800 (PST)
Received: from localhost (net-93-66-52-16.cust.vodafonedsl.it. [93.66.52.16])
        by smtp.gmail.com with ESMTPSA id v19-20020adfd053000000b0032f9688ea48sm15262153wrh.10.2023.11.28.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:29:22 -0800 (PST)
Date: Tue, 28 Nov 2023 18:29:20 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	lorenzo@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
	hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
Message-ID: <ZWYjcNlo7RAX8M0T@lore-desk>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64V85SnXPArICkGQ"
Content-Disposition: inline
In-Reply-To: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>


--64V85SnXPArICkGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add multi-buffer support
> for xdp running in generic mode.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/core/dev.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3950ced396b5..5a58f3e28657 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, =
struct xdp_buff *xdp,
>  	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
>  	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
>  			 skb_headlen(skb) + mac_len, true);
> +	if (skb_is_nonlinear(skb)) {
> +		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
> +		xdp_buff_set_frags_flag(xdp);
> +	} else {
> +		xdp_buff_clear_frags_flag(xdp);
> +	}
> =20
>  	orig_data_end =3D xdp->data_end;
>  	orig_data =3D xdp->data;
> @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, =
struct xdp_buff *xdp,
>  		skb->len +=3D off; /* positive on grow, negative on shrink */
>  	}
> =20
> +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 */
> +	if (xdp_buff_has_frags(xdp))
> +		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> +	else
> +		skb->data_len =3D 0;
> +
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth =3D (struct ethhdr *)xdp->data;
>  	if ((orig_eth_type !=3D eth->h_proto) ||
> @@ -4927,9 +4941,9 @@ static u32 netif_receive_generic_xdp(struct sk_buff=
 *skb,
>  	if (skb_is_redirected(skb))
>  		return XDP_PASS;
> =20
> -	/* XDP packets must be linear and must have sufficient headroom
> -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> -	 * native XDP provides, thus we need to do it here as well.
> +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> +	 * bytes. This is the guarantee that also native XDP provides,
> +	 * thus we need to do it here as well.
>  	 */
>  	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> @@ -4943,8 +4957,12 @@ static u32 netif_receive_generic_xdp(struct sk_buf=
f *skb,
>  				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
>  				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
>  			goto do_drop;
> -		if (skb_linearize(skb))
> -			goto do_drop;
> +
> +		/* XDP does not support fraglist */
> +		if (skb_has_frag_list(skb) || !xdp_prog->aux->xdp_has_frags) {
> +			if (skb_linearize(skb))
> +				goto do_drop;

@Jakub: iirc we were discussing something similar for veth [0].
Here pskb_expand_head() reallocates skb paged data (skb_shinfo()->frags[])
just if the skb is cloned and if it is zero-copied [1] while in skb_cow_dat=
a()
we always reallocate the paged area if skb_shinfo()->nr_frags is set [2].
Since the eBPF program can theoretically modify paged data, I would say we
should do the same we did for veth even here, right?

Regards,
Lorenzo

[0] https://lore.kernel.org/netdev/20220312131806.1c2919ba@kicinski-fedora-=
pc1c0hjn.dhcp.thefacebook.com/
[1] https://elixir.bootlin.com/linux/v6.6.2/source/net/core/skbuff.c#L2113
[2] https://elixir.bootlin.com/linux/v6.6.2/source/net/core/skbuff.c#L5016

> +		}
>  	}
> =20
>  	act =3D bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> --=20
> 2.43.0
>=20

--64V85SnXPArICkGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWYjcAAKCRA6cBh0uS2t
rLzGAQD/o6fvioIA4VQ/IXTLH47kovpscoXfpJG6tsRpHOLlyAEAswxoMzRnj2Ty
PPd3e6zKSFTKGjQkut+O1goHLUHJmQ4=
=XMBb
-----END PGP SIGNATURE-----

--64V85SnXPArICkGQ--


