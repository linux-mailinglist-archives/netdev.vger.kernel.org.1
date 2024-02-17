Return-Path: <netdev+bounces-72633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C563E858EE6
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8060E28380C
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D585EE78;
	Sat, 17 Feb 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuBvKlYN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FB59B56
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167669; cv=none; b=fHEC5/M/kFz/7s3ePSbgyoHszDwPFFwWfzDsS8SNF4oKvSedNJcDopSAnWG8V7kd/v5VCtXmPrepHaJDT5pUyKwDbmwVt+d6tRe6rj86saoNPDDuTNNUKA7ptblk79iYd4xaoxLyfFe5tycoxl9jFt6bd5OYLGM6tLy+euAXN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167669; c=relaxed/simple;
	bh=qCGyT5pBaJ/Ii6b5/xkXRzw+2/Pk/0m1t9UD7go6p8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwU1kc8zCnd3332ThzcKne700hG/Y40WRtYY4eThxTajbARGx+UgJRT4T8bTn+PIVJibDLBYk3AJqm7CJdyNa9vLfNS0+Vh8qm4DNv6lmCbagfecBPhjQSWplW860vnyeaJ4wq6tbnn8iANKRvy1jFA2PsXPTXORvda8n5PxTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuBvKlYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708167666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvOppNrs8Z1UVIDcN2OcqyPB9TDUxI7ldtZ0Ik7H2kk=;
	b=TuBvKlYNUCKHy/EEIuj3GApN7V7v8XAsXW1s1andZM4iXLHRGBT8Cl0WkJTPNh2wUUsVdQ
	iTkt6HXPU0LQRm/rN0G3G18uQ0ax/8SXjHM/J3YtsGKJo+0cN59nVOGV/pCUmoEKZRo7Et
	L1AyVHLkARF2DbXfaMQ+OTY9s0pLn74=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-9LfH3cJwNCef4miQJaoo4g-1; Sat, 17 Feb 2024 06:01:02 -0500
X-MC-Unique: 9LfH3cJwNCef4miQJaoo4g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d2b47bb52so188825f8f.0
        for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 03:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708167661; x=1708772461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvOppNrs8Z1UVIDcN2OcqyPB9TDUxI7ldtZ0Ik7H2kk=;
        b=dSjHcqxZacaVtDedwVPtB7+F91WuMJIv/Ka4oGiL1wDCYq/i2Ax8TaYTa9bWcIbCli
         VtL6oNKaX9ljPMuzA3Fic6382KzD19taDktr3uuXv9Z7OikseglpO2bNA54W3mUlYKi9
         JM3ooE9+oqoRAQ75IH4/u2GnNNwLv03Mpj8cFhcOyEdvxKOZS9Zd7hnxlfvvtnLn8gn1
         kUMA2qirhWa3GknUbVS5rbu+DnfF7zXRigUGoDuELWsiez2BAuAqaabC3OQ8C5+D3OFb
         4oN2TsdC0oNWiSRNX0QxqrRGRO7B/lck/FAIh2uOh9CeX+bG5KL9sQhhVFbJ0R3G1vs9
         murg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOz/r1ZnV8MPemr3EnVc+AY6CH6F7Y5X/3Nsr9L4QBOoi/xEF/Z+t8qLHOy8CqMEfzk49DCLrATKAczeFvZTAxuKBHi9A
X-Gm-Message-State: AOJu0YzizyJAWk/L7QhB3/5A6VOBLeO/DHK/PQlu0WYe7gIjHDHbeIDe
	+f24xCpu6H3q2HhKB6XF/Kodv73fzxrsVLbHxeogUd0lJ4bt1sFxU5rTpMyoEZV9/6ZJV1dWvEk
	AGystLoUB1LjYhjj/+pOgb+UFZp9H7qqLPWhmYx3rBatXTHXjnlpo/w==
