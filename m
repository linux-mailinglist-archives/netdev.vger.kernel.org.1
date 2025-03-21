Return-Path: <netdev+bounces-176808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75AA6C36F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E2048245C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920423026F;
	Fri, 21 Mar 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7k8wTz6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35722FF41
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585981; cv=none; b=aw3JWXf2N2yUdGCxOireFIJiR6RQ4drJSfqk1MzHHzI8sqJSiweA1iH9ot2D6i8UON1IycMOEYwbx4UPlxFAhvFVG/8n4QiLNi4woJcAcctMghY9F1G8FPOEG8V3RY9qbhuEU3oF5NUBMeTMACTOiRhhqswRuBXIAGmOVcomxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585981; c=relaxed/simple;
	bh=8Yf2e58bOdkWki6r3N9zOG96lZWqklx3PpwjJDAqkTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLjPZrYCnqRxBD25osornfCYV6NXbFVFPh62sx64U4eb3mtT3WNq6wR05lI18pahkTbtYiPZbf/8n/getePrxq+38v33yPxn/nhH1pl2437ZdaLRkpsaF7vR4GVnT7RO0ECEWSf17vvZQgjlB123d3URg60ysIRLc4mr+n/YW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7k8wTz6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742585978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaOk1vPVeha7q1Or366XeLotZcOIEZyeZ7CHH+BWos8=;
	b=I7k8wTz6DGIoikL1ryfCskvC4maiyjO9lDzgiSdrgROqwe/KlM1l0KIxxN5byGEzyxFVoA
	TkgEOCYkxLBSqNyNZJej/bc6qvePi1PZgOom8dEWZrsQri98S1oI8Qyox9Y4+wRqK01G0s
	Lno6CAK6yGrdoHh2klfgAyLQlhBz254=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-cSnISwrINE6atYNyCDbpSQ-1; Fri, 21 Mar 2025 15:39:37 -0400
X-MC-Unique: cSnISwrINE6atYNyCDbpSQ-1
X-Mimecast-MFC-AGG-ID: cSnISwrINE6atYNyCDbpSQ_1742585976
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3011cfa31f6so3835358a91.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 12:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585976; x=1743190776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaOk1vPVeha7q1Or366XeLotZcOIEZyeZ7CHH+BWos8=;
        b=hNymY7oqMvryhcCBRmmaiHkE2+Jw6+4SkKn6CWbGA3L5OiAu1sJCKuOBmvDbBTluVS
         +QYEQDufqplaAQnrg/q+/TP+llixJfgcevaFaa4RfLzQgmsFPbLkeOSLgj9IzTIkkzSJ
         GdjrkvMDgeQZM/wa+zJDr26iDPlygcspN5tZ1JQ7oWsprBHrB7pgVpUGNkEdeKjUNqwm
         cb2x8WwIrZ9ZHDZqN3fM7/b52AmKL3FFOgjcDzB1YuogHeP0Sr5n1bQXoyZCbzCWC7t5
         uB6FAMpoo2P57BbY6shEZioNsqR/lMWLoyODoGwGlCfj3dILzvyIWxvEz1ERkit7fBI0
         01cA==
X-Forwarded-Encrypted: i=1; AJvYcCXvQeTqWr51HH1sI7rtar0uT0QeZ/orynkP18iZIgLUtJD3i8Qbl5th57A3lkTIMrV27Q8CA3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCj/U3TqEkQioaHijPOm/hUCkdf/fI41hLvitb2OGnGyrJJNXO
	3KNq3o9xhPxR9WzqX0OXyfCNpxzB4E/qw25Agm/NIVmFrZFlEwlDo9HNfRZhTpAEzSLqEGJ0pmt
	at1ICJ8PGadvrf55O06igkwyWYSKvSr3dbj3wnebzTOhkmP6TkDPluw==
X-Gm-Gg: ASbGncv007fmi184/wMuPW2BbaOwsXAq/vdBZ6Gisx3H0iHqP43WcXd1Ce4njlKLDQ9
	hMBbKPTWXEXHZ3TR32Z1GP4waaJ3YMYsnlWqp3XOOqyxiW6UJgjp9Yd4Xh5GtTnork1uwowDJgQ
	snL73aXDf2NRf5gIYjeW4GgO126nPKJPy7hbj0B2hGq7E30wg3ckozSSPrsO/vbmmk4unLThk5J
	dKJ/33iCFLkhBHNSXlB8AMWTdLmTkAgIhpacv7Xe+xWA1bSI3CzZmoxJm1ecbczHrp8SWFY/zCx
	kmKeFyMK
X-Received: by 2002:a05:6a20:3d84:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-1fe42f08eacmr7029290637.5.1742585976113;
        Fri, 21 Mar 2025 12:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ9PwVrNT0IX4mEc55T4ElrcZWZgBTxmg9r86dv6Ws9U7gh7qZgMQ627xJ7/9/+AXMPCDGyg==
X-Received: by 2002:a05:6a20:3d84:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-1fe42f08eacmr7029263637.5.1742585975610;
        Fri, 21 Mar 2025 12:39:35 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4792fsm2197397a12.71.2025.03.21.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:39:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:39:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250321153829-mutt-send-email-mst@kernel.org>
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
> 
> Other patches look good to me.
> 
> Thanks


I think I agree with Cindy. kconfig just tells us whether the
ioctl is allowed. should not affect the default, if we want
a kconfig for default, it should be separate, but I doubt it.

> >


