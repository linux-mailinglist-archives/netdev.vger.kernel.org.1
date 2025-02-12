Return-Path: <netdev+bounces-165676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D34A32FCE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239FF1886AE2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF181FBEA5;
	Wed, 12 Feb 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwIp5RnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA071DC07D;
	Wed, 12 Feb 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388841; cv=none; b=K3losHJxmiJR2ZUSabsLeuEW42q4GPSi6Q9afFZAzA3oVwhyyAy56v6rW9qbMQW2E0eEH1wbfBoTgVibpzBqoIhcMpAa0dPuFHY+GAAKmWvEXMjJCTVBfuL8dL7SsGfX+nWjNg2IYYcI+GFUueQ72sQD/HzarU3lMZ5Fvk7S1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388841; c=relaxed/simple;
	bh=PcPT3RHBHVoo2zPOijRuSRcLS8iDyLJHQGs/g4jK9u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSvQt+ZCCaxCrIeR0GYN3l8bO663Z0mtom/LKeuOsKgNQrJSvoxKjYWcVAAwJ7gGW5svjojALW9qhUwE2/P0u0JY/kvfdmNtYovp4gPXBpANd14dEiyljlT8ywQpRR7msgIFbwLzxAiSGl9AmBKAarHCeYQGg4ILcbqNa3XjCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwIp5RnN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so38033a12.3;
        Wed, 12 Feb 2025 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388838; x=1739993638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lasNycot9OROMRz3Tf45TsHUJIexVqDWGvappPiMilU=;
        b=FwIp5RnNHKAVah5DECBThXHmkp/YuQPjZZGOjO+576GL1cnU7vtFzQTHoe1P328nX8
         Bty6jPNJaiwcA615cHA9N2LYKQpVdSeKyc6TTCPnN9CqCpErMIPPIkuCOemuGTOjeQi/
         7n/drhJNaAl2EqdsQO+/cmFFvfKgp6zEAJId+HUO6BXmLLEy3QEIKtKx3nx1jNZbqEZq
         3NNho+QYTMG5DCNSONOGsxMi3opGxtSUgTiOZhZXkihnYBtDQeLum/5jYiYotgPstjMo
         LviwIt/iD26mqfrX+6sKWqKpjrhGQtAxSW1TDBpG3m1wOTR4iqg1JavCoqpmCuYWP/Kz
         AdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388838; x=1739993638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lasNycot9OROMRz3Tf45TsHUJIexVqDWGvappPiMilU=;
        b=tp3jShtD1zBj8GrYEBK/3jYO72C3Zwdf8+olcG/djQKvouOBlfeI/hI5kYjLVEsonq
         wwJvkK27iHJACFOvq74+vhWklGav9yMyL07xJCvDw0imVYNttly7yV7+A+ULhNkQyQFv
         FRxbeKLs1j4AV5eFyyKoI2YouGJ7T/HXDD4J7RiUDacSloSbjY6BNsStL0NMcm3XJQhc
         h+/qGm/3rADUsgGB4a6R+XHx2ALTs3ic5UKpUvnV9B7Ghjq0MKXLY5hyK2FMXabSiDQH
         iMG+DQcbp+4AImlYTba7VBbY93Ph0MgUE0t6fBKobT4suf5FGcL4Ll7GmpqRpLgee0Xf
         SJnw==
X-Forwarded-Encrypted: i=1; AJvYcCVxWezoqfToYefjXhi32T5u2+XF9Gx4ByR9Xo1P0LU++tis1McyoZtJWz9izrF3cyAy3qA/D2JW@vger.kernel.org, AJvYcCWtp62Bxj9WzQsTlMpJxBX1JW3PVbj1IjHYcNJeR6grN9cEqX/8HCmxsg8s5PaOVJ8ekGMEH1MfXoPcNrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hQGLUpAOhCm+vwUvVh0wsuUW9UyW0CsWnX9wht4d/HUPoBqD
	4HQ0P8CojwiIVujWnD5KqAKnNcqyEsFo+MwZhYdc4oZrIvYh5vKy
X-Gm-Gg: ASbGncvNdeyeWrmY7pfPt1iMHa0hdWpLguRGVOnEaF6Z9bixv7bs37Eqk8rTp2CGacA
	pP1/omPw91EoY4PfnUi4FVX9a3fUcoOSBAx61SdCjkMepBL19It9BNzlZMe0IKSrY+pdBs9h6yX
	wY+m3jRY6EjmPLGtRStaRlk4bMY67HPvS6Yt11SEZhE27JfyPF2n9mRr1G80z1/1/JvtisnAazI
	VzX4PsA4x/6Sk2Ydjts1FgTR/RqhvlHBKLpkeshSsw2Ew4f16TN+dpRRWd3mqXGfcQpbl7aGaRD
	Y33Gxco5NUk95fUQ+cYmOeBcVsw/Q7wPxRwaHe9CTS2bWLpX1OO9XQVJKN6J6+j3UB+r1mWckY4
	oDkgeAC9RY1oOavN4cdQK3U7tvaQPLFqxYjp7L25aWJZ7mYlNfLzBo+n32nZJcfsALQ==
X-Google-Smtp-Source: AGHT+IHkmVd30f3deykKxL2ZIUBA3+EnIW5l4h6W1mPQ91mHlha7qyevukukOy5IENG+fcG0BHpRFA==
X-Received: by 2002:a05:6402:2106:b0:5de:4877:ef41 with SMTP id 4fb4d7f45d1cf-5deade00a82mr4171173a12.25.1739388837360;
        Wed, 12 Feb 2025 11:33:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de63a89b6asm8193610a12.46.2025.02.12.11.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:33:56 -0800 (PST)
Message-ID: <fe6509ab-c186-47c1-b004-4e17a875c5c7@gmail.com>
Date: Wed, 12 Feb 2025 20:33:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
To: Jakub Kicinski <kuba@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250209110936.241487-1-ericwouds@gmail.com>
 <20250211165127.3282acb0@kernel.org>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20250211165127.3282acb0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 1:51 AM, Jakub Kicinski wrote:
> On Sun,  9 Feb 2025 12:09:36 +0100 Eric Woudstra wrote:
>> This patch adds QinQ support to mtk_flow_offload_replace().
>>
>> Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
>> of PPPoE and Q-in-Q is not allowed.
> 
> AFAIU the standard asks for outer tag in Q-in-Q to be ETH_P_8021AD,
> but you still check:
> 
>> 			    act->vlan.proto != htons(ETH_P_8021Q))
>> 				return -EOPNOTSUPP;
> 
> If this is a HW limitation I think you should document that more
> clearly in the commit message. If you can fix it, I think you should..

It will be the first case. mtk_foe_entry_set_vlan() is limited to using
only 1 fixed protocol. I'll drop the reviewed-by, amend the commit
message and send v4.


