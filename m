Return-Path: <netdev+bounces-80990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C470D8856A6
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65460283319
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D575472A;
	Thu, 21 Mar 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="SrLB9TdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02A51C2A
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014257; cv=none; b=ZYCBobwnMf6gbtVLJRY6N36E4pXUoMXBugXb40QitLsqQWAGmm3iUjfyAuCzqRykiQOpR/s1Gr4cUaIv8VXwyDcAlC6q8Zk5Z8Zq3/ZIaCUJL+A1+jBl6OMnu/Oa7V3PAZs7QZd0H/8VDvb/WItdtE80kxl7aOYLvVDSN48n0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014257; c=relaxed/simple;
	bh=+BddkWmVb2KxQclyW5gI/MMg+/38KCLwOvq0RB+zoRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiZSO0wXeU8tdflmGgs4DLv6HWsDWm3GPsSNestD3Ih8QcPFuWe+bse5a0NKHFPiB40RGJeb03lR4Vt15qt/6EXlZQuJfF2IH2LqOMtwW028/HWFwPm4/kRp+sOcGdUXHcyl6YpELStfT9GR9u1aZNlpcS5mtuc/i73GgIciXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=SrLB9TdI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d4a901e284so16154951fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1711014253; x=1711619053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bnysIZLRHuJugMNjksHZ7KgXRP8kfnV+ELbUklK0tQ=;
        b=SrLB9TdIyj9HcCaj0X+Zn/aLZYsDDZf7O0uwLhSDuVfyjGTFcYh1O7x7oVh5zrZ0GB
         2ZyeDI30c4f4vGNiSYHExKSEE/UIOdWA2gc/PgVXaROnsB/Afu2v+Mk6TXKa4TMYal1L
         1KEq/waaaGrDznKytiA2CHOZMSsHZyl7YL6Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014253; x=1711619053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bnysIZLRHuJugMNjksHZ7KgXRP8kfnV+ELbUklK0tQ=;
        b=RgmXK1ASRwzstHNcIZx3Nf6EM612qc/VHA55gy5p5u1Mq5vpjpbhZQiBkmF12sTDSs
         hA+ploYt8RtcC9uq2EreN7H5oFsyn8g3qMb506XhKUIeRv8YOBf3n1szZ2XDv61qLTSz
         hacQOklsgIqd/NWF3NrSRh63/8QKLhofE6Hy8xV8RFFl9RpdCDrzugfJT9gpA7VRC6dL
         tLP1Xis11XDEmmgqWoDVoEFR68a4BffhY8cHSAAGxPGRzf7fpSRtsiha+VGRVbRNt+/Z
         XmcN653czq+1WvF4QAsrbwDSZs/o9eCo76TNmld/b0VnX0W7gvfheCYHNGjEsXX+5cAD
         +sOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4dXtvTnJSAE0gBgAHO4DWVuSeRX1Kj8DlAKmjbYCHU5Z8E0uWFUC7Vdh4uysYRkSSRaBZ4yzg07tHmvZkShmlZO3ta971
X-Gm-Message-State: AOJu0YyJSODF4XL5BrIHswyLhEskczOYhJ7miRiEFyQlT7QO3eeRDZwf
	bxaA40CkavUQEZ0vJWyL4DK8G36BHdpHUsB6vvqdXlr0P1xkmXmqjJku24F9eDW8V4bmiayjNyv
	7g+pdOa2A0Mv4p5MXbbL1uO/e83DdFfVeF4H9
X-Google-Smtp-Source: AGHT+IEuiJ3gPiBp0utLLCSVFQZk+rtPf3Lsyn4LSIs5SyTRd+I+8Eds85ZIqUIGPgvT//dxXReBQprBN392uYZNzpA=
X-Received: by 2002:a05:651c:3cf:b0:2d4:132b:9f21 with SMTP id
 f15-20020a05651c03cf00b002d4132b9f21mr1205215ljp.6.1711014253330; Thu, 21 Mar
 2024 02:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
In-Reply-To: <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
From: Igor Raits <igor@gooddata.com>
Date: Thu, 21 Mar 2024 10:44:01 +0100
Message-ID: <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason & others,

On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata.com> wr=
ote:
> >
> > Hello Stefan,
> >
> > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > > Hello,
> > > >
> > > > We have started to observe kernel crashes on 6.7.y kernels (atm we
> > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 where we
> > > > have nodes of cluster it looks stable. Please see stacktrace below.=
 If
> > > > you need more information please let me know.
> > > >
> > > > We do not have a consistent reproducer but when we put some bigger
> > > > network load on a VM, the hypervisor's kernel crashes.
> > > >
> > > > Help is much appreciated! We are happy to test any patches.
> > >
> > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > >
> > > >
> > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted: G
> > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > >
> > > Are there any patches in this kernel?
> >
> > Only one, unrelated to this part. Removal of pr_err("EEVDF scheduling
> > fail, picking leftmost\n"); line (reported somewhere few months ago
> > and it was suggested workaround until proper solution comes).
>
> Btw, a bisection would help as well.

In the end it seems like we don't really have "stable" setup, so
bisection looks to be useless but we did find few things meantime:

1. On 6.6.9 it crashes either with unexpected GSO type or usercopy:
Kernel memory exposure attempt detected from SLUB object
'skbuff_head_cache'
2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
0010:skb_release_data+0xb8/0x1e0
3. It does NOT crash on 6.8.1 when VM does not have multi-queue setup

Looks like the multi-queue setup (we have 2 interfaces =C3=97 3 virtio
queues for each) is causing problems as if we set only one queue for
each interface the issue is gone.
Maybe there is some race condition in __pfx_vhost_task_fn+0x10/0x10 or
somewhere around? We have noticed that there are 3 of such functions
in the stacktrace that gave us hints about what we could try=E2=80=A6

>
> Thanks
>

Thank you!

