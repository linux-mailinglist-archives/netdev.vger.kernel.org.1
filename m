Return-Path: <netdev+bounces-241027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C235C7DC85
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 07:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3B53AAB76
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C42857F1;
	Sun, 23 Nov 2025 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lae+GEgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76C35962
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763881082; cv=none; b=DlcrDXt96NlmmyIrr2rCmHDmrAzmzylV22XJl3+AzCt8fa/9q9RVU40h+KzrR/OITPXKHJ2tVudpzW3yizyjwoqYHHqz1I8PKr+pOMkBa1fZ6DJwOpBsK63fbdqa0DH6p/UMiyErU9hpUnisTuZKxsp2q2DuYAh70t7tUJzuuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763881082; c=relaxed/simple;
	bh=X6Wl+GsUv9tb9D2ZvYsvZDKqKoy8NWR2CEfCfgI0xKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG4eHCvGE5EgsdP1tvyGNTtaRzA2qkGY+uqZ3OSWLeD5alDVfDnntcdo9j/d8hpKADEpkkNHZmw6sfxoBwhi5WDrO12lptGGh3kCLt7j6OvvDQLKGMKHngtrbSdyLxTqB2xp7az9NfxXo4mF+yi0V+t0FtlJgpJKbudMxrTnKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lae+GEgi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477563e28a3so22206495e9.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763881079; x=1764485879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRVJRvrkA9r6FA5gPvj5O31mT6myPASpJOJtCaPGU+U=;
        b=lae+GEgiIQGzocy1m+fSXOQouErV2WPA/WnROV6iDyQWaesQJOcKWXU3PJ/1OUwH+L
         ruHDhXKVW+zfJRPCHRubp5rZpUeLzy7Ssu15XUavwFLurY2QsYuWNpsOYn5ATnXKfriH
         E40fiQZ0jA6Pz7OM8zfGhZ4jnmf99nC6B7z1PWw3db0e0iMOVbn+wfOap60nx5Zo/lBq
         DllQf6H7mYIXNMSVkGEPMQUcnndsLwKmqQVCfLQUQJccLT+n7PY4ThWiYH+cHmfu1sKD
         x5TmvEF6oF4/UsLwfOiVx6UH05+yC4W2hC05PBpQOiwhBYUL7Jt3DlVJIL7i8cqmNnQN
         e99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763881079; x=1764485879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRVJRvrkA9r6FA5gPvj5O31mT6myPASpJOJtCaPGU+U=;
        b=bTzpt/jHKpvXmeV8lMEuKDpQnvzH0MKzSA/RTr0iQEZWQPBPJ73uSZ2eWVEQ5KY7O7
         p7kSCW4e97VtDfxvFkZv+Nen81u6jOllaFH1PaURUniniVLcXiN9pN8KAS4K6enbJbNf
         iDNzS5AE+YrtXlAhjXL2gnTTCA5/2KYcO2JmxBY/zedyqPbyLkr+7J16kuyQnD4+PJ5w
         Z5yA6Ri5K+kbEkkzM5uzjLlye2We3SynGgEmrrSS4os2haXb/9RfufCDXP/Z8KR/9TLk
         08A2DiH/BySJJm26dQA1Vyr5bj8GnrHwsCZzrkJR7gBvBkNj9YHAiQtiSmX3GIorgykw
         xA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVRPBFTu1IXeMM2CQ0RSA6QVFleuA4PlcM6aAzn6jJFbvbyyLRbTHArU24+DGMi79vk1nzwpZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqGfcjg6ZeAtay4w9QveP1yjbpvgyT+ozjNw+q2Fzjp+C3yWM
	1gzoSn22Y5AWSawjyOeLME8iyrTudCjqSBrO6Jz9P2UK1OJ5ZLvKL5hA
X-Gm-Gg: ASbGnctHwqG4jHqfkuTEFVFTEbObLnkI3FfHH5MIAi1RWCy8nrzazBQSGEd/DKb6QLy
	2YNG8iQxL+7jjeW7SleExWKEB4X8Ls+idXBrbwiKPoGfcgeTHxei6rP2gb4esBOxIrGsb5WrjG8
	HghmxKURnxIVJLJLJXPnirifOvQyAaBkz+fvhyOiWT/grtx2BfeuVLuj8f9D+cdg6ueWg8X9iie
	30oL5RBUlf2RTGnuZj5hBEEczGG9pDzcIzJSxv/tjPUQdABwJOHVF3JQI5RYuJVa4hyCYUcmDmW
	TSTW8eCSEf1vXsFylyAbpM3ayDPLabFJCvv8HfPuALDhkXI3a/PWOMsW6g8ZA4JCWNLV1/cYK4h
	zKvIu7YlP/xWqcLALcu/+K28oxQAN36KJ3HD+kNCkSFzqFO7YRnoZSCB1kecFfKS3P9zPa0GMb6
	t2lATRXvqqPYqNcdk6HlOxGSnTwn2fpJkoEuU=
X-Google-Smtp-Source: AGHT+IHFAxOYU/3SO3J8aYD3YuAqZ07wcswkAErFmGjX6P2Bxhft7F/WMDyO2OFrbewioiPNPQbtkg==
X-Received: by 2002:a05:600c:c8a:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477c04cfb70mr82290215e9.6.1763881078919;
        Sat, 22 Nov 2025 22:57:58 -0800 (PST)
Received: from [10.125.200.125] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dfb639sm119878835e9.13.2025.11.22.22.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 22:57:58 -0800 (PST)
Message-ID: <f828d5d5-6ba3-4e9c-a7fb-3a0193f7e9bf@gmail.com>
Date: Sun, 23 Nov 2025 08:57:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/14] devlink and mlx5: Support cross-function
 rate scheduling
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <20251120193942.51832b96@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251120193942.51832b96@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/11/2025 5:39, Jakub Kicinski wrote:
> On Thu, 20 Nov 2025 15:09:12 +0200 Tariq Toukan wrote:
>> Code dependency:
>> This series should apply cleanly after the pulling of
>> 'net-2025_11_19_05_03', specifically commit f94c1a114ac2 ("devlink:
>> rate: Unset parent pointer in devl_rate_nodes_destroy").
> 
> repost please, we don't do dependencies
> 

Hi,

I submitted the code before my weekend as we have a gap of ~1.5 working 
days (timezones + Friday). It could be utilized for collecting feedback 
on the proposed solution, or even get it accepted.

I referred to a net-* tag from the net branch, part of your regular 
process, that was about to get merged any minute. Btw it was indeed 
pulled before this response, so our series would in fact apply cleanly.

Anyway, not a big deal, I'm re-posting the series now.

Regards,
Tariq


