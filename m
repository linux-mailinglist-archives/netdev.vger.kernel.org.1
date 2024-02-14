Return-Path: <netdev+bounces-71844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4085550D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BC8283CA2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689F13F00B;
	Wed, 14 Feb 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl2iPSE0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B9612EB
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946972; cv=none; b=JbLGy+1FUbluEG5atk/8tFGxVOorvN3Vux0uaOOGRm6jYBrZQwZ2kIdr4u7eMKTRTK/rofM4O6sGic7nkr/7ZqEhrvbQNZR/hoHUR34w5c2oTr2dQ3gcobAImtMeZYduaQS+vfz+hUx69ptaXv8vCr+DZnja0mMl4fCOuw8WAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946972; c=relaxed/simple;
	bh=3bLnzRI1WXj0gR19OdNvYztqc0SyhQFRgfz4jW+dN9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFrhLy7BBgH75/EabOEy/C327BlfW1BD9vwrvQ23m99B+qutRWvrJlPdLQFtXNSmt31mzFfRVfdN3u+po2r/cIdEjDxdAkGcpcLG60InnjsZIk6Bif52tLm39c9QmAvQ3x6U7UM8GDkMTWfzYrg5OX0GvrT7jeilUBBA7eJHYMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xl2iPSE0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707946969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUupHziP2oYSvBRcQqmZBph+bVM1imwHtMX59MFJtqM=;
	b=Xl2iPSE0MPBU2ulQd7Q+9tyytafVDKXdbvzXpM3w0byYJFv+Vp+hKSYIMNjw+Q+IthjZQi
	rnn0PXxKN2RCQZ2qfmcxemrgskPjeTJNit1IWmPI+xfHe5PX6g3MVh2JHuPgeSKyNg5iul
	fPKcJ+YXnyq1Y7azURNPCMkJBpHxFFs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-UAfkQ7TsPyyqfISWCfBKIg-1; Wed, 14 Feb 2024 16:42:48 -0500
X-MC-Unique: UAfkQ7TsPyyqfISWCfBKIg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2f71c83b7eso10508366b.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946967; x=1708551767;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUupHziP2oYSvBRcQqmZBph+bVM1imwHtMX59MFJtqM=;
        b=ZoUXYDYVXOZbch+maL1Y4Kf7fibXR6qAT89eim8Puw27WK5svoP1k3nU+EDKQgCfiq
         XlVXTDNZ3zsAmctU7b5iVmv/e5P7OTNLjs9vV3EkJ14yB1iJUxcpnXZN657v2tNfbKy6
         uTxTYDJD/20V7vIQB60NjRHtWthFZf3bBT2tNVGQJf1+Pv4O2Cs7u3BPpDODkvUIQ7fJ
         m5oX1MuJ/8c8ns9+VYPdGx+y0XTNs2lhEI8DJ0md4DFC9ykgMnx1mjnSL55Nk3MhAKxn
         T6zQbvcIy8Ahk/A+4PT3q3xWSZYSKgrmavOkNjI3Zp4YI3wX/XbMWadVTgnT3IWWsumw
         POYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhrqOU8br4BIK64z3AeTwI/q/B17I9Glh1clCHsjXNfd2GYtbUJTS5JX8/9QLc68uQHgQCtFShQ8jPraEV0BbouZk5JGvt
X-Gm-Message-State: AOJu0YzOEEWRWQgFmLY8ZEPGcxIFc5Kns0esKzPelVq7MnggZyZw3Ph1
	s255/gpRgnNUELSj6d9l7J+EkL6ocXlOlSgQ1WfjSdJ76ucNr54d+tccVqE239Y1KSPIc8k1dQ+
	3ees8v7/7IDlEipBawnqwhKQJXrTeAYp/dwDcS7z40pl+ZfpUiub3bg==
X-Received: by 2002:a17:906:29c2:b0:a3d:605b:16d3 with SMTP id y2-20020a17090629c200b00a3d605b16d3mr1626455eje.56.1707946967059;
        Wed, 14 Feb 2024 13:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOmYTzDMH0L+BD5/h8i6ydmXSQg4WP+Iier0HpwC4dFh2Yyou5SGs7h08J26Vh6s7pQS948A==
X-Received: by 2002:a17:906:29c2:b0:a3d:605b:16d3 with SMTP id y2-20020a17090629c200b00a3d605b16d3mr1626441eje.56.1707946966734;
        Wed, 14 Feb 2024 13:42:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4U8i1SRgSzDkC4V/b+25KUdY9Sq8Uth4z3cC3fwv08SQhc1vOroEX3nu7LuHtTOfa6cxz7XzPzksvt+cH93aX0AH5eQOm3WsOpD4/4+jb1S1QC8CtOBTm29Ru9C26VPZMlwp6HsRTgxl1ADK33YhgFoVoYTwzQCWIubcCGl/i5l+OmoixAflsZarZs1n7m6d6VwPlyRISFSbFZg+mF2YRgKAt2ySCY7jriS/SwfKvo4V35Bxplv3J+xx93uPHtMHQ8OOembDGbKDwC0wSdcjJMkXjRgo/Gom9MA==
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id mm15-20020a1709077a8f00b00a3d81b90ffcsm81127ejc.218.2024.02.14.13.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:42:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EF0D110F584D; Wed, 14 Feb 2024 22:42:45 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [RFC net-next] net: page_pool: fix recycle stats for percpu
 page_pool allocator
In-Reply-To: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
References: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Feb 2024 22:42:45 +0100
Message-ID: <871q9een8q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Use global page_pool_recycle_stats percpu counter for percpu page_pool
> allocator.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Neat trick with just referencing the pointer to the global object inside
the page_pool. With just a few nits below:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> ---
>  net/core/page_pool.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 6e0753e6a95b..1bb83b6e7a61 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -31,6 +31,8 @@
>  #define BIAS_MAX	(LONG_MAX >> 1)
>=20=20
>  #ifdef CONFIG_PAGE_POOL_STATS
> +static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_recycle_stats);

Should we call this pp_system_recycle_stats to be consistent with the
naming of the other global variable?

>  /* alloc_stat_inc is intended to be used in softirq context */
>  #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
>  /* recycle_stat_inc is safe to use when preemption is possible. */
> @@ -220,14 +222,19 @@ static int page_pool_init(struct page_pool *pool,
>  	pool->has_init_callback =3D !!pool->slow.init_callback;
>=20=20
>  #ifdef CONFIG_PAGE_POOL_STATS
> -	pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> -	if (!pool->recycle_stats)
> -		return -ENOMEM;
> +	if (cpuid < 0) {
> +		pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> +		if (!pool->recycle_stats)
> +			return -ENOMEM;
> +	} else {

Maybe add a short comment here to explain what's going on? Something
like:

/* When a cpuid is supplied, we're initialising the percpu system page pool
 * instance, so use a singular stats object instead of allocating a
 * separate percpu variable for each (also percpu) page pool instance.
 */

-Toke


