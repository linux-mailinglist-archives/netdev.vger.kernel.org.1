Return-Path: <netdev+bounces-141779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B59BC3A6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F37EB2161D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764516BE2A;
	Tue,  5 Nov 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itvJaTGM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA815C144
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776199; cv=none; b=Gw9+cpvplXoN7Cr5fMDyyKJCkcQFvBHRN5yXwk5uE9+jHoHAX44HQM5Ot3Rtxf/seCZHnM52UTr5ZvAgKKFDDXg9HpawnMS+yp6e1Eig8bSopQ5VVYKI9Y3nrVOr7SmNUkqOZvsN6N049x+cH425b//ZfPsZwJ2UAylr5eZFxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776199; c=relaxed/simple;
	bh=iJiqEI4jeiISFUYA5z9mrx3IXzLlVPZzv4h1oYlPJgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOvu9kqClGurNN/mZ+URWXrgpNdHxVQsAfMHe/UNIRLeWSSy5WkBJHNsLxNB8xbtMcvtiL1ASqvJUEeumvrhL8XqAx/WXmdlqsZfwBOUyRCkdfWpon6u0DyAJoPFlYhptTryzBu1SQsUZIlUiV3haViwJ1L5YsUXl8Ag7YYlbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itvJaTGM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730776196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e798jqlARNKREu5f9NYLA+kZVVjz8QYT2h6TT0fZ7qY=;
	b=itvJaTGMvq3pnNwJwXHX235F7FA/TuQiXyXlSYWmuaoHSJVjSrlQnOhXNma497nf6/IavG
	eqYzJU2UH+BY6fAMGkIVsc1wGQb4kizJBQCSx9DmjuJY5DwS8COUMEMUKPSuI5UsKx9xGV
	iy+4YvLROVopYnNDFOCFlCCThCLmmzs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-6lGN1WKINaa7l9EMBYrwpg-1; Mon, 04 Nov 2024 22:09:55 -0500
X-MC-Unique: 6lGN1WKINaa7l9EMBYrwpg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e33e5fc515so5089531a91.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 19:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776194; x=1731380994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e798jqlARNKREu5f9NYLA+kZVVjz8QYT2h6TT0fZ7qY=;
        b=qE4Zh1e0FQXWEhylSgug2yFtrE/Njv1wYfu4xzb0Mv8U9fhuRPKrzpofAEkMyp3FH1
         LsryMmpKyaR3RHXWbRyEroTzMVBVjNWeiiZaUxJJvkrGJQKZh4Anlj0Yth9N5lqnIjyg
         X7WbqBKdW0Ac769AxC/hjfRgdlvD8tJRRyd7ee4kEt7Gr79O5X6fGghC9Sg2yA51saj1
         9uwB8DeJZEtXhZzfnRBa70FwvhnV5J5W+RVMzhBwtGQfsArh3PMVw6rn8/WXEWbnFPpd
         GGGOuKmGSVQ0DBsmmTputxqifnMqwpv22/pUvpgeHKxemH3dac++SgEHdkDgcxisjJlo
         qqOg==
X-Forwarded-Encrypted: i=1; AJvYcCUUrjaD4cTYNWUYYBqobLMGJB9u5KkJpt0GCcK0ejmCD3HAZXANvA1UlCWbfRgQhwSlfIXkK0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfApJP9tqpGSbZ/FsRq7n2ygkCl5seh7iVQTRaDgw/m7kn02JH
	++663/5VDHmH/4fCFpet1iUBszsAkGJlOIsckXLfy0vI5k1Pgr8A6VW+gX/CT03f/jFL1jl1fT7
	yijR3waX9eHWGvk8vqASrA5ALHL7h3PmgiW+4PDq8AALQ03DQAJKQRA+Wd8pO6DvZsfo5lzHetz
	B+4eTM59yLmqS4j1cmJIXVf/O7gaQ8
X-Received: by 2002:a17:90a:bc87:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2e92ce32e36mr24812030a91.4.1730776193966;
        Mon, 04 Nov 2024 19:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYJVUVsmrlOV42/z3JLwA/lW5WLQWpnOFROwOF4DJyTXxU3SnSQkWNTS+6YVqbPJsVSZBiin0tuQPsU4ebyy8=
X-Received: by 2002:a17:90a:bc87:b0:2d3:da6d:8330 with SMTP id
 98e67ed59e1d1-2e92ce32e36mr24812003a91.4.1730776193416; Mon, 04 Nov 2024
 19:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>
 <20241101015101.98111-1-qiang4.zhang@linux.intel.com> <CACGkMEtvrBRd8BaeUiR6bm1xVX4KUGa83s03tPWPHB2U0mYfLA@mail.gmail.com>
 <ZyRlC-5V_NTKgzXh@dev-qz>
