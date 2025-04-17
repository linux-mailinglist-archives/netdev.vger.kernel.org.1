Return-Path: <netdev+bounces-183615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A53AA914A5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6DD3B20E2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559621D58F;
	Thu, 17 Apr 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jARW79Rp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA521D011
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873083; cv=none; b=qeNGHjrRPbQU2G2BgCgV6fgVh0tEvaDQ0neRhxVxSfrH1Z/qEiGVbZHbCAH25o8zNjMQXF0ZgKqrXAmM23CqZu3V7mcJ4mnK6qEXP9TAAimsZr9AFKIrKhFWOQgvnO6SK2FyrFyiyvFGWoHtf98gJfIDfHYd6kl5KElS86WR4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873083; c=relaxed/simple;
	bh=mhEAq0m1xvN7q2dDhQg6t9qlEIRwcQcUSWfYwijYQPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KviyvU7l+4XMifT0kc6my7Kbtu4EO5glnVagEo5YjKvUl3+m0ZSazPcU1fRrpPz9GP2tseqm3SSfALk+ViS5VJc7pMcXLz6nEFxZf3RolVSIpJSNbsT8T57WyfT0ApRqByqFPP5U620Xb9ZTOB6f1IN1DMcpmiQIXcbPzwX2Dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jARW79Rp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso803422a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744873079; x=1745477879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH75KHFecluyByKmLplzLLaVbiqXvYH0Wz/IWG30DT8=;
        b=jARW79RpRzH8rwiVK66s3dGt1skfECACodnLFDFZFFaDBgOSEwaOkYbHlIcQnRrOvy
         8iq56YZ+V80gQ9iA24IioRIAdAObZqcydjIu8tjfq1fVvwg6oKNj4ezCPnUtSWENo8CW
         tGtlX3QlCU/w8aACn0WH7mcQ+6JDeztAX08Q+L37Ts3MRXNLam1Tq+O0YBn6KyIxXze0
         vQLPx1A+YUQ9U4Zh4nPSF7hfgcTpk7PwBJfyLAT5gIwXDUT9sB6qKOYkhSECdcpqUObq
         NMksw+GX4mxpQwOIvx6RuB7hMv+HtXkiKH1rSGAEDLWpTOGqKaUAYzGf+V77Dlm3RP5P
         SeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744873079; x=1745477879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH75KHFecluyByKmLplzLLaVbiqXvYH0Wz/IWG30DT8=;
        b=IcNuJi0Mxk5p/V2egRgz2GMP4f1ZbstIxbbhCIPsIPamNa3WbZDgjqOsrrQsXl2RHv
         etOTaJ+oNB+CMs4H/iAT2MAhcDx4mP1GePDCTt4Apq3oOgrEro0FaL9QJZhTG1ku8AVg
         OeHiz9Pqz39/iLe4bh2mALqO0ZbfWBtrDTPOMzD0nXMjAgsNwucTAtehnHmwidcG33FN
         6KDgjwcv+kSDxhseeChlztNt4fEOXti+QKJlwYdxZAg8u8lWbtDu74MCtKuvWJE6haLd
         9DtcZZTxsQLX0KKMa3UWHTBcI6cWej4Qur0EixRpnwmCDi9OPDAT+dWlj+EqcpzWB4k6
         0Gkg==
X-Forwarded-Encrypted: i=1; AJvYcCWfndnGF8/lYPCINofhfco6xwne0QMWoYyJqdkg6c/MchiYqdxRzxeB6vz95CMbs0ceQPx8wpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZVZlRugni456QbxuB/F8e2OvsyC5SKiezRni52EEcLfmXYoQ
	xv5+2z0eXp8l1QvEXgMAHHaD0kSc/Q11iGzhqRKVP8deWtdJ2w5yj+KqEfRik0TXcH3S75fYLSU
	psTycC7yrYQ8HLjO8nj5qQcmZ3Uk=
X-Gm-Gg: ASbGncvUr38QUlmXEk3zQq4O0tSfldp6DwGS/0oT1UCActYhSYYcq94SvOCcLyNsdPz
	RzrdmAiKKLMq25iJ4z3zbpFQCQzy15Fme3cE4anoXDpJ32ZYa0WvCxk7UGhjPvvpqEHNaZiZmOP
	ih8CctWPtjK0lsL4d6iQsS+8AH
