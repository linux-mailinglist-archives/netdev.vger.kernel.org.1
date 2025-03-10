Return-Path: <netdev+bounces-173473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E63A5924F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376DF16A981
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4A226D1E;
	Mon, 10 Mar 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir5/tmEI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CEC28EA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605050; cv=none; b=IuF/budan7doTAw2qIXvRMIWPxQh6WKBF3c51DHH3ZHpKrx2HiemHrvVziuwaN3BbZQIlpH/FbLnnXrL4Ztt9bDu6oYyiKpCyyDx9qioz+lQlG5MfmGw4s8zT9F7aw1BeQes7YrpwMGrJYaJApU8sF0Q2VJKexwGIngQB01a6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605050; c=relaxed/simple;
	bh=DUGY4RyTyyLtGebb4mM1O6agnYPAK8XjRLZ4xWFyKiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Ge3g+jASQXeaeVvEZchrVA50+qBBu3hJMVuBLVNL+Hwx/EvTffDA+laNhcf4mC9L9iMh2WT96mGltPBljFTWl4dclt8q/eQBv8huEUGcHyTBMqALSF/8woIz4pH0kuA0TVXDKWXI7kOUhRrODt+7uly3/WIn6t9x9S0jgXXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ir5/tmEI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741605047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jWsvyVdHh4CdZ3fxBfjm7tC0neUuEN9Dv7lVimkztQ=;
	b=Ir5/tmEIndysYNvT8hHFxZ91irWao47ueoWVCdGN92DuSetv98fQ/VlpbFJ6TUPKp5CQik
	epc9LUyFczRGHpCFWrpn60qAiSr8M+cSJF0EaUPUlzn2aCz8uUXLtXr0y5uTZFcSrOj4Wy
	576XCQyC5iGnT9NkREB4P8Mugd4dsA0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-j3tCAwnzPfCSVsID6Mabeg-1; Mon, 10 Mar 2025 07:10:43 -0400
X-MC-Unique: j3tCAwnzPfCSVsID6Mabeg-1
X-Mimecast-MFC-AGG-ID: j3tCAwnzPfCSVsID6Mabeg_1741605043
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso27256855e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 04:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741605042; x=1742209842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jWsvyVdHh4CdZ3fxBfjm7tC0neUuEN9Dv7lVimkztQ=;
        b=xO+U4pqACCaVAob+aEEhiAoO0+BUxu5Ub0t9dIER/iTajl7Yzb/j+b0N3v7liiZg2R
         +TaNYI2P48xeme4e05DmQD5014i1CwVra5VI56ZS5C2GmXSXhZHBLMhcLKD5hNIAUiyr
         cLTKRO+VuxoBDJ5rynlYWLIVfDr+v/EHASx6iK+OVm2S1hWmLHrvxkEfZOH3gr5vBhCo
         0Qy0NLN2BXRMC60MCXpALbogqcnyJm6+594xWL1MY2FiXwl2Nhkq7Plxr3qt0RKczoLg
         +uxeVpDQKo6m/ZMHRZ9BWCMlIi6F5Vq6k3P8IeD+0k7Q0okttibbjSX/2Bp4DfOYaiKd
         sD3g==
X-Forwarded-Encrypted: i=1; AJvYcCUj0ODmz2EFmJ58LO86rhgvqbReg3Mm/ror1pNfN297am06fD4qrRxOZwUiN3qUI+rQyKH7CZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lCu1+l52ibfkbHweYyOm5UHDBQRzMg4pe2+SOkjzKg+xo9oV
	h9yU7MGg3J6R6PLQGEjIp4RXxRBjCiNYseqOFFaFcep9b7AhoFk9/RoD7Fsfb2lvJpbAKzsoU88
	Or/hYw9L29wfKU4tSB+xbvYl+aX1nWsr2BVi/y/0UjIZQNGqKRMRESw==
