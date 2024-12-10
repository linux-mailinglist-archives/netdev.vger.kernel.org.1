Return-Path: <netdev+bounces-150789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F59EB8CD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B7C188069E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE331B1422;
	Tue, 10 Dec 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp5u/+t3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114086336
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853303; cv=none; b=m0BfDBibfvYVhMj9MyFAxYDEucbBdnKsVtW5+wNDzp1o5XVnx8jpXYBN+NCEgJsJvmGSgi4SN53DfQHiXAQ3d4hoOaB3e3Ys6EGlz9euSQu5Pou/y0qzIPbPH4tGafGNC4oTT5qYzdIxRkuEVCUkuEsyTCQxMKpOZ5/qrIQ3KkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853303; c=relaxed/simple;
	bh=+JHWoW0txAbFn2WTq8OWQ00Ywq+bWkSXKgMZtrj20gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg52g8BvQFNzAYqHck+PaFXxoY4BjCCI+hcbmANuFE7Dxr2StW78A2IMlOMMFzkZzWl8Oi3XFmLM9fFPqrs0rF2SQWe0CQkun7YCTDsThemqP2KUPp6wx64splk8g/ww4E6exnGLUMyMJE/6e55UUqa7+2fwyxF08sY4CyAgAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp5u/+t3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zcHZag8gdmNWhHO5Ak8t21hEZGlUPrLrpjy85AhZ5ZQ=;
	b=bp5u/+t3m4TS0j1njsl9h4k9jz2iZL435+o90B2lQNDCCXIHvsWUjC6xTR6tKluljDCHuP
	SFVTbTdVAGGWqK8UYC8RWSTJ9lPdPP3UfVzVGNNhuFxf24N6oxnsJXOJkbNaflshqhfls5
	aNkwP/opz6eDatGJEzosPkMQHPxp2XY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-H5tCP1CTMHuIbFkYMJC8hw-1; Tue, 10 Dec 2024 12:54:59 -0500
X-MC-Unique: H5tCP1CTMHuIbFkYMJC8hw-1
X-Mimecast-MFC-AGG-ID: H5tCP1CTMHuIbFkYMJC8hw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f0d1484bso18653825e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853298; x=1734458098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcHZag8gdmNWhHO5Ak8t21hEZGlUPrLrpjy85AhZ5ZQ=;
        b=fCndO2Dbw+lfhg7V6dcINKq2VO4Pd82q16AGIQs1/cbXZD0+pQY9nu+v8d4ca12LGK
         YXPpIykI3+lNh55td+TrRgRLqeVFuX/32XnlnQYsoFRUkJBY5ify50TX4iKdjtH2V2E4
         FC9xc/UO4sSToFT4OI47ldkn1i6bBIAWiBnr736F7VCq6tcuAWkoluEV81oQ0eOX4Wxs
         Ll86EzKqBemwfJdHAzZ2qJOGsCEIrREHeqc59VGx+QzeZi7nRKtaRfLrSzRXkuKHkPpa
         X2C9dEP4iPt/8pYGVeSpUBkUxrIefdU7RoH2zqyLIGSJ0hpXgp7W8clKRLYCxB7Mx5jN
         mUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt7BnViswbDpZBwjDcU8pj8RvcRvZIkyPRHetHagFwYbk6jJERADizmeBqz8tJepMM3iqQxzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRP8SpacbO6UvUHJBWNGAPhS94vb+zYjYYVkbpqGfzV9VbhAC
	io5B1h8Qe8x6sZLzUlqIyLMSLFVsArgnjG4TCIGZ4+Lc1MMs2E3SmhMjsOZKT54Fcz8TsoyYTdq
	xqNkOFA68WQmxP1oBJZWwp6M656cw1xf4jpp5TlCngYZwr7Wq2PE1gw==
X-Gm-Gg: ASbGnctoVM4b9ebKwAd6tdBeUCqutk26SjbCRdRt2oqivKz9gThZ3Bvv9ab22N4LDyM
	N+0jA1m9clll54jkQOF8pUmzuBw4OnpJVjGfirbsBvpZT2CMpBsHCrYLxVAOvaGHikjPHoDWrx4
	X/OvLcn/WecRGhWbdAaDEYbMVCmiKgbgpswzUi3t0/YJyYWc8NSfCjYRCu53nug1EwVvEoldDc9
	Hkv3LhMInuBiP1oReTnk6tuQEHAwM2yfo/jN/7EsHnlQ49duEWpT03+BrEfNbrIojLgdnw/yuJr
	FCjHU9QSNHCe4RPeGyCtnISv9pSKXg==
X-Received: by 2002:a05:600c:548d:b0:434:f8a0:9df0 with SMTP id 5b1f17b1804b1-434fff69f6bmr47410905e9.8.1733853298525;
        Tue, 10 Dec 2024 09:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5h5cFZjv86y3Dziyg3MBclOHJHLgdGo4xsXmVuUJMXKQPSyKhOGL2jS9vx881qRPPMi/Jfw==
X-Received: by 2002:a05:600c:548d:b0:434:f8a0:9df0 with SMTP id 5b1f17b1804b1-434fff69f6bmr47410635e9.8.1733853297872;
        Tue, 10 Dec 2024 09:54:57 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435c1833d67sm24102865e9.5.2024.12.10.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:54:57 -0800 (PST)
Date: Tue, 10 Dec 2024 18:54:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
Message-ID: <2on4eblmkzkhecpyiwtauel6hxw6upnlh6wunfxgxvfp45cej3@6z5lzdermzeg>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-8-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> 2 files changed, 39 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 3e9cb99da1b5..12c3bf3d1ed4 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;
> 	int i, fd;
>+	u8 inherit_owner;
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+
>+		d->inherit_owner = (bool)inherit_owner;
>
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..d7564d62b76d 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,22 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	
> \
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1:
>+ *   - The VHOST worker threads inherit its values/checks from
>+ *     the thread that owns the VHOST device, The vhost threads will
>+ *     be counted in the nproc rlimits.

We should mention that this is the default behaviour, so the user does 
not need to call VHOST_SET_INHERIT_FROM_OWNER if the default is okay.

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)

Do we really need a parameter? I mean could we just have an IOCTL to set 
the old behavior, since the new one is enabled by default?

Not a strong opinion on that, but just an idea to reduce confusion in 
the user. Anyway, if we want the parameter, maybe we can use int instead 
of u8, since we don't particularly care about the length.

Thanks,
Stefano

>+
> #endif
>-- 
>2.45.0
>


