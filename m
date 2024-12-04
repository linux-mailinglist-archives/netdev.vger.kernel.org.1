Return-Path: <netdev+bounces-149111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B19E43AB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5797FB29197
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D61A8F63;
	Wed,  4 Dec 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXBF5GDD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480B156997;
	Wed,  4 Dec 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336332; cv=none; b=ZXlvZyUW9UA78peGubXU0OJyeKAxPCHKNREXldmXa8FEQsllVMDkHjSnprdJMVecoN7l8Nu+gYRU5prOi3dEgXx+quCiWb2sj9MD8qL5jXMnqttMvjaxUCfc3VTN/01WmbpPZgjZtedyBiLQrKiFcO5XXYa4oOBOHeLSJk575Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336332; c=relaxed/simple;
	bh=iIT9WTlddAJaqwr/4YoIF8Qi4AeZGWiinhaOc3oGwEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnRPZlON0TXzecqtdw+XK0OhzrWzhDBfW9YJxJI886rq/tqWeR9eFOHAZ/0j7WEQ/lvM2no/ohK/DZ8voQqKgmDh//cKlafCbKhvaTsZtPyiVnBWEiHc66A7aUx0k+8+nQ+S0UmowK4J6j+IgSTCGX5CkmPmZCnLsydzDsb2yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXBF5GDD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e35912f1so63472f8f.3;
        Wed, 04 Dec 2024 10:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336329; x=1733941129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvYXiMNIXwBmvuPCaPr45HpFOmqvpqbSH+NMAIqTqIY=;
        b=UXBF5GDDlHlW4jov2Uf440nDiykTQUKFxrnflJLK8Owk60wqYXDQ78AA8pHIpgvrdZ
         wP3NrRjOP/OKjczrkfPGi7/cwI5dM5rszJ8HG2qHX1Tw54CZlvsCLTIcyMGdyV/ZJHNH
         JcFqwrbDTkrYX838gQcqbiP5ED09ewBvTAVstYDXGGaz/46oeWUxpM4bpVOXlNqVvtsB
         jFsbN5j7l6nOHkOYJTp8H/hjZ9JMgd5I/YeEo1lPNqHp9aZvRs9y5N/ah9/ZI/4Z5qS8
         1k3fzeTdSYEFf3QFg0N1Ggtk/3bHnRX+xYA4Ho2AGbVOaHzD3Pf+mVSaJNBvWjCfkDWI
         kwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336329; x=1733941129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvYXiMNIXwBmvuPCaPr45HpFOmqvpqbSH+NMAIqTqIY=;
        b=Wz1Tx9KhIg5Dbruyz3jzVbaMt2UBEvRWMcnNZin62gYUw+qATB1Ju+a3an1z/EvjYM
         iXWYV9jJOH6mxpuo+YF6WSVNQVCuzVtpudEvpXjyVuMRtC+bE0reazn8V3IjNP/Rm0sC
         60pV50a7xs9Tz4kpqezxcvIAx7cO1pN+n9pjnxHPuGsm+Tm1OxJd4pH5plQfQljRPO1I
         b27SNNStJCzWCYodUJ73v3ISg1NdZMfmKqmCSuS/gEK+jV44bxSqQtzIcJgefQpfcEFt
         N68RtiJQbRkD6psUAaEcjqOJrDlXHELECJVlrxnGN26M9z2k2Z24eCjWwt2hJl92OB0x
         gj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUh/JVyUr4SfGHKw1CENeZKMDozoGVptDT+zjtuHpUEvV5nkhMBy8u6A2l8H7MNbS2xwvGAozRI@vger.kernel.org, AJvYcCWkfTQJyGMGXvXsndRt6HE7+5H0PZITItk/KiClPI6YmB1A9W/0k3G1YK0c4DQ4tMqzdmdWwGplL2F0RU4=@vger.kernel.org, AJvYcCXy/gmoXcthIl4fNJJuvce/NRdzbS4S+McRuWlNxvTesXgi2E3nsHsuFXwiM9lKRdLLO1f2UTpWXetv1Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3kP+8ZRLJUHUYZtKV5jspLNQC4IfKY/i1kWDsRr4RwiwudQI
	N/j0bM6pwPM1nEka/QAypYQMAjd1Ltr9Vu2AFPOdxUGT7vbVXqoF
