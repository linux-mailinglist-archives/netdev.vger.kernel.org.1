Return-Path: <netdev+bounces-147703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A249A9DB493
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495ED166586
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1E1552FD;
	Thu, 28 Nov 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHB/6xj0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84B143C5D
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784906; cv=none; b=kotzKR3uBy+2wVRninDx2KD7mjGwqf/J5ZdlKqElJM26W8LVyU8JuU7blbCGtvo+vYZ3gGdf3zGK6pL9qS/J3O8oOgmscQ6tZbT716IhvcRG+VtF41xNiNQoDC1Is/pZaZQTRtdGjTftKEiS64PwHcJiNa98nIJnBxLTeb+/Yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784906; c=relaxed/simple;
	bh=dIngRyaba5lCy21XF8uirQt9gFufuGOE2O8GjXsDNy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu6hELRHU1Q1SMl0wLiRwhwrtT48JkteGLNFuG4qBlbjRkdJfiCqZcYMQOV5+uyAn4/peh3b2zIdl4aeA5HFcX2L/p0SsEyz+PgsWrdDj98orcUeJb8VEY1UZn6lSffsjvmE+YmLnDbCpua6+QK0i5hqwndviP6x7L42lr5PB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHB/6xj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732784902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd6Oy9o8pF7hYxCWd8kfvQGssh+yBV9f9FGrH23Nd4Q=;
	b=aHB/6xj0PR3jOvdENLvbJ7+KdyJDrC069SeSCYrnhpt7AWSq4jIsKPNEH2fgOkmHaTdH6c
	AavXBaUWd81xSaUhwKOnhoXi6tayIU5gI7haT/jiG46vx0jbj/JEYbgajkHIQQo3Zhv6Fx
	oYnxplXCu6yz+KdJhZ9EmzqLgr6j3rE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-rbYrwaqrOomLu62tvbNKmA-1; Thu, 28 Nov 2024 04:08:21 -0500
X-MC-Unique: rbYrwaqrOomLu62tvbNKmA-1
X-Mimecast-MFC-AGG-ID: rbYrwaqrOomLu62tvbNKmA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so51347f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 01:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784899; x=1733389699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd6Oy9o8pF7hYxCWd8kfvQGssh+yBV9f9FGrH23Nd4Q=;
        b=uqUByr417vBBSrArWkPfhiRZ8g5qLRrHNdpadDeycJlfdmhdLlpTkOOOvD1/gkDVCd
         1dTzc8PKgbC9bqCggkeIfLJOHXNvTOHmMplapwviijAgN00O64HpjxsRjpz6PX9QRb9b
         56lrlILKtuUKv5VgEzxqma60dxis4dSajHs2W2Ku59aM/3CtijJ+IwxxzISbCme5lokI
         GPDW+ln+1Mzo97R+8O8yf4pa0Qy7aFAn3pHA/4kkIHoAmcUPdZUecC6PbLX3AkvXOmfL
         SSZHOXQyIo2EzBt4KTMmyknEJZJEiVGLDTxi9SnTi+FdN28dM7jwukLK9+Ptakt1NHvf
         6VHA==
X-Forwarded-Encrypted: i=1; AJvYcCWV03N3Er7FlrdLxQZIqLZPFkg5jPI2RKyueUjQe6UXZtdTYVd7b9GSgTdC/ZMHGwBEy4FEI1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbAOg5W+eDgzR2TFExzMaF2KTnhQd0I+ZTSYCUlGL99VbzEuS
	Wtqm4i/MYcfAZFyAIdh20QQ9ZEeya0SW0pZ5efs66yzsAvvYWzzzNPYqve5BxV8J/ZagctkLlH+
	pLSHg1UJxbBOjR4fkU64puysw/XL8cvDnp3P7Sl29Su/TYTQTQ4PojOncA/UdQA==
X-Gm-Gg: ASbGncucDXwjwrtInNM8ZbtDXy3p1r3GZ9DjIIwLunUVa3uh5JVsVYKVUauuzDFH2C0
	B5sRJfNiW/ZuMIlRn62SD4ad7S1g6AyeykIlWwpVM8dR8SicDzX+93YWzEte/g2J8OzLM1UUPmq
	CSEGJRxOiD00VsZSz9pU4zHLzwhlFAGp4HtHN1Zd4DZB9XdYkox0CCyU10pr9xXkYQAh9Kc8Evv
	JCmntHcm1fjrrWMyhPyIi3xC+tcbIq6sY7cKqWCrvdiG5ytWZCUK9Qc5mojhXt9YtLduYOziHaP
X-Received: by 2002:a5d:59a3:0:b0:385:cf9d:271d with SMTP id ffacd0b85a97d-385cf9d2858mr505962f8f.21.1732784899634;
        Thu, 28 Nov 2024 01:08:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPn1cFdjKX1VUpor0v8jaaA2iG7IitUJUGUTATanMx7SpW9wnMMd6OwcckvdMm3LpZDpXupA==
X-Received: by 2002:a5d:59a3:0:b0:385:cf9d:271d with SMTP id ffacd0b85a97d-385cf9d2858mr505946f8f.21.1732784899240;
        Thu, 28 Nov 2024 01:08:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-60-32.dyn.eolo.it. [146.241.60.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36d85sm1089329f8f.28.2024.11.28.01.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 01:08:18 -0800 (PST)
Message-ID: <f3657bf6-7980-4c5f-8c82-66c68beb96e4@redhat.com>
Date: Thu, 28 Nov 2024 10:08:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/6] usbnet: ipheth: use static NDP16 location in
 URB
To: Foster Snowhill <forst@pen.gy>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241123235432.821220-1-forst@pen.gy>
 <20241123235432.821220-4-forst@pen.gy>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241123235432.821220-4-forst@pen.gy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/24 00:54, Foster Snowhill wrote:
> Original code allowed for the start of NDP16 to be anywhere within the
> URB based on the `wNdpIndex` value in NTH16. Only the start position of
> NDP16 was checked, so it was possible for even the fixed-length part
> of NDP16 to extend past the end of URB, leading to an out-of-bounds
> read.
> 
> On iOS devices, the NDP16 header always directly follows NTH16. Rely on
> and check for this specific format.
> 
> This, along with NCM-specific minimal URB length check that already
> exists, will ensure that the fixed-length part of NDP16 plus a set
> amount of DPEs fit within the URB.

This choice looks fragile. What if the next iOS version moves around
such header?

I think you should add least validate the assumption in the actual URB
payload.

> Note that this commit alone does not fully address the OoB read.
> The limit on the amount of DPEs needs to be enforced separately.
> 
> Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
> Signed-off-by: Foster Snowhill <forst@pen.gy>
> ---
> v3:
>     Split out from a monolithic patch in v2 as an atomic change.
> v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
>     No code changes. Update commit message to further clarify that
>     `ipheth` is not and does not aim to be a complete or spec-compliant
>     CDC NCM implementation.
> v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
> ---
>  drivers/net/usb/ipheth.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
> index 48c79e69bb7b..3f9ea6546720 100644
> --- a/drivers/net/usb/ipheth.c
> +++ b/drivers/net/usb/ipheth.c
> @@ -236,16 +236,14 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
>  	}
>  
>  	ncmh = urb->transfer_buffer;
> -	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
> -	    le16_to_cpu(ncmh->wNdpIndex) >= urb->actual_length) {
> +	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
>  		dev->net->stats.rx_errors++;
>  		return retval;
>  	}

The URB length is never checked, why it's safe to access (a lot of)
bytes inside the URB without any check?

Thanks,

Paolo


