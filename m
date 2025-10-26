Return-Path: <netdev+bounces-232951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10CC0A254
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 05:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603E83AF6F8
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 04:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FADD24BBFD;
	Sun, 26 Oct 2025 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FAaDj5JM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA11D5154
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761451966; cv=none; b=CjDa6ip6Qyoews4eIC7Cnf0l7pSgQyOmz6pmLvLFgv7qOB0dLQt9hGHnoFrY/vRSc7A7L6TYrO7hcfqHZmwICVbU0J8hq6Ya+nraF5J98UwMIOniAPbGKKouRQHGF0/qRciBUpmGit4WJWU8AwDTJPHsgqdLR2KTGkRkJ7X/a/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761451966; c=relaxed/simple;
	bh=2/dZHmhJhlH4MffiFhm3aPFvIGWaDB0g96M31n6qWZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgF5tIH12+WkFBEsp1fZ2tGUlDur99L14ImkKtebHEZ3grJu1rgTR3R7QbhBmffXK6yEgnDUXL9+7M4J2XbW7wx1/JmWahwo1MhQPUQfF88luiJn9b1/4v61eZgSb0jcgdeyAMXh6fRw3nT7sJcUTBXAG5sEYXIK1xFZGMuPm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FAaDj5JM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso3258857a12.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 21:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761451964; x=1762056764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlWJak6gj08ZQP7zjfQtpMw/7X0ftaT95s6fHCzAXV0=;
        b=FAaDj5JMHJPxqj4K726ngE18Piv37CoxqfHE+1gTzTtFZh0kmhImGCgLqa6vW0Ao7d
         noIOqoCnpTDgs8z1za2uXzhMndTNsdaPBcpi9/TiaRLBkqKFsvfmUCjQTxWBJ0JOTjeD
         X6U4gBcv2+hV5tnl1K/dwjGVWwED5UwtLkoehoC6TW8OcB4kTwKurOWOR9Vv2xHIcCkg
         3HwLnbDVSVc2VE22gdgcUgMNq+fIK4LicfcmjHeekU5j16EDfa68bXcIgR7rmctelFsA
         t3Kx6muIzari6wdN/KpLcQx5NS5kUpZpGrTU83weMJg6/ukYkZgK2Yfzef5qhQdMdI7Y
         LHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761451964; x=1762056764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlWJak6gj08ZQP7zjfQtpMw/7X0ftaT95s6fHCzAXV0=;
        b=f7EkAfZrOT3hHIZfOL8NrEBlhy2azjPBxkinq8SeXEnM/1D2ye5z9kPBNH2kSlzjQw
         eXQq/C/SohUqZY9TQXt/+wWzPqF1ZSIFT87w2RFiLmLc4USnOCuLvZFNyFCV1SYml48Q
         KlOXx/modR9QYMfLy3tzhMJoJuQ9FUShPkaR663jMSsWxcKDa3u7ROrwQeO9PAuKZF8v
         291gPBg1C+MmQFshRULnO1TIWYIlQXh8ANE9S/A72VuWRga/exDSrzUBSfPZma3Kx0LD
         f2iX3oG0thF32RgBtQNQZ++VK8mqEFavEPRjBnN5kv4AmEeGC73UY6TAOJqq4IsEstFV
         MLNw==
X-Forwarded-Encrypted: i=1; AJvYcCWZm6f0PIADD05Y8VnZqedcpeqjGBGbjx5ZdWSmeOTjDeiU6tCWzSDoKYmC3Ix2FgIM783ZdYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFY0JwXJ91Afimnrcm6gi1sOyWxTqW7sCfuvEt75edFZj0Gxu
	17yxf1Mod2+cM2QX2QYzwigrHEhNWkDNglPx+5a6HOwSZWbN915/rahTx9TVGshJdyz8tXNn0sI
	tHaB9Ou8=
