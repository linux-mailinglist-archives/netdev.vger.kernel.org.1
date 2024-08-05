Return-Path: <netdev+bounces-115614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD39473C1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240B01F20D3C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054613C9B3;
	Mon,  5 Aug 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CywZ+Xhh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F53BBF7
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827850; cv=none; b=fps1J7MgjQ+b/zSUcWf2T8CqJASX2wlOHlGweKn16jAECPgIHaWr84hXpJ/AzCo3H+Bfv4kGSiy60c2/rjl9Gg7In5Ux/rsx5LnXgKZvnzjfezsDfx91ODDYcTOnbCDTO59ADk24qfXANpMwpkqkblfvANeC3kzKCzZwlHc6BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827850; c=relaxed/simple;
	bh=HWTzlxbLSR9s0+KuMLVg4GGTIeRTYe128A5WIkWNFwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8wxQ7pTcKXsHmyuWUrCxhQpj1x2nXOZksfdnFOj5NbiL/dFG6tppdgrNpxmDBsczEzN1z98jeAt//2awki94yPjWgt8PshM/WaPlwuYBRIHsniaPA6wKvecuGQRTQ5FNQ0+/DUyAfsBzd8J3QlJlN8wb7sAlCVJ9VKpYhK7L7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CywZ+Xhh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722827847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZmGo3XfbtNpcJRA7Fn1zMK1Nav07/DYxRfLLC/gTe8=;
	b=CywZ+XhhsrfSl+KBxvxmtignHdLEVZhK0Ha3nZCvg1joVlNTRZPg6RKkle18Jspw0wA7Lj
	FBEAKzOFv5yRHa3z9aJgXczEfaSOL3u1NBSG+sZuHWe/WAeQKz27+s8q+IL2ZWrLbLdkro
	vtL3SA19H+lltVojEKhziEIj8KbLF6c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-dgcPLlAdOIOzW_yqFBAe1A-1; Sun, 04 Aug 2024 23:17:26 -0400
X-MC-Unique: dgcPLlAdOIOzW_yqFBAe1A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so11751249a12.3
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 20:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722827845; x=1723432645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZmGo3XfbtNpcJRA7Fn1zMK1Nav07/DYxRfLLC/gTe8=;
        b=FgNyWtWw27NFrUHotU4WkPuw1mKfonBVm+EkNusi+pklaP4J3cNYwRO445X8x05Hgd
         MgT+MtaHw4dLhQ+K2PMtbI4KCsn/PAaxsKcanTAa2YSbvuc5r5fyF7x1p1xQzjSRKXzT
         RyNeNEFsnRh0ARt8zrr+eY6hEsdHBXBDYDcg0592nXPHFO/Y1SgaE80e+b24itnlfgRj
         7UXOqeS0j+/DRjgjD2+oaYGPZ4zysIxSS/eOKA6k3jwfyFDLLxYtIB0/zqC/mQ+QmSJP
         mKiS0exZG+OFnZYhSI4DL5YzR29ssDtPe3ssk69LOJYlTKI9p/v+m5Um+tX5gT8p/74V
         flsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR6rwdQD9xJ46QHDxca4/scqtv+b3Wf0g6ocDRqwUghM/TzLijmfAqJfJ4z/SYo9nLOMKctvD0EyQhqzNPhdaCUP3IEP2y
X-Gm-Message-State: AOJu0YxdW8SwwVKAE6ad2PJZXhlCcrisaw7yXqVh/qkEMVKUaIWjwp4J
	84kgZqLBczJlINkfDLVfs5s8hOzVMVppd01ll+dyVyae7scZ/PXwfDnZafaCCg3wOHM5BTCXzMA
	4TwOlLW5+0zTOE2uolyuLim0PJMFpuSoxmVIPBsu5TVHL+qa0dXtZkzgmS5HNGNQKaLInwHUYml
	kn/QKZ9TqWCOGhYuQfgKYwoVG8prUV
X-Received: by 2002:a17:90a:a08e:b0:2c9:95ae:b0ac with SMTP id 98e67ed59e1d1-2cff958245bmr11111439a91.40.1722827845019;
        Sun, 04 Aug 2024 20:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOfwNCgY5YLUhP/7xUiEpHpXVnCxUhXX352MzgNc8HM/UvylmZut+yOxshrN3S6IDoMY9FMpdvCM5saGz+Gz4=
X-Received: by 2002:a17:90a:a08e:b0:2c9:95ae:b0ac with SMTP id
 98e67ed59e1d1-2cff958245bmr11111416a91.40.1722827844369; Sun, 04 Aug 2024
 20:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801153722.191797-2-dtatulea@nvidia.com> <CACGkMEutqWK+N+yddiTsnVW+ZDwyM+EV-gYC8WHHPpjiDzY4_w@mail.gmail.com>
 <51e9ed8f37a1b5fbee9603905b925aedec712131.camel@nvidia.com>
