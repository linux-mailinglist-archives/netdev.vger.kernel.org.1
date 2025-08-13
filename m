Return-Path: <netdev+bounces-213126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00934B23CFE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC13A189AF02
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B41362;
	Wed, 13 Aug 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CQ2Ln9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5023EC2
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755044090; cv=none; b=jfjUNF+KKp/hX0ZRBrOWo1hoWtdCfbL9qc9i7ObLHYeg+yiyCyqhs/vVWgAdAzAkrDs/dbKXc0I6hLYF5CswqmDaxBhZdKWQyI7a+/KnNd0wLq7i52+zOKo2Y+Hut3pEerVk5HvD0CCchc1UD7iYHDU15oxdrcIx0BbsqBSnZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755044090; c=relaxed/simple;
	bh=YDtcJ9TMxa+wtQ79epfoYUl2HhammPK9aBzF8YOtcdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om7l4osJ/wt6A1ML819TrDkGopgXVFK8A/7lZ4OllC8lzrj4IknFj5KpaIeMThCtm/JuP0tjApCd7Z+eLYHdr3dXaILA0qhyCTTHwBrZ1G+2dADhMtsZKUTDzw/vD+bzj4wRCR+7Gkz5d/ASbGRjBokhRUbwuOVo2LmHYB7YWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CQ2Ln9F; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55cd6293605so1833e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755044087; x=1755648887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVLpF3rDeKETricP3lJjYBCxedMQlnkOUXT1PGObtW0=;
        b=1CQ2Ln9FRV0O13NOm6PdM5dme/B+2EiJJtCiaUeayNVRdCYQa8iGKpBeKgzKZOkFq2
         4jrWsD/hromFDGwE7VxU7KAVuOwuynJmPGi9I4hGBtp2YaQJbcaX5W6jnA4ad4NJh7Vc
         w76upI10R7RGRODIUK8BQmzWp/kRRgK5XiVf+FleM1XJ71UcFTYpyraArIHvgBXtZusw
         RsnImGbHpgP2GL2Oun1engJh4JGY30vCmLlXdFdcj1GLW9QwOw6E/0vt2fgAFXVm4FBf
         A/RIoALxQ/TVizrvHkaIulcuPcRx8bwJkYS9VHGn/pA5vkfwwUrBoMGvSVOuyaKlpQBj
         bEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755044087; x=1755648887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVLpF3rDeKETricP3lJjYBCxedMQlnkOUXT1PGObtW0=;
        b=esr21HZwcKH6+3D5XMKhFDP5Rh9WdQpmxpG7l0/4PAMBc32NbAxUOg8dE15Dbi0YuV
         aRDIc4Q6+EOAOFtkhMMV6y6COlFYB23INruZkN4+qw5eVsY+uAEJYmoLixuIOyK+pzgm
         rvfx6XqIrOm49P5XQvJUcbRMuL5gHVUu11iebVRRDkFDy4DxjNMDR1oAd5sHUev05Z82
         uS/4+GN79EiLJLztvbFftvbekzE6HSM5GlVidfXR5EC3yoqVg+o7nfRwONm38Z12lQCe
         QKXHXcVMYyc7BTrdnEg4C4DOoyg8b26JTGVeFgs7q0lm25mokHJpO75fMANRH26XzWD8
         3alg==
X-Gm-Message-State: AOJu0Yx9axWKn6+wQF0zH7wM02Qp23yfAIpvCPlS7MeMAHQYMb3Ur7F1
	G3ZU5F9iJ1Lz/XEaFXgdTzBvxXB0AxnQhRXJSTI+3TnMRoUCbRKOgyg0kkOh/5zaADmrQevo8CQ
	QOrZN713b/EWAYoP9tunJ6OsxoBcaBRYxRfmsysuz
X-Gm-Gg: ASbGnct9RLJpRfwQ8WQy73+2OG6PpTeAzfiVEA1aUZnl7KoRdYnbN1C+zAQ01TZSWAf
	16vxVMzA6+dhSR6qo9Dsp9gZOAFHumiXgJte7qPyIqvWbM2M5jPLeXY4bxEKP38lBvLtvAwopQX
	01I6BSBIoURVt+7gAfKt6ESUbPpZW/K17BX2un3WKOqacRsd3LXgDLlThnFi51+7v3VqQdh9gzs
	b6gARxZjfyejWQnmDuUg6KfegepjvQQFglpROsVIGVXjDY=
X-Google-Smtp-Source: AGHT+IG7yWeWTWyNWXIQItRRsOEK8jerJ3tMxMdK2nYJxrAtp5vDLE/Ar8aykVeAPEYCcWMbFJ439q8QIwK1w8BmA5M=
X-Received: by 2002:a05:6512:31c5:b0:555:4de:c172 with SMTP id
 2adb3069b0e04-55ce1240c1cmr80461e87.3.1755044086703; Tue, 12 Aug 2025
 17:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754929026.git.asml.silence@gmail.com> <7be7a705b9bac445e40c35cd227a4d5486d95dc9.1754929026.git.asml.silence@gmail.com>
