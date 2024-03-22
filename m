Return-Path: <netdev+bounces-81232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1E886B48
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEC5285D23
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC03EA88;
	Fri, 22 Mar 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZu0pfm+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E123F8D3
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106998; cv=none; b=RoI/oVA4VM5KtksjBcVUMB5v//caqVEYqgD4Rtv3fCpcTM0e1KRhLNbMWIj9xmAzkj3JJWqG3VBrg6+Iug54dY6/E5cp8gQeL9/hlVjH+OZqyvaogdwJK5Wg4i/K6/6wHwTAo80hpyT4ZitJDTfcaNlrLDEF5euQ/xlqZF6vT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106998; c=relaxed/simple;
	bh=sIAXmu2MpVDSgTXtvrQZQ0jLcG/8PHiBbpmS1BXTv1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA3s1dfk23EXIPOVU7oPPC+6zvUvK2lWJdCN+4sNqsD6xLhh+nSYnvSDDJSsYCCCNOuEnS3Cs0BAIfn9PQlKMKK7FwefJnbbPaKloCJ+U3lam/2regkr2c3ZXzBnQSPfxQ7t+p8SD+Smk5Dx04AXdjs+m7jinj0rjEIDjUEDm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZu0pfm+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711106995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jw2bfgtsApnZVxeXjYyO+V5I9lMts3UUwyazaFvr/XA=;
	b=cZu0pfm+1VU3skkSvLcXWGakE6ET62xzoQ0DIZ2WiDGxR52LBnVdSzi37m4R3P8go7DOW9
	JtaJSR3zF/EY2nMrra55gjbTzIaLp/POX564s3OTinwNSH5RE5ice6aH+mYhMZ3v6HbPal
	4c2gTvdxEPUiRiuut1EPl8aQQbYPbdI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-xU0VMFtUOzCXF2fhZd4qLg-1; Fri, 22 Mar 2024 07:29:54 -0400
X-MC-Unique: xU0VMFtUOzCXF2fhZd4qLg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-60f9d800a29so34371837b3.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 04:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711106994; x=1711711794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw2bfgtsApnZVxeXjYyO+V5I9lMts3UUwyazaFvr/XA=;
        b=t3ptE360HwRggAzlzZ/eLkbqMbm5scG+pSEeq25yNeoZYAJsw47Ez1qr7FXwjO/2gX
         Mz6dS5wen+vU/ePPfOQjLLcwpBQeKvVIETitN69bG1a8U5yOZ/OfQRZ2VMQfpXJE1M2u
         7PF+zjGRJtJtJfKtYpdCEhq4QW54E8eMFNTzp6ZmtItEi81JrTM4/eemVZLwme2OnPNR
         RtmoXouXKti9nlYq1EUpUvNbbvBs3BFOzjIEIVwLeFCYGB0Yeawv9IFj6nB1MivXCb7E
         IThiJzNf3Vm5b6MX1NqcOFIHNcC4XzfUBWr6F5+R6TpaS981pI0j7C0KyKPq148YIpGf
         9y6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7W8RDLm4zmaoZvQIZ1BgVI3twcCDFYqfSknD9fYL661Z1RO/hZWZy8l9MPLOQk/Mk7PaCxZA3W5jCRVTBxj+2NpeGhUCk
X-Gm-Message-State: AOJu0YwW9cgQrFLl7vrNeJ7EbSIFeG28PIGvxrnhpyVqI+7P9fcg0F/L
	kVO8SSfN43xO5VCdrrnJQzuciUKTS4p1OfUpmCHNKiZyJnBiaeYFIjMKVQegJ3P7MQ0ixidCizC
	m9nOCXocKlRnmEBJ2sEoqPgsfSU3Nul6B4TCGzP6Le2RlQhv+mPs1H7yfr5wsKRJ9vDjq82G74a
	GgZCfYhLS782L5woyy1RLy4+BOdxeY
X-Received: by 2002:a0d:db13:0:b0:609:ff22:1a88 with SMTP id d19-20020a0ddb13000000b00609ff221a88mr1744241ywe.44.1711106993834;
        Fri, 22 Mar 2024 04:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy0GkXyoLQh9IGnmMcvfIfSb80352BTOhRhvV2Q6BffAizjk6dreezEJLNyHeyWFdHs2nfBlI2fXh5chdbxhI=