X-Gm-Gg: ASbGnctuXfTfw4pJxwW89Oe/2O9OpHwalFvFKguR5qOyUd7nicruPB0Q37NcnJ9byV0
	11vcbf3Z6TenVco4GyLiQZoEEgc9DLJbuOvXGkc1hEK0U+jk/+pKBZHBKR0SH+sb5TYobFEN1g4
	y4AjOI9CwARpxQ80JpT0QQCTNbscF3dZbul0TpbbMJXAvI4BWrTrOxEyAIJiPktL8QmhhKgLpC7
	zqMn0EvtrLE/yOE91UtJ4cD/f3Kqkw0iM9Glh5VjKuEMTugxRSz8dHypOAC4+i1o9CZyYfaR5PA
	T8f9DqnslbH33+DCNOgEGTdGHCkuiNP6AwZ/
X-Google-Smtp-Source: AGHT+IHBkvT0ri1XCR+aU4iikxdd7BREWggswkR0IWXNfrk6Mcb/whX3n+sIiaZsFIAUhv8N+QosMQ==
X-Received: by 2002:a05:6000:2b12:b0:385:df8a:b489 with SMTP id ffacd0b85a97d-385fd42d422mr5214681f8f.55.1733336328708;
        Wed, 04 Dec 2024 10:18:48 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d7264f27sm18145336f8f.80.2024.12.04.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:18:47 -0800 (PST)
Date: Wed, 4 Dec 2024 19:18:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jon Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
	Furong Xu <0x1207@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
	Thierry Reding <treding@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <pckuhqpx33woc7tgcv4mluhwg2clriokzb7r4vkzmr6jz3gy3p@hykwm4qtgv6f>
References: <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com>
 <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
 <klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
 <df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>
 <2g2lp3bkadc4wpeslmdoexpidoiqzt7vejar5xhjx5ayt3uox3@dqdyfzn6khn6>
 <Z1CFz7GpeIzkDro1@shell.armlinux.org.uk>
 <9719982a-d40c-4110-9233-def2e6cb4d74@nvidia.com>
 <Z1CVRzWcSDuPyQZe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iwdew6aguv2p2efu"
Content-Disposition: inline
In-Reply-To: <Z1CVRzWcSDuPyQZe@shell.armlinux.org.uk>


--iwdew6aguv2p2efu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
MIME-Version: 1.0

On Wed, Dec 04, 2024 at 05:45:43PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 04, 2024 at 05:02:19PM +0000, Jon Hunter wrote:
> > Hi Russell,
> >=20
> > On 04/12/2024 16:39, Russell King (Oracle) wrote:
> > > On Wed, Dec 04, 2024 at 04:58:34PM +0100, Thierry Reding wrote:
> > > > This doesn't match the location from earlier, but at least there's
> > > > something afoot here that needs fixing. I suppose this could simply=
 be
