Return-Path: <netdev+bounces-180184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62203A80038
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B619189B154
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AAC26869D;
	Tue,  8 Apr 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhVDrRXy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B670268C66
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111402; cv=none; b=Nt//nH7USAV4jUemXVfyRpwJTZXPTQMyadlTTXuEZ1y9PGs9JtePKUw4/7wAJkvjaIlOXvv7fs/2kMaGEfcAfj5fifUiObRVQM4LxLELEbCr8bwC8GxVmRTKxInoB29gqVlqvy6CYHkFOB4eqgjY06RAy8en7N2+YAQ+TbxNg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111402; c=relaxed/simple;
	bh=7A2lFzcQs0+kGJmrB/0J9hzShIqQ79RoYmh3PkC/16A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iFevxj0mjsT8Rt2ZR9IAN6NRj+wghqJ5WCacCH73rvTX/Q9oyw9Bf6nQdRA75SI5vPII7tI/8dVJbwftx7FzR8kvZCoJqNpS3vZJkB1iWCaAHzqopulrGZ0rLpEcjffMZo2jGFb1nN1obKzBn9TgQlC7+i20B6qa1IBS+nqEGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhVDrRXy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744111399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUXxs671hXHelnn2s2t/j+j0/bqL54JMdDbZl2m1VKM=;
	b=KhVDrRXytyWSNm1ZnbnIwpdVP7xuJmaY+AilDKduSt6u5BzweHQWdyDEFF9C7Khrd4I9Rq
	08xpH47YhdtZ7B2zVCYqd8SXrQ3RGMcp42DaCqAtHpZWvyh+IGB47GOv7xy3biOdM/pNwd
	t2AGX9gEs+CwzOa1IVjb4PyhN+EGBus=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-6R-ebFdqPJ2lVgqkmn3s5g-1; Tue, 08 Apr 2025 07:23:18 -0400
X-MC-Unique: 6R-ebFdqPJ2lVgqkmn3s5g-1
X-Mimecast-MFC-AGG-ID: 6R-ebFdqPJ2lVgqkmn3s5g_1744111397
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bff0c526cso28509401fa.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 04:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744111396; x=1744716196;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUXxs671hXHelnn2s2t/j+j0/bqL54JMdDbZl2m1VKM=;
        b=FLYfJ0nEy/zoRkVNSorVNeqPJtiIiiEI3g8TCeh/o+P6U/t49Y31AO8Wq8UsCAouAx
         i/3+UdP2Sr/7iNtUrSwafaPDXHN2oNq8mBpQRTYwdhs6WGsZG5bgbbZPNVwl9vMjMIrQ
         vfPIwzlu3Eullx3ALn8s6EG7dc/XRPWm6vKmuFuDacuvwnKcJyhcmtxgaYoM87OPfrz4
         t09aqbdxxb+qa350JcF/7PKAXgKe2sId+R7qiHM4k1uWRonVEvZUk+VXag4wtlWOTscJ
         zKUv3kaDIBFeFrO9CduOJlC8XILIIkBPuo7nXxJIQlseuYl78RStrk5Yg4+QfhGnTjgj
         57LA==
X-Forwarded-Encrypted: i=1; AJvYcCVp4TukNihP6ukIjdmXxj8Ndq9kip05/iNcLNZbwwn7ijQnjkKu2DflKXT+wRene6Gk3XXoyAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqK3g7nBQUCDDntzNPs6pdXnCiT4avC7BYglKLpmGylF/w5a9/
	LI/eTmvCnGH9KHpUJ6dsHsGBzMkZhusjPt1AOzkq7mEroqRgtcJaegEwD5VLTVBYokMvwY+yaCm
	sinIIKh02s9pYgUGkr8t0/BR9BQkrGqp1Ms2LjCA/rwliSKAkYab1rA==
X-Gm-Gg: ASbGncuwL1vx8at04smlXyBz2C+K+0gvZdvWjD5H/rgCs7LSRXMu0b8uC1RzBqM+Dy8
	3kBZBilIYPTNm8QUuaukCHL7dG6IfJKg2ZtbSwexvsmktzhPSzRCDMhTKeZTMq2jO0POAUbjE8T
	IbYXOF+yZ4NYlypPxxfPWzqktwMScOk7Hgo8D8T5+IeX4DZs18I+7EYML5PCV/bYN1QSF88IY7w
	6/SvBdDi4XWbATo+3WRw0YySlEumgWsODa25F5anflWXezNMy/4WyNy+IwIftslRe/YE8kToRzI
	FFtbpiPus38D8lSnK4gHZoirlqz9jgixKWFxOsiN
X-Received: by 2002:a05:651c:2210:b0:30b:b8e6:86d7 with SMTP id 38308e7fff4ca-30f0bf4e0f8mr43961421fa.22.1744111396589;
        Tue, 08 Apr 2025 04:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHugZrZBe1olwpKjHjP12g8dE7uL7NLACvHaa6+imASaWUZ8UVY2RIoJIIgvMdOJVMZDs2+lg==
X-Received: by 2002:a05:651c:2210:b0:30b:b8e6:86d7 with SMTP id 38308e7fff4ca-30f0bf4e0f8mr43961321fa.22.1744111396226;
        Tue, 08 Apr 2025 04:23:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f03141cddsm18444941fa.41.2025.04.08.04.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:23:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A7841991DF5; Tue, 08 Apr 2025 13:23:14 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <c908ce17-b2e9-472e-935c-f5133ddb9007@kernel.org>
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
 <87a58sxrhn.fsf@toke.dk> <c908ce17-b2e9-472e-935c-f5133ddb9007@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Apr 2025 13:23:14 +0200
Message-ID: <87h62yx5gd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@kernel.org> writes:

> On 4/7/25 3:15 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
>>> +{
>>> +	struct Qdisc *q;
>>> +
>>> +	q =3D rcu_dereference(txq->qdisc);
>>> +	if (q->enqueue)
>>> +		return true;
>>> +	else
>>> +		return false;
>>> +}
>>=20
>> This seems like a pretty ugly layering violation, inspecting the qdisc
>> like this in the driver?
>
> vrf driver has something very similar - been there since March 2017.

Doesn't make it any less ugly, though ;)

And AFAICT, vrf is doing more with the information; basically picking a
whole different TX path? Can you elaborate on the reasoning for this (do
people actually install qdiscs on VRF devices in practice)?

-Toke


