Return-Path: <netdev+bounces-207470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C3B077B0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E902584238
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8D21FF33;
	Wed, 16 Jul 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOuGef5W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F42F2E
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675183; cv=none; b=GHtsyWWIiaTm7BjeLhAPAzVVJzAOihCRbMmBBBrziBxTJZ2soTf308TW44wWXKAjElqadao7r4FeQ+/y+u71NC33ziVIKId9r+pRZxB8YAmw1pGcDjeF1vjyNtG0A9h0JneQv4n/Ed864j+djh/U8ocd8gNPpGkRB4gNm6KIbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675183; c=relaxed/simple;
	bh=1UuX6szgOmOAGr0EFSUNwfsGrhCajPIIWCzDM/8ZdDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYaQ7EiG1F/QrtlEv3Ih+8NTugx8/4KGV4z4ijoYzqwu3iwQoVnZ9oVzTR33yY1AHlGSH2HUoNRsTooe2OL1lEH3GuQra6PYVQKK0GBhElCX1eqCZ8cLZlaS1pTO/s4Xto37m4duPPUBWM6yYWshRZnFPcFjdjPeJnwXGD696GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOuGef5W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752675179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3kQObBm2VhsuQ4Br5dn7g/NxqBvEUCwsbnrpjwtiTk=;
	b=ZOuGef5WJYkKzUCuIxqEROoJE+bGteCntTd0yewDTTo9ThvvWefUzASX0arzvbCebTwabB
	h2JClUNRNas2ks1fVT75GXVG2b6L6XhUHf8LD5C2GRq3/9Nr00EEQ6VmenhHZxHbphGPO9
	9H1hk3lO8n5KjH/yrdkQtnqUaYmYdUM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-0CaxSKs2PwmF0o46jeqkAw-1; Wed, 16 Jul 2025 10:12:57 -0400
X-MC-Unique: 0CaxSKs2PwmF0o46jeqkAw-1
X-Mimecast-MFC-AGG-ID: 0CaxSKs2PwmF0o46jeqkAw_1752675176
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso3866909f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675176; x=1753279976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3kQObBm2VhsuQ4Br5dn7g/NxqBvEUCwsbnrpjwtiTk=;
        b=hX+xW850XQfXQtAtz5yYQo7XoRVTqOhHvVLB/onm+KYGnkW+H8qAohn8n/7Cv/FKOR
         x7qql/Xr7XwwMCd7xdIjvRTq8lraziHqTlP9nztxRDJTmt8RQ+YWkqwGjJrvlFN7ZNq7
         kD9wSwXrIJF4NWqRcOn0wUSDSBCBrITU/kbM8FX+/U8dbQN4kN2LN+XTlaBiMKvoYocE
         6OMzc9+zUS7+2yboBAYlzee+5S0UGG4NEDGdWUr1smlnCCzcgn39I1yS3gH4wS0Fp5jN
         PdiUWb6lO02qibooUttZn7HGxoLmQxBOvudYoTUr4PTs3WIxOsWnqPyabef7apVnVunU
         NFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLXmIBzM1wRJde21MIIfuuwyfS8LG47JK7bpGgGewkDBT3QCDyPuYSMrMjvffXQL43jgiZjbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmjeoc+sNenQGJAIre+77qR4v4vnSEPX8cjPFaBqoJdaREp52W
	9Q9+Eek3EDbNRPeSwAbFoqBjxd8EBjjE//gvAbMbBBQnZbmezVp3yYH0iiZHjAZxuFRJobL/sC/
	7xb+oys2g7lQaDQHzfOheZh4DnNfEnerhHdCuhY243tzzKrgY91J9G2chXA==
X-Gm-Gg: ASbGncu+dStQQr0pJyQXSkJ2BWrJIFNoqafKg75FuzFW4wlA3SMgDXZlUhHbtcYmFz8
	qH6sFTibB9qLxHWGyFtg31w9dWCXjLZlrWCom7HzGRmOh/e22zkbMoumO71mYDPGmf/dufXCmwx
	GwPVD/zWuJT1TUF6bszYJeb8oAIVSCxE+/+zS+iPOO201Akly9QLlqbRDySvjRrYTACc8l1DsuW
	gxOCGQRqHPueKsSxORs1XBmbmlJnRyv6blHZ6KYc6FhuWm5Mf+xqqoRMB7aC358y3Q9jiRlLK4v
	DEnutatGjd6E2ojTbbiHrM5dAzN47ko/
X-Received: by 2002:a05:6000:64b:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3b60dd4f79dmr2927574f8f.16.1752675175565;
        Wed, 16 Jul 2025 07:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcTQHmFkdo4qKszITkM/hDotRfA4R+XuTHN+mNxyUn7y3tAOgVhUvnmBHW+D+Oz3dz00ArzA==
X-Received: by 2002:a05:6000:64b:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3b60dd4f79dmr2927547f8f.16.1752675175042;
        Wed, 16 Jul 2025 07:12:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600a39281sm10296194f8f.73.2025.07.16.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:12:54 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:12:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v13 0/1]vhost: Add support of kthread API
Message-ID: <20250716101152-mutt-send-email-mst@kernel.org>
References: <20250714071333.59794-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714071333.59794-1-lulu@redhat.com>

On Mon, Jul 14, 2025 at 03:12:31PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API. 
> 
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
>  5. reset the value of inherit_owner in vhost_dev_reset_owner.
>  
> Changelog v7: 
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops and add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>  
> Changelog v8: 
>  1. Rebased on the latest kernel
>  2. Address some other comments 
>  
> Changelog v9:
>  1. Rebased on the latest kernel. 
>  2. Squashed patches 6‑7. 
>  3. Squashed patches 2‑4. 
>  4. Minor fixes in commit log
>  
>  
> Changelog v10:
>  1.Add support for the module_param.
>  2.Squash patches 3 and 4.
>  3.Make minor fixes in the commit log.
>  4.Fix the mismatched tabs in Kconfig.
>  5.Rebase on the latest kernel.
> 
> Changelog v11:
>  1.make the module_param under Kconfig
>  2.Make minor fixes in the commit log.
>  3.change the name inherit_owner to fork_owner
>  4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
>  5.Rebase on the latest kernel
> 
> Changelog v12:
> 1.Squash all patches to 1.
> 2.Add define for task mode and kthread mode
> 3.Address some other comments
> 4.Rebase on the latest kernel
> 
> Changelog v13:
>  1.enable the kconfig by default
>  2.Rebase on the latest kernel
>       
> Tested with QEMU with kthread mode/task mode/kthread+task mode


I applied this, thanks! But I've rewritten the commit log.
Pls take a look - commit log must include the motivation,
and be written in the imperative mood.

Thanks again!


> Cindy Lu (1):
>   vhost: Reintroduces support of kthread API and adds mode selection
> 
>  drivers/vhost/Kconfig      |  18 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 295 insertions(+), 18 deletions(-)
> 
> -- 
> 2.45.0


