Return-Path: <netdev+bounces-159143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DABAA1482E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75F63AB78C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2C1F5602;
	Fri, 17 Jan 2025 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YtdjXu6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE681E102D
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080230; cv=none; b=rWNtWs7+qi20XtyGbikb1IL9ENwo3qB9BatvzZOWPw++8d5pQW5d8eBclGnfTN3mI7SyN57dkcYIy5ZzK3y/YKBtUkUCFpLGXa0ZQVaEEM8y/FlkD326R3+4mOMorH+zzImxfv+4IrMeDGbGsK6gXYBhfx2hDgja+zjUK4L+JNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080230; c=relaxed/simple;
	bh=ER6R9v8AJ405d+Lt2Mt514FdtTe+EsxuWv5o+fgncbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjXshl6Op3zhazbKjP2qYMEkHde5T+DAR3NsCE9h7WdddImDb/J7YLmofXuz8jzCtFGbFOJ3hBBR4IEphg3gbDL2GQfM/urd/7Q0bO/UgFoITlLOHWI2jECwEXdBDW3XN9fyY5docfqaEL0wiaXeL5Qcoes5EHp++cfql1BwJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YtdjXu6y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216634dd574so18911605ad.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 18:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737080229; x=1737685029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsZWFpIqCOprVA8AcjoSvhBNijx2DjW619VHPTjVUAk=;
        b=YtdjXu6y6Q1y8a7t7ROyGcKfENnLNabvUeeTU6t7VJxb/5jA6/XGADVMNAu0d3IG8w
         L6g+Ssp1tb0MhoI+opXIgH+5xev6Z38DA2gi0jbTk9VBBaV5zWKZn0XA4nIe7Q4nStk8
         e1OplB5H9YWPOS3Z/ZZL76PiREmVfs865y++J38p3AiWTTLjCk34GVbx7ikFgrzng22m
         pBnlNR0v+q4uaqkj9sVrfox0Ta2qiVHjpxQhFnKEOObsnjpVVtdgo9YQUbottWXDMJ8G
         cdhSi/A6ZeC2TztXrTgtEIE+vb4Ml7NbfMCXubkpU7thhyu9QsUs34C517KDLUXo3oiu
         2tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737080229; x=1737685029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsZWFpIqCOprVA8AcjoSvhBNijx2DjW619VHPTjVUAk=;
        b=FzXvNTGQJ6o47QRnrHwbY2gRl75jk9v+as3rwknRJtRyNpZVFb7hGEy+F0h87p+VKv
         rfMJO9UbcumziFfhpt1HCq3Dlq/74OeSyghG+glq3RfAwafSKq0ebLjBJ+g5L8IY1Jwl
         TH7y/umqVW4dcvGEWUGqpq2IfRD1z8k+e+N63wy8y2UFUf6MJGLDTG5ob7HFkCnrKGCT
         vmpOpIngNuPmJYgqLGb8I4YDeOz5h6RJ+H46inyp2+M3DpOZ8xONg1ddc54Wco6Aop/K
         IaLmOF49L+yRu7NMqFt/lUx3HtUopANq72fMOWkmyILuUFD4eK3d2/+BQ+V1C7LHd0OD
         oKfA==
X-Forwarded-Encrypted: i=1; AJvYcCW2V91SO274+9a9In3FA30w0MvHdrfUXQOepdJ/vMlgMfN1zc36SHQE6WezAOGwDGnbpN1UJOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LMOWDbOfp+5pHT1FJYwitWXTSHLxy3glf+P96wv97r5EBgiW
	aWE7AIQ3UeKAB9g9dMdz2fYi5w/c2Q4rE3n1Iai9rGciFXzyBeVoP4B/QdUV10U=
X-Gm-Gg: ASbGncs/kZAbo692LE8n0e+xzTrMr7EmAzwrAIxR/UXWKwB2sKRkW0rNYEA/voeOK1H
	C90qxNejWZqSwL7f10AHkikKZjQZX/J4ZGwgXugT4XL7rkko7P47uMlRmXP9B4kKlR3itl1Wd56
	ApC70KZDV7SQqcRLYWgzlu0zcZd6KCtEVEhckHioLqsb53NZnDgYXgxIA2UojHhfEx0KXrpeTKN
	erD5xyl22bGdRKAVjL2mf+yKtRNUPzVmjMGEs0iRvAaNSMPhXPDun6BanN+l0HNUg83zgFszSz4
	CMhXNV7tf//r27jGMw==
X-Google-Smtp-Source: AGHT+IHtiBAE/AhhLy8BO56X9syo+nIgSxnlPcyPJAy0E09R2b5E766BPWXWUAjtbCwARxDq8bM2nA==
X-Received: by 2002:a05:6a20:12d6:b0:1e1:a576:aec with SMTP id adf61e73a8af0-1eb2145dc23mr1477497637.8.1737080228742;
        Thu, 16 Jan 2025 18:17:08 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:cf1:8047:5c7b:abf4? ([2620:10d:c090:500::4:b8ed])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcaa3a8e7sm617057a12.13.2025.01.16.18.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 18:17:08 -0800 (PST)
Message-ID: <8872441b-7de4-402e-a982-ceeab14e6e43@davidwei.uk>
Date: Thu, 16 Jan 2025 18:17:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 10/21] net: add helpers for setting a memory
 provider on an rx queue
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250116231704.2402455-1-dw@davidwei.uk>
 <20250116231704.2402455-11-dw@davidwei.uk>
 <20250116175256.6c1d341c@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250116175256.6c1d341c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-16 17:52, Jakub Kicinski wrote:
> On Thu, 16 Jan 2025 15:16:52 -0800 David Wei wrote:
>> +	ret = netdev_rx_queue_restart(dev, ifq_idx);
>> +	if (ret)
>> +		pr_devel("Could not restart queue %u after removing memory provider.\n",
>> +			 ifq_idx);
> 
> devmem does a WARN_ON() in this case, probably better to keep it
> consistent? In case you need to respin

Yeah I see it, thanks. It looks like I need to respin so I'll fix it up.

