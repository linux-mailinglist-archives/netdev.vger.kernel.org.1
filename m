Return-Path: <netdev+bounces-74790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1163F862CD4
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 21:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D11C210FB
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1EEADD;
	Sun, 25 Feb 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7YStHhZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B171B807
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892781; cv=none; b=MjPsCf98ETdCfodUuvHQAUrweV9lTxOsVOoEI0523o6iuAn3uGIZUj2rGx29OKWl81KgCwAcpwks/diu98/HU8OPBPsy+lj7QHCOYPpEfQWUzEwPfDHWMV3n6GtQMo0x4ijErqu+pXtWSP+XbdJoFIINiaqKuHkTJaK/j8CCvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892781; c=relaxed/simple;
	bh=uia9Xpa1Ux/c4AXYRfNZbxYrdciWIwDldX5aSUd5yRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJvPbhvmGAdae+/2WoCI6iGgAEHIYnLQitYdYjzHngSmsqOPdCut5ZEKcYPWfHhYwn2SsKeN7uXcAmVZT8nx9+AkHTxbyzCN5UgUW9nj1hlenUJe7hHlyVanodsOLcKtyPX9KIwC+bp53+WhVR7BHyG3frUMwfhiR8S+Qm4JHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7YStHhZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708892778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3ytopfXqBqOL1Vu/I3rG4YfjxYxF7yRKyhbp2kFyno=;
	b=H7YStHhZux5RCNFJE2zK/JyJ5Yy/3fneHCrNsdg/JHtRP7QWMbYXNR1UvD9w62U97Cm0Oa
	Vor7lagXx/XqxNHZX4IByIpMjyus7d++jWbXxUoUEiDWOlB2AgfByl9Kwd8919kxvTaeBY
	YW1z3ziTm5UZhdz8Pv+Mmi15W9ukK4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-2s-ALWGuMZWQlNrcJnYhLw-1; Sun, 25 Feb 2024 15:26:17 -0500
X-MC-Unique: 2s-ALWGuMZWQlNrcJnYhLw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41296d7c800so12072735e9.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 12:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708892775; x=1709497575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3ytopfXqBqOL1Vu/I3rG4YfjxYxF7yRKyhbp2kFyno=;
        b=KvOxxsjuSEyzrJCn7qLsKSOc3mxZXXN1UqUhjjJAgYeuuwkj1nBMpqjAp0CgaXXs8s
         uRK1A0vkM8Tp7gfs3sNFNv8MTtzNpIWS/EaDbCzhgGjHpmA9H/qson2i3FzrPw2og+We
         v3rmQKe7aGXvcDOpYD6UnlM02IYbGI7si+HhTFhmU0467Q8J/O+Ml+rQXSqBEUmOUjGE
         pAz6YeUcvFutankVZvjPHrlhSG98alrS3VoQS1t9cezDmzKjl0qybck41Ln4+6jJhHEe
         +bxCOUnZBRjZa0b80Nqj/rxa3a4g05ULYmQjoqHcn+MyFU5mQD3Z0mUzllQcYN7o4sdT
         IM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6hsRz2HzCXv+9q4Uc3U/rf3NhhZ9IzmLIB0jqiar5na/XrGrfK+BdIt5IECIHY66C7T83yBI+JXDW5f8fRUk4UkKSCMWV
X-Gm-Message-State: AOJu0YznF1Hr1dwcD7hZCeYk4YhrQ6mHn6g/M0634n8A7R0RwSUkcXqT
	lhfTksChTFZ+6fBw/HLXT0ecwlwA/xVnIzufA7D+zt+pDYj0WffxNr/ut2w4mDabtfEHCorqn8i
	6CGOKozBBXbawLgsgMIHMt7gxorInn1WuO/Tc6sx+aDD0H2idFoBXoA==
X-Received: by 2002:a05:600c:4885:b0:410:f5d2:cbe5 with SMTP id j5-20020a05600c488500b00410f5d2cbe5mr3903022wmp.37.1708892774878;
        Sun, 25 Feb 2024 12:26:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM/Hc5aKEKDw17cQ7DrumqyLC5t7v2MRdRvGOBVg16+X6zFVBJiqvGL5wqhJhU7eoliAdjow==
X-Received: by 2002:a05:600c:4885:b0:410:f5d2:cbe5 with SMTP id j5-20020a05600c488500b00410f5d2cbe5mr3903019wmp.37.1708892774498;
        Sun, 25 Feb 2024 12:26:14 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040fd1629443sm5967317wmo.18.2024.02.25.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:26:13 -0800 (PST)
