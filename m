Return-Path: <netdev+bounces-241712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F99C878C8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B166C3532C4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A58F48;
	Wed, 26 Nov 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I33+ruBy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGMMHuqU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6B1367
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115485; cv=none; b=GldLSqFI3PpcYjcxv4xyOUItbgyx47/18iwpdc/2pI4U/rYOi9zdeX4RdNn24RxJlAmk7FWBeUamGbsF7+kTQJwmLtErXr1N1FjhVJPvGkomGCGPKrv3chF03WExc9v2pR5uwO7CbYlp4+4GznZIGbQjSHB7viVYWyl9OB0uOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115485; c=relaxed/simple;
	bh=ike1WMWzvLmPlx5h/tCRlbzBaVx7z8muD6TccEz+uaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaiYEOTpVSlVT+PnOVVST3CqtiY3uj01VW/BZ9bF2c/GLzWHvMEh+nVzNn7dYsLcAdM7/rooaDMP3M0YKeASzBWf1KmMxGAuGQKCVWVJkdKmImYcEqxF3NPUi7D8dJf1gdClTAIRB1zznFh9OrlwInWgeN1DqjE8EJ6nqygYgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I33+ruBy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGMMHuqU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764115482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTUyf4j0JVB1nQkzDa0c2Yn3+M9B9/NTb0nOVSMXyI4=;
	b=I33+ruByaslKP3z+4a7AQTMOPYY+pU1TT000lmvJJwvmmmXsg2uVNu78eH1+w4sZ8k+7yq
	AmdEF2yHTpWP39HGf07jrFkqI6i8XQDI488xhjeUF1I8ySPfkibXi0+qEsH+6XrHsWZ/Ie
	xb9bEIoIFI57UUAMlu2oyvu706G8uVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Oxv3e7_vPpmjKHX-vcf1Lw-1; Tue, 25 Nov 2025 19:04:39 -0500
X-MC-Unique: Oxv3e7_vPpmjKHX-vcf1Lw-1
X-Mimecast-MFC-AGG-ID: Oxv3e7_vPpmjKHX-vcf1Lw_1764115478
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4788112ec09so9439115e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764115478; x=1764720278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTUyf4j0JVB1nQkzDa0c2Yn3+M9B9/NTb0nOVSMXyI4=;
        b=NGMMHuqUKAx0nyY52GkIkXenckM982OZ0gcN8LCKvrvrw0U5+0jbDbAUIo/l/VnZ1D
         C/XYAIA866jx+7iBhQSY+zGRG+GEnw/7ljdgTiSQu1SNm+Tn2m2PrtWzWK0bb3R34iLe
         Gk8ZsbMZYPfjVxCXB/Tl1w/EtKDbnWcF7FnobwwMtWKpcyZBH2PfuH/9HHmy7e6tFo8s
         4ZxxL93Oh/m/kSsmyUzfNCqbCCfUKoB/xdRCXRqmp5kyC+u0gq5JiBZwzOaCNHNYUqIc
         x7uTRJRxdA/rxQJ0cTFXRzuc9YmdHwLd7VwoCiE09QSmKD3xChI97sxaaTLm+WOqXaB9
         SQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115478; x=1764720278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTUyf4j0JVB1nQkzDa0c2Yn3+M9B9/NTb0nOVSMXyI4=;
        b=qzauy196BS54LsNKWHpdXBGGOaskhK9niDbYEA6bepbHScXnKLn50K7T+d/F99AdFZ
         81ZXkDz3Id+erfUuXr3r3fOYT1yho3ovbiOk4aKvpVDpb5UG3uff+r13xZ7tDK20RcKv
         PyOmxhfsQY99/SuYOiaARNLLIRy2IKBB8+5OvTksz0R28bho7RcgM/9xb86U1RoggQND
         P/lnSCrGYTaY0y3/14bI3tG2v0R0ATH8RSUhcW1T6xGKEmmihnI07W3wmQJ2Bu1U9Nly
         w3l+11iSpu1e4axCcZoENnfDlmgkcZ/IpnJhUC4FE84BTggWYMpkwsJqCILQOH4tYuvV
         eEYg==
X-Forwarded-Encrypted: i=1; AJvYcCVYbvuhiFb7FIUIe+7Fa1WghvVkm5B9RDF9I2PbYJ9ECw3/8uQZvnnePC8MxgdZL/at8YUJD9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjM1IUAzZLIvLWt5a6d4Gv6Q65pELTEFUBhsVkolQEPLdDN1oz
	e56/tF1kUfnjSb8pAkzTAdr3TPkGnj0BVDp0L5mk2eG7HahSxjIoA3RzmWQQkvgnrHAFL4NKZc1
	3swIVFGaOc+aYlBsKeTiH99N5RzBxn41BuvrHHW294LNlfTzbcL92+rOF+Q==
