Return-Path: <netdev+bounces-176807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A357DA6C368
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1886117052E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D79225A20;
	Fri, 21 Mar 2025 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC490/WB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898C18FC75
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585830; cv=none; b=pdmW844JZG+yYEZsDQlP5HoEtBmMGcYjQN9pXOQZnd9P4Vcel7Z+TyoUA8KqUvAOLztwzQslkVIEQnCyEul5HHzrKWiq0hEJNGGRwm6DYclApWao1+MDl652nOBROGMKNr0kC66AUg6016RlPxCnlJUIBiLINv3T8fvo5lW/6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585830; c=relaxed/simple;
	bh=C5dSvFClHUK1mf991gzXd1Vn4vGKVld6B02AmFGbYzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe7njQQwojlI8ha/86CvlUYQptlwUr/R9qmcRXL8gJEmpLdD7YC1Ttj5u1ije1z5l8GfOrlJBjq3A0CTEijp1GBTQvB6Ke2LwXaYueksRN7X/hl4DC7G/YLekCr5vBVsTDrRLfGP1SuvMwTP1TakI+Z3z5qcS3vw8rHHbeRCv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC490/WB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742585827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QQC0oRuX+H1qRng4JbQdwL2Ntm0XtGldJhk0GkoAWw=;
	b=XC490/WBrBOJAgJuVozqmTFwvaVP7TpCTUxp+KDdJXTOPAa1GTwDpflh8pLPTsWNzRwNvU
	Fy6sTiL4ucT/nJqJgJchpfVW8kp283o7vqOGIgLpl1GflFjcSAy9XRd66ejLxMayXnwuRn
	9yzOYG90LK6o5q2YbpxneVwhfBaNt+k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-vwl0prUSNHC1y2_QgN1j6A-1; Fri, 21 Mar 2025 15:37:05 -0400
X-MC-Unique: vwl0prUSNHC1y2_QgN1j6A-1
X-Mimecast-MFC-AGG-ID: vwl0prUSNHC1y2_QgN1j6A_1742585825
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242f3fd213so34284145ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 12:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585825; x=1743190625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QQC0oRuX+H1qRng4JbQdwL2Ntm0XtGldJhk0GkoAWw=;
        b=pC5jN1d6lFoNVL563cFQao8f6KptYoDxKT9Raa/VbnsN3suYMNKchr9Qd4lL0yiaf2
         5YVG1x+1HDLWI7OuZRkw7lNKUpe1TP226Fbdvt0ZJqdhMqeU0Yv+N6lTcG9YD89krAWJ
         cI0KOi4+5LEyKUURQ2DYW9qHAaeTq+UnNv7XC+jZNchzcnW5SORFUKZ4TtBcIkjUuK8M
         dnxGtWU1ZAKeiI/Qve0tfuZ33uPfXsjNMDejJMJ86BVpmctlCE+OQfXhgZEtp0qWbRkU
         c+v9aDV4SerUgRsUYcPgmrenjGEeTeZj94B5H0+FWzg6fUIt2wqBagY7pTo8BQ+pLXZp
         Ctxw==
X-Forwarded-Encrypted: i=1; AJvYcCXddqPg19ThhxTNuI/19gS5pYCRMJFxCNeyQ92YfabQJTw1DUDl0mQkvmMtJ1G3R458j3wnovM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLWCyBNHax+XmFI+4KOA3Ov1vVnwLNPiTn6hkDVjedDJWQxFT
	sBKaUpljNTl8aEUwDPzwqVnpu3sRupUvbH1AeYa/4mt5QH6F1Z9NbERakj9+mkkwY+6g3tb1a0t
	h6C8/qUxsn7lbgW+JMNujeiNerETF4ytaz2YD9QGSlgYT29vgX6yr2g==
X-Gm-Gg: ASbGncv4RKNMBtg4l1XUfXrpUdJlE0LxRZPl0fnFjYt1fUaO0+u67VLi077uLIdxrcm
	yh7bXb8IKgxP84zfvJRkwWT24xWb2XhFyLCn2mnm21Chv6C+E5NkmPmZR9wJR8sfug8swJBtsIr
	bWjd+zlW9fbkrCjsl1mflBcn6c7+OSv3x93DmWaRyIMa0m4lvnMxO3WDoo3InfuM7cfmMqnpbv8
	8PxOA8OFovEir/biTnye5t6kQ0zIG1hvWx7WpsQ8K9FAPUPQSnZUJfbhHqWT4WQzdFcGkz1sOpu
	NUH6grs7
X-Received: by 2002:a05:6a00:398d:b0:736:b402:533a with SMTP id d2e1a72fcca58-7390593b622mr6060486b3a.1.1742585824594;
        Fri, 21 Mar 2025 12:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEowWUXagoZIoweCvQRfmtjqA/SNMQoj6gAyfhHZS9vDb6q+jhLEaKJ62zuuxrIuV9JfDVSgQ==
X-Received: by 2002:a05:6a00:398d:b0:736:b402:533a with SMTP id d2e1a72fcca58-7390593b622mr6060440b3a.1.1742585823983;
        Fri, 21 Mar 2025 12:37:03 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c72sm2500514b3a.59.2025.03.21.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:37:03 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:36:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 0/8] vhost: Add support of kthread API
Message-ID: <20250321153611-mutt-send-email-mst@kernel.org>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>

On Sun, Mar 02, 2025 at 10:32:02PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API. 
> 
> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode.

This seems to be on top of an old tree.
Can you rebase pls?

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
>  5. reset the value of inherit_owner in vhost_dev_reset_owner s.
>  
> Changelog v7: 
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops and add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>   
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (8):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Introduce vhost_worker_ops in vhost_worker
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: uapi to control task mode (owner vs kthread)
>   vhost: Add check for inherit_owner status
>   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
> 
>  drivers/vhost/Kconfig      |  15 +++
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  21 ++++
>  include/uapi/linux/vhost.h |  15 +++
>  4 files changed, 259 insertions(+), 19 deletions(-)
> 
> -- 
> 2.45.0


