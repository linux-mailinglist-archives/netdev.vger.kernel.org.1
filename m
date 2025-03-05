Return-Path: <netdev+bounces-172108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B89A50420
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407F11736D2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998B24DFEB;
	Wed,  5 Mar 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFi0T3GY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587D2475C8
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190850; cv=none; b=TqA10Mxfl8MdzU0usLFMLnx1n4+JqA1WC7rhMVbtqozthiSDrODX8rK+GasHmGv8vUye8jPouDYvA5WnOnVxqoAT/ptMQQGrvpg/6bFLrDzAvtEqivwxZA7nguVJkBO71gGrOMewfAy7Wrv8Df1pjfcztMX2edwZWH6xjblrctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190850; c=relaxed/simple;
	bh=kq/Og+wt7HP9ZImJr8Q41zTRnAZqrVJ2k+Jm/8grxEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alNl4EHmKsUOkk5cz1/IoSuUMbndVHy8PQbuMNwPgeFEvC2O1uXuHHYbnUH8YSlOAAca/zcOsPNzOwSfpvv3449koiX8kg1N1dofbWAsC8KedKaKfxqdIidO6+jhpWZVmzyBP9GUawOPLLXZYDokgj/SaY+rF8E+KUkZo+j1xu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFi0T3GY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741190847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryWkCCG9U7D/clkcoHvgWHB1rXveT/dQOyD5wDCrVfA=;
	b=BFi0T3GYQSwe9ufp2CBqR0oRXjwJ9CXz2I6nypqx0jRO5KB+J2ySnNdFG657bKjo19ko1A
	SHDNaoW+PSIOmCQZyMwkmvJgYqM3guGrO7pyuCVEjs0yWDOW+ZuS9a2LbppcQBtp/NzQG2
	kRZ0coR0MW1D+1hvMtegAkaP0HzCLf8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-uGJ2uZX5OP2cIJQz-pQHlA-1; Wed, 05 Mar 2025 11:07:26 -0500
X-MC-Unique: uGJ2uZX5OP2cIJQz-pQHlA-1
X-Mimecast-MFC-AGG-ID: uGJ2uZX5OP2cIJQz-pQHlA_1741190845
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6fd36a398cfso75582257b3.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190845; x=1741795645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryWkCCG9U7D/clkcoHvgWHB1rXveT/dQOyD5wDCrVfA=;
        b=UX37DMsCde3Eov0u0LAva0dBkiwUGuQ8vJOhiSMLaoFqHlYqXTlsnSyWXMbIb5sxfp
         6hqkEM4R8JJCO3+L1gSId6/k+gD1tw68xnEutI0Rb7k5OQnnxUPiyDG8AaBp7HDX03y+
         rBohfYI6ZkLoou98j2NXopag6cRI/55xcAci/+GGN3JN3H0WmfGPJ20ypKOI0yf4JKY6
         n8D4KDf1sY+77r3LN/vk6TJnye7/Rr4MHOUIVYz8Ikq4gDVrbDtUycK0hyzmTrB8BST/
         PYHxahNtDzBGEJJXRfRfH4Mc6n5yHG8Tfso2uQ7XjP06ntf9R6PZIpfxZgDEq09FGxYD
         aRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqACQ9krPiMbd4whg5W+QWUabuiicZUb5CRIQannhsIjpsjUZUEClMfG2OZFRSF2n5a/F3pDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQahtrrjv3dSc/AWyWHnO734LV1RHzsB5EvMB6QySg587ewoF
	3KKT+7QISJWv7PpKzffUy3DOUCPQl+4dw57ILcOyIdLmHaRK/pucGE1h2tdfUnEPbkEyztP5ijw
	JKXBbB9FbbfRkrRCGUxqnEAgGCZlqvwT5+sr7LWYxFMVPQssbKjvRH6/OCT47O88oJtSmGlKYki
	cYIoq2PjS4ZztJBFVyrxY6iL1Jz2Ev
