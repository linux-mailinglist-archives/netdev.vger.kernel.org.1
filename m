Return-Path: <netdev+bounces-184677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6EA96D6E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4847A2005
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1212836A4;
	Tue, 22 Apr 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+buSU06"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B41F150B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329834; cv=none; b=XZpvMOyAroMBFeRNzgM6j2Dusb/yFbuTr03GXd4RAV+1pfHCm0113CWHQQ/VRxdVesH78hwhhvAt5Skz/uZOdZaYfYkeUBwVHD4uORGbVNBrg1DXrioV9crS6OtoKujPH2GO2zsIbowGKhzZWAUq6daroT2PgJZ6yPTZW/cv0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329834; c=relaxed/simple;
	bh=dkCmKq3j0PhWQbKGGX4/SXtHAhGav5AP9tWWdDGr5gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXJwSJmlS7JJJl8d9gumGnqz9FlYm17VOvq9Pm3ga2MRwdLWh7+wDQje3nXM4aWmQatmiGpRPWMn4npDRPd8u9r8n4SK14RN/JtJVJbXqa5If1fgOHgKRUw/kNeqdKMlDAww3UIJlpsDBjqHx3nUP+2ibPwsth0ZOUVaLUg6GtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+buSU06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745329831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tGrrkrKKBqlG8Lh7JFZpiU/FR9zy5tYWV0eT1+VwfIQ=;
	b=U+buSU06KVPGiMo2Gq1wfI75eR7NFNenYtp6p1YbDriyJ6lm47/KdiLpWFe9UKTb4xqDRb
	rraj3FI8iV2GX9SIT2FFPwjZeObMhIhuEMxBkZxXU3DDUXuWDFe1apB98uVhvnlTMjJ/ZF
	TsvjuyYiNhiOlrasJsOYQRK0boeoytg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-_qfTQ8a4OLWJblGnP7QR0Q-1; Tue, 22 Apr 2025 09:50:13 -0400
X-MC-Unique: _qfTQ8a4OLWJblGnP7QR0Q-1
X-Mimecast-MFC-AGG-ID: _qfTQ8a4OLWJblGnP7QR0Q_1745329812
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab39f65dc10so662690666b.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 06:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329812; x=1745934612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGrrkrKKBqlG8Lh7JFZpiU/FR9zy5tYWV0eT1+VwfIQ=;
        b=O+VIvgi8uk/ujtkIJXp9yEnAc3adv4yMNoncyoebJLHGcSTRoLgsYMRu2nYKC4zosR
         rItbRU5by6QnZEWbmn6oYXUU4ksXE3yOxl/R70SjawrhR0D+e3XecRVkGMz9SBKkcjS3
         HhZHB1FJAmRnTrpVGkoavW3yIrAafGBCF9w3TFruYCgbjmkLpvusNlS56IxXXYkWpYyy
         3uHov17Cnq7lDyp4IIZf2GYtvI3adR0uOWj7cl/sDHJGZMYrQYXoDBjhLAEuSovDlD0e
         x3fz5PAxKloi80oKSC/sOvOzvPCJ0IGHXdc+/earVaTuc4gvt9WV3lxHIoaswbLoV3GZ
         yiRA==
X-Forwarded-Encrypted: i=1; AJvYcCWVh3phVN8wk8IvNsvP6BBBCSYmXKSw9318PmXcQbeMXbwNDvN6m+1Z2MtwYW/7CwwZUin0vbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtnd8X3rQ0u2Gphneq6Zl7Fgm2F4EuQ4v5IDle2vCOuhUQsS7
	8UMTZUX6BexfJTW4DjMicU7X+DmTulSbxTZ+AAQ5AHWiF3e595WlUnI/s4dNSqcFAQbUN6nkrot
	Pnsxog7DmzgVgzGs1GKfJd+mjfnjNfEUSbxVa6Zq5T4BIXXlfBd1bjw==
X-Gm-Gg: ASbGncssPjzpcdTSszgq0hbK3u4efsJOPzQ1BepSGjKx/w32Y0AWcxTrNyNwuZvV9Qp
	nJPeFAiEiRbriJkc8VgJvDr+CmCiNSFlRcUNxMMC6w6z4qpPosYqTQcnycSlnsQEXnOKpxZRNtZ
	45eWPpZDvKcAkUM0kahNx7K7t2U4EUZ8Pw+aj7+WH/7Bc22Wszg9lUQFQCrF6jzl1hjiydiLGYb
	qi04KAEElwFGK0RKJYYX2Lh8/8SAotb7UcPb/X6TM6uLmVVb8oxRyDKYkBGxW7CwnlY4ciZnm9d
	xRTjC7gjMdL8MKUB
X-Received: by 2002:a17:907:7da5:b0:acb:4cd7:2963 with SMTP id a640c23a62f3a-acb74b8e55dmr1223055566b.33.1745329811875;
        Tue, 22 Apr 2025 06:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQvXSYXhBqNx9LOtFRQbGzKaEda8F/rKCshPfN314qnQj7UlAV89zqf9GyuhprD3N9TfTw0Q==
X-Received: by 2002:a17:907:7da5:b0:acb:4cd7:2963 with SMTP id a640c23a62f3a-acb74b8e55dmr1223052566b.33.1745329811204;
        Tue, 22 Apr 2025 06:50:11 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb905183a0sm489771366b.110.2025.04.22.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:50:10 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:50:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <4xh3i7qikqiffxocxms4wfplg4tvemnszvywmtpkfyiqvq3age@jcq3aqvumig2>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250421024457.112163-5-lulu@redhat.com>

On Mon, Apr 21, 2025 at 10:44:10AM +0800, Cindy Lu wrote:
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
>
>diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>index 020d4fbb947c..bc8fadb06f98 100644
>--- a/drivers/vhost/Kconfig
>+++ b/drivers/vhost/Kconfig
>@@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> 	  If unsure, say "N".
>
> endif
>+
>+config VHOST_ENABLE_FORK_OWNER_IOCTL
>+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>+	default n
>+	help
>+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
>+	  userspace applications to modify the thread mode for vhost devices.
>+
>+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
>+          meaning the ioctl is disabled and any operation using this ioctl
>+          will fail.
>+          When the configuration is enabled (y), the ioctl becomes
>+          available, allowing users to set the mode if needed.

I think I already pointed out, but here there is a mix of tabs and 
spaces that IMHO we should fix.

>+
>+	  If unsure, say "N".
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

As I mentioned in the previous version, IMO this patch should be merged 
with the previous patch. I don't think it is good for bisection to have 
a commit with an IOCTL supported in any case and in the next commit 
instead supported only through a config.

Maybe I'm missing something, but what's the point of having a separate 
patch for this?

Thanks,
Stefano

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