X-Received: by 2002:a0d:db13:0:b0:609:ff22:1a88 with SMTP id
 d19-20020a0ddb13000000b00609ff221a88mr1744204ywe.44.1711106993294; Fri, 22
 Mar 2024 04:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
 <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
 <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
 <CA+9S74hUt_aZCrgN3Yx9Y2OZtwHNan7gmbBa1TzBafW6=YLULQ@mail.gmail.com> <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
In-Reply-To: <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 22 Mar 2024 12:29:41 +0100
Message-ID: <CAGxU2F63gJGbVBANeg4rA33E5gLacSawWamCPNTkigTE4bGgaw@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Igor Raits <igor@gooddata.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:20=E2=80=AFPM Igor Raits <igor@gooddata.com> wro=
te:
>
> Hi Jason,
>
> On Fri, Mar 22, 2024 at 9:39=E2=80=AFAM Igor Raits <igor@gooddata.com> wr=
ote:
> >
> > Hi Jason,
> >
> > On Fri, Mar 22, 2024 at 6:31=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 5:44=E2=80=AFPM Igor Raits <igor@gooddata.com=
> wrote:
> > > >
> > > > Hello Jason & others,
> > > >
> > > > On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata=
.com> wrote:
> > > > > >
> > > > > > Hello Stefan,
> > > > > >
> > > > > > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > We have started to observe kernel crashes on 6.7.y kernels =
(atm we
> > > > > > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 w=
here we
> > > > > > > > have nodes of cluster it looks stable. Please see stacktrac=
e below. If
> > > > > > > > you need more information please let me know.
> > > > > > > >
> > > > > > > > We do not have a consistent reproducer but when we put some=
 bigger
> > > > > > > > network load on a VM, the hypervisor's kernel crashes.
> > > > > > > >
> > > > > > > > Help is much appreciated! We are happy to test any patches.
> > > > > > >
> > > > > > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > > > > > >
> > > > > > > >
> > > > > > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted=
: G
> > > > > > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > > > > > >
> > > > > > > Are there any patches in this kernel?
> > > > > >
> > > > > > Only one, unrelated to this part. Removal of pr_err("EEVDF sche=
duling
> > > > > > fail, picking leftmost\n"); line (reported somewhere few months=
 ago
> > > > > > and it was suggested workaround until proper solution comes).
> > > > >
> > > > > Btw, a bisection would help as well.
> > > >
> > > > In the end it seems like we don't really have "stable" setup, so
> > > > bisection looks to be useless but we did find few things meantime:
> > > >
> > > > 1. On 6.6.9 it crashes either with unexpected GSO type or usercopy:
> > > > Kernel memory exposure attempt detected from SLUB object
> > > > 'skbuff_head_cache'
> > >
> > > Do you have a full calltrace for this?
> >
> > I have shared it in one of the messages in this thread.
> > https://marc.info/?l=3Dlinux-virtualization&m=3D171085443512001&w=3D2
> >
> > > > 2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
> > > > 0010:skb_release_data+0xb8/0x1e0
> > >
> > > And for this?
> >
> > https://marc.info/?l=3Dlinux-netdev&m=3D171083870801761&w=3D2
> >
> > > > 3. It does NOT crash on 6.8.1 when VM does not have multi-queue set=
up
> > > >
> > > > Looks like the multi-queue setup (we have 2 interfaces =C3=97 3 vir=
tio
> > > > queues for each) is causing problems as if we set only one queue fo=
r
> > > > each interface the issue is gone.
> > > > Maybe there is some race condition in __pfx_vhost_task_fn+0x10/0x10=
 or
> > > > somewhere around?
> > >
> > > I can't tell now, but it seems not because if we have 3 queue pairs w=
e
> > > will have 3 vhost threads.
> > >
> > > > We have noticed that there are 3 of such functions
> > > > in the stacktrace that gave us hints about what we could try=E2=80=
=A6
> > >
> > > Let's try to enable SLUB_DEBUG and KASAN to see if we can get
> > > something interesting.
> >
> > We were able to reproduce it even with 1 vhost queue... And now we
> > have slub_debug + kasan so I hopefully have more useful data for you
> > now.
> > I have attached it for better readability.
>
> Looks like we have found a "stable" kernel and that is 6.1.32. The
> 6.3.y is broken and we are testing 6.2.y now.
> My guess it would be related to virtio/vsock: replace virtio_vsock_pkt
> with sk_buff that was done around that time but we are going to test,
> bisect and let you know more.
>

That patch should only affect the virtio-vsock driver and vhost-vsock
device, but here IIUC the problem is with a vhost-net device, so I'm
not sure it's related.

Thanks,
Stefano


