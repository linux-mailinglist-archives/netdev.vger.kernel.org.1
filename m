Return-Path: <netdev+bounces-146043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E949D1CDB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF36A1F21B26
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90544134BD;
	Tue, 19 Nov 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPT3oONR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012DA93D
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978079; cv=none; b=kcMqiDABIHGflxthsjIYIpSLqQlcHGbMHElUa0VXW/aq8dM7sHfpOE0fouvA2tzgP92YdpV1K/DJ+H0shM5gBGayacjqg7zrXhqrL29zwtdessIiByTUddiUhJ+lEL0QZvPiAgJuDouI+GYwxG7YBuO3hH3f1vwjhnest5g6DuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978079; c=relaxed/simple;
	bh=Z702crGgqYVSufi49t0mOLqFv7022Qi8J5pQxh5xTgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqZzZ2YHBI7DsqNTNFSoHB0RTPRihSl9VXJeQsgTxmkoKXYmFNZL+8ypCBUmr4ge33YJgrecyrLD/tLvyTmEQGox1kNyZ6qOYuvS5f5LaBbNX6DxaaSLfUMi9okMncREB2C0dGz0HW9/Y29yO434KxthDp19J1v8ImMKM0bUUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPT3oONR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so40282085e9.2
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 17:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731978076; x=1732582876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Dy+y/Sg7BxkuaJRt8lN8ekR1rY4pdHsedbh1qGx8MM=;
        b=aPT3oONRdALV0fIsnr1yMFscc6zMd2ix7vE5W2CzIZP7m+QBvwGNUm809goPTwjeKz
         hs+gaeJ8866SmEHVm6YY2A4zyDv7NaDaLPYnQAXyt4ifED4yOdD+clt6ZN2n8zXJQ389
         k7PrSkjtm2YyGPipwy4ZMa4G3mcoG9avLT0+AMH6mn5YG06vwqt1oU55Lljuh9VeYMMn
         eGVnDpOWcZXmxnSPcvnCVhkVg0+E9nvDEVd6pl1mjgb4sjjZhUhDfpT5WmG+12NTxpCF
         TmsuV1rUsmKgJ7VKq+iXNHASm1UYfCWv8OD3gyqqXWNUX1f9SlPqr8KHsCM6kIL/7MZs
         K9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731978076; x=1732582876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Dy+y/Sg7BxkuaJRt8lN8ekR1rY4pdHsedbh1qGx8MM=;
        b=mEhi6hCGEJUQ8+tZ9a2FlPpHOz4fDAKlRbDVSyVHX3rI3dNGlAds/KtUUkqq12t8dS
         YK+em7XmhQI2FjIeQb1GKik0eUmKC+3aWZeySTRZ5iEE0pfKMNT2yLeDnPgT2z9/hOM/
         8qUvyGv1FIR0qdK1WlzDWubGBkDvSx2P3bxkaOt0y8kQrcK8oqH/mggZh4Ex7d/vFzaQ
         FINaKryhqEbzfAYOSQIetGwCToH1SwBGpT0u53VPL4OiQWSsrYqDx3HK5+qPlDLGbgaQ
         I67IjorWd/4I2YbIMypwG8BDZT1eQbY/ICJGDNqTXvn2560N7Lecw/liKPs+Bm8BcE4c
         R7HA==
X-Forwarded-Encrypted: i=1; AJvYcCUNAzpktL23Xpy83Uu2ZLKFWb+0UZkM2m1FNTtCgWnSTCh4n8WVjyFFoE6YlX0v1ymDQbVlUnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlwh8B4ekCDk1IDDxdgbCI5HQJZ2qFnERz/1ZvIzdT0wOoEl2F
	cUhAqPP6+gMD8X0IYFZ0s9w9ix3ACAE4/SdIWllQWH4gtWpIyxB5
X-Google-Smtp-Source: AGHT+IEizM8QYmdo4n+yxWV+vTQ5NKdtCjht1TWjEzKwHsEwScR3M5pGs6mWJKIG4P+ZrrDw5YPuqw==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr108474025e9.33.1731978075857;
        Mon, 18 Nov 2024 17:01:15 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab76dafsm172723215e9.10.2024.11.18.17.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 17:01:14 -0800 (PST)
Message-ID: <7e5e2bda-e80d-46ec-816a-613c5808222e@gmail.com>
Date: Tue, 19 Nov 2024 03:01:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
To: Jakub Kicinski <kuba@kernel.org>
Cc: wojackbb@gmail.com, netdev@vger.kernel.org,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com
References: <20241114102002.481081-1-wojackbb@gmail.com>
 <6835fde6-0863-49e8-90e8-be88e86ef346@gmail.com>
 <20241115152153.5678682f@kernel.org>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241115152153.5678682f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.11.2024 01:21, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 20:54:20 +0200 Sergey Ryazanov wrote:
>>> We tested Fibocom FM350 and our products using the t7xx and they all
>>> benefited from this.
>>
>> Possible negative outcomes for data transmission still need
>> clarification. Let me repeat it here.
>>
>> On 06.11.2024 13:10, 吳逼逼 wrote:
>>> Receiving or sending data will cause PCIE to change D3 Cold to D0 state.
>>
>> Am I understand it correctly that receiving IP packets on downlink will
>> cause PCIe link re-activation?
>>
>>
>> I am concerned about a TCP connection that can be idle for a long period
>> of time. For example, an established SSH connection can stay idle for
>> minutes. If I connected to a server and execute something like this:
>>
>> user@host$ sleep 20 && echo "Done"
>>
>> Will I eventually see the "Done" message or will the autosuspended modem
>> effectively block any incoming traffic? And how long does it take for
>> the modem to wake up and deliver a downlink packet to the host? Have you
>> measured StDev change?
> 
> He's decreasing the sleep timer from 20 to 5 sec, both of which
> are very high for networking, anyway. You appear to be questioning
> autosuspend itself but it seems to have been added 2 years ago already.
> 
> What am I missing?

Some possible funny side-effect of sleeping with this chipset. Like 
loosing network connection and dropping TCP sessions. I hope that 20 
seconds was putted on purpose.

Suddenly, I don't have this modem at hand and want to be sure that we 
are not going to receive a stream of bug reports.

--
Sergey

