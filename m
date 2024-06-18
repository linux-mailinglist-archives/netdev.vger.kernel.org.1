Return-Path: <netdev+bounces-104299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5B90C135
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563F1281C2C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF036AC0;
	Tue, 18 Jun 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKRshzmv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719C4C6D
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673608; cv=none; b=PNfcvmMDBc4+Uzrtg+UIzCvB3HvVxLKHkOdWfe29dGvSDJ8HGMn4KgcTuznLgshkT6LZJoD8ERYjn6KjrbhuCZPgJ7+nIXLSw6UuwVLnfKJysxTcm5e+BIcI+T/WMgGxe+RADAQBsnxrzl7hberoo4T7Pe3Ku5WWhzFQhfXXTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673608; c=relaxed/simple;
	bh=d0SnZw1Xf/53Eyu0IKqQJ47gBK/ILSrcvltGpevDImk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApOczWAc4SWUfAHO1aN5Eqw+xzni0wli7fMwxQ2JIJLQXwFJ6clZZ7Biy6/AW4NcD9YM+EmYZU0JJosPFPzJ02kfOrj/EE0KLgddiT8dqAJ/BEia368/sT9OAqRI+Y8o9Z9uRQBt/B8m+SYK/Mgc/Lj7FwOzP5A/M+ozfbbMBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKRshzmv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718673606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlJplGu26itJiIifDWOuoHRWeDURtPOV07x+0z7gMfM=;
	b=HKRshzmvoSh4Q6RhKgVMzwOVCf1fD4MSGmUTUCdUdBpwLd74vbQoSSUmg5l/c9Ej7GGBG4
	J5a0QlKlcyRJgs97ZWJjC11w7O87fzITXFRHJDRMuUlxtCBGjt2PsDkg6l6UgF8LFpk3+H
	RXuRGYyv/3Tz7r0e+tmMX7hhP0nMEgE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-YIrwbXoaPtCcuQG3zMZcNA-1; Mon, 17 Jun 2024 21:20:04 -0400
X-MC-Unique: YIrwbXoaPtCcuQG3zMZcNA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e79f0ff303so4030905a12.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718673604; x=1719278404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlJplGu26itJiIifDWOuoHRWeDURtPOV07x+0z7gMfM=;
        b=mq8ajXxkAohWiLkwy8UYcst/Wj+7jQxVprdP8TBS50xqeo/AFMuI64PwXxJYYd2Akh
         FCa0Hf6y0R07GqIyGaCFyE7nqO4EGcxMA/ltBMcz1p7erJW9acNaVyQlE9lVsEMi/dA6
         zdmZb054BqOOJsk7ZC5jmL426++BDeh4ggxhZqXEPGSWgX1vrt9DnL9vQ51UZGYG4HDw
         b577v75IJhLaH5FrsjBybxU/uT/rizaxGLBt9RF7HXfOOit/Pa9l9N6qiqNyQaj2Lowm
         d66BR/R0S9sjrPeRD7SgHQ93uo3+dW26H4VDZxuGveCs7T9i0t/TK0I3d5igEtIoS0/J
         AOxw==
X-Forwarded-Encrypted: i=1; AJvYcCXczZCRknLCIDZQaWydvEpdw44LMw60UeBI3SyOSAjlds8gZ9UFMbFxmBqBHg6HUcsiiD3DfRYfrwzZlC/rjUn+CwJxntG4
X-Gm-Message-State: AOJu0YxPYa59kxSbT7yqcvOrWDVt2wzraxox7nO79jUYSmhKlinhiKgS
	crCJM05ocGPIuKddTA6qAN8rAQID6qf4iJ/muvzKmhX2AC9sqQf6jUQaKQWH8YvxcSYJF9lVLKV
	xJ/R9cfZLfcea+d+BK13mCoijod5MSvwhyhDKRfMh/F2D432nXknNr9saskTAjOLUjVNc1DNyvu
	eeA05oWTZE46Vhl+Qb/epkGOYe+4tO
