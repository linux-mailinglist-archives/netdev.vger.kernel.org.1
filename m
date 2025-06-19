Return-Path: <netdev+bounces-199283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB107ADFA72
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22603B3B25
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB9615A856;
	Thu, 19 Jun 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giraopnZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB161624DE
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750294954; cv=none; b=qGGA/W3BrQur4Zvz1lw4g2vIRkdmNXKV5kLAffh2tTd9ux8+sb0tsqy8zAcmGwp9EgZHiE1dPyvyLybjgftZkbjQ20QwzlWYQr65+rmRH3sxZ27Z7MaLm/+l5r3bSCU7mGEHXj4thEZc0aaU3Iawh9AwDCf0InwkNfl09Ubd0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750294954; c=relaxed/simple;
	bh=Gh2HTqjo6HqHISVOKNkZllB0IT8SZEBJKMzIIC1BIaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUwfUBjbBv5hhwDsr7aynprp1DU029fM3p7D3qmIyIeRi21TdosXSznsg7CUf+fZlvOhX2Zzml0ChpB+FtuwtSv19RUyf/xpnaFZeNwSY4YoMUH2fvzqKEXnNs1xepTHYhYYmdCca1W0B8hQz0UtSK+JCQq+TmClmP1mwkj/DJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giraopnZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750294949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l65TrwKTqa28Ab3gvX6Whw90rT+WUXHj8udnKRnKtFc=;
	b=giraopnZrOlADt9FA+rcH8TfkpdvONxGIYBUdXzU2wHNualW7intAQVqC6Tg+/psROVVpS
	9mm7Nm6camDXe6RoIRoossxvAKkDS4yX2eVm+U97E8PsnaI3Kwy646ekjDZfTWYqrCi8E1
	EiYIa3oB7S8WcSN2ndzsIw39VDEdKMY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-JC_8xQXJN_6GUrd8lEF63g-1; Wed, 18 Jun 2025 21:02:26 -0400
X-MC-Unique: JC_8xQXJN_6GUrd8lEF63g-1
X-Mimecast-MFC-AGG-ID: JC_8xQXJN_6GUrd8lEF63g_1750294944
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so141428a91.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 18:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750294944; x=1750899744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l65TrwKTqa28Ab3gvX6Whw90rT+WUXHj8udnKRnKtFc=;
        b=Z0He5yKdCQZKO7rAe198xXr4Tj98QqolCFTUvtUGS1eTIipj7J6ZJu/9u9rbFMfgtc
         SsRdoR/ZKhN0ShS7xj+3JqCe8zro8G1NYJF/8wZ6t6xlvZ490ph+vnJxyhQ3k/tm8BTp
         1EkJDGFhzPOIKT4BVw0RU2+eBuyH3PMQ1r2mIxK2MN2sreltnwTvrq3YLzXTm9D2vNMq
         nY+tUbnK/RnM8LgCQcFEeQU2pKY6wDpmp7QIi+i+VjCe0OSFly9DWrjMe+Jbuh98yrqD
         N6JdhQLEgQEOZ+DNtPPlXzhWQ6/rBrNsAWdWGn8UF3wyCBCnsABd/ZmVhbCwD7ryHXWD
         SWYg==
X-Forwarded-Encrypted: i=1; AJvYcCX5A9s986BT+5Me4z3TP901UNU9n5YJ6BSFwiL2kCdSzeVmxY0yV2a/+6v+sts/1mBjtKf1gbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkln6UuTs5YglMqsfT0+xyklX+NwYSkNv6tBStGmIFM5bvSqBf
	fzyw23ac2+8fzYYc/O/ilLQw2ItafAH9Iu1wMt4a9w44i6B3PKQWlZNK1x8QUTEiBIDcrLVro1s
	iOp8G4pAyNgT3MFCmR/MdWFXZVXjZTD2+zhkZTw+wsi7I+E9EXEPNE48h5qJLNDarADV0TPADyj
	IIrdlv31sNrUEl0LthCzi+YKIG7lgJya2J
X-Gm-Gg: ASbGncvnsIyzhXZmJsY6aCY2BaB0hgK8hPoyZGfq77Ijqa6fZX8izOOO3TLvIsChdGP
	owdeNVBzULmbhIHBG9joOGUBra/gWkGomKEa2GylBBxqURYnEab3fEIGRKv+7L3uME+muJxMwFF
	dH
X-Received: by 2002:a17:90b:4b07:b0:311:e358:c4af with SMTP id 98e67ed59e1d1-313f1d4e22fmr33298302a91.16.1750294943507;
        Wed, 18 Jun 2025 18:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvD1oNGfqVd8IaeRKyp0By/ZB9vOLf69wY8Wdjl95C+Bq7i6eW/n+2Kf6VIikkjjMZqqg/6jugigwoZuc6aLU=
X-Received: by 2002:a17:90b:4b07:b0:311:e358:c4af with SMTP id
 98e67ed59e1d1-313f1d4e22fmr33298246a91.16.1750294942980; Wed, 18 Jun 2025
 18:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com> <20250616062922.682558-2-lulu@redhat.com>
 <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com>
In-Reply-To: <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Jun 2025 09:02:11 +0800
X-Gm-Features: AX0GCFsYtNF6CJUPUnvICkqbfymXVtXGjil77zAKX7_d_Qq1yhWIuFMie025ixE
Message-ID: <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: nicolas.dichtel@6wind.com
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:06=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 16/06/2025 =C3=A0 08:28, Cindy Lu a =C3=A9crit :
> > This patch reintroduces kthread mode for vhost workers and provides
> > configuration to select between kthread and task worker.
> >
> > - Add 'fork_owner' parameter to vhost_dev to let users select kthread
> >   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> >
> > - Reintroduce kthread mode support:
> >   * Bring back the original vhost_worker() implementation,
> >     and renamed to vhost_run_work_kthread_list().
> >   * Add cgroup support for the kthread
> >   * Introduce struct vhost_worker_ops:
> >     - Encapsulates create / stop / wake=E2=80=91up callbacks.
> >     - vhost_worker_create() selects the proper ops according to
> >       inherit_owner.
> >
> > - Userspace configuration interface:
> >   * New IOCTLs:
> >       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
> >         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHRE=
AD)
> >       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
> >   * Expose module parameter 'fork_from_owner_default' to allow system
> >     administrators to configure the default mode for vhost workers
> >   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whet=
her
> >     these IOCTLs and the parameter are available (for distros that may
> >     want to disable them)
> >
> > - The VHOST_NEW_WORKER functionality requires fork_owner to be set
> >   to true, with validation added to ensure proper configuration
> >
> > This partially reverts or improves upon:
> >   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarra=
y")
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig      |  17 +++
> >  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
> >  drivers/vhost/vhost.h      |  22 ++++
> >  include/uapi/linux/vhost.h |  29 +++++
> >  4 files changed, 294 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 020d4fbb947c..1b3602b1f8e2 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >
> >         If unsure, say "N".
> >
> > +config VHOST_ENABLE_FORK_OWNER_CONTROL
> > +     bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> > +     default n
> Why disabling this option by default?

I think we should enable this by default.

Thanks

>
> Regards,
> Nicolas
>


