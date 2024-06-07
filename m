Return-Path: <netdev+bounces-101800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA490020D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0C31F26065
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CDC190669;
	Fri,  7 Jun 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNCK6r+F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FA190662
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759365; cv=none; b=opaSAjsEj2Ruur3GhGY/ajN8JIJmvRVl/fNObhm5JSERF1eeWLRt4Mz92RVBQcBlxeiaS5i4IBWlflomtH2w+c/NjVUKDO2bVlxh1SNhUcrb1vSvSoGKPqEbDnOt8Mt39TdmWNgfmd7hLFaeNa114vK2v2ABG2eujs3Y0rseYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759365; c=relaxed/simple;
	bh=Upz4RiLLWtkT9CH3fuydHOi5B6ipHJ6OVJUwdL5BG9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnQTExHkGQpRz3UPUDXHrLvSNR6v4DfsG5bmy/YNBPUc6q0oPAM0mIoW3G43cuXsvr/qNd22DGgv8xoqFp+LpVIEYq1UHVhfiafhna8TNW9L0Ye+z4JsHxZH0y3z6BpGeau6+vS2exMkWNoipHUe5MhAo6Gpko0YCotdxRfgyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNCK6r+F; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c5920ed3bso442158a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759361; x=1718364161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxNSiv0bWToch8vRIYw3I2Yt7g0qfD37HpIws5gP+EQ=;
        b=bNCK6r+F+5ua3PwUKACH9mtrJ9Qs5u0Uq63NzqcV2YmHO38BaWh97RYwSZ0PaUgbxW
         3OBfIQ0StLI4JP5mhfQbM7qSJwXyiK0cgiZS9kIlvme7dt+OpsBvTfGZ5el/uxLPgScM
         xO5tTlHwM2QnnJ9OOj/lJnyVHX1PEt2dNmu8dEaGM5+BkiVct+rBpxyse+JMWW6HA8dd
         7A41PIyh6gVz8OSOs6sqKq5dHODdphVJCMvVicsl4NZpD8u7TBwl7ibMzJMrzdV/Mvyl
         omwJ1lP09xPCm9654tHA8fr5Ct4wl6hJdXZIeeaBcDhPtCp+lm3lHPSiAs9ED9jjpZgl
         2zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759361; x=1718364161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxNSiv0bWToch8vRIYw3I2Yt7g0qfD37HpIws5gP+EQ=;
        b=niPAtQZXXdzsb7hadqDsF9LhtH9ntk40MHjMqVyNK3+pG4UWVPLFV0Zjv2PrOjGBq1
         T8oud8rv/BggikCJDd5xzskUGjXZbeuKAGyggbroK1FjCrYoXh2vlnyDMxUBLQyNakBK
         zwt06szzonC6Nzthen6dNCYv2fZRwWAQ09XKSn9NCCtW+/Q0oTBt72XTbnDkKImuVZqa
         M46K8Swbo+Ox/Yj1OUCMk+Vpjsoh6u8fYiqxbkt0lEf7Lz+7pqG0Qllha0km1nMDHOF2
         kc2KZLigGteR334ngL9jQUNwMCDlGk299sv+4bah2kVFdF1AxAgjumgspMd8pUO0gSG1
         iALw==
X-Forwarded-Encrypted: i=1; AJvYcCWJuaqLgMB/UcGb/OwBvo+baz30r7k/lBMPsCnfTtr9a6n428RZRVhIWPTXv0LCapSQQ5gE8//InzjkmHMtidEBr4bedcPz
X-Gm-Message-State: AOJu0Yxvto467HTtkGo3vsep7iBZXbOXOg4VxTCm/R18xvtqe9DXjA5+
	Yfhh9D9RvyuqkOljSveHBYbdv7a1YcrgWLiv5WRiPo69EH3Q72NyoHWCrDcftK7V/rNxzIpLyW5
	lMCjAsKtonqZk/BffUbN438Jv5J0=
X-Google-Smtp-Source: AGHT+IFl8WNNejbJBPSnM878qXzHJOSh1drIJWdih0hjfQVp/eOvbIsLzMksGRbMR4kJq3oF0DegXvPSo+XZyKi7tYU=
X-Received: by 2002:a50:c2d9:0:b0:57c:5fc8:c95d with SMTP id
 4fb4d7f45d1cf-57c5fc8ca83mr575351a12.18.1717759360518; Fri, 07 Jun 2024
 04:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
