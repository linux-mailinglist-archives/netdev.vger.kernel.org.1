Return-Path: <netdev+bounces-140531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE279B6D70
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795C31C2348B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070901DE8B1;
	Wed, 30 Oct 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="XlcLz8ZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB861D1E7C
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319232; cv=none; b=EV3lLfSDd50fxjko4IpfrWwOBNNwcUMDsZysItBMmRQ+r8G/s35zVFSG5vFt+pn7ZlW5o9YyDmQmvt2ZO4VRfSGe6Ykb8mrZ149DghXUVYjQdDRMAT0XWvUKpeir9rPphYw2G+loKvP/8bkeVk+Y4FxcVyGhmwb1UA29RCEQ1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319232; c=relaxed/simple;
	bh=Je9nQDNX52HIxtPWVlFTpGYhsPK1UxiFB3ZXot3oK8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yfqt2cKGTQBQYWauKyTtnne1NGZxEg74MyYyxZ34mw8nOdeWI4oj1t4z9yyfFh3AQk58GTn9kCJYvkcR0eV7a73RZJ3Dgg1l+5Ku2p5Z7DqktIxJoHKu6nO4Vc4UP3G/wLKgxj0knDIAxu4MMl8KeSYJzcXKXTHGjFSc5jCP7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=XlcLz8ZD; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JCSQPkZeG44XFgf66urjEgFh8I8p1xvqB5kHtqNsrek=; t=1730319230; x=1731183230; 
	b=XlcLz8ZDAO83ESWN220hDIVI+/Cz57uVp9/RfpRhxgEtiB6gTCZYVZOeWcIznS66K5Y7h2/6kl5
	GF+HTDHvptcFanRJenPzlk5EOKNxE64EUc4XTzi4czUGZtlylrXiiSk0quv1I3dNMGBRMFAuL3fNG
	X0ZB2WrEeJHWuq2kCuKsU6IEA1XUIpaZrtDJxRC3nIxgrxHjJIU3FssOz3cNTkQlV1ABgvT4ENMUq
	xqT1ucS08KVAEkxm8Wr7EYb2cUi0BR/TcEHc3a+8OgDXC+tIqvBJVdRVwQjhu6IOc/NQzEZuC2McJ
	DFZt45Ylk87G3cNhuOVrmi2MwliY/8yWWKNw==;
Received: from mail-oo1-f47.google.com ([209.85.161.47]:46209)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6F4f-0000m9-6Y
	for netdev@vger.kernel.org; Wed, 30 Oct 2024 13:13:50 -0700
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5eb5be68c7dso201109eaf.0
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 13:13:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDPzi4+nnROnx1l4vpT3tiDHcq80H9p+GBjP7ir+5H9N5R6eNSKD8HoghLaVzeWyxW57Gw/RM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4uWHgUUYiB2/+engXsa/LKlMbHhkwChnxc2ROUlj89HBa9c0
	YlbAegiV+eh9Mdd0UHeF5kJNSBkwk5sF63tVBCDAihmQbGnFzi12PQjfAxIVhNwjXB8Uf8yrQtn
	yxO2OrHlBWYKawHhHUOx9SHosWZ8=
X-Google-Smtp-Source: AGHT+IE6BKFc8cv39adwka3c9p4s+C40fetgqbtOyDPm/XpVAgk2hocb3AStyvDYrdxAcWGqyB0MlaFM04UGYqlPgmM=
X-Received: by 2002:a05:6820:820:b0:5e1:de92:6b66 with SMTP id
 006d021491bc7-5ec6da776aamr490769eaf.2.1730319228570; Wed, 30 Oct 2024
 13:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch> <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
 <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch> <CAGXJAmyLsx9DPGdhZwPxn0wXjFAFV3dqjhFHpaBLtKZ1mtYBSQ@mail.gmail.com>
 <16f2e9cc-9b5e-4325-b5c7-fe7fd72600a8@lunn.ch>
In-Reply-To: <16f2e9cc-9b5e-4325-b5c7-fe7fd72600a8@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 30 Oct 2024 13:13:12 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzN4_y2fzHdm+tVncbSso4ZMYOV5WmE+A9sUm6by=rhwQ@mail.gmail.com>
Message-ID: <CAGXJAmzN4_y2fzHdm+tVncbSso4ZMYOV5WmE+A9sUm6by=rhwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and homa_pool.c
To: akpm@linux-foundation.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: ae7d61d5ad21aa0d569d6b6c8168eb46

Hi Andrew,

Andrew Lunn suggested that I write to you in the hopes that you could
identify someone to review this patch series from the standpoint of
memory management:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D903993&state=
=3D*

The patch series introduces a new transport protocol, Homa, into the
kernel. Homa uses an unusual approach for managing receive buffers for
incoming messages. The traditional approach, where the application
provides a receive buffer in the recvmsg kernel call, results in poor
performance for Homa because it prevents Homa from overlapping the
copying of data to user space with receiving data over the network.
Instead, a Homa application mmaps a large region of memory and passes
its virtual address range to Homa. Homa associates the memory with a
particular socket, retains it for the life of the socket, and
allocates buffer space for incoming messages out of this region. The
recvmsg kernel call returns the location of the buffer(s), and can
also be used to return buffers back to Homa once the application has
finished processing messages. The code for managing this buffer space
is in the files homa_pool.c and homa_pool.h.

I gave a talk on this mechanism at NetDev last year, which may be
useful to provide more background. Slides and video are available
here:

https://netdevconf.info/0x17/sessions/talk/kernel-managed-user-buffers-in-h=
oma.html

Thanks in advance for any help you can provide.

-John-

On Wed, Oct 30, 2024 at 9:03=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 30, 2024 at 08:46:33AM -0700, John Ousterhout wrote:
> > On Wed, Oct 30, 2024 at 5:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > > > I think this is a different problem from what page pools solve. Rat=
her
> > > > than the application providing a buffer each time it calls recvmsg,=
 it
> > > > provides a large region of memory in its virtual address space in
> > > > advance;
> > >
> > > Ah, O.K. Yes, page pool is for kernel memory. However, is the virtual
> > > address space mapped to pages and pinned? Or do you allocate pages
> > > into that VM range as you need them? And then free them once the
> > > application says it has completed? If you are allocating and freeing
> > > pages, the page pool might be useful for these allocations.
> >
> > Homa doesn't allocate or free pages for this: the application mmap's a
> > region and passes the virtual address range to Homa. Homa doesn't need
> > to pin the pages. This memory is used in a fashion similar to how a
> > buffer passed to recvmsg would be used, except that Homa maintains
> > access to the region for the lifetime of the associated socket. When
> > the application finishes processing an incoming message, it notifies
> > Homa so that Homa can reuse the message's buffer space for future
> > messages; there's no page allocation or freeing in this process.
>
> I clearly don't know enough about memory management! I would of
> expected the kernel to do lazy allocation of pages to VM addresses as
> needed. Maybe it is, and when you actually access one of these missing
> pages, you get a page fault and the MM code is kicking in to put an
> actual page there? This could all be hidden inside the copy_to_user()
> call.
>
> > > Taking a step back here, the kernel already has a number of allocator=
s
> > > and ideally we don't want to add yet another one unless it is really
> > > required. So it would be good to get some reviews from the MM people.
> >
> > I'm happy to do that if you still think it's necessary; how do I do tha=
t?
>
> Reach out to Andrew Morton <akpm@linux-foundation.org>, the main
> Memory Management Maintainer. Ask who a good person would be to review
> this code.
>
>         Andrew

