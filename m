Return-Path: <netdev+bounces-118785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A1952C68
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0641D1C20D04
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD441B32BF;
	Thu, 15 Aug 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eViwh9SX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AF1714C4
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716053; cv=none; b=G3hv3N9y2rPUwfYafvu3QeCqyIgzpin+UHHopjq52Zwl8rPvNvetZUrH7FQRC+mJKjwLxulAUDtWGlxfSuavDa3OvlYvPaV+g1G3Ior6qgr+YxHVqmlCRBsybzgGmo4iv79Og844mx5jQPtc0h/FKzc8gFncoWeV06EmOxt3+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716053; c=relaxed/simple;
	bh=5/CQNvLxQFoeAnRFoQafzP+JcE7z0R+s7OsIoIWaaeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/ablBJ2qjS6IwgSM62G7kuP9d1s7mTNwNGLYQs2eyviNrzlUcfpuavAKQq34Z6ri/nS3dbfhuPzJLCvgucuUH/bYm/pUMF2qXaFu9egDPrf4ekLPxZSDpLZwvx92BZP9xWygbl9JHdE6pvNjwy35d1Qz+xM/GCAJLuaiQeNDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eViwh9SX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723716048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDb6GNX3vOwuU98VN/SEplLulkRUAIt+sW7YYE4YmTM=;
	b=eViwh9SXnjpl6NVCGaSvIUJbsn572zLUa/Sb1F0ASjCeXYu0P3Dmo0Cf/UahrzV6nploB0
	hXY4M09iODe3Tdq4tw/79pFK3+7QYoA1UTJc9VI+1XJyTuBxJf7tgTQ1eMVBhuO02nak/B
	xl9804QUB5nYczVrBMBzjgTlj0Wz4ao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-qd7afqDXMHGrDoJzfRbP6g-1; Thu, 15 Aug 2024 06:00:45 -0400
X-MC-Unique: qd7afqDXMHGrDoJzfRbP6g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so1155575e9.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716043; x=1724320843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDb6GNX3vOwuU98VN/SEplLulkRUAIt+sW7YYE4YmTM=;
        b=cywdTH3PAx5gcyGvOfs9li7B8Q9AK2WIUXuNkkwE56Fv9MK7t8H1lF5sfks0/eJKke
         Ziwcz3fzfvQius5Ik3lorkXRPk+94tWe4IseA7GI1y+o6Ige0sbOqQR7rW4hXNWjGifB
         cnPCgtmayjia9yBMNi11KnpzVPBzZHgAlbMabctVR9jnuavjhooTQX68t5SXfo1Unc/P
         Jc5zecy5eT/UD9XYzFsmUqFPEMfx2/8wvr5P0h2/WaiBaMLr2t4PqcGUFiLLfaP0wHXp
         CJrN8I91usaUAhYh7YgvXxL0OGHlZQPpIMdz+kp7WqPI1a46+RfwvViNKbPmkmX9Htaw
         yagA==
X-Gm-Message-State: AOJu0YzxyMSlB1LZZk3RyzN7kv9o3jJo/A8WCF6E2sHZwPHmfyHAiJfW
	Ed5xPw7eikPUT7NPzHHmDiV0l7bqvsGcR9mthqdbkkFQNeY/CXbf849PHE4wCVgDhyvBxv9tPsx
	yQovAXxsqjlsczsMtBpK3fHG1Co/gFCY/HcYMmr5FOf11JBUUE6DFuR4w80oszPr7
X-Received: by 2002:a05:600c:1c23:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-429e0f5be95mr14363315e9.2.1723716042913;
        Thu, 15 Aug 2024 03:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgfGyY9sJWRMdsj2O7AcKX5GLCUo+hMEsGgOfgNDPFXCG8fhKxt8YuNlc9i8Oi+q9lTCUs/w==
X-Received: by 2002:a05:600c:1c23:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-429e0f5be95mr14363135e9.2.1723716042423;
        Thu, 15 Aug 2024 03:00:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7ead3sm44363415e9.47.2024.08.15.03.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:00:41 -0700 (PDT)
Message-ID: <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
Date: Thu, 15 Aug 2024 12:00:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: sunyiqi <sunyiqixm@gmail.com>, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815084330.166987-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815084330.166987-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 10:43, sunyiqi wrote:
> When enters tcp_splice_read, tcp_splice_read will call lock_sock
> for sk in order to prevent other threads acquiring sk and release it
> before return.
> 
> But in while(tss.len) loop, it releases and re-locks sk, give the other
> thread a small window to lock the sk.
> 
> As a result, release/lock_sock in the while loop in tcp_splice_read may
> cause race condition.

Which race condition exactly? do you have a backtrace?

> 
> Fixes: 9c55e01c0cc8 ("[TCP]: Splice receive support.")
> Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
> ---
>   net/ipv4/tcp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..7a2ce0e2e5be 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -856,8 +856,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>   
>   		if (!tss.len || !timeo)
>   			break;
> -		release_sock(sk);
> -		lock_sock(sk);

This is needed to flush the sk backlog.

Somewhat related, I think we could replace the pair with sk_flush_backlog().

Thanks,

Paolo


