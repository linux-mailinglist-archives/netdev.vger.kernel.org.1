Return-Path: <netdev+bounces-195172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FECACEAF1
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E7177C5E
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05080202C43;
	Thu,  5 Jun 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBV40mkL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9811E6DC5
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108939; cv=none; b=JJCXWKlibwiEvjlbLLRc35IjWrcm4E8QtkL+hDlAYBRA79feyYtFWrRB0Y57BfY4eGui5QqWniHzheEODLgLgviV//St5sJDwIEAMioC//Vazmt7Ua+/VT6sfCHAQF3SJcb7h7rDl39CK0WuIHcg71Ce5yqHF9KwOQspMkC6fzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108939; c=relaxed/simple;
	bh=xaaO/f1X4wFcpMshO0kr/Uc/I2hIRKwMQVno0JEnam8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8TcbSuMg0103+n9q9cJR1EZWIUz+PsyYAviJXdZVbQID2c+l0r/CpFVxPQE/Q/WBzS0tsZ8/8Z0hovn3Yib3K6m8tqb1aTRxXVyhy9MrKMbYwWNFqUTq/BiDe/lH9/J/PruwyMzR8jnoshHsrK9+tcSH6z+igVXVMkEGUhXARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBV40mkL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749108935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haNatmsr8a/iGKFdObS4u9jtqcJpXsWFI5vt5mC8hSI=;
	b=hBV40mkLLRRxQVVs0667BbT+SypP0s5a0pJj7AMkGUgRT4F5TQQJ5mP3j3w2pO96MWCPEQ
	YJ+2/C3dcvMmI/s60ZZYWSxZdNQb9HOhr7MIujAPXUaCHKKYjeAjoPxlYecGuGn7lTucTU
	ejJ6XX0kfgL6S2NmJCroQDGWufj9aDg=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-LFp41FTsP22TP-tLp1tKEA-1; Thu, 05 Jun 2025 03:35:34 -0400
X-MC-Unique: LFp41FTsP22TP-tLp1tKEA-1
X-Mimecast-MFC-AGG-ID: LFp41FTsP22TP-tLp1tKEA_1749108934
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-52480d42c8eso579389e0c.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749108934; x=1749713734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haNatmsr8a/iGKFdObS4u9jtqcJpXsWFI5vt5mC8hSI=;
        b=T7MIY98Ge+C5nKVtklSTfsuOE1f1Ftrvq8CY6/dwcauJ9pFmzLU9p7PB9ewmuuYevR
         Ubobkb+N3ud3ROaU5RjoVlQojJuZshBD8yGrxjtktgbaN7R3ZuvZX7gKvx4n4su1Pyw9
         uSgPoYv6XqsABWmNjhgcCO+zRNcDKQ9SEsaUql8eL/uRewm4jxxj0/VF7zUeno79Vt28
         bLlpCKtGCNKOisIutz9M8UWepYudLyvBdPlKsRsyuk3imDhn+E4v9kF/dyRtAWNm+WVL
         Ir5odol/Y8qoVa24xZDpoHydffCRIp2irl9Hdxjp3vhPu3RdQW69dqqcQTfdZ+EGhu0o
         EEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyHJavqmIBfqbxlzDqsO79rtnfzMPToVls0IH2cjRF/G2nlWWo0K3EzxuI2DHnUe0WwGKj5lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1Jx21UgUBm4jtgNo1Oy92CYluJ0fW7/4p6JUNyHvXezuIWIk
	l0RrH/OaF7eXOnGKWXJ+xQe5wQ4Nglt8JGnDM7mMSNTzWSUh5Nhzh7kY8ZrLSrfDEy9p1yXhcD/
	J+nztXmIFHvk5D1vXHnizOy2M1oDzQgbT3MF6JaMPXjO2x93c5w2s+9+3dcleee/RHYAmJv29Oy
	hUTRkVJ86RKHQcHCzoWA51wm9b95qxRAw/