X-Gm-Gg: ASbGnctJWC3sR4DOge5GL5153UFidY5qrNHL6HTdLsOoZ+XPA10fr+hd5p5UuEngkTp
	2SXQDOsnDjpFGf+uiIa8jFdUDEyMhbLdlkyV1HH7pYS+rLAN8IZML1c8QElSxvani5lyr/5N7US
	qR3Z0l82uxdL4KlIT/kkwNpIuwnChse6u1ciQGmZhsuN0DjXxplq84LGs5cq8ds1+JXkb4O9E21
	+mnd9asgxLVLx40GSZzhKZpxgIYseSP7H5BtKP3oepLuVsoahQC4yTxp3wFgiqpvcs6JH51fev/
	PzEkwqWH13ogdPvfPqaI90HkMFzr841Z5Yp9OjuI/FSMvndZAULlxAnMwoEWKyuVghgjz0XbHwK
	PC+Cj7lEHv5NG4f+r4M9XppGaeXCK0g==
X-Received: by 2002:a05:600c:6287:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47904ad0724mr39869625e9.10.1764115478502;
        Tue, 25 Nov 2025 16:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGO6qZviFo/lEHybIQNV9gudmrKamo/T+9zD29CwkXnIFBmXmbvXnDigufHOe+9lYLZ7wSlA==
X-Received: by 2002:a05:600c:6287:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47904ad0724mr39869425e9.10.1764115478064;
        Tue, 25 Nov 2025 16:04:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm36851184f8f.19.2025.11.25.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 16:04:36 -0800 (PST)
Date: Tue, 25 Nov 2025 19:04:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: separate VIRTIO NET DRIVERS and
 add netdev
Message-ID: <20251125190356-mutt-send-email-mst@kernel.org>
References: <20251125210333.1594700-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251125210333.1594700-1-jon@nutanix.com>

On Tue, Nov 25, 2025 at 02:03:31PM -0700, Jon Kohler wrote:
> Changes to virtio network stack should be cc'd to netdev DL, separate
> it into its own group to add netdev in addition to virtualization DL.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  MAINTAINERS | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9a8d945632b..50cef0e5c7c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27139,29 +27139,23 @@ S:	Maintained
>  F:	drivers/char/virtio_console.c
>  F:	include/uapi/linux/virtio_console.h
>  
> -VIRTIO CORE AND NET DRIVERS
> +VIRTIO CORE
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
>  R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>  R:	Eugenio Pérez <eperezma@redhat.com>
>  L:	virtualization@lists.linux.dev
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-bus-vdpa
> -F:	Documentation/ABI/testing/sysfs-class-vduse
>  F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
> -F:	drivers/vdpa/
>  F:	drivers/virtio/
> -F:	include/linux/vdpa.h
>  F:	include/linux/virtio*.h
>  F:	include/linux/vringh.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	net/vmw_vsock/virtio*
>  F:	tools/virtio/
> -F:	tools/testing/selftests/drivers/net/virtio_net/
>  
>  VIRTIO CRYPTO DRIVER
>  M:	Gonglei <arei.gonglei@huawei.com>
> @@ -27273,6 +27267,25 @@ W:	https://virtio-mem.gitlab.io/
>  F:	drivers/virtio/virtio_mem.c
>  F:	include/uapi/linux/virtio_mem.h
>  
> +VIRTIO NET DRIVERS
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +R:	Eugenio Pérez <eperezma@redhat.com>
> +L:	netdev@vger.kernel.org
> +L:	virtualization@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-vdpa
> +F:	Documentation/ABI/testing/sysfs-class-vduse
> +F:	drivers/net/virtio_net.c
> +F:	drivers/vdpa/
> +F:	include/linux/vdpa.h
> +F:	include/linux/virtio_net.h
> +F:	include/uapi/linux/vdpa.h
> +F:	include/uapi/linux/vduse.h
> +F:	include/uapi/linux/virtio_net.h
> +F:	tools/testing/selftests/drivers/net/virtio_net/
> +

vdpa/vduse is more or a core thing.
Just split include/linux/virtio_net.h things away.

>  VIRTIO PMEM DRIVER
>  M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>  L:	virtualization@lists.linux.dev
> -- 
> 2.43.0


