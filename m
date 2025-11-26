Return-Path: <netdev+bounces-241800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339FC88500
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D463AC290
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117C33176E4;
	Wed, 26 Nov 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8c4sAPZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBUaPoAy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF81316915
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139506; cv=none; b=ARmxWQ1Z6qirl4E5bAEYim6dnUS6e+J2M3FNVMLGxdb6HFO+wKlVhCJ3Xqngis6QWh5VWGKk8/XzltXo5K5/iUn/q5i1AEJR0alPAg7ZG/epp0SMesTSkj/h3hU8LV03jfJON+8UsZmynQjhqUjAVRZP6PLiwXfnCMJi3bohkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139506; c=relaxed/simple;
	bh=DQ6bRODoblgAeg3XSk7omcQWdHBFsCnw6CmyRqth/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+tH/pT1cCsBq2QEo0YuihQdjgEK9WS4AiyNQqATJYu29wGGbNEveUnz11l0yNjZ6ZU1ewTEwGCRtltTWaoDxd/thOjkZhB5awvAv+hjQEq9qN2zjxDu6EcO1z0KBWct05Y6gT9Te6TMUecfLKRypjDabBCWLX+JcpwfI6FQ8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8c4sAPZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBUaPoAy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764139503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Npvcjha76DC1ejnGCP7oq3FFGj14mki1tnTcX/tgKc0=;
	b=b8c4sAPZXrq5d9ihTU/cmf0l+k7FShmUe4+XMqOYddCYW+gU7UPPJvWHnyHZLPI74iakCn
	QLWuRsYTlHZnCHRgx9IRg/2IFra6C3ArFEfcekns0FlvRTUAw6O98s3fd28XrqJrqieJe+
	9idY6Z4mXMV9zfObbD+9zp2MVQSdjdg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-8AO3AGd8M_OZ_bi_Ivog4g-1; Wed, 26 Nov 2025 01:45:00 -0500
X-MC-Unique: 8AO3AGd8M_OZ_bi_Ivog4g-1
X-Mimecast-MFC-AGG-ID: 8AO3AGd8M_OZ_bi_Ivog4g_1764139500
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-882376d91beso176605986d6.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764139500; x=1764744300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Npvcjha76DC1ejnGCP7oq3FFGj14mki1tnTcX/tgKc0=;
        b=RBUaPoAyKZqIN568cDAkEwhdv8sxVfKMSziNbZV40UAEUn3jMpRIfP7Qtp3f9t6lG4
         2GOYIjaR9IRJxtWQ3yGSYtpWDNXb5v6JWIaZ0Sj+M0t7Jsr0PDF2+RQF0Zt8D23ub2Kj
         880QKmxkXqCEKhnYI2sq6w7WCBQI4pyyk3fLBzoKsWXvl6h/5wD1R5n44A13UItrDn3W
         vJenWvneqlHyhYUz9Igu2LbnNwdGYLZc6AOABFOVltxFAUcj7JXByz/e6IX4AZsyVp/A
         3vpQ/tZz3haVgzlxWv5HKn03QBa22PrWCVVWO+1xk4TPBqh9N5WWKNwDbR1n8729SV5o
         4m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764139500; x=1764744300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Npvcjha76DC1ejnGCP7oq3FFGj14mki1tnTcX/tgKc0=;
        b=nNsvzL1Gfy9R7VHs5H/4CW6pJf2S7zawYCemh2HgNwcDEg81ZHoRejgGn7ICNVpRPI
         3N85kBSH9EFSUAS8NRYDjC3tUEESwXXzN5ifTdA4COlwE0siWapE72c2w6YPbalck87v
         IzNDhnQSBSsdddQ07LSPT56Cgi+N8sRcFk0SHhO4T3lAvd3OFdLzO1oOn+GPxE5kPxGC
         QIZKEJI2IfoCztYSp3oyhxybq9/9EAMDjCMO4m3erKfSNckRxhe/StBkWHqeWJ747Otl
         o7sVvosC85KYemn+KYQefxF4zruH5EtU5bhWcH+yGVYkNDIK1HdcPRDlbimPqezEuyA+
         A4aw==
