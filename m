Return-Path: <netdev+bounces-74902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4668673A1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C71C250E9
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397811D54F;
	Mon, 26 Feb 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyKxSQRr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840461D54B
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947777; cv=none; b=ukr9mBD/yYPlWGxek5SnilR917eO32745FkY3GR0Z2A0Zy0IBjZOpC1D6csm/7LFjPtPIx9d4f9rsv/CSua9GymMWpFOjsIVFMdVaf2KXqzGvzENqJSr1AnO/3iiBXPGxq76fEjPHGi2L57IJheHeOUYOUkRJB6PnvnF4ijdLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947777; c=relaxed/simple;
	bh=ZiBqULMYtMzYt5A3Fw07mq6o6VC97VJcohEnmh1NlvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2VoFCDTGlTwhrLDy2jg36xxVWa5pkMqYBaMAdKZl+PzaRD2uoPv0V7+U95h/y9cWArtonkiK2HgGopFlaHbOtVBE5I+ougBaR8MER4WAFaijSnjkkW4FsbZ5i3EYkdAz8z9w/SWeqTD751E/9FtwavdQ0TnNA86vYmGTlPYIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyKxSQRr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708947774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQCAoFD9WmHXFMv8OaeKRB/dRBOv1MsyOoIJaFgQRco=;
	b=SyKxSQRrRkTUKQZnlMkGsxmvzw3hv63Fy01Bm0zYsVBzHWULENk9vLyr0yQD/Tgul6lbsT
	D2M8baD8J5378KM/Herz59XHVszNumTN6fUn7bwda7bd9vXulU7JzP4ke7DGIoY+uPBxui
	/B1KFfl5twD/vaRizRSBPO/ueJLHeTo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-7AaeDy9HOBON4qrfEL-Z9A-1; Mon, 26 Feb 2024 06:42:53 -0500
X-MC-Unique: 7AaeDy9HOBON4qrfEL-Z9A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-512e6d29386so2275710e87.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947771; x=1709552571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQCAoFD9WmHXFMv8OaeKRB/dRBOv1MsyOoIJaFgQRco=;
        b=E2qyVevtcC1cx7PVQnphD2CoB9vqHaxS3WSAmxZEzKJIGw0Q8ozmnuRizjv/GmfyfM
         tuD+yWEXYStJLsFlVmqnn+fpzSU71bjKE8BnF4K1SZhhj9UPTNeKKfE2cMRAB2Vm6BB+
         UTIMs+utHdh1i72hyWLR6OzM+YmAp334emxK2VcuUvWGDf0q1zUAF1o5DZb9shu0J6fr
         +ATUb1rQM16MAxvvvYxdyxleZV2JHZ9wAq4EKgYgqJFtrpSJ2J5taxngKdEk8P44y79X
         F7BfY/+rNNdOqodQrzZJpzuEqAHRrp5O4dCEhzFnHzcuwaQpgndMqK2KevEkhtopeyPY
         UK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEb2wcpw/onkxJbGWGqMZb0pFdnBuuFfaVMAEjW5UK9NmvRP9n5bw5QrlmR/w97yH9B5dyOh0TPMi0DGw1AYjXLyi8HRzv
X-Gm-Message-State: AOJu0YymSwcF4AwQjrV9gJQED0cwddgiipN5WSth+5vDRmZM0jCIEjNd
	PhQP/e/KVLSSrb7S1g7NFtEcYax8RNojYhyf3IDt/m0nB9TtSYJ5OYUk85EbPqbC1IfhqVZlhtq
	Qudj2WppMH3s7ybMzG9Go7VIyRGAEHGSNRxW4+lv+qM6rfl0xRKGLWg==
X-Received: by 2002:a05:6512:10c7:b0:512:f306:414e with SMTP id k7-20020a05651210c700b00512f306414emr4378226lfg.63.1708947770771;
        Mon, 26 Feb 2024 03:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL1AVum5a0eU6CBsVMR1IzClJPwi9qR+b2M278D25P9WZknylZSPqH5RxDTmPmE9MONWd94w==
X-Received: by 2002:a05:6512:10c7:b0:512:f306:414e with SMTP id k7-20020a05651210c700b00512f306414emr4378212lfg.63.1708947770399;
        Mon, 26 Feb 2024 03:42:50 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b0033cf80ad6f5sm7974579wrs.60.2024.02.26.03.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:42:49 -0800 (PST)
Date: Mon, 26 Feb 2024 06:42:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dave Taht <dave.taht@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	hengqi@linux.alibaba.com, netdev@vger.kernel.org
Subject: Re: virtio-net + BQL
Message-ID: <20240226064023-mutt-send-email-mst@kernel.org>
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
 <20240225133416-mutt-send-email-mst@kernel.org>
 <CAA93jw4DMnDMzzggDzBczvppgWWwu5tzcA=hOKOobVxJ7Se5xw@mail.gmail.com>
 <20240225145946-mutt-send-email-mst@kernel.org>
 <CACGkMEuFRQW6TFkF8KSHd7kGQH991pj_fCAT8BkMt8T51mEbWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuFRQW6TFkF8KSHd7kGQH991pj_fCAT8BkMt8T51mEbWg@mail.gmail.com>