X-Gm-Gg: ASbGncv5tX53f/m7DoDzE354OPHAAjAgXOI7nzRWz4EqpE1DUml0nsbICKTTz+gU7Eh
	NNyxEDpLEBHJVs4i74vN37pTOrJSbWMYwgBl7zd6zL/jwRtWY3YrK2L6xe0uoQs1kAYVeNitU8v
	Ipd6ZFmPWWww+7NwG09lOSzcFauyWMqGtQlA+++Tg4OxYY82bhqHQeDe3sau/cplwySddmpYJkQ
	apvGNz9Zp7WXr7C1D/kktwhzihCdg27+xUjLS40et6v/WQsmCpfvqTK35LEiQaCTRMdMQqdoD/R
	XOh0PYU7Ljry2JV3ow+ZkcH7PAvTcsLTEQtgcLia/y2I/RcxwjfV9bHvP0vdpe0=
X-Received: by 2002:a05:600c:198d:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43cfdbe4493mr8051405e9.6.1741605042527;
        Mon, 10 Mar 2025 04:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxQKAfcGbfVbc7RudCGgbeyKyDopEFEZ7+6RTPv/GSQ7F2awFFsus6B9IaNk9E9lRJ5njVvw==
X-Received: by 2002:a05:600c:198d:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43cfdbe4493mr8051125e9.6.1741605042048;
        Mon, 10 Mar 2025 04:10:42 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea4619e9sm57800125e9.1.2025.03.10.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:10:41 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:10:40 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Arthur Fabre <arthur@arthurfabre.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	yan@cloudflare.com, jbrandeburg@cloudflare.com, thoiland@redhat.com,
	lbiancon@redhat.com, Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 07/20] xdp: Track if metadata is supported
 in xdp_frame <> xdp_buff conversions
Message-ID: <Z87IsCfNrjEKCHz0@lore-desk>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com>
 <bc356c91-5bff-454a-8f87-7415cb7e82b4@intel.com>
 <D88HSZ3GZZNN.160YSWHX1HIO2@arthurfabre.com>
 <45522396-0fad-406e-ba53-0bb4aee53e67@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JtkONm/S2nFS2F49"
Content-Disposition: inline
In-Reply-To: <45522396-0fad-406e-ba53-0bb4aee53e67@kernel.org>


--JtkONm/S2nFS2F49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > >=20
>=20
> I'm fairly sure that all drivers support XDP_REDIRECT.
> Except didn't Lorenzo add a feature bit for this?
> (so, some drivers might explicitly not-support this)

I think most of the drivers support XDP_REDIRECT. IIRC just some vf
implementations (e.g. ixgbevf or thunder/nicvf do not support XDP_REDIRECT).
Maybe nfp is a special case.

Regards,
Lorenzo

