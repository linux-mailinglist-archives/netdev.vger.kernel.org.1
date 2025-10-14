Return-Path: <netdev+bounces-229096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE0BD8217
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA6D18A1359
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317E2DCBF3;
	Tue, 14 Oct 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgyuLe8E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58E2DA776
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429862; cv=none; b=Ydefuf2RglXAJAjSpsKltxRwcPXm8tVJd662dpKMTuOQEe8W0xBixmvPhnHtUsTnUHIRw9soIrikJFlkbImc6xk1mnuRUgLBW+cngbPiKL+za8B1LRNCst6vr6Z4ERA4UJgKjtVfV7ON6pq/1x1v2g0rRapIM2a7I/UVQ2M5SsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429862; c=relaxed/simple;
	bh=ZenOGeLl3E07i4+rFBn+dvevjdsbRCIJ235ulzP9wXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6Q7mBMWlJpFFXv4yLxSY1qBd1DFkQm55IWOKkBngxFvUj3Lj8kmVjzd5+VY75EkbeEGptS6hAW6kjGT8iR6hfHlZalM5UMULs+oZEn0QNRyoUxr3EYFGbsmYAbywYztgRBpmUoKa6Ru2gk+4ziR5/hcABgutnnmxPri0UBP0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgyuLe8E; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-930c304d1a4so776172241.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429860; x=1761034660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB5XUi1+cDwXRPWde5CzSKgVrGaXvz4WI2PJ/mRCG6U=;
        b=bgyuLe8ExLUhNGvtBKCIGR1wNkk2Xc0z0JCYLYkJFQ4uugGucHzJIFAlC/8sHbJzWo
         AhM57hqCDwsFeyRbrFzw4bgufX+sSPq+i4V392HFVmN2p1IobGdw1ilLJck2hhh085LN
         2XyfgVU5eWwIvf5SYbB1b3nusA16BrmfUpPfh9usHfvjgF5YVs6SOR6GYzLXIXG+XYTg
         mWtzlL84GGWlG4+efMubetaMcLIDNHDAngbZ5Ptrhl9vR3ybOzsyFWxRivIsnouRnnm0
         thVYt2k7RXbLCSgnyE10z1xr2KqiTxLYOVtOzY5qX3CMWQFj5cjLsp9CCAFe6RFOGM2y
         96xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429860; x=1761034660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB5XUi1+cDwXRPWde5CzSKgVrGaXvz4WI2PJ/mRCG6U=;
        b=kX7Rk3QlNcYouVbib4rw4yI8K7rKiv8uBFqiT1b4K7UnNZ7Z8q9A33FcsNiNGNtlgl
         P/yPSh6YGdncStq6bSO0+wPsG75x0JoyBYs8recZfTI2B15kEvetjlCCkFDTch0mdJa7
         3PMOIPVU8lXLCDXEmEHr5Pu63pOcvqwPRLwmSIigLWTHOV+kGo0ZCfBL66ebqGXRzTn7
         nb3Sf3V4Je0XgNiLPmzycknm6lM3rrA/Ix+e3vyhU+gkBOuW69Dg+TYET5ttBw2hyrw1
         qZiTKpa9rEI9RY6HsHSGLLxBO7II4pCfsaAk5DerTspUZ1SH9DiDTfKtlv7vlwLN0nlQ
         jdog==
X-Forwarded-Encrypted: i=1; AJvYcCUisTh7Wi09fg4j1m1JUXFrXUQkT2zdHfNWobpIvvlp96vsBMtRW87+KRGeEqMqKHJZuKPeN8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUcvXwUFe2N3XTQBMSTgZbJlQOZsPhMQ3aVLl6aMJq7kW/1PD
	Z4wIXucNf3VfLGwpIKoA5supsXfhU3/BkU+/LnMy2lBG7P0ZiLYXJDbudlK9OSwv5yxP3wg5eDu
	Cdqa6phr2pyHbZumN1hCwTGPoaujD5JY=
