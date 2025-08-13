Return-Path: <netdev+bounces-213125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE150B23CF4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC61885A38
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0B211F;
	Wed, 13 Aug 2025 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiQ1DIzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278BA48
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043519; cv=none; b=nXFLTpf6+PW3m24YatKzzLc/dDzrWKkLwZlgj54AymrMcoL6XE14rODYyldnqKlo6OAH7JbJI3NMVfIdHOPJ0o/m898cYXta+GhkP/gSD0r8sV5ndljhOnwUOFM1GiLhzCLuudj3Lzam+SGQ6U0SvRQt2O5bpVD1XYKsNdlI8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043519; c=relaxed/simple;
	bh=+A7f7rUnPXIhPcV7hGSFPXu6dlQGQ1MgXNQyjhGbioc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ilx2A02hCOMwX+w2y8s/o/nEwJvYXoa55J57LrtV3BJefXuBJf5hBHoJ5Syz8fXmBDgcqOqYa0LWw+Mr0d7ljV7CoHwL+qbM0wWpLM5xU+XI2hqydH40kykIWMFoCWKu1NEHncqJlMO+cVHwZoR678v0ZKMXPR8mbjPqICsU4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiQ1DIzK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so4434e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755043516; x=1755648316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/KVJDn84evdNYx1TNGKVqyrILDJc+rFre0EQo5xwPM=;
        b=BiQ1DIzKbZOXvU9UBUG5A80i82+pLzfVpBZhTjhk5zDCZ/O9+zyIhx2FyTlr3cU99e
         IoZf7w2qpVVbpldxXqXMwKk0nSPTDhZRQI2R+qmUK/jAW1fDje3inhNtXG3ypA/v2TGz
         ijEBUxm/lTrfxkGNyylIVCxUlCztqDlK5G8jRs+xszQtjIsun1RJfYEA4MZduWmZ4OW0
         RmX8ENPFkAM53Gyo/1Uc6pFfXo8c5mG5YDwRwYbdVHWjhAZsMcvbidNz9U2jERcgPEX1
         832i8tPAys6lKJEAdC02yrTB2WVrd9hdU/wenzXRjnKfQ1fkSyKd02kvBrh3s9wtZ9B9
         Pyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755043516; x=1755648316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/KVJDn84evdNYx1TNGKVqyrILDJc+rFre0EQo5xwPM=;
        b=fYo452JC41uK14/1+FZE7XP/9JuS1Ymf4belZBHYnTZB3SySCBilu03TMD3Eo18d7e
         q01mrnD4tfsQC9zs40eH6gJxqkZBrF9B+la6SOrUtvxK5PdKfbND9c6ctudd7pjiBvRN
         9BkiyZlm4al/MlkugnQyJQIrY8rCz00Y8aMxHqNQjOydBIJBR9YbAWf8DyyYZPjYKAxL
         Qh9QodTxqy4SbAAjEwphAp8GsVTwawGMb/NzS74mmG6aREvCSeGzWA4UBUKqrQm46sGK
         TLArt/F9KG/t2DyavvilgN0B/4wyxM6ZFFcRpJMCK/4FYNIKROp5fFyPK4SbEVLoipY1
         DJ/g==
X-Gm-Message-State: AOJu0Yxz8U3I86w8WCl4htZEsXhhO5PdUh+4hQ5kjp25xOHpG9KPXwKa
	w9H7nXBoTQAxByVrKpdv8+B20KLdtZ9EHId8GtPI0fZqbkuvvNTyrgP/Z7pimLomlsGGbhoU3KL
	1HB/oc30hIuIQOdNCjJRbdjQjEQ8DsxHtYcbZdyQXUMUEpkQXYlI60Psy5CU=
