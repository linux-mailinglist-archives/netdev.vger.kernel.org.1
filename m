Return-Path: <netdev+bounces-150783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EEE9EB8AE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F581888D97
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BF1AA786;
	Tue, 10 Dec 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJaqSrYy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798711AAA1C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853129; cv=none; b=qRqxGBICTmOmS7oaJmFI/JIa5tHqZVTrL4gGNwpBXw1NEVsUyZkjG8y/r6UNqiGjFgbidrNrkdcNGaD8tFrR0f0JYsuUQG7o0rjoANrrqGT3CYN4FhrUYvpBba6Tn7Tayrg3eS8vstuD/Olt8oAH6L6v8vrUD3ALSHfcHL3+3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853129; c=relaxed/simple;
	bh=q9A16Y6kO4s41vmJMGS854yDLlp9NiUZZ2qJ/TT+EKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM6/AzpeXpJAhHTgcBKPZLT0/KckUjL+ku7ACaVqTTBoE0wPWFeIVvo01/T8XcqfHhupts/w25jrxDgx+YXC+rkz5wC5NnxWCMWupHcuQme4V/MR2TGkehjuI8B2gclGaOpyrJYbbSbsz83vDEAm45bO+fOBJ1hhpA2lWYAzD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJaqSrYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5z++hiDZoK6MQKlJqwcak2mnPX1FBIvWTnRgAgxRHwY=;
	b=eJaqSrYyp2Foq+sTIRsPU1J9YpZbFgWot1Y9m2sy30tRVK0FxffldwK+yeWl/1eSmEKkx7
	xzpNI00HgPd6EP173ccatIubHLhLoeTii+HY4YGZl9xwoQndZmYCj4KPpZu9okCY/bximg
	XA128FPPgR7l+WMkBeTBjK/KERVZmYc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-9Uh-nT2HNyOB420hO29B0w-1; Tue, 10 Dec 2024 12:52:05 -0500
X-MC-Unique: 9Uh-nT2HNyOB420hO29B0w-1
X-Mimecast-MFC-AGG-ID: 9Uh-nT2HNyOB420hO29B0w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f5b7b4a2so22880465e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853124; x=1734457924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z++hiDZoK6MQKlJqwcak2mnPX1FBIvWTnRgAgxRHwY=;
        b=eiWrWsJag41jytdwDhp30KP+mqoQ//ZYXTmF3Kj+qwW7Vhx2eKSo6a75DSzvgoItsY
         ooN1nBqnGIaRi7BQV8PkQ/fmqzQCKRphNg6Mhps3ulua8tWH4p91FCANKX///DBi5UsG
         +8qyIojvOKU/2L4TWy/4N2hjDmu9oJaC3Eb2VumlN1/wW/vkBAg/J7WJSrr+yKnw3gLG
         ouX6SDLjby6qO0yPAAIrSKPjR02zml5tCvCmz8jnImZ5pvQsvFLJXqKXhmFi1HDZy9WB
         0KxuAVXNHcgfFg2smvngrnOsqZ07ST1LJLsA1S9T/oKTJWoRwPmfCJRHj/YmOiOznyjs
         nm1g==
X-Forwarded-Encrypted: i=1; AJvYcCWs9xHoyz5QZKIsjlbOpYzNIO7bgyq0JY/VI3sxhTBicCY+z+yubAcWqCWaUMsLUa4k7jbUfVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVUHCAUMEX6aURglD8qI2yxHeEhNmll022iitXnTsU/e1DE8V
	zAOFUAf0T8YEnCaDsHaRH8JO4APpxBhFB7U/fFJkLjjFFJyAh4vmHpcBR7kB3nmZrKi3AyjVcw4
	N/3U7cIIS5O/a/7WEBOGITeBROzAK/6jaOxSIZnOYOJae9prraNsjJA==
X-Gm-Gg: ASbGnctRI865VujpD06OdOSJxjrHf+7mefYM8znUbf0G+EvIViw09q51uZqo00K97rP
	hTtHm/V9dy2cygMeLNBvz+D5InPQRnDCoYKwCJOMSz55KynZdQGCUM1ytwmjaG7nedmx8TKZeXP
	uttqAnRs/xsH+rIxKzQeR9j/A+THELmkP/khhe2PSZSkt+VBNPuLwcpCbc25sw4DKRKayubvz5S
	ZxdIbDyLBmws1R/QAkzuTYYvIB1eQPc2yhYnUs16UjCYezTeKyZ6AQwohjEJovAdHbfCodXQ788
	5CycEAy9BLCR4nSAD4aHr/qjAJfbgA==
X-Received: by 2002:a05:600c:358a:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-434fff500a4mr54092205e9.15.1733853123927;
        Tue, 10 Dec 2024 09:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWlVeLxQceZVqJYPqW9abSwCI92YZV60MOUnZJwqpD1i3FXk0/EecHfd0I1AsDffr0xedD9A==
X-Received: by 2002:a05:600c:358a:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-434fff500a4mr54091875e9.15.1733853123291;
        Tue, 10 Dec 2024 09:52:03 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436199f6896sm12564785e9.14.2024.12.10.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:02 -0800 (PST)
Date: Tue, 10 Dec 2024 18:51:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/8] vhost: Add support of kthread API
Message-ID: <wxfwmdn73heh5k7dnbaqt5iq23qwz4ltlapetvsqlryhz7mhpt@4e3pw5qm7yom>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:39AM +0800, Cindy Lu wrote:
>In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),

missing something here?

>
>The vhost now uses vhost_task and operates as a child of the owner thread.
>This aligns with containerization principles, But it has confused some legacy
>userspace applications. Therefore, we are reintroducing support
>for the kthread API.
>
>In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
>The vhost now use vhost_task and workers working as a child of the owner thread,
>which aligns with containerization principles. However, this change has caused
>confusion for some legacy userspace applications.
>Therefore, we are reintroducing support for the kthread API.

This paragraph seems duplicated.

If you have to resend a v5, recheck the cover for a moment because it's 
not easy to follow.

>
>In this patch,

s/patch/series

> a new User API is implemented to allow userspace applications to
>configure their request mode.
>
>Changelog v2:
> 1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
> 2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
>Changelog v3:
> 1. Change the module_param's name to inherit_owner_default, and the default value is true.
> 2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
> 3. device will have their own inherit_owner in struct vhost_dev
> 4. Address other comments
>
>Changelog v4:
> 1. remove the module_param, only keep the UAPI
> 2. remove the structure for task function; change to use the function pointer in vhost_worker
> 3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> 4. Address other comments
>
>Tested with QEMU with kthread mode/task mode/kthread+task mode

A link to QEMU patches will be nice.

>
>Cindy Lu (8):
>  vhost: Add a new parameter in vhost_dev to allow user select kthread
>  vhost: Add the vhost_worker to support kthread
>  vhost: Add the cgroup related function
>  vhost: Add kthread support in function vhost_worker_create
>  vhost: Add kthread support in function vhost_worker_queue()
>  vhost: Add kthread support in function vhost_worker_destroy()

What about merging patches 4, 5, 6 in a single patch?

Thanks,
Stefano

>  vhost: Add new UAPI to support change to task mode
>  vhost_scsi: Add check for inherit_owner status
>
> drivers/vhost/scsi.c       |   8 ++
> drivers/vhost/vhost.c      | 185 +++++++++++++++++++++++++++++++++----
> drivers/vhost/vhost.h      |   4 +
> include/uapi/linux/vhost.h |  18 ++++
> 4 files changed, 198 insertions(+), 17 deletions(-)
>
>-- 
>2.45.0
>


