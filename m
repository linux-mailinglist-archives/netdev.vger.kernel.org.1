Return-Path: <netdev+bounces-229098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE359BD82A1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142743E84FA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359E30F920;
	Tue, 14 Oct 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7t94W4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9F30F527
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430319; cv=none; b=AdBQ8PotegNIF1tCCZ31DhSX3jj65Xq8fSsRgMWRM0sN2Fr8EwQ11Hdzw44uPkSed/xN3mX4gSr4kVHj+NDHfTBkJvYbX3ZkSPuy8VCZx4xUtEK/FRz7hNzK/koZ+2ou6F5bmuXQ0NS3hVItayPXycJN1UTez6ondTrO5SL+bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430319; c=relaxed/simple;
	bh=HDDBJEUGG08qvPrt90w1UW+14TOaO/pVign3zqHVNV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWBMskSQUrE13alMu3FYojWoyGSgYqjueK4CJtvoS3MFNMX0cPI9OUXXK06rxcnEWp7t/7bvYrSj57bw8/PdBdSeMtodFekuR3YiCRclst8g/iRp5NDQRwyABKnzgVWtqPad0LVRURR26K49ayirUtRNnTCoNvww5fVbDfdMUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7t94W4P; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-87db3aa478fso537205585a.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760430317; x=1761035117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xedia4qpks7I7EdQJJs0YGYLRIvZhKtcLLcwC48lucU=;
        b=C7t94W4PAvH672uEregUaYcwuoeRCm/Zj4DNQDs1wJXKE04/ZWxqpNi1sg2htkB/ZM
         5NvsvOb3SosIBZ7mTnjvuktjaorlToQWt37zsaefQUQwJo2aQlpkYKGeDJzq+dpoVEUd
         YUrNvdX+ZV8Yz6kN2+DLp/CisfUXql4C24rwrYsAND+NauYpXjhQzNgNeFzoqmTBahoz
         s5/JVUv9xQ1liMYvWuRHP1YQSvT9rDzXOH/ySvVKqQOJ1lZkAxLdcqvaILDZihqNV/bk
         Iz5Gm4GdBv57G6Cuv+jp+P2ihgDlEz3tyu2WgRWZq/8sRCpkrZjB0FsnuqJz5UOUB+M+
         gmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430317; x=1761035117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xedia4qpks7I7EdQJJs0YGYLRIvZhKtcLLcwC48lucU=;
        b=YxUyhyF640Uv2snUhxqbUxG2hL6SPS+3HFnaKt58EJCdzWIQCEMaVVvNoI0VeywqHK
         h/YqLZu7y4Dto0nJswDEbk7kaX6gQM52AI0eQFthAAz3ECMVWaJT1rgZdfOMmuDULRvk
         IX/8BRgT5A7f/pD8hWkX7izwNgoZ7+AnD1vlsgYUVweB+bh0AaB04w0QFcac4+xw6zpF
         heR3naqj6TIFGJv2rmUpP97YTrj/wFXNp/HXCik/0FkNggNqgJ2TMNXsYYqBqH4TfrgK
         ND/07dTeOujUcC3m1DRRn4W+nVU9ZXZbb8nxgQZrzfO2IERuh7vNbiaUitn12ZQvpB1f
         9oTw==
X-Forwarded-Encrypted: i=1; AJvYcCU8LiBii21cKAFIOSHBQTNhScMyEvaLTzCB6+Lvfii+eSFuS05pPdFZqSb3c9LJP7hq/BrGP54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWJfyMYrRom5vdPMrcF7CDHvLs6Rm/1I91gyE0Dx32FEr6hDO
	g75PmuC7RxweQM4B58DE3uDBnzD8RPF9RjO6HdYpA/PNGmB5DQHHHsSAH0M8ScQhZyXhEnhxgvM
	h/FbRoFQCVMY7Z7d3STPfQRzKK1rpOTCi5qEW3PiZ
