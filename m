Return-Path: <netdev+bounces-202910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B7AEFA1B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423B8164FFD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA526FDBD;
	Tue,  1 Jul 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTd8BdwZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB622094
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376026; cv=none; b=dBrAGUY0RjZ2T4QjLs1N+wcvgllm54ruHw5t9dCDkIi78ZfCEWz28CgLe3WCE2Mk4uysFFiQiiC4Wbz4f5vQaMjm87kjrJmuXKXHWz79wfs7pjZgFY1xtfGUpWtz+TyFge0+8pyfp+wZ9ZeQjYJQRT5O7x7z9ff6gmU/vG46yUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376026; c=relaxed/simple;
	bh=eRJ2p9dsI5riXRZzRsX0svtjIANa2edB7jr2kaolZyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzbXReNiQmELrXoU2NsMQVrsPkdFGt3qnoQjJ8AIbZD8b/sEw2B2DWU01VJxUFFYnwLQwrIMn0MCnggwVdZcBzTz81eTUbcFEY+EpmvObIikw0zcAfpTNsBwzBDykTI7rREWE23JFyUiz6skXOWa1zcyeFr64WWf2EcfuN52Y5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTd8BdwZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751376023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHwbcnnUQH5ZtJufbjFE3pizs5k9oq7RhM2V08YeVUs=;
	b=cTd8BdwZF1Fif9hJpHOcCWYE5jCfGwdVMLAESqcgQcwTxT+2g8z82WIXuZm8QqXOJv5416
	1UcB/atWKYYFJMCbwWgeklZ2Myh7xmIZ2juU6fw3Z+Vd1f2dnJb86+y0MymLAAilCf/2f+
	xQMlunB409JdNdRzyTM9zDrjKbTVfXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-G8PEllUBMkSfiuDNrBzFkg-1; Tue, 01 Jul 2025 09:20:20 -0400
X-MC-Unique: G8PEllUBMkSfiuDNrBzFkg-1
X-Mimecast-MFC-AGG-ID: G8PEllUBMkSfiuDNrBzFkg_1751376019
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538f375e86so30050415e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 06:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751376019; x=1751980819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHwbcnnUQH5ZtJufbjFE3pizs5k9oq7RhM2V08YeVUs=;
        b=srbx30OdAh1jNfrvJaz76MJLM7bBiXFdVfOjke+p3Rt96rbxPVGcJW+Owt2M/8c7VP
         rt68y7tEkgSkNUBWMtsv7u0I5Fw+PRUFqYxiDrejwjx5TwNxdX2NKbOSoAAlyeOp2yo6
         2LQlji+f+ssDnw4AcKik94CMX0N124jj1Ib7vvdHmW6V5sYhCpqZ6pHjQOJQTGIQ4KNk
         nzfH882nL533Tg1Ph8jlzO09aQ/4tapdUzShl2EKEQoTjcfEu+89gQoWHRQRU46sLgSx
         Ld+vKSyrkUWxbwepcOCBbSUajEIisTaWfut2M5bBv1UCPwz+ZJjXg9cFxkaVffHYcxN/
         MfNA==
X-Gm-Message-State: AOJu0YwczIBJBLmpnrcxkmHXzBFvwnYUtW0Yc+7UM9khHNHrfSmGbbPq
	yOixdS2l5Hev4cIXtiBU6DC5dqal9xEtp8pCqcfB4N00ThyOv2CIC9uq5aCm+I9gFv0ppp9ZPKk
	oEaBBD4/OTKzdwaEjRQW3NoaoRrY7fRFAIlxru+/mwkdMTt8qrRlZJlt7Pg==
X-Gm-Gg: ASbGncslNkoQ0t9u52TUt/qsLRvjgjausHwtwS1mGMcqpbteKoiXteSqTJMqZ3tamP9
	4fC46lZnXGM5mdT07i3ty/IUiZ9PCNVqBnoVyXvUSy8jjE9oXqCd2jAtMdr9IYV2vBJQ0wiBkuV
	7UTpoIsoTJz6HPouN6d2VVC8dTHD+IrJS63hdIhQAObOD/bh4LKLWMdRNI6TCcErrg1uZFCYWbK
	Es4y2Q9h4L3CpfQchOjY8vC3MntP5Cc6hjgrTQ5qNklhwYwZPodvMIVkNm8+h2h3S4hQSz5jcW3
	vsCx21JN5FRk3Yj9/1d91il5dLLMmRm08Szv6UDLzOfyc5Adeu6/BGqzw39huDrfPjzTwA==
X-Received: by 2002:a05:600c:3495:b0:450:d614:cb with SMTP id 5b1f17b1804b1-4538ee61ceemr149672835e9.33.1751376018601;
        Tue, 01 Jul 2025 06:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZX3Mi+guY4B0n1wdMJ6RVJmNQKe+PFngAr5jDRsG5xyLyDUgP7yeLUmzz+izYvsMVJEpS7w==
X-Received: by 2002:a05:600c:3495:b0:450:d614:cb with SMTP id 5b1f17b1804b1-4538ee61ceemr149672115e9.33.1751376017763;
        Tue, 01 Jul 2025 06:20:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm194523205e9.37.2025.07.01.06.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:20:16 -0700 (PDT)
Message-ID: <f3bc7bb7-acc5-4087-af3c-120b82bd7b51@redhat.com>
Date: Tue, 1 Jul 2025 15:20:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 12/14] net: mctp: allow NL parsing directly
 into a struct mctp_route
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
 <20250627-dev-forwarding-v4-12-72bb3cabc97c@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250627-dev-forwarding-v4-12-72bb3cabc97c@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:52 AM, Jeremy Kerr wrote:
> @@ -1318,61 +1333,114 @@ static int mctp_route_nlparse(struct net *net, struct nlmsghdr *nlh,
>  		return -EINVAL;
>  	}
>  
> +	if ((*rtm)->rtm_type != RTN_UNICAST) {
> +		NL_SET_ERR_MSG(extack, "rtm_type must be RTN_UNICAST");
> +		return -EINVAL;
> +	}
> +
>  	dev = __dev_get_by_index(net, ifindex);
>  	if (!dev) {
>  		NL_SET_ERR_MSG(extack, "bad ifindex");
>  		return -ENODEV;
>  	}
> +
>  	*mdev = mctp_dev_get_rtnl(dev);
>  	if (!*mdev)
>  		return -ENODEV;
>  
> -	if (dev->flags & IFF_LOOPBACK) {
> -		NL_SET_ERR_MSG(extack, "no routes to loopback");
> -		return -EINVAL;
> -	}

It looks like the above test is not performed anymore. Is that
intentional? Even in that case, a comment in the commit message would be
useful for future memory.

/P


