Return-Path: <netdev+bounces-143600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2FB9C3349
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24391F210EF
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2922619;
	Sun, 10 Nov 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgjUO47b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304ADA923
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253232; cv=none; b=uq3WZ7n00p84l22BNU1cqGX3XKZ7Y3qn4FeJeEJHWa7b3wzhqgUJMNOG2cFaUhNpH9bZMt3DFsbEfrSKSh9wIgw1Lagn28i1jZ4GXJnsUjBb9ZUsu72pwqnYaIuL0JHOwV1GU4UlGJZWYZrfQJDkTixk9QpTT68ZiF5WlKHMc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253232; c=relaxed/simple;
	bh=5XxAkAq3UZgJiM5aihae2lB0CCfDd4se0OwXaJCUpho=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qettA7nJhyMUQzg366OMsK8MWM/pn10cTKjCz42L0nmgc4+o96zM2gQJlXnn2nKnVilL/f+nIMbYr9wsJPtlnOJpkrTUjInQgAe1Qgiqn+oMyp5rAc4GVynAHZJ01XPi+SoNSE5oxRP+MwkhX2xFcnkLAnTNUuYhsFb9bLRgsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgjUO47b; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso8424623a12.0
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731253229; x=1731858029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYW6fqH0S6N8pgNTWzo9XUIJrI9KH8rEgXjf07oMRK8=;
        b=hgjUO47b0Fo+ddQceHjEc3g/0i/ykNwfwRUpIMFpHgYeKC55qW124khj2NLAdAiX8D
         sQZtShTAmEcePh1eEvIyOneGN52sEIJOfoiBhTfYS73d4GzKSwvi9PZ4Rvt4jdSk/kvp
         jNLgBuMRQUZxQGGeBBr4ZRI6I+XeaNkucvHcd0CrXWl9ltDaoBBPiQE1n6dYxbdrki9d
         2MhI53I8WWUZbo1Fbl9itTpCH+c5atOZb/4LyBqYslII8lVf7gxUKLrNfffbKkzqpHVB
         aUgN+0ZtsVR7j9Ki85QRJRIHUd2l00lV1QD5b8aP+ijNS7+rggnwzM6kV7uPBYrG+sTb
         4wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731253229; x=1731858029;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYW6fqH0S6N8pgNTWzo9XUIJrI9KH8rEgXjf07oMRK8=;
        b=AbejAbNc7FFW0BVenQWKsR0afuUPqP/XBL2Jm+/mG8lrOzROIyE8gNw+85X0Tk476Y
         2JnTwV14OVuQaWCInYdobu1Z+pw/l4UTla+y+jHB9cTUbeDDmTIpNfipBjea7tKLwURC
         iLSdQLNKXgeC/MBNsYO4slzEtpWSHqHveeik+lzBsiTEDNzLw0wofLU0TANgqrPq9QSI
         ZIHwDGSO7EX0aEOjLfUYn5H/DIqwoJ3V7yOPgXpY4ChYSCdPbCC9g7zVfSSUNQEnw3qT
         pvs4GW7E3ut0B7YASwiiX6OoYELUzMfx/LH5gZd7Hs1azBU+uPDE2Hjf4ZhPBVg4MEpl
         AcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHpirvdfkWvL1OfdBLh2Ma/FmLQPTqneSzoSbC8/2phrTkNMp86O7sbjhry7iL7TEl7xck2sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUf0KFOgKpEW76p1EZLVhDI1/wCP6ufC5aa3I1+hUcFIcNgTjn
	p1D419Rn1DAz3H0T6aJ6pIlnKYObTC/6EF79mxUiRsbbHrF+ywcV
X-Google-Smtp-Source: AGHT+IHvFFWhaFxLOs0Kc5l2Ua8MtvXdAmtcFcug7K30C4I/l+xUry7vobjcBmVSs0WX4+cnW3yycg==
X-Received: by 2002:a17:907:a0c9:b0:a99:ff33:9ba5 with SMTP id a640c23a62f3a-a9eeca85d1amr947738266b.24.1731253229101;
        Sun, 10 Nov 2024 07:40:29 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17684sm490254066b.34.2024.11.10.07.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 07:40:28 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com>
Date: Sun, 10 Nov 2024 16:40:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Simon Horman <horms@kernel.org>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
 <20241110140017.GS4507@kernel.org>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <20241110140017.GS4507@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2024 15:00, Simon Horman wrote:
> On Mon, Nov 04, 2024 at 10:51:01PM +0100, Alexandre Ferrieux wrote:
>> 
>> I believe you mean "let the compiler decide whether to _inline_ it or not".
>> Sure, with a sufficiently modern Gcc this will do. However, what about more
>> exotic environments ? Wouldn't it risk a perf regression for style reasons ?
>> 
>> And speaking of style, what about the dozens of instances of "static inline" in
>> net/sched/*.c alone ? Why is it a concern suddenly ?
> 
> Hi Alexandre,
> 
> It's not suddenly a concern. It is a long standing style guideline for
> Networking code, even if not always followed. Possibly some of the code
> you have found in net/sched/*.c is even longer standing than the
> guideline.
> 
> Please don't add new instances of inline to .c files unless there is a
> demonstrable - usually performance - reason to do so.

Sure, I will abide in the next version :)

That said, please note it is hard to understand why such a rule would be
enforced both locally and tacitly. Things would be entirely different if it were
listed in coding-style.rst, advertising both consensus and wide applicability.


