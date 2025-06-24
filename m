Return-Path: <netdev+bounces-200632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FBDAE659C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B464081A4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4729ACF1;
	Tue, 24 Jun 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmQVu5Hq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88728D8CA
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769644; cv=none; b=Fsyp+kedU83MUvXlZvwSgMsNgNOs5DhZJCsxa4vohUBeL9xb8/kGU+he2yIBAzg9n5GCV0A/C/QDVr4w1ptATap1fEajKSEDpJAs8SPYw9SGEXP9VjHoAAJY+oFNfZqfxCL5WzLufwy3idBwXGkQtIlWvNIpNOwD6hDTPkAcbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769644; c=relaxed/simple;
	bh=2kOE0t10Ys08qMax53uN1Ij++jJiV3VlExemldFQM8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diuSrWMlvcZ5eGByVsgcytpBs8+fg3JjcaXCbjEMoAwjyBzxWIS6YHTiI4f5u2mKQdrgytR+46VYSefgaTFiUsqEjb/r1zPBbZvkXPX2RQqftysJdmZsRGIXWMhOfCvEle168X/uyyuteDgI5jD0j4c/fUUbBGQ9C9gKo7ID7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmQVu5Hq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750769640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1zTpwcC335IMGuNVVSMsviTgOOTgO+DQI5xktWwQcI=;
	b=UmQVu5HqnY6DnVKVatuvmHBBsERCTrUiqBDjAUBB9a6bkSyxkrrqxUfziLMqZ7LV0syaw2
	FaSK0gLbMiV8L7TMa4Tm/7+p3BQvg9PDdL0/bPxWgmibK1+MHptoZj6SIcrwGKwkNXukRK
	Qz51IkDDoIHSCjcu5O6yiqhIHtVIP7c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Hlrv7rq2MqeLPHCiI6XnPA-1; Tue, 24 Jun 2025 08:53:59 -0400
X-MC-Unique: Hlrv7rq2MqeLPHCiI6XnPA-1
X-Mimecast-MFC-AGG-ID: Hlrv7rq2MqeLPHCiI6XnPA_1750769638
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4537f56ab36so2722405e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769638; x=1751374438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1zTpwcC335IMGuNVVSMsviTgOOTgO+DQI5xktWwQcI=;
        b=kcLvYsrJ2pzHX6ljSKSU8WTCEnTVanI7ARlQWK0yqE5m79O7qGI2LQFYPORW7Ejtph
         RpD2QXEIClaAf8sNy7iljWoRBQC6aOuaITBdzFfN+9IUPopyb6YfAgNvCUW2EbMfzHPI
         pso672pVcwRuFpqlNYv9lIdH8evCCqaHDsElOGr27iweaSxwvWEL4CgmPyI4JVs5yZOY
         /ap+N/Fh9+6XuASUr0P4L0v5lCjnK8w4xgQs8mCMYDyWZgdIQI4gKTTxa7T5mD3YJHJI
         MhnPzMSRszDL26SpwQSiYN1eAGuO9NRj9SizrMW4vxE1MJcqo+3xm0LVv55XlcRKDUU+
         bVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0jkElR05yqbBezUmxElzfznHaE/1Udhkp4cYKmgVAYmXzHSMHMgW0oSOq2KAJ0vV3405vZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8y1gClZKKHhYSDkvC+XM6EaEVyIMQ4eF4CUscKHrkpKF6lb7
	zLlIzbtHDVw/rIF7aDU3a3nXWF32B09k+VtKAvB8ffpDZOwkQXCc9HkDTnbPPnoI3wP+i0qzKdp
	b1XcYt+P9z84Vglg2ylvrQAvlbSYCBv4BgXkBVwe8sn/p7FI7wkJ2j3bYPw==
X-Gm-Gg: ASbGncu8ylUfFftuKmMrbEX1rBEK9C+pN3JVw0+JxKvRY4YS3P+5W3zOf7uMH3AruHG
	VzAsh6fqra7Dog8NbZNdTK92jRGpji3KrLnKhZGBP5kkV0bpA9rM1IRehLiRpNY09KrRaY12DQC
	OYfPUD2AF12Y4j9PRysaM063QjKlPJfpB4dVx7ByOfuLOV4zGXJjEV09lHYDCbtBKY0RZ1TAB7D
	e0mCHS2uZJWbMz+GTamgJAgKhkd3/dVVjS0qF6qbIURE8e0nlvi+fXaQld7E0ort3N0QwXvLoXs
	sW9amABZTwKFuBpGtMq724gl/sdtDg==
X-Received: by 2002:a05:600c:b8a:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-453658bac1fmr127799325e9.20.1750769638124;
        Tue, 24 Jun 2025 05:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7lMZVaWFiRWIPG8b3cMXMdvCcNTK8MZjjGLVmokK+tCuYyoVQ5c/x3K3fImoxj9zLjbwsw==
X-Received: by 2002:a05:600c:b8a:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-453658bac1fmr127799095e9.20.1750769637706;
        Tue, 24 Jun 2025 05:53:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646dc761sm139345745e9.17.2025.06.24.05.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:53:57 -0700 (PDT)
Message-ID: <fb0f1e3c-2229-4860-b46a-b99f6dbfdfe6@redhat.com>
Date: Tue, 24 Jun 2025 14:53:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] docs: net: sysctl documentation cleanup
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 skhan@linuxfoundation.com, jacob.e.keller@intel.com,
 alok.a.tiwari@oracle.com, bagasdotme@gmail.com
References: <20250622090720.190673-1-abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250622090720.190673-1-abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 11:07 AM, Abdelrahman Fekry wrote:
> @@ -593,10 +629,16 @@ tcp_min_rtt_wlen - INTEGER
>  	Default: 300
>  
>  tcp_moderate_rcvbuf - BOOLEAN
> -	If set, TCP performs receive buffer auto-tuning, attempting to
> +	If enabled, TCP performs receive buffer auto-tuning, attempting to
>  	automatically size the buffer (no greater than tcp_rmem[2]) to
> -	match the size required by the path for full throughput.  Enabled by
> -	default.
> +	match the size required by the path for full throughput.
> +
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)

This uncorrectly changes the default value: should be 1.

>  icmp_echo_ignore_broadcasts - BOOLEAN
> -	If set non-zero, then the kernel will ignore all ICMP ECHO and
> +	If enabled, then the kernel will ignore all ICMP ECHO and
>  	TIMESTAMP requests sent to it via broadcast/multicast.
>  
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)

Same here.

/P