X-Received: by 2002:a05:6a20:430d:b0:1b6:db6c:11dd with SMTP id adf61e73a8af0-1bae7e29041mr12347875637.9.1718673603808;
        Mon, 17 Jun 2024 18:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwMCQpzGRduK8eBGmbYbrrgYYqBMFiL1FjxTaND7gNyPprMKC/3wMqe3WZ/0zQIphPvUai/mECzBBG34xjvLY=
X-Received: by 2002:a05:6a20:430d:b0:1b6:db6c:11dd with SMTP id
 adf61e73a8af0-1bae7e29041mr12347848637.9.1718673603354; Mon, 17 Jun 2024
 18:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion> <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion> <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
 <ZnACPN-uDHZAwURl@nanopsycho.orion> <20240617121448-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240617121448-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:19:51 +0800
Message-ID: <CACGkMEtkzezg6Pm8+12MSvMAk4AFrc7Q_cymDqs6pa0Uvu+pJQ@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:16=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jun 17, 2024 at 11:30:36AM +0200, Jiri Pirko wrote:
> > Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
> > >On Mon, Jun 10, 2024 at 10:19=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > >>
> > >> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> > >> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> > >> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> > >> > >> >True. Personally, I would like to just drop orphan mode. But I=
'm not
> > >> > >> >sure others are happy with this.
> > >> > >>
> > >> > >> How about to do it other way around. I will take a stab at send=
ing patch
> > >> > >> removing it. If anyone is against and has solid data to prove o=
rphan
> > >> > >> mode is needed, let them provide those.
> > >> > >
> > >> > >Break it with no warning and see if anyone complains?
> > >> >
> > >> > This is now what I suggested at all.
> > >> >
> > >> > >No, this is not how we handle userspace compatibility, normally.
> > >> >
> > >> > Sure.
> > >> >
> > >> > Again:
> > >> >
> > >> > I would send orphan removal patch containing:
> > >> > 1) no module options removal. Warn if someone sets it up
> > >> > 2) module option to disable napi is ignored
> > >> > 3) orphan mode is removed from code
> > >> >
> > >> > There is no breakage. Only, hypotetically performance downgrade in=
 some
> > >> > hypotetical usecase nobody knows of.
> > >>
> > >> Performance is why people use virtio. It's as much a breakage as any
> > >> other bug. The main difference is, with other types of breakage, the=
y
> > >> are typically binary and we can not tolerate them at all.  A tiny,
> > >> negligeable performance regression might be tolarable if it brings
> > >> other benefits. I very much doubt avoiding interrupts is
> > >> negligeable though. And making code simpler isn't a big benefit,
> > >> users do not care.
> > >
> > >It's not just making code simpler. As discussed in the past, it also
> > >fixes real bugs.
> > >
> > >>
> > >> > My point was, if someone presents
> > >> > solid data to prove orphan is needed during the patch review, let'=
s toss
> > >> > out the patch.
> > >> >
> > >> > Makes sense?
> > >>
> > >> It's not hypothetical - if anything, it's hypothetical that performa=
nce
> > >> does not regress.  And we just got a report from users that see a
> > >> regression without.  So, not really.
> > >
> > >Probably, but do we need to define a bar here? Looking at git history,
> > >we didn't ask a full benchmark for a lot of commits that may touch
>
> It's patently obvious that not getting interrupts is better than
> getting interrupts.

Exactly. But dropping orphan mode seems less intrusive than the commit
that makes NAPI default.

Thanks

> The onus of proof would be on people who claim
> otherwise.
>
>
> > Moreover, there is no "benchmark" to run anyway, is it?
> >
>
> Tought.  Talk to users that report regressions.
>
>
>
> > >performance.
> > >
> > >Thanks
> > >
> > >>
> > >> >
> > >> > >
> > >> > >--
> > >> > >MST
> > >> > >
> > >>
> > >
>


