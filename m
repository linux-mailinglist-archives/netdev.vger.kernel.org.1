Return-Path: <netdev+bounces-213795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831AB26B8C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3049A5881E8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0F221FB6;
	Thu, 14 Aug 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjttK/Rm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4415E8B;
	Thu, 14 Aug 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186245; cv=none; b=pd/ab2sWsDzXP6oUi4PD5yh8zzbQkdCd7e4FwhfokD8cnpE1DFHhoXuc92PGeRgWSQrmlq5Em2AUhJvZza4yUUDZK1hY3iqH9N7InECjnXHLwEw/iIWyNGjxhTE2givOuDY/F0syPAGkx8etaQM9ffBJmLH6U50ocfaZpN8M5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186245; c=relaxed/simple;
	bh=t3MqfObdMhB/eNrcducvkgj1vjIjX96P5SMnnDq3ogc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fprnJQTFqbPne0mRiq8Gsio/Jnb88DiS9h1Cr/8mFibIBtGFQkUrdiLtNYp0ViHq0qmY/smmynwRavJ8HmPSvSNHDDMRSmFqVVBOyaqfI2C+/BXBRmJdrT53EbRdDEr+6GV6XCUxF1h8zlF2Tch0SFX5W0gpdxCrfqPoCQ5XJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjttK/Rm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so640669f8f.1;
        Thu, 14 Aug 2025 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186242; x=1755791042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eT6EXaXfAgPUtCDoo+js557olCIIOh9kVJvS1JST3g=;
        b=kjttK/Rm+M4al45/rjFmEl/wS7VkhKUlnYJug9F6xG72uvXrbHl6MfmeekRg+W5X+3
         V2I2izBwE9TAWrvoNJ4zYSNDGye/sqG/o0C5sMx5jajz6a7nVaRPxe8ur2JG4ZNZOF9G
         AFZDacG6evB3SPa54aeOQC8zR4nhqeh2ZrcwsKiY8Q+8wt8kVoo/t5y1371NRBo1xt9v
         Wy+yAgTszrgF1oX6k322YBOPiSlH4r25/z0jOWlMvNy3Q4Pty9TMPY5dhEp3DEBX6moM
         50oRG4y09oUyi7ErO8NzO9OC/+50yOr1J3V+oT+BEj2YkkFmfD2le1iRSx7RHzrGyUhj
         MRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186242; x=1755791042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eT6EXaXfAgPUtCDoo+js557olCIIOh9kVJvS1JST3g=;
        b=wHIJj4MIUc4LOIeVf338zsl9a/B72G356RIkn/ANM9OnBe8BIOHFH6HV3ne1LRlsGA
         6hJV0Kf/zs10Nb7NG6bGkKZ+IDneITtBZv/x/PZmUEMSq3W+VJrLVKorYG7kHy/piTF2
         ub8pHj1Zcr3MI1EsENr0+ULatZWlc2nBn6Za1SFFiIVCMBGwmiAVvMKiJcuHZnhLmrv2
         Azxb1N+0umZ+VJnBoOvVWDEj9lkgltVEPgYyOmwPMreXtl+yQIu75LSlHrqKJ0m+RGlO
         Kf7YtAh/e4GmN0d39kv6cXH740Rjw/xJlCSyVGqOpEj0d0wy4OhUWgeqjYeKHhRR+ViU
         20bw==
X-Forwarded-Encrypted: i=1; AJvYcCUzF4fC4jKMDePp6ibyUC2PP/faLK8lSbLLi4cA6WfsJAZHcl9ua5HirOGkjqyV5hg0rxZDjBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyA25/D5aN7RmnugMJthfvLAcW82A4tH195rAmG+j5hT/FE4d
	i0ioatQH8ZLUzo8ncSSYLSWhXl/aN0bzYn1NAbAk7Q/tnTcLcA32E5ag