X-Gm-Gg: ASbGncu7VSEX7yI/y9PKVKnw2mDKw82L/DXIne0965E+VQlZCgiDR6VknRxMPrIRGfS
	nTfXBQoQrlcmzEJcHcHJBuwY1IQs1hI1Z4JAEhPAvmU0ks0TmASoyuh63htqZ/U3mUjfjbUwKFu
	lh/9KmIGT1EeO2Xd9d/gjOzdj8GkFZTYyfjGCRNHi19Bd+Kgo1dHIvM2s8K7jfgy5BDWlLasrtp
	+ROIZbUk11DH6mxikoUGuiZXfAzHdAZ
X-Google-Smtp-Source: AGHT+IE2XZuUpY6yf1dVWPffNJkuGfhZwF35m+45ndZ/A0W69WaedUjJkm4TDgb9gRxsnIAXSMksxOG9bcF7EYiqZu4=
X-Received: by 2002:ac8:6f1a:0:b0:4b3:2dc:8b84 with SMTP id
 d75a77b69052e-4e6ead513b5mr378830371cf.47.1760430316382; Tue, 14 Oct 2025
 01:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
 <20251014035846.1519-1-21cnbao@gmail.com> <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
 <CAGsJ_4ySSn6B+x+4zE0Ld1+AM4q-WnS0LfxzWw22oXr7n5NZ=g@mail.gmail.com>
 <CANn89i+j_CZM9Q=xTkSq-7cjeRkt29JikD3WqvmPihDrUHBQEQ@mail.gmail.com> <CAGsJ_4xC=5nCSOv9P7ySONeXwdXN-YK2V+4OZ2zdCOeYiQHvzQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xC=5nCSOv9P7ySONeXwdXN-YK2V+4OZ2zdCOeYiQHvzQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:25:05 -0700
X-Gm-Features: AS18NWCsffjFXuh9SOpm483ZoDLgHXwm8ssjSph3yipxi4Ti2I03tEtjJ8_KnP0
Message-ID: <CANn89iK0OWswFFHH10PLzFdcFxZXodWorR5YJSdPq+P6+Qsu1Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, hannes@cmpxchg.org, horms@kernel.org, 
	jackmanb@google.com, kuba@kernel.org, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linyunsheng@huawei.com, mhocko@suse.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, surenb@google.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	willemb@google.com, zhouhuacai@oppo.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:17=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 3:01=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Oct 13, 2025 at 11:43=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > >
> > > > >
> > > > > A problem with the existing sysctl is that it only covers the TX =
path;
> > > > > for the RX path, we also observe that kswapd consumes significant=
 power.
> > > > > I could add the patch below to make it support the RX path, but i=
t feels
> > > > > like a bit of a layer violation, since the RX path code resides i=
n mm
> > > > > and is intended to serve generic users rather than networking, ev=
en
> > > > > though the current callers are primarily network-related.
> > > >
> > > > You might have a buggy driver.
> > >
> > > We are observing the RX path as follows:
> > >
> > > do_softirq
> > >     taskset_hi_action
> > >        kalPacketAlloc
> > >            __netdev_alloc_skb
> > >                page_frag_alloc_align
> > >                    __page_frag_cache_refill
> > >
> > > This appears to be a fairly common stack.
> > >
> > > So it is a buggy driver?
> >
> > No idea, kalPacketAlloc is not in upstream trees.
> >
> > It apparently needs high order allocations. It will fail at some point.
> >
> > >
> > > >
> > > > High performance drivers use order-0 allocations only.
> > > >
> > >
> > > Do you have an example of high-performance drivers that use only orde=
r-0 memory?
> >
> > About all drivers using XDP, and/or using napi_get_frags()
> >
> > XDP has been using order-0 pages from the very beginning.
>
> Thanks! But there are still many drivers using netdev_alloc_skb()=E2=80=
=94we
> shouldn=E2=80=99t overlook them, right?
>
> net % git grep netdev_alloc_skb | wc -l
>      359

Only the ones that are using 16KB allocations like some WAN drivers :)

Some networks use MTU=3D9000

If a hardware does not provide SG support on receive, a kmalloc()
based will use 16KB of memory.

By using a frag allocator, we can pack 3 allocations per 32KB instead of 2.

TCP can go 50% faster.

If memory is short, it will fail no matter what.

