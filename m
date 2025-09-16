Return-Path: <netdev+bounces-223387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CFCB58F5F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC41C3BD2CD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8072E974E;
	Tue, 16 Sep 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT9Ss2tA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B441E3DF2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008452; cv=none; b=q46P5Sbh598QtipfbBXdoFrB0NgBdhvhwkI0ol5Ww/JEFucLsq0ByZ3TiqCmfkWH37euJmRkIg/so+MUoNe22liBTF7buQo8AZozxWTVL2PeZptV4iSc/P07awEggAgtqdtt2zaibvt2indUENO6IF1y0uNu12JryvnStbjBomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008452; c=relaxed/simple;
	bh=GjEkDyLTh7ZDdDZihLiAf2k7iEwy4dac/0RvjEj6FR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnL217P0gC5IvA75ipHV1RAG+Yi74p17rC5/esNg6Xc+C5ECJDbvjOXTDHLty8Yz01FauNhCarpGtmwMrb0OYZr1DK9lTPg9sr1fZ7u3ZWrk8mZJ99DQe28OX7gtRwJ6jhl53aHoGpHj+kOblHK6yXHpzp5UdD+X6T67laTfGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT9Ss2tA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758008449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XC6jQUydWZva3M5eCBceendVdHRZfWZngDNic1d6Rk=;
	b=jT9Ss2tAVUsQfCEBGnEflChzlpGn1oEuEI1p9MA8wdLMUeD6a9f+HopXPhkQrwFyvkPuoX
	wHNU9UI2F4ehdMFMWVpbvnwXgjHRt6JHTES4otimgmCwk4ZbmufWppBJXlCOCU7gay8xDe
	7ElVOx42dnKsWqrTtIeLF3F8m+wRSoM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-YAc1YNNcMvuWiiTlWg8VMA-1; Tue, 16 Sep 2025 03:40:48 -0400
X-MC-Unique: YAc1YNNcMvuWiiTlWg8VMA-1
X-Mimecast-MFC-AGG-ID: YAc1YNNcMvuWiiTlWg8VMA_1758008447
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so31773195e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008447; x=1758613247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XC6jQUydWZva3M5eCBceendVdHRZfWZngDNic1d6Rk=;
        b=WxAheFUSYt2WilhpSdWuGCdCTCJJv1YvIz9g0VVamO5x5X+kDqj46ZoqCOqy4fwp3H
         iO437iQKG9zFMVv8tQvEv7zp22fO2isng3Dvjfp1B23EF9tRVPUZYzo0aeiFvZDlqT0v
         xjje+xIhQCv9/0qQHYBFNzpdhcMtdiPRmUQsWxBPJlr1pOfZQ8Y67ufmbQSBmGTZ0UqK
         MRzN8J1V+9OutpKcBNrrbLXZK9aiDwKPaHalK/L8Cq6mcNFKDF63PFTnNYOoY5qL+/F3
         B0m4M9hzYd2EHRNd+pGr/Wd4NtnL0q53jvNWKgbYzxWptIQL5+QLw3AvDY5nvj3kfZ74
         dEiA==
X-Forwarded-Encrypted: i=1; AJvYcCXFFYFJ7IqhHY8ckZ5lp1t7HFwk8LJrK7flusPQket8etej4Km1oilLBy+kSCeP2YCVEXdISZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVbcHmHkzpguEBFMdcE5sN0FMZCTcD1ID6GKWw0jcBc1TfqIQ
	ZV/ZoH5g+UiODy310xlUMuvB/Wa4CtnohI452tW/G0ZmB7VO8iqhrD/lou4MeCjknxTCniMMv8s
	1YkS9T6yzrzD8IrHe4PthIigifqCQVjh/TjhFp8ZY6LuDWq1EEy7f5TnoSA==
X-Gm-Gg: ASbGncvOOobNRLmVVWMy+8a5i0QJpS27aZPnnWZ2b6bD3OYxlCWIQAySYBYqUnOACBS
	bTI3rxLg3jBgIPzpYhLD4/sUUHeKOdFM53a8OVaU5m+FOHDuAuzJqFuzkxfC3KQHAErAz+4V1Lm
	YAPJmsO3ecaYy2UBn7+kdFI+fzohV43DqyQ+s0OfC1y31gbggdZCGg960p2ukcAFDX4iN0ZPAD5
	HmV8WrPFg5wGaGZSrNgZgJPYW3hin2ftHimYctKE2IEqlesH2O6roBQYJ3lK3R8jFvTTtJ19pFe
	IB10svLhn0NPhpOphXl8rEHkjFZyz9J+hd8I4aeOyD2p4wYWZhQ7R1b3UVC1AgVOdhFqtZPowwV
	7hZgOS69MbK6l
X-Received: by 2002:a05:6000:290a:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-3e765780a29mr15557508f8f.5.1758008447048;
        Tue, 16 Sep 2025 00:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0GMHGyJ7FIQxjksq4RJy1sc/WZjAzYzFb9xJalmfJ1yzSh00m+77viKw3AXwSQDB7C53Aag==
X-Received: by 2002:a05:6000:290a:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-3e765780a29mr15557462f8f.5.1758008446588;
        Tue, 16 Sep 2025 00:40:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e859a278c1sm13594749f8f.24.2025.09.16.00.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:40:45 -0700 (PDT)
Message-ID: <eda2c052-a917-4d02-becf-2608242d1644@redhat.com>
Date: Tue, 16 Sep 2025 09:40:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/14] dibs: Register smc as dibs_client
To: Alexandra Winter <wintera@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-5-wintera@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911194827.844125-5-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 9:48 PM, Alexandra Winter wrote:
> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index ba5e6a2dd2fd..40dd60c1d23f 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config SMC
>  	tristate "SMC socket protocol family"
> -	depends on INET && INFINIBAND
> +	depends on INET && INFINIBAND && DIBS
>  	depends on m || ISM != m
>  	help
>  	  SMC-R provides a "sockets over RDMA" solution making use of

DIBS is tristate, and it looks like SMC build will fail with SMC=y and
DIBS=m. I *think* you additionally need something alike:

	depends on m || DIBS != m
	
/P


