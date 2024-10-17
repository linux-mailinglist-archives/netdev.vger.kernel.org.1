Return-Path: <netdev+bounces-136751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2489A2E5A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B464284021
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14E21A6FE;
	Thu, 17 Oct 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtsXeuYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C52281DC
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196434; cv=none; b=CTWkG10+M8QNmeknTwR1ap8khCPV2fJaxLiRcPEq0/41puVGVtu2dl2+H2t7B36xufqx0Y78am7uis+/xmemdr2ryWLlh1HLmSQ2Jv3DOmvdVvmbTYqULXsrsZw09l7ewbjXLsaL98o0/rqWgivgC0jwcX1b0ed8rxzGswZCHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196434; c=relaxed/simple;
	bh=4bHiAcmpmJaEZ/6JyICLXEOA3J8FN4bGdFi17a9IHPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONZv2su+F/yjjOfCC0baqCZfdkgtLZ8glZ8zCTt38knwOypXZsQcBJUvyqr5jSKkY6sYrvQmPd2goZoX1ideDKKZZVBrysEl9DNJF0aGqTY/gxoqKYMCJ3sZ6ZK2woBCQEHnC6mW2OHH1ZeH4JvYaGFqI8PNAquDuT01aZllaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtsXeuYb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e1543ab8so2451731e87.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729196426; x=1729801226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+lLSVJDLeSkVSD4JaLLw0mh/GqPvD/iR54O84egAsg=;
        b=KtsXeuYbQUkeIuXkB1SJFDh5175nLl+L5sZkdC+LP8PbimXAhHAdvGIGCzoI7z4l4x
         pAt1wFCBAXUtRlPhquBOJdEUFokUpd2UeMzDNJrQQKbECL57EwDtRtifIhjkHIMKXlg6
         Zm4ultYyJAhJw2s1/xlrx9rFa1+n4FqlZ2gRhg7uWOZCCaFbHkEWHv7yCSeSGn7LVHEG
         z3RzQzI4nrzbY05pGhIMQzfMQxy5I5CK1ZEcxPoNk544GO3gC97cvxFXxsKa//hPrc4C
         GG9PXWR9XZuvyr3fDjlCJ/8Ha8r63zTmcoEUhCQMof7TpaWIMqudq0sC32jNhLFxCL/7
         nRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196426; x=1729801226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+lLSVJDLeSkVSD4JaLLw0mh/GqPvD/iR54O84egAsg=;
        b=YgtcJ6LvzWYHG8xclEi7cqkIau2SRqnM00S+JjWA9pYbILrFzJPjkLbvHNc52ROWGe
         CoKXeSdUl1BVv8XXcBW7xz3rxiYbKof5yzU1kkAgH2TKLx6XkEA5OjB9d+UYSklCq3xG
         7b0XDJzvRGcY8EsNOJs/TMTElC1zfjqbmywdEoj2kXh0wnbHp8oKx2NAR1G0BRBA/+eU
         seTXMRF7ZGYg93isrqMlbfafVnSU97W2o6JNfDzdFyByjr0/unoC6hZiqqACjOx3kuOI
         +UELK/aAXvcKGsZhQbWF32E15rQx7BT6uGkLK5lltphDnFkZLsvSMMJEeMpeGXkwDf1i
         nLVw==
X-Gm-Message-State: AOJu0YxIxidR4sT5CzKHCRgGU5v7aRWSysMyksBoybFIJ8ZvGlEUTPY3
	0AOUH3KGjwVcBtEYAjHzzooCsm7IetHPj2pRvbu4ct9Gdlnb2sBRcbuzgKbk2oL6kr4p8YBGkon
	hURbvuC8p0Zj8zxbveNEet0Z6FxOZxrFqddBD
X-Google-Smtp-Source: AGHT+IFui/hNaJtzBBshxQmG7kcnixdOWrxF54utRM8cgSbOrzez4CCUme1clquWTU5EDdlQY8+hRitBZSedrIGYESY=
X-Received: by 2002:a05:6512:3a8d:b0:539:9720:99dc with SMTP id
 2adb3069b0e04-53a154c9f51mr120153e87.46.1729196425667; Thu, 17 Oct 2024
 13:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014202108.1051963-1-pkaligineedi@google.com>
 <20241014202108.1051963-3-pkaligineedi@google.com> <89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com>
 <CA+f9V1MZWkWmVHruHgJC1hqepi-CTLDvGjtkd3CGaCiUR-kF5Q@mail.gmail.com> <e9c92aab-16bc-4814-8902-7796b9d29826@huawei.com>
