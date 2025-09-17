Return-Path: <netdev+bounces-224138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7C3B8124A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B61A462AEB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741DF2F99BD;
	Wed, 17 Sep 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt4d++SL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17D2D3745
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129443; cv=none; b=MolsGLtvIglqGFEhjfo+I+1xsN56GMgCfema3HSvtSTeOMYV7K1hqR2Jbp3pM/hwjofpa/x5S5iHmQFjB8f+iJgM95UHmuRWD4yUKzM1zW3VbdpaxcsumQ/SBm3YsraQeUSYXFzaaQNCn0IT4MWsJ3HCmO3E5gFzggwxJem+zTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129443; c=relaxed/simple;
	bh=3U1LBXIuz7fukjCItzAA+L34NZHtzJ8R8A3jIrQNLp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq5QsoG/nbzELpGFHC1SQKekxavZTrqBG1RWsIGeep/lOW6rBuVbWhWggPZcT4q6ZTE7hCLfI4QzSV5I5HONsygT7weDg0cbIbyH45ZGRQSp4NKhr9YC9upj/9TPIjqG1S3ZTyE7vZjxjy5ajWXeJDSF1d9JwIWSqmk+STfR6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt4d++SL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0428b537e5so3758666b.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758129439; x=1758734239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T58nxE+bqTs3gFShRUYNkSGoazp+TtcIoUFVVJY4jRg=;
        b=Wt4d++SLCdEDNC1oC0OoDIirhRD62BdqoAhD4rJtFs7edqFjlq5PFLV2e/j2dxjMcq
         NEUN1pLjIjrHj1hmQSEU7qrfjS4f2Koy3Hxqf1NDL6JglhwCH/CnRZAZl9D3lp2bG5Nr
         mBNBVwh5ObSwm7ZBYRbSFzVS5KTPdhmVnFTjrZFFDPJjPkdQ8gqiTzTOtIdK3q+hII2D
         k5vdobPyIOKnW+82LEGerZcdsrBAbyP/nwyZG2/LhaiJangr72x5inlKOOf3SKpDybSI
         LlTmzzHKMKoUjbczB9NKqqCgu956iZY8o/5mMHw2tjxGTdkM3u6/LGtH/Hx/DjUswq1W
         WHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129439; x=1758734239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T58nxE+bqTs3gFShRUYNkSGoazp+TtcIoUFVVJY4jRg=;
        b=WERef4w3IJ+qJHy5yF6SFYOdroYCBeQgwupfaVqbaamQ4OSetDBOn9RpbpvmdZZjMg
         DlWEvOtZrFuM+5YazLmVwFoN+F1LVVVvsYttpJl2xT7+ftS3h8cFNGQcfuO19TAgSkXE
         PhH2zbOKAzsBuiNo1Tni47tceV99lJU1otFxaS7anFz7DaKcIm9XJww1GfLi1bOkGBHG
         kxn2OIWYd/zZnZreWaaDEgiNn0+7EdWVcM7uY7FHTRdKTUFQDBqcdttZ5DP7x7bS2hw6
         eD9eAws3sUXJKrCU8xJ50wE+U08QqzEcoZCEUgrtSBhRMt1yKnkDP709R2gngWMlKbtw
         T6zw==
X-Gm-Message-State: AOJu0YzBwXr4s9GJ1iCks4II8KYSnpKd3Z5U4K5CwQpmDpFJnNDFBfxs
	YwSiV3va5feG6uCEsYO5yeysKnBO9g0Vp414SdBWvtNUFlhwkbzdm6RF
X-Gm-Gg: ASbGnctDJPZW1SFhf4ITE/qjTssQrzeicvCYo9gKCpz6WqJjKUo9vuwDe8YtzaFb6qF
	+zKx5on3Pdt6DZNaos4tqPhE8VpMWoosfS/MlKW8l6pzEfbGqScV12fVOryJBLqwzwQAaGVhONz
	iSyRqz5aeakCq7abxKXMk92YzGQwBsZck/iI9TquGpSo3bE+IXPzr4ur+yukK40g1P/Ey1Po195
	f4XblxroJft50iEQ2bm5u+pIt4nYtP8TM61BUgwtXKj0bZg3Bfbh+TxSTmvjlQqAhAZMe4hSTLK
	Cc9Lh8RW+kBiruiKE9wgywMCNjrdJn9wWl2bMvfcXETt8O+85U1IifYnZ/BwK1hDmEDwdf3HVcP
	+UqzX7waRmWdbtNerJgCMN8VGj4teUhn5qOr+ATSCMNvx4a+ZZirF2BcbU7vqptQocK6J5eyT/E
	nA5eZvuR0Tjs5PeRjLOKGbIc/KfhAtijBCfoiIEpuqhah9JaMAE5OATyr/TCi4GB0kdsgdu1ToT
	LnkxHxytaGovvzUU7Q=
X-Google-Smtp-Source: AGHT+IF4Nz3SU9lHRKJ70fXArrCic12h6QnJ8u61QtcZkfPMX1c4mrx8Y0kwSaGD6ZJNiCo7W0YX9A==
X-Received: by 2002:a17:907:3faa:b0:b04:95d2:ff6f with SMTP id a640c23a62f3a-b1bbc54779dmr312100566b.47.1758129438661;
        Wed, 17 Sep 2025 10:17:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f29:d000:1d6f:5a2d:6632:eea6? (p200300ea8f29d0001d6f5a2d6632eea6.dip0.t-ipconnect.de. [2003:ea:8f29:d000:1d6f:5a2d:6632:eea6])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fc890cc88sm11625566b.48.2025.09.17.10.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 10:17:18 -0700 (PDT)
Message-ID: <0c5f8ebd-5ac0-4ac5-ae66-24a5acea371c@gmail.com>
Date: Wed, 17 Sep 2025 19:17:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: set EEE speed down ratio to 1
To: Hau <hau@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250904021123.5734-1-hau@realtek.com>
 <292e1b4d-b00d-4bb5-b55e-5684666c0229@gmail.com>
 <a710550463da4b4281f9db1a8d0b29e1@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a710550463da4b4281f9db1a8d0b29e1@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/2025 4:48 PM, Hau wrote:
>>
>> External mail : This email originated from outside the organization. Do not
>> reply, click links, or open attachments unless you recognize the sender and
>> know the content is safe.
>>
>>
>>
>> On 9/4/2025 4:11 AM, ChunHao Lin wrote:
>>> EEE speed down ratio (mac ocp 0xe056[7:4]) is used to control EEE
>>> speed down rate. The larger this value is, the more power can save.
>>> But it actually save less power then expected, but will impact
>>> compatibility. So set it to 1 (mac ocp 0xe056[7:4] = 0) to improve
>> compatibility.
>>>
>>> Signed-off-by: ChunHao Lin <hau@realtek.com>
>>> ---
>>
>> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> This patch seems has been reviewed. But I did not see it been accepted. Should I resubmit the patch?

Its status in patchwork is "changes requested", likely due to the fact that we had a conversation
about the patch. So yes, please resubmit, with my Rb, and best also add the following, that you wrote,
to the commit message.

It means clock (MAC MCU) speed down. It is not from spec, so it is kind of Realtek specific feature.
It may cause packet drop or interrupt loss (different hardware may have different issue).


