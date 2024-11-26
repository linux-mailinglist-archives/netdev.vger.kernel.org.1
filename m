Return-Path: <netdev+bounces-147474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF199D9BFE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6C81634BD
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C911DA0E0;
	Tue, 26 Nov 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV/ht61R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8181D5CE8
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640588; cv=none; b=hUW/K+Qu5UClSdrI2z67cfzmHdZAk1vGweoM8/fo7NNj9Vmdl1xfqxKSEQFhtIPvP4gFJ+RvcnskLmsWeuCry4FzfgCa8tFOlpD34LrQq/dr9uYDtekTEJiaCVC65agHyfBHBsfD0jlmMnmZ48E2AJrKwbUd4RsZAnuausXw4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640588; c=relaxed/simple;
	bh=Vc44FpdxSEPcvHgnCbkopatpzZicbTvysePlsiWncdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaIsjr84m3uoAZZlAF+d1L55tiHcwpnwkE+/G+FPgOl2pjVsEEJ8/pO3DGVxqaxf87JauxMgUPyQ+wIKv0tEX5NzdEzMafYtUPUso5mZA54SOWGOUV22VLrU7TyDjJUvpWkf7EMxIbxdnmUFms4dq9x8/S2ANXf2XNvhTuQZHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV/ht61R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732640586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mm/2Kyik/1arX0uU2PP1mSD7NrkT0+1YjB4HchLmHvs=;
	b=LV/ht61RRgousNkhpVLQliLfIT52vLHKMtjJY8PqX7vP2jQ0Qnzx/tF8DI+qPxPXMzlT9h
	4xol1Gl4m7awef/XR2dnD8EtudNYHn4fzwihgILKI3pCHFgzS+tDBCVWYdhVoXNkZPes3Y
	0mxdZMW8kgbfogqBjTswn02QWzsy7lI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-bLsF4j0bPs2qB15mQAOqKQ-1; Tue, 26 Nov 2024 12:03:04 -0500
X-MC-Unique: bLsF4j0bPs2qB15mQAOqKQ-1
X-Mimecast-MFC-AGG-ID: bLsF4j0bPs2qB15mQAOqKQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382480686f2so3546174f8f.1
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640583; x=1733245383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mm/2Kyik/1arX0uU2PP1mSD7NrkT0+1YjB4HchLmHvs=;
        b=VW1kyNNoD2GUxEAgdNraW/r1aTzZrZCoU10xx9X4LLII9mBxieBGmbTOPoLPHr3ITX
         PP9msVnj+B8ihtHbxvRcm8RJvY8vnfVC3YWIKNO7zMFG3SSeGSA7H5N03/NVBIF861Ij
         LIQWr9PtOAeddvUr+etjxK3z3lvjRRC9fIVmY4AqII8sO3Sq0Y9pJg4rq8zAws1iwnG7
         IVn9amylorN3JzoDTFaNLtX1DOwlLj/5lBYUeQ5tYmasRDNV3kM3DxsXxu4MMOnB0LVJ
         GQI1ZVEIrgi0IMCjXb9GP8dOs0Mu4t6MEoo8Pe6h0Gh4dWEvMlehlTrz1FJ40XQY2J2O
         KZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMhhX0YE9L3kMXhm4mjEMU4AEVhGwBUlhW3JBcBRJf+ouKHRAUEB6sKj0u1dAKaoGLRqb86fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2O9BVDJ9d6Dopnz3dCmtkf5WHCzzDGN3lrEw8UNfxRW821+O
	5GQo02Tg9xICpUaq/7lQnBGAb413iB3i2Ej1PlIrnTgci0dOjWBqMqxyPe0pr5CjurOBnej1pRp
	XjSRCrjkHHTwuWjNvN2N6W7ubfvSi0MLQKDYjtfJo/PQRqyhcLmkIuSeZpRPmbA==
X-Gm-Gg: ASbGnctUtQf0JJo6RvXiENvfnrUz2Krdd8aEh15rC86gbhRnBQDyPIP3w5in/+a+ara
	GI4DccJKzq+EMV465TcQu5QTcLTqBzKpL8lbC7oGf4YDG9/dm+XnfvLMaIDbKFAdBGGYACI9hiy
	sehjiET5B3f0Oj0+EyFp2y/mw4KWsSa9kAzwEnL/i9XGGzSDEEPRgNDhBgMqxcPOV8G6p8DyjnO
	BLO5Cva/E4zC7eQ2n7Oa+1ONe8fdkTu5Cidhw8UeO+MqHHQnz7YkJ46A4BJYUfQ7pYVT6PmY09d
	V+PsUnQl5yRxlOCWH6K8dQ==
