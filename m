Return-Path: <netdev+bounces-104649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C890DB87
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288541C224C1
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CF15E5C3;
	Tue, 18 Jun 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyz3c/Z4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438A13DDDF
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735038; cv=none; b=ogFhENZNVW54fdMcOPuwSXF/ULcw6zJY7W3y1wWCumK1NZ1l+sNSayw9/AB4PzhPbQ3+G5c4QwTb1a1zdLCiubr2xolabSKOSwFxZRJvZCb3DU/cnsPpla+W6UvaHy2PEvDHA+e1rzxqjm+4Csmact8qoPEALAHwhl8qiO/+cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735038; c=relaxed/simple;
	bh=U8yHKftPtJ7KV9NHLlUbLrl7QlT2usjnSoXCwmc5DfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUlxUSk1nJamGzZXFzj17/aiXvpeMwrSF9wDK0Cd9CyO3kvIo+QijWZ/AT0Xrc/VgOc4fLtRLbGKXjJGApElhZoFRVFXvdeLRv64XT0mhYho1zIjY427Fmm8cy+tP35HUFl3f0pnlCa5Stcp+ge03qT+eMk14zUdI7BAPWliY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyz3c/Z4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718735036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd5e1t1YHSDWbvK0pTxindgPQYFqu/epSZ8nTYFq6wM=;
	b=iyz3c/Z4ZMTxMocXTx6lYriPoOwcs7/8u14trByj13djXlgkunTIQXVsEecaoASJAEF/nY
	gryMeGFWovVZT49TVjtOUAFCNPMDQx5PXFtIB7x7GZahe42tQ4lyz1sR0YYPm9DztDLtfN
	1Go7OmmpNlay73n3lv+JPulVXAN/gag=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-i22lT2mqP-aABtnnLYPm3A-1; Tue, 18 Jun 2024 14:23:52 -0400
X-MC-Unique: i22lT2mqP-aABtnnLYPm3A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-422322e4abaso395645e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718735031; x=1719339831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zd5e1t1YHSDWbvK0pTxindgPQYFqu/epSZ8nTYFq6wM=;
        b=f7SuSKiWt/njk5kWP1MrXyMHN1H18vVzTkgH7JP8GA2UBcneKTbS6m1wRrZgeSZjUM
         HwYqWRVepyJDdvflsZRllXuzD6B8DWVlp7Gn2arCi1+jMz9JGG17jzTi+XhOVQvIPhCH
         DuQZ2JnD1dIUpwwGcSuc7RU786FZje9Be5ALiH3I3eXN68xoC6mRhHaAnEsvrhUkjAem
         n1KjQe7uF8LO2K1oPFWAS0T/2tSzg7J6KabucPgKnprJE8uFU2g9yiW/Ktpu/kXFXKH4
         VujC4jzbWxv9b2JBBPpi1RrrmEtC3g55J9FB3mL3QVQNbeci4RQZyRsq9fQYvCxV3qVf
         Xa1w==
X-Forwarded-Encrypted: i=1; AJvYcCV4VYrxxyE9TkyDl7k7YazzwR2RMTZrMvkOsN16DZU8s4bOLGmZAMfRfHniWQmhSIxo5LA3G0HjLgMLhL0AL6eQs73Bu8kD
X-Gm-Message-State: AOJu0Yy2imqt23zqwZPmsZoby+A/ZnGqW65oaNLFOnUg/P/j/XsxNfBu
	BXrnjGSdkoog5srLjsKxLu56Rl81z84hzrXf+eLMyQs1oHl+RAeameV7qeqEgKk94cGLXWGn0e4
	e95DkZ5+NE46iLRDb92Wkc2jU3g9hbVX4zJ8Q5CWX3Cu1S6w/rbPFfQ==
X-Received: by 2002:a05:600c:46ca:b0:421:741d:5c31 with SMTP id 5b1f17b1804b1-4246f5cfa98mr31114715e9.15.1718735031033;
        Tue, 18 Jun 2024 11:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd8sQOKPN+DyV/byjiNIGj5VYifQGSoIwKFXPdTl3JxG8Sn56GaKySh4rYTIbW3g0+A9DNWA==
X-Received: by 2002:a05:600c:46ca:b0:421:741d:5c31 with SMTP id 5b1f17b1804b1-4246f5cfa98mr31114425e9.15.1718735030569;
        Tue, 18 Jun 2024 11:23:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e71dcsm231632785e9.44.2024.06.18.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:23:49 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:23:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240618142009-mutt-send-email-mst@kernel.org>
References: <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
 <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
 <ZnACPN-uDHZAwURl@nanopsycho.orion>
 <CACGkMEvYC0vV9McY=G6V9K56yqtc5=9RVk7XbVX495GYyRcQcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvYC0vV9McY=G6V9K56yqtc5=9RVk7XbVX495GYyRcQcg@mail.gmail.com>

On Tue, Jun 18, 2024 at 08:52:38AM +0800, Jason Wang wrote:
> On Mon, Jun 17, 2024 at 5:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >
> > Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
> > >On Mon, Jun 10, 2024 at 10:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>
> > >> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> > >> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> > >> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> > >> > >> >True. Personally, I would like to just drop orphan mode. But I'm not
> > >> > >> >sure others are happy with this.
> > >> > >>
> > >> > >> How about to do it other way around. I will take a stab at sending patch
> > >> > >> removing it. If anyone is against and has solid data to prove orphan
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
> > >> > There is no breakage. Only, hypotetically performance downgrade in some
> > >> > hypotetical usecase nobody knows of.
> > >>
> > >> Performance is why people use virtio. It's as much a breakage as any
> > >> other bug. The main difference is, with other types of breakage, they
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
> > >> > solid data to prove orphan is needed during the patch review, let's toss
> > >> > out the patch.
> > >> >
> > >> > Makes sense?
> > >>
> > >> It's not hypothetical - if anything, it's hypothetical that performance
> > >> does not regress.  And we just got a report from users that see a
> > >> regression without.  So, not really.
> > >
> > >Probably, but do we need to define a bar here? Looking at git history,
> > >we didn't ask a full benchmark for a lot of commits that may touch
> >
> > Moreover, there is no "benchmark" to run anyway, is it?
> 
> Yes, so my point is to have some agreement on
> 
> 1) what kind of test needs to be run for a patch like this.
> 2) what numbers are ok or not
> 
> Thanks

That's a $1mln question and the difficulty is why we don't change
behaviour drastically for users without a fallback even if
we think we did a bunch of testing.



> >
> >
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
> >