>=20
> > > So maybe we need to fix those drivers first, if there are any.
> >=20
> > Most drivers don't support metadata unfortunately:
> >=20
> > > rg -U "xdp_prepare_buff\([^)]*false\);" drivers/net/
> > drivers/net/tun.c
> > 1712:		xdp_prepare_buff(&xdp, buf, pad, len, false);
> >=20
> > drivers/net/ethernet/microsoft/mana/mana_bpf.c
> > 94:	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, false);
> >=20
> > drivers/net/ethernet/marvell/mvneta.c
> > 2344:	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_=
SIZE,
> > 2345:			 data_len, false);
> >=20
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > 1436:	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
> > 1437:			 cqe->sg.seg_size, false);
> >=20
> > drivers/net/ethernet/socionext/netsec.c
> > 1021:		xdp_prepare_buff(&xdp, desc->addr, NETSEC_RXBUF_HEADROOM,
> > 1022:				 pkt_len, false);
> >=20
> > drivers/net/ethernet/google/gve/gve_rx.c
> > 740:	xdp_prepare_buff(&new, frame, headroom, len, false);
> > 859:		xdp_prepare_buff(&xdp, page_info->page_address +
> > 860:				 page_info->page_offset, GVE_RX_PAD,
> > 861:				 len, false);
> >=20
> > drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > 3984:			xdp_prepare_buff(&xdp, data,
> > 3985:					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
> > 3986:					 rx_bytes, false);
> >=20
> > drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> > 794:		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
> > 795:				 buff->len, false);
> >=20
> > drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > 554:	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);
> >=20
> > drivers/net/ethernet/ti/cpsw_new.c
> > 348:		xdp_prepare_buff(&xdp, pa, headroom, size, false);
> >=20
> > drivers/net/ethernet/freescale/enetc/enetc.c
> > 1710:	xdp_prepare_buff(xdp_buff, hard_start - rx_ring->buffer_offset,
> > 1711:			 rx_ring->buffer_offset, size, false);
> >=20
> > drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > 1335:		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
> > 1336:				 pkt_len, false);
> >=20
> > drivers/net/ethernet/ti/cpsw.c
> > 403:		xdp_prepare_buff(&xdp, pa, headroom, size, false);
> >=20
> > drivers/net/ethernet/sfc/rx.c
> > 289:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
> > 290:			 rx_buf->len, false);
> >=20
> > drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > 2097:			xdp_prepare_buff(&xdp, data, MTK_PP_HEADROOM, pktlen,
> > 2098:					 false);
> >=20
> > drivers/net/ethernet/sfc/siena/rx.c
> > 291:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
> > 292:			 rx_buf->len, false)
> >=20
> > I don't know if it's just because no one has added calls to
> > skb_metadata_set() in yet, or if there's a more fundamental reason.
> >=20
>=20
> I simply think driver developers have been lazy.
>=20
> If someone want some easy kernel commits, these drivers should be fairly
> easy to fix...
>=20
> > I think they all reserve some amount of headroom, but not always the
> > full XDP_PACKET_HEADROOM. Eg sfc:
> >=20
>=20
> The Intel drivers use 192 (AFAIK if that is still true). The API ended
> up supporting non-standard XDP_PACKET_HEADROOM, due to the Intel
> drivers, when XDP support was added to those (which is a long time ago no=
w).
>=20
> > drivers/net/ethernet/sfc/net_driver.h:
> > /* Non-standard XDP_PACKET_HEADROOM and tailroom to satisfy XDP_REDIREC=
T and
> >   * still fit two standard MTU size packets into a single 4K page.
> >   */
> > #define EFX_XDP_HEADROOM	128
> >=20
>=20
> This is smaller than most drivers, but still have enough headroom for
> xdp_frame + traits.
>=20
> > If it's just because skb_metadata_set() is missing, I can take the
> > patches from this series that adds a "generic" XDP -> skb hook ("trait:
> > Propagate presence of traits to sk_buff"), have it call
> > skb_metadata_set(), and try to add it to all the drivers in a separate
> > series.
> >=20
>=20
> I think someone should cleanup those drivers and add support.
>=20
> --Jesper
>=20
> > > >   	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> > > >   	 * while mem_type is valid on remote CPU.
> > > >   	 */
> > > > @@ -369,6 +374,8 @@ void xdp_convert_frame_to_buff(const struct xdp=
_frame *frame,
> > > >   	xdp->data =3D frame->data;
> > > >   	xdp->data_end =3D frame->data + frame->len;
> > > >   	xdp->data_meta =3D frame->data - frame->metasize;
> > > > +	if (frame->meta_unsupported)
> > > > +		xdp_set_data_meta_invalid(xdp);
> > > >   	xdp->frame_sz =3D frame->frame_sz;
> > > >   	xdp->flags =3D frame->flags;
> > > >   }
> > > > @@ -396,6 +403,7 @@ int xdp_update_frame_from_buff(const struct xdp=
_buff *xdp,
> > > >   	xdp_frame->len  =3D xdp->data_end - xdp->data;
> > > >   	xdp_frame->headroom =3D headroom - sizeof(*xdp_frame);
> > > >   	xdp_frame->metasize =3D metasize;
> > > > +	xdp_frame->meta_unsupported =3D xdp_data_meta_unsupported(xdp);
> > > >   	xdp_frame->frame_sz =3D xdp->frame_sz;
> > > >   	xdp_frame->flags =3D xdp->flags;
> > >=20
> > > Thanks,
> > > Olek
>=20

--JtkONm/S2nFS2F49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ87IsAAKCRA6cBh0uS2t
rK6DAQD8r1mxdVzGu3go8xjrg+CDLC/xqM32YU4Lm0ICfcuq3AD/ZtDKNq13aynZ
k34lgXcO45VmQl+CqVUCjXsiFrZgmAw=
=7cKB
-----END PGP SIGNATURE-----

--JtkONm/S2nFS2F49--


