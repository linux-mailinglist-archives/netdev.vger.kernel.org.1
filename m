Return-Path: <netdev+bounces-69985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9784D2C8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4633F2820ED
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCA126F37;
	Wed,  7 Feb 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/NiVXGZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9185C7A
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337158; cv=none; b=NPc0YfIwFZaSNwVRt5a0JAuYDNAyNqFoYiFg/ZOH++8AF85c2g2L/AkKc7Tk+5t/wVg29rRtVG7XBvSZKtQKo+bEqgl2ukiaOpqR2xZ+yLk3vg69KNKoT4g0AGRavy2EJmh9nikBiV2xkTX3M9+rjkwjT0rz41Q6gy+O+1VbCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337158; c=relaxed/simple;
	bh=jHRLhustSZ7Cq7Dnz0cVwfN6/0XBTVIlkNLk4yEVxq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN3z2P+BATLFShU6pmTvy8/6JcGqmEOZvX82rkANwkrC/y6rzwmvHzk+l1u2yFjKGJ23J6eh79bcWIVnG+XWn98vRtIpgUL3MBnLD0h6YQgp20rpQxiHJyvDWPc5C9yYZlAVGPEHFBKgYPCsXfIJ9Mv0Jh3uwypkC7znC3H1nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/NiVXGZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707337155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbLOhWUxPT8y2mEi5eZce24NWfspLCNIf9Y9v+SSByg=;
	b=D/NiVXGZQgqSqQQ6A/YMBG0Y+Ja3aQP0oeMTEV9WM9pj90FqOEgsJIMK9CUmvaSIDf20h5
	KwTq6YRmnFinLy99slJ3SR6jHKoydyYzg55RRYZYY75Tu84NAFJawH9gBhorsbW8fWV/iF
	0CkC7ncFZgAOTDpUkHxRkMc1GCYVfkE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-mYLTQjE6Om28XAYFRY2glw-1; Wed, 07 Feb 2024 15:19:14 -0500
X-MC-Unique: mYLTQjE6Om28XAYFRY2glw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ff7e36f34so6291455e9.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337153; x=1707941953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbLOhWUxPT8y2mEi5eZce24NWfspLCNIf9Y9v+SSByg=;
        b=OPMqFKqMKkf6EEDHpCuiovz28WKT6Pq0AIINE4VwMLnLm9WTsFxo1s92atbvDNhzox
         giEU/lwqQQHidA0y8n24PvWMTBqbKdjGRXxJWsYMMFUdn3wWnzx0QR0p5EIALa1nmI0A
         zsrOFUsczcstgPPxkiJi4v8eh9N9xP6eXIwHwv3q/VqnExQsvJJ4s04XCZuWA0thQSab
         sUFw2SeMDFYU5ixhvqC7xUz28O5KetN1IMEs/5xbeLhUIUPCLKYdQVez0z7f7zoMJiyC
         l2H+6Re88ggXaXZKC7O3jWHSvTuqjUzUGcYWatRxLqHKp7b8qJLdXivzIQJvdTEZb3ye
         thRQ==
X-Gm-Message-State: AOJu0Yw+lfzLkNmonxkF+4oCqBn+8FYfVafuJMVX9j5MBfvSXVXQTApX
	HuelVWWYT/6Og0tJUSV1oI2S4pRW8vTf2LQYCNUIZx5EuAWOdKYgG9+tJxwHlN9/TNvXlBgvdKH
	LijOl7Kei/Z7JB2qwwwEutjIuIxnBndFtcG6jgtOI2zm4oJinMRrkVQ==
X-Received: by 2002:a05:600c:4f09:b0:40f:ed18:f74b with SMTP id l9-20020a05600c4f0900b0040fed18f74bmr3929128wmq.35.1707337153316;
        Wed, 07 Feb 2024 12:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4K5LEkmCBBHJnDtSTQhMePoD0VRob0a8WuweUykV4ofhnCGotQMYYU6xP8VbCeXeLXVRqeQ==