X-Received: by 2002:adf:f706:0:b0:33d:1064:9b98 with SMTP id r6-20020adff706000000b0033d10649b98mr4403977wrp.33.1708167660953;
        Sat, 17 Feb 2024 03:01:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1J7/fQ0d7swSWHKyvf5mXjYzLm9P/HXfamSGo+Laoa6Rv33rnicYldk3EciZsn2rfrFq5AA==
X-Received: by 2002:adf:f706:0:b0:33d:1064:9b98 with SMTP id r6-20020adff706000000b0033d10649b98mr4403967wrp.33.1708167660620;
        Sat, 17 Feb 2024 03:01:00 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id bw22-20020a0560001f9600b0033afe816977sm4798630wrb.66.2024.02.17.03.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 03:01:00 -0800 (PST)
Date: Sat, 17 Feb 2024 12:00:58 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
	toke@redhat.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next] net: page_pool: fix recycle stats for system
 page_pool allocator
Message-ID: <ZdCR6i85oEvoxMzF@lore-desk>
References: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
 <2f315c01-37ba-77e2-1d0f-568f453b3166@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HsB9iVI/TCPn1UJY"
Content-Disposition: inline
In-Reply-To: <2f315c01-37ba-77e2-1d0f-568f453b3166@huawei.com>


--HsB9iVI/TCPn1UJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2024/2/16 17:25, Lorenzo Bianconi wrote:
> > Use global percpu page_pool_recycle_stats counter for system page_pool
> > allocator instead of allocating a separate percpu variable for each
> > (also percpu) page pool instance.
>=20
> I may missed some obvious discussion in previous version due to spring
> holiday.
>=20
> >=20
[...]
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > -	pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> > -	if (!pool->recycle_stats)
> > -		return -ENOMEM;
> > +	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL)) {
> > +		pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> > +		if (!pool->recycle_stats)
> > +			return -ENOMEM;
> > +	} else {
> > +		/* For system page pool instance we use a singular stats object
> > +		 * instead of allocating a separate percpu variable for each
> > +		 * (also percpu) page pool instance.
> > +		 */
> > +		pool->recycle_stats =3D &pp_system_recycle_stats;
>=20
> Do we need to return -EINVAL here if page_pool_init() is called with
> pool->p.flags & PP_FLAG_SYSTEM_POOL being true and cpuid being a valid
> cpu?
> If yes, it seems we may be able to use the cpuid to decide if we need
> to allocate a new pool->recycle_stats without adding a new flag.

for the current use-cases cpuid is set to a valid core id just for system
page_pool but in the future probably there will not be a 1:1 relation (e.g.
we would want to pin a per-cpu page_pool instance to a particular CPU?)

>=20
> If no, the API for page_pool_create_percpu() seems a litte weird as it
> relies on the user calling it correctly.
>=20
> Also, do we need to enforce that page_pool_create_percpu() is only called
> once for the same cpu? if no, we may have two page_pool instance sharing
> the same stats.

do you mean for the same pp instance? I guess it is not allowed by the APIs.

Regards,
Lorenzo

>=20
> > +	}
> >  #endif
> > =20
> >  	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > -		free_percpu(pool->recycle_stats);
> > +		if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
> > +			free_percpu(pool->recycle_stats);
> >  #endif
> >  		return -ENOMEM;
> >  	}
> > @@ -251,7 +262,8 @@ static void page_pool_uninit(struct page_pool *pool)
> >  		put_device(pool->p.dev);
> > =20
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > -	free_percpu(pool->recycle_stats);
> > +	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
> > +		free_percpu(pool->recycle_stats);
> >  #endif
> >  }
> > =20
> >=20
>=20

--HsB9iVI/TCPn1UJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZdCR6gAKCRA6cBh0uS2t
rHWeAQCctwRXW5HZ1WURj+YuI93nW6rpqGSov5IlY1pt78wMBQD/U9n05tH9e0aW
4w3jPqySy8O//uH+lbtqVXggR7nJxQI=
=BhnU
-----END PGP SIGNATURE-----

--HsB9iVI/TCPn1UJY--


