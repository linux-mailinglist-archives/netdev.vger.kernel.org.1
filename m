Return-Path: <netdev+bounces-115204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E989F9456AD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A30AB21D26
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93D1804F;
	Fri,  2 Aug 2024 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKIxgsJ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D01843
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722569411; cv=none; b=CVBCgG/2ughWM261XN8lZdHCZIIG+MkKj9tVWVJYH114Zgut52Rr277r11HQrm+X2uS/p7i7IIGj13AA1CFsG3IO8EVDS7t4rscN8pyERKtqJc6XnxtjPCYo69aMnZs5rWc2HTwRztCyPSrjMcyDU8G/K3R1mMYMJts+F2xN9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722569411; c=relaxed/simple;
	bh=fkuBZ/9voPFfArgs0u7ovfz/ciJcaqzcoeTD7gUud+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI2W9FpAZe9fVx+hRp1/J6IARM0XvsRWNOxcWWje4attXD/JsaTPeR0MazoFxuAaT/RvJb0n5HlafpQGdSWlO9vvD+Dgpwt0x4EWRsKrW/spX8UsadBS/BdeBp6xHqBZje4EiLi9DEg8aA77+Yl/1Xdx3a9X4x35dYbGeQAbtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKIxgsJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722569408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYs07gX+68Fkga6CWEyd0P9TjFrALens7Dug0RaQ20I=;
	b=iKIxgsJ2w6DRdUOIT6881o6aTQRMwC2LgCtKaHGm6UU7hJcHboI/WU4Lm2q/EG7SzMdq/4
	9IBZ/xsNHbeD/zTE1qAKTZvEK5BwTJ60MYurNqB7wxpwmHxzqW3qifmb9vTU2wmGhSqIRw
	6nD6BJQfjBcml5BdlkqjIxlMg3+d7Rw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-ybW5FWYKN0qzLoZKj4b8gA-1; Thu, 01 Aug 2024 23:30:07 -0400
X-MC-Unique: ybW5FWYKN0qzLoZKj4b8gA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cfe9270d4aso1899691a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 20:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722569406; x=1723174206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYs07gX+68Fkga6CWEyd0P9TjFrALens7Dug0RaQ20I=;
        b=qHp2s4qwoeO3xpjK2bcG8FE+hJCnwIiy0zUzrvR+20Loapkhn8MkUkvJWE8VFGobh9
         +0hjQwam+6KWhee8qXtLCQP2TzckbZ1PA2RDTwuvQlBj4V42budijOw0o07It4MgZx4s
         jzL1podVx+v7xxIENleZcdTDqeT4Gl4tj+yf9MsDo42FtH/GUks+X543pMQwYKoScFzG
         GbTeWWj7d/41tywIRzq2y8BkGewiUcjHFIgzObdjbeuDzQm89N3IBcnwVLl6md4siadA
         UTXIZWJ3WIT69UucNe5rebZJ+u91k9z50mDLFz6Pp3+B+pJbMFArlVDG1J4/gF5DzuV2
         Jpsw==
X-Forwarded-Encrypted: i=1; AJvYcCUnsWFuYKcB2eV/vFZpyfwQGVW72cQ9HUF13LEah7vpDmBZrl3/uApKlV3b1D+gfeZMNm125hs6A+fsDu3Yg7fMhkc1Jm5w
X-Gm-Message-State: AOJu0YzlpDwqqmT9tMh0Km9MJx4QTof+6T2Rm0sVUX17EPNppNNljjfi
	hGz9bBQs/ApSnuPHi6+n5Z/CTyYIYZWDkGGdVmTdGPg04JamJzBTIpMcpV3yrFVALTlfoCCbO7m
	u3WhjfpTUijqjmtvGC4XzIbJVE1ORy8tVkmaSZnWYKp28VYMEch+DijtRTVcr0PYOOLR/65KptE
	N3FNfqejpoA+5J1U589lNUyfcAtJkf
X-Received: by 2002:a17:90b:4a92:b0:2c9:79d3:a15d with SMTP id 98e67ed59e1d1-2cff955990fmr2790964a91.29.1722569405872;
        Thu, 01 Aug 2024 20:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQRQ/W2bxUZ4fmyFACsHHugct/QvZY7SyEDi/cN1+lFTUmIsWbE6ZPpM3HrIrS6ZKxQliTy3j6BqHAbqnrVdM=
