Return-Path: <netdev+bounces-196819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A58AD67E1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52D91898062
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737C1EFF9F;
	Thu, 12 Jun 2025 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6jP4ys+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CC1E2858
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709251; cv=none; b=ub4uixqSMx1QNcBDFWzLyPmho0k7+7NHSLFzlK/8MUqoCo9ewj8UgpjnjzyH1qdgkFUmfIFFmMbyKnuErrZDP+g7T3re4IASvYhZVUSRzcahuu/DHD6EMzsOg4Wbj6XM7mAxcxZM4ZGONWKXGJq4tAocgF3LqolWlC6zL4G7pDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709251; c=relaxed/simple;
	bh=UjKVWN7uen5QtJlj47WJo7MSZiaiu10pJfZXyVbBjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/joIb1xew4yxP081NE1oAi4YhpoLpmF7XkrwULGxxAnbI3RsBAt6oWlJ6VPhcnrD3XMLSIoPsyZKxtqxAyoMw5+NTWIl3FvKsFMVGOYQntynRXKMcfyeqEWlIkeHJqXmNPUwa1zsOFLmSI2h3mB8MqpkdbMBeKS+3BSF1xVuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6jP4ys+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749709248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piaS+IvVA5BU5uoyHWio7NQXE3J6rbJilCTVKgCGvkw=;
	b=P6jP4ys+6gIC3IlQYdi0Q+lZt1KSYRvfyPSV/xkauWwIDVwKQA9wyrHWsJZB7sqDZQgMuD
	1pAI8GkDIuBcdekR9zjrrm6QokJ0IBmi6rTvo73KmAQIYVtoW1/3yKAy84YEWEdAc/+pSC
	anflRjtTlXELSvEBGRsOVB8zLunEgZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-6Ybg3N-iP0uJ5EI7s1W_Uw-1; Thu, 12 Jun 2025 02:20:46 -0400
X-MC-Unique: 6Ybg3N-iP0uJ5EI7s1W_Uw-1
X-Mimecast-MFC-AGG-ID: 6Ybg3N-iP0uJ5EI7s1W_Uw_1749709245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f8fd1856so245972f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 23:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749709245; x=1750314045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piaS+IvVA5BU5uoyHWio7NQXE3J6rbJilCTVKgCGvkw=;
        b=OwsgwOJkSuiGUvh/5mZ+Vo+TuC5CWo5jTM45relclJQ4PdabZ+r4RAK+Jyci1D9fTH
         7MHHdre63SIcrYScC5Y/jdg0R0vBR08PEirl1rCBNUNfTnphlwh/wONcm8vn8J9ChGeU
         fwQN/Htz4/+3Kla1fVBtRn7tiauftUkEIHEOkO0YubYYNLvfUenk96pKae2K8Pf0+jtZ
         +VgS8Hs2n2qr4hAFPmnpSSUYzJIGpFNcMA1EpkCiAzUzYZIOgIFFL+e4/a7HktkxKLg0
         U7o+LTDbRE3rliou6zCNpSQfjPUgDTiuJDGWTp143lMZ7BVgvyjBqClJw6To87yaVHyf
         lmHg==
X-Forwarded-Encrypted: i=1; AJvYcCUrBx7VWCKwpB+guY+lHEzfel/Ja2DQDqhHw125fHujnMymkgP+66FzTxKh53lg7KImIAe1QxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAER7WoLAWn4wPMm1B2kTAl+WoVtmIFVBKnZ1HmEiQ8jGuZlNx
	4ck6RQTv5BjTEmpmBEdnyNb+Dg8C3DlDIDeF0QpzRXmpeJQZsa4m0E7U4QxHUChzjiz0aACzpKi
	QylRF4zZb5Y+po7nwkNBTH/OxFAc4+9s3GhD5QHLMv4mYj8dJQE1vT13tzw==
X-Gm-Gg: ASbGncsX1of5oaVsWUSLFUiqUJyrX2QCQcIYRkR504tL6Qwma5nGm2JxviGT3OufY6L
	zgmvTD9M5UTukYXAns7B9kHInMB59HoMuo30cutCssVe+YTWVadH92k49KEIo1jC3HvdjqGYxGt
	WzT9RupsMBhGFS+Rr0J4prnoerkYVkz1OzBbJc12pagnN2Xs0Om9vhgzVDDeV9V94Qgtf7mLnLQ
	ycf4VsbG+eNHHaf0OwNjlepFv697UkWJ5Uazc+kguamQeHyUJxIl1LAkybpI0G2dXBvAbAh/BIB
	7ms9Q09jhu5iiNkx
X-Received: by 2002:a05:6000:2210:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3a561309d4bmr1368860f8f.15.1749709244942;
        Wed, 11 Jun 2025 23:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2RtRKGSbUvUXqFG5RCVEOgWfBzpJ3ZXPuVL/rUgYKBarLIkU9OJETs4KF/dDE8YU6wvHsPw==
X-Received: by 2002:a05:6000:2210:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3a561309d4bmr1368835f8f.15.1749709244571;
        Wed, 11 Jun 2025 23:20:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56198a3b4sm980497f8f.21.2025.06.11.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:20:44 -0700 (PDT)
Date: Thu, 12 Jun 2025 02:20:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v11 0/3] vhost: Add support of kthread API
Message-ID: <20250612022012-mutt-send-email-mst@kernel.org>
References: <20250609073430.442159-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609073430.442159-1-lulu@redhat.com>

On Mon, Jun 09, 2025 at 03:33:06PM +0800, Cindy Lu wrote:
> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode.


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
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (3):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: Add configuration controls for vhost worker's mode


All of this should be squashed in a single patch.

> 
>  drivers/vhost/Kconfig      |  17 +++
>  drivers/vhost/vhost.c      | 234 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  25 ++++
>  4 files changed, 280 insertions(+), 18 deletions(-)
> 
> -- 
> 2.45.0


