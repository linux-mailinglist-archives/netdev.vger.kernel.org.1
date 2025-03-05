Return-Path: <netdev+bounces-171954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961EA4F9D5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FA518867EB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35F2045AC;
	Wed,  5 Mar 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6hwbWbJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F17202969
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166600; cv=none; b=eZKnaLqzpGV7P51SncOTh4Qmbwpj9MopLX0LQSiCXYlJi79NmxM5zO2XtVz8SEVDRw0/lrZiL2D/sseSIpkuRSn7gZqjovxKu7nAhQqma+9u2ImQtXy9qjQTkv6L32E21kHhytYs5bcZtH2fI1A3QtZFPzuDrgiJ7sUu4JI4+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166600; c=relaxed/simple;
	bh=+QfPm6bqrG0OcdOxhTC1BYzGGpBGfOp64hZJsZUGa8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8WpnX44E3LYw1SK8X/lQ1+6thDGVVRTsvptpduMUOZPpiaHjMbhKyyoQktEEOfEjeGXrXx+Io5RkxbcG6UYssGHuDwFR4pXeVnc/yX0SE2ldGVMa2A/JY75isIPORRVp574Kd1dylgTaxWFk1a04Sv+E3kEASOYFHWuoUV5YC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6hwbWbJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741166597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
	b=H6hwbWbJvRc76HNKQr1ncFfLpM5roA6dEbbpRKWURLBSpKbzmqw3SLtXU96DX24QKcZ/UI
	S6I2+iyPatIuPtlA6XD1T3bcVeEP7BV3P667UPleGxaqk1M9HXAbti1hR2jDEhlKvhKHGh
	IMZ0jQ1GJbQb7399rZmvqvxFdX1t6R8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-mzbjl25TMguDrHG1-2aJCg-1; Wed, 05 Mar 2025 04:23:16 -0500
X-MC-Unique: mzbjl25TMguDrHG1-2aJCg-1
X-Mimecast-MFC-AGG-ID: mzbjl25TMguDrHG1-2aJCg_1741166595
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e54bade36dso3765881a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 01:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166595; x=1741771395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
        b=v4gEsjjZ5mxxEiMdkCWHN4sKCv4nM10YAhGbfo5Y5IJUWqVCao7uiXmNe0T2d0b/Kf
         zVF3Xv1TV9TjslaBmMm3CfKeDFrbI8HD305yQoXeHpFWGWghyDfSbHQJdsVaZ7BpfkGx
         mLBhVY7AJ8SIKOhyZvPZHhIUYRA4/2ea0BtZEQAb+GGS1o1bG0gkcdnv+Tp0tJGquNaR
         NGoyEaDwiYgL6OaB5AFnoleYeLL4mh4Omo4bVDTR/AbvrX1QGfa7Wm2nnsOFy3awC/uu
         JQsLTOv6My5mG8cLq5fG1WR0B/L0OQXBCoR5S/hj/7aOzWW+uGsyNHFO3ypfiuDv0wHS
         5u9A==
X-Forwarded-Encrypted: i=1; AJvYcCUgAzkdQNWR8yDWVXD0hLrR2Lgfel+BXBaJw6Y+dbw4vQ23uuPmdvhfC54LxtnWvnB3q7Ib0es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwysZldjdwjM6xdl+C8LEUl7dTRjTqc1jTXHCWMxz98YFTtNX44
	8vv6c9pNDpr6NC0qWJ78DqJzhQbxEWj0xg0yp4JKpFx1uLqEZVwzwO2GwMtWoAHij5aoHxfAveX
	e1lY1YLkm/MVq+BaeIlCX+QStsD6YwL3aJX8al0ya5wSNTO5lwGEIHQ==
X-Gm-Gg: ASbGncsOdVJqVhgzYdKgVjlu5OZsyvKPxolWzNp3z2Yp28LhVoW0NpzZ9Ia/c5vAjWC
	GUnozpn0+KaQOSzdJy2exhzEsjx9xny1sqv20jAViXj1qcK9qtmH9p+ER4gtqUo5PUOkFKFED9i
	UzmQahfYakLVHem1bxF4etK2iVLh9uGgpFp5MQpPkZyx2XciWorYL5sgthaV200IYAmad6Sx/2a
	kvDAGxv+IK1r7p6Iu38JCNhy7pBGgyvqb6Ag9epUuq4da4V7mRA1+iZGiyvtmh5W5dCvSS8AzIY
	U2PobGVVwWpaHYijUM8g70ffBYmYt45IfKOlc7M1dKvvPMaIF++a0m+lRoM2VnTh
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334229a12.26.1741166594695;
        Wed, 05 Mar 2025 01:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrT/jfbwSVjoA3FYJOR2RrQw1bBL1x20n/7XdsK3C0UVX0BQZe2DpbudtEjt/UHC5wEkkQDw==
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334183a12.26.1741166593907;
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm9297702a12.1.2025.03.05.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Date: Wed, 5 Mar 2025 10:23:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305022900-mutt-send-email-mst@kernel.org>

On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > This patch adds a check of the "net" assigned to a socket during
> > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > to support network namespace, allowing to share the same address
> > (cid, port) across different network namespaces.
> >
> > This patch adds 'netns' module param to enable this new feature
> > (disabled by default), because it changes vsock's behavior with
> > network namespaces and could break existing applications.
> > G2H transports will use the default network namepsace (init_net).
> > H2G transports can use different network namespace for different
> > VMs.
>
>
> I'm not sure I understand the usecase. Can you explain a bit more,
> please?

It's been five years, but I'm trying!
We are tracking this RFE here [1].

I also add Jakub in the thread with who I discussed last year a possible 
restart of this effort, he could add more use cases.

The problem with vsock, host-side, currently is that if you launch a VM 
with a virtio-vsock device (using vhost) inside a container (e.g., 
Kata), so inside a network namespace, it is reachable from any other 
container, whereas they would like some isolation. Also the CID is 
shared among all, while they would like to reuse the same CID in 
different namespaces.

This has been partially solved with vhost-user-vsock, but it is 
inconvenient to use sometimes because of the hybrid-vsock problem 
(host-side vsock is remapped to AF_UNIX).

Something from the cover letter of the series [2]:

  As we partially discussed in the multi-transport proposal, it could
  be nice to support network namespace in vsock to reach the following
  goals:
  - isolate host applications from guest applications using the same ports
    with CID_ANY
  - assign the same CID of VMs running in different network namespaces
  - partition VMs between VMMs or at finer granularity

Thanks,
Stefano

[1] https://gitlab.com/vsock/vsock/-/issues/2
[2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/


