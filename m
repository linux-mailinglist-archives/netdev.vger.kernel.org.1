Return-Path: <netdev+bounces-198516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3BEADC89C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B7163A9D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5928FFE6;
	Tue, 17 Jun 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG4jMwWM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7323313E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157322; cv=none; b=l2Axjqr2aNr1N8Cv2H9/uZyIc1qy0ur46T5rNAtPgoRqqLZ69xYMe42uKNrztad3q9brWBuBgukZIpBKWtkTEZnY0KlIi+lWEzmWYrFc8RXgJKlIayWQSV7LltlWefNmAQ9C7GvWH4hIcNxexPepfgdR2Mc0GpL/hmfmjH0j9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157322; c=relaxed/simple;
	bh=Uv8u54/dC2qUxCCPlrrZoR3WhX/sE1cmjIy197Ir6Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvrED0pq7tmullEf12EDSIohhKgW670bPJwo8O7rNaHvuA9oMf2/UhN498Se6udtxUKjbAUvb83jM7nbgGVnLrm03tb6ei9d+2C/XzvUo7VAcXJj5ehx8NVsqREkzEeYOXQ0lf4P4m1DsiT4yg2b1nirvSOPlB2V12FfuOwSz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG4jMwWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750157319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2YBkEzjOitxxT/YcZa7j0ioGPzZFcycwy5hGGacFEY=;
	b=QG4jMwWMZhylagqYRaBxTXIzwD9SD/YvrEI0dMMYVT8AQtOCNtJ2nFfIGDhr17EJim7imM
	YOaCJxvX+1YZjNdbJw2k2SG3dLP0suAe9ImjoqcBfbnWn1X1bmojTRb+nDchhNO3LWPL87
	GMzby0vltcXRIFavzmG6DIcVQL06N4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-85S1LmlYNMWDweV56qtlUg-1; Tue, 17 Jun 2025 06:48:38 -0400
X-MC-Unique: 85S1LmlYNMWDweV56qtlUg-1
X-Mimecast-MFC-AGG-ID: 85S1LmlYNMWDweV56qtlUg_1750157317
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450df53d461so45630915e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 03:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750157317; x=1750762117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2YBkEzjOitxxT/YcZa7j0ioGPzZFcycwy5hGGacFEY=;
        b=CWurysWTyIVaqmy3n1h7yTolnbMUN8Z2z2VDy/bEngJK3HbvOed2P4iVgPBpu0nhAX
         8vfqXBq8eyRSJOQjhIZNZVbXXz+YDlJy9yBPYbkqeoM/+xGrhteB9nStUaMmx/NJ49Dr
         MW4CuxVwOZ7eqsTRmZU0rjIiU0wl9yjivffMl/es1mlzfvBYE1z6oc+Mx+mYMkFXSNFP
         MA3iSbIAqkV0sLdmD6cDaBpmP+AdpYxetPomAiUngKfkkU3vPpeRcbz57l1fkHUn+3QA
         p2SqhkkUTRQHTQXLgNNoGiFjKBf5juK1i1sqpi+ZkA6ux5BtA/piuLvhYyP6oRPu6Gog
         xjCA==
X-Forwarded-Encrypted: i=1; AJvYcCXOnW5hTmUh1bY+6gYMJQEJ0t56uWILTJWCGC9oIOg5C/i1IOHrDKzZQ5l8E+5JmG0JdzHjqic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Yj8DXKJ0PTrfj0Mdn0iv9cX3TsKnARNt5AunzFDZcwPYzDHi
	MCyoJ/11zh3KViCjOiaDr1swLZoMIXDPNlIL1kSv9V/T+RkpJ7BZZnwXdW7O+L6sHHJEb0boX09
	h6UbWKzhlSIPyKL9d3Ye5b8UoeX7JBBDCYHEu5UDhSnnRgrba00FFM1KcI0uz8u3hytZI
X-Gm-Gg: ASbGncvztqWaPige0QYBPnj1/PvXGTw+TmwcFcoeeOKzNg4HjFYb3kDt2kEB3oD/ufy
	rZHBGHoQIPqjATTP+3/uo6+7HLNgT31G5yaIb4qmA8fkqMw6C5hIvpvGHOXuthyjPCKgk6S2Xys
	ebV/CuQbeNX9CvJZoZpWhTqlBSNi2o8WSCJcKQBbhquNQ4LzmvPSuD7eBD/qp/elGWViyGGyrN0
	UMq+7G2+GL4zLqzFwXebauH1B4XD+M1O6QjguJWSRMgnlnOETeYTZHtUGbz8QDO3jmp1WdZ5yOb
	oO+03lv8J0SbSKEnuERkGjy5zAxGV1GB8g5CVtpiiRGVxuqiuP4nqFeW45bN4QwFO2ogsw==
X-Received: by 2002:a05:600c:1ca1:b0:450:d3c6:84d8 with SMTP id 5b1f17b1804b1-4533ca837cdmr118077805e9.14.1750157317124;
        Tue, 17 Jun 2025 03:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF64g5YbFrucDdVgEXvbRk3CRluTsbwbsvTzZThEArUCifITIf4s1E3i56aauW0c+Cn+BJWRQ==
X-Received: by 2002:a05:600c:1ca1:b0:450:d3c6:84d8 with SMTP id 5b1f17b1804b1-4533ca837cdmr118077535e9.14.1750157316721;
        Tue, 17 Jun 2025 03:48:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2354fbsm169530345e9.15.2025.06.17.03.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 03:48:36 -0700 (PDT)
Message-ID: <54d712a2-31a7-4801-aa65-53746edda117@redhat.com>
Date: Tue, 17 Jun 2025 12:48:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] tcp_metrics: use ssthresh value from dst if there
 is no metrics
To: Petr Tesarik <ptesarik@suse.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250613102012.724405-1-ptesarik@suse.com>
 <20250613102012.724405-3-ptesarik@suse.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250613102012.724405-3-ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/25 12:20 PM, Petr Tesarik wrote:
> @@ -537,6 +537,9 @@ void tcp_init_metrics(struct sock *sk)
>  
>  		inet_csk(sk)->icsk_rto = TCP_TIMEOUT_FALLBACK;
>  	}
> +
> +	if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
> +		tp->snd_ssthresh = tp->snd_cwnd_clamp;

I don't think we can do this unconditionally, as other parts of the TCP
stack check explicitly for TCP_INFINITE_SSTHRESH.

/P