In-Reply-To: <ZyRlC-5V_NTKgzXh@dev-qz>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 11:09:41 +0800
Message-ID: <CACGkMEvc+eA7KdJJAtjNPwqve8CwLZYzAmMhf0RWwQ-GwonaUw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: only reset device and restore status if needed
 in device resume
To: Qiang Zhang <qiang4.zhang@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Qiang Zhang <qiang4.zhang@intel.com>, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:23=E2=80=AFPM Qiang Zhang <qiang4.zhang@linux.inte=
l.com> wrote:
>
> On Fri, Nov 01, 2024 at 10:11:11AM +0800, Jason Wang wrote:
> > On Fri, Nov 1, 2024 at 9:54=E2=80=AFAM <qiang4.zhang@linux.intel.com> w=
rote:
> > >
> > > From: Qiang Zhang <qiang4.zhang@intel.com>
> > >
> > > Virtio core unconditionally reset and restore status for all virtio
> > > devices before calling restore method. This breaks some virtio driver=
s
> > > which don't need to do anything in suspend and resume because they
> > > just want to keep device state retained.
> >
> > The challenge is how can driver know device doesn't need rest.
>
> Hi,
>
> Per my understanding to PM, in the suspend flow, device drivers need to
> 1. First manage/stop accesses from upper level software and
> 2. Store the volatile context into in-memory data structures.
> 3. Put devices into some low power (suspended) state.
> The resume process does the reverse.
> If a device context won't loose after entering some low power state
> (optional), it's OK to skip step 2.
>
> For virtio devices, spec doesn't define whether their states will lost
> after platform entering suspended state.

This is exactly what suspend patch tries to define.

> So to work with different
> hypervisors, virtio drivers typically trigger a reset in suspend/resume
> flow. This works fine for virtio devices if following conditions are met:
> - Device state can be totally recoverable.
> - There isn't any working behaviour expected in suspended state, i.e. the
>   suspended state should be sub-state of reset.
> However, the first point may be hard to implement from driver side for so=
me
> devices. The second point may be unacceptable for some kind of devices.
>
> For your question, for devices whose suspended state is alike reset state=
,
> the hypervisor have the flexibility to retain its state or not, kernel
> driver can unconditionally reset it with proper re-initialization to
> accomplish better compatibility. For others, hypervisor *must* retain
> device state and driver just keeps using it.

Right, so my question is how did the driver know the behaviour of a
device? We usually do that via a feature bit.

Note that the thing that matters here is the migration compatibility.

>
> >
> > For example, PCI has no_soft_reset which has been done in the commit
> > "virtio: Add support for no-reset virtio PCI PM".
> >
> > And there's a ongoing long discussion of adding suspend support in the
> > virtio spec, then driver know it's safe to suspend/resume without
> > reset.
>
> That's great! Hopefully it can fill the gap.
> Currently, I think we can safely move the reset to drivers' freeze method=
s,
> virtio core has no reason to take it as a common action required by all
> devices. And the reset operation can be optional skipped if driver have
> hints from device that it can retain state.

The problem here is whether the device can be resumed without "soft
reset" seems a general feature which could be either the knowledge of

1) virtio core (a feature bit or not)

or

2) transport layer (like PCI)

>
> >
> > >
> > > Virtio GPIO is a typical example. GPIO states should be kept unchange=
d
> > > after suspend and resume (e.g. output pins keep driving the output) a=
nd
> > > Virtio GPIO driver does nothing in freeze and restore methods. But th=
e
> > > reset operation in virtio_device_restore breaks this.
> >
> > Is this mandated by GPIO or virtio spec? If yes, let's quote the revela=
nt part.
>
> No. But in actual hardware design (e.g. Intel PCH GPIO), or from the
> requirement perspective, GPIO pin state can be (should support) retained
> in suspended state.
> If Virtio GPIO is used to let VM operate such physical GPIO chip indirect=
ly,
> it can't be reset in suspend and resume. Meanwhile the hypervisor will
> retain pin states after suspension.
>
> >
> > >
> > > Since some devices need reset in suspend and resume while some needn'=
t,
> > > create a new helper function for the original reset and status restor=
e
> > > logic so that virtio drivers can invoke it in their restore method
> > > if necessary.
> >
> > How are those drivers classified?
>
> I think this depends whether hypervisor will keep devices state in platfo=
rm
> suspend process.

So the problem is that the actual implementation (hypervisor, physical
device or mediation) is transparent to the driver. Driver needs a
general way to know whether it's safe (or not) to reset during the
suspend/resume.

> I think hypervisor should because suspend and reset are
> conceptually two different things.

Probably, but rest is and doing software state load/save is common
practice for devices that will lose their state during PM.

Thanks

>
>
> Thanks
> Qiang
>


