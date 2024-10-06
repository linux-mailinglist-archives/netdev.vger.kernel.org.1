Return-Path: <netdev+bounces-132531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91217992086
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5312816AB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690318A6B0;
	Sun,  6 Oct 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ys7S/UoM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFF2572
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241460; cv=none; b=N7ZGTJI6FnlupZuJ1HotD0daH2WCqVcMGDU3mjH+oOpEByBzzeuFR2u4h8KmK0iXj5RE0v8sWBdbBUc1fOOxBX0d2rliJkj14czyH4QYY3mathEu7Xd5qtokxMMnbpFj194bOgcd3jLGha5xNMjcOsRgxUV977ZVMScVOOL46gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241460; c=relaxed/simple;
	bh=HNrFd/PGUU8WcSrRQfH4Vzosl/k3lpvVnsKnl7wZPAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMiMfr3nNfmEHW4u0DkGrHQZhI2CHWPBTSd1LmEIedo8AAu/9k45i81ie6cqOijl6TGcqh0DxOP20iddnsZAAiAqCT3Jll219l6TUavjxfemPb0P7ybrl7Y2wXNn1yTZA1OhdyGmq9l4/IzA773zcc4ESr30Q5Cg7gN3W7xeyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ys7S/UoM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9939f20ca0so222044266b.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728241456; x=1728846256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fw0XseSH+Ve6ONa8vMAg4AER4YN4R6MDRkWml4yhFY=;
        b=Ys7S/UoMx8JnvgOEZTvvdKqhw7eVbxRc2E7uts2B1UAerBRo0hlhXWXTgkARu987+l
         ORYBzdi1jr3//xj1TAG3uM5rJUg9UAju7ko7stFR6Y5czjsfshLP1gSmPw3FxysUNl7V
         dMojuOmAoQB4m8zjyJadAtjl6lvt8HPwKDpFKoxtrMn0iGTrgidR994SMD1EXITtrP2U
         54Ee+Wqwci4kjiM11gclyL1cOYxiqRlFowlpdL4y9HGRh7dTwW8hGmsZer8WVfK3RTiG
         K379UoWHjbYWHz9yPYhMNkONAAYC6Fz1pjSsMG53b0ZCJbsj1wQ69ewk6lZcIsdB9Wwk
         FgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728241456; x=1728846256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fw0XseSH+Ve6ONa8vMAg4AER4YN4R6MDRkWml4yhFY=;
        b=nhHWIh1Q6yKoPTk1GcLOix/LARFsx5ga0XdCigY0N/Q4B5OpVYA+YWmvARUsbe2GqO
         p76WmRMxgVHC+1UnpjhTgupwoEmjXv4XRJIUADtIngJ1c82iymnw+wz9Kj84OW5iBOI1
         RLEQgd0VToIwxBXaoMCcwmzujzE+q7jzdq8AmUbs+mIGiKaeIWkkRpqW1Vivl6cABEwG
         pmjL+OrxLSULkFR4iu2m9K0PCgbSabUUqL6QxAhA2eCDtK9JP4gbC3kICD2FFKNaJSVu
         1XQyQC7KW5mZeKmNTkb2ptLWJzIs9bkV4y+G7BPT8UjdnWpyrvcowWBU8C2qkphhFJlp
         JwSg==
X-Forwarded-Encrypted: i=1; AJvYcCWn8FQuhCYkXjNyQk9UM08XTV9CZ3EwlwkejqoRXKFzN9nxZujIv0ufiGSqPztNxQe3pIqsrCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEJCfGupbVV/Fkyg05GZ+1ncegGcP/jRyqBDb3OAJ92ZsQekC
	dFsPuMiEOUedtnd7tyJuxRfq1Mpq8IXOaOyNK6NAJAx2x0Ky5LwKkrnjk03VNfGZ5cOydNTBQqD
	z9qEuBtgFwIJApVWfB/Ig0Sgh5mZe0tRATkKwK5K7CFwvMGrCYV1e
X-Google-Smtp-Source: AGHT+IHLi6qgIbcAhmZ5d9BCterOP5EmT7+vJQipve8Oi/uMqinOIKtDjFyL2Zu250Y+Zrqg2kN+S6ARzBNQzVax93o=
X-Received: by 2002:a17:907:3f87:b0:a99:4e2e:6f58 with SMTP id
 a640c23a62f3a-a994e2e76dfmr296639666b.35.1728241456228; Sun, 06 Oct 2024
 12:04:16 -0700 (PDT)
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
 <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com>
 <CADvbK_fxXdNiyJ3j0H+KHgMF11iOGhnjtYFy6R18NyBX9wB4Kw@mail.gmail.com> <CANn89iKrLE69O+qOuhGG0ts2zmxJzw5jAAFLfzspi8uOQe8pQw@mail.gmail.com>