X-Gm-Gg: ASbGncs8Ko4uIdlPF1OYQeWdrFYBdW7XvqaK8X7L9M0QOXAiIpizpanRLulPJMpNli/
	NMoiTskre04p+rcFrP5Sn/VzAOL9R0Qofn9fYM4AN3qGQCZXTd88OmpdWaTXZFxOSa8XRHIqUtL
	8CuYNAC+JXcjs+oIKEtuxBXdZsABEpF0Vd63IIAj9UeMTSBf+pPFiODXpWi+A7biIwPzGrfYjFh
	EII8+4nTmcjM0VcJHiXihWzfYLqdg2Dh4t7tLZhtLRRm+hj1Y2Cp3+X1niRHgRzusoOC/46SNG2
	w01AMoPexjejPH+aQ0QQSFg9tErT4IDOtwsmKYhY+SViyOfqux12aXnlaigaHc647NH5E5KPQuE
	2zo8j2usT9lniwvYATU+bnPseFKg1Y2miFLcu3h5aybf7VQ==
X-Google-Smtp-Source: AGHT+IEUyPPY/ilyCvI0pwfT8QaROBfvAnjlt5odJQI/7Ysk04frv8GmG9vqxGJ2NZBMPkYNXsa7Qw==
X-Received: by 2002:a05:6000:1445:b0:3b8:d0bb:7554 with SMTP id ffacd0b85a97d-3b9e4158a5bmr3254886f8f.7.1755186242191;
        Thu, 14 Aug 2025 08:44:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:64dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ba50f369ecsm2612704f8f.48.2025.08.14.08.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:44:01 -0700 (PDT)
Message-ID: <001d822f-2f78-4ba5-b29f-23ec1813d3d4@gmail.com>
Date: Thu, 14 Aug 2025 16:45:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
To: Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
 paulmck@kernel.org, kuba@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 boqun.feng@gmail.com
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 11:16, Breno Leitao wrote:
> Hello Mike,
> 
> On Wed, Aug 13, 2025 at 06:14:36AM +0200, Mike Galbraith wrote:
>> [  107.984942] Chain exists of:
>>                   console_owner --> target_list_lock --> &fq->lock
>>
>> [  107.984947]  Possible interrupt unsafe locking scenario:
>>
>> [  107.984948]        CPU0                    CPU1
>> [  107.984949]        ----                    ----
>> [  107.984950]   lock(&fq->lock);
>> [  107.984952]                                local_irq_disable();
>> [  107.984952]                                lock(console_owner);
>> [  107.984954]                                lock(target_list_lock);
> 
> Thanks for the report. I _think_ I understand the problem, it should be
> easier to see it while thinking about a single CPU:
> 
>   1) lock(&fq->lock); 			// This is not hard irq safe log
>   2) IRQ					// IRQ hits the while the lock is held
>   2.1) printk() 				// WARNs and printk can in fact happen during IRQs
>   2.2) netconsole subsystem 		/// target_list_lock is not important and can be ignored
>   2.2) netpoll 				// net poll will call the network subsystem to send the packet
>   2.3) lock(&fq->lock);			// Try to get the lock while the lock was already held
>   3) Dead lock!
> 
> Given fq->lock is not IRQ safe, then this is a possible deadlock.
> 
> In fact, I would say that FQ is not the only lock that might get into
> this deadlock.
> 
> Possible solutions that come to my mind:
> 
> 1) make those lock (fq->lock and TX locks) IRQ safe

And I'm pretty sure the list is not exhaustive.

>   * cons: This has network performance penalties, and very intrusive.
> 2) Making printk from IRQs deferred. Calling `printk_deferred_enter` at
>     IRQs handlers ?!

It'd only help if the deferred printk doesn't need the
console_lock / doesn't disable irqs.

>   * Cons: This will add latency to printk() inside IRQs.
> 3) Create a deferred mechanism inside netconsole, that would buffer and
>     defer the TX of the packet to outside of the IRQs.
>     a) Basically on netconsole, check if it is being invoke inside an
>     IRQ, then buffer the message and it it at Softirq/task context.
>   * Cons: this would use extra memory for printks() inside IRQs and also
>     latency (netconsole only).

That should work, we basically need to pull xmit out of the
console_lock protected section, and deferring is not a bad option

> Let me add some other developers who might have other opinions and help
> to decide what is the best approach.

-- 
Pavel Begunkov