X-Received: by 2002:a17:90b:4a92:b0:2c9:79d3:a15d with SMTP id
 98e67ed59e1d1-2cff955990fmr2790948a91.29.1722569405302; Thu, 01 Aug 2024
 20:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801153722.191797-2-dtatulea@nvidia.com>
In-Reply-To: <20240801153722.191797-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Aug 2024 11:29:54 +0800
Message-ID: <CACGkMEutqWK+N+yddiTsnVW+ZDwyM+EV-gYC8WHHPpjiDzY4_w@mail.gmail.com>
Subject: Re: [RFC PATCH vhost] vhost-vdpa: Fix invalid irq bypass unregister
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The following workflow triggers the crash referenced below:
>
> 1) vhost_vdpa_unsetup_vq_irq() unregisters the irq bypass producer
>    but the producer->token is still valid.
> 2) vq context gets released and reassigned to another vq.

Just to make sure I understand here, which structure is referred to as
"vq context" here? I guess it's not call_ctx as it is a part of the vq
itself.

> 3) That other vq registers it's producer with the same vq context
>    pointer as token in vhost_vdpa_setup_vq_irq().

Or did you mean when a single eventfd is shared among different vqs?

> 4) The original vq tries to unregister it's producer which it has
>    already unlinked in step 1. irq_bypass_unregister_producer() will go
>    ahead and unlink the producer once again. That happens because:
>       a) The producer has a token.
>       b) An element with that token is found. But that element comes
>          from step 3.
>
> I see 3 ways to fix this:
> 1) Fix the vhost-vdpa part. What this patch does. vfio has a different
>    workflow.
> 2) Set the token to NULL directly in irq_bypass_unregister_producer()
>    after unlinking the producer. But that makes the API asymmetrical.
> 3) Make irq_bypass_unregister_producer() also compare the pointer
>    elements not just the tokens and do the unlink only on match.
>
> Any thoughts?
>
> Oops: general protection fault, probably for non-canonical address 0xdead=
000000000108: 0000 [#1] SMP
> CPU: 8 PID: 5190 Comm: qemu-system-x86 Not tainted 6.10.0-rc7+ #6
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf2=
1b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:irq_bypass_unregister_producer+0xa5/0xd0
> RSP: 0018:ffffc900034d7e50 EFLAGS: 00010246
> RAX: dead000000000122 RBX: ffff888353d12718 RCX: ffff88810336a000
> RDX: dead000000000100 RSI: ffffffff829243a0 RDI: 0000000000000000
> RBP: ffff888353c42000 R08: ffff888104882738 R09: ffff88810336a000
> R10: ffff888448ab2050 R11: 0000000000000000 R12: ffff888353d126a0
> R13: 0000000000000004 R14: 0000000000000055 R15: 0000000000000004
> FS:  00007f9df9403c80(0000) GS:ffff88852cc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000562dffc6b568 CR3: 000000012efbb006 CR4: 0000000000772ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? die_addr+0x36/0x90
>  ? exc_general_protection+0x1a8/0x390
>  ? asm_exc_general_protection+0x26/0x30
>  ? irq_bypass_unregister_producer+0xa5/0xd0
>  vhost_vdpa_setup_vq_irq+0x5a/0xc0 [vhost_vdpa]
>  vhost_vdpa_unlocked_ioctl+0xdcd/0xe00 [vhost_vdpa]
>  ? vhost_vdpa_config_cb+0x30/0x30 [vhost_vdpa]
>  __x64_sys_ioctl+0x90/0xc0
>  do_syscall_64+0x4f/0x110
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f9df930774f
> RSP: 002b:00007ffc55013080 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000562dfe134d20 RCX: 00007f9df930774f
> RDX: 00007ffc55013200 RSI: 000000004008af21 RDI: 0000000000000011
> RBP: 00007ffc55013200 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000562dfe134360
> R13: 0000562dfe134d20 R14: 0000000000000000 R15: 00007f9df801e190
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 478cd46a49ed..d4a7a3918d86 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -226,6 +226,7 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vd=
pa *v, u16 qid)
>         struct vhost_virtqueue *vq =3D &v->vqs[qid];
>
>         irq_bypass_unregister_producer(&vq->call_ctx.producer);
> +       vq->call_ctx.producer.token =3D NULL;
>  }
>
>  static int _compat_vdpa_reset(struct vhost_vdpa *v)
> --
> 2.45.2
>

Thanks


