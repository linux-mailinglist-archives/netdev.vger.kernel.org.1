Return-Path: <netdev+bounces-81171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568488663A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E851C20756
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160610A24;
	Fri, 22 Mar 2024 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFo9hMVJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA114AAE
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085467; cv=none; b=cQ723muuFhsPUzpaRuNFzib4iPBK2mrfuO9U7uarraeAAwaaWvx9zCX5zoKVAw8YXc/8tjwGrMV4Z3DSOM0cyneYlXa6twwuUKiIKPKFkmEhNLme7c5Pe+DeX4BXWJ6GALmXn3lpEbKmp1P3vSA3n0sKfDpSJIOaj8rcgyzVkdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085467; c=relaxed/simple;
	bh=q21Oo2Bry/F1emY/6CL7cFJhoOqCZgnwXMWaEqLUKt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6k0q9Gm77bV0rA8rU9g3TJA8jU8F4lgiG/QBUb48UnyhN+d0XuBbfJGWjCjeRqXCbLl9q9hVmfRXuih9UWgVEjQxqBkqSRV34lpKGkduQTNZuX44ACDk7UGU/oQVGu7wuGF3dfyay3sBh+o3oMzVoK/QlOeKGJXXAFUKa0Ajzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFo9hMVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711085464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zeyqe8RQeD7lvkeazy10PIuuNwicb6A5lKZzL5V9940=;
	b=MFo9hMVJ2H8tk8AlN9wngYTEt280urgOJ+91qE1Wina7VRXr+/DoFD0fNYC3ChhbSqiHBu
	9b44xu/a14XS8pIwH5UpHtGR4cSYxt4pM7pinINvfAx9nBbzhlekzAEVQ+PenW7K+kQV2D
	UOmJFadUIgwAusCqvBSHCG6aMcGjxeE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-CprJDWViPLKjQYYR7BuX7A-1; Fri, 22 Mar 2024 01:31:03 -0400
X-MC-Unique: CprJDWViPLKjQYYR7BuX7A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29de982f09aso1295429a91.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085462; x=1711690262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zeyqe8RQeD7lvkeazy10PIuuNwicb6A5lKZzL5V9940=;
        b=XLy22xoVwFQ55w4qQ15Y1z+qvQB9eYR3ibg728r/UwMJe5P9ucwFzKLjUW4buDyB3q
         tL5wj/LRU+SDlNBiLkpnfOgBinStEq2RkcAAbpnznLtHYEFAjRnNOU/6IsU1V+pfP+4r
         G3au6G2G71wyiGqRS/0+7ZYy16/PeD22IM1KgCVKiNQUjRvABFSB+YL3QmjKCIOso4sU
         e4AZnS13Ni6TXTpQH0ovbpWMbKSfa7Yvw8UY8mv/0m2LF++u8+GPasGXnMCEZDmzHyPj
         ffs0UAQfSsYXAmiBF3QyoXWqMMLX0r/Y4m4UiW+CZxMaovXjT4xbzb5SHcAtex1Dh706
         OSFA==
X-Forwarded-Encrypted: i=1; AJvYcCWGrK8qoX1iIeRf+bG20Oyspr77GbMgnecviPt+OIrnzX/HEIne0o52VkXD3/YMPr0ZGMZotorhKUkOq3kZpXjEmf36Aqtd
X-Gm-Message-State: AOJu0Yy2gbyPsnRbTp1vRdYbwTu7/Plg05xjIUyY4fEAhfpOODIWwCX5
	wAjLu2QqBRXAtL1BFjij+vJr2yJRrFuauVVys6lF3vBdV3NZ4YfoxoKLzmIjx8t+MHPXc42hvQZ
	TRzFaTIgVOoDe53uDKOFey/sLSOofjYecLAct1fItmI9CzNk2ApXbj/CeoONWfl6fiShpUaJoTl
	6zoT1ol2fWaFYhyrm7kYDmWX+jLUdO
X-Received: by 2002:a17:90a:a418:b0:29c:5ba3:890e with SMTP id y24-20020a17090aa41800b0029c5ba3890emr1322049pjp.4.1711085461978;
        Thu, 21 Mar 2024 22:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQB0sfVvGsmkxlkxiev1UO+YVtZ530Wo19MHC05q7NO4RtVeKRKi9QvIqyovGaiEZByXQR8JJUbHlopkLt9Ak=
X-Received: by 2002:a17:90a:a418:b0:29c:5ba3:890e with SMTP id
 y24-20020a17090aa41800b0029c5ba3890emr1322041pjp.4.1711085461672; Thu, 21 Mar
 2024 22:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com> <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
In-Reply-To: <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:30:50 +0800
Message-ID: <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Igor Raits <igor@gooddata.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:44=E2=80=AFPM Igor Raits <igor@gooddata.com> wrot=
e:
>
> Hello Jason & others,
>
> On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata.com> =
wrote:
> > >
> > > Hello Stefan,
> > >
> > > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > >
> > > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > > > Hello,
> > > > >
> > > > > We have started to observe kernel crashes on 6.7.y kernels (atm w=
e
> > > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 where w=
e
> > > > > have nodes of cluster it looks stable. Please see stacktrace belo=
w. If
> > > > > you need more information please let me know.
> > > > >
> > > > > We do not have a consistent reproducer but when we put some bigge=
r
> > > > > network load on a VM, the hypervisor's kernel crashes.
> > > > >
> > > > > Help is much appreciated! We are happy to test any patches.
> > > >
> > > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > > >
> > > > >
> > > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted: G
> > > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > > >
> > > > Are there any patches in this kernel?
> > >
> > > Only one, unrelated to this part. Removal of pr_err("EEVDF scheduling
> > > fail, picking leftmost\n"); line (reported somewhere few months ago
> > > and it was suggested workaround until proper solution comes).
> >
> > Btw, a bisection would help as well.
>
> In the end it seems like we don't really have "stable" setup, so
> bisection looks to be useless but we did find few things meantime:
>
> 1. On 6.6.9 it crashes either with unexpected GSO type or usercopy:
> Kernel memory exposure attempt detected from SLUB object
> 'skbuff_head_cache'

Do you have a full calltrace for this?

> 2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
> 0010:skb_release_data+0xb8/0x1e0

And for this?

> 3. It does NOT crash on 6.8.1 when VM does not have multi-queue setup
>
> Looks like the multi-queue setup (we have 2 interfaces =C3=97 3 virtio
> queues for each) is causing problems as if we set only one queue for
> each interface the issue is gone.
> Maybe there is some race condition in __pfx_vhost_task_fn+0x10/0x10 or
> somewhere around?

I can't tell now, but it seems not because if we have 3 queue pairs we
will have 3 vhost threads.

> We have noticed that there are 3 of such functions
> in the stacktrace that gave us hints about what we could try=E2=80=A6

Let's try to enable SLUB_DEBUG and KASAN to see if we can get
something interesting.

Thanks

>
> >
> > Thanks
> >
>
> Thank you!
>