X-Gm-Gg: ASbGncubpEsQXsFpPUk37fVgFIVcr01cO23iiW4recvPnarF6hYEZu22/2XNm+CFQ8t
	a2VaUrqqTa0CnZmyWymdAeqX+WrMXhR9CK4fltz14mlza8uXmuI4Swofk5M4HqWVXjM/LabFGYo
	aubYpMMp6eIyCLwD8yZX1jPVTOit/VoZ2Fp/KWq3giJ9HXgBVYAhBnlIkvLz+K9Z7XZS4F8XseE
	clTAUsu12MNGILIm6drQpqiij6PxVL07z6hBnNiyFuc5us=
X-Google-Smtp-Source: AGHT+IHJFU7Fotlj8Wmy8cUCHFXQmmWa3xIFZoYOfk0b+mrYn1MMStVmgwzf9TFryoZcTItHnM/bYKDCae8zh9JwVys=
X-Received: by 2002:a05:6512:31c5:b0:555:4de:c172 with SMTP id
 2adb3069b0e04-55ce1240c1cmr77110e87.3.1755043515980; Tue, 12 Aug 2025
 17:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754929026.git.asml.silence@gmail.com> <dbde32b0c68a1ac5729e1c331438131bddbf3b04.1754929026.git.asml.silence@gmail.com>
In-Reply-To: <dbde32b0c68a1ac5729e1c331438131bddbf3b04.1754929026.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 17:05:04 -0700
X-Gm-Features: Ac12FXzz_Iko5p20Cye3sqCoWlQwWZZZnSaHztm_XvmIUlItKxFh_3F3sZGnpfw
Message-ID: <CAHS8izNXjGhg2ntH_9rjH8OfbZr8VaU97w6j4uYqK9kkQE+n5g@mail.gmail.com>
Subject: Re: [RFC net-next v1 4/6] net: convert page pool dma helpers to netmem_desc
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	sdf@fomichev.me, dw@davidwei.uk, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Byungchul Park <byungchul@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> struct netmem_desc has a clearly defined field that keeps dma_addr. Use
> the new type in netmem and page_pool functions and get rid of a bunch of
> now unnecessary accessor helpers.
>
> While doing so, extract a helper for getting a dma address out of a
> netmem desc, which can be used to optimise paths that already know the
> underlying netmem type like memory providers.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/net/netmem.h            |  5 -----
>  include/net/page_pool/helpers.h | 12 ++++++++++--
>  net/core/netmem_priv.h          |  6 ------
>  net/core/page_pool_priv.h       |  9 +++++----
>  4 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d08797e40a7c..ca6d5d151acc 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -389,11 +389,6 @@ static inline bool netmem_is_pfmemalloc(netmem_ref n=
etmem)
>         return page_is_pfmemalloc(netmem_to_page(netmem));
>  }
>
> -static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
> -{
> -       return netmem_to_nmdesc(netmem)->dma_addr;
> -}
> -
>  void get_netmem(netmem_ref netmem);
>  void put_netmem(netmem_ref netmem);
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index db180626be06..a9774d582933 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -425,9 +425,10 @@ static inline void page_pool_free_va(struct page_poo=
l *pool, void *va,
>         page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct)=
;
>  }
>
> -static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem=
)
> +static inline dma_addr_t
> +page_pool_get_dma_addr_nmdesc(const struct netmem_desc *nmdesc)
>  {
> -       dma_addr_t ret =3D netmem_get_dma_addr(netmem);
> +       dma_addr_t ret =3D nmdesc->dma_addr;
>
>         if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
>                 ret <<=3D PAGE_SHIFT;
> @@ -435,6 +436,13 @@ static inline dma_addr_t page_pool_get_dma_addr_netm=
em(netmem_ref netmem)
>         return ret;
>  }
>
> +static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem=
)
> +{
> +       const struct netmem_desc *desc =3D netmem_to_nmdesc(netmem);
> +
> +       return page_pool_get_dma_addr_nmdesc(desc);
> +}
> +

nit: this wrapper feels very unnecessary. The _nmdesc variant has only
one call site from page_pool_get_dma_addr_netmem. I'd really prefer we
don't have the _nmdesc variant.

But, minor issue, so reviewed-by anyway.

Reviewed-by: Mina Almasry <almasrymina@google.com>

