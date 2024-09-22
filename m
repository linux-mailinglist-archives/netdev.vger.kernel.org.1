Return-Path: <netdev+bounces-129164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C17797E0B0
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4D7281419
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96651C3E;
	Sun, 22 Sep 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/obVzJR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CE273FC
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726996687; cv=none; b=C8PCzMfMocjZQ3dnVIvsEgOZlW8EG7RlT4VyRwH6R4Kz3DeYoxexSp5FcxvVvu7JlxDqDZ7xqu3sAo1iAU7Ut/HZWJQ8dom4zrWUKlclQ6E6fOs9Ax+Y+cS3HZIvr1GGCCMA+oRShHNB+KoPK2p2EYLWtotKa6haGRxXua7RJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726996687; c=relaxed/simple;
	bh=CkVf/BUTbleDBi4ErBkX5kkH/UNmslDmWgD0qCX81Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=earWC6C4u5Y90OP/fpPXGZiNKuT7dahemTj0j2eS7zk7jEqSbvlWKgdGoXVUoU8fIcnRnQNEYjGitXMlVd19YvB4jgksX/wPw0Gm7RYMeYde+mcoYHjh5RWnAgU+V4u6u332N405WpfJG0anJBjo44etUUFuponQNeeGV6uQpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/obVzJR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726996685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXAx1lyb+OHUcXTVhf/rtzN8Qm/38mHOyytwY0XpYps=;
	b=K/obVzJRIAbhZXgB4fAcEqAfBE63m2QHcB2ie4A29ZAsDijCTA8qC/iErFIdiNMA013caR
	7TvwqM7+z6VYA8ktiLYhHQ+TGGTpSz9w/Wjdd1gWc3qg9DWiPua0am3wDNHG3O5v+1Avar
	nc4Ity9MmeooWab0tnuOuTCZaENOKBc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-BsmGCPnzO_eHEaj8hBT_5A-1; Sun, 22 Sep 2024 05:18:04 -0400
X-MC-Unique: BsmGCPnzO_eHEaj8hBT_5A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a87c7c719so142757466b.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 02:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726996682; x=1727601482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXAx1lyb+OHUcXTVhf/rtzN8Qm/38mHOyytwY0XpYps=;
        b=WUToNICbizbEO1Tiz/UgdKhg0KyxKFnKn4fU+5jb0GvjrRPuUX5W9g9Q0mDo8vE9ZI
         HYfuBTwT91skDN41EYaXTmdcWG5tq5+CR0kGhs+D3r6Jm8yrprlkLT7nqLhJPYBjU+16
         30Z2GBor4SOyPRDhtaDM6Evw6hPvB15a25P4XpjvZPlQ7razZdQ5b1pE3ukNhD9wYN2y
         q4h4Mz/snr4oVQMn9UY6NDYFRfgJdFq4gSHJpYYRCFvPgSJErMEunnOYly1kk7d8EzZn
         cwG0PjSbf7sWBH2BA39iNvsmCM943MAQifH/Jv3hVy9Dab5nc0xyUw167JX1QG1Ayj35
         BXOw==
X-Forwarded-Encrypted: i=1; AJvYcCWou/oqK0UTfvKyMjIDu+rG6JgFscXZB5AkSKmCcpYE6XHfpC6YF4z5/CZgNh+BYFC8rRet6ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3SPmiST3GjoxEKxWApHEtP8Gk6bDnc+lmZ6+WVM2U6FQcQbn
	fYi/EjR+i7mqkgGu9aD4fHKMzNDF+0J6dcasS5TEXc+FpGb6nqlUlau+AshuNWvRDi8s8F/62gf
	8VsWq6DXhdBtUwemsF66Xr3jwy7ju89PiyL3alsUeWjcRuMcs6XIbM3zDPFXELjfc
X-Received: by 2002:a05:6402:4313:b0:5c3:cb45:2e with SMTP id 4fb4d7f45d1cf-5c46484f321mr9608192a12.5.1726996682355;
        Sun, 22 Sep 2024 02:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf9TMYT2IhPElc8dV5tR8Nn2xYHdfg3DTnHOp+UvWeEV68rpjCdJBZeyRvvMen4+MhNa6mbg==
X-Received: by 2002:a50:8dc5:0:b0:5c4:64e6:55a4 with SMTP id 4fb4d7f45d1cf-5c464e659b7mr8744624a12.12.1726996671718;
        Sun, 22 Sep 2024 02:17:51 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061328bb0sm1060048066b.193.2024.09.22.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 02:17:51 -0700 (PDT)
Date: Sun, 22 Sep 2024 11:17:50 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
	toke@toke.dk, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, mst@redhat.com,
	jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <Zu_gvkXe4RYjJXtq@lore-desk>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inD87LbY/R9ETazn"