X-Gm-Gg: ASbGncuveRx4RJPq3oCZnLZBHqSSPzXbZmmn81Z+/z42A/x0ZqkXI1QqneUFlX0JATb
	Qsj0Y2EUM8/D8ZmkNaA738vFs2JRviH2/YIWGX6jtFbcZ4xMMpFqunSD6/6vj+5x1YL04Bw==
X-Received: by 2002:a05:6102:510e:b0:4c1:7be4:eb61 with SMTP id ada2fe7eead31-4e746f837a4mr4499065137.25.1749108933941;
        Thu, 05 Jun 2025 00:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhfWXYxHfh7ndgHlr5SsuCZIS9uSBe8eCGWSE8HDvdi0nEFlAlR7YsAwWZnsQ6fylQBk9U9xd09BIVxvKtPz0=
X-Received: by 2002:a05:6102:510e:b0:4c1:7be4:eb61 with SMTP id
 ada2fe7eead31-4e746f837a4mr4499051137.25.1749108933605; Thu, 05 Jun 2025
 00:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com> <20250531095800.160043-2-lulu@redhat.com>
 <20250601064917-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250601064917-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 5 Jun 2025 15:34:56 +0800
X-Gm-Features: AX0GCFu35JguejX9e3-1qt6CZ0h8hz4k2SNC3u5-OLCeEHlCWSfhHe4JVwP6JO0
Message-ID: <CACLfguX8vAMTz=vmnZtnqWSAawNps8UOboZ1DvZ-it6Gf8+4jQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 6:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> > The vhost now uses vhost_task and workers as a child of the owner threa=
d.
> > While this aligns with containerization principles, it confuses some
> > legacy userspace applications, therefore, we are reintroducing kthread
> > API support.
> >
> > Add a new module parameter to allow userspace to select behavior
> > between using kthread and task.
> >
> > By default, this parameter is set to true (task mode). This means the
> > default behavior remains unchanged by this patch.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> So modparam is here but does nothing.
> This should be the last patch in the series, or squashed with 3/3.
>
> why is this inherit_owner but ioctl is fork_owner? is there
> a difference? If not
> can't the name be consistent with the ioctl?  vhost_fork_owner?
>
>
sure, will fix this
Thanks
cindy
> > ---
> >  drivers/vhost/vhost.c |  5 +++++
> >  drivers/vhost/vhost.h | 10 ++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 3a5ebb973dba..240ba78b1e3f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -41,6 +41,10 @@ static int max_iotlb_entries =3D 2048;
> >  module_param(max_iotlb_entries, int, 0444);
> >  MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> > +bool inherit_owner_default =3D true;
> > +module_param(inherit_owner_default, bool, 0444);
> > +MODULE_PARM_DESC(inherit_owner_default,
> > +              "Set task mode as the default(default: Y)");
> >
> >  enum {
> >       VHOST_MEMORY_F_LOG =3D 0x1,
> > @@ -552,6 +556,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> >       dev->byte_weight =3D byte_weight;
> >       dev->use_worker =3D use_worker;
> >       dev->msg_handler =3D msg_handler;
> > +     dev->inherit_owner =3D inherit_owner_default;
> >       init_waitqueue_head(&dev->wait);
> >       INIT_LIST_HEAD(&dev->read_list);
> >       INIT_LIST_HEAD(&dev->pending_list);
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index bb75a292d50c..c1ff4a92b925 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -176,6 +176,16 @@ struct vhost_dev {
> >       int byte_weight;
> >       struct xarray worker_xa;
> >       bool use_worker;
> > +     /*
> > +      * If inherit_owner is true we use vhost_tasks to create
> > +      * the worker so all settings/limits like cgroups, NPROC,
> > +      * scheduler, etc are inherited from the owner. If false,
> > +      * we use kthreads and only attach to the same cgroups
> > +      * as the owner for compat with older kernels.
> > +      * here we use true as default value.
> > +      * The default value is set by modparam inherit_owner_default
> > +      */
> > +     bool inherit_owner;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> >  };
> > --
> > 2.45.0
>


