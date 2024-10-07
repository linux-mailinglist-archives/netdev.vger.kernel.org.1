Return-Path: <netdev+bounces-132806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836929933CD
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49681C236A5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806591DC051;
	Mon,  7 Oct 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X99nvTAA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3321DBB3A;
	Mon,  7 Oct 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319683; cv=none; b=eejkXGjlTHmFOIhRpozz3NDNrvRiR6PY2a2V4lx4RmlPqO/eCTdaopoLvfba+TChbJ67gD9uW+LqIKxNnYK5fRUZwxclB1tPuv5Ylu9Tdjeu54McnYuoBrZ1dLuh3jLn7rGMyXBZidARJxFNrQkl/O8PxHYgCXP/mOEIXCS4Xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319683; c=relaxed/simple;
	bh=m5COKRDZ0N+jZ3ruutsrz4XDt0lzrIWnyIVoN63Yr/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyoiykBZH666tbE7agtpU/4i4576XQrC/kzxllgM4cCqrlFyaVrSoz5rlvY4Ruj7qiKGo/qT9nbos0WsdlURBVVg+jC8cqKOviMvtotgTDxXxQwfedeOVqmxctn84TC1wr/VeCmEjbtf1ZQHkNavtVFS1m/yq2MOiDt1SKv29Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X99nvTAA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so41408655e9.3;
        Mon, 07 Oct 2024 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728319680; x=1728924480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjjsJvt3Ubeo2DT+hd89E6pFZ1HmYlwo+hb6vzYJIBQ=;
        b=X99nvTAAZUawCOKLJLQa9pCvGgCEU4pSjhWGmsM1nbbuLIzZMTvdPske0bdkKMkK8c
         7kbd4e93i4duT0xpd3O/vMy/KAD+74PtlnA88XRdnob+zfBXZtzMXcA7llwB9CeFAUJx
         2Vyeel65Vvx7G6BDYIqipuVOrbsKhcfvQNnwfPg7WXzOlzdMTWcEyFO9i9zk7RzWGaWy
         ulHhYwlMZiUIWFwavIV9/DHxBRzdA8DhLkmAFUq4Z1iM2BT2YJMsfqYA1tYL2sh+nf4C
         wWK5ZVKUxLmI0UH3tDO6+x2V/5f0GASkeeyAlOnxod7PhDp+35/Uy2iq4u73t+20glRD
         aLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319680; x=1728924480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjjsJvt3Ubeo2DT+hd89E6pFZ1HmYlwo+hb6vzYJIBQ=;
        b=u6A3dTLGEXeEqt79+kb3FXi4FoPohtAzhJ+mstrGiCLrf6Lvulz9WKFio0F0WA6Ces
         577PToS1itsYex7R2IAyayDctUAQU1YZJRDVL/OE2sUSWF94wILh3oyyJl+Ec4Qw45ZZ
         tdxYw/VIzYfU+TxvOd9Rd4GteM5kdIskGLr0piDApGkbLINCRbj3l2UOT9Jio/s0wtXR
         8ntShNSKm7F7tWsXt+8+33LILgH1feLwtCJ6qQcSy11GRqWVTBj7mhPT66R5Ozv8LO8+
         FcMzkuUvrup54CYpIExNz+SUlMmNwErlvTRiKfV+gIE1Ha4zQVlxlW8joRZiGX5gYiAJ
         Bx2A==
X-Forwarded-Encrypted: i=1; AJvYcCUaZGrkoKimRjf4gCnrnL/ryrPtHA+zR+iiKXjuVS398PK0ZebJJLl/NXSyJHXfeuX2x9nB7xHGo3+e+N9w@vger.kernel.org, AJvYcCVo9wvWV69r933mbCbi64SBNfeTYU7He0WuTBfuG3pf6tANTl7iIcSbF+ZPkKeMN77dcDey4jY0bR0=@vger.kernel.org, AJvYcCW2oCti/LutitfCpMo8eZBoAkZM81CibNEau+x0EWbKYQNHhJpUM41ty7UH/+D+XhRZXy1jc4Dy@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJ8fj8GQNQ8AaSTb0MxUqHgkVF1mPKVYM5NXKhuy0+D3JIz1y
	NhMvFKIFD5WTxRNpQgvifCnD7GWQEwHplo5+GpYq3CEXrOtKbkuH
X-Google-Smtp-Source: AGHT+IHbf2asevkk2K3r5PtdD0PoltYd6OeaFzL96uL9uyLu7Ao2qPR9x6OsQpZru0X9UKsb1MbUwQ==
X-Received: by 2002:a5d:40d1:0:b0:37c:c5dc:72b with SMTP id ffacd0b85a97d-37d0e6bc8ebmr7134164f8f.1.1728319679638;
        Mon, 07 Oct 2024 09:47:59 -0700 (PDT)
Received: from [192.168.42.151] ([85.255.234.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d169733c5sm6078760f8f.110.2024.10.07.09.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 09:47:59 -0700 (PDT)
Message-ID: <9386a9fc-a8b5-41fc-9f92-f621e56a918d@gmail.com>
Date: Mon, 7 Oct 2024 17:48:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
To: Breno Leitao <leitao@debian.org>, Akinobu Mita <akinobu.mita@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Jonathan Corbet <corbet@lwn.net>, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, Willem de Bruijn
 <willemb@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20241002113316.2527669-1-leitao@debian.org>
 <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>
 <20241007-flat-steel-cuscus-9bffda@leitao>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241007-flat-steel-cuscus-9bffda@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/24 17:20, Breno Leitao wrote:
> On Sat, Oct 05, 2024 at 01:38:59PM +0900, Akinobu Mita wrote:
>> 2024年10月2日(水) 20:37 Breno Leitao <leitao@debian.org>:
>>>
>>> Introduce a fault injection mechanism to force skb reallocation. The
>>> primary goal is to catch bugs related to pointer invalidation after
>>> potential skb reallocation.
>>>
>>> The fault injection mechanism aims to identify scenarios where callers
>>> retain pointers to various headers in the skb but fail to reload these
>>> pointers after calling a function that may reallocate the data. This
>>> type of bug can lead to memory corruption or crashes if the old,
>>> now-invalid pointers are used.
>>>
>>> By forcing reallocation through fault injection, we can stress-test code
>>> paths and ensure proper pointer management after potential skb
>>> reallocations.
>>>
>>> Add a hook for fault injection in the following functions:
>>>
>>>   * pskb_trim_rcsum()
>>>   * pskb_may_pull_reason()
>>>   * pskb_trim()
>>>
>>> As the other fault injection mechanism, protect it under a debug Kconfig
>>> called CONFIG_FAIL_SKB_FORCE_REALLOC.
>>>
>>> This patch was *heavily* inspired by Jakub's proposal from:
>>> https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
>>>
>>> CC: Akinobu Mita <akinobu.mita@gmail.com>
>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>
>> This new addition seems sensible.  It might be more useful to have a filter
>> that allows you to specify things like protocol family.
> 
> I think it might make more sense to be network interface specific. For
> instance, only fault inject in interface `ethx`.

Wasn't there some error injection infra that allows to optionally
run bpf? That would cover the filtering problem. ALLOW_ERROR_INJECTION,
maybe?

-- 
Pavel Begunkov

