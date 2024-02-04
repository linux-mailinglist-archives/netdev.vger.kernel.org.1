Return-Path: <netdev+bounces-68925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199C848DC7
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C1A1C21AF5
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E02219FF;
	Sun,  4 Feb 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvaA47kS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7B224E3
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707050387; cv=none; b=B5G0tf20XQTWg70g/tF08qf5fTd9Ligst1dTV8YzPmWF9PWk3HwVr6jjmnetqF40Xwd6Eeh8ZibCqNKEwQybwCwAh+GhgVBFIVX2Yr8OdiGPbpejzCTlTRSFbFoaqtKg2hI0x+1QELyccZ6zvVCe/z7jgyQwTRXSwoDJJpS+VgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707050387; c=relaxed/simple;
	bh=pirbvKlskhOYKnsrXru1Jdv54NG7AYPCCSfDpkXGdDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF0RMc2luk32i2/zaZVENXIN7PGYJOkk1w8Sr2mZyBtBgUzG2FEzo64mHvn/4yNidn5/0tg9e4r0R6ioDkWx2pL6m0cd93/04Rx4rCIkDCTSpH31OajQVyx0nO8ayp3wS0EyPlwJVIrRtsw0akGXSZGI3s8zJE20Ac3Cn1zajRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvaA47kS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707050384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcLLFPKvLJzuF/XcWyGsAawP3WU5em03/73vyC7KdFw=;
	b=EvaA47kSuWQVm2uyQ/OjG9+SrU4knUZkuPbJV7fBeeh3R87Z8p158+QG+3+ccbgviRQXMp
	yhhe1NFna+vEcCgjn6Ai+oea8rq8lMyhOetNAeQopxAz2OhBV1KSJzA6YiIjLbDj8xrAUf
	co0HeyDMo4jSJ5usTNqcslVJdidMLwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-qMKGX-rJMfa2Aun0EBz5Rg-1; Sun, 04 Feb 2024 07:39:43 -0500
X-MC-Unique: qMKGX-rJMfa2Aun0EBz5Rg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40ef75bea84so20058295e9.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 04:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707050382; x=1707655182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcLLFPKvLJzuF/XcWyGsAawP3WU5em03/73vyC7KdFw=;
        b=TT+ihWBKfvDPdjLIUu+lHgj6txVG0B7faPFI414mgaUuNpIai6bC3nmQ/u7yZIasvF
         bOmgtBede1os5C7wa6NvHson34nqESfRqLhNqTXL8Yk8VRlxYvJ2f7WVYn7nlBIazh30
         FrM0dyURJ1vqASihjAp9Nu53WgyfgHfUUoVVlostrXjIqk7wEBgHCmxkoiSSS1p4IInc
         PC8njuAx2JoNlR1eFaIK86aO1off+4OuI2gDzgEh1SEqMK3EJMl7NyF9O2hathS8j6Jr
         DGO+PQOhbeH1WmU7Vht67VGTUkiIAVtfZwabMPNJE/B1cKg0gbk52q++70wHCkL0ZtQB
         Sgig==
X-Gm-Message-State: AOJu0YxPBtYH4935PlrXYnH0Nzqtvtsx6bz3MVMRuRHkwxyqDuRXI7k3
	8Y3KLIzeBkRJyw38FCgvNuSjLyJV89sEA8cgMtm591+t+NhIPMLXzW5YRm+wZGbe97clhqc4C0Z
	LL0+3gGujEg2TNJuFtX9+68zxf+aK5r0hgDBBTGTiwe0X52F+nI6qCA==
X-Received: by 2002:a05:600c:4313:b0:40f:b456:6877 with SMTP id p19-20020a05600c431300b0040fb4566877mr2860427wme.18.1707050382069;
        Sun, 04 Feb 2024 04:39:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDo+6QiXrDDE5utbx0ixAeLLZSJP8HUbsdHLXIc5kzw9Hhb3WeIxVAQbmt2ZnZofmRtUckEA==
X-Received: by 2002:a05:600c:4313:b0:40f:b456:6877 with SMTP id p19-20020a05600c431300b0040fb4566877mr2860413wme.18.1707050381731;
        Sun, 04 Feb 2024 04:39:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWCyApH338V9ULgsryYbgIsb37kvdSTBTeZ1yPqqzLH4rEXNamoFW7UPrn3uuZ4xdXRJIY0JfsP0M5H2WDNIZaCX/TbJDImdNW5uMZsczUWxFshlvC4+Fci3r6ReF0YarGSIeZ1pAeEYmS50DkiE+6zDyApCX2xVwXUP1FYnbvoOfowrADTT+xdu0kg/p3m3+31YNe3TBUKTS9bYFy1VZNC1fPnI4Y7Y2E77rhqx0hQGWg4LHASzDLmaFQDn/N4Wdvpg4vGUYHrh96cNVOnEORuYs8OuP89KLBzHtrHopB1mOEn18cCiAsoDplNR4Y4oNV2V+DBVu2TpRWewlJaMyw=
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm5584660wms.41.2024.02.04.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:39:40 -0800 (PST)
Date: Sun, 4 Feb 2024 07:39:36 -0500
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
Message-ID: <20240204070920-mutt-send-email-mst@kernel.org>
References: <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>

On Sun, Feb 04, 2024 at 09:20:18AM +0800, Jason Wang wrote:
> On Sat, Feb 3, 2024 at 12:01 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > Can you say more? I'm curious what's your use case.
> > >
> > > I'm not working at Nvidia, so my point of view may differ from theirs.
> > > From what I can tell is that those two counters help me narrow down
> > > the range if I have to diagnose/debug some issues.
> >
> > right, i'm asking to collect useful debugging tricks, nothing against
> > the patch itself :)
> >
> > > 1) I sometimes notice that if some irq is held too long (say, one
> > > simple case: output of printk printed to the console), those two
> > > counters can reflect the issue.
> > > 2) Similarly in virtio net, recently I traced such counters the
> > > current kernel does not have and it turned out that one of the output
> > > queues in the backend behaves badly.
> > > ...
> > >
> > > Stop/wake queue counters may not show directly the root cause of the
> > > issue, but help us 'guess' to some extent.
> >
> > I'm surprised you say you can detect stall-related issues with this.
> > I guess virtio doesn't have BQL support, which makes it special.
> 
> Yes, virtio-net has a legacy orphan mode, this is something that needs
> to be dropped in the future. This would make BQL much more easier to
> be implemented.


It's not that we can't implement BQL, it's that it does not seem to
be benefitial - has been discussed many times.

> > Normal HW drivers with BQL almost never stop the queue by themselves.
> > I mean - if they do, and BQL is active, then the system is probably
> > misconfigured (queue is too short). This is what we use at Meta to
> > detect stalls in drivers with BQL:
> >
> > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
> >
> > Daniel, I think this may be a good enough excuse to add per-queue stats
> > to the netdev genl family, if you're up for that. LMK if you want more
> > info, otherwise I guess ethtool -S is fine for now.
> >
> 
> Thanks


