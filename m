Return-Path: <netdev+bounces-101660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7178FFC36
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E81B285DED
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDE14F13B;
	Fri,  7 Jun 2024 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1DKu+nB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C318AF4
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741537; cv=none; b=urDWRDRKNU5ct4WH/j7rhe9cnyR0Vdrgm0KyLTZNITz5U02iMq5HFNQ6rO+6o2hC6tHH1AAxBlc6zH6SmV6rolffpB1T3UcgYb6d4jqVEHL4vmq680UUpR9RMwVGFcoPZpeV3AhGE+zctDe5aErbz7OuK7RO/fnS9Va+4vVbdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741537; c=relaxed/simple;
	bh=vNSvPl6arDFt3bloR5w0I1uaCU7Peho4prbi2Lx8/9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkFHHoCF7HblzhXdp/bBZ2ioiWOFXwroaTMhYOsbsdFuVG70+6Nj0yTB47uVKiFofGm9QveNlorA0BuK6tuB+aPUE5+2ay7b0wf9RTcybLTbjwgNgd/FxvSWgN0vLkWLlHyDh2xIwvSOzGLFkihOCwBWnIYUFsjkcObgxB6JkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1DKu+nB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPombUCSKVXobqHvHlGD2t6hSXSJCfgvNAdOEXWRbHw=;
	b=V1DKu+nBXv13SIdpDKPBTPBupv+8Is6enkdfwpNyhOemLQLP4NJdz0BJ/SFxo9r+KYQ0Kj
	qoiY7Kgu8dosuoR0dKfXTZnPKKGGzcan5R8+Xy4gEIU6y0mYjBjQJxkj4qaETXUGSP4QRJ
	TcMBT7HW8vdKBUBgEIR55JmQO5P8+OM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-dTMXdDfSOiCHWDppqEsMIQ-1; Fri, 07 Jun 2024 02:25:32 -0400
X-MC-Unique: dTMXdDfSOiCHWDppqEsMIQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-66c3eace6efso1529573a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717741531; x=1718346331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPombUCSKVXobqHvHlGD2t6hSXSJCfgvNAdOEXWRbHw=;
        b=d7XfVFfuJdanf8Hq2NY6VEQNuuxYraOB9+MHqbWR+5IkfSR+oW3Sotue5dAUQEl+62
         E71HxkRWqRt1UegW/n8u4vpD19dq8JWCeR4qyjRhe+rCW15AKI8wtf4DicZQzHbiR8SE
         vFnA/6oOCKGMj+JkPIswmMxeSzyAt+SbBukG0ehdtQCPraDpwZC3O7IDQ6g9mBdTDThy
         Awq1JeNql+h/B00mcd+Kcgt5G5o2MFZgGKB2KAj9sXI/wxQacJtSVyojkpa9ID3VJxxN
         cSYA2nE0O3OzyUL8VQXD9SFyCBR6A33Z7awof7LNy13I+HXumKAqS2SflZKcRbZirtLh
         RNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl4p+LCpZCaawMoHePf2q/tLd+xr6hRT9aeCHS36bP1vI3w3JM3UcpyVV4VK8iVhxsuK0CL3y/yTzBSrn9mbrs/RobZiIb
X-Gm-Message-State: AOJu0YxYfzIRJi1zRJ4BwE0vfXVu25AFDPi56JeMz3eF+qYT5RjZ1Fqc
	juitJzotUtfqX52aR6BRHBUEx4rQ33APN71IZwGFxfVxBPvuoCMMShzz5us9zlQ4Kf9SxPivuh6
	QdkUYyey/Fzikyqms5F7S09fnonAM8ukWF5Mt6TnKmFpcWrZPoN1qw5TL+vdFPIUT8J/B7+3RQs
	HxEVSC/ZVyQdoriOQQccMqEZCmsSSa
X-Received: by 2002:a05:6a21:3393:b0:1af:cfc2:8069 with SMTP id adf61e73a8af0-1b2f96d6969mr2022360637.4.1717741531256;
        Thu, 06 Jun 2024 23:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUi4WYnn4OxXsHHOSsqUiW4sOic725gpoYQvC+aEOeUdW/61KfsYupAjPBn+0SnlkmpiFzup0Mi2qIQpb+b9Y=
X-Received: by 2002:a05:6a21:3393:b0:1af:cfc2:8069 with SMTP id
 adf61e73a8af0-1b2f96d6969mr2022351637.4.1717741530901; Thu, 06 Jun 2024
 23:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
In-Reply-To: <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:25:19 +0800
Message-ID: <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:45=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >>
> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> > > If the codes of orphan mode don't have an impact when you enable
> >> > > napi_tx mode, please keep it if you can.
> >> >
> >> > For example, it complicates BQL implementation.
> >> >
> >> > Thanks
> >>
> >> I very much doubt sending interrupts to a VM can
> >> *on all benchmarks* compete with not sending interrupts.
> >
> >It should not differ too much from the physical NIC. We can have one
> >more round of benchmarks to see the difference.
> >
> >But if NAPI mode needs to win all of the benchmarks in order to get
> >rid of orphan, that would be very difficult. Considering various bugs
> >will be fixed by dropping skb_orphan(), it would be sufficient if most
> >of the benchmark doesn't show obvious differences.
> >
> >Looking at git history, there're commits that removes skb_orphan(), for =
example:
> >
> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >Author: Eric Dumazet <edumazet@google.com>
> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >
> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >
> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
> >    since skb wont stay a long time in TX ring before their release.
> >
> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
> >    possible, since it breaks TCP Small Queue or other flow control
> >    mechanisms (per socket limits)
> >
> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> >>
> >> So yea, it's great if napi and hardware are advanced enough
> >> that the default can be changed, since this way virtio
> >> is closer to a regular nic and more or standard
> >> infrastructure can be used.
> >>
> >> But dropping it will go against *no breaking userspace* rule.
> >> Complicated? Tough.
> >
> >I don't know what kind of userspace is broken by this. Or why it is
> >not broken since the day we enable NAPI mode by default.
>
> There is a module option that explicitly allows user to set
> napi_tx=3Dfalse
> or
> napi_weight=3D0
>
> So if you remove this option or ignore it, both breaks the user
> expectation.

We can keep them, but I wonder what's the expectation of the user
here? The only thing so far I can imagine is the performance
difference.

> I personally would vote for this breakage. To carry ancient
> things like this one forever does not make sense to me.

Exactly.

> While at it,
> let's remove all virtio net module params. Thoughts?

I tend to

1) drop the orphan mode, but we can have some benchmarks first
2) keep the module parameters

Thanks

>
>
>
> >
> >Thanks
> >
> >>
> >> --
> >> MST
> >>
> >
>


