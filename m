Return-Path: <netdev+bounces-154758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C998D9FFB0A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FC918833F3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08719D071;
	Thu,  2 Jan 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzn1F0NK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31E8BE5;
	Thu,  2 Jan 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832217; cv=none; b=kRbBqmtJZqkP1yPUAd5iLDTlsmXhCW8up6FmsSHi6PN8gPmlOhR/OH7u1iRoezGcVjsyjIdfz8Fh4zu83SoKKkABcuTDIHKiX0ubRD11oh5biv7iW+8Jyi0QdMfhMSMrfyjbv74ZLi0upvmajpycspL+ePJe4HR7nmFgk+0UWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832217; c=relaxed/simple;
	bh=f38aPYAmhszBuFj6KTOhnppFbnb4JjDmJ3z3JQ61iAI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ow/e3PyeW0YUysT3ZJAubFt91goNHo/1alCUcSc6uEl0IDdoIjBiwTmiuUBlaSxkIGDH/PC3w8CCo6/6wWVP1v95VMPaamxaDDD6PLzahSOgWZGOSauB1l225VSnjaUILqd9eJ4aZfGQQGXwR8BA0LFZT5UIP3pZ6BLaKbLcNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzn1F0NK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4368a293339so77082015e9.3;
        Thu, 02 Jan 2025 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735832214; x=1736437014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W30DC7OaNqvJnSZnaaNsRvXcLsLHeYQX3Ko5/d2qxm8=;
        b=hzn1F0NKtg63P3svkFm4NZgr8eNc83lh7zD51gUqJojDWlwEvwFU78WTjyO1mGArcz
         7aH1fYhHvjWFN9I4NEUEDNvSgypjZb2BNt8RvvHrtOWq5ni5okvIwTKjHTL8fKvW8fx/
         BYLpPvCozZir0RzJKSZ+v/hT7iatohtHzSUY1jlrD7GW6fVwIscrgtsasXX+H0EQCxOq
         ypWet7EihBtTfZz/bvOiRAZ4zZGLC8PtKJiw/XQB0Yjhl8VoWmftzZ4GOlclTlNZqpd9
         3Gm9PlXkwqdlhwqO/CGg/7DLsYm0yYldIdf5uFwCC9PhaBSmD9hdnWyiQAZ/4ttRwrVv
         PSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735832214; x=1736437014;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W30DC7OaNqvJnSZnaaNsRvXcLsLHeYQX3Ko5/d2qxm8=;
        b=QRpm3dM6M6hUJrvGx8TIo+98avFQpZgnYrDWdclCPW3amyh9BDWrIj4FrLwt+rW6L0
         E5QGnHYM0MvdpK1mGQmGGVpE557zIb0G2cu8ho9SV5jgIEB0LaQVPr4uVeL64d78q2kG
         x/pxuPY4n4vEdMCocC/+uwr3BlZMaCzdDUoBgI3HJ/6tAKWD8OZjh3JStWdQEcb0XrF2
         HoAjvy1zyphcuF7gEXpRieC77lIj8lpZdSQOVsZpNkSWlcZeawgMQ29UVI0zVAM1akjR
         QdtytToaGtPJSiJjENkqP1yNGr7SlL9r9sJQbnRrWXQhmspuEEnKtwNaT2ge0kDOByiE
         /8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUFQmHCD2c4DRDNuN5wc/LhKDIfQmRgv+SG1HgnSZqw/B7iJLm54joyXKxUuyYMbWEY9T1ztg5m@vger.kernel.org, AJvYcCVDHpsBVEjD/S+8O2oCgCjNRT+hSIblRAsUithuSHyrBGkw+ZIN8aUyJg8omGfKZRPZEyyjwdM9lqGSWHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZC4iGKSCMRiwkvW4I551kUdvi7ZAtu+jmb4lwdDpmH3HV0rJ
	wrm+fAb/Uvs1KaxFOky12eht5p1pq2aHWZGacnrhSPQ8p3pQoc6I
X-Gm-Gg: ASbGncsbh0rPViQoit9r3EyEL0O7QffNv/FeTZatK0lXEA0a9XsWnM2PqIvNTBNzefA
	Y+t/iTlfjCAucBoNJYN7hWnVzli7/oayxdywesppZCPwdRsK1KVvnaous7ij+AO1tn15lcdDNZ8
	NS4n0zA7OLYR+ILoOuaHW21So1rRCJDJYdeEfRJP+7Ce/BRZU6BxxY9tlJWStUfd1hGNmV4O1Lx
	Y2yhhSrzKwECooa7gR1k+9Q1kj6N3BSuYmmJOD7plMEPtF0HdxRlLohDEj3lAz4QSoVYzbNztaU
	rq9V8Z+pIdFk1/omQ4LuONofIi/7l8IQpe5NUpir52iz
X-Google-Smtp-Source: AGHT+IHzZSpkNaxW88jjdEhhyUTHTOVLRbadoqT9hVMKSlcgLUk/E0ZQV1REBYbeKKKUG+KlcVjtNg==
X-Received: by 2002:a5d:59af:0:b0:385:deca:f7cf with SMTP id ffacd0b85a97d-38a221e1ff0mr36324252f8f.8.1735832213789;
        Thu, 02 Jan 2025 07:36:53 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b2a4sm489959975e9.27.2025.01.02.07.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 07:36:53 -0800 (PST)
Subject: Re: [PATCH net] net: sfc: Correct key_len for
 efx_tc_ct_zone_ht_params
To: Liang Jie <buaajxlj@163.com>, kuba@kernel.org
Cc: habetsm.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 pieter.jansen-van-vuuren@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
 Liang Jie <liangjie@lixiang.com>
References: <20241230093709.3226854-1-buaajxlj@163.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <2ad890a7-7035-881e-8613-3ca830e0e7c6@gmail.com>
Date: Thu, 2 Jan 2025 15:36:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241230093709.3226854-1-buaajxlj@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 30/12/2024 09:37, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> In efx_tc_ct_zone_ht_params, the key_len was previously set to
> offsetof(struct efx_tc_ct_zone, linkage). This calculation is incorrect
> because it includes any padding between the zone field and the linkage
> field due to structure alignment, which can vary between systems.
> 
> This patch updates key_len to use sizeof_field(struct efx_tc_ct_zone, zone)
> , ensuring that the hash table correctly uses the zone as the key. This fix
> prevents potential hash lookup errors and improves connection tracking
> reliability.
> 
> Fixes: c3bb5c6acd4e ("sfc: functions to register for conntrack zone offload")
> Signed-off-by: Liang Jie <liangjie@lixiang.com>

Thanks.

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

