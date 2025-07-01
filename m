Return-Path: <netdev+bounces-202844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA7AEF53F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EFC7A3AAA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12F26F477;
	Tue,  1 Jul 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg3kZWqr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9092356C6
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366252; cv=none; b=TJOxlNLouNHcX7fx9WniBShPyo7vLcRR08LWjsXA1AxncUPgmBucELFnFr0WwY26CS0yhN1PYdPdHmmXUHUltxLTCGaCgwzov7kKGPgMN56DuZiNyZUpkXpXCIExIggMn84iuUAk+ij9Jg+VASDKrG85vEAiz+Od63vC2VopVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366252; c=relaxed/simple;
	bh=heXSovKMp8WMZ4/NmKFQEomaA05X7Vw0t+hCl43nhvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBttfq2HYxoG+GpkgXQ25XhyJwj+12wJtkp3eW4SWl2T6Nk8SxVKjMfDB7X+Bj9XsFfprQZkEAnc3t1ct3AEdt/NJFR38PXXLGKcB/7W1AD5M9PCaezIZ8RsRtaHs2oW6UfZYbhRFK6yD59hyXZZx0LUvzDiEl6ASMtGQiCwqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bg3kZWqr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751366249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2ir46AUDqqNyeG2en8npeW9OEH0djU5Wi0RBd8xUlA=;
	b=Bg3kZWqrGMOkDohS2MVzZHxtsKyyqExL6zEhzvzELiCI+wUmUWsRqFqVGGG9lWMdm1Si6S
	Vqzb+N7/MuVWfBe5WTyimxIoMkzW7O0tHflqmj265QfhOVnr4SPOCs3gZqeSjcfCKlub6k
	yPC8ARjVy5+OzjPJLWTogNak1AmTeQA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-r5XpKKadMQCBPFnFJjpEFg-1; Tue, 01 Jul 2025 06:37:28 -0400
X-MC-Unique: r5XpKKadMQCBPFnFJjpEFg-1
X-Mimecast-MFC-AGG-ID: r5XpKKadMQCBPFnFJjpEFg_1751366248
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-60d60b8ef64so2348089eaf.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 03:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366248; x=1751971048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2ir46AUDqqNyeG2en8npeW9OEH0djU5Wi0RBd8xUlA=;
        b=hiPOYSPCbAnisakAiLBCUi1Ib/Td+tOui1+ojDgne8GQjI5YhYni2pXu0t/PuHe0ZQ
         Ef4V2KyqJSO11r/WMYke+2AR9mlavmcxeIEpmSxhS9C/bXgPoWq82ZLI9ZO4dFPKvyPp
         5nXqBEzLs0LNVhCV5C4bTua1GsImpEhqL0KhtS7pRREGY1NahQZ3ANmjcQagtriXUzoV
         ZDc038hFGExFW/XPCPwFHAassImVTR+LkG9DMrw+jQLz8YlHl1rq2kHK4rW/ulkNtaw2
         Rdey8UBZ/fzJvTaws+T/I3jVlfUFkfmqMTty+zntjNSooiOUb1Tcwa9z4lGSV+qvBBjR
         cXtA==
X-Forwarded-Encrypted: i=1; AJvYcCXUxAo09WFIwmbQd1OpLGN3WUqQDcnLaRLh2DxjT2bp8XwMED/1BLRfwlBwd4zeGGfAGhKhWKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdxMMP3hDZiHYwb+33GF/Ay3n1ytRjPPCQbTju8LyrDDgHc4C
	uiIY2+xLlgeV65txwOIOAdVe1lXPfEyckrwHZhBd0Vl9OZTmidGE0jQTyiEdrF9zR6uR+U9/4Gi
	adcjuCLPjKViNwCBbdS/4zfnCZ9gQxYqTDtD3AxDGl7b/VZ6g3ANtGgpTqQ==
X-Gm-Gg: ASbGncvUwtkJtau52Ng7igubCXEPpigQwCz+M9vgdRZX309ICklonFcPlKsAjMcEhxJ
	pBuxP+vIzyBVlCIGXX6lYrayqD3vGwAZKMsLphkemnZbHjUzqkaSRm3RvlANvVv3Htg0H+E9Ud/
	Z7urUb682TcleRkp/MhLQHzMF14LMdz4ksWrUAiTZSHER+ddHZsz1v9mZfYNZ2oBusLWmOdDDzo
	15pZIXTSobFEwsObG+WLFNNSPnuvxzbCY4upJN6IuGRFljeVnLx9d6SC2j3XNUv6FIc28afOWTK
	DVpwY/NZOCeEc3w2IaMztpedmeKh
X-Received: by 2002:a05:6830:4d87:b0:731:cac7:364e with SMTP id 46e09a7af769-73afc63c25dmr9915275a34.22.1751366247250;
        Tue, 01 Jul 2025 03:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyVKJMDrLHZZIEx6Kk38/Nas6gM9Ud+smX4Ebygc9Zz6lBqLLrkX5YBPiqMFvYh1w2+bHAbw==
X-Received: by 2002:a05:6830:4d87:b0:731:cac7:364e with SMTP id 46e09a7af769-73afc63c25dmr9915263a34.22.1751366246892;
        Tue, 01 Jul 2025 03:37:26 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb107871sm2055408a34.58.2025.07.01.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:37:26 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:37:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Message-ID: <njwfflmq7swifmc5gwbovtju4bg2zg4cibpichtjhlkqkprvtb@5r5giy2irbzd>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-2-will@kernel.org>
 <7byn5byoqlpcebhahnkpln3o2w2es2ae3jpzocffkni3mfhcd5@b5hfo66jn64o>
 <aGKIO8yqBSxXZrE2@willie-the-truck>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aGKIO8yqBSxXZrE2@willie-the-truck>

On Mon, Jun 30, 2025 at 01:51:07PM +0100, Will Deacon wrote:
>On Fri, Jun 27, 2025 at 12:36:46PM +0200, Stefano Garzarella wrote:
>> On Wed, Jun 25, 2025 at 02:15:39PM +0100, Will Deacon wrote:
>> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>> > this is only checked once the SKB has been allocated and, if the length
>> > in the packet header is zero, the SKB may not be freed immediately.
>> >
>> > Hoist the size check before the SKB allocation so that an iovec larger
>> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>> > outright. The subsequent check on the length field in the header can
>> > then simply check that the allocated SKB is indeed large enough to hold
>> > the packet.
>>
>> LGTM, but should we consider this as stable material adding a Fixes tag?
>
>Yup, absolutely. I put it first so that it can be backported easily but,
>for some reason, I thought networking didn't CC stable. I have no idea
>_why_ I thought that, so I'll add it (and a Fixes: line) for v2!

yeah, this was the case till last year IIRC, but we always used Fixes 
tag, also if we didn't cc stable.

>
>That seems to be:
>
>  Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>
>from what I can tell.

I think so!

Thanks,
Stefano