In-Reply-To: <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Jun 2024 19:22:02 +0800
Message-ID: <CAL+tcoCRSCvbwxNibDu7MdWXF77qjROd1eTeyZN6Sh-ckXDQrw@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 5:57=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Jun 07, 2024 at 08:47:43AM CEST, jasowang@redhat.com wrote:
> >On Fri, Jun 7, 2024 at 2:39=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
> >> >On Thu, Jun 6, 2024 at 9:45=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >> >>
> >> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >> >> >On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> >> >> >>
> >> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> >> >> > > If the codes of orphan mode don't have an impact when you en=
able
> >> >> >> > > napi_tx mode, please keep it if you can.
> >> >> >> >
> >> >> >> > For example, it complicates BQL implementation.
> >> >> >> >
> >> >> >> > Thanks
> >> >> >>
> >> >> >> I very much doubt sending interrupts to a VM can
> >> >> >> *on all benchmarks* compete with not sending interrupts.
> >> >> >
> >> >> >It should not differ too much from the physical NIC. We can have o=
ne
> >> >> >more round of benchmarks to see the difference.
> >> >> >
> >> >> >But if NAPI mode needs to win all of the benchmarks in order to ge=
t
> >> >> >rid of orphan, that would be very difficult. Considering various b=
ugs
> >> >> >will be fixed by dropping skb_orphan(), it would be sufficient if =
most
> >> >> >of the benchmark doesn't show obvious differences.
> >> >> >
> >> >> >Looking at git history, there're commits that removes skb_orphan()=
, for example:
> >> >> >
> >> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >> >> >Author: Eric Dumazet <edumazet@google.com>
> >> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >> >> >
> >> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >> >> >
> >> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for =
TX
> >> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit(=
)
> >> >> >    since skb wont stay a long time in TX ring before their releas=
e.
> >> >> >
> >> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much a=
s
> >> >> >    possible, since it breaks TCP Small Queue or other flow contro=
l
> >> >> >    mechanisms (per socket limits)
> >> >> >
> >> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >> >> >
> >> >> >>
> >> >> >> So yea, it's great if napi and hardware are advanced enough
> >> >> >> that the default can be changed, since this way virtio
> >> >> >> is closer to a regular nic and more or standard
> >> >> >> infrastructure can be used.
> >> >> >>
> >> >> >> But dropping it will go against *no breaking userspace* rule.
> >> >> >> Complicated? Tough.
> >> >> >
> >> >> >I don't know what kind of userspace is broken by this. Or why it i=
s
> >> >> >not broken since the day we enable NAPI mode by default.
> >> >>
> >> >> There is a module option that explicitly allows user to set
> >> >> napi_tx=3Dfalse
> >> >> or
> >> >> napi_weight=3D0
> >> >>
> >> >> So if you remove this option or ignore it, both breaks the user
> >> >> expectation.
> >> >
> >> >We can keep them, but I wonder what's the expectation of the user
> >> >here? The only thing so far I can imagine is the performance
> >> >difference.
> >>
> >> True.
> >>
> >> >
> >> >> I personally would vote for this breakage. To carry ancient
> >> >> things like this one forever does not make sense to me.
> >> >
> >> >Exactly.
> >> >
> >> >> While at it,
> >> >> let's remove all virtio net module params. Thoughts?
> >> >
> >> >I tend to
> >> >
> >> >1) drop the orphan mode, but we can have some benchmarks first
> >>
> >> Any idea which? That would be really tricky to find the ones where
> >> orphan mode makes difference I assume.
> >
> >True. Personally, I would like to just drop orphan mode. But I'm not
> >sure others are happy with this.
>
> How about to do it other way around. I will take a stab at sending patch
> removing it. If anyone is against and has solid data to prove orphan
> mode is needed, let them provide those.

Honestly, we in production have to use skb orphan mode. I cannot
provide enough and strong evidence about why default mode on earth
causes performance degradation in some cases. I mean I don't know the
root cause. The only thing I can tell is if I enable the skb orphan
mode, then 1)  will let more skb pass the TCP layer, 2) some key
members like snd_cwnd in tcp will behave normally.

I know without orphan mode the skb will be controlled/limited by the
combination of TSO and napi_tx mode thanks to sk_wmem_alloc. So I
_guess_ the root cause is: the possible delay of interrupts generated
by the host machine will cause the delay of freeing skbs, resulting in
the slowing down the tx speed. If the interval between two interrupts
is very short like the real NIC, I think the issue would disappear.

That's all I can tell. Just for record. Hope this information could
also be useful to other readers.

Thanks,
Jason

>
>
> >
> >Thanks
> >
> >>
> >>
> >> >2) keep the module parameters
> >>
> >> and ignore them, correct? Perhaps a warning would be good.
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >>
> >> >>
> >> >> >
> >> >> >Thanks
> >> >> >
> >> >> >>
> >> >> >> --
> >> >> >> MST
> >> >> >>
> >> >> >
> >> >>
> >> >
> >>
> >