X-Gm-Gg: ASbGncsuaYpRPyWh2STPUH1IvE7IJgwXS1hphEEK+kC+8z94JL/jIVJiZXbkIyC4jAg
	WkI+fXR7ZYDik2YpvceQpQck2Bk/kgcycwd2pQa33L73QbWz5yijcCilAHntNuCKbtobrqsA=
X-Received: by 2002:a05:6902:2b04:b0:e3a:228f:b6ae with SMTP id 3f1490d57ef6-e611e31b361mr4939465276.28.1741190845403;
        Wed, 05 Mar 2025 08:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUAS6WwP66wpVRH9zM8tONfKYOINgZVsEogrnYLnEVbUemjVXbmLZS/WKWOoZP10KvvEaRYVNTgnvohXgwyFk=
X-Received: by 2002:a05:6902:2b04:b0:e3a:228f:b6ae with SMTP id
 3f1490d57ef6-e611e31b361mr4939380276.28.1741190844684; Wed, 05 Mar 2025
 08:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org> <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
 <Z8hzu3+VQKKjlkRN@devvm6277.cco0.facebook.com>
In-Reply-To: <Z8hzu3+VQKKjlkRN@devvm6277.cco0.facebook.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 5 Mar 2025 17:07:13 +0100
X-Gm-Features: AQ5f1JpJL5yP-_Z0xQeVD2Y1zot7Sg-rzWoskaP0DYpCjrRwMKzDiyskEoI2Ozg
Message-ID: <CAGxU2F5EBpC1z7QY1VoPewxgEy3zU7P1nZH48PtOV1BtgN=Eyg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 16:55, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> On Wed, Mar 05, 2025 at 10:23:08AM +0100, Stefano Garzarella wrote:
> > On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
>
> [...]
>
> > >
> > >
> > > I'm not sure I understand the usecase. Can you explain a bit more,
> > > please?
> >
> > It's been five years, but I'm trying!
> > We are tracking this RFE here [1].
> >
> > I also add Jakub in the thread with who I discussed last year a possible
> > restart of this effort, he could add more use cases.
> >
> > The problem with vsock, host-side, currently is that if you launch a VM
> > with a virtio-vsock device (using vhost) inside a container (e.g.,
> > Kata), so inside a network namespace, it is reachable from any other
> > container, whereas they would like some isolation. Also the CID is
> > shared among all, while they would like to reuse the same CID in
> > different namespaces.
> >
> > This has been partially solved with vhost-user-vsock, but it is
> > inconvenient to use sometimes because of the hybrid-vsock problem
> > (host-side vsock is remapped to AF_UNIX).
> >
> > Something from the cover letter of the series [2]:
> >
> >   As we partially discussed in the multi-transport proposal, it could
> >   be nice to support network namespace in vsock to reach the following
> >   goals:
> >   - isolate host applications from guest applications using the same ports
> >     with CID_ANY
> >   - assign the same CID of VMs running in different network namespaces
> >   - partition VMs between VMMs or at finer granularity
> >
> > Thanks,
> > Stefano
> >
>
> Do you know of any use cases for guest-side vsock netns?

Yep, as I mentioned in another mail this morning, the use case is
nested VMs or containers running in the L1 guests.
Users (e.g. Kata) would like to hide the L0<->L1 vsock channel in the
container, so anything running there can't talk with the L0 host.

BTW we can do that incrementally if it's too complicated.

>
> Our use case is also host-side. vsock is used to communicate with a
> host-side shim/proxy/debug console. Each vmm and these components share
> a namespace and are isolated from other vmm + components. The VM
> connects back to the host via vsock after startup and communicates its
> port of choice out-of-band (fw_cfg).  The main problem is in security:
> untrusted VM programs can potentially connect with and exploit the
> host-side vsock services meant for other VMs. If vsock respected
> namespaces, then these host-side services would be unreachable by other
> VMs and protected.  Namespaces would also allow the vsock port to be
> static across VMs, and avoid the need for the out-of-band mechanism for
> communicating the port.

Yeah, I see.

Thanks,
Stefano

>
> Jakub can jump in to add anything, but I think this is the same use case
> / user he was probably referring to.
>
> Best,
> Bobby
>


