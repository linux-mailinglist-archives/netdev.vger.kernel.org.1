Return-Path: <netdev+bounces-172348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A1A544BD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806923B1082
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6C1FC7DA;
	Thu,  6 Mar 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG++pnu/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774C1FBC9F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249403; cv=none; b=JNHEmEpgz0w9y4/oZzO/JmsZg1spOnfDo+ii59vSUNO/Dr+RZfJifP0Z7vDlHALwwkfh0bcemrSDZwODierkXK5lcIA1GCww1pMfnP/9sWqUCliOaFnHmzF4QyTciRu4xpZDaW+GcvObxEtSozujIiselvEQhp+Quhctv5we2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249403; c=relaxed/simple;
	bh=LAESgKwjsOolqILQ7EFqXdhdFKselMeHOYpzQPd3EDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2y1lL4VsQ0mqfLPsHpaZEJw6NtW8Tk1gOA7fRKSAMUDb6YhaIGgH/fRarOLzf866vxPj5P6inNDPKrG4tCuY1YyNvZTlvDJb+gL7URRaglmYAC81pLJlbMGBehbSMG1r3/aleepM3ow136GkS6JJIHgMDdBV/IFQpQN9B86tBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dG++pnu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741249400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7r18lDDaYnSU7d2JOl6qmtUJzAYao+io6UYl9OANnk=;
	b=dG++pnu/zC2++ehDgE1RgC0FE0V+zAUyT04mwcMidClFcTRvtm+UgCNb9lYe9rUEgSK2h4
	b4eqJXlFkVrxmm0NBtHHBHRD6/8JtKBcSnHpb+UkjBOtR7202xRWJtaJXEH9dRLcAiRjna
	kb7lYehEpjCsVbfaxqpj7/gGJH1VIQQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-S6o7LVHKMuCLln91XEl6Fg-1; Thu, 06 Mar 2025 03:23:18 -0500
X-MC-Unique: S6o7LVHKMuCLln91XEl6Fg-1
X-Mimecast-MFC-AGG-ID: S6o7LVHKMuCLln91XEl6Fg_1741249398
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so591299276.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249398; x=1741854198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7r18lDDaYnSU7d2JOl6qmtUJzAYao+io6UYl9OANnk=;
        b=Fgk6JY//cjCJ6uHbnRxeda4ovW9OWYFs69myMTtqtRdp6/ngIdGMiPZSita2FsprBr
         A6Ayb7fhezu3z3DautbkYOFEUTZs9/2ZojccNvuZ7I4xTuX9upyU+8IW+rBc4J29MaqU
         b+ZcaJ2+PjF/9F8f/J5yhAgB+SxObnQJvw5dkDxQWP74iLpYRbqKY7bdlxpo+IledMQv
         6g8h9brmeUfUCQQqpyT/HZ2EOtCtpGUyR8C72lVVaI+OPdHpnu7DH/VHH6HjsTsW30gX
         idHtiEk+8aChlVTwaSVN6MSwwIf/lqHtaX6UTZRjsmZwzqRtdr+GMuMx8FbpYyDHEejs
         /jjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVchDl8kcnakYqShuibOT8D0R9L1fSPngkuJM95DENM3UvzuHfiJoDuc0PYLlQyL7C2vBW3imk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4CaNkybBIO/ryQ7F4kt0n8eWihvYOm8c/g4sNJKS2YCmQmCw
	aCfwuUvrdYEGueT7VUJTnusCpJ4IcJc5ZZg3heQLpfH+UbVuykikx/9ZZmhbPwBGm3oDEwTw28S
	rthYsgUEAsGZXZIXQ5pYtUzbRikqtpW7xHbRj/4FNzS9Lsq0DgKMJQ0Xi3y+A+FrM6GLVtxtFc2
	VhdnxvRUsXOVeR+HC7Q0RFKARWQLnS
X-Gm-Gg: ASbGnctKGscuzexMUg4OKR0B7WYImm4YHt7bru9pgb9qQY8rpwQzyJR9dorSEpKa1Ho
	5USEOBwC2naQOXVN8qCL6N+IGsM6yfWrCbV4bCWeNC1V8smyyVfXxzU/+FXjBPlX2m5e5rQc=