Content-Disposition: inline
In-Reply-To: <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>


--inD87LbY/R9ETazn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 21/09/2024 22.17, Alexander Lobakin wrote:
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Sat, 21 Sep 2024 18:52:56 +0200
> >=20
> > > This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_fra=
me
> >=20
> > &xdp_buff is on the stack.
> > &xdp_frame consumes headroom.
> >=20
> > IOW they're size-sensitive and putting metadata directly there might
> > play bad; if not now, then later.
> >=20
> > Our idea (me + Toke) was as follows:
> >=20
> > - new BPF kfunc to build generic meta. If called, the driver builds a
> >    generic meta with hash, csum etc., in the data_meta area.
>=20
> I do agree that it should be the XDP prog (via a new BPF kfunc) that
> decide if xdp_frame should be updated to contain a generic meta struct.
> *BUT* I think we should use the xdp_frame area, and not the
> xdp->data_meta area.

ack, I will add a new kfunc for it.

>=20
> A details is that I think this kfunc should write data directly into
> xdp_frame area, even then we are only operating on the xdp_buff, as we
> do have access to the area xdp_frame will be created in.

this would avoid to copy it when we convert from xdp_buff to xdp_frame, nic=
e :)

>=20
>=20
> When using data_meta area, then netstack encap/decap needs to move the
> data_meta area (extra cycles).  The xdp_frame area (live in top) don't
> have this issue.
>=20
> It is easier to allow xdp_frame area to survive longer together with the
> SKB. Today we "release" this xdp_frame area to be used by SKB for extra
> headroom (see xdp_scrub_frame).  I can imagine that we can move SKB
> fields to this area, and reduce the size of the SKB alloc. (This then
> becomes the mini-SKB we discussed a couple of years ago).
>=20
>=20
> >    Yes, this also consumes headroom, but only when the corresponding fu=
nc
> >    is called. Introducing new fields like you're doing will consume it
> >    unconditionally;
>=20
> We agree on the kfunc call marks area as consumed/in-use.  We can extend
> xdp_frame statically like Lorenzo does (with struct xdp_rx_meta), but
> xdp_frame->flags can be used for marking this area as used or not.

the only downside with respect to a TLV approach would be to consume all the
xdp_rx_meta as soon as we set a single xdp rx hw hint in it, right?
The upside is it is easier and it requires less instructions.

>=20
>=20
> > - when &xdp_frame gets converted to sk_buff, the function checks whether
> >    data_meta contains a generic structure filled with hints.
> >=20
>=20
> Agree, but take data from xdp_frame->xdp_rx_meta.
>=20
> When XDP returns XDP_PASS, then I also want to see this data applied to
> the SKB. In patchset[1] Yan called this xdp_frame_fixup_skb_offloading()
> and xdp_buff_fixup_skb_offloading(). (Perhaps "fixup" isn't the right
> term, "apply" is perhaps better).  Having this generic-name allow us to
> extend with newer offloads, and eventually move members out of SKB.
>=20
> We called it "fixup", because our use-case is that our XDP load-balancer
> (Unimog) XDP_TX bounce packets with in GRE header encap, and on the
> receiving NIC (due to encap) we lost the HW hash/csum, which we want to
> transfer from the original NIC, decap in XDP and apply the original HW
> hash/csum via this "fixup" call.

I already set skb metadata converting xdp_frame into a skb in
__xdp_build_skb_from_frame() but I can collect all this logic in a single
routine.

Regards,
Lorenzo

>=20
> --Jesper
>=20
> [1] https://lore.kernel.org/all/cover.1718919473.git.yan@cloudflare.com/
>=20
> > We also thought about &skb_shared_info, but it's also size-sensitive as
> > it consumes tailroom.
> >=20
> > > one as a container to store the already supported xdp rx hw hints (rx=
_hash
> > > and rx_vlan, rx_timestamp will be stored in skb_shared_info area) whe=
n the
> > > eBPF program running on the nic performs XDP_REDIRECT. Doing so, we a=
re able
> > > to set the skb metadata converting the xdp_buff/xdp_frame to a skb.
> >=20
> > Thanks,
> > Olek
>=20

--inD87LbY/R9ETazn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZu/gvgAKCRA6cBh0uS2t
rBMGAQCny4oFrmk5dJWIQ0C1+/9UKb9+b/klnvNkYgQWGI7uwgD/Qn+xWmGdaRXY
s4/PVtYfv9dsYkKnnnco+8sDesjq9Ao=
=rOzF
-----END PGP SIGNATURE-----

--inD87LbY/R9ETazn--


