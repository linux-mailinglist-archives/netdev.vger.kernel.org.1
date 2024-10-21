Return-Path: <netdev+bounces-137525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374D9A6C63
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0917E1F23D25
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E51FAC32;
	Mon, 21 Oct 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFFnsk71"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47F1FA257
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521617; cv=none; b=ohduwo2b/y/TyN5wI4weFu2hO8IpFwzOQKD8VSJB7mkLY0i7cXA0CagzYKJvqOWRLWeIspTFAVBv71wn74N+1pddXtTyOF1vtaLf4CfrFHO6zftpAUHtl3oTsQM4et747Cbi+HkBpbfSnDc1n9LMzq1cC81OF4y3W8hLcw8w3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521617; c=relaxed/simple;
	bh=Qb1J4ESPnoxMNJqmJyqgTEhGUYpIL/sGVVxxzKXx1HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mm7svr7Qdnrkl3UdiVmFHmPJaUsDHzwXOk1aQc2y5NpcD4/ZaTUcgZ8J3whpr0SL01FS9LpZ6rAjTUHWhppnKXRJ8SY4pCQeJstFmMwkhoVuTQZeHTJlLZUylXMmgijj3B5TNqw16c+7qUk+SPv5YPDyj35FIDBdnXJ83n7igoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFFnsk71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729521614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZ/ST2n2o+s+ljcXLA0TYyh1FPWIv37+D3gxR3SEmjE=;
	b=SFFnsk713P65FzwXBnv/YoEK05i2OUqpegHYEO4XTHda7gF3ArygZZQWrs9dXMLTUUigqS
	OradVFj79C7cfBmx60Tsu13M1jk40u5+R5ZKhaYofl0qUGT+f94/JXB2K9frHLgvR7ujr8
	Pnm27oINwT31HkH5StOEA3pIRbWUcZQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-fQ8n-mU9NEmGgRt6Rs_RAw-1; Mon, 21 Oct 2024 10:40:13 -0400
X-MC-Unique: fQ8n-mU9NEmGgRt6Rs_RAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431604a3b47so27217745e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 07:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521612; x=1730126412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ/ST2n2o+s+ljcXLA0TYyh1FPWIv37+D3gxR3SEmjE=;
        b=IR3iknFgsUU1/bPJeTmOvxME4jfKCHUTb3LnXQDemyEBj1RinsP18w4oWDPfYwCbsC
         m6/OVhBwLRWr8w6HZrPs4Ait12piTIYlfqemqly1m2cSfZCGTXsA1wxrmOQQNp4+PqqE
         Ne3peVdKRBHda4fP/xmedZREydUWDq4jaIn1ZCwVhiW573fH90AJeMIVYHlaYoawfOyW
         6307m/MSlzuFKOPqgqTKjcAgSdLWogIr7R1Q9iTck74nr5q1vTa2nUqqzORV2yxyzDX2
         kp15b2BctA16aqLX1/aisYBRdPNNR4BuTw3qp3U9ZkxaWd9hkCwKWJ1j/aPXxmzeg1qP
         JfQg==
X-Forwarded-Encrypted: i=1; AJvYcCVbf+98ttgKRXq4ifjjb6Nm2ITDKq0mBWkz31KFb+KkyplR2FEkAtl+o0+0mqJn2uwdbzlGsHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKRa5A3s5um25bkfuTnVhAMzqO7DbgIQrquVBq9PnuY4stwum
	XUI+MFMBAV8Ie8xx7Q4DTWo8g35jmMYg+7mwBlwMY3intFBH8hdrnMeGWNVOzsOzYU6395uVCEx
	7aSWRyzzYAfMDvtS5+cPQ9deNne+Nhdx0wQSoDGY+QFlpcEiuX5Nv1Q==
X-Received: by 2002:a5d:5271:0:b0:37d:387c:7092 with SMTP id ffacd0b85a97d-37eab4d1178mr6286642f8f.7.1729521612160;
        Mon, 21 Oct 2024 07:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7/5labcUqsZBuqFnZonhZTBc1BKmhXe+frMb36S+aYhl3kVjymM+TEQ1VQ61MDBDEBRa/Xg==
X-Received: by 2002:a5d:5271:0:b0:37d:387c:7092 with SMTP id ffacd0b85a97d-37eab4d1178mr6286623f8f.7.1729521611833;
        Mon, 21 Oct 2024 07:40:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a485dcsm4487102f8f.34.2024.10.21.07.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:40:11 -0700 (PDT)
Message-ID: <4f61bdef-69d0-46df-abd7-581a62142986@redhat.com>
Date: Mon, 21 Oct 2024 16:40:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] io_uring/zcrx: add copy fallback
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-15-dw@davidwei.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016185252.3746190-15-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 20:52, David Wei wrote:
> @@ -540,6 +562,34 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
>  	.scrub			= io_pp_zc_scrub,
>  };
>  
> +static void io_napi_refill(void *data)
> +{
> +	struct io_zc_refill_data *rd = data;
> +	struct io_zcrx_ifq *ifq = rd->ifq;
> +	netmem_ref netmem;
> +
> +	if (WARN_ON_ONCE(!ifq->pp))
> +		return;
> +
> +	netmem = page_pool_alloc_netmem(ifq->pp, GFP_ATOMIC | __GFP_NOWARN);
> +	if (!netmem)
> +		return;
> +	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> +		return;
> +
> +	rd->niov = netmem_to_net_iov(netmem);
> +}
> +
> +static struct net_iov *io_zc_get_buf_task_safe(struct io_zcrx_ifq *ifq)
> +{
> +	struct io_zc_refill_data rd = {
> +		.ifq = ifq,
> +	};
> +
> +	napi_execute(ifq->napi_id, io_napi_refill, &rd);

Under UDP flood the above has unbounded/unlimited execution time, unless
you set NAPI_STATE_PREFER_BUSY_POLL. Is the allocation schema here
somehow preventing such unlimited wait?

Thanks,

Paolo


