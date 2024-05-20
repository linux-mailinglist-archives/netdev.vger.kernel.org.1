Return-Path: <netdev+bounces-97212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5E8C9FBF
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AA1B21032
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07523136E34;
	Mon, 20 May 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqWxs3WW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F413FC01
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219256; cv=none; b=T0+Nknf76fW5HbZfBjBrKbMsTp891/iwUB/vdkRgNBTzmuvLvbuG00AKXafegmEaQSzJo/9sWBqVvxxA3E2juhIDwIs/SJLnIqS4mLfEIAG8HBCodi+IfaUaz24I1deBDzETVl56UNGh4DVn2sRrIrB3DsW57OctLqTuniEObDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219256; c=relaxed/simple;
	bh=MmDHNVUVr1JatqfvE2aayNYn7QYD6UQdZH/Y2URMT+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vj8MTTy6afHML3yrkmmIK/4wYF+F6vZ1iuZ8WRg8ED7eVxAUWq/J+9hBoYYiKzUsH0F88Kd7Evcl7jsO4jwuTdlHponKKoBZro8mLVEe0/Nyv1lg7Ngqu9SUrcHA13TTu6cIBMaqbIW+cCEg6gznmpfAljWvzKd7fWhqblgyfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqWxs3WW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso12768a12.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716219253; x=1716824053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmDHNVUVr1JatqfvE2aayNYn7QYD6UQdZH/Y2URMT+Y=;
        b=dqWxs3WWDWcQbuPuWwwu4U5ocghXvzZAVC0/x4/Ro3fAm21FJVwy4P6J9947qNK2QS
         KSb1QjmRJBwAWo1KKN3Xkejn/36/RIJY2nuqB4XwCycvrMv7+klmIT92s1wFu14VpXt5
         XpeXAeyxMPdpMroMOLxTStSJm+rw6bCwOD5eEiuEEcr+mVgpQHoCSkv3d92gZvuCWslw
         nPg0gHqf9M1Kqqc1ZRmJDpJ86WvpNH/ePeQHIZIdK8sKKqj1s4K+QuX1DAE5DL9GQb8u
         t5mZU7rT6s8LQ5+gseOOUH4oY91LoNwHqZZpION8rwV2Ra8JJ4iukh2zYiCJuwQH292F
         b07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219253; x=1716824053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmDHNVUVr1JatqfvE2aayNYn7QYD6UQdZH/Y2URMT+Y=;
        b=Sx2TOMVTO4TiWhaBSlVdOfzO1EzMXi6lq8+4HK30drhtuRHaMNmxYhV5zNrLEFK4Vk
         xc6YYO4lEIp/uXhBlvns37DuZYJfkUumofhjRbAH4YLTTdxOp/96sVBQqfVaRd1hkgNX
         cL6RggXlxJlqpVfOHJI1ABaWSsLp5VKmoJqB3DJtFiQV/Nb4f4oqkQqD8De1Om84XKyA
         bhJVbzIcW/XobRNx3Q0US+u6/fKhikyyFdemPAHEbhTtK5nsyqQWu2I1PeP1bpU41Fw2
         QTNjSOWET8080uPvzrXf4fXfy3ziy79IyEPR8iaxO2fQZA9+6OrO+E9IUHidKXMWak+/
         KYuA==
X-Gm-Message-State: AOJu0YyYj9WUXDJRmMdi+ROZJEX4QqNHXFkXTThZPyE1FIB2b8dQbPwm
	ZKdDmGPGiXRk3DavqPr2w9DrFi0xgdgcPvLZ53PlddqfkVjge/rrpQD1oaGNVMCoNgxzVqHXrZh
	y60JZn4ZiN+79oDyccwuog81FQm8gK0Qm+y+qCePRkctbSI7KmFGL
X-Google-Smtp-Source: AGHT+IGDyc74/lQ8xJhUsviOgiOXhF9MFbfZgW9GOt5L5GOLMqz1PbXzxDOAym0A+3yeQy/VjbqcilEWBYUe7keWETg=
X-Received: by 2002:a05:6402:150b:b0:572:7c06:9c0 with SMTP id
 4fb4d7f45d1cf-5752a4268cemr353534a12.0.1716219253308; Mon, 20 May 2024
 08:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13bccadd7dcc66283898cde11520918670e942db.1716202430.git.pabeni@redhat.com>
 <CANn89iKg4p+ZgW36mKf-843QGydw0g_jxvti86QJOoxCyB0A8A@mail.gmail.com> <3410304ae2006ce9d8816429c2423591f8a9317e.camel@redhat.com>
In-Reply-To: <3410304ae2006ce9d8816429c2423591f8a9317e.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 17:34:02 +0200
Message-ID: <CANn89iKsTeDtiPQjLPYew_GodSG6JiQ+WNH-MrVrxRVj4CcOYA@mail.gmail.com>
Subject: Re: [RFC PATCH] net: flush dst_cache on device removal
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-05-20 at 15:54 +0200, Eric Dumazet wrote:
> > On Mon, May 20, 2024 at 1:00=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > Eric reported that dst_cache don't cope correctly with device removal=
,
> > > keeping the cached dst unmodified even when the underlining device is
> > > deleted and the dst itself is not uncached.
> > >
> > > The above causes the infamous 'unregistering netdevice' hangup.
> > >
> > > Address the issue implementing explicit book-keeping of all the
> > > initialized dst_caches. At network device unregistration time, traver=
se
> > > them, looking for relevant dst and eventually replace the dst referen=
ce
> > > with a blackhole one.
> > >
> > > Use an xarray to store the dst_cache references, to avoid blocking th=
e
> > > BH during the traversal for a possibly unbounded time.
> > >
> > > Reported-by: Eric Dumazet <edumazet@google.com>
> > > Fixes: 911362c70df5 ("net: add dst_cache support")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > I can't reproduce the issue locally, I hope somebody able to observe =
it
> > > could step-in and give this patch a shot.
> > > ---
> >
> > H Paolo, thanks for your patch.
> >
> > It seems dst_cache_netdev_event() could spend an awful amount of cpu
> > in complex setups.
>
> I agree.
>
> > I wonder if we could instead reuse the existing uncached_list
> > mechanism we have already ?
>
> Then rt_flush_dev()/fib_netdev_event() will use a similar amount of
> time, right? Or do you mean something entirely different?
>
> On the plus side it will make this patch much smaller, dropping the
> notifier.
>
> > BTW it seems we could get rid of the ul->quarantine lists.
>
> I think 'quarantine' is used to avoid traversing multiple times the
> same/already blackholed entries when processing multiple
> NETDEV_UNREGISTER events before the dst entries themself are freed.

But if we list_del_init(&rt->dst.rt_uncached), each handled dst is not anym=
ore
in a list.

ul->quarantine has no purpose (we never traverse it). Even kmemleak
does not need it, I think.

Note this is net-next material, just because I took a look after
seeing your patch.

> Could it make a difference at netns disposal time with many dst and
> devices in there?
>
> Cheers,
>
> Paolo
>

