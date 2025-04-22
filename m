Return-Path: <netdev+bounces-184613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E9A96623
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CEE3A8DED
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29D1F12E0;
	Tue, 22 Apr 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdD8jiZU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F61DDA1B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318471; cv=none; b=TaQpmAN5qN2euDJlKYMcRm3bAB/HIK3H59w9wyhTKLUMw8LMvfVQLagD2PWu1utOiUPStXRqACHQ4iRt4BzhH/l9Vz8B1STkZ796WdqHkorX4xvA6cMju2iLYd6o8V3X5DfCGaKuE7dzSRDWwB63+lBZ7CYvVwMrU1ekR+59ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318471; c=relaxed/simple;
	bh=MBxL0LkvIA4vATxYe4x0tjrYUSOw3EtiQtqh4dVesjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb1et/k/U5px9S+kcDrmailR25ILfXwyyi67ItcMGy8QRn8W9UCxTIuuC/g3Ie7hCDedjR1dr+gpC8KkjfJZzXM5GE8AqN0RapN4wLdG4J3ZSKxkWCUBfmwMPmbHwjfq1/j7A9qvIwSj1RvbBWVGy4aheqz9uNmMIkPJAInYNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdD8jiZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745318467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvNtL6c2VjzDh2f+3Rz55In+lMu12wbNCHwQu/1GSVI=;
	b=YdD8jiZUtTToN3z5y4wpIqEOEs6KzC0SLkybQrRzCW8k1eNQZmI5lkyReb0Kyx8iPXGDOf
	+dJXU8ZtM/surywIPgeCnsMeepJmNW0sO6Ike/eGSiSkKmgQGr9qI9lio4AifDnwj32eJN
	eNhm0aQ7MGHQKbp4ZQSNyCTChhbHRS8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-USp-3rROPBeRJ65WKX2exA-1; Tue, 22 Apr 2025 06:41:06 -0400
X-MC-Unique: USp-3rROPBeRJ65WKX2exA-1
X-Mimecast-MFC-AGG-ID: USp-3rROPBeRJ65WKX2exA_1745318465
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39979ad285bso2221880f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318465; x=1745923265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvNtL6c2VjzDh2f+3Rz55In+lMu12wbNCHwQu/1GSVI=;
        b=I1lYRHlowZFaP6MtlUD4T6AKzk4FgjfCq/n7za3TZPwnNVKvBPl1EAqy9VD30kvAdv
         gH8C/w1hluPGS9rONwd57d0opDfQfXpqLIeW0fJYs76FLvxNc6zSMcsYjGqrUrezILbC
         5SYnpA5NYhe8rjdMFEismEvu3886dEB3g6hcl8iVdG/H22acPq8e6CWyZFDi+4nxJC0f
         E3U68qQ1ssZrYPmqqH64FDw9v6gbRK8xrtYDV06I6K9FYxGIg5z6xETMEydCgGSeP3In
         So2iSMkvl+2bDQzzv97+MtLLG03x2EWqlYsPTpcJNelJ0raIS0rxMTWC27xENgCwiZSi
         q5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOYcVePzr3dNwd4+guv347rCI8SUeJF1YV91PqiyzlUinbDg+xPevqCmcP5YGVZbKPSDh8kiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIDv5Wso85PYRburTgOUyvlb+H/G93iMrjv0argunzT0dwKEu
	eT+kYkWVUbeZ1wM1wTsZdWODb5mReK2Ry9oem5UqW3o4Oyv1EHvXe2eHNfc+dpNloQDrzOssIeg
	LJYCQrSo1/rqPJoHBqdR0wUOoC/+K/y7DJvaTVc+lOpb7gDuL91nGsQ==
X-Gm-Gg: ASbGnctMHQhEWPeu+it+/h98a1ulMtU4Ka2e3hmjiDOPAhIKDLdB0/nn77PM435KY8/
	PkadunCL3I67ZRdSp0vL7XD3B0y/Vu6xqw4BeTqdVWFFkK08sKTxL1HWylgPn6fEzLlzqiMxYrN
	xP5VtvtMWDjVujRd7Ws06n5laVpHaKd/Rycf+0B40mYLAzZnPWCqzKNqQkE/+hhftGa6bLKmkh3
	xPBzstKpnKX3v7jtWIG977vKDV91NMZ2YgVw6x+ifs4rrvAIfNfgiBYkPCzCApCJ7POB6f0XrzS
	YzjUuPZ3nPoloOR4fpPl+vdlmqSfmMly1Dch
X-Received: by 2002:a5d:5987:0:b0:39e:e438:8e4b with SMTP id ffacd0b85a97d-39efbaf6e96mr11661117f8f.50.1745318465085;
        Tue, 22 Apr 2025 03:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfhmdY3+2oaQKSOAlvXE2xWziVZEiI/GfbXgpJGaf3eH1zP169yxdyhIy73RUyTSQrUgpQ/A==
X-Received: by 2002:a5d:5987:0:b0:39e:e438:8e4b with SMTP id ffacd0b85a97d-39efbaf6e96mr11661101f8f.50.1745318464726;
        Tue, 22 Apr 2025 03:41:04 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a517dsm14622895f8f.100.2025.04.22.03.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:41:04 -0700 (PDT)
Message-ID: <0f5578fd-9f0b-4541-aff8-f882850ee01d@redhat.com>
Date: Tue, 22 Apr 2025 12:41:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] TCP: pass accepted-TFO indication through
 getsockopt
To: Jeremy Harris <jgh@exim.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com
References: <20250416090836.7656-1-jgh@exim.org>
 <20250416091538.7902-1-jgh@exim.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416091538.7902-1-jgh@exim.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 11:15 AM, Jeremy Harris wrote:
> Signed-off-by: Jeremy Harris <jgh@exim.org>

The commit message is missing.

> ---
>  include/uapi/linux/tcp.h | 1 +
>  net/ipv4/tcp.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index dc8fdc80e16b..ae8c5a8af0e5 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -184,6 +184,7 @@ enum tcp_fastopen_client_fail {
>  #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
>  #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
>  #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
> +#define TCPI_OPT_TFO_SEEN	128 /* we accepted a Fast Open option on SYN */
>  
>  /*
>   * Sender's congestion state indicating normal or abnormal situations
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e0e96f8fd47c..b45eb7cb2909 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4164,6 +4164,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
>  		info->tcpi_options |= TCPI_OPT_SYN_DATA;
>  	if (tp->tcp_usec_ts)
>  		info->tcpi_options |= TCPI_OPT_USEC_TS;
> +	if (tp->syn_fastopen_in)
> +		info->tcpi_options |= TCPI_OPT_TFO_SEEN;

I guess a paired iproute2 change is needed to really observe the new info.

And it would be nice to leverage such thing to later add a paired
self-test for this feature.

Thanks,

Paolo


