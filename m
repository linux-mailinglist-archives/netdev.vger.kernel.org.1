Return-Path: <netdev+bounces-67273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B928428A6
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D89528936C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF286ADF;
	Tue, 30 Jan 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9mzrmld"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168186145
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630526; cv=none; b=SDEfWCbGTuMpBS7y1MoW3E0jJ9bLh+PFLHPz9+j/874sJ9yD098H1Fq5or96NobEpyLGYAvnVKoBPiTyWhN5TpbXxJ4l/9+UXUjRtz2T8rmPNl8yVbqPCPU2J5b9EdH27EqplrF/i81dXoHX/sCMQdBw+1mAAVLzU7tnKa3Es7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630526; c=relaxed/simple;
	bh=R/+PGrqlIQzRx/YC8Yw0Yia2E8Fz6ExLuynaZh2F/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GluG2M8ahlpusivn3oKNXXS/qHYM3+IbDpDgwOEohWMRdSeUSCnd/htHPehMVluv6iAEJ/y7iAavlydjfzchZbYaAc4XAZM3dSIxJrItTjCVRV7KKv3flg9vPSiJkeY1eW9uZw8kKx02fx0a55AwGNJJ3E9IcdjbYuZqElR+r3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9mzrmld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706630524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsPhw/UFv6rmTQuuvbVRDjJ+6ofGxDXqAnyB7KVB/58=;
	b=I9mzrmldu76rrcIi4DljyYt75+W0ko4JF4r+e+qOrxLFVk0Pedl+9Gibiy5dWcP+UoL4Jo
	o9R7ECUAwNRlJzAsLn+BEZ9grsIRVJpYsOM4yg1SqW78gkaIXZIkw82HTq8d2fcwiNe983
	hk9JHwlArN5ox/agxAbpasVjYrLtTUM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-rhSxSl4IPTCZdRHr-Te5Tw-1; Tue, 30 Jan 2024 11:01:54 -0500
X-MC-Unique: rhSxSl4IPTCZdRHr-Te5Tw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40eeb1739edso25249435e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630513; x=1707235313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsPhw/UFv6rmTQuuvbVRDjJ+6ofGxDXqAnyB7KVB/58=;
        b=I3ZTWIhTgHjhPbqEHIDMRe0e5MjyuPkSVt5WbJTodV68ZBrcIFtuOe20Qjps0cShfe
         pAEsaB3Vk4um0SMC81UpHXA2V/ziCHziKXk0DVpsUclSpP2yXplSto0XVWjyEtiD1CGq
         qDJeZxEaTpCWHdoyBfWfgynmP0VCGoKdGB3DIuYOV33vrBDpfIezlhWo0Z/O8QJG5Z6u
         YR8IDPqr/JEyOsOBp+vnSm6ap5PlnvJStYgktj55iCJbxYkYPgFiMDCP4eQzsRRvwDLl
         vFrx/dqx6O80QRelS3RYfTq/7LOjQOcbkI9n7Eb6lxBk0Dxn9Vo27gYj+BqMT/HajMOG
         B42Q==
X-Gm-Message-State: AOJu0YyvZ6ApwSIoEEB6WKCxuUXswbk5osQvdf27lTWZGdLr59ZqkKaE
	GqBMtINbD9ogALy+BIToerX7bnol+zC+HJbkYYtDLJzZUKvhtJZkod7w/1u2Ve/q5XmAJ9jtBnO
	uLYLprzbM8IEifBB615e2DuuorAcqMlE+gdmIQBFSie49nM9u16yuJQ==
X-Received: by 2002:a05:600c:1e0a:b0:40f:30b:ee96 with SMTP id ay10-20020a05600c1e0a00b0040f030bee96mr1465911wmb.37.1706630512861;
        Tue, 30 Jan 2024 08:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKCIESEWm8fMGWFUaJ+FFroIeLj4O+hrnJRknoMG+eYSSv9IFnneCyG5F85fWBjknHDEP85Q==
X-Received: by 2002:a05:600c:1e0a:b0:40f:30b:ee96 with SMTP id ay10-20020a05600c1e0a00b0040f030bee96mr1465887wmb.37.1706630512517;
        Tue, 30 Jan 2024 08:01:52 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600003c300b0033afe6968bfsm631053wrg.64.2024.01.30.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:01:51 -0800 (PST)
Date: Tue, 30 Jan 2024 17:01:50 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
Message-ID: <ZbkdblTwF19lBYbf@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
 <Zbj_Cb9oHRseTa3u@lore-desk>
 <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XGsBPEjow8ZYXOm2"
Content-Disposition: inline
In-Reply-To: <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>


--XGsBPEjow8ZYXOm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 30/01/2024 14.52, Lorenzo Bianconi wrote:
> > > On 2024/1/29 21:07, Lorenzo Bianconi wrote:
> > > > > On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> > > > > > Move page_pool stats allocation in page_pool_create routine and=
 get rid
> > > > > > of it for percpu page_pools.
> > > > >=20
> > > > > Is there any reason why we do not need those kind stats for per c=
pu
> > > > > page_pool?
> > > > >=20
> > > >=20
> > > > IIRC discussing with Jakub, we decided to not support them since th=
e pool is not
> > > > associated to any net_device in this case.
> > >=20
> > > It seems what jakub suggested is to 'extend netlink to dump unbound p=
age pools'?
> >=20
> > I do not have a strong opinion about it (since we do not have any use-c=
ase for
> > it at the moment).
> > In the case we want to support stats for per-cpu page_pools, I think we=
 should
> > not create a per-cpu recycle_stats pointer and add a page_pool_recycle_=
stats field
> > in page_pool struct since otherwise we will endup with ncpu^2 copies, r=
ight?
> > Do we want to support it now?
> >=20
> > @Jakub, Jesper: what do you guys think?
> >=20
>=20
>=20
> I do see an need for being able to access page_pool stats for all
> page_pool's in the system.
> And I do like Jakub's netlink based stats.

ack from my side if you have some use-cases in mind.
Some questions below:
- can we assume ethtool will be used to report stats just for 'global'
  page_pool (not per-cpu page_pool)?
- can we assume netlink/yaml will be used to report per-cpu page_pool stats?

I think in the current series we can fix the accounting part (in particular
avoiding memory wasting) and then we will figure out how to report percpu
page_pool stats through netlink/yaml. Agree?

Regards,
Lorenzo

>=20
> --Jesper
> (p.s. I'm debugging some production issues with page_pool and broadcom
> bnxt_en driver).
>=20

--XGsBPEjow8ZYXOm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbkdbgAKCRA6cBh0uS2t
rPJHAP9rXcNf2AVzWKoU8ZHGcju4f1EgGLYov0X+uPMRZ8n/vwEAor0WqOqXpmKB
KD0CZsS0eaVlAe5RMs1AIUlDXHLU3g8=
=UQ1L
-----END PGP SIGNATURE-----

--XGsBPEjow8ZYXOm2--


