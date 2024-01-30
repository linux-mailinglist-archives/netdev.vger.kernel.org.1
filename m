Return-Path: <netdev+bounces-67233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B608426E0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F3E1C24FAF
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE16DD19;
	Tue, 30 Jan 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+so500j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811176DD08
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624793; cv=none; b=fmsGRrVMlSgXE58O42KxI82jYTvB6uiS6XMBnPBsp2uDVrauu6exKnB1ek1mbhB9k3L6MiTiMWivlqvKlDAtDcVpdXQTH+rXdwlcA51JwSryZBn8e04uKRaAhXBAauJRi1yvXlaMc5RJXz8YzhW+4t2qjrbTYk+intsZS/OdUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624793; c=relaxed/simple;
	bh=Z/oi0TD9rbRhOMY02/K6GmzYztRqlv+XAYiT0wztfMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQL0yOg/Kcf+cLn2478hq84oaiDlWdZysLYYDP1oMGwa9qiUcJKY5GoWKcSnDynV6tcRkenPZfBqoWO63Fu1UR2JqrWutZNfmXI1DFcJeC8MbXaEFG/5G8pQTssiA4uy56iPEwt2BdxczXiajcJYeUR7kitMHFwi76J6fgi74LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+so500j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706624790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gc5CUVQVf9N+E+8WHXLrMTrpzxHA+Wq5e9QjeRUgRxM=;
	b=f+so500j8NNq7YJi/JBNaAvCvDpAu85cbZD0ypJpH217lAXwRHzyHucPtVZEHk8OeUolAB
	9t0dvU0upw+hvgEJtfDM1FtyqvDH+6wjvI4k5bXSMwExQ69DLAXCgWT+aueP+Ew8NEgeLx
	bAJ5fjGiPxUQ41rNWQIJxkE59v4dzh0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-__v0kdjoMD2-bDJQdYLWag-1; Tue, 30 Jan 2024 09:26:26 -0500
X-MC-Unique: __v0kdjoMD2-bDJQdYLWag-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33af105d951so829758f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 06:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706624785; x=1707229585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc5CUVQVf9N+E+8WHXLrMTrpzxHA+Wq5e9QjeRUgRxM=;
        b=hsybAOW4ySPJ/B+UT1gR25osVGuvkEGde+jEUm3uQErVKR0GOs4+yNncXSWwMgNoau
         9xVR08zpwo9yU37Ou/zb64gLxsDrrZOyL9NQsnS3uSXY9IqmQNxizDCq6vfq2AlrI987
         9TXar5qK0oa3ed0Fi2FL0+XR/UqcUocCtifhpeSqPeMbOWiu3LJNglPW76oMCHof0OQl
         /55e9iBNxLzl/nyDYZ1Xs21c6RE8kMWtlAHdTF0CCDUiDoVma8gyHS/7sIZ2/GCniJim
         YVZ65gKyIrQ4bqqPDlu4jKveykICmjP3anRTsK151FvMnM/jbc1q6D17F18ElGcsRKou
         CY7Q==
X-Gm-Message-State: AOJu0Yz/AwCtxm4GheLwL5yXMYyRqnHwjk6aSvAWoSUbHYNEnR4GO9Lm
	7xkW9cUr1XuaNwMFU10NSc1eqhErkzP5JqLAvyJU9/zvdcIWFyEapBHuYCtZKfuz2hxh2a6k1HF
	ABadRQwpAaqyP7S0/vRq8H+7smVCIiMNlhFG98MoKV85Q+X0OrU8wSA==
X-Received: by 2002:adf:ea4b:0:b0:33a:f024:271f with SMTP id j11-20020adfea4b000000b0033af024271fmr3823616wrn.68.1706624785529;
        Tue, 30 Jan 2024 06:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Fu0yrcn3zw0ib7zkT6uPNbKttY5Gi+aywjWNqmMpJQAGVVfyJINjAiPLrfDW5s52YxUnyQ==
X-Received: by 2002:adf:ea4b:0:b0:33a:f024:271f with SMTP id j11-20020adfea4b000000b0033af024271fmr3823595wrn.68.1706624785219;
        Tue, 30 Jan 2024 06:26:25 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b0033afbd1962esm1698784wrn.69.2024.01.30.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:26:24 -0800 (PST)
Date: Tue, 30 Jan 2024 15:26:22 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Message-ID: <ZbkHDo4bxcWtGP9X@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <f6273e01-a826-4182-a5b5-564b51f2d9ae@huawei.com>
 <ZbeiZaUrWoj39_LZ@lore-desk>
 <7343292d-3273-a10a-9167-420f3232dbdd@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHXY2NtUZpqv9sEn"
Content-Disposition: inline
In-Reply-To: <7343292d-3273-a10a-9167-420f3232dbdd@huawei.com>


--cHXY2NtUZpqv9sEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2024/1/29 21:04, Lorenzo Bianconi wrote:
> >> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> >>
> >>>  #ifdef CONFIG_LOCKDEP
> >>>  /*
> >>>   * register_netdevice() inits txq->_xmit_lock and sets lockdep class
> >>> @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(void)
> >>>   *
> >>>   */
> >>> =20
> >>> +#define SD_PAGE_POOL_RING_SIZE	256
> >>
> >> I might missed that if there is a reason we choose 256 here, do we
> >> need to use different value for differe page size, for 64K page size,
> >> it means we might need to reserve 16MB memory for each CPU.
> >=20
> > honestly I have not spent time on it, most of the current page_pool use=
rs set
> > pool_size to 256. Anyway, do you mean something like:
> >=20
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f70fb6cad2b2..3934a3fc5c45 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -11806,12 +11806,11 @@ static void __init net_dev_struct_check(void)
> >   *
> >   */
> > =20
> > -#define SD_PAGE_POOL_RING_SIZE	256
> >  static int net_page_pool_alloc(int cpuid)
> >  {
> >  #if IS_ENABLED(CONFIG_PAGE_POOL)
>=20
> Isn't better to have a config like CONFIG_PER_CPU_PAGE_POOL to enable
> this feature? and this config can be selected by whoever needs this
> feature?

since it will be used for generic xdp (at least) I think this will be 99%
enabled when we have bpf enabled, right?

>=20
> >  	struct page_pool_params page_pool_params =3D {
> > -		.pool_size =3D SD_PAGE_POOL_RING_SIZE,
> > +		.pool_size =3D PAGE_SIZE < SZ_64K ? 256 : 16,
>=20
> What about other page size? like 16KB?
> How about something like below:
> PAGE_SIZE << get_order(PER_CPU_PAGE_POOL_MAX_SIZE)

since pool_size is the number of elements in the ptr_ring associated to the=
 pool,
assuming we want to consume PER_CPU_PAGE_POOL_MAX_SIZE for each cpu, someth=
ing
like:

PER_CPU_PAGE_POOL_MAX_SIZE / PAGE_SIZE

Regards,
Lorenzo

>=20
> >  		.nid =3D NUMA_NO_NODE,
> >  	};
> >  	struct page_pool *pp_ptr;
>=20

--cHXY2NtUZpqv9sEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbkHDgAKCRA6cBh0uS2t
rFBwAQCfFe/onm1LzNi7Yk+HxHQYideq3uQK0NB+AFZ5Ad3RLgEAlk8x2QwNxNQs
IyRRcRVgU3GdlOxFX+kHd744W6F4AAs=
=k4fY
-----END PGP SIGNATURE-----

--cHXY2NtUZpqv9sEn--