> > > > hiding any subsequent errors, so once this is fixed we might see ot=
her
> > > > similar issues.
> > >=20
> > > Well, having a quick look at this, the first thing which stands out i=
s:
> > >=20
> > > In stmmac_tx_clean(), we have:
> > >=20
> > >                  if (likely(tx_q->tx_skbuff_dma[entry].buf &&
> > >                             tx_q->tx_skbuff_dma[entry].buf_type !=3D =
STMMAC_TXBUF_T
> > > _XDP_TX)) {
> > >                          if (tx_q->tx_skbuff_dma[entry].map_as_page)
> > >                                  dma_unmap_page(priv->device,
> > >                                                 tx_q->tx_skbuff_dma[e=
ntry].buf,
> > >                                                 tx_q->tx_skbuff_dma[e=
ntry].len,
> > >                                                 DMA_TO_DEVICE);
> > >                          else
> > >                                  dma_unmap_single(priv->device,
> > >                                                   tx_q->tx_skbuff_dma=
[entry].buf,
> > >                                                   tx_q->tx_skbuff_dma=
[entry].len,
> > >                                                   DMA_TO_DEVICE);
> > >                          tx_q->tx_skbuff_dma[entry].buf =3D 0;
> > >                          tx_q->tx_skbuff_dma[entry].len =3D 0;
> > >                          tx_q->tx_skbuff_dma[entry].map_as_page =3D f=
alse;
> > >                  }
> > >=20
> > > So, tx_skbuff_dma[entry].buf is expected to point appropriately to the
> > > DMA region.
> > >=20
> > > Now if we look at stmmac_tso_xmit():
> > >=20
> > >          des =3D dma_map_single(priv->device, skb->data, skb_headlen(=
skb),
> > >                               DMA_TO_DEVICE);
> > >          if (dma_mapping_error(priv->device, des))
> > >                  goto dma_map_err;
> > >=20
> > >          if (priv->dma_cap.addr64 <=3D 32) {
> > > ...
> > >          } else {
> > > ...
> > >                  des +=3D proto_hdr_len;
> > > ...
> > > 	}
> > >=20
> > >          tx_q->tx_skbuff_dma[tx_q->cur_tx].buf =3D des;
> > >          tx_q->tx_skbuff_dma[tx_q->cur_tx].len =3D skb_headlen(skb);
> > >          tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page =3D false;
> > >          tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type =3D STMMAC_TXBUF_=
T_SKB;
> > >=20
> > > This will result in stmmac_tx_clean() calling dma_unmap_single() using
> > > "des" and "skb_headlen(skb)" as the buffer start and length.
> > >=20
> > > One of the requirements of the DMA mapping API is that the DMA handle
> > > returned by the map operation will be passed into the unmap function.
> > > Not something that was offset. The length will also be the same.
> > >=20
> > > We can clearly see above that there is a case where the DMA handle has
> > > been offset by proto_hdr_len, and when this is so, the value that is
> > > passed into the unmap operation no longer matches this requirement.
> > >=20
> > > So, a question to the reporter - what is the value of
> > > priv->dma_cap.addr64 in your failing case? You should see the value
> > > in the "Using %d/%d bits DMA host/device width" kernel message.
> >=20
> > It is ...
> >=20
> >  dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device width
>=20
> So yes, "des" is being offset, which will upset the unmap operation.
> Please try the following patch, thanks:
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b262cdad60b..c81ea8cdfe6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  	struct stmmac_txq_stats *txq_stats;
>  	struct stmmac_tx_queue *tx_q;
>  	u32 pay_len, mss, queue;
> +	dma_addr_t tso_des, des;
>  	u8 proto_hdr_len, hdr;
> -	dma_addr_t des;
>  	bool set_ic;
>  	int i;
> =20
> @@ -4289,14 +4289,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> =20
>  		/* If needed take extra descriptors to fill the remaining payload */
>  		tmp_pay_len =3D pay_len - TSO_MAX_BUFF_SIZE;
> +		tso_des =3D des;
>  	} else {
>  		stmmac_set_desc_addr(priv, first, des);
>  		tmp_pay_len =3D pay_len;
> -		des +=3D proto_hdr_len;
> +		tso_des =3D des + proto_hdr_len;
>  		pay_len =3D 0;
>  	}
> =20
> -	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags =3D=3D 0), queue);
> +	stmmac_tso_allocator(priv, tso_des, tmp_pay_len, (nfrags =3D=3D 0), que=
ue);
> =20
>  	/* In case two or more DMA transmit descriptors are allocated for this
>  	 * non-paged SKB data, the DMA buffer address should be saved to

I see, that makes sense. Looks like this has been broken for a few years
(since commit 34c15202896d ("net: stmmac: Fix the problem of tso_xmit"))
and Furong's patch ended up exposing it.

Anyway, this seems to fix it for me. I can usually trigger the issue
within one or two iperf runs, with your patch I haven't seen it break
after a dozen or so runs.

It may be good to have Jon's test results as well, but looks good so
far.

Thanks!
Thierry

--iwdew6aguv2p2efu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQnQIACgkQ3SOs138+
s6GyGA/+Mi+zWzm7HiVlhKv4XJWkUknxqYmbqs0d/bC8641dT3ogSqPfVbcMFbZO
s9APdaIXCK2cRivM9PTITkrIrK0YHwgHgbvv0ronPOnsvcX0i4uZ2q/QtILbznwX
ch7P++KrfYTPikIqDP1GC77bC1L9l5BYzc+/iOTltKRqA9oM/t0cclTVegQkfzdE
cLfTJ4JzYkqneOl69+f3P5pOLnr1wj3tULGssJK5oDg71gIz6JgtieLgRSV+4d5s
b6R79vnIJXeWMUK0JN+7yt49SatPrbVMMg5qluURZDmKO4TMIZuVIuq0qK8H7+pf
atrCkAZIpNKRLnVkN7BZQCsYk/LuDSsZn3DRnCRTo4q/DW5jCO1A7XCQhqV7jnNZ
9QgZePJR/3STPPC04E37NKKdLiBpinUZcVIgm/EIcXD/mlTJEEFVtTD2f0PucOk7
AHYRkbHIZ7kvsBVtVG7lW+Z5Y2FE19o5RnhoSNpIgubPRAZXmZSP00PTKxAmdyOo
HTapRMCe381Y9gjKeIy7ZpFpA0CHqH6WqJAb47DYdKKRaAfZbAgTujOg2NYXhRMO
43MHpldVISdfxs0wENT0QnHHV3sWCfFa5cJvwRwm/Cr/3y3Ia4LM+mZx5hggaMfJ
YvlC+2075bywCZn7qfrZ7PxFE5FEgz1RJar4do29uSnbdP5TUBU=
=p0Oa
-----END PGP SIGNATURE-----

--iwdew6aguv2p2efu--

