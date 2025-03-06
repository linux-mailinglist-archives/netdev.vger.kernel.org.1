Return-Path: <netdev+bounces-172255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE18A53F01
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 01:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C373A3ED9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE00C1C27;
	Thu,  6 Mar 2025 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvgId6SB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D6BA3F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220232; cv=none; b=Y6FxfFAWmO+wC2zZ9dBYrIo7F6X+q7B5X4CtUhNwnBLCcigH/f17A1cjrR6WfxUcnBYAUbqASsjlrp8O1qV2FnJjAXX7fT8ETcU+kyFpM9NCyj5D16yOWFt01fk3OO7HSqqKxA/kUHTjGXPZKTJKBIywC2ZBRtZgQnmYJdUpuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220232; c=relaxed/simple;
	bh=+Wwm78y9BnVLdWm8RFuREOENXYM1SpKDISYy3wFQGr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VogovDOIf84zqp+bIb97JnGfYLzuwK0xU+8qkXyc+3R89DhConYimYNvXovPOzI+APFo1ulslqPYMfPKGHjTfie/NB3iWc7JlbimUep+9N3WjNhxVGnlgGRa3KlZQfH6Oa0WxwlUWTO+fgLMKd00AKsNYY50XMGb7SLYVNtFiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvgId6SB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741220230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYivC87WhRU5jPCfxZzkS7AXzckjBFGkdKstv7mfD7c=;
	b=gvgId6SBjdgrbLYpViKgOF8lYPX4XOFbx2yd4nfFlDYidRgZ/P767ChOccpXGM8TJl6eOt
	oBihAZFkeBnfM7kqWMEn7LHGfAe58FLtZw45Fe0hjWY4yReeKvSfRb6HhfC2zBzAF2bXa5
	sNHjyoG3AuRBuUAC3vlGlCdUEkc/2cs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-QPtDUFLyMcy-sZo5vHvkOQ-1; Wed, 05 Mar 2025 19:17:04 -0500
X-MC-Unique: QPtDUFLyMcy-sZo5vHvkOQ-1
X-Mimecast-MFC-AGG-ID: QPtDUFLyMcy-sZo5vHvkOQ_1741220223
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso409719a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 16:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220223; x=1741825023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYivC87WhRU5jPCfxZzkS7AXzckjBFGkdKstv7mfD7c=;
        b=BJDWRMbhoVd+vSlxOFZHOA9/w5I5y2oTN/0Q09fve71MmStgZm+FEo6a/XF9Wv5B0Y
         nlz7d421N6otwX/xxLBiUZlYKKk+aj51dycD8o61gNRVcjTSu7xmiFLKsTPaBPl5BDau
         a0D2JPY3L2d6+Dxq85ic7YyCpcbGPUZHmVCQp7q3ztrp3qwwGGOXclhVXBC/T8pRTXlX
         hugeREc/0iUjShEs0jxlsYAH8MRWAopKrzqufLG85Ch6gAgIgBuSV7q9RWzgi2a/Yy9v
         XF91OLsSnTdVgtxmtC9mCrPysT7hEAy3T+C48il5IlmUZGTVwGj65Ge9Gw848ldXx8sn
         xfSA==
X-Forwarded-Encrypted: i=1; AJvYcCW+bB3S1ju2uB97Utqh2Tbol7auYx/Ivhd0miDXv25JcSX1OLCu7iyx1RufbjCXHyTipmMOj54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4/ugwHgo62PNcpTKq2hV34jlGlf+Y0PF3MJSDbgKwFSYB8m0
	Df2kMLlrkryGPqTx5Nihy/2kzkzNwsGmvITWww3KNEDsQ5r20S08xwGFPDQU0210nulx+ef2kPG
	08sLs5wMeo3qeowLGEkwTKpIcpw/rClGjC0hnEPhOmMLGcWvd/p78/SEvP7Xy3ZEAOy5Z/kC+al
	KjsNAk/rr95SpxN1XyZwZ4p1jgXqS/
X-Gm-Gg: ASbGncvcMIE5YMc3Ju56xLXpQ+0zcUJFlKJPrbTXohOXqpAAHcVRCnp4zXG+mVi7hRo
	99ka//+oW1spFi4WOAszwsqXxUscVR6NXR0xveE0ltXuNm3lltdcDVmOkIeS6ZjTf9ZtK/ncORS
	o=
X-Received: by 2002:a17:90b:3c87:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ff497cce78mr9640205a91.18.1741220222887;
        Wed, 05 Mar 2025 16:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm03yuBJCzHipb+u+/vxkatspEkUc/vBoHzZ9SJCyh2hxYSRGDOjw00zbfIsnmQnxOyJi4dQOkxCDXWDyfOC0=
X-Received: by 2002:a17:90b:3c87:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff497cce78mr9640168a91.18.1741220222504; Wed, 05 Mar 2025
 16:17:02 -0800 (PST)
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
In-Reply-To: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Mar 2025 08:16:51 +0800
X-Gm-Features: AQ5f1Jql0yqolE1p-RM3zEM6LJujZ0qsyX-vhJHsLFPVzV7f1_y-mNi6DKL8tMs
Message-ID: <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> >> I think it might be a lot of complexity to bring into the picture from
> >> netdev, and I'm not sure there is a big win since the vsock device cou=
ld
> >> also have a vsock->net itself? I think the complexity will come from t=
he
> >> address translation, which I don't think netdev buys us because there
> >> would still be all of the work work to support vsock in netfilter?
> >
> >Ugh.
> >
> >Guys, let's remember what vsock is.
> >
> >It's a replacement for the serial device with an interface
> >that's easier for userspace to consume, as you get
> >the demultiplexing by the port number.

Interesting, but at least VSOCKETS said:

"""
config VSOCKETS
        tristate "Virtual Socket protocol"
        help
         Virtual Socket Protocol is a socket protocol similar to TCP/IP
          allowing communication between Virtual Machines and hypervisor
          or host.

          You should also select one or more hypervisor-specific transports
          below.

          To compile this driver as a module, choose M here: the module
          will be called vsock. If unsure, say N.
"""

This sounds exactly like networking stuff and spec also said something simi=
lar

"""
The virtio socket device is a zero-configuration socket communications
device. It facilitates data transfer between the guest and device
without using the Ethernet or IP protocols.
"""

> >
> >The whole point of vsock is that people do not want
> >any firewalling, filtering, or management on it.

We won't get this, these are for ethernet and TCP/IP mostly.

> >
> >It needs to work with no configuration even if networking is
> >misconfigured or blocked.

I don't see any blockers that prevent us from zero configuration, or I
miss something?

>
> I agree with Michael here.
>
> It's been 5 years and my memory is bad, but using netdev seemed like a
> mess, especially because in vsock we don't have anything related to
> IP/Ethernet/ARP, etc.

We don't need to bother with that, kernel support protocols other than TCP/=
IP.

>
> I see vsock more as AF_UNIX than netdev.

But you have a device in guest that differs from the AF_UNIX.

>
> I put in CC Jakub who was covering network namespace, maybe he has some
> advice for us regarding this. Context [1].
>
> Thanks,
> Stefano
>
> [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebo=
ok.com/
>

Thanks


