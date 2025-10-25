Return-Path: <netdev+bounces-232946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD16C0A111
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 01:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8323B9D7A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580332E3AE3;
	Sat, 25 Oct 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VHKrHPqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE6188713
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761435476; cv=none; b=ijepvxSBTb0ILTtYFWfb2KCe4okLVxeHont9PIVk7la8etBWOKv68kq9B4RIFPvAfxaveD1vmBHz858sUW5DY9FNJw4UtF8gLZKfobTWlFwzBq07RrV9veVTbyS4IdZbQSsxQ/WNCBHYJEUje/6MP60r4AvzpxG6sUiMBe8ZfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761435476; c=relaxed/simple;
	bh=Dx4U+Gaq/clGn09ECu7zSnUeMedBa7Zznmvzmrd2rLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9zjrQQgU8zaZAiR5GACpEqo8Aim5sFj2+t08mxoypkLU4jZWCqNZyoM1AwhTsFM8BSP+sagoGl2sdNKz2lvF0l+ug2UD7hmzQXJ+dV16EDSwb096MSCrpoylvro3X9kYdg/gJb8QxYrR3E7kjP05XzWvQga+KniXXPR0E4PgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VHKrHPqm; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430ce2c7581so14593335ab.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761435471; x=1762040271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uP2cTMdqoXM56t3bzPV291d+nRePd6UdCfenlgq7J4k=;
        b=VHKrHPqmGSTOJrRN+gRlmVRbs4/kD1ulbM2C/3bqRif9ZFgIb1rxP/aXs5UwHt9Igi
         ftsnA1IaBFFCFU60MwcO6zNrW9BHkMt/lUKmCWfxXX5Q8MO9kkrUzALY+YAbVjyCI8K1
         JBIiYNjNy8vdz1ciHlu7mlKB3YOmxTUs5XQ00t56zF7/JA9uCDHDOARjZ3un0mNVc7Ec
         rsTk9DHf/HGThu8Wi2BmZVEFRZcOlpuYEr7fz4ezZCd95xDfx1E5tjjYGrMWv25tjYdf
         IweGQGJYOONsFLFKds3ZaNqTGGVb1EK9uoteJ0+UiE+ghwzTogx7zW9Si0BMlteglZcM
         nNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761435471; x=1762040271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP2cTMdqoXM56t3bzPV291d+nRePd6UdCfenlgq7J4k=;
        b=gtzDnbOrd8uVb3fdKykfjxdfVPOSLQLbmMnmQ+doyLbhNHN/p89b57tQRrYpyZGaVS
         krLfYlrKul+g8rZayv4ottYKwVjL8Bo79OIRd6MgcnyxqUFmzBbJaIhJ7jr5BFYFFa1x
         UKvZHtzb/BtB3XRa65MxiAowipqEi2JbyQm31SOvK0Xi1mSyp0cqTun7T+SdyoMFN55h
         iFUf/ArNk+wj2W4iSJK39g9SXTKek/VlAuk4kZuIxqwBWXcwyhQc82p1VA68BQiqp7Yy
         319GKRYyD4y8LMmvH4vI39a+xgzJxNPleRzrElq36XKKA9PKhzWy4Hg8BMUs8ScHIGyr
         Mm/A==
X-Forwarded-Encrypted: i=1; AJvYcCUusk/lptfKo8lbowo3beabdm1vsRoTRZNAHfLyE+Zng0IDAw/HlHTTWoSI6tzbxiwL67O5rCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GyPDaDLWh3omcdDRS3hvxvk0Hb/gwy5Z+b1WMNOeHMzBhwAo
	M7oa/9xO4KewaUPG9vzs2wbjjUYfVLdgtScvs+tcF80h+qwlZHEJPjYFPHg74Ge0X5w=
X-Gm-Gg: ASbGnctypo9HDoCiT5IrC6SCpPWFjdeqcWBlM1sLfCHOaDwHJNpZK4PFbRfE4UG4hR1
	IvQShkjdlkfA2GCMxdJ71vXvpvjDsOIdnA3V5ek2UrXZZkfV9DAGcgYoFhiAES6uWmlHhT0ADBP
	2eFmRj1er0YGSdgaGlUECpsK+lzf+1ngZ6svA7aLekEvsqHPZv72YLnV3e+yTBurMEqaZz7hXqf
	K6LZ3behmZk1qwI5zhQAJXPd4BmVvUf8acwzCM411RoJNYrmfLt3/qGx5Ajl1rHcGBvlBAqbpyD
	K1sg8dQeEH9TlF9bJNFgXGYmrUk7iHFYdu6xC6eLB3RpFhK8zX+FJuZSraVbUQUx0ay1kBkbSuR
	RqINMjqkwBHIa7SCJF1oMZVWfIOkIGJtoJkHY6SG7UbsgX33dyUymZNEJ0OisOTINk6RIvcJd7w
	3ILeM5F1pu
X-Google-Smtp-Source: AGHT+IEUxjCHMUkVgNCW7r+20nOOVAyChpFQ4pF8QbECTAE7TkPei/vWPSqX65q+xvHnBbCesi2PeQ==
X-Received: by 2002:a05:6e02:1aaa:b0:430:b178:428a with SMTP id e9e14a558f8ab-430c52d7705mr441468165ab.22.1761435470947;
        Sat, 25 Oct 2025 16:37:50 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995e70csm1327153173.42.2025.10.25.16.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 16:37:49 -0700 (PDT)
Message-ID: <0a9d9e34-a351-4168-bbdc-3ca3b6c3e17b@kernel.dk>
Date: Sat, 25 Oct 2025 17:37:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] io_uring/zcrx: add refcount to struct io_zcrx_ifq
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
References: <20251025191504.3024224-1-dw@davidwei.uk>
 <20251025191504.3024224-3-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251025191504.3024224-3-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/25 1:15 PM, David Wei wrote:
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index a816f5902091..22d759307c16 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -730,6 +731,8 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
>  	lockdep_assert_held(&ctx->uring_lock);
>  
>  	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
> +		if (refcount_read(&ifq->refs) > 1)
> +			continue;

This is a bit odd, it's not an idiomatic way to use reference counts.
Why isn't this a refcount_dec_and_test()? Given that both the later grab
when sharing is enabled and the shutdown here are under the ->uring_lock
this may not matter, but it'd be a lot more obviously correct if it
looked ala:

		if (refcount_dec_and_test(&ifq->refs)) {
  			io_zcrx_scrub(ifq);
  			io_close_queue(ifq);
		}

instead?

-- 
Jens Axboe

