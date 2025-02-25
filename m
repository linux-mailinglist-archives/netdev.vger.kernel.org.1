Return-Path: <netdev+bounces-169435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78488A43DBC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B75A3A28CD
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D78267B89;
	Tue, 25 Feb 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFE85OD4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D83267B86
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483078; cv=none; b=H+B7/rgZwCoQOZMYfT48fprXElD2bYO5rQrdfQ6LJLOCsEOvofs5+odueDcO9b5Vyt/I2BLj9kHsheELs+jVV8EUeoxuWEQxtefVDS9D7PY/E+CfIsQiqlYIsF6QRDho5ptXGD8/Gy6bqRn8YKsjMjWrnugDLuQe3NoVxzoRlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483078; c=relaxed/simple;
	bh=JNsvBkbU/xeGUA2wB24yiaAwvMR0TShWcVfnwYO9psk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBnCEF8ZuVdKrbYm9wWzJpJ29pykUc8F/g0vi6lvxCT2yT6LA7+4F1wKXTjfTfzbAPdMLDdc4ZFmcMJN9T2T6XghTTrkewCTE8rzfb6pQ1YY9leKfBARJe10fWAPcr0i6j373i7Wf2/buNpPeWcN2ZLNwuUTxuy+kjt/mgBD4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFE85OD4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740483076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amu6qNJ2XLnE1PzLc9Jh3MOyLPKxqhaqigKuNJC2nTU=;
	b=AFE85OD4TlSetswMUy4QMYZ4vCa1kS3JHHGLXT7kMBNTYe8/chIwqm5rR0iNLKx5VWS0Qg
	hQivTLzSUfkt8ysUZnyHJk1x+GuN856UNQS0Yba2JXeBObHXwrE1KUdQtupNwVsm9BP6G9
	q6BLoPFUppee5O9C6XirzG0LZI8+gDg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-8BdoxuTEPciSPR2EVPP1nw-1; Tue, 25 Feb 2025 06:31:14 -0500
X-MC-Unique: 8BdoxuTEPciSPR2EVPP1nw-1
X-Mimecast-MFC-AGG-ID: 8BdoxuTEPciSPR2EVPP1nw_1740483073
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f255d44acso2382757f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483073; x=1741087873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amu6qNJ2XLnE1PzLc9Jh3MOyLPKxqhaqigKuNJC2nTU=;
        b=J1GWWPtU2mGPJC7h/qHvcHAA/NZ5TLjxmY7yK8euFbH1+dNf+GWPcBti6IzNdwf3jJ
         VyFCd6pGzGCYKklXjjFD/t1XjwcQLvbyiROgdGd6zH0X1FauJrZsPaT7xJaak4MoTOUa
         w/OOAZu4ytca091Ubwd5pVl7fdpOdWfU+HPX1gS+JVJgcQt8vSE7TmuKeQ14Lbg+rLKz
         7mUgT9szDzuR6+6EpJ0nNp2HO8oefO8CclKVrQ0Q7lUc8EL1eG09qka8jD2ZQehJtfWd
         6TzMckSfi2W9fhoF2DPGL/l5pJH48JueFFwUC+Ji0DgZ7Ch+xaRWf9DqAB04H+h+Q7MK
         HBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYj98enZzekvoCuOcHlQKC7jk5UakKb8aWOHAcTjXTvACzYJnB5vP4cFs+u+u9aNSNpgyvTk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybceCng3E76+Eu/OdUOzBsrWE5vl4Yjqv1b1/kdWsr2+rCWUDH
	4IaZje9cJGgamUDJAyRU5qu3D+upL7v+tiTJ92nT3x5/v6CQkZipJITGlhLliYWqoiiufqThvxv
	ebYKhr9OK815Z0JQxo377Zn03SK2S+iD1BD5kRSrZ0dJazZ6tXaqyQQ==
X-Gm-Gg: ASbGncvZVz+377PIHXf29rdzWDDECh/Dg66/zibW27h/uf5mexKxzAC34wugVdnXKdo
	AIzTDB7JVkNSnHhMcIa4KFK9oZmp0rAuYX/skNBSth4ftbv5/qrWCebkP0dXZOG4artqYYeEeLK
	f8QBrMRNxrazLtZLSR7y3DdJIASVq2dyZWxcbGBIeMX3odiQ7V5Chhxk0LAUr4elj20WGLNpygH
	P+YD6Z/4w1isJvy/YIoUSSUvs8lc+gz8O6PaDo/6wM/Ed8HFRKMkwK5j8uiz46tB9fdiDgVyJ0A
	XVYxYTVA2/lvg6o=
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id ffacd0b85a97d-38f6e74f270mr14234553f8f.9.1740483073117;
        Tue, 25 Feb 2025 03:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtz5zkAxf+n06y+uM0vFkhN66Z0eIXxRWu45tZA+nsHTF3VLjPSb93B6lqTibRPrNYImW8BA==
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id ffacd0b85a97d-38f6e74f270mr14234497f8f.9.1740483072522;
        Tue, 25 Feb 2025 03:31:12 -0800 (PST)
Received: from sgarzare-redhat ([5.77.102.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883934sm1996643f8f.59.2025.02.25.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:31:12 -0800 (PST)
Date: Tue, 25 Feb 2025 12:31:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>

On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> 2 files changed, 40 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index d8c0ea118bb1..45d8f5c5bca9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
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
>index b95dd84eef2d..8f558b433536 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,22 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1:
>+ *   - The VHOST worker threads inherit its values/checks from
>+ *     the thread that owns the VHOST device, The vhost threads will
>+ *     be counted in the nproc rlimits.
>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)

I don't think we really care of the size of the parameter, so can we 
just use `bool` or `unsigned int` or `int` for this IOCTL?

As we did for other IOCTLs where we had to enable/disable something (e.g 
VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).

Thanks,
Stefano


