Return-Path: <netdev+bounces-156251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E1A05B5E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C818889A6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DC1F9400;
	Wed,  8 Jan 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8UcXuT4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0A1F76D1
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338811; cv=none; b=oSqjrZMplBoGyvDH7qbxl/xJKaMWJc7kt9n91vMwp7cEvRhPXR9kIIgvqdx5R3yyUlJtnS+lrCVP8V9IehOUBz+ayfEiq+xOsJf1llsuQ2UF94sNV4ynm9O4d4YKtO/+WuYLN/9CU5rL1aQbchpi8LaX/WCWK74ChCxNhI2d2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338811; c=relaxed/simple;
	bh=HAHSQYiW7j7jDWWaKzSiXVvSlJqTsmQpmrOEno+dRl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z23rIKiMv5qNtuxWilmfZJ4HK4EMQXqapzzdpFE4ialIwqt45ibzXUANg/rNu2CUn8rtwNuyTC0GiAgfNRcK42Hr+eQMDfkcTMPXrlchwx/+FO7h4YH8YZTihcmnYGgcamkDihRY5r8my8gUz/rgtFoIr/6of+VGbD+8D0wh4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8UcXuT4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvkScmKSiojMKy4UOE2DrwK0+YmOWXUTXTU3FB5pL+0=;
	b=f8UcXuT48tB/oq8XE05SQ8tLOA1daaGIyoQufuCjyRSssQjSCNvluGIt2VFFVHathaKXNc
	ouEbau4QbajQcLrSPw1KbdOw3S7M3pvT7xLjhR3YRvN1La1O4GDuHaHmv52/FJMafiio6a
	Wf0yCfFKK+XewYYC7uy1GkIM2XCdEtw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-_8lG6930OJ-9BxpwrsivVA-1; Wed, 08 Jan 2025 07:20:06 -0500
X-MC-Unique: _8lG6930OJ-9BxpwrsivVA-1
X-Mimecast-MFC-AGG-ID: _8lG6930OJ-9BxpwrsivVA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6a7bea04cso745832366b.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338805; x=1736943605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvkScmKSiojMKy4UOE2DrwK0+YmOWXUTXTU3FB5pL+0=;
        b=HVOtWEhPqEotPwNgM9q36xfZNFvx200lfX9YhWKb7yS6elk8bTJFO9Ex0vUSTer53v
         2EcGmgC1BuVu/0m/Gri6f7x4aEnA2JXWr+2cfUn3Ougppg/reOXvEGRgBiW8UACOmgTu
         mb3H3KZae64PS/zuXR17SmBixttiEeeLNwnQ6H60SeZR8K0iMvVR7dGsoXKAp35KH5uE
         LHc+qpwR3iTiFAVpeetCRf+n22vFCQ10Uv8w6zLlvHzslZ0OuAgIvpozq3wo8EiWSaVi
         SAu5ssjsZFZn7YKbvt34ZOgvTciyDz5jO9lZ+pDl0APHqbs0+4x+sAfeJQCBWLulRMiB
         Vc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgklK1wM3LcXgR5euQ9L8M4M/+Ppj4HcJADlPeJ+IMK1EeG1XyMvyyTIc/OouhU1T0BjuSaoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2gsFJOcI0Q9aHJ54rIT1mOtDrOKiWe99s7CkKSdAadHZkGtp
	TIic8QP/mVWZOng5NlXQ95A1+kOir8jFz6qCaHM4WaviouglnxXqTL9/Xrw8kXxVcNabwc0SwaD
	N6IG2hQbaY8HqqgbCg5CnynNTcxav9b88sPhAKmYlWPRzbA+eQ3c2MQ==
X-Gm-Gg: ASbGnctBdEyGpQtd2on4gj3Ht2Yu3z6INOJ3YCt5rl39V79VyPehJZa52EiB74CtJ47
	COuJEzU9lXeIvKK78pQNfDtpWul6LtaIIXwP+j1SA6zS43OSXlXr4JoZXx4Y6oe4zJiUSZFz+1r
	RrOEZzH9B1S8Ilry7kyl2Kak5HKc655qZqJmLoOcS+ISk/XFZAWXJFd5TSDKgRmgfpeyMVMjOYl
	T37GaDgw5IRqQGYDtEAUq9ZepKN45p01GtYeAc1pjS32zzkVQk=
X-Received: by 2002:a17:906:6a1e:b0:aae:bac6:6659 with SMTP id a640c23a62f3a-ab2ab675c7bmr195885866b.7.1736338805309;
        Wed, 08 Jan 2025 04:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJnfpyyzkpOex2toXbOpvS659Qc95KZbvn2dCmymN19iFdvMLZcxesMMp7PrcMbRk8ElqcfQ==
X-Received: by 2002:a17:906:6a1e:b0:aae:bac6:6659 with SMTP id a640c23a62f3a-ab2ab675c7bmr195881866b.7.1736338804843;
        Wed, 08 Jan 2025 04:20:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f31bsm2471713066b.1.2025.01.08.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:20:04 -0800 (PST)
Date: Wed, 8 Jan 2025 07:20:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250108071933-mutt-send-email-mst@kernel.org>
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-6-lulu@redhat.com>
 <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>

On Thu, Jan 02, 2025 at 11:36:58AM +0800, Jason Wang wrote:
> On Mon, Dec 30, 2024 at 8:45 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a new UAPI to enable setting the vhost device to task mode.
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> >  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index ff17c42e2d1a..47c1329360ac 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  {
> >         struct eventfd_ctx *ctx;
> >         u64 p;
> > -       long r;
> > +       long r = 0;
> >         int i, fd;
> > +       u8 inherit_owner;
> >
> >         /* If you are not the owner, you can become one */
> >         if (ioctl == VHOST_SET_OWNER) {
> >                 r = vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +       if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
> > +               /*inherit_owner can only be modified before owner is set*/
> > +               if (vhost_dev_has_owner(d)) {
> > +                       r = -EBUSY;
> > +                       goto done;
> > +               }
> > +               if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > +                       r = -EFAULT;
> > +                       goto done;
> > +               }
> 
> Not a native speaker but I wonder if "VHOST_FORK_FROM_OWNER" is better or not.
> 
> > +               /* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> > +               if (inherit_owner > 1) {
> > +                       r = -EINVAL;
> > +                       goto done;
> > +               }
> > +
> > +               d->inherit_owner = (bool)inherit_owner;
> 
> So this allows userspace to reset the owner and toggle the value. This
> seems to be fine, but I wonder if we need to some cleanup in
> vhost_dev_reset_owner() or not. Let's explain this somewhere (probably
> in the commit log).
> 
> >
> > +               goto done;
> > +       }
> >         /* You must be the owner to do anything else */
> >         r = vhost_dev_check_owner(d);
> >         if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..f5fcf0b25736 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,23 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                               struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> > + *
> > + * When inherit_owner is set to 1 (default behavior):
> > + *   - The VHOST worker threads inherit their values/checks from
> > + *     the thread that owns the VHOST device. The vhost threads will
> > + *     be counted in the nproc rlimits.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> > + *     implementation, which may be preferred by older userspace applications that
> > + *     do not utilize the newer vhost_task concept.
> > + */
> > +
> > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
> 
> Thanks


At this point, make these changes with patches on top pls.


