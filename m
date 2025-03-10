Return-Path: <netdev+bounces-173558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F286A59740
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77501883B34
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB722AE7E;
	Mon, 10 Mar 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvqy9ro0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D21386C9
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616115; cv=none; b=bFC1g5GtwgzJkrJdRmwcDjuMSRRNrNRAKE2Wdcif3RRcwTefJbrxckn46laDaUoMsEgyMquArylx9fhwp0q/RYQKAzIElWbh2qw9Q57TdXnNLgd/2GewMA0SD6KQxSJZceuevzmhI/jyWbADzP7pfUs0K2jxxjpfjqoz8yn4Q5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616115; c=relaxed/simple;
	bh=jEa1MxsrpS1cHMT2RYO8VBbSWB07INDb5JSIrlBAMRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdzdDQpK2ZwlljIyTcwiV1VYEbis7Hh81Lqyh4RlM+7F61eFbvUr6cuPUWOryHU5gPheFri737ZvDbZrjP+1YHJOO5W820xj2kFLM1MTwVqZLpcTWdoPLb5ALVg/9sPYiSp0/+lyTPqOGQXVbydYE2kjpjDCWEb5ttmhtXj+41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvqy9ro0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741616113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMdCg2efbd0Qh20QNdOF7eXxFbnyvCBURzGryJnLYK4=;
	b=Pvqy9ro0SVzG5zXxSi6sYMDWApwuW42+xZeDpeFOpDFX2DJ4Q5bIu8e0HHLCaXt2SS3+jH
	Rqs7KZmqJLTQkbU0f4yIRYGJKPCnP5XOstwKil7q4fRKQpbOZl9nIllqBEijR6eBKGDkDM
	l1z28aRIvkdyRo293Vqq4BqZDHmmcm0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-EWewh_qBMS68bOgFGy5O9w-1; Mon, 10 Mar 2025 10:15:11 -0400
X-MC-Unique: EWewh_qBMS68bOgFGy5O9w-1
X-Mimecast-MFC-AGG-ID: EWewh_qBMS68bOgFGy5O9w_1741616111
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6f2c7746509so67799487b3.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616111; x=1742220911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMdCg2efbd0Qh20QNdOF7eXxFbnyvCBURzGryJnLYK4=;
        b=ax8VV+lSNP5Kx+0DZYv/UxGb74NzmkPIW3H6dznjOPLcmEOmSNBvlc3WjAWJeDKW08
         vpxWrI4N2VOImW/pb2I7DZTOsE46VCynBzoAbAUOD1Bwj1wOtPdmW1tvc7rdNSA09YbX
         tj9hUP1qpuTT+VdmoGB3NaK/nx8d3yulK1uEGwHXPItRhlHF3zq08t1dcm+2CtovHo82
         097lPvT3JPKPV9ptMu2ZE2hVbn3/tgouvtH8m3SxlPJ85ckiMu4fDBxfDwWznrIUmsGr
         sWTyVuUGWdex0fGqiERCrVAGj7tDjCGuUFS68PnrrtV1EakBXO+WTkw/QmMHVknqgy3v
         pJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBsMGTI7NnH1CzzqNcchALiVuWUJrNZXXiIAoYJDUXUj+/u6hAWfzHVjvSubHeuWG99nypKGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmXaS20Wx1zeVjov0m0/m6w1ii+MOxc/TjJxg/IwdiUThpavH
	OJ5p4IZ2kLSL8iX67fNPjoDVmCNfB/h9Mw/x51MGb+0TBRYCBNfy0UwOEgeL20JHHZCy7d1yUTi
	riEjdt+x8e4/zU17On3ewPEuPmq/dppEAdF6c5EyCdwyoVmGopt2N/urP9cXyxOar2FfHCQgX6+
	3EZkZjtzRmV0X3K01L74hsBZwvnD9i
