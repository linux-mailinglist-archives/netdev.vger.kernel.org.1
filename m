Return-Path: <netdev+bounces-83223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6BD891654
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA4B21C93
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994E4879E;
	Fri, 29 Mar 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbhIGJsd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E33BBDB
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705922; cv=none; b=FwJp6CnbjRbHV/3LOCjKnYIuKodKOG2LVakcxSosmblENMUJL2xoEGCJFCKHI4/1ZODBBAIzxe7zykPzBdUjZfnGaEa4C7W36OcNYEukRkPNf1d5x6C3VmKEyvVmTA6IlO7ZkRLpQFvpdpXtOzpC2hnPpGJ15jVTnLLpEgGZrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705922; c=relaxed/simple;
	bh=djiaB4U2ZnOlHE7cFPb+RDg52bCNsVSynx5YnvVL9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0zuJnj7MQQ8kG/rCRa9VJCHw5i4GQwPBTNWmAbq3N5beyigM8Nij0BlGaULZGkr76Y4RW1gKUKZumHRdULqbhtIqEwMi/su6SHDbPjhNYtwVOPQ7MH8HPSEiCZQAE/6eep8VBR/NiqijpLNqwG4Lv0mlKRSsVa9X8u1/J0AMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbhIGJsd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711705919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deMJ3oVnouvBFi4X5/gthJT9K+f+3N94offCvLJPHoE=;
	b=hbhIGJsdvicAvRAi3SyFXzUs2IlUkOega50wgVMGjX7auZgpZ4FoZK8rJbJ++/IUz9vl85
	jvc1vDNutnqMXBY120mfkXBuQMyJVyHb63rO+2kNzV0KJrVxgPZ5m48guKs5+EO0SpNNNp
	dYyCOZUr3hdw+x7TQEy2yLoa8D6CVPk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-73foU2XyO7-iVdhjuYxZQQ-1; Fri, 29 Mar 2024 05:51:56 -0400
X-MC-Unique: 73foU2XyO7-iVdhjuYxZQQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-513dda67cbeso1618466e87.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 02:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705914; x=1712310714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deMJ3oVnouvBFi4X5/gthJT9K+f+3N94offCvLJPHoE=;
        b=mCYMLcACRknj9YJlO8Dt0skCqzrdCF4hLbnlbYIj83sfL9f85iIvTg611i8pEkq74d
         CunJDcTusBRcffiJhLQS1Kwvgaid5IOtqX5yA+avbe72g0akudIxCLDgSCpDIg+RQHCn
         xtDUAWZFbK1pTzJrEqkunEvsmF2nr4K4BxClJviZT0T80UHsZTVLVCZLlBKuAH90alq1
         Nt9kdgNJQ0tB+NXQrCxaUDQeI6cThGe8eX3fw0Y0EX8Qf6pkySC+JNqoon+yyflCjSXP
         hbeD7T6DwbhodRhFPW51Zdk4hG0Efw+j9+QcDeB91uA+isscweb6vVXWCz4H5YuawQxI
         zSvg==
X-Forwarded-Encrypted: i=1; AJvYcCWfG0b00d+7dPJaN5+eUj4KA/aQF7f5eMhm3ZV44f2zL1Iv+zhcnMlMMAvleR0ubJRAuKMxyncdho8K/HZ7yFForxjodOWF
X-Gm-Message-State: AOJu0YwRLG4GIoBskV8tOqrwAWoSINDekrT24rQEeRcWvDKU2jgyqUW0
	vIb77tZjaczXzqZTkX98dWAX2KVe/S1SHp2PW92Mp1ea84Khb8kms+5oXM6G5FZAHtEx/aiWHdr
	D0zuReZuf+uAsrHNqBhdm5R7gEK5WL4vNd9i/QV4V2BuQ7P7gHKryew==
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id c14-20020ac2414e000000b00512cc50c3e0mr1283297lfi.52.1711705914343;
        Fri, 29 Mar 2024 02:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCIBkxIKVbMHIoPNaKtpwlibzeDnCCEzGl88sYaXjP+u7tE0mYtwUWm3GQccH/hMA1lWuvA==
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id c14-20020ac2414e000000b00512cc50c3e0mr1283273lfi.52.1711705913698;
        Fri, 29 Mar 2024 02:51:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d4acd000000b00341e5f487casm3782337wrs.46.2024.03.29.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:51:53 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:51:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add reconnect process for VDUSE
Message-ID: <20240329054845-mutt-send-email-mst@kernel.org>
References: <20240329093832.140690-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329093832.140690-1-lulu@redhat.com>

On Fri, Mar 29, 2024 at 05:38:25PM +0800, Cindy Lu wrote:
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..f903aed714d1 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnectoin works

typo

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
> +
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


I don't get it. So this is just a way for the application to allocate
memory? Why do we need this new way to do it?
Why not just mmap a file anywhere at all?


> +2.6 When the Userspace application exits, it is necessary to unmap all the
> +    pages for reconnection
> -- 
> 2.43.0


