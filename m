Return-Path: <netdev+bounces-206070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979FB013E3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12C65A49D4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71D1DF990;
	Fri, 11 Jul 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiwOj5mx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860991DED57
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216572; cv=none; b=htv+Q+O0A201OJIMhOOKVe3YJbm6j4aP1MjoYbmo9+w1WmMPhDfC9bnpwbcCJG0vm74mXUAVjp0yayn/hvA3BQKesdAIQAUfS4AqkkrdNdeTdqO+a1EpoVIbN93A4DpKKecMW8i5oHtCY5RTcmzL87APc5vUxOvszfWfzsDblVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216572; c=relaxed/simple;
	bh=8WjKZo/Tzc+89ScV1HU0cXSdTevhkck7mFPn4y7/ZAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLAyWgcZkGDay0I/MlR7/xCh2tGw5NSzt1yK+KD6/Mm61Zyw+JFFQmUEUw4pEMEUD6J1bIMaSiNYN4afWDjvgykgaMQHEYT2ZHuXB28F6ZG2nhCiVyXYKy4aY9OiwRMMElDSn1Y3aH3acBcefiyvuk3vKin2VHST8mZaUOGsdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiwOj5mx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752216569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxbG4JFSAtZVQEjQXI+wWXnxQA/cXn+OA4Z+OMpKyu4=;
	b=CiwOj5mxnoK/1S9tjeDCBOKbOulBzeC1rHovr+dsPTvtKK3e0up9Fzf7od7mwYuWurkF60
	hmnnX4Oua8xAQbZvdD4LZSiAFlA3CvTzmelzdriYqLNb9a8qMPSJlQg4L7fjmSye7kXGWc
	blaQDYyaVxb7Dxkx0qYw4wvzjJuvkl0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-U1cNHl09PbOikbREUQmATA-1; Fri, 11 Jul 2025 02:49:27 -0400
X-MC-Unique: U1cNHl09PbOikbREUQmATA-1
X-Mimecast-MFC-AGG-ID: U1cNHl09PbOikbREUQmATA_1752216566
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-532d32147ffso607106e0c.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 23:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752216566; x=1752821366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxbG4JFSAtZVQEjQXI+wWXnxQA/cXn+OA4Z+OMpKyu4=;
        b=ssa+HsuMGNIOmF/4Y88RsdCeSuHC46P6xi0KtNnz7iEqhJl7err74gokKg+khENjkS
         2VZH1oHSzucwENtC5rN26s+sH/ihVXdIPGfiH+uQZuNR9gaygXlreZEE0dKQXtwntu3a
         KmOpNxtA3U1H5mnhRb4m3rPHTmXjUfARA3FeP1yO77dfMI3hWr/HQNWkldt+n6JwQtnV
         GFU2WJ66CbP99DiV8D5WyPYADhhG46eLMqRghZ0c1/67xSmpjMtw3GnExLP99shtbvG8
         kTnYqVxo/n6ISLkweWFEEhfTgx+4e7yqmxpwoHlfgwuWsuZL+eLch0eXNI74+q569daA
         tZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCWjwAebbkPZxSMfptDLhUDEcUNBFrnUNrO6CurqkigLhH5pVvjjiPvIudQBmrVoah/GWGZA4/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tn3utPJmp+AoFJ1H4H0V0u4PCT7llxil+ZalPDE/L9TneMSn
	0faAiPCm05RnmhS+LdyBXDJZdwZ1S96YRCYUv03ZCaMR7xjo0lUukzXGII2P35K8vS0GP7hJmuf
	tWW9ljkqKlA9s9jBtPqUmHBMLH/bHk31GHWYVNSUpyjCUC9/OMkTHXvZoxkSfBH6ARTltXK441Y
	xNU7ZztJJoMgWsdyDvfr4ax2Sw8K30aAPIkPiAEDqN
X-Gm-Gg: ASbGncs+i9XTsFQ1JPQponYGhAZ7gBEIJXwON8zYXFRo/e2rY/frjC5HSgR4Wwp+jhq
	OEEgAof2vXuFRKY1oll6zQwB5ufuivo+ra7FZ2JTagfTEbuVHrNSDuzTrsnwTd1cZh+0LCjNheU
	OmzUY15sJ78XWr3U6yFQYh8g==
X-Received: by 2002:a05:6102:dca:b0:4e9:c773:dca1 with SMTP id ada2fe7eead31-4f6411e36c2mr1621593137.11.1752216566340;
        Thu, 10 Jul 2025 23:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8pdr64dQhCGFiGndp3QqJ4OXoQVOVXjcmO3HV7h3AAPJDmNsRuoLhWIcxZByOZsvaufxvkGWZod21F8kL+T8=
X-Received: by 2002:a05:6102:dca:b0:4e9:c773:dca1 with SMTP id
 ada2fe7eead31-4f6411e36c2mr1621586137.11.1752216565960; Thu, 10 Jul 2025
 23:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com> <20250616062922.682558-2-lulu@redhat.com>
 <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com> <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
In-Reply-To: <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 11 Jul 2025 14:48:12 +0800
X-Gm-Features: Ac12FXxIsX9kCA8tu7rmOHAy5cYEuocqulMU9XdacIEoFSZMPVCORVJXY4Z54Eo
Message-ID: <CACLfguWqF62MMY3Y45GCRnh=5J75q6ebAqhFgOmhsAAsoyYXew@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Jason Wang <jasowang@redhat.com>
Cc: nicolas.dichtel@6wind.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 18, 2025 at 8:06=E2=80=AFPM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
> >
> > Le 16/06/2025 =C3=A0 08:28, Cindy Lu a =C3=A9crit :
> > > This patch reintroduces kthread mode for vhost workers and provides
> > > configuration to select between kthread and task worker.
> > >
> > > - Add 'fork_owner' parameter to vhost_dev to let users select kthread
> > >   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> > >
> > > - Reintroduce kthread mode support:
> > >   * Bring back the original vhost_worker() implementation,
> > >     and renamed to vhost_run_work_kthread_list().
> > >   * Add cgroup support for the kthread
> > >   * Introduce struct vhost_worker_ops:
> > >     - Encapsulates create / stop / wake=E2=80=91up callbacks.
> > >     - vhost_worker_create() selects the proper ops according to
> > >       inherit_owner.
> > >
> > > - Userspace configuration interface:
> > >   * New IOCTLs:
> > >       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
> > >         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTH=
READ)
> > >       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
> > >   * Expose module parameter 'fork_from_owner_default' to allow system
> > >     administrators to configure the default mode for vhost workers
> > >   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls wh=
ether
> > >     these IOCTLs and the parameter are available (for distros that ma=
y
> > >     want to disable them)
> > >
> > > - The VHOST_NEW_WORKER functionality requires fork_owner to be set
> > >   to true, with validation added to ensure proper configuration
> > >
> > > This partially reverts or improves upon:
> > >   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > >   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xar=
ray")
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/Kconfig      |  17 +++
> > >  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++-=
--
> > >  drivers/vhost/vhost.h      |  22 ++++
> > >  include/uapi/linux/vhost.h |  29 +++++
> > >  4 files changed, 294 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index 020d4fbb947c..1b3602b1f8e2 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >
> > >         If unsure, say "N".
> > >
> > > +config VHOST_ENABLE_FORK_OWNER_CONTROL
> > > +     bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> > > +     default n
> > Why disabling this option by default?
>
> I think we should enable this by default.
>
> Thanks
>
Thanks jason,  I will send  a new version
Thanks
cindy
> >
> > Regards,
> > Nicolas
> >
>


