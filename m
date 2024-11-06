Return-Path: <netdev+bounces-142536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103A29BF8F3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB26D1F22E32
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C9209F3B;
	Wed,  6 Nov 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSjQ3KnV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E44824A3
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931153; cv=none; b=uCVJ5EWkfmb1mnMk58JWOmIbBlztQG5kZSPRE9T+p8RD8DCZDl3PfhEN/BhJ6aZsJD3T89fWjdeV+sFmdN/Ax5vcr5Ryz9QYlPOWpN3uJj6eXnWYgDhqdvoveyqnoxcaX28Nd1uqeS3LiTRDOJDa4WfkFqr0RxNNrQTW0EOmk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931153; c=relaxed/simple;
	bh=NKbVcCCZIiM0sX+WdXRuDBBSQbhN5H6+3jGmAYxxA6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/9FmTonaEK1SMg4NFINyIu1ZPWmpDh6ZwTwon2qQuI1sF0BT4rEmdi81gvi+c6vGVdV8x1HCtW3bj+Ft2yHz6BU1l6kma2859iRT1T24lCip8bu8EEGDpWT8p/1xhTuitt5tjDocKhKhg6dV/xie945G8xNSWE+setkMJAUY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSjQ3KnV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315baec69eso2759475e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931150; x=1731535950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB3xeY071IgcEnEiq3AVPEiyG5ZVXfdzV1Ck//Skg7M=;
        b=mSjQ3KnVWsFAxpSuOoszlwW0jBf1LlkN/Z3ShI4zXGlTkCfLvKHTHQYLP0cFOypwyK
         cTYnaFQ9JyzNNA0iQ++TicCxNlmeMJGjlX9XqID+nPrCqMvXxlU3C1H9WPOHlVM337lE
         4d9Yz4aIiX1GnKLfUYFisSld2xcgZ1L811roIGTInUFo1IsnCaL6bOGeW40Iq1RVugQ2
         Z+CgXpN1sVNVghxu7i5PmWlZ7SwQ2mbK3n6g6XGPVUn7Po4Lgk6SpObClC0I/3ngSeMo
         WoTng8h4vg6szHApDGpg0cDxAO2djM42x0vkbpfDaGswzfmEh0WbRSxCRT9OjaRWB/vU
         mY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931150; x=1731535950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB3xeY071IgcEnEiq3AVPEiyG5ZVXfdzV1Ck//Skg7M=;
        b=Ab6sXmSVT4C72JTgRTkkpzAH/tIHZFaqyM3VCKjzJ84V/w+liF36WS0W/1jnvfTepA
         +XJ9KaoCAPzwmRw1gBpztemkTzg5Fmk2lEUXf9trdCGS4/WuJzYsyfXrgydKpQWAj60l
         7TiXM91KGLMJCBkIGHmUs+Fm9ZeuVBuJxNcvU397j/a9j7T1z5R/yY69k5Z1wJ7HwFQq
         mO+WMZFH1HDALMEpSLtwtw2HNhHcDVnNekYwTqR5epNiKdmKiQ/TNvWJZM6XKlFqfDZF
         LiuTBv6zfNvtlgr7qxJQHUe/aHpOmx2fe8x4Fdc3+F2hY/slbzRiOr/UVC2EXECarEi7
         CNXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqgwvBRgKPp4tQbD2AkuY2LqPT0/paI3JjTPeCr6nPF8cCZfzK+FAgGbLHaxgyBdov5w37+Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4r1qVEQEsVec4vrjJsA/iI094I8/bTDfp4Uhl5W8u96X8UbBv
	rtL3I1ZJ7NLXxRAvI9fs5LE5LhfMl9XjfcdxoalfO7Go3cbLW/6G
X-Google-Smtp-Source: AGHT+IFfw5uAMtdU1Om11dpYAnWEuvswlrvP8MXiZx6I0NsIQwFcLiPX5mXS4Yxg1s/Iptb9rEr+Hw==
X-Received: by 2002:a05:6000:4009:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-381c7a5f773mr18655654f8f.34.1730931150127;
        Wed, 06 Nov 2024 14:12:30 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e771sm20526409f8f.81.2024.11.06.14.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 14:12:28 -0800 (PST)
Message-ID: <3d17cd64-46c5-427f-b24f-9091546e2edf@gmail.com>
Date: Thu, 7 Nov 2024 00:12:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
To: =?UTF-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com
References: <20241028073015.692794-1-wojackbb@gmail.com>
 <20241031185150.6ef22ce0@kernel.org>
 <CAAQ7Y6an8ZkxYpJehd8cBRPHjqyQofc6A4QdPzM_dhh1Sn0nng@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAAQ7Y6an8ZkxYpJehd8cBRPHjqyQofc6A4QdPzM_dhh1Sn0nng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Jack,

On 06.11.2024 13:10, 吳逼逼 wrote:
> If the PCIE connection remains in the D0 state, It will consume more power.

True. Keeping device active causes battery drainage and the idea to put 
inactive device into the power saving mode is clear. My question was not 
about power consumption. I am trying to understand what other 
consequences of keeping modem suspended. More specifically, how the 
suspend mode influences user data communication?

> Receiving or sending data will cause PCIE to change D3 Cold to D0 state.

Am I understand it correctly that even receiving IP packets on downlink 
will cause PCIe link re-activation?


I am concerned about a TCP connection that can be idle for a long period 
of time. For example, an established SSH connection can stay idle for 
minutes. If I connected to a server and execute something like this:

user@host$ sleep 20 && echo "Done"

Will I eventually see the "Done" message or will the autosuspended modem 
effectively block any incoming traffic? And how long does it take for 
the modem to wake up and deliver a downlink packet to the host? Have you 
measured StDev change?

> Jakub Kicinski <kuba@kernel.org> 於 2024年11月1日 週五 上午9:51寫道：
>>
>> On Mon, 28 Oct 2024 15:30:15 +0800 wojackbb@gmail.com wrote:
>>> Because optimizing the power consumption of t7XX,
>>> change auto suspend time to 5000.
>>>
>>> The Tests uses a script to loop through the power_state
>>> of t7XX.
>>> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
>>>
>>> * If Auto suspend is 20 seconds,
>>>    test script show power_state have 0~5% of the time was in D3 state
>>>    when host don't have data packet transmission.
>>>
>>> * Changed auto suspend time to 5 seconds,
>>>    test script show power_state have 50%~80% of the time was in D3 state
>>>    when host don't have data packet transmission.
>>
>> I'm going to drop this from PW while we wait for your reply to Sergey
>> If the patch is still good after answering his questions please update
>> the commit message and resend with a [net-next] tag (we use [net] to
>> designate fixes for current release and stable)

--
Sergey

