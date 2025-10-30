Return-Path: <netdev+bounces-234464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B0C20EDA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ACD1A63FA6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B15363370;
	Thu, 30 Oct 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blOdIk+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE222264F99
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837879; cv=none; b=mgt9GTXyEhIHeKOfWHcFg6yonxIh/mvceTRQijIJ3D10hmw90KRMY3DavFeVYUdDkqWJQit3A5NA/VOmIvSRQlhHFohVZ6AMKuA6BKhz2T8DnnMp1m3qX8jZxRCVUgWX8oAvv49AfQtxMVdrnqDUXHARWh64P3aiofWzI/uSjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837879; c=relaxed/simple;
	bh=8C45GNay6861gaofOOL4oU9RBTEls5L8G9ZvIb5db98=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDdijgIPKXO8/WRHkxIyw7KJTpDSnzaqrVcVVNLYOvTy80gKuEfEvVavjBjBTqALRVsiPlPhL+UDj8EZjrTKvZHHhKJ3ZleD8CS2T3LML1efQ9wcVdRTHVfKg1mCirYDni9ryME3U4GmYTbmyFK8Q8dFALEfuSm5NGXYKNbEots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blOdIk+Z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso689920f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761837876; x=1762442676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ppRB7YyVaZda9cCc1DXsVyW0gFyW4C6mJ0qs6JyLsnM=;
        b=blOdIk+ZwTsd0mrjX+C9+am32cuHs3v98qaW4MJ3Cz1qH9sGAQyDCg38ZmNoKlLrp6
         Gv9BV047AcGKPJJAtrRDWZzTpmTmbTEy1dByg0Y+kbe5QtL7+vPicoC33a1qoFyWE6oW
         yYPf+4KYzmyzo0XSoDoDiGbjyKVDe04GALtlbo/Eq/abIPok9i8Ee4Tb6Dr/5Z5f3aMt
         8pHcMU/hcJqCfJ5pspiIF2gFMfGCydnno1HbgOwymgPlqeM5SVgXEBOSgUwe9jf2JuIP
         M24wK/rOMl7Y0rbWtzWHtrkfoFbf1U92Yo6U2QT5moJQKZfs1OWGjTqp1RouGkUhJl33
         sAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837876; x=1762442676;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppRB7YyVaZda9cCc1DXsVyW0gFyW4C6mJ0qs6JyLsnM=;
        b=sSmz6TmzZWUUvIxQmuh/xqVa8/4YDOrG+GwZpp8mfwBOKpIjSFSrBc5fcKm6btB0cN
         SgOzv5XfCwgtIbcmZcaSw93et8X00ju94vCFiHC4lADx6Itj+doyCa65i4aQlETZ8lUM
         KnUN/t3IqUiOXwrqVY1IVHQCRwIwKIOp1Ti2Arb2eVSnFM78t4NNfJqyYWy+hVWPya/J
         iGIJasJkX4Y5tJi062xwxowHfurlWP4NdUzcjqvtT7pdkNitbH1ItvqhziUldoMSB/ax
         ktWXyJhjTa11wNZooZJVqHhXzaMYrzsq/SatSR3pxoKAA/9l8wV36Ci6YSKAX8S3fsgQ
         8rgw==
X-Forwarded-Encrypted: i=1; AJvYcCWXC1Te9+L5xoiMVX2hl66lQ9JXIsnlgRhD1/e49GSAq/z5PC6BghRCZI71sG1zeJmezJ6wmJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhR8dxZURks+2Ivl9mWmRFqIaP53j///Qwdk7JOLRCJ3rA8w3U
	K/sZLqJiSKx+6DNeZcq8JVYJGicopO8FDDAdqmZ3+qI9/TZI9uSPnM/t