Date: Sun, 25 Feb 2024 15:26:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dave Taht <dave.taht@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, hengqi@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: Re: virtio-net + BQL
Message-ID: <20240225145946-mutt-send-email-mst@kernel.org>
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
 <20240225133416-mutt-send-email-mst@kernel.org>
 <CAA93jw4DMnDMzzggDzBczvppgWWwu5tzcA=hOKOobVxJ7Se5xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA93jw4DMnDMzzggDzBczvppgWWwu5tzcA=hOKOobVxJ7Se5xw@mail.gmail.com>

On Sun, Feb 25, 2024 at 01:58:53PM -0500, Dave Taht wrote:
> On Sun, Feb 25, 2024 at 1:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 23, 2024 at 07:58:34AM -0500, Dave Taht wrote:
> > > On Fri, Feb 23, 2024 at 3:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > Hi Dave,
> > > >
> > > > We study the BQL recently.
> > > >
> > > > For virtio-net, the skb orphan mode is the problem for the BQL. But now, we have
> > > > netdim, maybe it is time for a change. @Heng is working for the netdim.
> > > >
> > > > But the performance number from https://lwn.net/Articles/469652/ has not appeal
> > > > to me.
> > > >
> > > > The below number is good, but that just work when the nic is busy.
> > > >
> > > >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> > > >         BQL, tso on: 156-194K bytes in queue, 535 tps
> > >
> > > That is data from 2011 against a gbit interface. Each of those BQL
> > > queues is additive.
> > >
> > > > Or I miss something.
> > >
> > > What I see nowadays is 16+Mbytes vanishing into ring buffers and
> > > affecting packet pacing, and fair queue and QoS behaviors. Certainly
> > > my own efforts with eBPF and LibreQos are helping observability here,
> > > but it seems to me that the virtualized stack is not getting enough
> > > pushback from the underlying cloudy driver - be it this one, or nitro.
> > > Most of the time the packet shaping seems to take place in the cloud
> > > network or driver on a per-vm basis.
> > >
> > > I know that adding BQL to virtio has been tried before, and I keep
> > > hoping it gets tried again,
> > > measuring latency under load.
> > >
> > > BQL has sprouted some new latency issues since 2011 given the enormous
> > > number of hardware queues exposed which I talked about a bit in my
> > > netdevconf talk here:
> > >
> > > https://www.youtube.com/watch?v=rWnb543Sdk8&t=2603s
> > >
> > > I am also interested in how similar AI workloads are to the infamous
> > > rrul test in a virtualized environment also.
> > >
> > > There is also AFAP thinking mis-understood-  with a really
> > > mind-bogglingly-wrong application of it documented over here, where
> > > 15ms of delay in the stack is considered good.
> > >
> > > https://github.com/cilium/cilium/issues/29083#issuecomment-1824756141
> > >
> > > So my overall concern is a bit broader than "just add bql", but in
> > > other drivers, it was only 6 lines of code....
> > >
> > > > Thanks.
> > > >
> > >
> > >
> >
> > It is less BQL it is more TCP small queues which do not
> > seem to work well when your kernel isn't running part of the
> > time because hypervisor scheduled it out. wireless has some
> > of the same problem with huge variance in latency unrelated
> > to load and IIRC worked around that by
> > tuning socket queue size slightly differently.
> 
> Add that to the problems-with-virtualization list, then. :/

yep

for example, attempts to drop packets to fight bufferbloat do
not work well because as you start dropping packets you have less
work to do on host and so VM starts going even faster
flooding you with even more packets.

virtualization has to be treated more like userspace than like
a physical machine.


> I was
> aghast at a fix jakub put in to kick things at 7ms that went by
> recently.

which one is it?

> Wireless is kind of an overly broad topic. I was (6 years ago) pretty
> happy with all the fixes we put in there for WiFi softmac devices, the
> mt76 and the new mt79 seem to be performing rather well. Ath9k is
> still good, ath10k not horrible, I have no data about ath11k, and
> let's not talk about the Broadcom nightmare.
> 
> This was still a pretty good day, in my memory:
> https://forum.openwrt.org/t/aql-and-the-ath10k-is-lovely/59002
> 
> Is something else in wif igoing to hell? There are still, oh, 200
> drivers left to fix. ENOFUNDING.
> 
> And so far as I know the 3GPP (5g) work is entirely out of tree and
> almost entirely dpdk or ebpf?
> 
> >
> >
> > --
> > MST
> >
> 
> 
> -- 
> https://blog.cerowrt.org/post/2024_predictions/
> Dave Täht CSO, LibreQos


