Return-Path: <netdev+bounces-171120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EEAA4BA1F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E79818830E3
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF411EFF9A;
	Mon,  3 Mar 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9I1LfwX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E441EEA57
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992319; cv=none; b=qLCZtdFBe8HMN7vUR+e/vNtKFwobRGDqpC4bvB26Paxo/HkDeWNrHMeXbvU64DIh3xHqgqKdPlD6xVvfQ/FQ42MVBK1jAV7LcpST062hhHCt5RJma2BATmDcPlVoZl20HymleZW5Fl9lcWE3U5Q8qQLwl8aQWGM1M311I3OVJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992319; c=relaxed/simple;
	bh=trItDQ5V/mkIx/cKE4ZUDuGgE8kApBhRlmDdGwNOul0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeGJnoFsjtZKB2GGy4D1OMFMhBo9ZnrDeEMldDQKoeAXzCOyTIfAe9YNp50Ax1ESYFBFSIp30GHK9il8puk0ST7KWamv5ZtrcgpeP965+LQhEPUaqf6ozCaIWSqyzbXjs8RvVI+oBEYbQ8BKlOjjgYt8bTzB+d2iWiYuivCNeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9I1LfwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740992316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5mIvbymr+I4BfYQ2lCWwQkjM6pyai+CS0CDOiZ31Js=;
	b=O9I1LfwXanhjZzGRmtbXW4BDWbsNgMnnI9HkCdaXBlH2qFuPWK6l3eXLw7Q51ul+F5PS8a
	KihA2tUPOmAXvOqX4wpCpzt4JnUHzFPGpHC17vaxuWTPlCtOf2rMnsm6WZt5Pw72FxrgYt
	pFkBzoAvIXvhcY9329gwNwtLGeZdKl4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102--TlWWRvQMd2lVSGpJtUsPA-1; Mon, 03 Mar 2025 03:58:35 -0500
X-MC-Unique: -TlWWRvQMd2lVSGpJtUsPA-1
X-Mimecast-MFC-AGG-ID: -TlWWRvQMd2lVSGpJtUsPA_1740992314
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e4cf414a6fso3360971a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 00:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992314; x=1741597114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5mIvbymr+I4BfYQ2lCWwQkjM6pyai+CS0CDOiZ31Js=;
        b=uGvtg2N3oAhAWjDkxvqpgwj4QhEGD9a71i5Yjmnn7j/4VMMQXfbui/H4/P1ayhgwF3
         fzTN9jKv41NlTNHlt46QvZ2Fj7Sc7GXt7r9zN2duRQfbpdGWuifUZrFwD33lqKxJGsHb
         zqdQoXfxoQjde9AeSrbazTAGPqxRQsiqXZ/AOVtgm341sYrIO1NEPZ8DMjmX2bvcdbBW
         UZt1J+Aec2k8SWJMt0e7UqxZUFf8/7vZn7AesgiYhe+fEfFcRbr93BS2aBrGpLbmzeaH
         mVERX29kyZkssS7liZfmkvvfhKuaA2N/9buG/xFeS+jYivCBhGWXPlCRX5h4iHYWVal+
         1y7g==
X-Forwarded-Encrypted: i=1; AJvYcCXIZk4HW3CFF19IIeTyPkuOgY/vBsf5FDyBpK92CsXi6yyXOE/k6IGIBy4XXU9XJ1JuCDefu9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hePQZk/xBMvDaO+SbUbxRyI3DiqPOUJ+1xKbaFBnVfFJnq8n
	/SiHm//9uTumQkmnaOQFYlQ/ZNb654DCh/PGXmH7EjMhEzHKobgkFWJJRU3GdeOzHUcpGu2Z3IX
	UTzjRvuAlnSBbGpgEXLjTZ4J9V9V5FUn9AhRYPCTUKX2ahtUs1hXkO9jBczVZAg==
X-Gm-Gg: ASbGnctGLT9Sm+oLnxrPYdwy7dbmIT34YiDsn8uf/oJ4IxtthFo1hVY/u0qkbLcV/5f
	pqlUJOKdMxYGLdn5uN7pK0Dcfj8GrxIQ6uD1jM/8hWAOY9rlfeEuEs5K2VtH5SNeJY8gCFfeNL3
	tOuzKh78UC4m1acVEd2iuxbatuqZsM44Y5PA4Su+ilVrMZahFzV6SMPjL311j97+hZTCSkdIbm8
	sJWOTArfhouG1oXd+AeCiETd6agkAqHTGmqBKwbt1KNKc1qpVxo6NRs+g4Y+5ikpHNCnLGKlKG6
	nRlD2frbTXkhPQKH89cMDKhMfLoKxEqIFeUs993QrLZ4Xs5o75vWIj4m+31k7QGK
X-Received: by 2002:a05:6402:13ca:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4d6ae3bd8mr12016401a12.11.1740992313687;
        Mon, 03 Mar 2025 00:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1UBws0o6Q6N8Or0I9EH2txIiXNDRTiXCawz1Rn521pIsbUD0YYXL9ZstVZ1QxNwfhidyhMw==
X-Received: by 2002:a05:6402:13ca:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4d6ae3bd8mr12016357a12.11.1740992313071;
        Mon, 03 Mar 2025 00:58:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51e1sm6716034a12.61.2025.03.03.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:58:31 -0800 (PST)
Date: Mon, 3 Mar 2025 09:58:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 6/8] vhost: uapi to control task mode (owner vs
 kthread)
Message-ID: <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-7-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250302143259.1221569-7-lulu@redhat.com>

On Sun, Mar 02, 2025 at 10:32:08PM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode
>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> include/uapi/linux/vhost.h | 15 +++++++++++++++
> 2 files changed, 35 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..ff930c2e5b78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		u8 inherit_owner;
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+		d->inherit_owner = (bool)inherit_owner;
>+		r = 0;
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..547b4fa4c3bd 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,19 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device

Should we mention that this IOCTL must be called before VHOST_SET_OWNER?

>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1(default value):
>+ *   - Vhost will create tasks similar to processes forked from the owner,
>+ *     inheriting all of the owner's attributes..
                                                   ^
nit: there 2 points here

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - Vhost will create tasks as kernel thread
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>


