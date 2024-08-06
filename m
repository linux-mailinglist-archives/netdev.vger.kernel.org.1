Return-Path: <netdev+bounces-115940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F69487B6
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 04:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C579F283BC9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04093BBEB;
	Tue,  6 Aug 2024 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HG9exNHo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDBC3BBC1
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913051; cv=none; b=SyeV8qP4k1TExQ37idQrChm/scLKBHnRvkck7CKh5nMwLrcV95n099on2+XgC6yVHnonW1zOwgckkUSCD0kZyqONfWKmKGM4DDXHrkMBD72uP5whNnV1OkdNpFG1Yt0q3fosp6sQcyHUgxGIe0rDRPYVW6++UkqZrJDm9BiTrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913051; c=relaxed/simple;
	bh=Et3Rgv15AHoLf3qbw1RElJDtSFKydQXp0V3QkhFEXYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdUObKvuZvQe/C9TK45xl6zQcpKDl++YutDOBJGNzqTDhVA/WtpELcRneVHA+hQEhTC22z27cPJiFnSUbwfT7VdckXPZprYH9DfKEkP25L+PajLqMCzum79tR80+qHUJQZUA/RQG2H3ORG0KAx1DgRB5y87uPN8zpy6NW3PsecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HG9exNHo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722913048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/Ealr7U/YUSVDDNANGwGdcf9UjVrAd+Xl/AaSABtGc=;
	b=HG9exNHo+Z3hFOFiaVboVOT0qewHZhHVXFHFbNnMRdlMxI/3WANi6lp3e0/cGj6m/LwwC/
	viIeU0DfbOAUPNImgvIoT9NRLLg/OCNx3Qb6zg+CzcVoYEOxNWmdSJRTB5DFMi9zSuKOO+
	VRsaO2laNFC+FP5+mv7U0g7TxwuCwSE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-0g0tyz30MQeAznXHuKuG8Q-1; Mon, 05 Aug 2024 22:57:27 -0400
X-MC-Unique: 0g0tyz30MQeAznXHuKuG8Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cd72aa5328so386964a91.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 19:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913046; x=1723517846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/Ealr7U/YUSVDDNANGwGdcf9UjVrAd+Xl/AaSABtGc=;
        b=HGeen/flTKqiF5HhMI9u9Q3NadA+nsWF4Bi0CX4HjcHIA7Y3zXDnbVPsdFaBOU9C5r
         JPuqROWAcJuIaj3r+1BsU9EGFA9briEontynA6A6/SwSpAngnwrCrlEtNIfR3BtiyCle
         hdcX1/2I6jZ3teIgUW4iKT3q/73LBHmeAY2lN7gVq8j267nVmk2bFBPPbWRIXl8FpkrX
         jB0ogXyXuFyiDUe7LcCkLzCCzve9+t1lvD5drMAvoK1Gozrg+GfT7b5W04SRaaVhz/Xd
         tTk7H3ZsRmFF5Mht1IrD/eJzH+3Qdsdb1UaH89J8LmK6UoctpuNf66VHzKPuKtk3dTD6
         sZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWxrRvHwmhnJk6J454m9FMpNRkUSleWxSIbL/F122HwyGPARX+rbNge9F11d4jyW5Ehh5YO3RVRDkYaXdWYVdqeDhFjODml
X-Gm-Message-State: AOJu0YwxetKjZX1PxLpU1BrAehVeHL/bobMnoFO+hIbsJIXEnyZ/ImYQ
	fH6GSeWRJMSSBFejB8A/AVXCfLXKpDaKev09yN0ZCOAqsyK4fAx/wZpcjrW42TnJ8i6DNt66u2x
	U8bJh7QTw6Qy50VlaNQ1IXPfCt7EyP/p3SNOLu5b8CwxB2Ejs5Vm/meJ2FZuMsVpiuVQnr+88zI
	j3/fPIXWymqsDM5SvQZAuixwa7K9Be
X-Received: by 2002:a17:90a:5ae5:b0:2ca:7f3e:a10f with SMTP id 98e67ed59e1d1-2cff93c5a19mr12543748a91.9.1722913045791;
        Mon, 05 Aug 2024 19:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF14o/QZvCia+rUu3d6wzCzB8kmwnmiRbIkLwlrBhoI/u/PVzEyXmhGN8WZBvpq5XCGGWGVK02Hxk64IRBCczY=
