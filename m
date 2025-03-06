Return-Path: <netdev+bounces-172262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F997A54004
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5739C189040B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94D18CC1C;
	Thu,  6 Mar 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmRjlZWK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F372189BB5
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225061; cv=none; b=Tevs9asANGFdfZvmbNqVBQYFZB94sf4gNZHJXyuysnhWiEC3lVoQJ+FQfleHnnOoH8bzRNluJvvnU8Xa3GriFu1ZJFWbVPNy4Wa0JO6mHuaydjljUcKLpTpWPxV/HIEy6yh6bsYe8xoJV1byYXFz7BtA+XxfOauAczmGgYVKCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225061; c=relaxed/simple;
	bh=jt8oE1DDukSHhfGAEncsuyQqx3ir3OOa0dHNqoKOelY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J25FgBil75qA8WWUS28Kf+7SFvFEv47ZVZu7bb6p5CVz2niAwY4OpR5iyNpi7mz9BEZZQ3rwWeAuozjprFoG5z3IU8VtWihHKTrGQtQl96GCInWpzYepSlyN2YYwBuQwiPM0ZNccQ5pxGZr/WJ4uLHOikcT/pXXLUvouapxU4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmRjlZWK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741225057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwJDzSbLHHnbA7u1yktm23jopFFzMjn7g9N2Exf0cfw=;
	b=VmRjlZWK2YZtElGV344lcd+z+gwzitqf91ScAoE0YwcnPMc/JFrUItM+ElWRWlZeO3C/LH
	Rw8OFPrhe+1Rffs0VFnUgmCijFPxRSnZ3Zt9fW5kctubeNEe/qVjF01Nu9urO8FBLN7saW
	84DLxwlWTYuwMQDvodHdAV2GMufkZm0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-THyqIXzvOf6egv0hqCtobA-1; Wed, 05 Mar 2025 20:37:35 -0500
X-MC-Unique: THyqIXzvOf6egv0hqCtobA-1
X-Mimecast-MFC-AGG-ID: THyqIXzvOf6egv0hqCtobA_1741225055
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf5fc8f157so13162866b.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 17:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741225054; x=1741829854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwJDzSbLHHnbA7u1yktm23jopFFzMjn7g9N2Exf0cfw=;
        b=nH5FTz/G64lyTEsIPUD9qABc49mTIARVSPLi3BpikEX/7KlXit9za+BakpxwIpWoJj
         Zbdex4q7YNuDqvNCdoHBSpLP1RgHINnHk9KcmdfZppv+qlYrEUqH2nH4aDqLoby4Efxb
         K/mEXf09XKtzMsC5KbAzdJxN6yjiOIAECFadAqNB+VReyZPYthlssk/0dAqawO+bSqua
         OVMmWAluIwNGKEE8e3wg0QaEZ7vZMlMW0UyBXPKtDKVP9lY9X9UrjbN15Qffs/IvZ4NH
         f6+pMtaqyL8MpSn2q6AL43V5jt8VPCnc0GV7u9jRsairMc2+oZfAHHA5ESb1Dkcbllb/
         FJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyYvDAxfv/FoEXsxAQdOk7room8c8fIJZsNVFjNCmhlg7GNHKlNKYoJ94iNg2fIzteUzUWfE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCL+mLv9qH6icuKr7//1TTJObOm0sTmHAffuRO3zhUBQNtqvk
	/aQ+gnvh8sk2xIxoTgU4qStjzb4Kd43q2x/App/KqqS+GtwtmJUCRyWg4p1/Sv7jPAYMgrlbmMx
	OPm18snf2A1gNp0lE+pFo+/zSvx6Ofbz+xMHEIS7jhFMmszFn8ptE2HB10mWmWNClx9Wx1UsVlw
	QY9dW1YoxTpdt0SY/QFQR6tp9fXDZI
X-Gm-Gg: ASbGnctMEnzmqTZUEBIswOIX79RjbVFYqItbdPM2xrN4yt8rudb8LXAf27vJ/l5S0D3
	90Zt6T8KOokuzV+YSCyq3PYQJ1UaYYMXvX67UQCibldDTo2UnFk5rwKR9Jwn6e9lA8Up8IFgTGw
	==
X-Received: by 2002:a17:907:3f97:b0:abf:6225:c91d with SMTP id a640c23a62f3a-ac20db5625bmr437490066b.34.1741225054596;
        Wed, 05 Mar 2025 17:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9H1qhwvkDgDybNE5sW4VnwbCiQQmLm0SVfn0Ji7BN3QvZ4moN9FmVfiIH9jslgkkvztcXACeXl8wpC1dBMno=
X-Received: by 2002:a17:907:3f97:b0:abf:6225:c91d with SMTP id
 a640c23a62f3a-ac20db5625bmr437488266b.34.1741225054236; Wed, 05 Mar 2025
 17:37:34 -0800 (PST)
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
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 6 Mar 2025 09:36:57 +0800
X-Gm-Features: AQ5f1JoJEUufAEkLHWWULXhaNHkiqHvkFGZFpeTeSZ026lfQ3NJ0WwfBHHNypzs
Message-ID: <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series patch with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 6, 2025 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
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
>
> >
> > I see vsock more as AF_UNIX than netdev.
>
> But you have a device in guest that differs from the AF_UNIX.
>
> >
> > I put in CC Jakub who was covering network namespace, maybe he has some
> > advice for us regarding this. Context [1].
> >
> > Thanks,
> > Stefano
> >
> > [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.face=
book.com/
> >
>
> Thanks
>
>


