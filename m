Return-Path: <netdev+bounces-182356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66EA888A3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695F11899582
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6062820D9;
	Mon, 14 Apr 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrppPEBy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65619309E
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648360; cv=none; b=tuz+EcTOPPoF89OHz2gLSuU+1bdgfnionvWYnRJ8DcD2PVJ5lhsK1TXGeHJlxjmEyJ9/Dp5ODz8ztEFkEd93U60TQiVnRvtqiKhtjTB0sCjSegqoBRIm4uc5iiEirTOa6rrhRvBCOeJ/ypqJrr3yO/uHzK/yUqtJudB2UlEcXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648360; c=relaxed/simple;
	bh=LxeEjXsTzyjmpn+ReNlLxMKLEF/tsQrcB3L0UMTB9is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOrTDWn29XpKA4E2LiYUl6cruO3nhdW47pzCusm4iZKLhivawLHmpnMSLSVEqIVbytX/40S/RqRWABU75CaToIgDPcTa/omhPd8IfYstOmPoLaQA0evtHbEOB6cvghr7n2vt15i++4RdvdyoSZcVIUfIay3DHWDveOtfaSmcRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrppPEBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744648356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psPpYVaNQlJBPoNb/90nh8sbsObK4AuLZcGNe09lj5c=;
	b=VrppPEByuDEadsvSH+p/M1HnQCMj2v5XF6AtS80foymTitPpmiIE2Wd7OklxnBTn8KptjP
	cMjxNz1BJIYJykiYD3CB73znx6OgDQqRRwARqkF/FoecqbhK0Nmhp1qdoAywk9Rs0p/YYk
	4KZxmYhS1mgx26NWN4iNlWa6vHVGH2A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-niRSeQtJMeGkNnRObHRTjg-1; Mon, 14 Apr 2025 12:32:35 -0400
X-MC-Unique: niRSeQtJMeGkNnRObHRTjg-1
X-Mimecast-MFC-AGG-ID: niRSeQtJMeGkNnRObHRTjg_1744648354
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso28858445e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744648354; x=1745253154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psPpYVaNQlJBPoNb/90nh8sbsObK4AuLZcGNe09lj5c=;
        b=MGSBDRX970SyKa3YQVsD1lHOormO7SWoFODDZ5JPEpA3c5WoX5YCNJo86BADFW7XMx
         Du8QP7c2mCK1TIJ1YpW369RSD9BNSXDTOJQE/x2in55EUTe9vO/t6N+LLR7QSzyVdYfZ
         C+fV3Gsi0fzPzI16WVFu6Yf2/jkpVbMHFw8c+SaOEQj5uU0X0X4o5WzBE+k5ukbhcbAF
         s0tUWG/GUhCSU4Bw0sYcx7OH935BVk25r1fLd7ZJzzckxY2FZr4IJfb5naykxia/SjEd
         30zabjgbgXsUxoJl9lx9i4X3hQAOW11haZ6dxDevjvOY/hXX89vwJ7zIZLc8kNXJzbt0
         JVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXbeP2eaZXwX0ZQ2moFFvHFYbEk2DymM5FyaVpQOmig2mlAoDgABcoYLJmk4fXmbFxf9mz2Df4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2myVyv0fzNMSJ5Zy8YL17pWABFtmk7nfUlV2lQng7wM6PeuW
	UuXZlpcm7xR4PmW94xdaI8fy195UjGKtRoNkDYXD6y+nRPplcmTaeDs+pheqIzantVyMWT5sS7/
	AeWC2MdKRzKqKqFUlup9k7C+nJ0XK//QFT/yn2zxM7FAPd56IFX5F/A==
X-Gm-Gg: ASbGncsysjQLzg+mQt4WUwomZjSpNhaArNjXfOxw1ljmw80JFIoL9PdHfc8F3rsX1jq
	lu5m3cOV0aEgrdK1BoRIHm0pTfL2IaDg3mt4rMiqnLBX1OMZhWaNu4t/PbHpvBdbAdRQ6NF9x+L
	zD29RJse5g4M+LDUB/avCZmVp0ukpgqfu+VIbXJhQR9J4DkKWjw8dgXbz8rMmW/1pEgu8n2+KnC
	ONgi5FAQKpHola62LY24/hRjpQvQS52z/ynIEyZ3a1i6tnG19VocAcmzU7Su1uCTFsFD8FC0194
	VqDtXw==
X-Received: by 2002:a05:6000:248a:b0:39e:cbca:8a72 with SMTP id ffacd0b85a97d-39edc3059aamr38187f8f.12.1744648353749;
        Mon, 14 Apr 2025 09:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErshira9b65DJz4U+YOoZ2EfEQ5MJmWz7qS8OqJT6VLSYpu4hvsslk7OCkkLLr5Vcu2G6UIQ==
X-Received: by 2002:a05:6000:248a:b0:39e:cbca:8a72 with SMTP id ffacd0b85a97d-39edc3059aamr38167f8f.12.1744648353322;
        Mon, 14 Apr 2025 09:32:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm179644545e9.10.2025.04.14.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:32:32 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:32:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, jasowang@redhat.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, joao.m.martins@oracle.com,
	joe.jin@oracle.com, si-wei.liu@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] vhost: add WARNING if log_num is more than limit
Message-ID: <20250414123119-mutt-send-email-mst@kernel.org>
References: <20250403063028.16045-1-dongli.zhang@oracle.com>
 <20250403063028.16045-10-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403063028.16045-10-dongli.zhang@oracle.com>

On Wed, Apr 02, 2025 at 11:29:54PM -0700, Dongli Zhang wrote:
> Since long time ago, the only user of vq->log is vhost-net. The concern is
> to add support for more devices (i.e. vhost-scsi or vsock) may reveals
> unknown issue in the vhost API. Add a WARNING.
> 
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>


Userspace can trigger this I think, this is a problem since
people run with reboot on warn.
Pls grammar issues in comments... I don't think so.

> ---
>  drivers/vhost/vhost.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 494b3da5423a..b7d51d569646 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2559,6 +2559,15 @@ static int get_indirect(struct vhost_virtqueue *vq,
>  		if (access == VHOST_ACCESS_WO) {
>  			*in_num += ret;
>  			if (unlikely(log && ret)) {
> +				/*
> +				 * Since long time ago, the only user of
> +				 * vq->log is vhost-net. The concern is to
> +				 * add support for more devices (i.e.
> +				 * vhost-scsi or vsock) may reveals unknown
> +				 * issue in the vhost API. Add a WARNING.
> +				 */
> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> +
>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
>  				++*log_num;
> @@ -2679,6 +2688,15 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  			 * increment that count. */
>  			*in_num += ret;
>  			if (unlikely(log && ret)) {
> +				/*
> +				 * Since long time ago, the only user of
> +				 * vq->log is vhost-net. The concern is to
> +				 * add support for more devices (i.e.
> +				 * vhost-scsi or vsock) may reveals unknown
> +				 * issue in the vhost API. Add a WARNING.
> +				 */
> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> +
>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
>  				++*log_num;
> -- 
> 2.39.3


