Return-Path: <netdev+bounces-178597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61C8A77BF7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB3F3A72CE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9821FAC50;
	Tue,  1 Apr 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKQ79aJK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED451D619D
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513715; cv=none; b=TV//niqHgJsjszxyUUy3SugRVyZ3iSzbJfAyak830CIf9Fk4jrH++n6QcA1JC+HtOuml7UNi1mvviTb0mxd8F52ofBavk04vnOV5lpruOkEiFeMRcLVSWLyGcrH8ymjDH/T46kdYcb3NAkOAX6QTBk5qOOyIncb0U7FQ5aqAcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513715; c=relaxed/simple;
	bh=ycqaVfo4cc/Z15EASZ9JqEGL8RqMFYZHnyysBu7HA+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg7mpw+A1YAsPaFpIw67OFVsylGHCnBv5sIOwYKvIgn7e/VCX3PCz75QkZvIVMSHc+qgoH9MgZNOuPOmNpsN45Ya4JFZNIFqqGaaZRkJ/NXxXvu6ERW0sLGGubKHKwTy4ERareDxHm2Q0JxaF1bN1bz0EhoKejeAE0mvOOR6dDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKQ79aJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743513713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRPbMyE5s2HZPVPM3LxqZ+mTI/kiq2Z60zsrimmnKds=;
	b=PKQ79aJKrgA+97yWYaJUjbgOaKDop4ZJzkfakpG6xWC7VrL/5NhwOb8oMNKUzpwJLDgQB/
	T5T3fEnr2Phbz3YSU3rNRJky0C6LjIhEvMYnzYSm9KOhh3CUTL4WCgW+oBK4ok1C7QVfCO
	A5CrfUTYQTN8UHT16JwMOihEwDhoQrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-CDoUsPNiNeaZV_rS1bqWSA-1; Tue, 01 Apr 2025 09:21:50 -0400
X-MC-Unique: CDoUsPNiNeaZV_rS1bqWSA-1
X-Mimecast-MFC-AGG-ID: CDoUsPNiNeaZV_rS1bqWSA_1743513710
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so40642025e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743513710; x=1744118510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRPbMyE5s2HZPVPM3LxqZ+mTI/kiq2Z60zsrimmnKds=;
        b=W1EL+/tUubLz7AMcbKPAiV2uCRHnCR8P2B4y0r76MxSUk+Yydqn/zRt04oYGgxt7TQ
         5eVbHITfuQh34JbUELxYhXRoPPuB3lKiSP0dGWz/DnSORVNFFo44aYlPwD051ucmb8Qa
         jUYHD6ZaBrNwfR3hhozvb+bxE7QsVl8qSgS9p7XpB4tguTQEZm4BE7tupG17u235SI35
         4+kHvnkfEX0US6c//mYwlQnwRjGGmXf5Gfqj6JT7CIluoZCtUpGQfrFthFybpJufFe8B
         S0l4BUzA0XVbPq2jWWD3GaVdrpkD5rqlh3is/T4cRD9iEuqHzJRThoUtf8g/FtI8htuq
         aRIw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6aaegXNprPB4YTUix3VG5cATfcHkvIpg6MHSvkK34ZMHJ43JVdBTYHlD7xVbmSbsd7Ehqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOww650NYV8ulU5wU/QjkP0MTmzRVBFlJmYhMusEaScSYGmj1
	+QYt36jSV3UpHwiE1jahTvTanlM0KC3RwDB1N+yWWWdPhI1WSvlUafNRCOPtDxDOYt4JnAHd4d4
	+IEpwLs1OxbDTKZLVrha6jVpXbab8tKtLqAMxYaAZVUWPZU5L7dESEg==
X-Gm-Gg: ASbGncslbhidxOLmBiZu3H9pA1u7k2xkflgN88PHblwKCYciyF1ri/dbrF64Q/O1gv3
	n6g5eB/oZ1whLE9wxc8lr38TNXrzcxGXucpn2VEJv60jFEMBU0dDaOjiAtloDjnA1lylFWIhiLt
	MZOZwUwT6wVJ2/HL+TET0+do/xHryeia6eEFdX2IpxTLPoo9BbUKk0ibpr1PMZqextnT1pp0wiE
	euT7soWeSOn2LgHIWTt81mY2VqeCoy1+tPTZoAZv3esLFtSvLlDxE5OrupX3wiNxJa70rDgUSnF
	MNZ/g1naJmxb7l+NXImFz9PuiKdx5X6sjIK78J8g4A24mQeJEhTHapBnePI=
X-Received: by 2002:a05:6000:1864:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-39c120cc896mr10576009f8f.9.1743513709523;
        Tue, 01 Apr 2025 06:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiWSuzzoAuRNaX6AE7+30mbeGythA/LKCONvKE8G1+2K+Xi1SRoClR/KoadewifmZl/GAkjw==
X-Received: by 2002:a05:6000:1864:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-39c120cc896mr10575974f8f.9.1743513709009;
        Tue, 01 Apr 2025 06:21:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66277dsm14027524f8f.24.2025.04.01.06.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:21:48 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:21:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <3zmkrimo2nghk42iatj4tuhfb7qrxx235srleuavi4at5dsv26@zj6wqgj7hj62>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-9-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-9-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:52PM +0800, Cindy Lu wrote:
>Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
>to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
>When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
>is disabled, and any attempt to use it will result in failure.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/Kconfig | 15 +++++++++++++++
> drivers/vhost/vhost.c |  3 +++
> 2 files changed, 18 insertions(+)

IMHO this patch should be squashed with "[PATCH v8 6/8] vhost: uapi to
control task mode (owner vs kthread)".

It might break the bisection to support an ioctl, and after a few
commits enable or disable it depending on a kernel configuration.

>
>diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>index b455d9ab6f3d..e5b9dcbf31b6 100644
>--- a/drivers/vhost/Kconfig
>+++ b/drivers/vhost/Kconfig
>@@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> 	  If unsure, say "N".
>
> endif

nit: there is a mix of tabs and spaces in the next block, should we
fix it?

>+
>+config VHOST_ENABLE_FORK_OWNER_IOCTL
>+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>+	default n
>+	help
>+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
>+	  userspace applications to modify the thread mode for vhost devices.
   ^
   tabs

>+
>+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
>+          meaning the ioctl is disabled and any operation using this ioctl
>+          will fail.
>+          When the configuration is enabled (y), the ioctl becomes
>+          available, allowing users to set the mode if needed.
   ^
   spaces
>+
>+	  If unsure, say "N".
   ^
   tabs

>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index fb0c7fb43f78..568e43cb54a9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>+
>+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> 	if (ioctl == VHOST_FORK_FROM_OWNER) {
> 		u8 inherit_owner;
> 		/*inherit_owner can only be modified before owner is set*/
>@@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = 0;
> 		goto done;
> 	}
>+#endif
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>-- 
>2.45.0
>


