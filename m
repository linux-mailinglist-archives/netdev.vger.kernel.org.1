Return-Path: <netdev+bounces-134119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9499812C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591C91C26F63
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0041BC9EB;
	Thu, 10 Oct 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOdnz67X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380F33E1
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550544; cv=none; b=ZJZ4qJ+bH8buYqY2mAGnrZxc0ZjJnQcf/H0OZ/irKu0llHH4RlkeXu4WYsu5aeCCRLfyLhHhtLVpTF6/7h0Vbyeht8NI5eWxVCZ87zee+C3cUcLl+ZjnHZXmDfXm1UCvKfbZvIqlQt0UQdu0nXwuHS5UgvlSZdm4iEAQbUL+rqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550544; c=relaxed/simple;
	bh=tSnTNox3CzWuSmQyoYHbS4FBF9b95t8o1S5+OREF5mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB8xWVAEzFskp1JzHgcvn7IOdqX01UE8ZxL8++17Lngynl5+qBx3wg2KwPZv+epB0mFcACBRvhCiiKBgEIq1TCbjpCiO+bo0Ecuv1oIwOg6f/qSfiuuo+kanCUjUw/kC51wpRRft3oGxTTQUjqAtW+qVvqr99yf52fDCf1Y8wDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOdnz67X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHRb9hUP6jc++R3jZsGG9z5py87yImaghzrVpSjttVk=;
	b=QOdnz67XdRFWHtnr+bU/cu8tTgvaQery3agZEPQCq11PbkWwV+UsobSnSRhHkpEykaHtf1
	u6fmMCNY28EelalNofkmLznygg8KWNDnMyympqcXYMZQuTe/IfFLUWtJrIUNXb95OwlBcV
	Zraow8vg3W4wPjZBLlJxV/+xMJXHauU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-roZPA6amMDunl_Y8mktDXA-1; Thu, 10 Oct 2024 04:55:40 -0400
X-MC-Unique: roZPA6amMDunl_Y8mktDXA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fabc7ca031so3474101fa.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550539; x=1729155339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHRb9hUP6jc++R3jZsGG9z5py87yImaghzrVpSjttVk=;
        b=VrCHforsTo4gWWIq6gdcKcK7TDAgHdhCz+pocUXzHbtn1oHmiqNOgkaKgjp5phxNl1
         86XNMtstJYMHDZIaYgbuxeJ8SDklDy4fs01NnNPt/fTbTF3zo/95n+bRRFsmO47393eX
         vaLA1xgyd32Yt14IkAMQTHu/R4tJ69CwuFSXGlCl/43aLWx+AAn3OXTLjEItYyNPaJuH
         Jysf7rgOwBgJigd4NqR+Us4mtCKjb8bc8Kmm18Kx/EiPCM5Wa50PzzZ6cJa/p/txX40d
         CO098O4ZFVSYrxql1wYQAxuZSI6FRqJoPYUD0HMJCMUQcIDEzIdc35YStOaSdUvrqPXm
         jtGw==
X-Forwarded-Encrypted: i=1; AJvYcCW4XRImqmG9yNv0nPitRpfsQO+JaOr/YZ69rvzXrAwo96kQ8PC/QLmSL8oOkSNTqeejIExAwfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf19RQZkr1Su9xFRZIoC01WFTXAtTQOKrrDJN4fo10vMgK/n0r
	NP6+fQMUxTIQhXzQoOGKheqsvmdbyh8a5ur82fUf5e6a1ZkgsI55REhVPtCGdwFmguoKOj6cMSs
	EP3xDsDz7UWIm4WyznndthWeqsoS+0SRuqlUCUlQDIhZ20gI43cCpvA==
X-Received: by 2002:a05:651c:150a:b0:2f9:d0d1:6169 with SMTP id 38308e7fff4ca-2fb187bf032mr33415001fa.31.1728550539101;
        Thu, 10 Oct 2024 01:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFti7OuiFs5Tvc9xr2ngUrKycp5lREFia5dPySBqAPM+WAcYtqcaT4jy4YHH23QuPipbqDmLQ==
X-Received: by 2002:a05:651c:150a:b0:2f9:d0d1:6169 with SMTP id 38308e7fff4ca-2fb187bf032mr33414761fa.31.1728550538312;
        Thu, 10 Oct 2024 01:55:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937263299sm484495a12.77.2024.10.10.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:55:37 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:55:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fixes related to sockmap/sockhash
 redirection
Message-ID: <xkdl5nbabdrwsw3qcerd6rg2pljz6dysffgf4lviokr7wle36o@5z2how3eut2g>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>

On Wed, Oct 09, 2024 at 11:20:49PM GMT, Michal Luczaj wrote:
>Series consists of few fixes for issues uncovered while working on a BPF
>sockmap/sockhash redirection selftest.
>
>The last patch is more of a RFC clean up attempt. Patch claims that there's
>no functional change, but effectively it removes (never touched?) reference
>to sock_map_unhash().

I'm not an expert on BPF, so I reviewed only those that touch 
virtio-vsock.

I only have a doubt about another call to add, otherwise LGTM.

I think we should handle the two receive paths better, so in the future 
we should refactor the code a bit to avoid this difference. I'll try to 
take a look at it in the coming weeks, but for now let's get on with 
this series.

Thanks,
Stefano

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Michal Luczaj (4):
>      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
>      vsock: Update rx_bytes on read_skb()
>      vsock: Update msg_count on read_skb()
>      bpf, vsock: Drop static vsock_bpf_prot initialization
>
> include/net/sock.h                      |  5 +++++
> net/core/sock_map.c                     |  8 ++++++++
> net/vmw_vsock/virtio_transport_common.c | 14 +++++++++++---
> net/vmw_vsock/vsock_bpf.c               |  8 --------
> 4 files changed, 24 insertions(+), 11 deletions(-)
>---
>base-commit: 94e354adf6c210ce79827f5affb0cf69f380d181
>change-id: 20241009-vsock-fixes-for-redir-86707e1e8c04
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


