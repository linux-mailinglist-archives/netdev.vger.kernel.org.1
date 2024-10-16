Return-Path: <netdev+bounces-136280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE929A12D0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29026B24BE9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A72144B8;
	Wed, 16 Oct 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRGKQ5H8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDA2144A9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107822; cv=none; b=rSS3NqYkgz/zu6BrKwTK9DX5yHMGRgxsIhr9MOpyUoZvGq+ocg3hEAaCLfjRJzYjmzjIz2M3UGmSPbmGydK0xpHGwDDKY0vUk/N/CngMkPGG6GGCXYl3WT5DZeNquR3z5XXjsqJR3naVn7VolKbuSyZYLWlYm5HamHukIjCouSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107822; c=relaxed/simple;
	bh=3EtZq1YJUm8sV8yUv0/QAp8tm+8F3sOQQOGzq+xLuBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrVQwx5fVMsDepEa8hKEHXmH1r1mLbVjtjFYsTxEds8anTZEaz/ZMooJbgNJBBIf7U4Yo9+uXqZ4L63nCTmMNhajNBtpF5L2JhSxDExpGuu++z9eQkO59MPYHKwfUvV3mSrpyZ+/oeaYCt/nfHVATLdqSQ3Qli4suyvXsJFYD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRGKQ5H8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb58980711so2903441fa.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729107819; x=1729712619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfzFikakdkd7rqTnyEvRl3KyvBO+P5X2ZTw6wg6GduA=;
        b=tRGKQ5H8McPz6JFd6lcB6gDzP1R7kmtZd14nRZv5csdz+5WdMwrDoG2iDE2oG3GQdT
         6x6xl/9zjZ+6Vwlj8KGr+K4kGurlnABuvZ4aFVFHevSrP7ClDh9nJZ4CNFdZHMwZfy1I
         RdyJeBUiWUcKFPugd2NHwkBtojiTHUZ9vFaHR/spYIcymO0zxbDidTISffL1PUh6H9P+
         qKaBlS/hgv1RymdeAdu/wg/bnRCFxRv8kf9QPibwvJQN/FzFP4Dz3a8Az7eOV26ImYGe
         hm8hej0EuDV+yasXJBo/RN6cGmHd/qGIN6u582XTMi/L/dtRtY5vMZezAufsgkeF8NzW
         gHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107819; x=1729712619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfzFikakdkd7rqTnyEvRl3KyvBO+P5X2ZTw6wg6GduA=;
        b=aruIJbotMy/CcW9cIDZhv+TK42DkPhIxWMyB1MG+9Jje0G7iAABrHufPkoZGDcpDxF
         Pvn0xCjXg68t7CoNht6a/Dn4ZRTvH+Eg7rLlB+Iy3gzlzHeJZTMdwq5ixqYkIfzv1K+P
         PhQ2hREuqfFFjaVbL6cWv2CR2OBZPsRGeduDQAKrQlkrUH8Sa+46xDn5nPrg1GuDkjIK
         GCPNpDrkpxII0J9/kLLPcRYnH9g4vCd0/uEhlsDhNNPmASVo33XdF/sLv7NtPCDxl6/D
         SVTy5Na2zbeAu3sNyife3IBetTccfr8FvPMhR0FZT9p5QmG5jiaQr57KTcN8QsTLB9Xs
         qUSQ==
X-Gm-Message-State: AOJu0YwLHBDRaI46yCRUmV5hS4A6OshxNPjH0M3ByKxww3/hxogDC+8d
	T3wfNcwPnRAw/p174+ueoJVCzZfhwUcJ/ooxr/tjqkkfmybxMF4sqF8YUDNHHxQnBBJKlSE5NpY
	pIj6PvHh9Iu0UtipsRQcuRovgFdnwDBb6TmVV
X-Google-Smtp-Source: AGHT+IGIYB8+sfQGhD/X4zHtOPB3919jcmnMw5lW7marVme+YLJyL93Y3iCQPO69+9iimjmtCLSwWTqmAb542zYphkI=
X-Received: by 2002:a05:651c:b2a:b0:2fb:4b1f:973f with SMTP id
 38308e7fff4ca-2fb61b3e42amr33643711fa.7.1729107818903; Wed, 16 Oct 2024
 12:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014202108.1051963-1-pkaligineedi@google.com>
 <20241014202108.1051963-3-pkaligineedi@google.com> <89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com>
In-Reply-To: <89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Wed, 16 Oct 2024 12:43:27 -0700
Message-ID: <CA+f9V1MZWkWmVHruHgJC1hqepi-CTLDvGjtkd3CGaCiUR-kF5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] gve: adopt page pool for DQ RDA mode
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Yunsheng. One thing that's not clear to me - the GVE driver
does not call page_pool_put_page with dma_sync_size of 0 anywhere. Is
this still an issue in that case?

Thanks,
Praveen


On Wed, Oct 16, 2024 at 2:21=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/10/15 4:21, Praveen Kaligineedi wrote:
>
> ...
>
> > +void gve_free_to_page_pool(struct gve_rx_ring *rx,
> > +                        struct gve_rx_buf_state_dqo *buf_state,
> > +                        bool allow_direct)
> > +{
> > +     struct page *page =3D buf_state->page_info.page;
> > +
> > +     if (!page)
> > +             return;
> > +
> > +     page_pool_put_page(page->pp, page, buf_state->page_info.buf_size,
> > +                        allow_direct);
>
> page_pool_put_full_page() might be a better option here for now when
> page_pool is created with PP_FLAG_DMA_SYNC_DEV flag and frag API like
> page_pool_alloc() is used in gve_alloc_from_page_pool(), as explained
> in below:
>
> https://lore.kernel.org/netdev/20241014143542.000028dc@gmail.com/T/#mdaba=
23284a37affc2c46ef846674ae6aa49f8f04
>
>
> > +     buf_state->page_info.page =3D NULL;
> > +}
> > +
> > +static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
> > +                                 struct gve_rx_buf_state_dqo *buf_stat=
e)
> > +{
> > +     struct gve_priv *priv =3D rx->gve;
> > +     struct page *page;
> > +
> > +     buf_state->page_info.buf_size =3D priv->data_buffer_size_dqo;
> > +     page =3D page_pool_alloc(rx->dqo.page_pool,
> > +                            &buf_state->page_info.page_offset,
> > +                            &buf_state->page_info.buf_size, GFP_ATOMIC=
);
> > +
> > +     if (!page)
> > +             return -ENOMEM;
> > +
> > +     buf_state->page_info.page =3D page;
> > +     buf_state->page_info.page_address =3D page_address(page);
> > +     buf_state->addr =3D page_pool_get_dma_addr(page);
> > +
> > +     return 0;
> > +}
> > +
> > +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
> > +                                       struct gve_rx_ring *rx)
> > +{
> > +     u32 ntfy_id =3D gve_rx_idx_to_ntfy(priv, rx->q_num);
> > +     struct page_pool_params pp =3D {
> > +             .flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> > +             .order =3D 0,
> > +             .pool_size =3D GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_d=
esc_cnt,
> > +             .dev =3D &priv->pdev->dev,
> > +             .netdev =3D priv->dev,
> > +             .napi =3D &priv->ntfy_blocks[ntfy_id].napi,
> > +             .max_len =3D PAGE_SIZE,
> > +             .dma_dir =3D DMA_FROM_DEVICE,
> > +     };
> > +
> > +     return page_pool_create(&pp);
> > +}
> > +

