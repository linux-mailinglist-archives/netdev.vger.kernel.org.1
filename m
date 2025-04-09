Return-Path: <netdev+bounces-180577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F28A81BB0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343A87A720B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21713BC3F;
	Wed,  9 Apr 2025 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3ZxwuZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7B6F073
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170506; cv=none; b=h3l6K68G5T37dMlXmKrarnSkZJrPDhTIjrFIwPntjoeHAh5JDyyVnZ+kd/WPXe0bMVuqkj1W2xHxnEeCT1ISPmxYkX3V2MdLcaJTIkfQ+ZB4PdEPwsAPICuSScCyG78Ykpcyp2wDA4jPMLgIo1I0cpsPDMEanwA8stSvHQBk450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170506; c=relaxed/simple;
	bh=jm23jbproO302nvscE4k26m7PcSXsSKnvx/92fuN9sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxB5lQpQi9E74cn14jwLpqcpjzhY1nJD0ZSuqO5WZCaz5NSSSAU08MgN6yEhzjRE45qTKa+cC8YJ6O/rdJWcXP+niYZYSC8YVYnS5/jl4X7kxf9WuE1GKDbo/zCxJVokZbvj1Ka/gx7VqUuBNEPfQ+yX9qUd96iN4gFHGXz92Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3ZxwuZr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso10187524a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744170502; x=1744775302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plqOV+CBhLr8hn2ShOMF5leTcV4+inLNdgzQe1MuDbc=;
        b=Y3ZxwuZrP30TFCh4RHnJQngCcnJoy+8hejUtNqQFjKJpmO8MENjcCcSW4CcD2OO2m4
         iU/2OMGzEmXy0UY3qNnZv6ICMWYrlUdVJNt9mhE3rYzIadSkigcWcMYn67xk5hDBdyJg
         7i+rTsMlR9+/3nKcn8E+Y+OFJKqC0nA1P2DnwMKhWAfoxQkhibbsyTKjA6+mYRWGLXif
         VZh6930qjZLExzteK+uC4X6c8kIzlhLHp0Y24+s0TZNnT2ScoDC05qQpaFpAAa56Nb+G
         AoCvJyMCKFbi9znRjIMWV2ujjxsV2oy7xa2hwlbXjFuOM4qHmpXs+4EarK6qR5Qi+iFc
         n88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744170502; x=1744775302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plqOV+CBhLr8hn2ShOMF5leTcV4+inLNdgzQe1MuDbc=;
        b=W4qRawP6/tkwuPQ/vXZMqmCjIUEwL8uMUKQWg01ml5R2GC7AXrWnWAV6jc/IkT3r20
         fbaQu3EC65t6I39XlQD7oMgzFrtH78Y8+z7AgWeJ/TiGXe5i6uvLCjF866o/GsCabV6E
         EvRLwCoUobRTP4ZSCFLKs5gVB4IKNLnO6s8H4BvIQo/BBwRSkRLHxGxtWahRI88mOgNK
         CpW6XnAI+sWHOKZucIJWOcXiJ/gCJtjR1TDPl9oQ+r5nW7SSLOpgT9slXfPAt9XDHW3H
         Tf+r2LynhKbcLBZZY/YRlruEw7MMNSnQiX0/u1UJobWZQb6T+m60nCeXwz7e7HXtgRWN
         /Bnw==
X-Forwarded-Encrypted: i=1; AJvYcCURb9fpq9JqeUbJzkLpO1o6MiPWao9+i7B+6OCVHSDkR6w4HztjbrxJ7TC3KibQJY01SgERmgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tTQMzhqD+ObjkVCFQKUGtAQCQ/frId1cngBU+ZKql5qpIaCu
	NIJJWOetTN7wmIyvWw7v1IAEkoGabbyOYjVBy0wnJy2YHo+ESn/PAn64en1B5PIshMxGy1heZMt
	M923DhjKn9NSB3s33L+m9Tn2cVkQ=
