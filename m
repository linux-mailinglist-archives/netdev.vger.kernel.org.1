Return-Path: <netdev+bounces-86712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8A8A0060
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7EA1C21741
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2F180A88;
	Wed, 10 Apr 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+gvAbxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA6180A7F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776182; cv=none; b=TWSvAvYXJAiGLdNOnXeuTJB4nV5ak7EvcZNwCC+mFz2MgnPzh0B7EAB29KC0nU0W3tlEm58wzXHM+HkyOhvMto4frorurQx/DXetoLAL2VLIpDh8+RkXt/v6KAQkqipIllJoqBJ8HBYq74dm16uUuptdg4mUD9R7GoY/JYgEK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776182; c=relaxed/simple;
	bh=3vpVF4t7apopDMRyVXzObK4S1vRFFr2BvTpMBTZ17jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meU2Gvv2LbXVBfokjhRDgrD2Ah+brCi2zdUP4gtPl81TWYgop/CuRRcpBNzbGpK0LVcAdrVQyNOns2zyGwZ5f1QBMqSxWK7/4/qBivkS4sfGGy6uYQdEwKvlawYuxLb0MnpE1ZN04wb9yWuzhRkLWaIr4R9aacJ0T2933bM9p00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+gvAbxm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d4d80d00so6828201e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712776179; x=1713380979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIo2EVourWrLaohp5j6QNkkQsISAFdO4wMswAJKmsJ4=;
        b=2+gvAbxmmzzAKUt5ZFXEgjLwBBIoYd/znXmBjZyRqa6rG60mYcFviZ5Tqm3sU8QCAq
         s8KIOnyM6wewe++PgEuS2J0X1Df8ZrFzX7VOmtUSp5dBjBkrIm533TaoVrFh1ISIWlSe
         sKd/B0npqipRnNgpjLz3JiTogQqXippRTpOVO6DHRgr2JCG3YxGjVd3MapjSSPCSMT7C
         dcymDAylEUkb2Cg31D9rZHY+az0xM4/IrdPCfy3d9es/HUxT8dLXdeyFWGd/bEKWa7qu
         pp4qp3+/u8XJbv4wXDlFAteHHqTxe/ZqlC38A8TuekES/xj5DwLxHRmS/V0EQgp/ye3u
         SDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712776179; x=1713380979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIo2EVourWrLaohp5j6QNkkQsISAFdO4wMswAJKmsJ4=;
        b=aEUNdnG0G10zEZexD1Q/j9iPH5sTgajXlr+NMJkpZmIG18nBT9N/kWBJQULOh0dqNP
         7NlVkk9+Xxv6IPWE5Cq3R5cAqmJpWc+HvlHkMzfSbFEeICJLtVuyh5PygmZ9JMQF7VH/
         Y3O3Z06Lc8556Rs4xBCbqb8GbQyIGT18ZJQiuuZzZZHSix6xG8bT53Av/Xa+69iRNhGa
         NDNDp0/uN+pXCGBKyAvgVIB3iyFKFGDOLPB77ScAV8ERU2sjORTQSYIWoQtUjMWqUnZO
         U+Bm6dV3JYbIJ83sJzEshBv5efq4ASWFeqSQ7jG5fhhrGkhw/zYGGPEVTPJ/Q4VJjpNK
         a6VA==
X-Gm-Message-State: AOJu0YzKFn+gj5e3cPeX9c7Z2yHibuGmrX/VIZxI8ajtE3ULKLRxp8E7
	ZlgxQcGQ+b8b8TV8M8xNescKKR4A16rWMAR/d5z7kZerDb3LqIwiknx9gdnqDvlkYuf4+xkXoR6
	gEAi7GT+F0jQZfJJcLwgmLCc2lfc8MYI2zb+i
X-Google-Smtp-Source: AGHT+IH5P3MBCNgnfVNKHRh/3p0kXImGKWwPLqhR8qXKbY22t/CU4Q5cuxfS1hEk4O6f0dElkgcrJEVfk3FCIRv4BiY=
X-Received: by 2002:a05:6512:33cb:b0:517:854e:2c91 with SMTP id
 d11-20020a05651233cb00b00517854e2c91mr925647lfg.64.1712776178375; Wed, 10 Apr
 2024 12:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408153000.2152844-1-almasrymina@google.com>
 <20240408153000.2152844-3-almasrymina@google.com> <20240409182301.227c9ff7@kernel.org>
In-Reply-To: <20240409182301.227c9ff7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 10 Apr 2024 12:09:26 -0700
Message-ID: <CAHS8izM+S=j1DLsb6JdKFFUurotcw3eArGDOz9NBvksDoh=11Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net: mirror skb frag ref/unref helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  8 Apr 2024 08:29:57 -0700 Mina Almasry wrote:
> > +#ifdef CONFIG_PAGE_POOL
> > +static inline bool is_pp_page(struct page *page)
> > +{
> > +     return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> > +}
> > +
> > +/* page_pool_unref_page() lives in net/page_pool/helpers.h */
> > +static inline void page_pool_ref_page(struct page *page)
> > +{
> > +     atomic_long_inc(&page->pp_ref_count);
> > +}
> > +
> > +static inline bool napi_pp_get_page(struct page *page)
> > +{
> > +     page =3D compound_head(page);
> > +
> > +     if (!is_pp_page(page))
> > +             return false;
> > +
> > +     page_pool_ref_page(page);
> > +     return true;
> > +}
> > +#endif
> > +
> > +static inline void skb_page_ref(struct page *page, bool recycle)
> > +{
> > +#ifdef CONFIG_PAGE_POOL
> > +     if (recycle && napi_pp_get_page(page))
> > +             return;
> > +#endif
> > +     get_page(page);
> > +}
>
> Shifting of all this code from pp to skbuff catches the eye.
> There aren't that many callers to these, can we start a new header?

I am not 100% sure what the new header should be named and what
exactly you wanted moved to the new header, but made a guess and
uploaded v6 with this change. Let me know if it's not what you had in
mind. I added a new linux/skbuff_ref.h header file, moved all the ref
functions there, and included page pool headers in that without worry.

v6: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D843380

> We can then include page pool headers in the without worry.
>
> I'll apply the other patches, they look independent.



--=20
Thanks,
Mina

