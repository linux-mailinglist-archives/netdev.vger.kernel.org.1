Return-Path: <netdev+bounces-165049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635BFA30348
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01511886864
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DA1E5B7D;
	Tue, 11 Feb 2025 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNDNPVtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F051D88C3;
	Tue, 11 Feb 2025 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254426; cv=none; b=KXLRbGE8kKx36vzhYzBy4WetoDsQ5rIalMbiW8qLbfhhhD9JxdjHPUC8g65z/ddzhZIsRfjdaifrXm33TPkJ50YZtNKc7GdC2BZDgHguE61aTWsKjTcI5F7SD62XHAnbXNZJfIPUruooSrPH5PsMt2XNstqGpNr4o6M8z3JqCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254426; c=relaxed/simple;
	bh=4b5Tf+cYF+aJZMs/vLmquYipLIib6Dzh/h5Xf6SxyHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HulWJPSH1uh5VJgFFTtKZG+1xBzM7WGo4r6NXg+zyWGIAsa/YMsU0IlCS4bxuIwIwb3eEyxTmVQsPgAV2coWUrSfd7kaHCmmv4Oqtt8XWOf5PVKphbW9sWtHhAPFmjyGXph6tG+JeZK1rvB9zRfbcQgWOpJIP18iDHNKi/SL0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNDNPVtd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so794951566b.1;
        Mon, 10 Feb 2025 22:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739254423; x=1739859223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZwmuG6fIwYgavBTh3pe7ZVdONpeTaMmZEJ19dTNbeM=;
        b=eNDNPVtdvkI81/Tgt9kZJ+zQ6TeLXQzOiPfvLAYz03bK2gU3OANjMJXLYMzpgb5Foi
         YLWkeiJANg5XBanv9qy5+/zOXXVDvOcwWu87yahVPqxhBS+kPY+bU0R0LlkpgZpOhbzd
         8oxg7+3Un2PaEj/Bj6yxMsOkkrYaCqxoW06v78F6fdBIe6DCksIcfEIWffTPlwBn62yt
         769gH/ZZ2iAIUIXQKTVCZ1Q5qctGT1QmfVtPk7L4GJbiyyRYzEpZzc49UV27riYy25mc
         DGfnICmZvq3qMVMBizTBRaoaFbeQZGjOv6l2tIfcnKqH0e2wzo0scaM19eJu5dnc961x
         kYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739254423; x=1739859223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZwmuG6fIwYgavBTh3pe7ZVdONpeTaMmZEJ19dTNbeM=;
        b=ZTAQwXVAe/aBJ93Ybv0JMYYPa6/J6Elk4qt6vegE3GL2eI8ux70su3/9hBRmg/9Uw4
         AaPULXLcWZvJKmio7UfhDMau0RncvofgbYUhOdPHaQPpmd448mswY5Imr2egO1QJvxoq
         tya7/dC6Vadgkc4LHC1cgGCQ284rrZ/GtBRf74dR/No7UPjlodcFlUybgXxRQ0WBl6IG
         kIrhbqJUs74f4D++LTb/tJNps9hPzZU4HsLb5Xye/wrmfjIHlTVehtzYJLfXnggtLWXW
         /K0Jg/KvVb3vkZAwJsR9S1bJ8xlFJPFERs/ecOlSUJSiWLwPrlFrcg+fbPnylT0NUavd
         Gvcg==
X-Forwarded-Encrypted: i=1; AJvYcCUD9BT1pvobGoEInnTTvU0sW5vIywm5QZg8YYYzBFsOOz+hIzwCF1vN5IjciRV03KHqz0MLF2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/tDLrfN+568zExQGfvKIO11XOT+mZCItwgE9U5yFlm2HJDv7
	qVgPJZqLTBnK0eQ5LSXiHz8cDtU5ntxtci8JD8yRtMQLt2HxL6QOp2tXKUmjZQN1Cg==
X-Gm-Gg: ASbGncvGaS34ewRIU3OaZTAY1On8aPV8rfa05hwVwKPv1BdSX5l+txd0sNnEHeH0lSP
	KFLMw35UjpAX/h1m/VEWKIwfzkWXKCrINe6ZqQJT3uGcHncJcUmMO32xqORp87rde6EoX1akflx
	iYZeg+1FUuZzshu99AlnqIXuAJOpi4USnjo8+StujN82zu4zzhFM6b+WFOjeadtamD8oqj26eRV
	9owjJugr3MAHQdquH8gt+1k5baA+6vo7tk17DrfNdU+Xw4WBAGtMNsDMru1nWfn5B4pwNbf8clt
	tytnAtGpA1kOMMk+xCrAgSNWQ1zsIWSfD17gic+paNlmwlYuXjCoCAwMWFi5tiuD51w81IRcz79
	AJpcJ/dZDcKJPkirXPlSUvkjQ7IYzy4scoDdOpOv7UZzivP9D8vc=
X-Google-Smtp-Source: AGHT+IFB7sWu9xsjklaDURJ4/bdA65j/GjnV3PYnArz1cIsDnRu9QNM8/BgVaxq6KhGYLVSr9TFbJw==
X-Received: by 2002:a17:907:c0c:b0:ab7:5c14:d13 with SMTP id a640c23a62f3a-ab789ca28c4mr1616863166b.53.1739254422970;
        Mon, 10 Feb 2025 22:13:42 -0800 (PST)
Received: from ?IPV6:2003:d0:af0c:d200:6033:13d7:beea:72d6? (p200300d0af0cd200603313d7beea72d6.dip0.t-ipconnect.de. [2003:d0:af0c:d200:6033:13d7:beea:72d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bbf40b2bsm390151466b.23.2025.02.10.22.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 22:13:42 -0800 (PST)
Message-ID: <619aec64-b191-49f0-99ce-2c2af9493e58@gmail.com>
Date: Tue, 11 Feb 2025 07:13:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prandom: remove next_pseudo_random32
To: Andi Shyti <andi.shyti@linux.intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 netdev@vger.kernel.org, tytso@mit.edu
References: <20250210133556.66431-1-theil.markus@gmail.com>
 <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <Z6qGtsEdjpz4ETvl@ashyti-mobl2.lan>
Content-Language: en-US
From: Markus Theil <theil.markus@gmail.com>
In-Reply-To: <Z6qGtsEdjpz4ETvl@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11.02.25 00:07, Andi Shyti wrote:

> actually would be better if we apply the i915 part in drm-tip
> rather than waiting for kernel releases to receive this change in
> our branch. It has been source of conflicts and headaches.
> 
> May I ask Markus to split the patch in two parts and we handle
> the i915 side?
> 

Sure, will do in a v2.

Markus

