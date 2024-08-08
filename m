Return-Path: <netdev+bounces-116680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082B94B589
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E091C20ECD
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B83BBE0;
	Thu,  8 Aug 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfL10oUC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD7241E7
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088229; cv=none; b=VIpDzct+6nnaNMni6lMDxSU4XI4nG2uKacCBDw+2iuxcg4YKxksujdTQcMcFNViRa/oBS9oLTbWdLvArcS1qJRW5RMCHHqtH8hnMSPvgBwZGVm0RL35Q/fyO377KrYOJS7A+8ZccNwWI6dXAnaT7NW/iZtBTWllim0N9IcxidwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088229; c=relaxed/simple;
	bh=rsfGskLeevi210+0nwnR/FvCqrDSYPYQ4o2gtKKwY2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZNoI0gCGesqHoc3Q2fXbHiRRkOG7XlaDzATxivU1/u8W4Qp6gn5dUdaGmE2vvTbNJbxFzU6mXKOs9X2/lJz7zG02A50D3PbSdlCKIT+mbY6C5mG7a4t7SkJoPsrqlVe+BJOBVidV5iicE4HknK0FOme0XylCUmLyfIj6rmyFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfL10oUC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723088227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JM5fShMRFvHDNou2oItMYL1KDcgeP9aORDib99GpkD0=;
	b=ZfL10oUCFVogz3AFH+6iiCfvKfoEBoNON7SlV0tRUZbu7hHzirFKQNqgGiNA+gi8oKYlvk
	xaJCJkfHFskzyZg2fLd8V5wq91VajjW83t1Prz7M0DsK2z08ILPnIS0LNtQTnuTe0xyvAe
	yaijhAHKZWMGeulf7cEshNK8bEXTSSQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-jw3SybO8NWSEkteWBZlciQ-1; Wed, 07 Aug 2024 23:37:05 -0400
X-MC-Unique: jw3SybO8NWSEkteWBZlciQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb4bcd9671so732819a91.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 20:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723088224; x=1723693024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM5fShMRFvHDNou2oItMYL1KDcgeP9aORDib99GpkD0=;
        b=J0QQQIRoHL3/sGT6/g9tV7fAeoRc/FZuV6GmIsyk3iRluDjw6UfpXIupbDJ8ea71Vp
         GApFhF/DcSZhKTMUlfQKgWuNqtlOH4BSchgOGMVB0ucA6bXKUcbVI4iD7ExNZ+X3gHYV
         h70e+pe0avTLUBtxEfW9fRz5LNStRRbQ4oIHbDE3BUfDS/DTPO1hrq3k+bzvmbxIJKUU
         id24KdVNtYihG0jtZJW28E1VFWHzJnPImkNksN0sHbRyRBxGrnJp5GTpJwKGEALaIy6c
         hgPaPKfQxgWfRjmwToabKc/42YUEbwxIgumwzZo/pCybv8O1kXh1cNnSQZTjZ5xCT8Kp
         UI3A==
X-Forwarded-Encrypted: i=1; AJvYcCXRfSnaGL2Dj9NnKLmroUQ9Ndg3CPYRSqU1DTpKC9HTVZXYtTJtN9YC8r9t6Xp4/fecUVogLEKxwglaGvd6h6gVQw9Jj0IT
X-Gm-Message-State: AOJu0YyTctX95brEHmc1bKhcT5jKtQCk7Q6JyInwhjCVUV2U1hGmS3GB
	t88vKhLDmXSgkkCaik4buo1G+pbAjGvt6A3+pfvXN6Y/84T92EWtEYuVdQLrDVPn8YUHgtM/ZOU
	WiP8pXz2P2ebu4kuGgkLNKSufarpf8njESRgZdplNcn9xw/J5EWiV1WJ9YCPQpgi4hXkrMtVS5e
	t1wJRPTomufMkCiILDC76k48iP0nNF
X-Received: by 2002:a17:90b:3e8c:b0:2cf:cc0d:96cc with SMTP id 98e67ed59e1d1-2d1c336e212mr716287a91.9.1723088224365;
        Wed, 07 Aug 2024 20:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8AAVl+6GMladCLXvkjOUq4BTrWPAy0oTDvxSQ1sx7mzNS7t+QEvx2CEfx/g2srsMpNQeJbpCGfwwspsvIPlc=
X-Received: by 2002:a17:90b:3e8c:b0:2cf:cc0d:96cc with SMTP id
 98e67ed59e1d1-2d1c336e212mr716268a91.9.1723088223749; Wed, 07 Aug 2024
 20:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731111940.8383-1-ayaka@soulik.info> <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info> <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info> <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
 <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info> <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
 <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info> <66acf6cc551a0_2751b6294bf@willemb.c.googlers.com.notmuch>
 <3a3695a1-367c-4868-b6e1-1190b927b8e7@soulik.info> <CAF=yD-+9HUkzDnfhOgpVkGyeMEJPhzabebt3bdzUHmpEPR1New@mail.gmail.com>
 <CACGkMEtMHn1yympWO5TpWUArVVOkxL6aaKpSVLVmAMcCNxkJag@mail.gmail.com> <CAF=yD-+2SnOzALmisVVBZAKNKrCMv07FdEDP1ov35APNMYOTew@mail.gmail.com>