In-Reply-To: <7be7a705b9bac445e40c35cd227a4d5486d95dc9.1754929026.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 17:14:34 -0700
X-Gm-Features: Ac12FXwg6tL9s_YnxAoH0rxel3taiPVzbtR-Qz-7woiW0COYmNhL3lABzluIN5k
Message-ID: <CAHS8izOMhPLOGgxxWdQgx-FgAmbsUj=j7fEAZBRo1=Z4W=zYFg@mail.gmail.com>
Subject: Re: [RFC net-next v1 5/6] net: page_pool: convert refcounting helpers
 to nmdesc
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
> Use netmem descriptors for the basic buffer refcounting helpers and use
> them to implement all other variants. This way netmem type aware helpers
> can avoid intermediate netmem casting and bit masking/unmasking.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/net/netmem.h            |  5 -----
>  include/net/page_pool/helpers.h | 29 ++++++++++++++++++++++-------
>  net/core/devmem.c               |  5 -----
>  3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index ca6d5d151acc..7b5f1427f272 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -324,11 +324,6 @@ static inline struct page_pool *netmem_get_pp(netmem=
_ref netmem)
>         return netmem_to_nmdesc(netmem)->pp;
>  }
>
> -static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netm=
em)
> -{
> -       return &netmem_to_nmdesc(netmem)->pp_ref_count;
> -}
> -
>  static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
>  {
>         /* NUMA node preference only makes sense if we're allocating
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index a9774d582933..bc54040186d9 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -234,9 +234,14 @@ page_pool_get_dma_dir(const struct page_pool *pool)
>         return pool->p.dma_dir;
>  }
>
> +static inline void page_pool_fragment_nmdesc(struct netmem_desc *desc, l=
ong nr)
> +{
> +       atomic_long_set(&desc->pp_ref_count, nr);
> +}
> +
>  static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
>  {
> -       atomic_long_set(netmem_get_pp_ref_count_ref(netmem), nr);
> +       page_pool_fragment_nmdesc(netmem_to_nmdesc(netmem), nr);
>  }
>
>  /**
> @@ -259,12 +264,12 @@ static inline void page_pool_fragment_netmem(netmem=
_ref netmem, long nr)
>   */
>  static inline void page_pool_fragment_page(struct page *page, long nr)
>  {
> -       page_pool_fragment_netmem(page_to_netmem(page), nr);
> +       page_pool_fragment_nmdesc(pp_page_to_nmdesc(page), nr);
>  }
>
> -static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
> +static inline long page_pool_unref_nmdesc(struct netmem_desc *desc, long=
 nr)
>  {
> -       atomic_long_t *pp_ref_count =3D netmem_get_pp_ref_count_ref(netme=
m);
> +       atomic_long_t *pp_ref_count =3D &desc->pp_ref_count;

nit: I think we can also kill the pp_ref_count local var and use
desc->pp_ref_count directly.

>         long ret;
>
>         /* If nr =3D=3D pp_ref_count then we have cleared all remaining
> @@ -307,19 +312,29 @@ static inline long page_pool_unref_netmem(netmem_re=
f netmem, long nr)
>         return ret;
>  }
>
> +static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
> +{
> +       return page_pool_unref_nmdesc(netmem_to_nmdesc(netmem), nr);
> +}
> +
>  static inline long page_pool_unref_page(struct page *page, long nr)
>  {
> -       return page_pool_unref_netmem(page_to_netmem(page), nr);
> +       return page_pool_unref_nmdesc(pp_page_to_nmdesc(page), nr);
> +}
> +
> +static inline void page_pool_ref_nmdesc(struct netmem_desc *desc)
> +{
> +       atomic_long_inc(&desc->pp_ref_count);
>  }
>
>  static inline void page_pool_ref_netmem(netmem_ref netmem)
>  {
> -       atomic_long_inc(netmem_get_pp_ref_count_ref(netmem));
> +       page_pool_ref_nmdesc(netmem_to_nmdesc(netmem));
>  }
>
>  static inline void page_pool_ref_page(struct page *page)
>  {
> -       page_pool_ref_netmem(page_to_netmem(page));
> +       page_pool_ref_nmdesc(pp_page_to_nmdesc(page));
>  }
>
>  static inline bool page_pool_unref_and_test(netmem_ref netmem)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 24c591ab38ae..e084dad11506 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -440,14 +440,9 @@ void mp_dmabuf_devmem_destroy(struct page_pool *pool=
)
>
>  bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref ne=
tmem)
>  {
> -       long refcount =3D atomic_long_read(netmem_get_pp_ref_count_ref(ne=
tmem));
> -
>         if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
>                 return false;
>
> -       if (WARN_ON_ONCE(refcount !=3D 1))
> -               return false;
> -

Rest of the patch looks good to me, but this comes across as a
completely unrelated clean up/change or something? Lets keep the
WARN_ON_ONCE?

--=20
Thanks,
Mina

