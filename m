Return-Path: <netdev+bounces-169204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B8A42F5C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C4C18966B7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D11DE2A1;
	Mon, 24 Feb 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlsEwGfx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C31C8630
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433392; cv=none; b=eSOUAWCQAmFkzltGO0ZfWdXkuAeKA5uHex0i0gbDt+4oRcgXxgJXGk84LGvCFcAKLNGiFsfvSWLMresqoaeDHquQjQgDu/DW/HeRA9petpJODfWvTZsrbO5BrPZae7cdj6/F2QcTQf02TqfeLhuyfnvER5pVl2bGZVWH0Fkina0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433392; c=relaxed/simple;
	bh=rGCaM38jYnJVXBwmgw8Sh7VmVvIrDfJq+EHfQSyCLRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IClsJw3IF0thEuumjkKEnMqgIy0zbkvUh+ImCgMCXPrnSeUPzo/am/oPMRSvUE1y+EZpCg16F1G8e5xa85MkgcaSKEBiSZ99mT+ViVkM/8XP1wc+3u1L6QhKzfhuRyk2crT7HV4mjF7W6sIxPQXO/bM3/kuFBiVz+jXIFQIqUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlsEwGfx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRvlyIwfIErpAyFrGoq863D4eRcM+k3YszciGmJ1mwo=;
	b=UlsEwGfx0P6BfJrnof8mG5mFQQRWFELak9NgzsuG+wkCuMrNEvNhmB8wesjZMQ0E37SKv4
	jSyRn+xyVAja/RaAXfjO8I2azB0iZZZ6d8/eaxeLWGHMnp8ZJrCCemzAmzed1+zB5q5D0F
	/M0+P7kH0ykyCy0mHED/eFidEo3L8lM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-6gMcxVjMO1qXzm1EaehYpg-1; Mon, 24 Feb 2025 16:43:08 -0500
X-MC-Unique: 6gMcxVjMO1qXzm1EaehYpg-1
X-Mimecast-MFC-AGG-ID: 6gMcxVjMO1qXzm1EaehYpg_1740433388
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb9962ebe5so450595266b.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433387; x=1741038187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRvlyIwfIErpAyFrGoq863D4eRcM+k3YszciGmJ1mwo=;
        b=sJOw011Kn5X2jQoDZ1VAQMhYpYe/DqFy3B2VMq+N0PXjZ0VzfzNdmzC6zz3ZHMVAAm
         bFlEvnn4PXsfNE8dtdB/AiWEsbpOpb+Cu/aUKgoOyLEshHepW3s5wx+1Ty2GapzbBJ+o
         eoY5FlEdE19vv9G7hKvVgOFPhnrs/awSweD1XozKv6LOPvnxLaokNCr31sSUnRuvfgoD
         BWwwvYnh/xsETt2f4E5RwfzHmM223Ulb/Pk0U9uAH10knOZlTtB2ArpbRiqNvc4WxeQx
         0LfxWx1/pl8G/5CsAIu4lOlmjHECnmaJAjfrAOWtOjP4OdCBh/oT7ttzr1ejdE3u7rXu
         IwgA==
X-Forwarded-Encrypted: i=1; AJvYcCUlILl4VVDY0E+Qyl7TOHd3Z8Dkli8fL/ORyh8AcXkHoShb59QXdTNVmtTHql1ZeKyClFY7Ra0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dOoEQCzt3V6GLEhfsiGWA6/KBLTkfabin/3mq+mfEs3mz9jr
	qYlH8diZi9aNHlKtnav0x/4CFxiRWr/piSPjjQBxKn76HgWewv4fMalp1Gixi/5IlU+GTTdboJJ
	9CUQM/SjJiAAy4WXnB7ZIUKYV2ESUOk0augs30oJ9zF1qt5BbXtUhVw==
X-Gm-Gg: ASbGnctu2TYhb1VwyV/Pvf516YMCKfF7lVqvlkwrWDkqAxQtsWgFzh/5dFhOv7pdWCB
	Pc2sA441Th4rDBb6f+OryGql+oq1Uu3EnXfAL/5VYH/Io+KlbvIwIQF7/1884aEqKNQFXli5BVg
	x+p21WgutqNw5zup6+YCV0SInJTZ3ABW1D7SGMzaFQMPdQhyu2U7T79eYmQiiiUcNPoGz2D5C31
	B1+7WrRSez6qhqCEynbbuzz+1ZAvdOAQzm6utJ+U3LpxQVlQ+N+NNQml7/stgOJd2DmM00cvNA6
	J5riJ98iag==
X-Received: by 2002:a05:6402:2684:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e44a256c8dmr1414777a12.25.1740433387665;
        Mon, 24 Feb 2025 13:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFggkY3qckFwg+3BfU9CiVPo7fKtfcLRWbW/4aTirrRH/YEvcpVLH1Iwi+Ay7RISwY3EepFrw==
X-Received: by 2002:a05:6402:2684:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e44a256c8dmr1414733a12.25.1740433387287;
        Mon, 24 Feb 2025 13:43:07 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1a01648sm29278766b.0.2025.02.24.13.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:43:06 -0800 (PST)
Date: Mon, 24 Feb 2025 16:43:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
Message-ID: <20250224164233-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>

On Sun, Feb 23, 2025 at 11:36:15PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API.  


This looks good to me.

Pls address Jason's comments and add a Kconfig knob, and I will apply/

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
> Changelog v6: 
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner  
>  
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: introduce worker ops to support multiple thread models
>   vhost: Add new UAPI to support change to task mode
>   vhost: Add check for inherit_owner status
> 
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  13 +++
>  include/uapi/linux/vhost.h |  18 +++
>  3 files changed, 234 insertions(+), 24 deletions(-)
> 
> -- 
> 2.45.0


