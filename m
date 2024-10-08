Return-Path: <netdev+bounces-133103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B46994BEC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9838EB20B1D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E51DE3A3;
	Tue,  8 Oct 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTeiFA5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D364183CB8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391637; cv=none; b=MfQW74BH5Yq7LzxcanZOpz9Gn7kaLJ3EYOnJcj/cCnJjr/EB+J3uo9ssqL9eb/nnA3HTZw6AYJr0/koZI20FM5VIkQI+eSGtllUzygwwVjkgj8VWjaogMXmnpj1MNoHF3wePmMaMdAR9if/mnv+mZa936H2YJF7JMRmerS8PWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391637; c=relaxed/simple;
	bh=OcgUl6AxtIjr+qvFs98OfcZQB6DjipjZ9W7QLlv8vno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHIZZO7BtgCTe4zFNU8WTOOioIWc/ufqqZkPmJ2EDqCDYSR8eLctCMmx0p6r8MImyHNXYslDEZrBRPmOITRm4OL5E6S/yi9TaD66BjPmqQ7ttQesHXTEvnk8YKIY1tfFefjX6Y3JNPwtl4Z4Cje2whm3lELxjlHmv+HhbIX/w5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTeiFA5M; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so6530874a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728391634; x=1728996434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AZj4mSWxdQvLc3IIceeRNXHM4Bz2hFoj7c5V1+w6fw=;
        b=yTeiFA5MBXIgbhYEqhmQb1H+hnPOqYdGRkNpuJQ0alH52OSnmxNeqG0NspyRJUregg
         tqKdGl+ope1ayYw7dm4q0EWLxaRKGgZ4vpTR8InS1hFIZ3cJ0twBaqRfFDkUsp5Dnr0U
         0udIn1FEX39gAFYZzSydaNucVPqjZbXb6oUZDbwH21o9fS8nfZakIJe38uR4bLpcV/NA
         LnDXs94Ubxu6jfBQg06IFBo3ZeMc2Tsy1GUuQZjGZLQVG0rLNSgaAP+PrmINHa+7sf3K
         /WD+McuOfor51z1aEA0TIY3czbBNCVpQhAwoTP3qUQ3EWvkvPZJXQP0xdxc3qF110JWW
         bZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391634; x=1728996434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AZj4mSWxdQvLc3IIceeRNXHM4Bz2hFoj7c5V1+w6fw=;
        b=G0ELy1ItFMlPI+9ccEENYTUJMb6KIuC52vqYEpFQkO4UB8Aiythrp1knZkxNnYbPte
         4cKP2QpPLyVEm7//Yzi1MsrGb72/ZH9n/5rhQUp+veBYpatRvCPp8ED5Xsvvc6UYdsZ7
         6cTbORBmNd7VRyMRoHav478hmi3aItP+jGPEhJX9jWaxBg5zyW2tcR3N1FTilqAiE3pe
         7kUbIPXIkDTBo6b94Fa/HYKx8txtFKEsAP/8Hbq8GYHquc04R6GOda1VXFLrMn/4+rKe
         iz9nr0GlZJBpa7BDN/8AFpnATqcb7/tmTJZsLxig0Ux4jzXBo3acB2LG7p6lOAiHUJeA
         vhrg==
X-Forwarded-Encrypted: i=1; AJvYcCUzPy1nq4OznQoWUg/0jpZjKspQSZDJ8qWqgxHfnPUX5a9tdpegX7ibPHTONkanMa1QPLj1RYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjgHlFIdS6H3OYg9ghpjDo2VQWG+ne/fjSmoEyPTWQl/OV8mz
	O1zZSuWqRxVVni0PdBy7+hMC4BMqoHTqYmdtHcsqQuby7xVLonXlInDgZdOMO1Ji9BfimzoNck9
	7KzEe93qxUnEzAIvkoqZyJhiIjcgs2GYNtrO+
X-Google-Smtp-Source: AGHT+IF85dD7JaN/CC0IFqXbSSkWjOdAjTE69GjxbZuJ37iHmVY0wqA4eSL1ZRKSeoLjrczL2VUUVCZCjqlqulBV1MY=
X-Received: by 2002:a05:6402:2747:b0:5c8:df9a:749b with SMTP id
 4fb4d7f45d1cf-5c8df9a750emr10909813a12.28.1728391633387; Tue, 08 Oct 2024
 05:47:13 -0700 (PDT)
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
Date: Tue, 8 Oct 2024 14:47:00 +0200
Message-ID: <CANn89iJBUAC6-tKhU0C95+rB4fk_FJD2B_sQRbKnGAJ3KkG+FA@mail.gmail.com>
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

I am planning to send it soon.

>
> Or we can also move the dst_entries_add(dst->ops, -1) from dst_destroy()
> to dst_release():

If we remove the code from dst_destroy(), we must do it from its two caller=
s,
dst_release() and dst_release_immediate()

No big deal, I am adding a helper to make this a bit cleaner.


>
> Note, dst_destroy() is not used outside net/core/dst.c, we may delete
> EXPORT_SYMBOL(dst_destroy) in the future.

Which version are you looking at ?

Upstream got this already.

commit 03ba6dc035c60991033529e630bd1552b2bca4d7
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri Feb 2 17:37:46 2024 +0100

    net: dst: Make dst_destroy() static and return void.