In-Reply-To: <CANn89iKrLE69O+qOuhGG0ts2zmxJzw5jAAFLfzspi8uOQe8pQw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Oct 2024 21:04:05 +0200
Message-ID: <CANn89i+WVuDascBvduzCK=-WYSdkcc6hy+_XmH+kxHwSf_6bSQ@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To: Xin Long <lucien.xin@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Hillf Danton <hdanton@sina.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Netdev <netdev@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 8:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sun, Oct 6, 2024 at 8:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
> >
> > Sorry for bringing up this issue, it recently occurred on my aarch64 ke=
rnel
> > with blackhole_netdev backported. I tracked it down, and when deleting
> > the netns, the path is:
> >
> > In cleanup_net():
> >
> >   default_device_exit_batch()
> >     unregister_netdevice_many()
> >       addrconf_ifdown() -> call_rcu(rcu, fib6_info_destroy_rcu) <--- [1=
]
> >     netdev_run_todo()
> >       rcu_barrier() <- [2]
> >   ip6_route_net_exit() -> dst_entries_destroy(net->ip6_dst_ops) <--- [3=
]
> >
> > In fib6_info_destroy_rcu():
> >
> >   dst_dev_put()
> >   dst_release() -> call_rcu(rcu, dst_destroy_rcu) <--- [5]
> >
> > In dst_destroy_rcu():
> >   dst_destroy() -> dst_entries_add(dst->ops, -1); <--- [6]
> >
> > fib6_info_destroy_rcu() is scheduled at [1], rcu_barrier() will wait
> > for fib6_info_destroy_rcu() to be done at [2]. However, another callbac=
k
> > dst_destroy_rcu() is scheduled() in fib6_info_destroy_rcu() at [5], and
> > there's no place calling rcu_barrier() to wait for dst_destroy_rcu() to
> > be done. It means dst_entries_add() at [6] might be run later than
> > dst_entries_destroy() at [3], then this UAF will trigger the panic.
> >
> > On Tue, Oct 17, 2023 at 1:02=E2=80=AFPM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 5 Sept 2023 at 17:55, Eric Dumazet <edumazet@google.com> wrot=
e:
> > > >
> > > > On Tue, Sep 5, 2023 at 1:52=E2=80=AFPM Hillf Danton <hdanton@sina.c=
om> wrote:
> > > > >
> > > > > On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.c=
om>
> > > > > > On Sun, Sep 3, 2023 at 5:57=3DE2=3D80=3DAFAM Hillf Danton <hdan=
ton@sina.com>
> > > > > > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@goo=
gle.com>
> > > > > > > > --- a/net/core/dst.c
> > > > > > > > +++ b/net/core/dst.c
> > > > > > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > > > > > >
> > > > > > > >  void dst_release(struct dst_entry *dst)
> > > > > > > >  {
> > > > > > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > > > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > > > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > > > > > +                       dst->flags |=3D DST_NOCOUNT;
> > > > > > > > +                       dst_entries_add(dst->ops, -1);
> > > > > > >
> > So I think it makes sense to NOT call dst_entries_add() in the path
> > dst_destroy_rcu() -> dst_destroy(), as it does on the patch above,
> > but I don't see it get posted.
> >
> > Hi, Eric, would you like to move forward with your patch above ?
> >
> > Or we can also move the dst_entries_add(dst->ops, -1) from dst_destroy(=
)
> > to dst_release():
> >
> > Note, dst_destroy() is not used outside net/core/dst.c, we may delete
> > EXPORT_SYMBOL(dst_destroy) in the future.
> >
> >
>
> Current kernel has known issue with dst_cache, triggering quite often
> with  selftests: net: pmtu.sh
>
> (Although for some reason it does no longer trigger 'often' any more
> in my vng tests)

Simple hack/patch to 'disable' dst_cache, if you want to confirm the
issue is there.


diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 70c634b9e7b02300188582a1634d5977838db132..53351ff58b35dbee37ff587f7ef=
8f72580d9e116
100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -142,12 +142,7 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);

 int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
 {
-       dst_cache->cache =3D alloc_percpu_gfp(struct dst_cache_pcpu,
-                                           gfp | __GFP_ZERO);
-       if (!dst_cache->cache)
-               return -ENOMEM;
-
-       dst_cache_reset(dst_cache);
+       dst_cache->cache =3D NULL;
        return 0;
 }
 EXPORT_SYMBOL_GPL(dst_cache_init);

