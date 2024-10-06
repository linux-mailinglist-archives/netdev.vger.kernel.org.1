Return-Path: <netdev+bounces-132530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2099207F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9E01F21694
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19618A6AA;
	Sun,  6 Oct 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD/XbXKf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A6320B
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241129; cv=none; b=jS4oDb6o/dQ7LOtWwCpwLwHmr5AkwbDp6b+jToA1ZsZ5rgwNizjk+bbC392qSe/nQRUGKHZ+GHE6DWCNEsqdhUNE95688nUYUnlVa1PBlQxz+KS7dsVIjDWLQTv+9b1xQhvG9cDg3YdpHbOzA8l5RhpTA1FY9ZTF+3fXqg+aRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241129; c=relaxed/simple;
	bh=0TqNAPG8laE1uyVYQXjNTF6m82JcAQP4lFRuHi+PEvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNHHRRKQnvusvTLukwn80Jc2oyMplBwm8ae8PCFU7ZtkefOPKk4CmsRtVyRZ3oO3L2encz9c8U7k1/40j/lOZutHURnoHtIn6/hJwbRhAzKN1qMNAnlduCjORuw21njy1AKUnWPicAxPKrweqgvWbqv5Lba3A9Gf9TJ/CYwuxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD/XbXKf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so438888666b.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728241126; x=1728845926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vprB2WDxqemi4ZH8WwqIh0DGGmx9lr1o5ssCURSxxWM=;
        b=lD/XbXKfGtk4GWw1U3U8+/PTqz0zZxJ3MunL7Wajf2aRVa7LgtiVhqJ0fwQtUrjQ3D
         LiNIArdzFoXInS/qvuZtod59iXPU67GOEvM2mNbBj0u5YLaeUpQQOteSECTMyocRb1Dm
         1xlh04vqIh4J30iKpK1xsJjlj3c2EymvckQduPs0V1e8mcwn8MqgcAkB3D1G9EqXZWAy
         jy7EWt+nqXGakdP0Nx0epFY70bHAfy+IDz160N/i3MxwHW0p8YfVwI54PUrKWsCqInvU
         5znA/+94rgsCTd2ggJEdCXCPCYcJw0gSJ9OqKDh4kXCPYMXxWHvTkVtBNsJJa2ERXpWz
         hjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728241126; x=1728845926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vprB2WDxqemi4ZH8WwqIh0DGGmx9lr1o5ssCURSxxWM=;
        b=fu18ykahInoUTUGV0eaCY5RBaBQ7woC5bqvIXHFVLTaIHKnyfLzOBUXsU2KObQnFOJ
         RE8Yb5hAs52dmZilMUQwI0R2PwqwEq1a/6mdNqK3YVIklT7GsAcELpfUzbZd7Gbr+ksa
         d/3l2WbpOkZC9ijogO41XPuRvRvVLHkGHdEd9OGHB7LOSuuzpbHMVrggfQIGFXRuSVs6
         Hy7hsewnFSTrtprmzdmu1PHI9EJnTYNp6nTt9YqoiYOc9AgbyX+uVJOH6tJqpZMbaZJq
         cIr8BnouXswY/9qmqo7LZxDJKTJZ4+JaD3V/VTyp1y8MPdjYCLtvz3X6EuF8QLUwO2ce
         M8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuv0kbTNPI0kBUXzQGVRrA4/COWsoY4bzwT6pDMXEbmXYob7aDmjlwvEmlwmvfLPhnAbl2ZJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ohyTO+G822ihkSaDrXHufBET+lirZBb8i7fPJrFhpIt3bR7I
	CiFaP3g6bpkXNY8AQmGMQflOy73GE3U/9+PaHd/SpIZyrJIYQUf3PvtRd9n6s9N4xoYnTYTN4pe
	0Ny0AhnbfFmUw1JKcnOt5Cil+kO4zDoJrUfZV