In-Reply-To: <51e9ed8f37a1b5fbee9603905b925aedec712131.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 11:17:13 +0800
Message-ID: <CACGkMEuHECjNVEu=QhMDCc5xT_ajaETqAxNFPfb2-_wRwgvyrA@mail.gmail.com>
Subject: Re: [RFC PATCH vhost] vhost-vdpa: Fix invalid irq bypass unregister
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Fri, 2024-08-02 at 11:29 +0800, Jason Wang wrote:
> > On Thu, Aug 1, 2024 at 11:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > The following workflow triggers the crash referenced below:
> > >
> > > 1) vhost_vdpa_unsetup_vq_irq() unregisters the irq bypass producer
> > >    but the producer->token is still valid.
> > > 2) vq context gets released and reassigned to another vq.
> >
> > Just to make sure I understand here, which structure is referred to as
> > "vq context" here? I guess it's not call_ctx as it is a part of the vq
> > itself.
> >
> > > 3) That other vq registers it's producer with the same vq context
> > >    pointer as token in vhost_vdpa_setup_vq_irq().
> >
> > Or did you mean when a single eventfd is shared among different vqs?
> >
> Yes, that's what I mean: vq->call_ctx.ctx which is a eventfd_ctx.
>
> But I don't think it's shared in this case, only that the old eventfd_ctx=
 value
> is lingering in producer->token. And this old eventfd_ctx is assigned now=
 to
> another vq.

Just to make sure I understand the issue. The eventfd_ctx should be
still valid until a new VHOST_SET_VRING_CALL().

I may miss something but the only way to assign exactly the same
eventfd_ctx value to another vq is where the guest tries to share the
MSI-X vector among virtqueues, then qemu will use a single eventfd as
the callback for multiple virtqueues. If this is true:

For bypass registering, only the first registering can succeed as the
following registering will fail because the irq bypass manager already
had exactly the same producer token.
For registering, all unregistering can succeed:

1) the first unregistering will do the real job that unregister the token
2) the following unregistering will do nothing by iterating the
producer token list without finding a match one

Maybe you can show me the userspace behaviour (ioctls) when you see this?

Thanks

>
> > > 4) The original vq tries to unregister it's producer which it has
> > >    already unlinked in step 1. irq_bypass_unregister_producer() will =
go
> > >    ahead and unlink the producer once again. That happens because:
> > >       a) The producer has a token.
> > >       b) An element with that token is found. But that element comes
> > >          from step 3.
> > >
> > > I see 3 ways to fix this:
> > > 1) Fix the vhost-vdpa part. What this patch does. vfio has a differen=
t
> > >    workflow.
> > > 2) Set the token to NULL directly in irq_bypass_unregister_producer()
> > >    after unlinking the producer. But that makes the API asymmetrical.
> > > 3) Make irq_bypass_unregister_producer() also compare the pointer
> > >    elements not just the tokens and do the unlink only on match.
> > >
> > > Any thoughts?
> > >
> > > Oops: general protection fault, probably for non-canonical address 0x=
dead000000000108: 0000 [#1] SMP
> > > CPU: 8 PID: 5190 Comm: qemu-system-x86 Not tainted 6.10.0-rc7+ #6
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0=
-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > RIP: 0010:irq_bypass_unregister_producer+0xa5/0xd0
> > > RSP: 0018:ffffc900034d7e50 EFLAGS: 00010246
> > > RAX: dead000000000122 RBX: ffff888353d12718 RCX: ffff88810336a000
> > > RDX: dead000000000100 RSI: ffffffff829243a0 RDI: 0000000000000000
> > > RBP: ffff888353c42000 R08: ffff888104882738 R09: ffff88810336a000
> > > R10: ffff888448ab2050 R11: 0000000000000000 R12: ffff888353d126a0
> > > R13: 0000000000000004 R14: 0000000000000055 R15: 0000000000000004
> > > FS:  00007f9df9403c80(0000) GS:ffff88852cc00000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000562dffc6b568 CR3: 000000012efbb006 CR4: 0000000000772ef0
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  ? die_addr+0x36/0x90
> > >  ? exc_general_protection+0x1a8/0x390
> > >  ? asm_exc_general_protection+0x26/0x30
> > >  ? irq_bypass_unregister_producer+0xa5/0xd0
> > >  vhost_vdpa_setup_vq_irq+0x5a/0xc0 [vhost_vdpa]
> > >  vhost_vdpa_unlocked_ioctl+0xdcd/0xe00 [vhost_vdpa]
> > >  ? vhost_vdpa_config_cb+0x30/0x30 [vhost_vdpa]
> > >  __x64_sys_ioctl+0x90/0xc0
> > >  do_syscall_64+0x4f/0x110
> > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > RIP: 0033:0x7f9df930774f
> > > RSP: 002b:00007ffc55013080 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 0000562dfe134d20 RCX: 00007f9df930774f
> > > RDX: 00007ffc55013200 RSI: 000000004008af21 RDI: 0000000000000011
> > > RBP: 00007ffc55013200 R08: 0000000000000002 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000562dfe134360
> > > R13: 0000562dfe134d20 R14: 0000000000000000 R15: 00007f9df801e190
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 478cd46a49ed..d4a7a3918d86 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -226,6 +226,7 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhos=
t_vdpa *v, u16 qid)
> > >         struct vhost_virtqueue *vq =3D &v->vqs[qid];
> > >
> > >         irq_bypass_unregister_producer(&vq->call_ctx.producer);
> > > +       vq->call_ctx.producer.token =3D NULL;
> > >  }
> > >
> > >  static int _compat_vdpa_reset(struct vhost_vdpa *v)
> > > --
> > > 2.45.2
> > >
> >
> Thanks
>


