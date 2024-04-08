Return-Path: <netdev+bounces-85596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D889B89B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 09:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685231C220A4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FACF25619;
	Mon,  8 Apr 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1rwULxq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA72BB0A
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562006; cv=none; b=ODoIcoRd2Y/P+cXOOof9j7xJfWncN7u6p7sLfu272J9xCM+MaNKOT9PlEZLBh7BjpAghrCcqu+r5y+LKY5fyuieCVqDIVj/dzw5IsDY6y+PKwQe5tVIwO/Td1/yNaNyV1VLYVLJ9XhUueHnH32oaT7izaG1b/lFtj6NJ40bJcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562006; c=relaxed/simple;
	bh=rNOqKr343ZSMxime79iGUap0wNoYZSF/QDcsqxpgorI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpRP9K7DSbchWGiI+5+t/UlKwV9bhYhegdHt/ubqyYNLKOmEiW/VkrFR7FBUGFpbEjK/mGUM0so3cQaYXMXRnergO7ziUiEO1zumue/OeBst04rnPdyoAZv/viUqZ7hOVoOComogrZB5BElIjqYTUiUMkc03Lnm2GrHMThKxKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1rwULxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6c8NxRj9cq6OvbALtg2Roh5bDMfOSXXjT3FSUcwbEE=;
	b=a1rwULxqFcQwCqpBcZsds6r8LXPd19LLBsKy0FXpHNM1NJO+2nq/ououh88AQiioXnaPUL
	T08N9KgHbIXfDUsO6JvN3zVkzkjPOWlvKKBX6M+3WBErt+JyoMgvZ2FpTmrxQU6AL0G2S4
	bmKIqbgnoFxyZZo08LG/EUUC38z8+UI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-UDrYv6udP5mnt08IultdFA-1; Mon, 08 Apr 2024 03:40:01 -0400
X-MC-Unique: UDrYv6udP5mnt08IultdFA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516be44ea1dso3563055e87.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 00:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561999; x=1713166799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6c8NxRj9cq6OvbALtg2Roh5bDMfOSXXjT3FSUcwbEE=;
        b=vzBuAo8ZS7yXHJzunZ2Czf7AyWPqleXGDuOOxq40l0KLxZPiKtG6wBqMPjvdnRV7VF
         LmojVHmxF94vTAB/Lymx9ItHovzw0Kv3BkkhkfGjhUS7mnNClIDN++n7XfZ+4NzJXTQr
         S0gFd3ZDXL2eTd4XDbiMchuPIGo8aifNRKIcjC3BB25uvkzA1hEroRS1TE8HgjDXQBXe
         v1gFmfefxRfviqlYmBf4OOG7+ypUvMRguMKJVAAqPvRmLXce3XCsEW04zm4oQ8ds5327
         Ar9APOjrwdRYxy3Y4oC3Sb0mn2SZolaLchk6Um+ZlFwIgORDylsXjvZx0H0Q3Jsv8tap
         O0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkEaIRRKIllWtTNyHfNSDZDRtScLLYmhqGIPLDM/V+GnrM9fGGsHA/WoG5L/B90aWAUS5Tmt10sFL2yEsKxaRapuPJs5h3
X-Gm-Message-State: AOJu0Yw8cVLy1cO2ussfiNSXkRYKlYPLVE0AiiiVGv8Tu3Tayo61bPTT
	Jm86o9GAKTP8wNrek1oGcHFO7Xrsme/b+JZnwMmiqE0aJH1c5vpE3NmDpMa+gZ8RZ9qe97LnsXG
	Us1A3Wfu2EocwwEmESANIS2sCICjJJD5yLrtVFJvXNxjmocxcUZ9TLf2xoDjkxg==
X-Received: by 2002:a05:6512:6c9:b0:516:c8e5:db35 with SMTP id u9-20020a05651206c900b00516c8e5db35mr6894125lff.18.1712561999178;
        Mon, 08 Apr 2024 00:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDBkJjgbRSv4emXcuf1/HTD8JQtEuPSUD5eeQ3QrlOhXQrKMs2KEWRXNbHyZBPzEseuHvbQ==
X-Received: by 2002:a05:6512:6c9:b0:516:c8e5:db35 with SMTP id u9-20020a05651206c900b00516c8e5db35mr6894089lff.18.1712561998195;
        Mon, 08 Apr 2024 00:39:58 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0033e7b05edf3sm8276904wrt.44.2024.04.08.00.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:39:57 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:39:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
Message-ID: <20240408033804-mutt-send-email-mst@kernel.org>
References: <20240404055635.316259-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404055635.316259-1-lulu@redhat.com>

On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..7faa83462e78 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnection works
> +------------------------------------
> +1. What is reconnection?
> +
> +   When the userspace application loads, it should establish a connection
> +   to the vduse kernel device. Sometimes,the userspace application exists,
> +   and we want to support its restart and connect to the kernel device again
> +
> +2. How can I support reconnection in a userspace application?
> +
> +2.1 During initialization, the userspace application should first verify the
> +    existence of the device "/dev/vduse/vduse_name".
> +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> +    If it exists, it means this is a reconnection, and we should goto step 2.3
> +
> +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +    /dev/vduse/control.
> +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.

Confused. Where is that allocation, in code?

Thanks!

> +2.3 Check if the information is suitable for reconnect
> +    If this is reconnection :
> +    Before attempting to reconnect, The userspace application needs to use the
> +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> +    to get the information from kernel.
> +    Please review the information and confirm if it is suitable to reconnect.
> +
> +2.4 Userspace application needs to mmap the memory to userspace
> +    The userspace application requires mapping one page for every vq. These pages
> +    should be used to save vq-related information during system running. Additionally,
> +    the application must define its own structure to store information for reconnection.
> +
> +2.5 Completed the initialization and running the application.
> +    While the application is running, it is important to store relevant information
> +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> +    get vq information, it's necessary to check whether it's a reconnection. If it is
> +    a reconnection, the vq-related information must be get from the mapped pages.
> +
> +2.6 When the Userspace application exits, it is necessary to unmap all the
> +    pages for reconnection
> -- 
> 2.43.0