X-Gm-Gg: ASbGnct+HpTY4aC4T0+F/oocOIfv4dA/5idVHrz7fKalQ+AI9Sk6v14M/DmhjuNSYdY
	sHFV1CfSFT5H63ISjgPa8FrQD6E/J0k8tVfc8jCFFuAHFZJQAVK8mgeVSqP0qkqLf2Bxix8Rc2b
	6PO9IRxfKlAQbahqzxnl26sTID0cnSsFdr7gqoLkw1gm0nA3wsDQrzb7f/N1+PyqaTq+5Xp6TvK
	tNfHLYCREhkYfVUvmPqcFtr3BxabNIjeSqAONbpkKoesCzLlnYnbOJebNVMVkVXtWT6FYzv0Bcn
	EyMLX85/2QcAH3sETHbxxjxbnAYdmeGIENq+LKCQz3sjiGSFvtM5J2IC9peNVqrbt5pQu29gHd2
	iTnBoeGQpOdSOS3Og0PcxNQfDk2fajXyDevLV1GFB2JIshOvWimIVw/uqwQSqKxx6nqr/OQ8pw6
	nsr1UQ+hicNnbRZN0qUXR9ZflW91n/rparBVgJAivolW715Yc8LNHXdkmd0KGQ4g==
X-Google-Smtp-Source: AGHT+IGTSPHyRHnpOIOisch7G5qfAF9ch437FEwTxTCgRLNzqnQFbmm7G2y8Ecy7rIZ9KTe8hn7EZA==
X-Received: by 2002:a05:6000:1843:b0:425:86b1:113a with SMTP id ffacd0b85a97d-429b4c68afamr3801431f8f.16.1761837875751;
        Thu, 30 Oct 2025 08:24:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429bca06fa5sm362612f8f.14.2025.10.30.08.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:24:35 -0700 (PDT)
Message-ID: <b0890420-6897-4ef9-a15a-8b9721ce85d0@gmail.com>
Date: Thu, 30 Oct 2025 15:24:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] io_uring/zcrx: add refcount to ifq and remove
 ifq->ctx
From: Pavel Begunkov <asml.silence@gmail.com>
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251028174639.1244592-1-dw@davidwei.uk>
 <20251028174639.1244592-8-dw@davidwei.uk>
 <810d45da-7d60-460a-a250-eacf07f3d005@gmail.com>
 <9fe0088d-f592-47c4-8b95-7c85a494cf70@gmail.com>
Content-Language: en-US
In-Reply-To: <9fe0088d-f592-47c4-8b95-7c85a494cf70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/25 16:16, Pavel Begunkov wrote:
> On 10/29/25 15:22, Pavel Begunkov wrote:
>> On 10/28/25 17:46, David Wei wrote:
...>>>   void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>>>   {
>>>       struct io_zcrx_ifq *ifq;
>>> @@ -743,7 +730,10 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>>>           }
>>>           if (!ifq)
>>>               break;
>>> -        io_zcrx_ifq_free(ifq);
>>> +        if (refcount_dec_and_test(&ifq->refs)) {
>>> +            io_zcrx_scrub(ifq);
>>> +            io_zcrx_ifq_free(ifq);
>>> +        }
>>>       }
>>>       xa_destroy(&ctx->zcrx_ctxs);
>>> @@ -894,15 +884,11 @@ static int io_pp_zc_init(struct page_pool *pp)
>>>       if (ret)
>>>           return ret;
>>> -    percpu_ref_get(&ifq->ctx->refs);
>>>       return 0;
>>
>> refcount_inc();
> 
> Which would add another ref cycle problem, the same that IIRC
> was solved with two step shutdown + release. I'll take a closer
> look.

The simplest solution is to keep the two 2 level release and
split refcounting for sharing. It's still better as now
shutdown can be folded into the io_uring ifq unregstration
helper.

https://github.com/isilence/linux.git zcrx/zcrx-sharing
https://github.com/isilence/liburing.git zcrx/zcrx-sharing

I fixed up synchronisation and drafted the export/import via
a file part, take a look.

-- 
Pavel Begunkov


