Return-Path: <netdev+bounces-67225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF2842677
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246D2B210DE
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFB6D1B3;
	Tue, 30 Jan 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcr8aeqX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F446D1B5
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622738; cv=none; b=qp1gfzAEuhoaE4zLhnbVs5sZEtKOX0ukh/tNZybqUThT6GJKu3DeponCuwHzOgDsG7RGwBPTFL18z409A9AR4auTuajrenf9Hq1C1MCyrrmX0o/6WPvLHX/sQq8ij5Ypve7i3myKiAEHuFeck/Gs09Rbvhhk8xAaibjs9hztMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622738; c=relaxed/simple;
	bh=tO3IZxsShfuPHoL/+i6gsppH2PKVgcSAHbpdC+yZsP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlV36EdUA6CSJ1Iqpv3DX6SltHPnDuarX5il7SlXhVd06WT13v4vIWuGJNxA1mRtx5X6AV/c59xFJlW3Z39I62RAWJLqrGyPFEycjJNZ42Y3IgArmpbZEatAQwwg+fgVLLzn5Ix9O1xpxoAPiTnx7InG4svnM/+scxVWI2H4Npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcr8aeqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706622735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tO3IZxsShfuPHoL/+i6gsppH2PKVgcSAHbpdC+yZsP8=;
	b=dcr8aeqXH+EE92y3F0cImTAdcdKCIRcvKAgQ6A0nfFRuR+O26IQpEDZW6YtN6EScFXk695
	29vOUYNNo6I5CNOu8vicBqFk6zt1qWtPY2hZ1OK0I84hr5YCYvHR+3UlOc9nV46d2Ucwfh
	QyAUH6iOGNOMRxIoSeXoVGSMDkVW6PI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-UvhXE5-VNgaWjoIJZpGMVw-1; Tue, 30 Jan 2024 08:52:13 -0500
X-MC-Unique: UvhXE5-VNgaWjoIJZpGMVw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ef75bea84so11689145e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 05:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622732; x=1707227532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO3IZxsShfuPHoL/+i6gsppH2PKVgcSAHbpdC+yZsP8=;
        b=q5LsWxj/GKHHFbpWX2Q53o4DaNfzYgasqlypf/s5KJqFur7Kx8SKR2t3Bu4I+tGF9m
         dY2BrQXq8yn7AQ3/lOI+s+d+1zTjIdgiqLHGr6n5gqp3e2soGxzVjmI8FeGghTQvTjxX
         RaeZtZUXcUlmfjw9bTdGUEQoXKOz0oYxTU51LyfURqkGCCMPeGMTJ6rllcpFg69XBlLP
         /v5G+oJHg0UT/FQlNgs6TwvvOmDtzX3Lvggr2Cb8Vkfj1rwOR70678WCl0dUH/qg8zA0
         9YsdNrManOMb7jqe2e+4dYYnmpYpoaE//c2bvWwrMHw0qvoyCkoKk2pXMsfkDSenCYKM
         hInQ==
X-Gm-Message-State: AOJu0YzvKFwB2VmqNDjHw33Nm5QDqmhCieoFCndhtG6dbawDCOJkW/zz
	jybflA5joIOZGHjiUucG/gLqOHu3Ut6jbVKKB1hpVG6EQ0Ie1hhz2BfguV966R3T15PLMPqNLut
	j5uPP06bxbM+4DJqPzIPudswHBYO1ToFJItrw8rWLDBQ5RUQNBtXX+Q==
X-Received: by 2002:a05:6000:10d:b0:33a:f77a:36a5 with SMTP id o13-20020a056000010d00b0033af77a36a5mr1662925wrx.9.1706622732288;
        Tue, 30 Jan 2024 05:52:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhfR2EaxJ2Dl23vZ6o9sxuk0eSIx8yX9QSEzNYOnL5u+peBEi/VZ9hMDvNIZEzcwctanP9OA==
X-Received: by 2002:a05:6000:10d:b0:33a:f77a:36a5 with SMTP id o13-20020a056000010d00b0033af77a36a5mr1662914wrx.9.1706622731928;
        Tue, 30 Jan 2024 05:52:11 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm6580820wry.79.2024.01.30.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 05:52:11 -0800 (PST)
Date: Tue, 30 Jan 2024 14:52:09 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
Message-ID: <Zbj_Cb9oHRseTa3u@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T3DgLZPov/35UEPU"
Content-Disposition: inline
In-Reply-To: <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>


--T3DgLZPov/35UEPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2024/1/29 21:07, Lorenzo Bianconi wrote:
> >> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> >>> Move page_pool stats allocation in page_pool_create routine and get r=
id
> >>> of it for percpu page_pools.
> >>
> >> Is there any reason why we do not need those kind stats for per cpu
> >> page_pool?
> >>
> >=20
> > IIRC discussing with Jakub, we decided to not support them since the po=
ol is not
> > associated to any net_device in this case.
>=20
> It seems what jakub suggested is to 'extend netlink to dump unbound page =
pools'?

I do not have a strong opinion about it (since we do not have any use-case =
for
it at the moment).
In the case we want to support stats for per-cpu page_pools, I think we sho=
uld
not create a per-cpu recycle_stats pointer and add a page_pool_recycle_stat=
s field
in page_pool struct since otherwise we will endup with ncpu^2 copies, right?
Do we want to support it now?

@Jakub, Jesper: what do you guys think?

Regards,
Lorenzo

>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20

--T3DgLZPov/35UEPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbj/CQAKCRA6cBh0uS2t
rB+LAQCh7IOX4mFd+LYQIs9UkgOASEmBg2jPX2KsFjT9ojP9rwD+PXPYJw+buABP
oRTnk4AJtOPrll6FFdld6TuTL1a8nAI=
=isOu
-----END PGP SIGNATURE-----

--T3DgLZPov/35UEPU--