X-Received: by 2002:a17:90a:5ae5:b0:2ca:7f3e:a10f with SMTP id
 98e67ed59e1d1-2cff93c5a19mr12543733a91.9.1722913045229; Mon, 05 Aug 2024
 19:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801153722.191797-2-dtatulea@nvidia.com> <CACGkMEutqWK+N+yddiTsnVW+ZDwyM+EV-gYC8WHHPpjiDzY4_w@mail.gmail.com>
 <51e9ed8f37a1b5fbee9603905b925aedec712131.camel@nvidia.com>
 <CACGkMEuHECjNVEu=QhMDCc5xT_ajaETqAxNFPfb2-_wRwgvyrA@mail.gmail.com> <cc771916-62fe-4f6b-88d2-9c17dff65523@nvidia.com>
In-Reply-To: <cc771916-62fe-4f6b-88d2-9c17dff65523@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 10:57:13 +0800
Message-ID: <CACGkMEvPNvdhYmAofP5Xoqf7mPZ97Sv2EaooyEtZVBoGuA-8vA@mail.gmail.com>
Subject: Re: [RFC PATCH vhost] vhost-vdpa: Fix invalid irq bypass unregister
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 11:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On 05.08.24 05:17, Jason Wang wrote:
> > On Fri, Aug 2, 2024 at 2:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >>
> >> On Fri, 2024-08-02 at 11:29 +0800, Jason Wang wrote:
> >>> On Thu, Aug 1, 2024 at 11:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> >>>>
> >>>> The following workflow triggers the crash referenced below:
> >>>>
> >>>> 1) vhost_vdpa_unsetup_vq_irq() unregisters the irq bypass producer
> >>>>    but the producer->token is still valid.
> >>>> 2) vq context gets released and reassigned to another vq.
> >>>
> >>> Just to make sure I understand here, which structure is referred to a=
s
> >>> "vq context" here? I guess it's not call_ctx as it is a part of the v=
q
> >>> itself.
> >>>
> >>>> 3) That other vq registers it's producer with the same vq context
> >>>>    pointer as token in vhost_vdpa_setup_vq_irq().
> >>>
> >>> Or did you mean when a single eventfd is shared among different vqs?
> >>>
> >> Yes, that's what I mean: vq->call_ctx.ctx which is a eventfd_ctx.
> >>
> >> But I don't think it's shared in this case, only that the old eventfd_=
ctx value
> >> is lingering in producer->token. And this old eventfd_ctx is assigned =
now to
> >> another vq.
> >
> > Just to make sure I understand the issue. The eventfd_ctx should be
> > still valid until a new VHOST_SET_VRING_CALL().
> >
> I think it's not about the validity of the eventfd_ctx. More about
> the lingering ctx value of the producer after vhost_vdpa_unsetup_vq_irq()=
.

Probably, but

> That value is the eventfd ctx, but it could be anything else really...

I mean we hold a refcnt of the eventfd so it should be valid until the
next set_vring_call() or vhost_dev_cleanup().

But I do spot some possible issue:

1) We swap and assign new ctx in vhost_vring_ioctl():

                swap(ctx, vq->call_ctx.ctx);

2) and old ctx will be put there as well:

                if (!IS_ERR_OR_NULL(ctx))
                        eventfd_ctx_put(ctx);

3) but in vdpa, we try to unregister the producer with the new token:

static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
                           void __user *argp)
{
...
        r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
...
        switch (cmd) {
...
        case VHOST_SET_VRING_CALL:
                if (vq->call_ctx.ctx) {
                        cb.callback =3D vhost_vdpa_virtqueue_cb;
                        cb.private =3D vq;
                        cb.trigger =3D vq->call_ctx.ctx;
                } else {
                        cb.callback =3D NULL;
                        cb.private =3D NULL;
                        cb.trigger =3D NULL;
                }
                ops->set_vq_cb(vdpa, idx, &cb);
                vhost_vdpa_setup_vq_irq(v, idx);

in vhost_vdpa_setup_vq_irq() we had:

        irq_bypass_unregister_producer(&vq->call_ctx.producer);

here the producer->token still points to the old one...

Is this what you have seen?

>
>
> > I may miss something but the only way to assign exactly the same
> > eventfd_ctx value to another vq is where the guest tries to share the
> > MSI-X vector among virtqueues, then qemu will use a single eventfd as
> > the callback for multiple virtqueues. If this is true:
> >
> I don't think this is the case. I see the issue happening when running qe=
mu vdpa
> live migration tests on the same host. From a vdpa device it's basically =
a device
> starting on a VM over and over.
>
> > For bypass registering, only the first registering can succeed as the
> > following registering will fail because the irq bypass manager already
> > had exactly the same producer token.
> > For registering, all unregistering can succeed:
> >
> > 1) the first unregistering will do the real job that unregister the tok=
en
> > 2) the following unregistering will do nothing by iterating the
> > producer token list without finding a match one
> >
> > Maybe you can show me the userspace behaviour (ioctls) when you see thi=
s?
> >
> Sure, what would you need? qemu traces?

