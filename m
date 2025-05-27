Return-Path: <netdev+bounces-193602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8ACAC4BFE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB54178E60
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62E24DD13;
	Tue, 27 May 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpbHddE6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982B1E22E6
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340479; cv=none; b=eJWlYBxbcpfBL6psf+2ZUZN2rDQqsmNtJ3wLWL7DsmJ/m3H4QfrcLxIcGGQOZ19CaiwjQnzBOjRNDcrEZNKntp+gMEEnoDkehTqm0f4KmYNLNKgpoDh5kQUqAQ+jP6DOn4GgZwuf7LA0fxRgCQI6Y7xl6/sGR6V+CyxuNxenkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340479; c=relaxed/simple;
	bh=LUDY5+QY3OOzomPMaC6ZSG6wDrqxfZg2mOMfJ6GeXy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdfhQoWxOEGDBYnpNnHzoff67B+z9CA1CnhOlvw2eySobCoaIYOJbNClTEgE6nOM4eqcSQBPf13wHfOxBplEp1zCeaH4xSeEs7HV8Ks//coHtkAEsjtZ5To4QECJDiW6TEab/hUGfr6N5A/BQSNtUn3ujZIaunf1jFqThq1NCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpbHddE6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748340476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiWsmRysyzgIQdsMsmY38sFE/BQsReFRNj9TE4URjNA=;
	b=WpbHddE6/q0jr5ms5MEu/opdDmB8k+zDUzETOI4SZ4hhxapODEoA2mj23c+2nI2VZeV2Gt
	cqFxM9oRKSV/X18N4122qTt8wkF8ccGSxJCHQm8yh8UkbxxZopwJmJkGyyOR09SMX7w/Lf
	imrEb64umUK5varGnR+/+Mi/pAELdao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-dmjpTOM8NoyxGhvC8uH8NA-1; Tue, 27 May 2025 06:07:55 -0400
X-MC-Unique: dmjpTOM8NoyxGhvC8uH8NA-1
X-Mimecast-MFC-AGG-ID: dmjpTOM8NoyxGhvC8uH8NA_1748340474
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3684a5655so1561438f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 03:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748340474; x=1748945274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiWsmRysyzgIQdsMsmY38sFE/BQsReFRNj9TE4URjNA=;
        b=L/rlVJKkSwmduf6xRizhnEAxE44nrRLZXKfQhJRx6XOvn7LkVhzI2igl8ravB0qhoP
         hjsZaJCfxU71IYw1jq7QDLTsv8BD1zi8juIskJhCejYPXeuUWGGg8ICg5lUVYLLMXFtV
         IMReGLQoBJI/COMhsbsuajit7yRSeZUe+0Vq+CO3Xh3F7gTItMJNQSYyuw9Q9Tk+tt05
         44dEMuLXkWz6gk1t1U8+o+zKVFWmNoPl8DBGQ85wL39HJuji8R8bz6h/o0Bq68xSsNya
         lOGwjcGxwC4BBFZkr/2ABghbgLKIVztk4QetidIdzyrdRCEFt5/bv/pRRMIPR9+RBC6j
         D5xw==
X-Gm-Message-State: AOJu0YziocbG6nev9i2l9iK6hOFAzWNtJcPzjlDXTiLKLrqvPj1H1Sop
	XP26AdUQKUEQ0bCvhjljnwjW0hHsCOn12A5pRQQHbQH20KLcze2xB9adSGCoPkBUb8oKANfXgWX
	Sa7EW0h4fEMV6OYSjvysqM6A0sb5xLNBHYujnZh1U0tH2ZfGQGRM96ld5hw==
X-Gm-Gg: ASbGncvM0flUPG5+jUgkxZL/YjDCH5xpouFURdBakZaUCOGRTVcXWILNow6y91SiMmW
	hWiMJU66yRtKOstyFI3vimpUQfbrOK3q+K+JNMuDVvmpSHWEQPyqgQTKVgcHrcpNGpV+lmB8Q6R
	WMw1R5tl/rJOUwAFUnUr0wkWk3N1HGZGJymt34QE7L2e1uyjHfvk/G3EoV0iIk4PMMahSNXG/qE
	mCTyF0u6phvYqHQmj0kEoZlIzTXVTmUBBtsgjWgTCwv0OBsnhEtaMUTKUVMUOI8EcBbwJ2j6nhN
	yTgB9r+4kFV2Fn2s9Fw=
X-Received: by 2002:a05:6000:4211:b0:3a3:7bad:29cb with SMTP id ffacd0b85a97d-3a4cb499ce9mr12013361f8f.52.1748340473992;
        Tue, 27 May 2025 03:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLNHWzaadRk4BeFT9N8GXrWjrNdkIG2aaLNq2H8vKxDSQ3pCejWiKsjDOLcOZjjg0kw5/fXQ==
X-Received: by 2002:a05:6000:4211:b0:3a3:7bad:29cb with SMTP id ffacd0b85a97d-3a4cb499ce9mr12013335f8f.52.1748340473655;
        Tue, 27 May 2025 03:07:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d0eeec5dsm8369268f8f.46.2025.05.27.03.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 03:07:53 -0700 (PDT)
Message-ID: <dbcb476d-9bfd-42bd-bef8-8085baa05063@redhat.com>
Date: Tue, 27 May 2025 12:06:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] queue_api: add subqueue variant
 netif_subqueue_sent
To: Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Fan Gong <gongfan1@huawei.com>
References: <cover.1747896423.git.gur.stavi@huawei.com>
 <19057ca470251f5c48d90f379edafdb639278339.1747896423.git.gur.stavi@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <19057ca470251f5c48d90f379edafdb639278339.1747896423.git.gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 8:54 AM, Gur Stavi wrote:
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index ba2eaf39089b..7b6656ee549f 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -294,6 +294,14 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
>  		netif_txq_try_stop(_txq, get_desc, start_thrs);		\
>  	})
>  
> +#define netif_subqueue_sent(dev, idx, bytes)				\
> +	({								\
> +		struct netdev_queue *_txq;				\
> +									\
> +		_txq = netdev_get_tx_queue(dev, idx);			\
> +		netdev_tx_sent_queue(_txq, bytes);			\
> +	})

The above could be (and should be) a static inline function. Note that
(most of) the existing queue API helper are macros to allow quering the
tx ring without using indirect calls/function pointers.

Thanks,

Paolo


