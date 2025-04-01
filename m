Return-Path: <netdev+bounces-178499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAEA7751C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276B83A74F0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21031E7C2F;
	Tue,  1 Apr 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtvyLz1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8971E7C0E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491869; cv=none; b=hHj3XHz4jCnt94DcZwp49sKiVcEWBlBvmkGkssVil3r+2qwMi8v+M3VxPaBCG9BC7wiyV7iwgJd/TroyVwPFK2Tp/6nriFuE433Qs6DucoLQGe/3m9XjRnrqEZjn3/RzfOFi20SMpmHXhh/G68AEkApY4XJpGnSmexyAPGSzGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491869; c=relaxed/simple;
	bh=R47fBs/aSUqu8V65BhtfZkaJpwfAsSFzOW3O2T9Jovo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fagJGdQq/K6TjB8niR9EWZqfZfAB0H/jVBzN/FCYJg3Y7PEHrZAlNy3KyJivciigikrP8fQ6EXr5KjOtPiaMFSs8B9bYnT+vIw6dKDUspKKheIpV8HAiqY4yMgJz8RbRPgA5pTEvzMl7tBhsPm6iF/WfUeB1n521vSG1sy6UN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtvyLz1O; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso9574999a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743491866; x=1744096666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XblhwfpoL/wdEhd1eNKwaQ/ml4EekreePjQ1dJcuRAM=;
        b=DtvyLz1Od59Hp8+TagKu6UR/rbTD2D5U2FxA6Xf1la+p93j4PCDALHHfiLEep+iLuq
         PkLztcDwktObwdCtYBP/l+hnKSv9IoHUMGK9tX/UPI6TGfK1c7y5cXq3DJFPYZ8m/e31
         /d/add4QL2m679dUB7QUH7Uxfipic+oP84ST4OSN7heSx/Xwo0RHC6/nNjXKQJ/MdA9m
         Ff5pIrD/xlz7pr7xsUnD7cJFrdLNyqlPpP0Bd7nxTRye/zSEQSbUvU1u/5vhmkUm5X+V
         6y7Wz7i5DcV97vTPZQo2I0wkR5wRu0/Bxi21Hn7leIDL2xH7JmTzKAw9kGPaWbNXFBB2
         G3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743491866; x=1744096666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XblhwfpoL/wdEhd1eNKwaQ/ml4EekreePjQ1dJcuRAM=;
        b=L7+Jzs4TnvHJlQToFiCKv6RblOHzJvSamt5HejwMYWn1mrwJkovTZpGBVNLmpKvMUz
         7+YEy7j/XiugnZ5aHWhCUu6+og3Lkr6oH919WvLNW5wDCtk5AuO0DKSfVSYegehgSjnq
         EPfXI6yPdyE403F+y3WIg26jWpkAYB1MsvlhJ7r0q1J5ZGR2z5Zh3B2hx6RcKgS9TozX
         W/tLxbSUwNsKo51g40L1uVVGb1uR8WNpNO0B361C0ncLD/dyd0lbsCFJypyiXqkfVcB1
         ZvefqYXyLufniAcVbb10TXOENmNuYUNRyu5tWmdJN5IQC1CMwQHw3DMNBjJSMiB1PA8m
         8oYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHO1vXW9PfbVqX1DF0DrGa1ESejkMYyW4FkBXSyLtvre0G46mxag2QlP9+k9Z6NVuxTfsBBDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kiy1ZYc2BzdEpk+3e4C0oi16dwcvvtbIX5OAPci89ErItxTp
	ILavAbcEhy1sVIT1Jyfk3K1lrAiRfjzYJiMAh8+QF8NE6/N4hB3vvJg5Ib3RDcrbPgDOVWGD0m2
	X2gHSV08Ih0qfkoSMeySs6WBr22s=
X-Gm-Gg: ASbGncsptWEGVXtTx76Op+M+1JDdpc3Et9A+lt+0b6sy43BM1IX9nLoTktIKlBRaACe
	OnsrIGgbk67qwYv/gHNsidZ7Pre904g07UIVp+597A6e0LxFBAD2mXASsCq1zJ9O+OC4OMiJfMh
	N6gcSsR5q4DSVB1Hc7aNUFlWtNLESF
