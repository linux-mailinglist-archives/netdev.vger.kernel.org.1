Return-Path: <netdev+bounces-69987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0F84D2D2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DA01C2289B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F71272A8;
	Wed,  7 Feb 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBoy2rn8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E736126F19
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337290; cv=none; b=Pj2bxIlQKvwaEt+VNc0nIh5lG7zD57sHF6g4emCfm9zHi6zom3YRov7h4Xu5DCTOtQtD2Ls7+LyQyabZLVV8OLO7GAMWexvfavOc1zqIwXZY13xSTAaFC6fHbONvDUPxDM4Ua438mnw1wliUjBt1giUZRy3X467yIjTqpRCxtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337290; c=relaxed/simple;
	bh=C1+aE5zy9B03xrsMBL8HKVA2xk9DSY7YIYN3YM8Nm6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8bWMLVs3XM72LKfxPWSJpmbO1eLrYyYDkFyr9+9ZuZ2knHDvF1bT5vr9cJCi6kFGT5j8ZbgP83dbDNI+bwdKMV4+pLVrcBUCIxw0Qp8Jb4JqfuEjn5Adu7GD65h3ic441D5GuOFXupUSLU/Otp24IOAnEeUkRFZkVXXHkQ2thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBoy2rn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707337287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H8QJtDMIo3MZizJfYWH6nlrtUEhOFebosERzPFJAFw=;
	b=VBoy2rn8sOQ5sXJRZTO5VPE3epRo9L7XfU+jvMJ6p8gM9PTs8EJ3nJ8fHxVLYWjgye5Iy5
	X9GY/Dcv7CaLXDEf7w77VQ/iZuZdfqCpiLCm56jkTyx08cG16Sp8paHJN1GoAAB94d5ucv
	MM2PrezLyevD6cRLy1k+dMF9+ctCkVM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-V_bg-MaEOmeKEtUzsRncbw-1; Wed, 07 Feb 2024 15:21:26 -0500
X-MC-Unique: V_bg-MaEOmeKEtUzsRncbw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b248e7cf0so546471f8f.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337285; x=1707942085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3H8QJtDMIo3MZizJfYWH6nlrtUEhOFebosERzPFJAFw=;
        b=DFm8M3gbQYaTbIxiEprR7VWYjzxpzRi+lRXXeDhhBn5SP+FaG5a0Q7pwZAjzoCUEJs
         vwRG1Ui608jr9iydg/Do22Ag30II01lnVzQo/7ScxM+2DGh62dAizZjYAm6k9/P65sbc
         p0/IdeNQHzVfl7QV0YLc+PY5hmWK2mwaPSA1jWT7Hs8dU50cYJgsoRPb6T7XuDAP9mLt
         G3Bnt8i+6adLVochy+WW6Ev7xFyC1cn8TjfSPrxviYu7G7WSb8hdk505v4h5c6bxGQWc
         x9cXRmkoKm/4Vs8aq1+XTjO+kUkmQul2JiL4hYNLWnTkGlLbOOdd76wIqC9TSUgAVwqf
         dUJw==
X-Forwarded-Encrypted: i=1; AJvYcCV27OzZwkrN9Drh1my2hkyNh6CelpIh6IUOkEfK7/oeeyqvNOdePPG9SVNfMBDERuVaNSxVpDMQZ2iBOnkfZm4lJyxSvFEJ
X-Gm-Message-State: AOJu0YxYx31QIPgLJK31UUe5Z9k2HGtMUD874nSLDXyVQK8PZvnr0qTx
	ETZKqPqAqJKHzGtXG/IdZU3DuraJlfRpssPEjnkvW6nEj/NpCGMg4/4/5IJfQpSjOJXCB87sONu
	iGcQGAycSpbeqr2miFSs4RAZ+Hbucl/nejdxXz/YpZsMLT1FceVCa0w==
X-Received: by 2002:a05:600c:314d:b0:40e:60c3:c327 with SMTP id h13-20020a05600c314d00b0040e60c3c327mr5256608wmo.1.1707337284833;
        Wed, 07 Feb 2024 12:21:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBUnIvTGUQgEyU72QEFyFSVayytjrrRYGNqaslbqM5E2+LfRIRSySNBFM2rv2F01kmr+IzxA==
