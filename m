Return-Path: <netdev+bounces-153977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111549FA839
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE587A126B
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA2188CC9;
	Sun, 22 Dec 2024 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvb9mEt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE3259489;
	Sun, 22 Dec 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734901499; cv=none; b=qtKLRl6g5NI7VbSDbjVvFr59J3xVL6PB2u5cu8yKeE/iqf6UuBHrBXqecQbEwDdbBZa9TGdptw/4l/uMVlu3DMrYXOX4lKF52fY7+eAvkyc+9j03CvzNizajFSpgunvxrJ0CVwwZ1ov3gPNaP9B/anbypDXlWPeq2Hn3b3naZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734901499; c=relaxed/simple;
	bh=Z4rhkVlVGQk354wSx8/JpdQqE6gsiWpqzQPNAZ2ApEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwEQsRibs6P78qyu8ulsUY6WhigbdmYYSDHJKrlZ4l/LV1kYpUdYnuQ15T0+lJWGg9do2K7niZ80MggBYAKw5jprOX/0iPt8sLCZuvQWlqPPOms0/kUbGh5ZFzsRtZyGTnBoTDFbEcaQbJXjAQsE+e7kvRlHAihmC4H6zRImMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvb9mEt9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4367239aa86so17301255e9.3;
        Sun, 22 Dec 2024 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734901497; x=1735506297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1oye4z15+lr2o1w+EQ1x0Cmk8LMpN4hRUXuCC9sKgc=;
        b=mvb9mEt9vudkndxxuMkqP7e1ykG8zUdY5M1ysPA/4tuR412+vCAZlfhZoclmTvAaTi
         UweNHJ/7YRDSTCckbN7WTU9TCHqJrfgiAOqBlRv5wl/Vt3CzqdWwjiF/d/UO1gAh+y9o
         f5ieu8qPMdGQXnSbROlQMYQl+eW1727ypPlc0p/hA7AlYaRaaCzsb5wYUVAbfUcee0O5
         MpKhLj9ipbRRis30MnlDYYm4aMRJjv7nNjkgp89stw1JRC9mIzPRIGwFEXYt6vCXK9Gd
         qxaLGdCHrDhgoFaypjZSveRhAWh1SRdPY1G7rb+ugBq/6dZ3PJCC12KjunuB5n7Q297Z
         yxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734901497; x=1735506297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1oye4z15+lr2o1w+EQ1x0Cmk8LMpN4hRUXuCC9sKgc=;
        b=gXteS84QTr+FFVoY1feNPplK0fe1J1TneY05XRefzJOfBI9BKyXG5IDbkqU2/UzmIT
         EN+Gh+TQrt/2CxytCckQeLGSJ7CKVHMY4/90ioLYKr8TsInS4cMLy/Q46VVCbZQ9i/Xx
         B5hV8a4el3ZNvOG8JrdNO8Eb+v6QicT6hEl2v3i1Ap/QPIPX3xByWF6v6GE4vWKWEj+A
         5f/II52Xya7c7jm4UcVEnz+ATgPjPvQcNFf2GJuA5r3+N9AXtHQtwzq91M4Sj0YSUEme
         rFdewFRfYFsBwdDG15Yi794RsXkmuRT0W/iqGjSxBux9sfeBcNNRG5oOYiwIZYNigmAU
         VaXg==
X-Forwarded-Encrypted: i=1; AJvYcCUPg2cosl30+6M2qdXgpNqnGMEy8/Pkfp2QOYRgageQNWmy6UhcoWw6+v4jHJdy2a17yoIJlqs3XPUAjzvV@vger.kernel.org, AJvYcCVXPm5lVojZtm1sRD3giCF03xCUY4pfxwRaKdlXIbRZeZ3xlHUV+/+xE4qFZvCry+nGCOCqokShUgE=@vger.kernel.org, AJvYcCWDiOKretgVcqMQNBxerRhabZHGb9L97P4nzOzpGpw6ym9Yn1IV+W5hc1CMWr8aX9LU8zyXvDDh@vger.kernel.org
X-Gm-Message-State: AOJu0YxdO2mpJQZXt0LPsOxH79zT24Q5EDZc3IvCasQV1uydFrOyugLK
	2yVSwSymQvbPBsKthtg+zIrzV5llAx/p+wLGGVl+LXXa6nTVtaVo
X-Gm-Gg: ASbGncucA4HRmTH25nF72kh79GNFy2UtifnaESpXxeIplh5z+qVKYSaJdtffM1J3ZTr
	XluIytsLPwMX0XZL5zxhBj/sqQza7kNzPkfDGjPb5tGskiITY2gUkuSZJvsaRA5PBRsLN23L17u
	uitiYHmshlZnZ9hCThqoJV+MmYu3LD0Vy8Xc4RAhhRE+A3DudHDGB8LeV02bi0k8jXGsdIhcy9K
	HkbDV+u6NNyZEfy/OU3d7MzSc4nJySQKOoTIFdny4a0HOdh86nrZfZPBQ==
X-Google-Smtp-Source: AGHT+IHrVNOxvatH0wJahcvx8K9R6UCZia3C2mnXBs1VmInWx4bVumdXRL/+jSSx4T8TnEac1wlEhg==
X-Received: by 2002:a05:600c:1c12:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-4366aabbed2mr92183945e9.31.1734901496299;
        Sun, 22 Dec 2024 13:04:56 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm114539775e9.33.2024.12.22.13.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 13:04:55 -0800 (PST)
Message-ID: <6d839f1a-9c38-46a9-aa3b-62afbd75cea7@gmail.com>
Date: Sun, 22 Dec 2024 23:04:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2] net: wwan: t7xx: Fix FSM command timeout issue
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, corbet@lwn.net,
 danielwinkler@google.com, helgaas@kernel.org, horms@kernel.org,
 korneld@google.com, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 netdev@vger.kernel.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20241213064720.122615-1-jinjian.song@fibocom.com>
 <20241220085027.7692-1-jinjian.song@fibocom.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241220085027.7692-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjian,

On 20.12.2024 10:50, Jinjian Song wrote:
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> 
>>> Fixes: d785ed945de6 ("net: wwan: t7xx: PCIe reset rescan")
>>
>> The completion waiting was introduced in a different commit. I 
>> believe, the fix tag should be 13e920d93e37 ("net: wwan: t7xx: Add 
>> core components")
>>
> 
> Got it.

[...]

> Yes, the patch works fine, needs some minor modifications, could we 
> feedback to the driver author to merge these changes.

Looks like the drivers authors haven't enough time to maintain it. You 
are the most active developer at the moment. Could formally resend the 
updated patch with refcounter as V3? And, I believe, we can apply it.

--
Sergey

