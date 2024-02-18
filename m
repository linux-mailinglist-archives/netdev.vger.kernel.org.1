Return-Path: <netdev+bounces-72773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362318598F1
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C8B1C2036E
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482976F507;
	Sun, 18 Feb 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3QjE0De"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125422075
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283253; cv=none; b=PeNc+R6eQXyNMnVkXO53+SPGm7BoHuS9lnmbEgVTqr7MiD6FshE2jk4d9WQVDQtNwQCfqOhThxknesSwVtjb+vmESgfi8qsCnSHhvmA8HeLPoWEw19cq8g3PA1MqchDr9ZFLRE2f78o/sLYNtI60gEUbf/nunodtAZcfA6Q+d9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283253; c=relaxed/simple;
	bh=9qEs2bLMEPI6Wpj76i7Ro8DLSaVojALPLjviypw/7Ng=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j9Tzv3jlROc+URdacR/f7jf3qd6V6zN2Z17lhF5y1yK8AnEVwg/e369bpzrjlqNaBwgzwIjr/yVZRomGp/LM7gKSG8NZd0GtxXm5LqnzHLTmFwxMKAGg5YbF899GDFsv+0fDCWHVCvzPE9YS8Vx1y8pGzdOmtcqXTPtViuk7c7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3QjE0De; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c72294e3d1so124927139f.1
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 11:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708283251; x=1708888051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfZ9/8NPyY3E75m7VV4aWgI5OQ6i0uFlZYGhwhgUW6g=;
        b=W3QjE0DeQEyioE6wQj+5vOeMb/TdQ+txUbA6hwkK5F0Hhyf6Eg6yuhV+KAz/nvyOcp
         IeSZGBH3Gtr4Vh2yCZr1oPygS8s7WnmRchc5Xk6gRnUsSSZ2tLJMVvgDpvbKIb3H0H4y
         mnAFZaRT59twVkkH9+II05IyBstHzViCZIJfgc+BvtLR4Y67VSacMe+ad257NLD8yx7i
         lu47I2SbLN2ieE4ATnlRR/q9dkXDI9v/Zk+/1JIfGvSF/hJ5Tu7D9MXFYDQ6Yh+6beXz
         iHLi7c75iA63plSLpgbSgzBXSOQ3lZmx3XhGT/ZHFDgkEZ3uBGcDgkfB71sCr0TCxB+c
         twEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283251; x=1708888051;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfZ9/8NPyY3E75m7VV4aWgI5OQ6i0uFlZYGhwhgUW6g=;
        b=IOWA0nDiGZeiEasajw72tZtrq5psfV97COsBdtMzzjnBKkVTUA1WkKqYfbaQo9twav
         TiWxSW978f2W9eL9gacYa2Dni53NCg56EsGO+/d8P6IHjz1jENlada9m6sI62xGYlIjn
         bMHIHR0irvMrSxAiwgVB356P8jc9sTqTTWvai4wvKe1bOrjgA4+fWFiMVgxi4nLiUBAs
         1dQo2lLEVlwq2nd+FrNWBan+a7rdONZv9fgMHvb98wnS74PCc8jYET4SGQmYMYWEyycY
         YBpwC1N5s7mhIytRnoMSh05BCsseA5eZHZGo8dMobNTdqVAfnU0ko9UWFvplsl6JNzMM
         +uhA==
X-Forwarded-Encrypted: i=1; AJvYcCX4tcjiuC8LlUg+LRU76eX50XzOZKL4vgduMIwX5m3gp4fHr9pniUn/EJGBFbtdsvNnX+Rd0/kT9CIXeGmugPUHtlwIQerx
X-Gm-Message-State: AOJu0Yyud0cpKDaSs+JFTi9Oqbp13yEZpOSfFyMmEglRvRMJq8hqm/bn
	L2t6p7gGUgpn9Vt6DKVI3eBv4Ae+KcAD7Zg5wzO3oxtY/D6Pe1xnnTDGJuU6jGQ=
X-Google-Smtp-Source: AGHT+IH1FwjiheTYossXAiIGITYYMfhrZ0P8j+lW2PjXe7rH+tc1Om+W33AlnMg5KB7RWtHjd5IfXA==
X-Received: by 2002:a92:de12:0:b0:365:2429:f615 with SMTP id x18-20020a92de12000000b003652429f615mr2702528ilm.8.1708283250783;
        Sun, 18 Feb 2024 11:07:30 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id c5-20020a92cf05000000b0036426373792sm1759365ilo.87.2024.02.18.11.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 11:07:30 -0800 (PST)
Message-ID: <5e36928d-e892-4cfe-85a5-c0cdbc669c0e@linaro.org>
Date: Sun, 18 Feb 2024 13:07:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: don't overrun IPA suspend interrupt registers
Content-Language: en-US
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com, elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240218190450.331390-1-elder@linaro.org>
In-Reply-To: <20240218190450.331390-1-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/24 1:04 PM, Alex Elder wrote:
> In newer hardware, IPA supports more than 32 endpoints.  Some
> registers--such as IPA interrupt registers--represent endpoints
> as bits in a 4-byte register, and such registers are repeated as
> needed to represent endpoints beyond the first 32.

I'm sorry, this is a BUG FIX and I neglected to include "net"
in the subject.  Please handle this accordingly...

					-Alex

> 
> In ipa_interrupt_suspend_clear_all(), we clear all pending IPA
> suspend interrupts by reading all status register(s) and writing
> corresponding registers to clear interrupt conditions.
> 
> Unfortunately the number of registers to read/write is calculated
> incorrectly, and as a result we access *many* more registers than
> intended.  This bug occurs only when the IPA hardware signals a
> SUSPEND interrupt, which happens when a packet is received for an
> endpoint (or its underlying GSI channel) that is suspended.  This
> situation is difficult to reproduce, but possible.
> 
> Fix this by correctly computing the number of interrupt registers to
> read and write.  This is the only place in the code where registers
> that map endpoints or channels this way perform this calculation.
> 
> Fixes: f298ba785e2d ("net: ipa: add a parameter to suspend registers")
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   drivers/net/ipa/ipa_interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index 4bc05948f772d..a78c692f2d3c5 100644
> --- a/drivers/net/ipa/ipa_interrupt.c
> +++ b/drivers/net/ipa/ipa_interrupt.c
> @@ -212,7 +212,7 @@ void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
>   	u32 unit_count;
>   	u32 unit;
>   
> -	unit_count = roundup(ipa->endpoint_count, 32);
> +	unit_count = DIV_ROUND_UP(ipa->endpoint_count, 32);
>   	for (unit = 0; unit < unit_count; unit++) {
>   		const struct reg *reg;
>   		u32 val;


