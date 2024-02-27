Return-Path: <netdev+bounces-75434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8501C869EC1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2520E1F234A5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB41474A9;
	Tue, 27 Feb 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHn/gYew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BB1468F4
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057723; cv=none; b=bX/FvledVYzXbpORtSLhQ6xSlDuzUtcBrLH4siRL8aQxY8kjmSldVgO1InVuP83hoRF9qws9ii6XCjPXOnR8DJ2mZFkJMxpgPu4C259rcYfUtq4Mp3Fo47xMpwVMairE9mXA+Ty1tVqpjBVFHZRjLFLCRatwiFhITvULQnbNr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057723; c=relaxed/simple;
	bh=yGfF2y7OiQ62zjsBayX5vj7f1RM7VNMek1YdbDiXn9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXbDAfqsp8vmUJY2tyzcwZvw0ThFTVRhduRTB2mePFE5EiQedKsZ5mJhWiRYwABl2op5yoZvewi6NURCd2NNAFIHD4S39sgVUojSvsv9EASrItLK3BYpFDLIih8z19gprYg37iMwc/+FtjWVhcb2wfz549jd2HDwGzN2d0Za0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHn/gYew; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5664623c311so434a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709057719; x=1709662519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW8lo8QQWVGX5jcFTfGpjOUlvf6b0ipeO/aWgeZxw6I=;
        b=VHn/gYewMTfO1G2NjXAAuSWQylDH2J7RFkTsDo7ckMIPyDtzTfKbxAyklRw/IrT3KO
         NO7ebgonUCFJscfO3u2i6RJck4En/KPultVp8EQoxMuizrZtpXE5wWoOlCOvdWPyhkof
         zSTjxBRzVcJYu0QJOdLSv+uCPH+JQ6PrVU4sf1XsxAV7BxiNF8dOO39L2J4WfbSfrUBM
         jzcAKDWD3PyTRytm93NiToWlTt1pqxdIF1+Kw8T+jv8lEgjvbgFAujF8ZEfsxfe3BdxT
         bpy3J80YI8X6UjEuOYD+V1eq2pMoxP5xCVJT9iHsHO1VE0BVOhjZm1niNkSylhYZVFjU
         xCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057719; x=1709662519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW8lo8QQWVGX5jcFTfGpjOUlvf6b0ipeO/aWgeZxw6I=;
        b=OrTtNvDibM9zGDSSzk7m6oEy2kQLHgfiuuz8AgyaVzf1aFQhjEuCLW3ilnC+vZIsHi
         dUcSwuUW40UPRghlS/wvt+VTYj5Puqe3G1zeQQuBWmNmjTNk5DoPeSzrzzHetSajfcAi
         bP1L30oK7HWhZ34nyI9HMU3cxQ7qMjI0qL93LinNlr+RbBpWydxaO6YP1r2GugypiJa+
         RqL2VSCwVh5G+djyscZpr9NXCu1/RWexCp+O0lIUdZ0R6/AJs5IfoIajX+K+Tzf7aov+
         rTM/M8tB+8+Pv4jnXR7LT8pw5cyQLtYpu7OadvTSRVxJdewnw9J0cZyIuyIcgT2JNxdb
         gjug==
X-Forwarded-Encrypted: i=1; AJvYcCVOvHgPyre9wfYT+ibyuOKYfRyxcRGspizCudp0kY+ozEQ7mkMJmfExn1Ua5BXTkhmjSU//a/hF7h168pUPEJY+2CowpVHZ
X-Gm-Message-State: AOJu0YzVpefoYY80NlGaRz7ot5pfbXwcOfiCECL9Ex6pkU1O/ykyezHK
	BvivPOnbqzHZkYLuxrO9hKe0awzADPC4EoG0BwZi1ixqI1rpVpibfBLu3EjXalEtfm2BR0Cg0At
	2yg7LVwUagJ4q68MXfeS1HSItflG7m9lZZUGw
X-Google-Smtp-Source: AGHT+IELVMhAMLanzwPjFyzOn2aNRqc72lowDF2s9NjQXEdP4V0Kdc8O22CYUWW1hRot4y1qFpei0CbSNjZT2hVaWiI=
X-Received: by 2002:a50:a448:0:b0:565:abf9:1974 with SMTP id
 v8-20020a50a448000000b00565abf91974mr260424edb.2.1709057718694; Tue, 27 Feb
 2024 10:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224090630.605917-1-edumazet@google.com> <20240227095244.23e5a740@kernel.org>
In-Reply-To: <20240227095244.23e5a740@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 19:15:04 +0100
Message-ID: <CANn89i+tMOYBrdbPmZYP6LOd0q8h4FRZWCAbKL5u9_k4ce3pqg@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: use kvmalloc() in netlink_alloc_large_skb()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Zhengchao Shao <shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 24 Feb 2024 09:06:30 +0000 Eric Dumazet wrote:
> >  struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadca=
st)
> >  {
> > +     size_t head_size =3D SKB_HEAD_ALIGN(size);
> >       struct sk_buff *skb;
> >       void *data;
> >
> > -     if (size <=3D NLMSG_GOODSIZE || broadcast)
> > +     if (head_size <=3D PAGE_SIZE || broadcast)
> >               return alloc_skb(size, GFP_KERNEL);
> >
> > -     size =3D SKB_DATA_ALIGN(size) +
> > -            SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > -
> > -     data =3D vmalloc(size);
> > -     if (data =3D=3D NULL)
> > +     data =3D kvmalloc(head_size, GFP_KERNEL);
> > +     if (!data)
> >               return NULL;
> >
> > -     skb =3D __build_skb(data, size);
> > -     if (skb =3D=3D NULL)
> > -             vfree(data);
> > -     else
> > +     skb =3D __build_skb(data, head_size);
>
> Is this going to work with KFENCE? Don't we need similar size
> adjustment logic as we have in __slab_build_skb() ?

Note that the 2nd argument of  __build_skb() has not been changed by my pat=
ch.

 SKB_HEAD_ALIGN(size) =3D=3D SKB_DATA_ALIGN(size) +

SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

I do not expect kfence being a problem here ?

Either data is vmalloc, and the patch is a no-op,
either it is kmalloc(), and __build_skb() does nothing special,
kfence magic already happened.

>
> > +     if (!skb)
> > +             kvfree(data);

Note that skb->head at this point must be equal to @data

> > +     else if (is_vmalloc_addr(data))
> >               skb->destructor =3D netlink_skb_destructor;

