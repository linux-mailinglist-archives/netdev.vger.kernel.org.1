Return-Path: <netdev+bounces-115926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E1948683
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D936284B9E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34B382;
	Tue,  6 Aug 2024 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jX9OZ3up"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3044A05
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902838; cv=none; b=p5B9Lb7GGK8lis8IeZO9snln1hVo5W8r/R5AFH2WfVNmzAep0Q7l693C8AXNEVa9CBi0vgX8yLo+Yn3aM8w1ULy5iu5YDjv56/ZVtIQngEbvTbXvr7izJJSPli7Vh8dtsARYjhpW+PervcdsQcrDdq4Hc8qfC1O2zvZKQaLM+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902838; c=relaxed/simple;
	bh=hPNkYg6hobsvfnetbWCfaJdSwmZREGaq/FYk+XTXGfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqAKHJC7F8IYLvtghjLdcmliNopoR/J00LmEhm8VCXNBLo3X8zf7SpFddFNN4CxUiLH9wDAxMVMSrPca71FgE4Ew9d2eK10yBNgQbiYCgzkBqRjegxq1ogsTjGR3oQ4ewOqdynlpJShELrNBUQeXAGvyd1Y/D33N0eQl5ih4JnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jX9OZ3up; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684eb5be64so97317f8f.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722902835; x=1723507635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87e9dDRpLjDrghC9wwQL6cwF7qJh27NT+d0X+TLlZfQ=;
        b=jX9OZ3upKqYczzEvJ/B1rFLC7Ppx5rdlh12zYDNlGLVsJ+WGm8Dhn3UpA3TunVGOgn
         ELkP2UpJWcMGLezJyDTC23MqmwWuU7463FjR3thW/gooYRQXlfpImhCuShTflaNTO5oI
         qVfROqRf/5c6OJj2C5Tx4hV16z2JnyESucoF5PYjQhTSuc/74FOh3uohOdEyImh74jWU
         1moQ+QdXezlmybvh8B6oYGSnuNQW5Br0SMCzgwUtiX+1vKn22edfl7auy8Q64JaH1uH6
         l8+mQ4BBR855+TqyT4ANdTOmFN09Q36Q26yBHdW4ISEPF5X5o7JdBVTGTwnINoOw6JDS
         1pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902835; x=1723507635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87e9dDRpLjDrghC9wwQL6cwF7qJh27NT+d0X+TLlZfQ=;
        b=RQVOgo8YHG/qDzvf8X7CJJo5pDAG5UB4grOyhrfNYru+EGRQ1+c+PXYlWOuxFNU6qi
         Zkmp7BwuTyMcexecTbJpz1Og5aUJjoSYvOPZfSgCclXmYGcyWQHFpke//JbzBwcN2c/g
         X//oLzbQL5sFh+SGW1dZ1ZWMCC2uIaIoPeKf3NT5vabSr3nYvZ6xkzDEMwZv0Fp+PV6S
         miEmdMG2XALdZRRw3gcLEbXdOAoilNt6JzgvYT80k6BIV59Slxg3dnF2XH4NxuDSVRbR
         nTeloPK/7/JxRPAXZ/0l50CDcex4/+UI8fVPi1aRLbWEF6GVa+isRWCR5h1aoa+DO4Ej
         j/2g==
X-Forwarded-Encrypted: i=1; AJvYcCV9FN6Gw4uwyoU7nA5Iza4xKIk1SP611+GYh5oaLNZPSoZ8dCZq/J0ytkXdEh3Om3n68XJq+3hQnEa2e29E/YHhAWn1MH3R
X-Gm-Message-State: AOJu0YxSOzgC8Rf7t4ENfWd1RzDA10BKa91fAf6JR/ygxRemYoqh4sKZ
	Dv9rYFEj9QVC80GESXTZx/gxMMB4ytXpj9Bh7vnF/AFUca94HZLK8FG47zpR+5dJzfN/Pu0v6cu
	AsvJPJn7o3d/FToY8lk1QO+wyub44o9x+5wm9
X-Google-Smtp-Source: AGHT+IEygNnHNVm8OsgpjCmZvqm0Qw/28HPn0Ql8UJtntIWeV6HlB8Mlh/ORJsTesm39oK/PeD2R4egzHglwOTQRgjI=
X-Received: by 2002:a05:6000:154f:b0:368:64e:a7dd with SMTP id
 ffacd0b85a97d-36bbc1d2278mr10281389f8f.53.1722902835130; Mon, 05 Aug 2024
 17:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802012834.1051452-1-pkaligineedi@google.com>
 <20240802012834.1051452-3-pkaligineedi@google.com> <20240802162131.0eb94666@kernel.org>
In-Reply-To: <20240802162131.0eb94666@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Mon, 5 Aug 2024 17:07:03 -0700
Message-ID: <CAG-FcCNN18PGVaRXysnOBk75vQDOq2g1LzEcBAMq2cpa_M85Ow@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] gve: Add RSS adminq commands and ethtool support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	jeroendb@google.com, shailend@google.com, hramamurthy@google.com, 
	jfraker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  1 Aug 2024 18:28:34 -0700 Praveen Kaligineedi wrote:
> > +static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh=
_param *rxfh,
> > +                     struct netlink_ext_ack *extack)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(netdev);
> > +     struct gve_rss_config rss_config =3D {0};
>
> I never remember the exact rules, are you sure this is the one that
> is guaranteed per standard to zero all the fields?
>
I didn't find specific rules for standards older than C99, but looks
like this should be supported for all standards.
https://stackoverflow.com/a/63356270. Also there are multiple drivers
using {0} to zero the struct now, so I think it should be good?

> > +     u32 *indir =3D rxfh->indir;
> > +     u8 hfunc =3D rxfh->hfunc;
> > +     u8 *key =3D rxfh->key;
> > +     int err =3D 0;
> > +
> > +     if (!priv->rss_key_size || !priv->rss_lut_size)
> > +             return -EOPNOTSUPP;
> > +
> > +     switch (hfunc) {
> > +     case ETH_RSS_HASH_NO_CHANGE:
> > +             break;
> > +     case ETH_RSS_HASH_TOP:
> > +             rss_config.hash_alg =3D ETH_RSS_HASH_TOP;
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (key) {
> > +             rss_config.hash_key =3D kvcalloc(priv->rss_key_size,
> > +                                            sizeof(*rss_config.hash_ke=
y), GFP_KERNEL);
>
> key is a bitstream...
> IOW this code is like allocating a string with
>         calloc(length, sizeof(char))
> :S
>
> But what is the point of the allocations in this function in the first
> place? You kvcalloc here, copy, call gve_adminq_configure_rss()
> which dma_alloc_coherent() and copies into that, again.
>
Thanks for pointing it out. I will send a V2 to avoid the extra copy.

