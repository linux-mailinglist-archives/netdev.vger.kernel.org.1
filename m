Return-Path: <netdev+bounces-69993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D784D31E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7231F2598E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9F1EB5D;
	Wed,  7 Feb 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrYp0CNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADC1E525
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338622; cv=none; b=igzxP+nmKL02pHE9qmF+9o2u6J8aP6mOuAV985nilC/efew6HRbiiprTZ1qzOPkNbSFM3yPBmhmViXPBw2RLMtejq6wnusEALdrCFT/trI3Nbq+waIL7TkcuMLdKlxDAvwJGOPLb6O0c4AXoivnRPHYNfOp/ugFq1/5BQX8XUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338622; c=relaxed/simple;
	bh=aZnS/ozK9Q3nmtCH4KG36f1krg7vVVn/T7ZpY1pxZmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkIlGvEyMPjK4z8A3JVD0LagGW5VqLRT2p2ZTBWiajaPAEUIGMxucq9LyCP26jcvvvQ6CTxMIqsGYfvRf7idvRblrMtL3lGUqrp7ymuhKn9RTS4oUpxyMxLC/5/xfvnYU0/PBQFY3mWMHt+iUgCu4RRqUVpOndg3YeOtbrIcdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrYp0CNZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so14324741fa.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707338619; x=1707943419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HzOYbr0NlWwDE7ZwyyejfXX5ZbOEq5K4GY5Kn/91C1o=;
        b=CrYp0CNZImQAEGQHWEk9XvD2/ZVLQyL0zlb6BPqihIIKOkQJHVQ8kFcRPPub8AySig
         Tk48ym32Tfrk5bnEt+6OG7jgS0mtszSnyulfmW+ogt8usr81pY0IcbjRJQEjb1f6KxcV
         n0HbQtYlrP0YdWFNWQtVtMv92d9aTs0dDcAcQyFoqTPSM3fBM0GUnuj+FlLY2XaM0qAS
         ie2RyyL7VXKvidR7a8CVCuyYSH0qNap/ISsbBNfbPkFdKy30CmAB5rItAFQ5tR3R39MN
         akAfCYXmrl52kRE8dAZRqurAcuFoZv+e7eWRniaXRlwzUUMsvgtH1LMsWUM2BHU4etE6
         FP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338619; x=1707943419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzOYbr0NlWwDE7ZwyyejfXX5ZbOEq5K4GY5Kn/91C1o=;
        b=FC8RoQDfI3A+iEsrVD3iYlgatZRuyfNMLM/A1uqlwSJfOQpic8GXgT0hPH07uUckde
         Ardr57G0kR74Q97EcemzfJWUoIQLd25L+qreb7YOeaLS1J49hCRj2cYRVCFSP4xXbp47
         Wr+4cTGlO0WKf4eaeFsErrAUDNbx3TpPP7ga4XMYAmLck85b0/Ia+eldNdWYTk+FJsFE
         kmbT3GTKqNhVodIDWUD+LynIyNS0qtgqNK0a1juO2f4Pc6fPWQUKBkY4e+4rB547K3wO
         OsGZNg8Kd6OxTEZ6kqZ9fYxfXNEHMaXH8wk53xV1vFeAtar0TDoPss9fmoH2TgoPQEQJ
         YjLg==
X-Gm-Message-State: AOJu0YyDmy/TydzHY5LjVgq4WSHl2U+YoPovEGgQHQmyb61SonnDpx2n
	aAg/VAHD5aKWRZMQ/WLYJls0lcBGsK4i8WxHz+K54As2GkaMUecf
X-Google-Smtp-Source: AGHT+IGBQS91y9gY+0aH4WwVqQ/dQeWxl2QgQxDVFTEhBfN/2b3NZWmcIT76xW5kbMtkS1K9wWd9DQ==
X-Received: by 2002:a05:651c:a06:b0:2d0:cfe6:4364 with SMTP id k6-20020a05651c0a0600b002d0cfe64364mr990306ljq.36.1707338619010;
        Wed, 07 Feb 2024 12:43:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ40FjeOG2AlI7t3qC+R/P+/hIutP9r7AZSqCxtmW0oVi1teoBbz0J9SRl8wr9ogihaRTMDStnfjBuJOvydwXlXKI/8uyG+IQV0cuEJb0KKMB1tBdYMpwtJqNzl0oTbjPWBFrP6Q9p3Jc5I7NHDlr69ZUvb5Sldjxhx2GoZjOmOPJyzZrN+MtxqiSsJ6XX9issfjal
Received: from ?IPV6:2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a? (dynamic-2a01-0c22-76b1-9500-5d1b-fc9d-6dc2-024a.c22.pool.telefonica.de. [2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a])
        by smtp.googlemail.com with ESMTPSA id s5-20020a50d485000000b0055ff68cce5asm82619edi.27.2024.02.07.12.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 12:43:38 -0800 (PST)
Message-ID: <7edda20e-d8a2-4049-81a1-1ef946934bc6@gmail.com>
Date: Wed, 7 Feb 2024 21:43:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: remove setting LED default trigger, this
 is done by LED core now
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>
 <20240207200713.GN1297511@kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240207200713.GN1297511@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.02.2024 21:07, Simon Horman wrote:
> On Mon, Feb 05, 2024 at 10:54:08PM +0100, Heiner Kallweit wrote:
>> After 1c75c424bd43 ("leds: class: If no default trigger is given, make
>> hw_control trigger the default trigger") this line isn't needed any
>> longer.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> This patch looks fine to me,
> but the cited commit is not present in net-next.

It's present in linux-next. Not sure when it will show up in net-next.

