Return-Path: <netdev+bounces-103899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927E90A1E4
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 03:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C8E28142D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6E512B144;
	Mon, 17 Jun 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuX4yWAK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61D156652
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588711; cv=none; b=qF/xwj/u2kVzT0Gge7nJVtk6Lbf83Pp96rbnw7USfZEJXyFPihCH98JAUv2HraIWNSdxsNrXDE1pcyLhfBhXWLXoTVBPFWJaQ4QXyqcdo5BhLD/pxzU4T03GJ7OhpNJwYPDRU390OUXxIBdzqUM8yRCWwHrkx7waMI2Dn6U2rWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588711; c=relaxed/simple;
	bh=t5MD1ex9VlAS8c468F/2oWD+5J03aRRoVhgBc7qIz0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQR9tEl2bvd5TAYSLgU8x7rfLHEVzO6VDNkoNZfGRTiCxUIqqP7nrf/yRjcsM7r3vqZ37U1vfljQrGJr1Z/1z8vC+G4B7ggcxmWAo5j+/N3gHL9CUxxOWkLCTqbHBOVu+DW1nI3OT+1xtKwNHXvpnX2VFs7lN2TJMPwxc88MdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuX4yWAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718588709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=varLkYvQXXiVYrsly37DyVexBnZsFAUL1jZV89pLMSc=;
	b=GuX4yWAKQG6FCAFfZdQf8J8buiG4ob9K9fnaQmygUF+HMErud4FgBRrxZKabZJfDTRoMRL
	ywDROFVrtqnml5mSaukyYP+DVOAxr+Ys2Jm1ZOU2NOfx5Cf2GMCNpAJRK5t8vR3diVJvAx
	GJdTjYmHHmROg8NxIO3MLtoYhYxwFaI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-hMA29X0OPue4_BqMxvcuFA-1; Sun, 16 Jun 2024 21:45:07 -0400
X-MC-Unique: hMA29X0OPue4_BqMxvcuFA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c51c2f1d78so890167a91.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718588707; x=1719193507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=varLkYvQXXiVYrsly37DyVexBnZsFAUL1jZV89pLMSc=;
        b=AyB3x2jQ04lUZQ4C8z1f4UX/1TOKKA9ECwl/5JLn7DO8Q/7/lWWIwHqYlOg4eNAAZe
         e+4d9zRlJaBgDsA4lcmpjPIuPQDv9bu/wm6Z7tBRmwUmErBekd/zgWgfMcrf21eAfcH4
         dyE0xylHJd97oINCOMjOdNLFRogOpGSyX2TEUPXZ+y1Mu1IQ8Iv0r40vE/aSkZUGO5l7
         Y9ifcS6PgKWfSwdpT/AMYwNreDeovyk88ZwKPYrK1zuEQ/HPKhM+UrOIyWc9OtronYoH
         tXiMOhm/D4HHrLRRqE4i/6TZjbW9HRZ+8xvqZhgw3leEixe3M1lxarHeEAJCNM4Mc95P
         A4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVLv5oQjmSA2PL/UWBR1w5b6bE8YKsCw/xhITegUU2lcrpp8U6/YwXc0oRYEaxrfV6eVDdKn6XSCt5+hKCuKrbmk1kYygp/
X-Gm-Message-State: AOJu0Yw6SJalGeIM6EA8bve2kV5FF082RDePRJtopwbM+b8wsXu/Q/+L
	9xfSIN27zE9qtrrDWE3441mPKvIqms8u2bsvd4Jo107NRlVS7gfG6HWwt/bY7ARRsL5StfTAPu5
	lUKwa4U3Qh8x12Mp0lYksVSu+MtIDfjnZk3vKZIE5mQE5C7nVc/DPuaPziIgzIsDivNVE1EI2QP
	i50dQLpEWIaMlBj4PsYrJ2cqCbPgOn
X-Received: by 2002:a17:90b:1109:b0:2c3:2557:3de8 with SMTP id 98e67ed59e1d1-2c4dba4cc8bmr6965577a91.33.1718588706645;
        Sun, 16 Jun 2024 18:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0AkWfMq72NwUEMIwBQBHsf866KKlMTTJe+fIwJHWEiL0M9NimZLgYzfnZ5J7nZR659gGCPKCffH8bhH406rg=
X-Received: by 2002:a17:90b:1109:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2c4dba4cc8bmr6965570a91.33.1718588706277; Sun, 16 Jun 2024
 18:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion> <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion> <20240610101346-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240610101346-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:44:55 +0800
Message-ID: <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> > >> >True. Personally, I would like to just drop orphan mode. But I'm no=
t
> > >> >sure others are happy with this.
> > >>
> > >> How about to do it other way around. I will take a stab at sending p=
atch
> > >> removing it. If anyone is against and has solid data to prove orphan
> > >> mode is needed, let them provide those.
> > >
> > >Break it with no warning and see if anyone complains?
> >
> > This is now what I suggested at all.
> >
> > >No, this is not how we handle userspace compatibility, normally.
> >
> > Sure.
> >
> > Again:
> >
> > I would send orphan removal patch containing:
> > 1) no module options removal. Warn if someone sets it up
> > 2) module option to disable napi is ignored
> > 3) orphan mode is removed from code
> >
> > There is no breakage. Only, hypotetically performance downgrade in some
> > hypotetical usecase nobody knows of.
>
> Performance is why people use virtio. It's as much a breakage as any
> other bug. The main difference is, with other types of breakage, they
> are typically binary and we can not tolerate them at all.  A tiny,
> negligeable performance regression might be tolarable if it brings
> other benefits. I very much doubt avoiding interrupts is
> negligeable though. And making code simpler isn't a big benefit,
> users do not care.

It's not just making code simpler. As discussed in the past, it also
fixes real bugs.

>
> > My point was, if someone presents
> > solid data to prove orphan is needed during the patch review, let's tos=
s
> > out the patch.
> >
> > Makes sense?
>
> It's not hypothetical - if anything, it's hypothetical that performance
> does not regress.  And we just got a report from users that see a
> regression without.  So, not really.

Probably, but do we need to define a bar here? Looking at git history,
we didn't ask a full benchmark for a lot of commits that may touch
performance.

Thanks

>
> >
> > >
> > >--
> > >MST
> > >
>


