Return-Path: <netdev+bounces-204940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C9AFC9BD
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B753B516E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3292D9EC7;
	Tue,  8 Jul 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDx+SIKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE012882A5
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974796; cv=none; b=cugxGeB0KWZaSC5WEja3x69gPBmCDDAAcWHmx8AXh2CWXoxZMI/4q3p3vcQ+HDb2tHxWK2CLGWiU52M3VcJ2EfWMi63idJg+5HfQI6gWsQIw6io9v24eFFlf6qK6tkI4a5hYymAMVJZVHgyU7TCE+iMckZqq78xjVDB0JGqmDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974796; c=relaxed/simple;
	bh=anrcJkhR0K2UFvABRyTbtjlESGIkubeRDAlquXXlVdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMSByhknh/XrMpWmcJSiXJ5muaFxttWClEQxHXUC1geF/7+tkOhlN/YZll2cY85aq2Q+gQ4Z2JWFwRfMutNldzm4oHj7ujThokOTbojHBF59wGqK5IzqmLu2wn+lFOo3Q0HGREzm9ZarbwGWSUy/Dk/Ry9Lnclz5M0o/+0NJqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZDx+SIKk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71173646662so37748357b3.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751974794; x=1752579594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eMeJVMzIthoABLN3c573S0lEtUCztks52HyLR1vSyo=;
        b=ZDx+SIKkNG+3IxHbX9Z4lAUTh7p9viNk7eNU3/Kml3gcW96LNnq1PtuaQSSdVlrMnh
         rwqoZdz619BG5QkmqO7MKAcGF1SOQJZZOFXGIW97fJSiQnVnYxABSaB55AfJIQR3p2MG
         Y88hq7G2ScqBNkKl1OyKveUza/nHKT5RRa5rlfI7U3a3FiWnRpzoiDgAnx5u3p2eD6Xf
         JyRtPiDvtb9hvNu9MRyqCDJy0vs6wG9GSyBzkPFwLmoesQwKHIkg4WmreuIPzwBMU9tA
         HO355AqtxUCUrhRfW4nuSldPcopH7dD4KzuyVew55aJu0v6hNdNIrrV60vYLVidMJFex
         I0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974794; x=1752579594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eMeJVMzIthoABLN3c573S0lEtUCztks52HyLR1vSyo=;
        b=K7tJRTI/ywuXr5CB2srtqP4NKQS11vtAQ8UcxGLa04WEBaTRSLJohJaeF9u/4OQNJn
         zjLPxQkcLnJwtTNhgvi9I8jGMceb6zZrMmF+HaUkJvtWE0sGD48BUogPhtyJL2SNySq7
         Gj/bZA3eq5sCzIAaCMW716FdWk4q8wP1iNY63Lj+Z4LuqPawelD3pfUn7gDrFQ4MRP8O
         WzrQa+x/b2D6p6ek6UXT79uKpgydTO9VuzeyfEAsbTwiFLPsNSDtQ3g2L05fB4hrMswj
         c70Pbmkp84Z7ejGcWvcNQIWd/eeWWr0A/8qoOtZK/cv+9XkhI2V5AfeZlQeImSjrStRB
         lkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGe0bkYrc/gakCz3tcIrYiN/tdHRqR7QJgJx8Jarl/A4e8sZg/NWj/T/YHUHOFYpDPDijVawc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKN6R/yvJI2kresZW31fJHX60hTkqeTOgvqOwV4DOggxbUJ7Cy
	DLWU/mwtnmhimacIlidOPTFUp+zQFcHQA3PGivcNAh42fwN2knCghTbmzHdCOgVYSLpAOaq2ZGF
	gOBG5JBR2UCi2vonDJblG1BnBJ+gZsuS0mgBmDXp5UQ==
X-Gm-Gg: ASbGncvt4xO+PvDYu+AKeQ+53tOinihR74lyAupZFP46YXStq3a+j6+M6rjs9dusYo+
	CAhw9ma23XsOyqbKFkZPEAlfGD5IcSFQiQz+eIdD+wr3VsTYbm1UzMn144eimFeEVhBrfmanbGo
	BejYqZkCaHUL/rBh1rXaV05vt2GnI9zibz/OcYog1gtBE=
X-Google-Smtp-Source: AGHT+IG6kwwi/O1JpxJQzqce7OC4YlDVtNrzWESKs36ZU9aEADMh6ZKR839SIoeejlL3CWzFXOhNldDkEPqgFZcBnJY=
X-Received: by 2002:a05:690c:dc7:b0:70e:6105:2360 with SMTP id
 00721157ae682-71668deda5amr227576207b3.24.1751974793396; Tue, 08 Jul 2025
 04:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702053256.4594-1-byungchul@sk.com> <20250702053256.4594-4-byungchul@sk.com>
In-Reply-To: <20250702053256.4594-4-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 14:39:16 +0300
X-Gm-Features: Ac12FXwbisTy0vRZbr1dnSDkZ4VZxeOs9_WADPGLv9-1kgfrQv9Qj4QdZfgR36o
Message-ID: <CAC_iWj+mOqEfyanEk52Y7Pw4zMs_tZbES=5xBV7AfAG-nTUPpw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/5] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 at 08:33, Byungchul Park <byungchul@sk.com> wrote:
>
> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  net/core/page_pool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 95ffa48c7c67..05e2e22a8f7c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -544,8 +544,8 @@ static struct page *__page_pool_alloc_page_order(stru=
ct page_pool *pool,
>  }
>
>  /* slow path */
> -static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool=
 *pool,
> -                                                       gfp_t gfp)
> +static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_po=
ol *pool,
> +                                                         gfp_t gfp)
>  {
>         const int bulk =3D PP_ALLOC_CACHE_REFILL;
>         unsigned int pp_order =3D pool->p.order;
> @@ -615,7 +615,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *=
pool, gfp_t gfp)
>         if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
>                 netmem =3D pool->mp_ops->alloc_netmems(pool, gfp);
>         else
> -               netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
> +               netmem =3D __page_pool_alloc_netmems_slow(pool, gfp);
>         return netmem;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_netmems);
> --
> 2.17.1
>