On Mon, Feb 26, 2024 at 01:03:12PM +0800, Jason Wang wrote:
> On Mon, Feb 26, 2024 at 4:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Feb 25, 2024 at 01:58:53PM -0500, Dave Taht wrote:
> > > On Sun, Feb 25, 2024 at 1:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Feb 23, 2024 at 07:58:34AM -0500, Dave Taht wrote:
> > > > > On Fri, Feb 23, 2024 at 3:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >
> > > > > > Hi Dave,
> > > > > >
> > > > > > We study the BQL recently.
> > > > > >
> > > > > > For virtio-net, the skb orphan mode is the problem for the BQL. But now, we have
> > > > > > netdim, maybe it is time for a change. @Heng is working for the netdim.
> > > > > >
> > > > > > But the performance number from https://lwn.net/Articles/469652/ has not appeal
> > > > > > to me.
> > > > > >
> > > > > > The below number is good, but that just work when the nic is busy.
> > > > > >
> > > > > >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> > > > > >         BQL, tso on: 156-194K bytes in queue, 535 tps
> > > > >
> > > > > That is data from 2011 against a gbit interface. Each of those BQL
> > > > > queues is additive.
> > > > >
> > > > > > Or I miss something.
> > > > >
> > > > > What I see nowadays is 16+Mbytes vanishing into ring buffers and
> > > > > affecting packet pacing, and fair queue and QoS behaviors. Certainly
> > > > > my own efforts with eBPF and LibreQos are helping observability here,
> > > > > but it seems to me that the virtualized stack is not getting enough
> > > > > pushback from the underlying cloudy driver - be it this one, or nitro.
> > > > > Most of the time the packet shaping seems to take place in the cloud
> > > > > network or driver on a per-vm basis.
> > > > >
> > > > > I know that adding BQL to virtio has been tried before, and I keep
> > > > > hoping it gets tried again,
> > > > > measuring latency under load.
> > > > >
> > > > > BQL has sprouted some new latency issues since 2011 given the enormous
> > > > > number of hardware queues exposed which I talked about a bit in my
> > > > > netdevconf talk here:
> > > > >
> > > > > https://www.youtube.com/watch?v=rWnb543Sdk8&t=2603s
> > > > >
> > > > > I am also interested in how similar AI workloads are to the infamous
> > > > > rrul test in a virtualized environment also.
> > > > >
> > > > > There is also AFAP thinking mis-understood-  with a really
> > > > > mind-bogglingly-wrong application of it documented over here, where
> > > > > 15ms of delay in the stack is considered good.
> > > > >
> > > > > https://github.com/cilium/cilium/issues/29083#issuecomment-1824756141
> > > > >
> > > > > So my overall concern is a bit broader than "just add bql", but in
> > > > > other drivers, it was only 6 lines of code....
> > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > >
> > > >
> > > > It is less BQL it is more TCP small queues which do not
> > > > seem to work well when your kernel isn't running part of the
> > > > time because hypervisor scheduled it out. wireless has some
> > > > of the same problem with huge variance in latency unrelated
> > > > to load and IIRC worked around that by
> > > > tuning socket queue size slightly differently.
> > >
> > > Add that to the problems-with-virtualization list, then. :/
> >
> > yep
> >
> > for example, attempts to drop packets to fight bufferbloat do
> > not work well because as you start dropping packets you have less
> > work to do on host and so VM starts going even faster
> > flooding you with even more packets.
> >
> > virtualization has to be treated more like userspace than like
> > a physical machine.
> 
> Probaby, but I think we need a new rfc with a benchmark for more
> information (there's no need to bother with the mode switching so it
> should be a tiny patch).
> 
> One interesting thing is that gve implements bql.
> 
> Thanks

Yea all this talk is rather pointless. Someone interested has to try.
Trying to activate the zerocopy tx machinery in vhost even for when
packet is actually copied could be one way to create feedback into VM.


> >
> >
> > > I was
> > > aghast at a fix jakub put in to kick things at 7ms that went by
> > > recently.
> >
> > which one is it?
> >
> > > Wireless is kind of an overly broad topic. I was (6 years ago) pretty
> > > happy with all the fixes we put in there for WiFi softmac devices, the
> > > mt76 and the new mt79 seem to be performing rather well. Ath9k is
> > > still good, ath10k not horrible, I have no data about ath11k, and
> > > let's not talk about the Broadcom nightmare.
> > >
> > > This was still a pretty good day, in my memory:
> > > https://forum.openwrt.org/t/aql-and-the-ath10k-is-lovely/59002
> > >
> > > Is something else in wif igoing to hell? There are still, oh, 200
> > > drivers left to fix. ENOFUNDING.
> > >
> > > And so far as I know the 3GPP (5g) work is entirely out of tree and
> > > almost entirely dpdk or ebpf?
> > >
> > > >
> > > >
> > > > --
> > > > MST
> > > >
> > >
> > >
> > > --
> > > https://blog.cerowrt.org/post/2024_predictions/
> > > Dave Täht CSO, LibreQos
> >