In-Reply-To: <e9c92aab-16bc-4814-8902-7796b9d29826@huawei.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 17 Oct 2024 13:20:14 -0700
Message-ID: <CA+f9V1N2H5_uWQ4eVa7r3Gv1JA=AW_VZu4vpC-Th8rujgpKTQA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] gve: adopt page pool for DQ RDA mode
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Yunsheng for the clarification. It makes sense to me now. We
will send a patch calling page_pool_put_full_page instead of
page_pool_put_page.

--Praveen

On Thu, Oct 17, 2024 at 2:40=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/10/17 3:43, Praveen Kaligineedi wrote:
> > Thanks Yunsheng. One thing that's not clear to me - the GVE driver
> > does not call page_pool_put_page with dma_sync_size of 0 anywhere. Is
> > this still an issue in that case?
>
> It depends on what's value of 'dma_sync_size', as the value of the
> below 'page_info.buf_size' seems to be the size of one fragment, so
> it might end up only doing the dma_sync operation for the first fragment,
> and what we want might be to dma sync all the fragments in the same page.
>
> The doc about that in Documentation/networking/page_pool.rst seems a
> little outdated, but what it meant is still true as my understanding:
>
> https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/networking/=
page_pool.rst#L101
>
> >
> > Thanks,
> > Praveen
> >
> >
> > On Wed, Oct 16, 2024 at 2:21=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/10/15 4:21, Praveen Kaligineedi wrote:
> >>
> >> ...
> >>
> >>> +void gve_free_to_page_pool(struct gve_rx_ring *rx,
> >>> +                        struct gve_rx_buf_state_dqo *buf_state,
> >>> +                        bool allow_direct)
> >>> +{
> >>> +     struct page *page =3D buf_state->page_info.page;
> >>> +
> >>> +     if (!page)
> >>> +             return;
> >>> +
> >>> +     page_pool_put_page(page->pp, page, buf_state->page_info.buf_siz=
e,
> >>> +                        allow_direct);
> >>
> >> page_pool_put_full_page() might be a better option here for now when
> >> page_pool is created with PP_FLAG_DMA_SYNC_DEV flag and frag API like
> >> page_pool_alloc() is used in gve_alloc_from_page_pool(), as explained
> >> in below:
> >>
> >> https://lore.kernel.org/netdev/20241014143542.000028dc@gmail.com/T/#md=
aba23284a37affc2c46ef846674ae6aa49f8f04
> >>
> >>
> >>> +     buf_state->page_info.page =3D NULL;
> >>> +}
> >>> +
> >>> +static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
> >>> +                                 struct gve_rx_buf_state_dqo *buf_st=
ate)
> >>> +{
> >>> +     struct gve_priv *priv =3D rx->gve;
> >>> +     struct page *page;
> >>> +
> >>> +     buf_state->page_info.buf_size =3D priv->data_buffer_size_dqo;
> >>> +     page =3D page_pool_alloc(rx->dqo.page_pool,
> >>> +                            &buf_state->page_info.page_offset,
> >>> +                            &buf_state->page_info.buf_size, GFP_ATOM=
IC);
> >>> +
> >>> +     if (!page)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     buf_state->page_info.page =3D page;
> >>> +     buf_state->page_info.page_address =3D page_address(page);
> >>> +     buf_state->addr =3D page_pool_get_dma_addr(page);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
> >>> +                                       struct gve_rx_ring *rx)
> >>> +{
> >>> +     u32 ntfy_id =3D gve_rx_idx_to_ntfy(priv, rx->q_num);
> >>> +     struct page_pool_params pp =3D {
> >>> +             .flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> >>> +             .order =3D 0,
> >>> +             .pool_size =3D GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx=
_desc_cnt,
> >>> +             .dev =3D &priv->pdev->dev,
> >>> +             .netdev =3D priv->dev,
> >>> +             .napi =3D &priv->ntfy_blocks[ntfy_id].napi,
> >>> +             .max_len =3D PAGE_SIZE,
> >>> +             .dma_dir =3D DMA_FROM_DEVICE,
> >>> +     };
> >>> +
> >>> +     return page_pool_create(&pp);
> >>> +}
> >>> +