X-Google-Smtp-Source: AGHT+IH59AhC/WPDKe0tNo+ygDNx2ppU0eb7SOaWgqOd7tpTok7YxVanM7ebMrxIlAvYIZF5waOeEo98TfMSKOA8xtA=
X-Received: by 2002:a05:6402:510a:b0:5e0:58ca:6706 with SMTP id
 4fb4d7f45d1cf-5edfdc02a25mr9816856a12.30.1743491866127; Tue, 01 Apr 2025
 00:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-2-ap420073@gmail.com>
 <CACKFLinMwcWpv1Z13Si2sDPFUeRYx_aMfS=_46PWTBYmHvMm5g@mail.gmail.com>
In-Reply-To: <CACKFLinMwcWpv1Z13Si2sDPFUeRYx_aMfS=_46PWTBYmHvMm5g@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 1 Apr 2025 16:17:34 +0900
X-Gm-Features: AQ5f1Jr3pJedCQujxifYkff-151hJHDXgaehO7mPrnONjrjmcY1zXgH6VMlqdOM
Message-ID: <CAMArcTXrryUq_D9i4ezRk7Et6qNC4jD9iGNxSELYt2qWzSREgg@mail.gmail.com>
Subject: Re: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk, 
	netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me, 
	aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:39=E2=80=AFPM Michael Chan <michael.chan@broadcom.=
com> wrote:
>

Hi Michael,
Thanks a lot for the review!

> On Mon, Mar 31, 2025 at 4:47=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 934ba9425857..198a42da3015 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -915,24 +915,24 @@ static struct page *__bnxt_alloc_rx_page(struct b=
nxt *bp, dma_addr_t *mapping,
> >         if (!page)
> >                 return NULL;
> >
> > -       *mapping =3D page_pool_get_dma_addr(page) + *offset;
> > +       *mapping =3D page_pool_get_dma_addr(page) + bp->rx_dma_offset +=
 *offset;
>
> Why are we changing the logic here by adding bp->rx_dma_offset?
> Please explain this and other similar offset changes in the rest of
> the patch.  It may be more clear if you split this patch into smaller
> patches.

Apologies for a lack of explanation.
This change intends to make the two functions similar.
__bnxt_alloc_rx_page() and __bnxt_alloc_rx_frag().

Original code like this.
```
    __bnxt_alloc_rx_page()
        *mapping =3D page_pool_get_dma_addr(page) + *offset;
    __bnxt_alloc_rx_frag()
        *mapping =3D page_pool_get_dma_addr(page) + bp->rx_dma_offset + off=
set;

Then, we use a mapping value like below.
    bnxt_alloc_rx_data()
        if (BNXT_RX_PAGE_MODE(bp)) {
            ...
            mapping +=3D bp->rx_dma_offset;
        }

    rx_buf->mapping =3D mapping;

    bnxt_alloc_rx_page()
        page =3D __bnxt_alloc_rx_page();
        // no mapping offset change.
```

So I changed this logic like below.
```
    __bnxt_alloc_rx_page()
        *mapping =3D page_pool_get_dma_addr(page) + bp->rx_dma_offset + *of=
fset;
    __bnxt_alloc_rx_frag()
        *mapping =3D page_pool_get_dma_addr(page) + bp->rx_dma_offset + *of=
fset;

    bnxt_alloc_rx_data()
        // no mapping offset change.
        rx_buf->mapping =3D mapping;

    bnxt_alloc_rx_page()
        page =3D __bnxt_alloc_rx_page();
        mapping -=3D bp->rx_dma_offset; //added for this change.
```

However, including this change is not necessary for this patchset.
Moreover, it makes the patch harder to review.
Therefore, as you mentioned, I would like to drop this change for now
and submit a separate patch for it later.

Also, if you think I missed other points, please let me know!

>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 21726cf56586..13db8b7bd4b7 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -807,7 +807,7 @@ struct nqe_cn {
> >  #define SW_RXBD_RING_SIZE (sizeof(struct bnxt_sw_rx_bd) * RX_DESC_CNT)
> >  #define HW_RXBD_RING_SIZE (sizeof(struct rx_bd) * RX_DESC_CNT)
> >
> > -#define SW_RXBD_AGG_RING_SIZE (sizeof(struct bnxt_sw_rx_agg_bd) * RX_D=
ESC_CNT)
> > +#define SW_RXBD_AGG_RING_SIZE (sizeof(struct bnxt_sw_rx_bd) * RX_DESC_=
CNT)
>
> I would just eliminate SW_RXBD_AGG_RING_SIZE since it is now identical
> to SW_RXBD_RING_SIZE.
> Thanks.

Okay, I will remove SW_RXBD_AGG_RING_SIZE and then use
SW_RXBD_RING_SIZE instead.

Thanks a lot!
Taehee Yoo