X-Google-Smtp-Source: AGHT+IFh4yOOI2vGQZZtA2Fw/BgTcLAKMk/ns7pNOqI1leNGSZaa95uJQ22wjFlwnloGe8yjBrK5Q9PU4miQTfZz8BU=
X-Received: by 2002:a05:6402:1913:b0:5ee:498:7898 with SMTP id
 4fb4d7f45d1cf-5f4d18aff48mr1468374a12.17.1744873079099; Wed, 16 Apr 2025
 23:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
 <CAMArcTWFbDa5MAZ_iPHOr_jUh0=CurYod74x_2FxF=EAv28WiA@mail.gmail.com> <20250416173525.347f0c90@kernel.org>
In-Reply-To: <20250416173525.347f0c90@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 17 Apr 2025 15:57:47 +0900
X-Gm-Features: ATxdqUFkk_b8C_XCX9oOX72PmNEyDfRZjGzK2CxE2kavhWxCLX2wcZYzgvf_mPA
Message-ID: <CAMArcTXCKA6uBMwah223Y7V152FyWs7R_nJ483j8pehJ1hF4QA@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mina Almasry <almasrymina@google.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 17 Apr 2025 00:01:57 +0900 Taehee Yoo wrote:
> > Thank you so much for a detailed guide :)
> > I tried what you suggested, then I tested cases A, B, and C.
> > I can't see any splats from lockdep, kasan, etc.
> > Also, I checked that bindings are released well by checking
> > /sys/kernel/debug/dma_buf/bufinfo.
> > I think this approach works well.
> > However, I tested this simply. So I'm not sure yet about race condition=
.
> > I need more tests targeting race condition.
> >
> > I modified the locking order in the netdev_nl_bind_rx_doit().
> > And modified netdev_nl_sock_priv_destroy() code looks like:
> >
> > void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
> > {
> >         struct net_devmem_dmabuf_binding *binding;
> >         struct net_devmem_dmabuf_binding *temp;
> >         struct net_device *dev;
> >
> >         mutex_lock(&priv->lock);
> >         list_for_each_entry_safe(binding, temp, &priv->bindings, list) =
{
>
> Not sure you can "for each entry safe here. Since you drop the lock in
> the loop what this helper saves as the "temp" / next struct may be
> freed by the time we get to it. I think we need:
>
>         mutex_lock()
>         while (!list_empty())
>                 binding =3D list_first..
>
> >                 dev =3D binding->dev;
> >                 if (dev) {
>

Thanks. I will try to use that you suggested.

> nit: flip the condition to avoid the indent
>
> but I think the condition is too early, we should protect the pointer
> itself with the same lock as the list. So if the entry is on the list
> dev must not be NULL.

Yes, I think it would be okay to remove this condition.

>
> >                         netdev_hold(dev, &priv->dev_tracker, GFP_KERNEL=
);
>
> I think you can declare the tracker on the stack, FWIW

Okay, I will use stack instead.

>
> >                         mutex_unlock(&priv->lock);
> >                         netdev_lock(dev);
> >                         mutex_lock(&priv->lock);
> >                         if (binding->dev)
> >                                 net_devmem_unbind_dmabuf(binding);
>
> Mina suggests that we should only release the ref from the socket side.
> I guess that'd be good, it will prevent the binding itself from going
> away. Either way you need to make sure you hold a ref on the binding.
> Either by letting mp_dmabuf_devmem_uninstall() be as is, or taking
> a new ref before you release the socket lock here.

Thanks Mina for the suggestion!
What I would like to do is like that
If binding->dev is NULL, it skips locking, but it still keeps calling
net_devmem_unbind_dmabuf().
Calling net_devmem_unbind_dmabuf() is safe even if after module unload,
because binding->bound_rxq is deleted by the uninstall path.
If bound_rxq is empty, binding->dev will not be accessed.
The only uninstall side code change is to set binding->dev to NULL and
add priv->lock.
This approach was already suggested by Stanislav earlier in this thread.

This is based on an inverse locking order from
priv lock -> instance lock to instance lock -> priv lock.
Mina, Stanislav, and Jakub, can you confirm this?

>
> >                         mutex_unlock(&priv->lock);
> >                         netdev_unlock(dev);
> >                         netdev_put(dev, &priv->dev_tracker);
> >                         mutex_lock(&priv->lock);
> >                 }
> >         }
> >         mutex_unlock(&priv->lock);
> > }