In-Reply-To: <CAF=yD-+2SnOzALmisVVBZAKNKrCMv07FdEDP1ov35APNMYOTew@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 11:36:52 +0800
Message-ID: <CACGkMEvjk=8GZgw_m2Z8XoqNgAV4-k5E40wUiN3hQMZit9+rfg@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Randy Li <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:12=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > In that case, a tc egress tc_bpf program may be able to do both.
> > > Again, by writing to __sk_buff queue_mapping. Instead of u32 +
> > > skbedit.
> > >
> > > See also
> > >
> > > "
> > > commit 74e31ca850c1cddeca03503171dd145b6ce293b6
> > > Author: Jesper Dangaard Brouer <brouer@redhat.com>
> > > Date:   Tue Feb 19 19:53:02 2019 +0100
> > >
> > >     bpf: add skb->queue_mapping write access from tc clsact
> > > "
> > >
> > > But I suppose you could prefer u32 + skbedit.
> > >
> > > Either way, the pertinent point is that you want to map some flow
> > > match to a specific queue id.
> > >
> > > This is straightforward if all queues are opened and none are closed.
> > > But it is not if queues can get detached and attached dynamically.
> > > Which I guess you encounter in practice?
> > >
> > > I'm actually not sure how the current `tfile->queue_index =3D
> > > tun->numqueues;` works in that case. As __tun_detach will do decremen=
t
> > > `--tun->numqueues;`. So multiple tfiles could end up with the same
> > > queue_index. Unless dynamic detach + attach is not possible.
> >
> > It is expected to work, otherwise there should be a bug.
> >
> > > But it
> > > seems it is. Jason, if you're following, do you know this?
> >
> > __tun_detach() will move the last tfile in the tfiles[] array to the
> > current tfile->queue_index, and modify its queue_index:
> >
> >         rcu_assign_pointer(tun->tfiles[index],
> >                                    tun->tfiles[tun->numqueues - 1]);
> >         ntfile =3D rtnl_dereference(tun->tfiles[index]);
> >         ntfile->queue_index =3D index;
> >         rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >                                    NULL);
> >
> >         --tun->numqueues;
> >
> > tun_attach() will move the detached tfile to the end of the tfiles[]
> > array and enable it:
> >
> >
> >         tfile->queue_index =3D tun->numqueues;
> >         ....
> >         rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
> >         tun->numqueues++;
> >
>
> Ah right. Thanks. I had forgotten about that.
>
> So I guess an application that owns all the queues could keep track of
> the queue-id to FD mapping. But it is not trivial, nor defined ABI
> behavior.

Yes and this is because tun allows arbitrary tfile to be detached
while the networking core assumes the queues are continuously. If
application want a stable queue id it needs to "understand" the kernel
behaviour somehow (unfortunately), see below.

>
> Querying the queue_id as in the proposed patch might not solve the
> challenge, though. Since an FD's queue-id may change simply because
> another queue was detached. So this would have to be queried on each
> detach.

Let's say we have 4 tunfd.

tunfd 0 -> queue 0
...
tunfd 3 -> queue 3

To have a stable queue id it needs to detach from the last tunfd and
attach in the reverse order.

E.g if it want to detach 2 tfiles, it needs to

detach tunfd3, detach tunfd2

And it if want to attach 2 tfiles back it needs to

attach tunfd2, attach tunfd3

This is how Qemu works in the case of multiqueue tuntap and RSS. This
allows the qemu doesn't need to deduce if the mapping between
queue_index and tfile changes. But it means if kernel behavior changes
in the future, it may break a lot of usersapce.

>
> I suppose one underlying question is how important is the mapping of
> flows to specific queue-id's?

For example to implement steering offload to kernel. E.g RSS,
userspace needs to know the mapping between queue id and tfile.

> Is it a problem if the destination queue
> for a flow changes mid-stream?
>

I think this is a good question. It's about whether or not we can make
the current kernel behaviour as part of ABI.

If yes, there's no need for the explicit getindex assuming the tunfd
is created by the application itself , as the queue_index could be
deduced from the behaviour of the application itself. But it might not
be all, if tuntap fd were passed through unix domain socket, the
application that receives those file descriptors might need to know
the queue_index mappings.

If no, allow such query might be useful. It might give a chance for
the user to know the mapping as you pointed out. But this patch needs
some tweak as when the tfile is detached, the queue_index is
meaningless in that case.

Thanks


