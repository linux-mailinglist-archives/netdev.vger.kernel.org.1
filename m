Return-Path: <netdev+bounces-118953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA68953A46
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC1DB23692
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545164A8F;
	Thu, 15 Aug 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gjBqoKQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B065B1E0
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747216; cv=none; b=ey/ZFfS03R303NtZ2bJzCrBzvJDrjiZp3oGBw4SlhTfSPPeB8hrDGvgLWB8VsXsFB5K7Fj4GVXmujUhKYw9cUCBkERU0gfdEAY2cqZ3uKs0TZReDrYBw/TpBJSu7GFU9S85FfEzru7jnSMK4rqyGB0rB6ZemDgOiatUIYG7vT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747216; c=relaxed/simple;
	bh=ZE4Zz5osrC49M/vXSCOxNNjmTAzpqaBfhvQtNfarPYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1Ktv6k0Uc+OlKzrslmIBJkasfYSmK+UXHaO95Sf5X3P+QvUYMnP88m9tvSXH01K7hdLubhLq1DKVbsFXKnQhxzjrvRUJDWAypVeokSGkdAeONgM0BOpN2T7Oh03cCstoVVgCN762T8U+ZYWw/atNRzsV6Q91kHUoBmiuB1H0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gjBqoKQ6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201f83e0d47so715385ad.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723747214; x=1724352014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7G23jOysGth/FGYl0E61txbtZGC7pVkDJVfmjAiyIyQ=;
        b=gjBqoKQ6LjgERViBhLxF4dtLkLUs9u4dM4mtmBwxxZjkqjj8Ty+rGeLrYqV+ycrG7P
         2Oazrcz97rWoKtn6Iqtn4uKIWmUURYtBt0WJTKtpXZn0w4xOVvSyQDFbu8FywDD0nXwR
         x6LvpcUPXUSrsMVwPEVqm1iJdUWjPIlt+wmSRH3K2hGRegepbsDQdI/GSgEjldgpVQpX
         cak+uULLThN64MHfXp8kFJW2AKaGBx+rEhAv5eGtvrd4p1kugAzndN1vftXdP/XOyoEU
         OoIEyl2S5FMSJ6S8Sz5gI5KxS8gEXBbf1wS9vZdablK5Qo7rDgwGVd4dxkDeWtDG8D7C
         PaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747214; x=1724352014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7G23jOysGth/FGYl0E61txbtZGC7pVkDJVfmjAiyIyQ=;
        b=P1S0AvogJ5H0+ecLO9NNsK4jbD5oSJVAFTL+oKJ+LREbUbsB+gQKD24KSs2tn+iQuz
         /6KLK8y98m4fVgu5tKy2yYfth5GCXbdlWxHy1FlwCYKBqsZ8TpqcZ1AzakpObSCR8IlJ
         cvnPCzDj7+VfcxTQVVc2KaHok2I7ih7fgcbAuf+Nq22Iz0f3wLfMrMoC8WXWHIQNngeX
         xSgMbhCjqf26LK+JTT/hgsPtnUe7YZ5fIdTA381XaqzqV/a0s7dtFQ+YgNaNYK14e0tF
         k0op8bV1EooeqFh8sw8GEJUYR0IhgxZwLRvasBzMZWBhvrqJPEuQGeByVSxvKUWPlyJA
         Yqtw==
X-Forwarded-Encrypted: i=1; AJvYcCXSThw1lG9smOmi4IgZkedVq4svc6jVUyrjuloO0zr+QrIh2LDsOAKCdB6zR6sLwWGCrS/mm2Et9PSOfe0sDEAnJStvqsIH
X-Gm-Message-State: AOJu0YwqAUaetd+/L+tF0lnyodYjEiHxj3sYUI9vR+BzEMOM9xH0+2/8
	RvbV2IZUuOPK6S+49fx2byImr0IL+Gr4XxVZlJCN+aL0ewakummOo1QAg7LAGy0=
X-Google-Smtp-Source: AGHT+IGOntniUG4ZVlSqTpFpIJZ+pJk0zhBjp0RK1k01rfRL/yPln2Wx1vv0rBpcdb2aXIxs9xW8tA==
X-Received: by 2002:a17:903:2291:b0:1fd:a54e:bc41 with SMTP id d9443c01a7336-2020624daebmr1154665ad.8.1723747213972;
        Thu, 15 Aug 2024 11:40:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a565bsm12995635ad.263.2024.08.15.11.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 11:40:13 -0700 (PDT)
Message-ID: <1019eec3-3b1c-42b4-9649-65f58284bfec@kernel.dk>
Date: Thu, 15 Aug 2024 12:40:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
To: Breno Leitao <leitao@debian.org>, Justin Stitt <justinstitt@google.com>
Cc: kees@kernel.org, elver@google.com, andreyknvl@gmail.com,
 ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, asml.silence@gmail.com,
 netdev@vger.kernel.org
References: <Zrzk8hilADAj+QTg@gmail.com>
 <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
 <Zr5B4Du+GTUVTFV9@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zr5B4Du+GTUVTFV9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 11:58 AM, Breno Leitao wrote:
>> 1) There exists some new-ish macros in overflow.h that perform
>> wrapping arithmetic without triggering sanitizer splats -- check out
>> the wrapping_* suite of macros.
> 
> do they work for atomic? I suppose we also need to have them added to
> this_cpu_add(), this_cpu_sub() helpers.

I don't think so, it's the bias added specifically to the atomic_long_t
that's the issue with the percpu refs.

-- 
Jens Axboe


