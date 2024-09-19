Return-Path: <netdev+bounces-128932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E297C7AE
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2397B28EC24
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398571957E7;
	Thu, 19 Sep 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOZRppXG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87E168BD
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740370; cv=none; b=sGrxEPSp2vS/7tFpyxtE5WA/Hr+CNJXRfi67jjTtIAKPWmXjHoFyFiTQIiN1GKaZKgMbnXHnbQ29dfPkLWlRyW/jYg0Au9uCzL4quFwGApcgvBLl5WSeCk5sQRiWOS6CEXXAW2EU3MM9GtCKpbPiOAGxXl8PmrWIXqd/VzpekUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740370; c=relaxed/simple;
	bh=XCSshaxJzznqVzATTj4/9h1+YuItLrY1TyGGv+lOYiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nPrXEKiVfHN6yALGfzotnCWMqiBVt7UFWOFj5dO11JC0OXtccW/jjhC9tZ/jAkMtWR29JsLUZ7sFQqlxdLt8S/0/WaTQc8FThCY4xiROqoHqKFpYBeUQcwgiIA8rGb2xJcJCiLjP0PwIVL+8TfLoqnEVwSatXO5TJbrQsJ228i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOZRppXG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726740367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8sw9chzh6V0ldGfmUwBiAZ2jnRMPFw7mVDSc3g8Bgc=;
	b=hOZRppXG9tmrJQW+4jf8MbgAtTildR1aheXZOulgxFI0xI+bpNxLA/eoUyG7h0W5FZ5GX0
	q07/m80KyzQ2U9g4fhgnQub4kzEqonRFcGoUzsVomxn1r5TCxovkw4eEb1OGsXETg7oERS
	dTYAmkKAQqkORh3/vBqgPRloBVV0hug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632--GnKdZYsPMe4jP7thSb7uw-1; Thu, 19 Sep 2024 06:06:06 -0400
X-MC-Unique: -GnKdZYsPMe4jP7thSb7uw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so4688715e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 03:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726740365; x=1727345165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8sw9chzh6V0ldGfmUwBiAZ2jnRMPFw7mVDSc3g8Bgc=;
        b=KR85RtRrE44bwnGTXsqWSgckS/99vneSHHxuDEfh5MAvtQLC9mEkiC4gnOyYJefUx8
         70Y3cnJ0b4W3+XJg63m9GuokCF8GeZ6Fnwkr3HNiQQkeoSTvWtf5EfRAWR7FwqFI8uaU
         PXpIdD9aDO8+p4riuZyqzu6WgoQIOPcHjE8BMljbXicXybSvjeziVgmsOWVV74AAwHmE
         R76smt6twwr4Ro/jYfHpcRTQgjtRPfmz1ag8mVQTd/25UPe36PF4cWniUow1sOuHxR/c
         TC+stS50EGmkaAihjlLR5h0Orta0CLx6VB+dmuMgXRs8lfc0s+bEt8RvpEzZAwwmLUu0
         6dvA==
X-Forwarded-Encrypted: i=1; AJvYcCUm5YeR3Z+R9iiDqp9XaVSbjbplEBxnfOy572C7S99FAaNUmFLPT+IVG5cYQ7q6mKytXkpOXlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdP6Dfm7iz4ZH5Lug4kCUWxaX/rRhIFa04WIP3iTlqN/dOcLO5
	ozFiqBbWc8awrT1cVyKPcmfp0xwgqFN6h6Ic66GzPuHRYUxLQnZ7w8HdmN4FtdvseAAhTmgGaC9
	RjOaxDaBt6dXDeKteOYK88NjVivivoo/a9kh/HQYsiHe78ogD9oK76Q==
X-Received: by 2002:a05:600c:45ce:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42cdb586d9fmr198605145e9.22.1726740364769;
        Thu, 19 Sep 2024 03:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCQb+yDIF3c7yHLOLlyuOP1obKRz9WHSVtK0x+cI/W3HDiqwFW29UxH0o8W4i4Ib8pkExQlw==
X-Received: by 2002:a05:600c:45ce:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42cdb586d9fmr198604895e9.22.1726740364282;
        Thu, 19 Sep 2024 03:06:04 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754256c8sm17803525e9.14.2024.09.19.03.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 03:06:03 -0700 (PDT)
Message-ID: <49d32698-e226-46b5-bee8-46e9aad5754b@redhat.com>
Date: Thu, 19 Sep 2024 12:06:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net:ipv4:ip_route_input_slow: Change behaviour of
 routing decision when IP router alert option is present
To: Guy Avraham <guyavrah1986@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912141440.314005-1-guyavrah1986@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240912141440.314005-1-guyavrah1986@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/12/24 16:14, Guy Avraham wrote:
> When an IP packet with the IP router alert (RFC 2113) field arrives
> to some host who is not the destination of that packet (i.e - non of
> its interfaces is the address in the destination IP address field of that
> packet) and, for whatever reason, it does not have a route to this
> destination address, it drops this packet during the "routing decision"
> flow even though it should potentially pass it to the relevant
> application(s) that are interested in this packet's content - which happens
> in the "forwarding decision" flow. The suggested fix changes this behaviour
> by setting the ip_forward as the next "step" in the flow of the packet,
> just before it (previously was) is dropped, so that later the ip_forward,
> as usual, will pass it on to its relevant recipient (socket), by
> invoking the ip_call_ra_chain.
> 
> Signed-off-by: Guy Avraham <guyavrah1986@gmail.com>
> ---
> The fix was tested and verified on Linux hosts that act as routers in which
> there are kerenls 3.10 and 5.2. The verification was done by simulating
> a scenario in which an RSVP (RFC 2205) Path message (that has the IP
> router alert option set) arrives to a transit RSVP node, and this host
> passes on the RSVP Path message to the relevant socket (of the RSVP
> deamon) even though upon arrival of this packet it does NOT have route
> to the destination IP address of the IP packet (that encapsulates the
> RSVP Path message).
> 
>   net/ipv4/route.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 13c0f1d455f3..7c416eca84f8 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2360,8 +2360,12 @@ out:	return err;
>   
>   	RT_CACHE_STAT_INC(in_slow_tot);
>   	if (res->type == RTN_UNREACHABLE) {
> -		rth->dst.input= ip_error;
> -		rth->dst.error= -err;
> +		if (IPCB(skb)->opt.router_alert)
> +			rth->dst.input = ip_forward;
> +		else
> +			rth->dst.input = ip_error;
> +
> +		rth->dst.error = -err;
>   		rth->rt_flags	&= ~RTCF_LOCAL;
>   	}
>   

I think this is not the correct solution. At very least you should check 
the host is actually a router (forwarding is enabled) and someone has 
registered to receive router alerts. At that point you will be better 
off processing the router alert in place directly calling 
ip_call_ra_chain().

However I'm unsure all the above is actually required. It can be argued 
your host has a bad configuration.

If it's a AS border router, and there is no route for the destination, 
the packet not matching any route is invalid and should be indeed 
dropped/not processed.

Otherwise you should have/add a catch-up default route - at very least 
to handle this cases. If you really want to forward packets only to 
known destination, you could make such route as blackhole one.

Cheers,

Paolo