X-Gm-Gg: ASbGncvDGzvkBRMI8ojLMeQcRjrvhJR/Ndusmy0Qg0r9M3+Hw0FNIeTpOpG1f7TkLiw
	Q/F69kTexqfU5MlTp6GexG2siYolX9QWoxzZA1ZNOp46ERSxS77BdgHKjxu3WCoz0oZMAHNIPZu
	M87gSKJqq0ES57U8kRA1x0mUA5sh19+f1J8+B4+zfurxPfa66zoQVMAW/ruDa/471cMX+kRZ5Pg
	UXM4olllZ4Q7YiVaZ/LoWkUjNI9iBdB9/1DQFKOhGp+5DXgrxVd3fxH/Xl+XLUI93VDHEj11XGt
	GDkwWmUVQiOi2uTDeokiZdMMomDS/DcU9vXR9TuTDzScLC7j3xRZCTOjq8JrwAyoQKkXKEfQZVM
	QPzQ0M3AgxYExHpiOMLmf6yh1FO/O2MBcd5Ls3M3ex7qWNFNMzg4RQJ2G4u23KZMrL/du45O1aS
	qaqYO67IKus0KJ1P8rJPtPetjLy4hDHGcjCFvb9VeGkiMItQERPw==
X-Google-Smtp-Source: AGHT+IGB7CshQnduUy0EMlQ3fnGIaKG+LbcCIrjXUUhwz4rAG/fY5wM474RGdgCo8RoqbOh85gVPbA==
X-Received: by 2002:a17:902:fc4b:b0:267:b0e4:314e with SMTP id d9443c01a7336-290c9cbc851mr382015575ad.23.1761451964538;
        Sat, 25 Oct 2025 21:12:44 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d426e5sm39620705ad.79.2025.10.25.21.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 21:12:44 -0700 (PDT)
Message-ID: <ffdd2619-15d5-4393-87db-7a893f6d1fbf@davidwei.uk>
Date: Sat, 25 Oct 2025 21:12:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring/zcrx: share an ifq between rings
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
References: <20251025191504.3024224-1-dw@davidwei.uk>
 <20251025191504.3024224-4-dw@davidwei.uk>
 <f1fa5543-c637-435d-a189-5d942b1c7ebc@kernel.dk>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <f1fa5543-c637-435d-a189-5d942b1c7ebc@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-25 16:41, Jens Axboe wrote:
> On 10/25/25 1:15 PM, David Wei wrote:
>> @@ -541,6 +541,74 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
>>   	return ifq ? &ifq->region : NULL;
>>   }
>>   
>> +static int io_proxy_zcrx_ifq(struct io_ring_ctx *ctx,
>> +			     struct io_uring_zcrx_ifq_reg __user *arg,
>> +			     struct io_uring_zcrx_ifq_reg *reg)
>> +{
>> +	struct io_zcrx_ifq *ifq, *src_ifq;
>> +	struct io_ring_ctx *src_ctx;
>> +	struct file *file;
>> +	int src_fd, ret;
>> +	u32 src_id, id;
>> +
>> +	src_fd = reg->if_idx;
>> +	src_id = reg->if_rxq;
>> +
>> +	file = io_uring_register_get_file(src_fd, false);
>> +	if (IS_ERR(file))
>> +		return PTR_ERR(file);
>> +
>> +	src_ctx = file->private_data;
>> +	if (src_ctx == ctx)
>> +		return -EBADFD;
>> +
>> +	mutex_unlock(&ctx->uring_lock);
>> +	io_lock_two_rings(ctx, src_ctx);
>> +
>> +	ret = -EINVAL;
>> +	src_ifq = xa_load(&src_ctx->zcrx_ctxs, src_id);
>> +	if (!src_ifq || src_ifq->proxy)
>> +		goto err_unlock;
>> +
>> +	percpu_ref_get(&src_ctx->refs);
>> +	refcount_inc(&src_ifq->refs);
>> +
>> +	ifq = kzalloc(sizeof(*ifq), GFP_KERNEL);
> 
> This still needs a:
> 
> 	if (!ifq)
> 		handle error
> 
> addition, like mentioned for v1. Would probably make sense to just
> assume that everything is honky dory and allocate it upfront/early, and
> just kill it in the error path. Would probably help remove one of the
> goto labels.

Sorry I missed this during the splitting. Will include in v3.

> 
>> +	ifq->proxy = src_ifq;
> 
> For this, since the ifq is shared and reference counted, why don't they
> just point at the same memory here? Would avoid having this ->proxy
> thing and just skipping to that in other spots where the actual
> io_zcrx_ifq is required?
> 

I wanted a way to separate src and dst rings, while also decrementing
refcounts once and only once. I used separate ifq objects to do this,
but having learnt about xarray marks, I think I can use that instead.