X-Google-Smtp-Source: AGHT+IG0S94gzwLfasbSNf2NETOTvaK2CP62HiACmuLwwiYeeZRTyrtgvdvsV3AUJRQRmf0lpJqb3Cb/56a7O6ucS74=
X-Received: by 2002:a17:906:c10f:b0:a99:4162:4e42 with SMTP id
 a640c23a62f3a-a994162606bmr489016466b.37.1728241125532; Sun, 06 Oct 2024
 11:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
 <20230903005334.5356-1-hdanton@sina.com> <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
 <20230905111059.5618-1-hdanton@sina.com> <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com>
 <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com> <CADvbK_fxXdNiyJ3j0H+KHgMF11iOGhnjtYFy6R18NyBX9wB4Kw@mail.gmail.com>
In-Reply-To: <CADvbK_fxXdNiyJ3j0H+KHgMF11iOGhnjtYFy6R18NyBX9wB4Kw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Oct 2024 20:58:34 +0200
Message-ID: <CANn89iKrLE69O+qOuhGG0ts2zmxJzw5jAAFLfzspi8uOQe8pQw@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To: Xin Long <lucien.xin@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Hillf Danton <hdanton@sina.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Netdev <netdev@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 8:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> Sorry for bringing up this issue, it recently occurred on my aarch64 kern=
el
> with blackhole_netdev backported. I tracked it down, and when deleting
> the netns, the path is:
>
> In cleanup_net():
>
>   default_device_exit_batch()
>     unregister_netdevice_many()
>       addrconf_ifdown() -> call_rcu(rcu, fib6_info_destroy_rcu) <--- [1]
>     netdev_run_todo()
>       rcu_barrier() <- [2]
>   ip6_route_net_exit() -> dst_entries_destroy(net->ip6_dst_ops) <--- [3]
>
> In fib6_info_destroy_rcu():
>
>   dst_dev_put()
>   dst_release() -> call_rcu(rcu, dst_destroy_rcu) <--- [5]
>
> In dst_destroy_rcu():
>   dst_destroy() -> dst_entries_add(dst->ops, -1); <--- [6]
>
> fib6_info_destroy_rcu() is scheduled at [1], rcu_barrier() will wait
> for fib6_info_destroy_rcu() to be done at [2]. However, another callback
> dst_destroy_rcu() is scheduled() in fib6_info_destroy_rcu() at [5], and
> there's no place calling rcu_barrier() to wait for dst_destroy_rcu() to
> be done. It means dst_entries_add() at [6] might be run later than
> dst_entries_destroy() at [3], then this UAF will trigger the panic.
>
> On Tue, Oct 17, 2023 at 1:02=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 5 Sept 2023 at 17:55, Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Tue, Sep 5, 2023 at 1:52=E2=80=AFPM Hillf Danton <hdanton@sina.com=
> wrote:
> > > >
> > > > On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.com=
>
> > > > > On Sun, Sep 3, 2023 at 5:57=3DE2=3D80=3DAFAM Hillf Danton <hdanto=
n@sina.com>
> > > > > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@googl=
e.com>
> > > > > > > --- a/net/core/dst.c
> > > > > > > +++ b/net/core/dst.c
> > > > > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > > > > >
> > > > > > >  void dst_release(struct dst_entry *dst)
> > > > > > >  {
> > > > > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > > > > +                       dst->flags |=3D DST_NOCOUNT;
> > > > > > > +                       dst_entries_add(dst->ops, -1);
> > > > > >
> So I think it makes sense to NOT call dst_entries_add() in the path
> dst_destroy_rcu() -> dst_destroy(), as it does on the patch above,
> but I don't see it get posted.
>
> Hi, Eric, would you like to move forward with your patch above ?
>
> Or we can also move the dst_entries_add(dst->ops, -1) from dst_destroy()
> to dst_release():
>
> Note, dst_destroy() is not used outside net/core/dst.c, we may delete
> EXPORT_SYMBOL(dst_destroy) in the future.
>
>

Current kernel has known issue with dst_cache, triggering quite often
with  selftests: net: pmtu.sh

(Although for some reason it does no longer trigger 'often' any more
in my vng tests)