X-Forwarded-Encrypted: i=1; AJvYcCX7ElXNz6n2HFvBHYPQoEg1cGAyaZ9h9lwgpPiovc+iwjPXFvRDDPQ4Hoi+2QYbCs35piYaDQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHDEIXj1qGX8qdTJxHqo9NRDJyxAcgYzIP8/l41eEN/3djK2q
	rlWABBV6AfX/oWrHH+DdONqnmid/r08WTov4x5TOZq1Q+4CmIxD0vc2ODr88/q9AXx+dsMJ0IZC
	4uyCqwmnQKy267Vk6i21+nvI7Hn0sLdu3Xi1QMy5vk+9OdAYny1dSLMdZjA==
X-Gm-Gg: ASbGncuGDpLUjRptuPA6tyZX3KSsLF3T2qCUXL7DayCqosLo8NxTkVm1Wf1FOtzYRMq
	HF7eMWTLl5AbfKc/WP23OHm4kun88cpW02VLGV+IjPEl+YOMbT0l+hfAWp8DvElytKu5CXhIX+R
	TehvBGbMMyo1Uf4q27XaDiGlebDpaxb50/0WPlgftdIIRFnktiEWCHUO1MWs2BxGPg+VsXNyH5X
	yAeybdhFNeiQAmY9Tmin90nrrITkczx0WmXpBJU7uF6ED/SAfwaI8S0bmIxc+nYMy2wjfUwlGk0
	G9BR93VFoFWXpA2hwAZu5qZedS0RQMBDmb65FmHdGeW9m2EMrQRHhdUPsGpPnAl3ggGQPUsrlRG
	vZ5wAIddR/wMdA3ZEFbA++yT3Vlv5nA==
X-Received: by 2002:a05:6214:4983:b0:729:9b59:bba6 with SMTP id 6a1803df08f44-8863b0030bcmr81663846d6.34.1764139499996;
        Tue, 25 Nov 2025 22:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFryAKS6j5tOcAHlHu78NLpdU4U4O+q9VC2+SQ+7lI/BXK39/K0QLkDWLrOK7gOYfRBdeiYUw==
X-Received: by 2002:a05:6214:4983:b0:729:9b59:bba6 with SMTP id 6a1803df08f44-8863b0030bcmr81663586d6.34.1764139499525;
        Tue, 25 Nov 2025 22:44:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e573909sm142973046d6.39.2025.11.25.22.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:44:59 -0800 (PST)
Date: Wed, 26 Nov 2025 01:44:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] MAINTAINERS: separate VIRTIO NET DRIVER and
 add netdev
Message-ID: <20251126014446-mutt-send-email-mst@kernel.org>
References: <20251126015750.2200267-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126015750.2200267-1-jon@nutanix.com>

On Tue, Nov 25, 2025 at 06:57:48PM -0700, Jon Kohler wrote:
> Changes to virtio network stack should be cc'd to netdev DL, separate
> it into its own group to add netdev in addition to virtualization DL.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: Narrow down scope of change to just virtio-net (MST)
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20251125210333.1594700-1-jon@nutanix.com/
> 
>  MAINTAINERS | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9a8d945632b..dfe80717b0af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27139,7 +27139,7 @@ S:	Maintained
>  F:	drivers/char/virtio_console.c
>  F:	include/uapi/linux/virtio_console.h
>  
> -VIRTIO CORE AND NET DRIVERS
> +VIRTIO CORE
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
>  R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> @@ -27152,7 +27152,6 @@ F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
>  F:	drivers/vdpa/
>  F:	drivers/virtio/
>  F:	include/linux/vdpa.h
> @@ -27161,7 +27160,6 @@ F:	include/linux/vringh.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	net/vmw_vsock/virtio*
>  F:	tools/virtio/
> -F:	tools/testing/selftests/drivers/net/virtio_net/
>  
>  VIRTIO CRYPTO DRIVER
>  M:	Gonglei <arei.gonglei@huawei.com>
> @@ -27273,6 +27271,19 @@ W:	https://virtio-mem.gitlab.io/
>  F:	drivers/virtio/virtio_mem.c
>  F:	include/uapi/linux/virtio_mem.h
>  
> +VIRTIO NET DRIVER
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +R:	Eugenio Pérez <eperezma@redhat.com>
> +L:	netdev@vger.kernel.org
> +L:	virtualization@lists.linux.dev
> +S:	Maintained
> +F:	drivers/net/virtio_net.c
> +F:	include/linux/virtio_net.h
> +F:	include/uapi/linux/virtio_net.h
> +F:	tools/testing/selftests/drivers/net/virtio_net/
> +
>  VIRTIO PMEM DRIVER
>  M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>  L:	virtualization@lists.linux.dev
> -- 
> 2.43.0


