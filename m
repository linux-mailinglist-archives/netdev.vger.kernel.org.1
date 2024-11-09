Return-Path: <netdev+bounces-143553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37AE9C2F41
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1931C20CA0
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14191A00F8;
	Sat,  9 Nov 2024 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEZVPO7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2F19CD17
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178803; cv=none; b=M9vfhoNWZdU+Pfh35E4jqH8ctMs/n//tUCNtNNkz0rXG5n0SEJISl67KzJ3Pinux04CqaBOto2MJzQCY46ptMqy1edJHIuVjt/CwifFyRb6nEq3IvEsN3CtAtHiI4jr7qUNb/1r6vGLoNzkMfu0wdeZtN/xD96KcfTVW1tsDzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178803; c=relaxed/simple;
	bh=gWQ1fsV/EKNQ1SYWxhfLeUOgYsfznxy2WbQpMEuhICw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PlR4N/8kkXBLXgyRq2oOwCCii5ejtvJh+aV+/3C5gWE6j5OVsMG0cXc7bhxjKqX+erXbSJ0ZceHoY1p1c3wJSkkNie4xGXeRWoECwZSNN+q9FLnYZHZIOupaMZG/SmCnovNo2PaZ8RBOxiw+Tk8trCbD6XsaPHYMn9M8LOSWxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEZVPO7b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99e3b3a411so730065866b.0
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731178800; x=1731783600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiPop9LGrrRHWUIhFuPrz5fa3eJlYErNyH1umuFjMvc=;
        b=VEZVPO7bWmWL+AuKMpiAAr7TI1BYmhvGI2MUAJ3bZ3aeBzkWdmX4x/c/1vNIIBwcB6
         8YJt/9HdsYOj75gXQl0nqN6rBrle21KhdWNQWL1RPj6J33mPV7oOhZDFdTPI0uhd91Kp
         47UKZNK23vk+GFXyGDHWKxg4v8WusQoEt3GPgkIavaXRabxD3haAg05TFlfCXp2neq3O
         Z4svvuqF8IEC/zFm5JK1bUuluSKqlQtoxFfN0HXRifLva092wx25+9tcX2nimr6bAHby
         15WumwH2BxrctAuEH/HAudDNK+BPX2CMyM2E+lwG6ctJEDkCScJPVc9omEER1E1ghIxz
         OIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731178800; x=1731783600;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiPop9LGrrRHWUIhFuPrz5fa3eJlYErNyH1umuFjMvc=;
        b=NgoAt/wCit7YS/2sfGXi9s81orK9YXtqmZVtrRf843OfN/R9q7r9CgFLLydMq0H4kD
         PHJFD9NU+BsrZlHu7Qi/xloYKi4F9MDbG1FFXHsIZnntiZZCgeMt76uhGQyIqSBruEnV
         rblA6O9fXBRW9H2+dRlUc6id4iHNdoVHnhA7j8uWjI9I7uZz6tKZ+gFaT7jnvR9uHQI7
         /aklE4rY4q0cRhS4z8IJK1MVYfkPEAOv0YzM6s9W3Q7Q6QdhBHmVJZEKFyJV6TIaFnn0
         zxi1lPQPkr6Lqe5qMAq8tJGpGyp4iLgb+dP5plRc5XBibJMoh2iY2CSZ31K+INyAo1dA
         gbxA==
X-Forwarded-Encrypted: i=1; AJvYcCX8BVdVABHPvSzPPe6H2kK+PgHVBDSlGUKYLJ5fW/QgT8B28lc4RK0D4hg3OyvvcMTCB3fb5NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyty0Kur6ySE2hKKHZYQPzsjlji6L0B2osGAOHz8k2BaNZflPrG
	eVkuTxWRVsIV6RRzjR/M1eke5AD/51RjYBpHCULoAUCX16ygU/go
X-Google-Smtp-Source: AGHT+IFXuM71auCZGqemwloR58N+X5McUqn6dcn8Qk4+wLL1x+/oiHiMxDIhzu47kxuR7VfcLDOeIw==
X-Received: by 2002:a17:907:2da5:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9eeff97fe5mr730904666b.25.1731178799945;
        Sat, 09 Nov 2024 10:59:59 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def4b5sm394908866b.146.2024.11.09.10.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 10:59:59 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <ab19689f-c77e-4750-ba8a-b222ba4909d2@orange.com>
Date: Sat, 9 Nov 2024 19:59:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
 <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
 <CAM0EoMknpWa-GapPyWZzXhzaDe6xBb7rtOovTk6Dpd2X=acknA@mail.gmail.com>
 <7c4dc799-ebf6-47fe-a25f-bb84d6faa0cf@orange.com>
 <27c31e30-b2d6-43a4-8ad6-adbeb38db9ee@orange.com>
 <CAM0EoM=yX4yWrSrxU4PxVje9E-Qh1GcXkwWRqLybNmQhLXEaHg@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CAM0EoM=yX4yWrSrxU4PxVje9E-Qh1GcXkwWRqLybNmQhLXEaHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2024 14:07, Jamal Hadi Salim wrote:
> 
> BTW, what is your interest in u32? I am always curious about use
> cases. I gave a talk here:
> https://netdevconf.info/0x13/session.html?talk-tc-u-classifier

In first approximation, my motivation for u32 is very akin to your humorous
depiction pitting flower-for-humans against u32-for-machines... more seriously,
genericity is my primary concern, and I'm instantly convinced by the notion of a
scriptable mechanism that is really universal, as in "parse my custom protocol
without writing a kernel module".

Now today there is also nftables in raw payload mode, and with its hashing
features it might be possible to emulate a full u32 graph of hnodes/knodes. Not
sure about the perf though. And of course, in case of hardware offload, u32 wins.

I am also aware of tc-bpf. For trivial things without hash, directly writing the
cBPF assembly by hand is a serious contender. But if a hash is needed you must
go eBPF, with its heavier infrastructure.

Overall, it seems to me u32 still sits at a "sweet spot" of the
flexibility-performance tradeoff. Its actual usability by mortals is another
story, as Tom hinted at in the QA session of your talk :)



