Return-Path: <netdev+bounces-232965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C770C0A878
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371203AECE8
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB219F40B;
	Sun, 26 Oct 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K4DCAOJX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD7749C
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761484595; cv=none; b=djPZGaont32ByLwg6YAolLcTnjbAHfEyU1S0toq1XcWtdSZRpnkH743ijviMTeqeBM/gG8sgAA23jOHI5k62m50fmBRnqZbqPiTjEzPbr2TWUNOUEqcFIiH5BbojmNorbWZd6v5nsypqmIczGi9qCdUnCxgH8mpTuQ0kOW8fz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761484595; c=relaxed/simple;
	bh=SERo0fpHLJ6iN9CZvXvaItAVNwQzTh5UAwKP7FYDghI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqFNxL7agt+BZCeAKOziqUwK6BmiSZF+sHKskmcdsZQ0ZmYiOxVoNRoJugpmlud4DPE0KYD+cL6eVzem3Hqap1Yqk1l7zTkpMNawXj92P5d8e4nd5Dyr8mxPV2CpPvnhZFpVKwt0B5Gr8X5004iBqUmhR4IxHbIDHDGiQN0fvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K4DCAOJX; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430d78a15b1so36988075ab.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761484592; x=1762089392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Je2G6oS0diRsBc1xkoypa2q+3cXAdySawINjZn0hOes=;
        b=K4DCAOJXcOR87xnT3rI6SUlnE9nU96qH6cRHiy+Z/OKc44i8ILL3cnLDwae9w/pBbj
         kK+GkhqekXPse3FgDWmBJQZ424o1AQr3omUwKwURKz8fYbAhd0zzQ8liKXmFTgLglVGN
         wpo9fYOLer9O2OW6Ts++N3ESmriYW7d8k2pcaKdiRBk4tNpmXulNwOV5W8oRQX859UIp
         /kEoAPYvpPXHV0RDumnNQQHk3iLFdjFMCdcuNR8foaC+mwc+NVLAqZ2l05dDBe4E5J9g
         wg7iPPGtR1lYoUzCA7+JbZ1XY23zSS9EXQegdYAukMAmnB8ZK1e7b4KnUI5o249aQ+Kt
         5FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761484592; x=1762089392;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Je2G6oS0diRsBc1xkoypa2q+3cXAdySawINjZn0hOes=;
        b=NyBeNMfyq46RJPMSMLIi5X1YFQPR8fSSJr64l0ZdxMk+Cj2GB1DCtDFZr/5iuZI7Lb
         7WpVNjGm7Vwu3bS8UwdCi1BNbeY+PTjJgCeUThU7w+yZ+BcNSwUcYyNZuGhGjf9XBv/z
         L1pktsltQv4mBS+1K0Ec/MIOwqYXWKIRYkSSKWkYWHXJo2UnJ6lUzW2D6gFCNNs9GTeE
         /usfUlGs1UKraNKLZrnUo30f/3jkApdlcGxEM5RrY9JFNYJqGZfCn4jD4ArjUz2RmqAO
         LUDLLhoAZgFLlYHPlF1GYPIQVCVATQqF1uevioNwFzGu0omHzlI5aOE6Ou/0G7oy1LqU
         PsTA==
X-Forwarded-Encrypted: i=1; AJvYcCXoaB7tT4xfC40zVmxgjbUxiKALcSHiWmyJJ03teQI1QjMTwsDmS/ee4FFOhA/JuiUILwt6jsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnqj7luEUYbYP26ObM8/BM3JkGNrAPRm76P+SAIdVsT5K0DZKs
	H45v5v2XahvtgH8vZOiFT/iJ1hbaj1lHqWVlRUOBnz+TPQG6/ixeeQWc7OWlmPNltSdn/umpoEr
	D4fRFuSM=
X-Gm-Gg: ASbGncueH4ss/Rs0OTiKxYJzRm16lp2ljQ3UhLjwIZFk8k/noPCH7zM7nUfNXRhlVSj
	g5OAYaDrEVPW/Khs9lTdMNxz8S8+5ErVJvr1OfsWJMMWZBdTlja1LwRpT3LFwfJu1zvkeZ7tDQ5
	jxodwai44E6aP6pzdDX6/ZsRcA/scWGOXUM3uCY3bXxwaZZiZ63ojrnUG5PH+Jx0TBjGUXTfGd2
	va2p0xg2vl6aVvaDWY8epwC5o24q5xKacMHsN2DdICXgypDYS/9n3SCv5oQHHtjEMjBniDuDma/
	RXZTOpLdDS2RSGaDGpevet79MtuzF8toHVM5o3zcUgNNb4qhhENRc1/dcb7PhLmjletZox/lNrl
	VMNTN7Sl3cewKa3LU/vFgCSVg14lU2cviDfdSAcCY1hzTDIKzdo6+tQbsgCIx1vDQQZskwxf1fI
	1aOmzU2PpW
X-Google-Smtp-Source: AGHT+IFYc55UFA7cxHsnoKidSYgwjCNGGkmSuK1XFsIhHJj5qglvRcSPZriyxg1o6xWyafqqzNnJ+g==
X-Received: by 2002:a92:cda3:0:b0:430:c1ba:3558 with SMTP id e9e14a558f8ab-430c5268daamr314115775ab.18.1761484591776;
        Sun, 26 Oct 2025 06:16:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6899e76sm18805135ab.34.2025.10.26.06.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 06:16:30 -0700 (PDT)
Message-ID: <3a7a2318-09fb-41d2-9ba1-9d60c7e417a6@kernel.dk>
Date: Sun, 26 Oct 2025 07:16:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring/zcrx: share an ifq between rings
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
References: <20251025191504.3024224-1-dw@davidwei.uk>
 <20251025191504.3024224-4-dw@davidwei.uk>
 <f1fa5543-c637-435d-a189-5d942b1c7ebc@kernel.dk>
 <ffdd2619-15d5-4393-87db-7a893f6d1fbf@davidwei.uk>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <ffdd2619-15d5-4393-87db-7a893f6d1fbf@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/25 10:12 PM, David Wei wrote:
> Sorry I missed this during the splitting. Will include in v3.
> 
>>
>>> +    ifq->proxy = src_ifq;
>>
>> For this, since the ifq is shared and reference counted, why don't they
>> just point at the same memory here? Would avoid having this ->proxy
>> thing and just skipping to that in other spots where the actual
>> io_zcrx_ifq is required?
>>
> 
> I wanted a way to separate src and dst rings, while also decrementing
> refcounts once and only once. I used separate ifq objects to do this,
> but having learnt about xarray marks, I think I can use that instead.

I'm confused, why do you even need that? You already have
ifq->proxy which is just a "link" to the shared queue, why aren't both
rings just using the same ifq structure? You already increment the
refcount when you add proxy, why can't the new ring just store the same
ifq?

-- 
Jens Axboe

