Return-Path: <netdev+bounces-171355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EBA4C9FF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921867A5597
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF89214A80;
	Mon,  3 Mar 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAGSqzCe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FDF14A62B
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023200; cv=none; b=c9IFJdGVuhu9Uq049UhSskXU4Osj7iUo+WqPFOscyGTdPog7lO7N24xtFZ7gpXCDtj+49k46pmjL+az4EuaSadSN+otHoXF1hChi4uapVjdl0ktJhc3iaOn9mbcypRAzaYE3ATy43IYHNy1ReEEAawdBjmKRUvfQHrVyxdhzCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023200; c=relaxed/simple;
	bh=Kqke1zXRTdE0PHPb+71qhUA9lMSBTCX8sSQVT4I2Ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZquX6QibqUyAJILstoOVsZ5V7ebSk/TD0mAy7b690iR92qKaaj+BGpAHr+UaaKgaP3pzkmnfBV7BWO1Y3H9ahpDleiGWoxK7VVTqvb1AbLU+7RRqazAY9gN7v4aRR/SN3JlF4TFocAdwb78Xr8fqMMM3EYXTHTJKwbm+UI91Ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAGSqzCe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741023197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riX1iNIQhseaZsPbJjiHdH5ZxszgBUyrqDQWObE9EXo=;
	b=QAGSqzCe1ir92rMZd2fBt+C+zuirk+G/6LRPAP2UvnQ6I8RASUkiomPI/0AzBqj2ZM5n4u
	Q9SCaF8wrIE046n3cDDkwLIdno16iOHj7i4sJc9Ipr0lXYEEZhd80wBYlLzMx3WxavthHF
	7FXi4X9TJgq4Q8rGhW0lp21BaopEIVA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-G5ZLXwZsOoqauOx7ObDSjg-1; Mon, 03 Mar 2025 12:33:16 -0500
X-MC-Unique: G5ZLXwZsOoqauOx7ObDSjg-1
X-Mimecast-MFC-AGG-ID: G5ZLXwZsOoqauOx7ObDSjg_1741023195
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390e62ef5f6so1706620f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 09:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023195; x=1741627995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riX1iNIQhseaZsPbJjiHdH5ZxszgBUyrqDQWObE9EXo=;
        b=OspgF4fIFbWv2J66mlzqKIIc1hgJR2So4yYPPKHHL+olfNFektkbsgUcvrpqpin9fo
         mrMjd136fpgikYGCUjNGRr2UneQuIK9QilJMXVFjvjbd+nHXR2X/8suhQ9uk2U1v8/1x
         xtzljltH5cfOKvGLCw/7rjZqC9e1cPrY65obeHYErpDf/yerRBVnYMINXO00AO3V9qyh
         4naSylSgw9Q18IpLLIoCc4JkJkSgDN3mOj0wUyoe1tICz2sUSoN5SAkBTQiAa3ymJrih
         QampzQc/27pPDdWI+TIMw9qh5gl/9/uI2f1IVLFc0rEEjnJRCIDlNkj9KA1Byhm/KX0Y
         cX+A==
X-Forwarded-Encrypted: i=1; AJvYcCXz28CY+uwkoPTS3qPVWxheoaTuYkk3Jvzo8zirmwPE7wls/35Nyw4KGG0NQUwidc49AOJIOk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//0EtLKvlLuxtKNgKaF+Rff0IfV1w45Hl3ZAPlRvotBiQjI0Q
	QNhkBIr2aNxkAFTWjB0AxHefpcH3EsKRrOifbA3Zin6VMm/BqHt84PM1Ce0dvdgR82h/Fvu92Gu
	yjsMmW9h3oh9Xc89bdxzaRRAb2pRupCD1flNP7OoGPPn2bw80Uko/KQ==
X-Gm-Gg: ASbGncvOFT3Kpu8jSGDMUOK2Ihvcwogfw4jWe+daQoIqicEpncENla2Nki1JGmMYkZj
	fyE5HxbbPieHxHW9WMGgtT6ZaBmTMeWFeJUnbYsVOSOip67vPP783KY7QUDsBHJNsTurBpTPsu9
	M56SNRLHoYN+0cT7OlxN6y48IUQwBF2SSnQt88vHgGN0BU2JYeg0fQ2chxrA7pND6FjuU8xYWN3
	IQRKOCFGttjfLuUci8lwrK8mOLxQqKFtu8wluV8Pa3uBBEjsoyWzArLrpc9n9NvN6PU6wf6oItG
	sT8trAc5Hg==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-390ec7c8eb6mr11963053f8f.5.1741023195330;
        Mon, 03 Mar 2025 09:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0GmDlZsbzQlj1pj5FfLVE18PQfmrSwJDhwqCdM5eQRgnv/LJj6Wq+AmT8QxKX5JIr/1sNZA==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-390ec7c8eb6mr11963001f8f.5.1741023194570;
        Mon, 03 Mar 2025 09:33:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1514:ea00:6409:9e94:fe6f:3eb6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm15218056f8f.91.2025.03.03.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:33:14 -0800 (PST)
Date: Mon, 3 Mar 2025 12:33:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250303122619-mutt-send-email-mst@kernel.org>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> On Sun, Mar 2, 2025 at 10:34 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >           If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +       default n
> > +       help
> > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
> > +         userspace applications to modify the thread mode for vhost devices.
> > +
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> > +          meaning the ioctl is disabled and any operation using this ioctl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
> > +
> > +         If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..09e5e44dc516 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >         if (ioctl == VHOST_FORK_FROM_OWNER) {
> >                 u8 inherit_owner;
> >                 /*inherit_owner can only be modified before owner is set*/
> > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = 0;
> >                 goto done;
> >         }
> > +
> > +#else
> > +       if (ioctl == VHOST_FORK_FROM_OWNER) {
> > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
> > +               r = -ENOTTY;
> > +               goto done;
> > +       }

why do we need this? won't it fail as any other unsupported ioctl?

> > +#endif
> > +
> >         /* You must be the owner to do anything else */
> >         r = vhost_dev_check_owner(d);
> >         if (r)
> > --
> > 2.45.0
> 
> Do we need to change the default value of the inhert_owner? For example:
> 
> #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> inherit_owner = false;
> #else
> inherit_onwer = true;
> #endif
> 
> ?

I feel it is best to keep the default consistent.
All the kconfig should do, is block the ioctl.


> Other patches look good to me.
> 
> Thanks
> 
> >