X-Received: by 2002:a5d:5f47:0:b0:37d:4dcc:7fb4 with SMTP id ffacd0b85a97d-38260b4599fmr14673910f8f.10.1732640581402;
        Tue, 26 Nov 2024 09:03:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr8NYJcMREmunQfPgtRUJ+6vWmZoL9RuaYlOmIYZwV1pzISCOwDVS/dXl1poRYeBl/8PZYEw==
X-Received: by 2002:a5d:5f47:0:b0:37d:4dcc:7fb4 with SMTP id ffacd0b85a97d-38260b4599fmr14673660f8f.10.1732640579381;
        Tue, 26 Nov 2024 09:02:59 -0800 (PST)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde059a6sm174986745e9.4.2024.11.26.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:02:58 -0800 (PST)
Date: Tue, 26 Nov 2024 18:02:58 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski <kuba@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <Z0X_Qv24e-A4Nxao@lore-desk>
References: <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk>
 <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="79Xh1BHeJHl1mt/8"
Content-Disposition: inline
In-Reply-To: <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>


--79Xh1BHeJHl1mt/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Mon, 25 Nov 2024 16:56:49 -0600
>=20
> >=20
> >=20
> > On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
> >> From: Daniel Xu <dxu@dxuuu.xyz>
> >> Date: Fri, 22 Nov 2024 17:10:06 -0700
> >>
> >>> Hi Olek,
> >>>
> >>> Here are the results.
> >>>
> >>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
> >>>>
> >>>>
> >>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> >>
> >> [...]
> >>
> >>> Baseline (again)
> >>>
> >>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throu=
ghput (Mbit/s)
> >>> Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
> >>> Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
> >>> Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
> >>> Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
> >>> Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
> >>> Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.1=
26
> >>>
> >>> cpumap v2 Olek
> >>>
> >>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throu=
ghput (Mbit/s)
> >>> Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
> >>> Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
> >>> Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
> >>> Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
> >>> Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
> >>> Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.3=
16
> >>> Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.=
32%
> >>>
> >>>
> >>> It's very interesting that we see -40% tput w/ the patches. I went ba=
ck
> >>
> >> Oh no, I messed up something =3D\
> >>
> >> Could you please also test not the whole series, but patches 1-3 (up to
> >> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
> >> array...")? Would be great to see whether this implementation works
> >> worse right from the start or I just broke something later on.
> >=20
> > Patches 1-3 reproduces the -40% tput numbers.=20
>=20
> Ok, thanks! Seems like using the hybrid approach (GRO, but on top of
> cpumap's kthreads instead of NAPI) really performs worse than switching
> cpumap to NAPI.
>=20
> >=20
> > With patches 1-4 the numbers get slightly worse (~1gbps lower) but it w=
as noisy.
>=20
> Interesting, I was sure patch 4 optimizes stuff... Maybe I'll give up on =
it.
>=20
> >=20
> > tcp_rr results were unaffected.
>=20
> @ Jakub,
>=20
> Looks like I can't just use GRO without Lorenzo's conversion to NAPI, at
> least for now =3D\ I took a look on the backlog NAPI and it could be used,
> although we'd need a pointer in the backlog to the corresponding cpumap
> + also some synchronization point to make sure backlog NAPI won't access
> already destroyed cpumap.
>=20
> Maybe Lorenzo could take a look...

it seems to me the only difference would be we will use the shared backlog_=
napi
kthreads instead of having a dedicated kthread for each cpumap entry but we=
 still
need the napi poll logic. I can look into it if you prefer the shared kthre=
ad
approach.
@Jakub: what do you think?

Regards,
Lorenzo

>=20
> Thanks,
> Olek
>=20

--79Xh1BHeJHl1mt/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0X/QQAKCRA6cBh0uS2t
rOMVAP9sfomXx8kbm2KqBUkFS0IBD3Qk4xQs87FNINYbSG6VyQEAxUlOgtod8Cvs
Xx6AHmLLh8qJ5h/w2pd6dTEQxPAHrwo=
=+Ql1
-----END PGP SIGNATURE-----

--79Xh1BHeJHl1mt/8--