X-Received: by 2002:a05:600c:4f09:b0:40f:ed18:f74b with SMTP id l9-20020a05600c4f0900b0040fed18f74bmr3929116wmq.35.1707337153003;
        Wed, 07 Feb 2024 12:19:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkYWRI60f6eJUMa4KvcTOpuTKkytbC/nBvPjrEUFs30DM6iq6L/QShZHRsPmfw+5OE1tKBtLGJcF94g1kmdKmHpHnAWeySQ/uUsrCV3QZShpyKXTFpms1cnWAQNGtx424DXTD4NW3D8zl1WU7e0F2bJGy3Vq4Bmt+qUrrOHHhUI8dMjoEqMj+OyBJx98zaIXczWTFcgfeciXumc2EANUb2ynTm852RhhfIcwqTm5p6ftHUznpX9et7AODQWg9JoJ/sPCfJvzq6x/3UNo6S3g/Rp9Eye+N/irntcEsUfO0LpbgWAJqp3XHoPzZ+SnRkkVZVKKCUawsr6CkIHKw=
Received: from redhat.com ([2a02:14f:173:89f9:ff9e:3e5c:f749:4dfb])
        by smtp.gmail.com with ESMTPSA id r18-20020adfe692000000b0033afc81fc00sm2205014wrm.41.2024.02.07.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:19:12 -0800 (PST)
Date: Wed, 7 Feb 2024 15:19:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240207151748-mutt-send-email-mst@kernel.org>
References: <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>

On Wed, Feb 07, 2024 at 07:38:16PM +0000, Daniel Jurgens wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, February 4, 2024 6:40 AM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>; Jason Xing
> > <kerneljasonxing@gmail.com>; Daniel Jurgens <danielj@nvidia.com>;
> > netdev@vger.kernel.org; xuanzhuo@linux.alibaba.com;
> > virtualization@lists.linux.dev; davem@davemloft.net;
> > edumazet@google.com; abeni@redhat.com; Parav Pandit
> > <parav@nvidia.com>
> > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
> > 
> > On Sun, Feb 04, 2024 at 09:20:18AM +0800, Jason Wang wrote:
> > > On Sat, Feb 3, 2024 at 12:01 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > > Can you say more? I'm curious what's your use case.
> > > > >
> > > > > I'm not working at Nvidia, so my point of view may differ from theirs.
> > > > > From what I can tell is that those two counters help me narrow
> > > > > down the range if I have to diagnose/debug some issues.
> > > >
> > > > right, i'm asking to collect useful debugging tricks, nothing
> > > > against the patch itself :)
> > > >
> > > > > 1) I sometimes notice that if some irq is held too long (say, one
> > > > > simple case: output of printk printed to the console), those two
> > > > > counters can reflect the issue.
> > > > > 2) Similarly in virtio net, recently I traced such counters the
> > > > > current kernel does not have and it turned out that one of the
> > > > > output queues in the backend behaves badly.
> > > > > ...
> > > > >
> > > > > Stop/wake queue counters may not show directly the root cause of
> > > > > the issue, but help us 'guess' to some extent.
> > > >
> > > > I'm surprised you say you can detect stall-related issues with this.
> > > > I guess virtio doesn't have BQL support, which makes it special.
> > >
> > > Yes, virtio-net has a legacy orphan mode, this is something that needs
> > > to be dropped in the future. This would make BQL much more easier to
> > > be implemented.
> > 
> > 
> > It's not that we can't implement BQL, it's that it does not seem to be
> > benefitial - has been discussed many times.
> > 
> > > > Normal HW drivers with BQL almost never stop the queue by themselves.
> > > > I mean - if they do, and BQL is active, then the system is probably
> > > > misconfigured (queue is too short). This is what we use at Meta to
> > > > detect stalls in drivers with BQL:
> > > >
> > > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.or
> > > > g/
> > > >
> > > > Daniel, I think this may be a good enough excuse to add per-queue
> > > > stats to the netdev genl family, if you're up for that. LMK if you
> > > > want more info, otherwise I guess ethtool -S is fine for now.
> > > >
> > >
> > > Thanks
> 
> Michael,
> 	Are you OK with this patch? Unless I missed it I didn't see a response from you in our conversation the day I sent it.
> 

I thought what is proposed is adding some support for these stats to core?
Did I misunderstood?

-- 
MST


