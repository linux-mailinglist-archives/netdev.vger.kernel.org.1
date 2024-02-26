Return-Path: <netdev+bounces-74816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C3586697D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 06:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4B328136E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 05:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5C18EA1;
	Mon, 26 Feb 2024 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwoJb+vo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED10101C4
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708923809; cv=none; b=VmcFAEkknZmBPBkZaGigKcfnujjVoaaOZiPiFEPBkNx6p94K8OBzF59CuGg6Le+0HnNR+TsoPb95171XEO8qM0n32qohcdv5WWGYFro4WB7wLfUA83vNukSG+N6rlTCB8YtgMQKZqLR7K3c/aQ9gEVd8m8YroQgvts17gphfhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708923809; c=relaxed/simple;
	bh=a3tEgyaJCtPG/p3fVcd1CgAnCegNQ8ZsfgH1ZWFhhIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVQT77YQsSPSFcSSNYMhBDeKvq9pD1iOsoQJ5o6Kce4v+Ioqsp9KSDUlZhNrmCGtCQyr+xXRcMzj1/hFXIg2VNDWjlvzQjFMa9Je4w5+ltaqMULL4Uld3FNdkeoDrFAwk9eE6cbzqDVvJb8sb4jFJeQw3JVB6QKD+p7qHK7DN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwoJb+vo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708923806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTvrw5muOxvvYI3cWfdC2xiirxyCiY1jvcXxIyw2mqg=;
	b=fwoJb+voCCRXw3+5kihXGgERh8e5TSWJHJEnVCOh4bkgD4yWMynsaYCtWOEfc87be01rX0
	0Wr330IplHxyjESEusc6dBH907s5HXw6iLH8xT90nF8QnEoiBYR90ZgKUEKYnNrJxPaGyv
	dYJtOFKfFCpqfxd72xorSqGPpGSZ69c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-DyzylVbsOE-PeMiiAT5g4Q-1; Mon, 26 Feb 2024 00:03:25 -0500
X-MC-Unique: DyzylVbsOE-PeMiiAT5g4Q-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dbcf647a9dso18043135ad.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 21:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708923804; x=1709528604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTvrw5muOxvvYI3cWfdC2xiirxyCiY1jvcXxIyw2mqg=;
        b=RF8PU8dfAicJa3eAay5oLOMoP7InFh+ithDjnQwnZSlc1ZbEy78ZNlYY14Ag5zO0BK
         6m4uy96UDIUU3OZZ3wITFYET5pM/WPMj08fkbJ1XoRTQhxNijmKq5xwS4qwBiqi0/gkP
         DglCPd4ufNfqd+NhTKrcm6gdUrWGKcje+uxss08jNCY+e96apiyApf9gklsnzSRq+gXn
         5jwi3DQuP/4se1JyiQM12+TDNawBJxVStQYpyh5WumRhaTVwki7ckC6leDlPQ0MDtGHg
         3E8+M00ysrTI/2Fmr6d4uGzCn8gV7Pm87GH3UNqv92BKd9QrnpUb0Moi+vJ4U4lQKst3
         iODA==
X-Forwarded-Encrypted: i=1; AJvYcCVYVbW/HneRt98899zFAGkXMxhRnu9/QN2sucTtR4L0ktUoHc8gAMkQbyXKb6oN/q8CaY42g7Gzz6ccsmzmq5f86oi70FhA
X-Gm-Message-State: AOJu0Yxr+CxN8dIW5KbD1OIoU1bj19qi2TYQHqE6yNU7aiPGzu9gM4jA
	b70szgrQE4TaDvX5QRWcZ22jG7ejwHIoy7jadhy9KaDAyz3rTmeDtFpR5grMhmHaScxQt/oagW8
	KPNUazBh9B3d5+qWvfoRBFAbPJBUvl8fXKqEJtxZnpuFu48oQeimBfZ8uTY3Cw3pg8KGVLVDuUi
	BUPXckysXVEUy9hE5SudmEb2XrS8ZG
X-Received: by 2002:a17:903:2447:b0:1db:cf64:7331 with SMTP id l7-20020a170903244700b001dbcf647331mr8002163pls.13.1708923803852;
        Sun, 25 Feb 2024 21:03:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFUmeTA+/ExLnN9SAAROrp6Trci1fDHliS70EzZoHXWxf87Y4AIxRRU8H8CAsD7uPwkKiXN6bgMUSwJDZP40Q=
X-Received: by 2002:a17:903:2447:b0:1db:cf64:7331 with SMTP id
 l7-20020a170903244700b001dbcf647331mr8002144pls.13.1708923803519; Sun, 25 Feb
 2024 21:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
 <20240225133416-mutt-send-email-mst@kernel.org> <CAA93jw4DMnDMzzggDzBczvppgWWwu5tzcA=hOKOobVxJ7Se5xw@mail.gmail.com>
 <20240225145946-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240225145946-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 13:03:12 +0800