X-Gm-Gg: ASbGncu2NCDWcYPxLEjkdIWkhhiCe+3uTu5hsUp/TSSdKmywlNtxmGussJOA1+ypj4i
	E7xIpxCZjs5ydEefGrD49ORhe/7gxSt7As/BK4hJSc8gssXS4Vty/emd7A9aNjqTU1vcdwwE=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id 3f1490d57ef6-e635c1d8d02mr14992221276.36.1741616111102;
        Mon, 10 Mar 2025 07:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqWrvAukg1iFDpO6ExBXHje3cw437GoWuPupbevVNTptRCcjP/uO3Bp+OM9ocpYHlDfKvsiQX6/BEdrkJbTU=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id
 3f1490d57ef6-e635c1d8d02mr14992171276.36.1741616110694; Mon, 10 Mar 2025
 07:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt> <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
In-Reply-To: <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 10 Mar 2025 15:14:59 +0100
X-Gm-Features: AQ5f1JosWWXY88zUmFjBrkclv9qmpGDLsUUZ5bj0pBV0c8sMAT4CMg2t-YayKWI
Message-ID: <CAGxU2F7SWG0m0KwODbKsbQipz6WzrRSuE1cUe6mYxZskqkbneQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 01:17, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > >> I think it might be a lot of complexity to bring into the picture fr=
om
> > >> netdev, and I'm not sure there is a big win since the vsock device c=
ould
> > >> also have a vsock->net itself? I think the complexity will come from=
 the
> > >> address translation, which I don't think netdev buys us because ther=
e
> > >> would still be all of the work work to support vsock in netfilter?
> > >
> > >Ugh.
> > >
> > >Guys, let's remember what vsock is.
> > >
> > >It's a replacement for the serial device with an interface
> > >that's easier for userspace to consume, as you get
> > >the demultiplexing by the port number.
>
> Interesting, but at least VSOCKETS said:
>
> """
> config VSOCKETS
>         tristate "Virtual Socket protocol"
>         help
>          Virtual Socket Protocol is a socket protocol similar to TCP/IP
>           allowing communication between Virtual Machines and hypervisor
>           or host.
>
>           You should also select one or more hypervisor-specific transpor=
ts
>           below.
>
>           To compile this driver as a module, choose M here: the module
>           will be called vsock. If unsure, say N.
> """
>
> This sounds exactly like networking stuff and spec also said something si=
milar
>
> """
> The virtio socket device is a zero-configuration socket communications
> device. It facilitates data transfer between the guest and device
> without using the Ethernet or IP protocols.
> """
>
> > >
> > >The whole point of vsock is that people do not want
> > >any firewalling, filtering, or management on it.
>
> We won't get this, these are for ethernet and TCP/IP mostly.
>
> > >
> > >It needs to work with no configuration even if networking is
> > >misconfigured or blocked.
>
> I don't see any blockers that prevent us from zero configuration, or I
> miss something?
>
> >
> > I agree with Michael here.
> >
> > It's been 5 years and my memory is bad, but using netdev seemed like a
> > mess, especially because in vsock we don't have anything related to
> > IP/Ethernet/ARP, etc.
>
> We don't need to bother with that, kernel support protocols other than TC=
P/IP.

Do we have an example of any other non-Ethernet device that uses
netdev? Just to see what we should do.

I'm not completely against the idea, but from what I remember when I
looked at it five years ago, it wasn't that easy and straightforward
to use.

>
> >
> > I see vsock more as AF_UNIX than netdev.
>
> But you have a device in guest that differs from the AF_UNIX.

Yes, but the device is simply for carrying messages.
Another thing that makes me think of AF_UNIX is the hybrid-vsock
developed by Firecracker [1] that we also reused in vhost-user-vsock
[2], where the mapping between AF_VSOCK and AF_UNIX is really
implemented.

Thanks,
Stefano

[1] https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock=
.md#firecracker-virtio-vsock-design
[2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock


