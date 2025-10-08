Return-Path: <netdev+bounces-228161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE29BC325A
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 04:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCF33C7228
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724329ACE5;
	Wed,  8 Oct 2025 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eayCGPHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B729AB00
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759889522; cv=none; b=iO83Kl4eh+Jbry2bo/2lfUFADda3oYL93qCrbWluvzLtClmOFUEaVnZr6thOjMOOCRJmV77DpVEA8YFv+bmLV4IlwGF5SoxhWWK1gOA2qOwZFCWVGoL7FoqjlgGpLa1/gi7xyci1x2lIdEjy6Mtz66orvNS5r1Uys4wDYKW53go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759889522; c=relaxed/simple;
	bh=95NJX+pL9ZUPYYCw3O9+SBtr8kwet9/Gfon0rHi+IrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTimtzVQeAAb3n4WutYJ+PZsoA+qPQ2y/izpWYPaAFsCQyY4ZaWK1H4YoVIAYgFgH2bSVWuF44ouGLwUiPk4uSAbzIxrvDfU5OOElVrIoSst24anQXS4Iptq5UKSgBEi3S4OWY+rw/hj4yNfkSPNR8POIqx00qyW/815uMA+qJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eayCGPHS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so6234713a91.3
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 19:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759889520; x=1760494320; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=95NJX+pL9ZUPYYCw3O9+SBtr8kwet9/Gfon0rHi+IrE=;
        b=eayCGPHSH8xU4qQqdIObCmynVJjctqYa33hsYpGw4xjZjLy623/pLZT5mljTrPnai/
         bFJc7rhOR/OK92Aov0Qfl1+4qf7w19I6dsNbLkA15/wXJdrzjdefmwp8ScY0Gey881GN
         IKvEsTYRZOZTsuqG6DAgU5ettVe0hYD973lgpCrPzpB43VSWWtHo7FhWyzkwTg3trR87
         ea978BbbJmOR65qXoLB8jQmXs+4lbi0MqWDy4SMYtoL1Gs431QNTtdLLKIfuILQdRFW1
         DiRWHf4XubRJbOROr69+y57PQ0KwfZknlUcOpXZJvmxL1H8uBOKap+7XEn0QJZevzyw5
         ILrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759889520; x=1760494320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95NJX+pL9ZUPYYCw3O9+SBtr8kwet9/Gfon0rHi+IrE=;
        b=pFceF8QVM+IwUUyhJjCB0w9winZ3d19fCGsfXtI6NmT8caseFuFtSLXRw/Wl1OhkB5
         KkQ5JGe9Tk3PqpqH4W46in8GDJdpv2jE4cnoHCx3EdfVWB8BA8zmFmnFcUmCCLH3KD2c
         0WFEl9wXSDYFwdSkNFrSuZKCu4BozSZP+WGqwU8ol7Q0FkNRjjeCbOyEIgxd7du9bUco
         eK22AUartvC+xtlASszOsPE2XJ+CuQqjMklH15d97d3S6Rvn7KKwxjPVsY07JkKzOv4u
         haRs/ErXF5LqDL78D9qkcHhU97Ybg7RGdoW87+V1uVXFVAppbz+hcOJMDSjfJ0T3s28O
         rdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCWhxga5mFkVVHSaW5n0wg7YxqM09RA2VYvs0xWlIbf/I8mLjalBQ1k5Tgi7SSuIPlst35Bb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7ygeH1FyXnS5LX/YG5XRGGOsCZcUVTDbJi9YH77iFFpD8G3a
	nQlGM1a37kG58+1o6daom9VMLT/Vw/xljBr9oGiK6zNypgbUZ2W5kvez
X-Gm-Gg: ASbGncvevqNQpDgJOnISyEO9nttdTviKgRXtoD2TVamxuqCXY/cbo+MZfn38OWcfhJz
	3z/tFP2NCqhV4l8mX5GP9waVV1/AtOYBEbGpcqX/6Kwnh65dvBQ79bt5Jjf8EptYZOHWPzzfphG
	q0c/+cpBRoM217+jhxNTPjROS6eEV9N1nHbkHHeGmMnsC9t45UWxfhcK7Nu6cwRzTKOBMU0mfyL
	w2tJbQ9LP65rGclEs2peKHxvUtcB0stakt/ppvWFybLbqiplYgJEDooAS3eZwHgbsXW27R7zNqS
	V5lQoMZdhrRr+5aUPijPQHoEBdo3UFibSw/io1dwwqOxv/b98akvQKFrdbENIETclrTlNg6XIq9
	gljF+mNfQzUjxzrOkB1ujSwKdkTG/T7mS5aikspo+vCBkJ7Z/p1atkhQ90kGtUdlZfg==
X-Google-Smtp-Source: AGHT+IFz3FyEY2M3qBMJhmAUtAZylBJiGvc5t2kDkFXIlFjsQK/ep9L7nU3ABxehckhHpf5uib5BHA==
X-Received: by 2002:a17:90b:1d05:b0:330:6c04:a72b with SMTP id 98e67ed59e1d1-33b510ff5a6mr2002849a91.3.1759889519684;
        Tue, 07 Oct 2025 19:11:59 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5137dea8sm1239235a91.13.2025.10.07.19.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:11:59 -0700 (PDT)
Message-ID: <143591bfd3499f2ee90034190a94154a965f563d.camel@gmail.com>
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, John Fastabend
 <john.fastabend@gmail.com>,  Jakub Kicinski	 <kuba@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S . Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Date: Wed, 08 Oct 2025 12:11:52 +1000
In-Reply-To: <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
	 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
	 <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
	 <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 11:51 +0200, Hannes Reinecke wrote:
> On 10/7/25 11:24, Wilfred Mallawa wrote:
> > On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
> > > On 10/7/25 02:46, Wilfred Mallawa wrote:
> > > > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > >=20
> > >=20
> > [...]
> > > I wonder: Do we really need to check for a partially assembled
> > > record,
> > > or wouldn't it be easier to call queue->write_space() every time
> > > here?
> > > We sure would end up with executing the callback more often, but
> > > if
> > > no
> > > data is present it shouldn't do any harm.
> > >=20
> > > IE just use
> > >=20
> > > if (nvme_tcp_queue_tls(queue)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue->write_space(sk);
> >=20
> > Hey Hannes,
> >=20
> > This was my initial approach, but I figured using
> > tls_is_partially_sent_record() might be slightly more efficient.
> > But if
> > we think that's negligible, happy to go with this approach
> > (omitting
> > the partial record check).
> >=20
> Please do.
> Performance testing on NVMe-TCP is notoriously tricky, so for now we
> really should not assume anything here.
> And it's making the patch _vastly_ simpler, _and_ we don't have to
> involve the networking folks here.

Okay, will send a V2 with this approach.

> We have a similar patch for the data_ready() function in nvmet_tcp(),
> and that seemed to work, too.
> Nit: we don't unset the 'NOSPACE' flag there. Can you check if that's
> really required?=C2=A0
> And, if it is, fixup nvmet_tcp() to unset it?
> Or, if not, modify your patch to not clear it?

I don't see why we would need to clear the NOSPACE flag in
data_ready()? My understanding is that this flag is used when the send
buffer is full.

I would think the clear_bit() is necessary in write_space() since it
would typically get done in something like sk_stream_write_space()?=20
However, running some quick FIOs with the clear_bit() removed, things
seem to work. Not sure if removing it has any further implications
though...

Regards,
Wilfred


> Cheers,
>=20
> Hannes