Yes, that would be helpful.

Thanks

>
> Thanks,
> Dragos
>
> > Thanks
> >
> >>
> >>>> 4) The original vq tries to unregister it's producer which it has
> >>>>    already unlinked in step 1. irq_bypass_unregister_producer() will=
 go
> >>>>    ahead and unlink the producer once again. That happens because:
> >>>>       a) The producer has a token.
> >>>>       b) An element with that token is found. But that element comes
> >>>>          from step 3.
> >>>>
> >>>> I see 3 ways to fix this:
> >>>> 1) Fix the vhost-vdpa part. What this patch does. vfio has a differe=
nt
> >>>>    workflow.
> >>>> 2) Set the token to NULL directly in irq_bypass_unregister_producer(=
)
> >>>>    after unlinking the producer. But that makes the API asymmetrical=
.
> >>>> 3) Make irq_bypass_unregister_producer() also compare the pointer
> >>>>    elements not just the tokens and do the unlink only on match.
> >>>>
> >>>> Any thoughts?
> >>>>
> >>>> Oops: general protection fault, probably for non-canonical address 0=
xdead000000000108: 0000 [#1] SMP
> >>>> CPU: 8 PID: 5190 Comm: qemu-system-x86 Not tainted 6.10.0-rc7+ #6
> >>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-=
0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >>>> RIP: 0010:irq_bypass_unregister_producer+0xa5/0xd0
> >>>> RSP: 0018:ffffc900034d7e50 EFLAGS: 00010246
> >>>> RAX: dead000000000122 RBX: ffff888353d12718 RCX: ffff88810336a000
> >>>> RDX: dead000000000100 RSI: ffffffff829243a0 RDI: 0000000000000000
> >>>> RBP: ffff888353c42000 R08: ffff888104882738 R09: ffff88810336a000
> >>>> R10: ffff888448ab2050 R11: 0000000000000000 R12: ffff888353d126a0
> >>>> R13: 0000000000000004 R14: 0000000000000055 R15: 0000000000000004
> >>>> FS:  00007f9df9403c80(0000) GS:ffff88852cc00000(0000) knlGS:00000000=
00000000
> >>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> CR2: 0000562dffc6b568 CR3: 000000012efbb006 CR4: 0000000000772ef0
> >>>> PKRU: 55555554
> >>>> Call Trace:
> >>>>  <TASK>
> >>>>  ? die_addr+0x36/0x90
> >>>>  ? exc_general_protection+0x1a8/0x390
> >>>>  ? asm_exc_general_protection+0x26/0x30
> >>>>  ? irq_bypass_unregister_producer+0xa5/0xd0
> >>>>  vhost_vdpa_setup_vq_irq+0x5a/0xc0 [vhost_vdpa]
> >>>>  vhost_vdpa_unlocked_ioctl+0xdcd/0xe00 [vhost_vdpa]
> >>>>  ? vhost_vdpa_config_cb+0x30/0x30 [vhost_vdpa]
> >>>>  __x64_sys_ioctl+0x90/0xc0
> >>>>  do_syscall_64+0x4f/0x110
> >>>>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >>>> RIP: 0033:0x7f9df930774f
> >>>> RSP: 002b:00007ffc55013080 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
10
> >>>> RAX: ffffffffffffffda RBX: 0000562dfe134d20 RCX: 00007f9df930774f
> >>>> RDX: 00007ffc55013200 RSI: 000000004008af21 RDI: 0000000000000011
> >>>> RBP: 00007ffc55013200 R08: 0000000000000002 R09: 0000000000000000
> >>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000562dfe134360
> >>>> R13: 0000562dfe134d20 R14: 0000000000000000 R15: 00007f9df801e190
> >>>>
> >>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>> ---
> >>>>  drivers/vhost/vdpa.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>> index 478cd46a49ed..d4a7a3918d86 100644
> >>>> --- a/drivers/vhost/vdpa.c
> >>>> +++ b/drivers/vhost/vdpa.c
> >>>> @@ -226,6 +226,7 @@ static void vhost_vdpa_unsetup_vq_irq(struct vho=
st_vdpa *v, u16 qid)
> >>>>         struct vhost_virtqueue *vq =3D &v->vqs[qid];
> >>>>
> >>>>         irq_bypass_unregister_producer(&vq->call_ctx.producer);
> >>>> +       vq->call_ctx.producer.token =3D NULL;
> >>>>  }
> >>>>
> >>>>  static int _compat_vdpa_reset(struct vhost_vdpa *v)
> >>>> --
> >>>> 2.45.2
> >>>>
> >>>
> >> Thanks
> >>
> >
>