Message-ID: <CACGkMEuFRQW6TFkF8KSHd7kGQH991pj_fCAT8BkMt8T51mEbWg@mail.gmail.com>
Subject: Re: virtio-net + BQL
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dave Taht <dave.taht@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	hengqi@linux.alibaba.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:26=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Feb 25, 2024 at 01:58:53PM -0500, Dave Taht wrote:
> > On Sun, Feb 25, 2024 at 1:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Feb 23, 2024 at 07:58:34AM -0500, Dave Taht wrote:
> > > > On Fri, Feb 23, 2024 at 3:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > Hi Dave,
> > > > >
> > > > > We study the BQL recently.
> > > > >
> > > > > For virtio-net, the skb orphan mode is the problem for the BQL. B=
ut now, we have
> > > > > netdim, maybe it is time for a change. @Heng is working for the n=
etdim.
> > > > >
> > > > > But the performance number from https://lwn.net/Articles/469652/ =
has not appeal
> > > > > to me.
> > > > >
> > > > > The below number is good, but that just work when the nic is busy=
.
> > > > >
> > > > >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> > > > >         BQL, tso on: 156-194K bytes in queue, 535 tps
> > > >
> > > > That is data from 2011 against a gbit interface. Each of those BQL
> > > > queues is additive.
> > > >
> > > > > Or I miss something.
> > > >
> > > > What I see nowadays is 16+Mbytes vanishing into ring buffers and
> > > > affecting packet pacing, and fair queue and QoS behaviors. Certainl=
y
> > > > my own efforts with eBPF and LibreQos are helping observability her=
e,
> > > > but it seems to me that the virtualized stack is not getting enough
> > > > pushback from the underlying cloudy driver - be it this one, or nit=
ro.
> > > > Most of the time the packet shaping seems to take place in the clou=
d
> > > > network or driver on a per-vm basis.
> > > >
> > > > I know that adding BQL to virtio has been tried before, and I keep
> > > > hoping it gets tried again,
> > > > measuring latency under load.
> > > >
> > > > BQL has sprouted some new latency issues since 2011 given the enorm=
ous
> > > > number of hardware queues exposed which I talked about a bit in my
> > > > netdevconf talk here:
> > > >
> > > > https://www.youtube.com/watch?v=3DrWnb543Sdk8&t=3D2603s
> > > >
> > > > I am also interested in how similar AI workloads are to the infamou=
s
> > > > rrul test in a virtualized environment also.
> > > >
> > > > There is also AFAP thinking mis-understood-  with a really
> > > > mind-bogglingly-wrong application of it documented over here, where
> > > > 15ms of delay in the stack is considered good.
> > > >
> > > > https://github.com/cilium/cilium/issues/29083#issuecomment-18247561=
41
> > > >
> > > > So my overall concern is a bit broader than "just add bql", but in
> > > > other drivers, it was only 6 lines of code....
> > > >
> > > > > Thanks.
> > > > >
> > > >
> > > >
> > >
> > > It is less BQL it is more TCP small queues which do not
> > > seem to work well when your kernel isn't running part of the
> > > time because hypervisor scheduled it out. wireless has some
> > > of the same problem with huge variance in latency unrelated
> > > to load and IIRC worked around that by
> > > tuning socket queue size slightly differently.
> >
> > Add that to the problems-with-virtualization list, then. :/
>
> yep
>
> for example, attempts to drop packets to fight bufferbloat do
> not work well because as you start dropping packets you have less
> work to do on host and so VM starts going even faster
> flooding you with even more packets.
>
> virtualization has to be treated more like userspace than like
> a physical machine.

Probaby, but I think we need a new rfc with a benchmark for more
information (there's no need to bother with the mode switching so it
should be a tiny patch).

One interesting thing is that gve implements bql.

Thanks

>
>
> > I was
> > aghast at a fix jakub put in to kick things at 7ms that went by
> > recently.
>
> which one is it?
>
> > Wireless is kind of an overly broad topic. I was (6 years ago) pretty
> > happy with all the fixes we put in there for WiFi softmac devices, the
> > mt76 and the new mt79 seem to be performing rather well. Ath9k is
> > still good, ath10k not horrible, I have no data about ath11k, and
> > let's not talk about the Broadcom nightmare.
> >
> > This was still a pretty good day, in my memory:
> > https://forum.openwrt.org/t/aql-and-the-ath10k-is-lovely/59002
> >
> > Is something else in wif igoing to hell? There are still, oh, 200
> > drivers left to fix. ENOFUNDING.
> >
> > And so far as I know the 3GPP (5g) work is entirely out of tree and
> > almost entirely dpdk or ebpf?
> >
> > >
> > >
> > > --
> > > MST
> > >
> >
> >
> > --
> > https://blog.cerowrt.org/post/2024_predictions/
> > Dave T=C3=A4ht CSO, LibreQos
>