X-Received: by 2002:a25:1ec2:0:b0:e63:474e:c861 with SMTP id 3f1490d57ef6-e634eef0b1fmr718513276.25.1741249398216;
        Thu, 06 Mar 2025 00:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7nJyNaHwTKfCFf2zsd6PiaEGoXlfFh+yzGhdtdq5/XYd3bHYtIZ0oKB/mltmXYT1qA2ZSl8TLqva2zRpXEPU=
X-Received: by 2002:a25:1ec2:0:b0:e63:474e:c861 with SMTP id
 3f1490d57ef6-e634eef0b1fmr718493276.25.1741249397848; Thu, 06 Mar 2025
 00:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
 <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com> <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
In-Reply-To: <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Mar 2025 09:23:05 +0100
X-Gm-Features: AQ5f1JohM_t7j7Fpc0COSkCeLVhsbQLpCfbrtS-97yp_c3OjYm5Amp7QVm4NzL8
Message-ID: <CAGxU2F7_0hXc-0hasa-_p_0z6nGCY6bsF_49ZRRN2mKZEJcziw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Lei Yang <leiyang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 02:37, Lei Yang <leiyang@redhat.com> wrote:
>
> QE tested this series patch with virtio-net regression tests,
> everything works fine.
>
> Tested-by: Lei Yang <leiyang@redhat.com>

Sorry, but this test doesn't involve virtio-net at all, so what is the
point on testing it with virtio-net?

Thanks,
Stefano

>
> On Thu, Mar 6, 2025 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> > >
> > > On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > > >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > > >> I think it might be a lot of complexity to bring into the picture =
from
> > > >> netdev, and I'm not sure there is a big win since the vsock device=
 could
> > > >> also have a vsock->net itself? I think the complexity will come fr=
om the
> > > >> address translation, which I don't think netdev buys us because th=
ere
> > > >> would still be all of the work work to support vsock in netfilter?
> > > >
> > > >Ugh.
> > > >
> > > >Guys, let's remember what vsock is.
> > > >
> > > >It's a replacement for the serial device with an interface
> > > >that's easier for userspace to consume, as you get
> > > >the demultiplexing by the port number.
> >
> > Interesting, but at least VSOCKETS said:
> >
> > """
> > config VSOCKETS
> >         tristate "Virtual Socket protocol"
> >         help
> >          Virtual Socket Protocol is a socket protocol similar to TCP/IP
> >           allowing communication between Virtual Machines and hyperviso=
r
> >           or host.
> >
> >           You should also select one or more hypervisor-specific transp=
orts
> >           below.
> >
> >           To compile this driver as a module, choose M here: the module
> >           will be called vsock. If unsure, say N.
> > """
> >
> > This sounds exactly like networking stuff and spec also said something =
similar
> >
> > """
> > The virtio socket device is a zero-configuration socket communications
> > device. It facilitates data transfer between the guest and device
> > without using the Ethernet or IP protocols.
> > """
> >
> > > >
> > > >The whole point of vsock is that people do not want
> > > >any firewalling, filtering, or management on it.
> >
> > We won't get this, these are for ethernet and TCP/IP mostly.
> >
> > > >
> > > >It needs to work with no configuration even if networking is
> > > >misconfigured or blocked.
> >
> > I don't see any blockers that prevent us from zero configuration, or I
> > miss something?
> >
> > >
> > > I agree with Michael here.
> > >
> > > It's been 5 years and my memory is bad, but using netdev seemed like =
a
> > > mess, especially because in vsock we don't have anything related to
> > > IP/Ethernet/ARP, etc.
> >
> > We don't need to bother with that, kernel support protocols other than =
TCP/IP.
> >
> > >
> > > I see vsock more as AF_UNIX than netdev.
> >
> > But you have a device in guest that differs from the AF_UNIX.
> >
> > >
> > > I put in CC Jakub who was covering network namespace, maybe he has so=
me
> > > advice for us regarding this. Context [1].
> > >
> > > Thanks,
> > > Stefano
> > >
> > > [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.fa=
cebook.com/
> > >
> >
> > Thanks
> >
> >
>