X-Gm-Gg: ASbGncsbM1apz0Un69eDz9jMvyNxRp409tA496qM5PgQCAQfFp4r4iqtbF7OAgRmb72
	pcMVVSgIfYTLRSiOJsjohJiW3xEqT50bHOlMh6THc1vN/gWG9D0BvJ4aPnAWxjVuMH8pt9xXkrr
	3DND14HFEEHYl/LuPhfgvvF8uk
X-Google-Smtp-Source: AGHT+IGLslssggqPSAPwBaEZvHjSNFE7yjcvWezA6Qhi/hGAEm6SAGFD/lknkH2uREmycfpDun9wl6CCBbPwjNQfy2A=
X-Received: by 2002:a05:6402:26c7:b0:5e5:edf8:88f2 with SMTP id
 4fb4d7f45d1cf-5f2f7740579mr1064458a12.23.1744170502104; Tue, 08 Apr 2025
 20:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408043545.2179381-1-ap420073@gmail.com> <CADYv5ecv3iz=B_Lve-0oK273a79Qqa=Eh08kbfhBHLFXDgotSw@mail.gmail.com>
In-Reply-To: <CADYv5ecv3iz=B_Lve-0oK273a79Qqa=Eh08kbfhBHLFXDgotSw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 9 Apr 2025 12:48:10 +0900
X-Gm-Features: ATxdqUH0Cm1ntZmDdsvweFFzJQhgK4gg7RjCvn33K9uI4pv9zNkPDhZL5vMAzko
Message-ID: <CAMArcTU7iv1McsFM24yaK5TxaiOqsayizOBr__82VKqD0w=fHw@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add support rx side device memory TCP
To: Hongguang Gao <hongguang.gao@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org, dw@davidwei.uk, 
	kuniyu@amazon.com, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:35=E2=80=AFAM Hongguang Gao <hongguang.gao@broadco=
m.com> wrote:
>

Hi Hongguang,
Thanks a lot for your review!

> On Mon, Apr 7, 2025 at 9:36=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > Currently, bnxt_en driver satisfies the requirements of the Device
> > memory TCP, which is HDS.
> > So, it implements rx-side Device memory TCP for bnxt_en driver.
> > It requires only converting the page API to netmem API.
> > `struct page` of agg rings are changed to `netmem_ref netmem` and
> > corresponding functions are changed to a variant of netmem API.
> >
> > It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> > page_pool.
> > The netmem will be activated only when a user requests devmem TCP.
> >
> > When netmem is activated, received data is unreadable and netmem is
> > disabled, received data is readable.
> > But drivers don't need to handle both cases because netmem core API wil=
l
> > handle it properly.
> > So, using proper netmem API is enough for drivers.
> >
> > Device memory TCP can be tested with
> > tools/testing/selftests/drivers/net/hw/ncdevmem.
> > This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> > 232.1.132.8.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>
> Hi Taehee,
> Thanks for submitting the patch. Overall it looks good to me.  Please see
> 2 minor comments below.
>
> I'm also in progress to test this patch, not finished yet.
>
>
> > @@ -3777,15 +3811,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt =
*bp,
> >         pp.dev =3D &bp->pdev->dev;
> >         pp.dma_dir =3D bp->rx_dir;
> >         pp.max_len =3D PAGE_SIZE;
> > -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > +       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> > +                  PP_FLAG_ALLOW_UNREADABLE_NETMEM;
> > +       pp.queue_idx =3D rxr->bnapi->index;
> > +       pp.order =3D 0;
>
> Nit, set pp.order to 0 is not needed. The whole struct was initialized
> to 0 already.

Okay, I will remove it in v2.

>
>
> > @@ -15766,7 +15808,7 @@ static int bnxt_queue_mem_alloc(struct net_devi=
ce *dev, void *qmem, int idx)
> >         xdp_rxq_info_unreg(&clone->xdp_rxq);
> >  err_page_pool_destroy:
> >         page_pool_destroy(clone->page_pool);
> > -       if (bnxt_separate_head_pool())
> > +       if (bnxt_separate_head_pool(rxr))
>
> Should be:
>         if (bnxt_separate_head_pool(clone))

Thanks for this. You're right.
I will fix it in v2.

Thanks a lot!
Taehee Yoo

>
> Thanks,
> -Hongguang

