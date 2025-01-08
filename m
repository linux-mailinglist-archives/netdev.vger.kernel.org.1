Return-Path: <netdev+bounces-156253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716CA05B71
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9325F3A4043
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF181F9A8C;
	Wed,  8 Jan 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi00FDtu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4A1F76CD
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339000; cv=none; b=onV9nrLawL+fEBO8kBvtXCuVGfI57q8NJgdBQ9PUn1g6R8FOBcslvXn4wt1W8qUrt2Vi4hsdS3mZ5iSFwBoAO82KnT4IX5EQdZ0J/k4TWPMtsFoIU2Ao7cxFZ//vTe9TdaulT8KhxO3EEa/YqSwYdRUXX00bKfMj6MIOlajnjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339000; c=relaxed/simple;
	bh=CYEL1xsMWMcBwANmoFnaeB+RsMLozxlw7Y9ZKV5IL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaN5UxeyG2HuEM32KtFMODWnfPhkA5CWZOrNbMOhzZFmGlQOmbW2ezEb6JEDIyUY6N3BgYL9+i6c1+ajkaivvJ5R53CRy4XBTxEMn6vkapTK1rFWHAggPcAO55WSUyc3dBfHuiJp9RuvuMmbPDg6jHwZxnwVv4pJg4sH4UqOTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bi00FDtu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtNPZrhPuEXDAUmk7MMSLxT+pmGkUlhGX8IMqmFXcVs=;
	b=Bi00FDtusYef6RUS3D+WcfmJHOOrsx44+PGhTEbWLSqRfU0Y3kmFX91SCZK6r1tjsYQ9HB
	sfGCvbdDzgZmN65EhL9Z6GCP1nzEok1q8wBQRLUBvHs81BT8vaYlOR58z6WRSMzaPuueG/
	5A9beLU2ktZCAgEuSjplvLNv90Pl4Bw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-yPBJZiu6MGue8TqN5g0htw-1; Wed, 08 Jan 2025 07:23:15 -0500
X-MC-Unique: yPBJZiu6MGue8TqN5g0htw-1
X-Mimecast-MFC-AGG-ID: yPBJZiu6MGue8TqN5g0htw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab2b300e5daso64303066b.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338994; x=1736943794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtNPZrhPuEXDAUmk7MMSLxT+pmGkUlhGX8IMqmFXcVs=;
        b=kgODUovvu9Z7cN0KcjirQq9UXnTVn7lA6ki5LKHspfJgJeVTTBN3UPmisdgazYeDyk
         WygzaA72FxXk2FA1ry3O7iCUSEsqrQR4vCFhAKYuoEW+eOwFSiXCpmyEeG65yR199m0+
         1vzcT6mNAnmr7XWaNS8xgfaXRq3+BgsuzxX3Z26FzQA1xK868agn0nQfI6wDWrZRKiUt
         yqQHhrl8vgb5ChojiRIVj7kLMCt0KFiivuhSBSLLgpvTR2dIV5SOZnvB6fpSgpyVdSk9
         Xu5uTlr1NEBSa+rTfGH2UbUpW4J83T/l1GKRpvZc4VFY6ofT8k3VuRFDzapZ4ZR7ghST
         zZSA==
X-Forwarded-Encrypted: i=1; AJvYcCWQIe7wyF0L1e76OIlJNEHSxv0yc2XTZQGKcaPeA6tGPfR/GXbEJeT5kAd9sPLVGU/wA/XLA1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIWo1n0peKXdShdgpslnxzuSBbfwvP1XH3v3iqCK7O1T7s5tE
	W3YQZzPn0ydruHBuABBfpFff9jKFq4pd5cO0Gwzpg83656wAHg/Q42CJ94Ejf0qli+UzGuURHrb
	1wE1+rKr/9G5meqm6tSo2ebje/0xj1jhN/vsBCo1JZZciq5PR/UtttA==
X-Gm-Gg: ASbGnctc3nDbGGwzsq/DEsdEnulM0xrHg6tGkx4gcyp9HPNMtBWQM3vTCWB6z9mzoBv
	INYTHqpAtxfZZJ6zhMoVyKeD6ZriZ8hE0/Ju7i0SAtnM/0A3+rblvi74d/oqMGa5joc7+n9UceJ
	FruqDCynO4uH+M1PbzhEmVr8K9FUPlIBYBtMBLsnIuc+XIehYFBEXOB1FelUm5sgpvuM1WTD7X/
	TJQPdF68mIhUT/w5kDXSjJmiX+TWkeAwk8nWjW0LCWavB2JiwI=
X-Received: by 2002:a17:907:1c96:b0:aa6:6a52:970 with SMTP id a640c23a62f3a-ab2ab6a7603mr214442766b.1.1736338993619;
        Wed, 08 Jan 2025 04:23:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgJ2ItxqbcNpBvhzA7PF267wqdTMYaBrex8PA7k15rP1ubt/sLuYmBO/GJPJLWwYew7P6vYw==
X-Received: by 2002:a17:907:1c96:b0:aa6:6a52:970 with SMTP id a640c23a62f3a-ab2ab6a7603mr214439666b.1.1736338993060;
        Wed, 08 Jan 2025 04:23:13 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f616sm2481777466b.41.2025.01.08.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:23:12 -0800 (PST)
Date: Wed, 8 Jan 2025 07:23:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
Message-ID: <20250108072229-mutt-send-email-mst@kernel.org>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>

On Mon, Dec 30, 2024 at 08:43:47PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API.  


I briefly applied this, but there seem to be a bit too
many nits. So I will wait for v6 with everything addressed.

Thanks!

> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode. 
> 
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>  
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the default value is true.
>  2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
> 
> Changelog v4: 
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function pointer in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
> 
> Changelog v5: 
>  1. Change wakeup and stop function pointers in struct vhost_worker to void.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>  
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add worker related functions to support kthread
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
> 
>  drivers/vhost/scsi.c       |   8 ++
>  drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |   4 +
>  include/uapi/linux/vhost.h |  19 ++++
>  4 files changed, 192 insertions(+), 17 deletions(-)
> 
> -- 
> 2.45.0


