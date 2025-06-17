Return-Path: <netdev+bounces-198821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C1ADDF14
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCD0189CACE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4B28C029;
	Tue, 17 Jun 2025 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FrJSd+iw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08D2F530F
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200114; cv=none; b=BvwD3dx8rYfteEmj+aDMjeF0oWOCmyKW3SJSh+aQx4vK7P0N+7RDoRQOArJs0/FuBm46+/XgzGr9ZSSDsaV8ZupI1d8FlSDtir72NFqIFhwhAveqQmDUgklnqdq2uEFNFKMWTDZk1MEs9JgJEfQhARkVrkmoSSE02g+i1vxPCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200114; c=relaxed/simple;
	bh=Wyltk7WgG08mOczXamgtSq84WvzFMAeDsL758G/jJsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3P+Kg1v6aXxNxZuNGrVnBFhpcGXxEt54Ybf15fpnXj6gZmS/NzcHVWTJdKKl+Nx5obUX7t606gxSqxo9rDYjpctaCXYK+zmoZy8i4G+t37Zw27e63p2lAMHqmlnrVjkJ0q2U+f2EHraNoEx6Vhsb8NkzaMjLekRxthC/bRnJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FrJSd+iw; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-86d02c3aab0so214135839f.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750200111; x=1750804911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88AIS/uYpf8Ers2JSTN9a2I7eTl96ZTUl8zjwBbs8g8=;
        b=FrJSd+iwLta6VuD1eoa0mqK7gXtGVyIVuLhKwHPRlrGi3N06PSsfzZ1JX+TbF5l8Md
         sJ/noldQceTRie2fgEMmhzKfb9tvl7sZQELadLH9EDy4n7P89sugYUXmwUGZ5Cn3ZgiP
         dNhwYKqU4GdfoIX/moJ75R8rocawHaTRQ2Jq8oPGY9YLaennG7fA7bR+QEEoTtDnh/tu
         Ml0AZdMLTd3kv+GSL8dHkmMPyJYkbNH+PkKgJUucFI8+iYmBUsvTb4bidYcB2da0+hGs
         BuEJtMmdLZEEUCTIbnfmihLI7okNfm0YeOWKe8MF5W7ALKubnBFyjCbkhbPlV3k3gjJ0
         w+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750200111; x=1750804911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88AIS/uYpf8Ers2JSTN9a2I7eTl96ZTUl8zjwBbs8g8=;
        b=b6WI+qp2HVdJsaOHk8mE8rrrYNwydLfA09v5S2oMLfdPODzAhQWOqjCY6pd+24aLdp
         MUzJm4XXJ24kF8jNSV08GugbrNfBEejXxssev144TwaZakd13yAlyb2p05vI8JNQJuup
         sLDcxJzOkdjxcZ5zJZXX9t86aafMfr1c1/Dtb7FN3a7naDgv+oVkupOmP+sJDuNseNFp
         87qmFlfBe3DJBt1Awfr8+/bYTI9HXLCS9z6SeOZHHsK+46VvuU87bReGQGwWLhpVq5W7
         a26A+2P/ZydyJStmyhikG5wdCaAkcI0oPXvk5eSE9dF4PtIKMjQ8gaClacjNWy0HoDbg
         F4dg==
X-Forwarded-Encrypted: i=1; AJvYcCW1AU3EIBulABP2tSnD7uLzqneDxtPrAu285nsTTixfv6vKXusj94H038Rl1MEcH/fBjpCc2no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUv+sBodS24/yWjdF98gI/UVRe08z10+O9FlOu2B8SXffW4yE
	qBB4GJc7uUnpHb7ywwsN/aSZZ/L59fR//ig4d9ZGxPCG2Ut4YLw7hqymFMm0xatqomIwV1BjDEP
	1Otw9
X-Gm-Gg: ASbGncu14haqSD3/0VoRwysd3BMWLLmLX0iUr/0G05S+X0QnVYBF+WDElng+VVAhANA
	39uvlsKoH006MH9gr/feMFBwTq+SdhwQx05WvQ8nqhzPdWZV7jEA8qVLdPYgs7/OPi2CgFzeUQf
	g3bwJ+9jxpTAsgHbRwavVM8XBfnzkU942l99LaATgYJsczSks4/ZSltmLR9Y4dyoAnVAVU97CC8
	Nb0lJGaJkNE8xIw+4V/4w5+YFPcmWJ1v66IoCAJd4493rKdjW/2o/IGAe5aT/6jjCSztywwWRXX
	ZxAHzP/h2kKdY7KjokctcXhMLTH9UPawZxfEuH5GOKSrO2pt/h40W5I9lL8=
X-Google-Smtp-Source: AGHT+IGabjx/K+Ldb960ZHsK5LrY46RJJYXxfIDNiBSQIP3DDgEsXOqQ/dovSOae+v/UL5y7DOAm5A==
X-Received: by 2002:a05:6602:3ca:b0:861:7d39:d4d3 with SMTP id ca18e2360f4ac-875ded02b89mr1630771439f.3.1750200111327;
        Tue, 17 Jun 2025 15:41:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d572b8bdsm240271139f.18.2025.06.17.15.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 15:41:50 -0700 (PDT)
Message-ID: <0e5399ff-c315-4810-bbdd-18c95a2afe78@kernel.dk>
Date: Tue, 17 Jun 2025 16:41:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] io_uring cmd for tx timestamps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1750065793.git.asml.silence@gmail.com>
 <efd53c47-4be9-4a91-aef1-7f0cb8bae750@kernel.dk>
 <20250617152923.01c274a1@kernel.org>
 <520fa72f-1105-42f6-a16f-050873be8742@kernel.dk>
 <20250617154103.519b5b9d@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250617154103.519b5b9d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 4:41 PM, Jakub Kicinski wrote:
> On Tue, 17 Jun 2025 16:33:20 -0600 Jens Axboe wrote:
>>>> Sounds like we're good to queue this up for 6.17?  
>>>
>>> I think so. Can I apply patch 1 off v6.16-rc1 and merge it in to
>>> net-next? Hash will be 2410251cde0bac9f6, you can pull that across.
>>> LMK if that works.  
>>
>> Can we put it in a separate branch and merge it into both? Otherwise
>> my branch will get a bunch of unrelated commits, and pulling an
>> unnamed sha is pretty iffy.
> 
> Like this?
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git timestamp-for-jens

Perfect, thanks Jakub!

-- 
Jens Axboe