X-Received: by 2002:a05:600c:314d:b0:40e:60c3:c327 with SMTP id h13-20020a05600c314d00b0040e60c3c327mr5256598wmo.1.1707337284498;
        Wed, 07 Feb 2024 12:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpYYXxRiHzcANqsGuklB5kOjaBTsE/682jdZgjrs0S4+ysoDRer5JKr7rWC5Ibks+LvVBFr+MazWYA+1HVOYiwd6EWxB7mS3tVMvAXHWBAJ+6gTZE24tAz7SXDw3+4IS73a3Cj6hfHrHEWWqJD0Jda6VufAFxs7c9xS4vBbGY4AVs3u4OdoTPvEZSi1giVdcrqZTQ35ILwwN6iNmeq2ZfRjbEavQogfkr3u51RIwY+Mjq7amPKjQd+gDi6RPwD+feJU8amby5mcwyi65uy2r/Zrr58MFZ2fr76ZyyhfXufd69D/68/glvMZMhC9NKRzoHClX8JXohqL7FwagOOcjc=
Received: from redhat.com ([2a02:14f:173:89f9:ff9e:3e5c:f749:4dfb])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0040e4733aecbsm3114699wmq.15.2024.02.07.12.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:21:23 -0800 (PST)
Date: Wed, 7 Feb 2024 15:21:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240207151940-mutt-send-email-mst@kernel.org>
References: <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
 <CACGkMEsphvgtvaFFob3OjJ-UuuDEVgqyg3pahaGvGZkAsioAFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsphvgtvaFFob3OjJ-UuuDEVgqyg3pahaGvGZkAsioAFg@mail.gmail.com>

On Mon, Feb 05, 2024 at 09:45:38AM +0800, Jason Wang wrote:
> On Sun, Feb 4, 2024 at 8:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Feb 04, 2024 at 09:20:18AM +0800, Jason Wang wrote:
> > > On Sat, Feb 3, 2024 at 12:01 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > > Can you say more? I'm curious what's your use case.
> > > > >
> > > > > I'm not working at Nvidia, so my point of view may differ from theirs.
> > > > > From what I can tell is that those two counters help me narrow down
> > > > > the range if I have to diagnose/debug some issues.
> > > >
> > > > right, i'm asking to collect useful debugging tricks, nothing against
> > > > the patch itself :)
> > > >
> > > > > 1) I sometimes notice that if some irq is held too long (say, one
> > > > > simple case: output of printk printed to the console), those two
> > > > > counters can reflect the issue.
> > > > > 2) Similarly in virtio net, recently I traced such counters the
> > > > > current kernel does not have and it turned out that one of the output
> > > > > queues in the backend behaves badly.
> > > > > ...
> > > > >
> > > > > Stop/wake queue counters may not show directly the root cause of the
> > > > > issue, but help us 'guess' to some extent.
> > > >
> > > > I'm surprised you say you can detect stall-related issues with this.
> > > > I guess virtio doesn't have BQL support, which makes it special.
> > >
> > > Yes, virtio-net has a legacy orphan mode, this is something that needs
> > > to be dropped in the future. This would make BQL much more easier to
> > > be implemented.
> >
> >
> > It's not that we can't implement BQL,
> 
> Well, I don't say we can't, I say it's not easy as we need to deal
> with the switching between two modes[1]. If we just have one mode like
> TX interrupt, we don't need to care about that.
> 
> > it's that it does not seem to
> > be benefitial - has been discussed many times.
> 
> Virtio doesn't differ from other NIC too much, for example gve supports bql.
> 
> 1) There's no numbers in [1]
> 2) We only benchmark vhost-net but not others, for example, vhost-user
> and hardware implementations
> 3) We don't have interrupt coalescing in 2018 but now we have with DIM

Only works well with hardware virtio cards though.

> Thanks
> 
> [1] https://lore.kernel.org/netdev/20181205225323.12555-1-mst@redhat.com/
> 

So fundamentally, someone needs to show benefit and no serious
regressions to add BQL at this point. I doubt it's easily practical.
Hacks like wireless does to boost buffer sizes might be necessary.

> >
> > > > Normal HW drivers with BQL almost never stop the queue by themselves.
> > > > I mean - if they do, and BQL is active, then the system is probably
> > > > misconfigured (queue is too short). This is what we use at Meta to
> > > > detect stalls in drivers with BQL:
> > > >
> > > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
> > > >
> > > > Daniel, I think this may be a good enough excuse to add per-queue stats
> > > > to the netdev genl family, if you're up for that. LMK if you want more
> > > > info, otherwise I guess ethtool -S is fine for now.
> > > >
> > >
> > > Thanks
> >