X-Gm-Gg: ASbGncut97YavwcdQ7GYIFj5NV5Oy9UpTVJ0u7maoltKsgJiv4oZfBneYcbS3Wno+83
	m8a0bsmox4HQGcKJcwMqAIIT2jFP5KJula8ARD5OQ34xtO0AUsLAY+PCVRHBkjJK61rqWYOOxjY
	2C+EF8YGPO5JipXzAT6ScGlgPghXLs3eI1babBjtUbkXxla7QWoQ3sTRSvRWan6rDZOH6Qi0fXd
	BEzXRpE4CtPt8f5ZLSDPWoytnyYzs+A0vHz171G12Cl64AHfRpFaT9xKGWt0lEL/S53
X-Google-Smtp-Source: AGHT+IE74/+9NMWbvU+qO/+W07sc5FWF1iW+Jodkjrw6Ldi09g2hF8G7tsWXqr3Kth9KAyQqpDa/9zGf3F+nkghdsOo=
X-Received: by 2002:a05:6102:f07:b0:4fc:1a18:aaa2 with SMTP id
 ada2fe7eead31-5d5e2217442mr8155988137.5.1760429859483; Tue, 14 Oct 2025
 01:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
 <20251014035846.1519-1-21cnbao@gmail.com> <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
 <CAGsJ_4ySSn6B+x+4zE0Ld1+AM4q-WnS0LfxzWw22oXr7n5NZ=g@mail.gmail.com> <CANn89i+j_CZM9Q=xTkSq-7cjeRkt29JikD3WqvmPihDrUHBQEQ@mail.gmail.com>
In-Reply-To: <CANn89i+j_CZM9Q=xTkSq-7cjeRkt29JikD3WqvmPihDrUHBQEQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 16:17:21 +0800
X-Gm-Features: AS18NWDxwbBeHYYzY9zkajM9730iY7yUrkf_deZ_-1VTrKeqK4m8413YWm5g-Tc
Message-ID: <CAGsJ_4xC=5nCSOv9P7ySONeXwdXN-YK2V+4OZ2zdCOeYiQHvzQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: corbet@lwn.net, davem@davemloft.net, hannes@cmpxchg.org, horms@kernel.org, 
	jackmanb@google.com, kuba@kernel.org, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linyunsheng@huawei.com, mhocko@suse.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, surenb@google.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	willemb@google.com, zhouhuacai@oppo.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Oct 13, 2025 at 11:43=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > > >
> > > > A problem with the existing sysctl is that it only covers the TX pa=
th;
> > > > for the RX path, we also observe that kswapd consumes significant p=
ower.
> > > > I could add the patch below to make it support the RX path, but it =
feels
> > > > like a bit of a layer violation, since the RX path code resides in =
mm
> > > > and is intended to serve generic users rather than networking, even
> > > > though the current callers are primarily network-related.
> > >
> > > You might have a buggy driver.
> >
> > We are observing the RX path as follows:
> >
> > do_softirq
> >     taskset_hi_action
> >        kalPacketAlloc
> >            __netdev_alloc_skb
> >                page_frag_alloc_align
> >                    __page_frag_cache_refill
> >
> > This appears to be a fairly common stack.
> >
> > So it is a buggy driver?
>
> No idea, kalPacketAlloc is not in upstream trees.
>
> It apparently needs high order allocations. It will fail at some point.
>
> >
> > >
> > > High performance drivers use order-0 allocations only.
> > >
> >
> > Do you have an example of high-performance drivers that use only order-=
0 memory?
>
> About all drivers using XDP, and/or using napi_get_frags()
>
> XDP has been using order-0 pages from the very beginning.

Thanks! But there are still many drivers using netdev_alloc_skb()=E2=80=94w=
e
shouldn=E2=80=99t overlook them, right?

net % git grep netdev_alloc_skb | wc -l
     359

Thanks
Barry

