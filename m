Return-Path: <netdev+bounces-161943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C7A24BCD
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 21:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267473A5BCA
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A31C3BEA;
	Sat,  1 Feb 2025 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHlf8RLU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB957C93;
	Sat,  1 Feb 2025 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738441508; cv=none; b=N2ee14JWkTkSlaPuzHIYZZcagO+sQfm0vfbwcv7J7uS7SCs4ZkFhu1YlyyutBpYVaA3PkLJnPOI81+8hRN+DZvBCQ27nOQI+uHbalmrc+nftRpU0z53zhPxosfQphRe7QrlyMgEMaiVSY43AK87XkSeRX7Ig8h0EFdP0Ms93WkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738441508; c=relaxed/simple;
	bh=iccBA6deq2GhgLaVCPERj7AzSbVh4NwBqQ9LHAIx0sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX7zX8li/cVwvdnWyygYtuX02VbrqLS4EIIZ0JcpdtiQQBux7SxdpvaVgBpFnVQV15jt1WBKP6uC5qP2JQMT8JX3uqrzYmCNeyO+EEVp2VFwzLsVQsIfoj0ZnCi6MKR5ncaa2o2bd0LmQ+BYJFjpQitaPFG6GIP9o1FyF/2BDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHlf8RLU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so44663285ad.2;
        Sat, 01 Feb 2025 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738441506; x=1739046306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v8bf5RcY8i16rD0QiWrZhv6qgVFg9w2YATA1BYWElLo=;
        b=cHlf8RLUCej4lOwZUWZZi+ENXXsbok0x4f4psSVNgY9FIg/I6qrWhbHUd6bADyMMvJ
         0LrZH/dmbqGw/M36EnSWmOyUEdCxHoGqNcWZ8DspSYyrQroURUW9gwCdtbAU3Rv2am7t
         RN1F0UbycSfx6bHU9jkh//VAA5nQKkjDON7dBPg7G5V6ea1R5ETJT9XBIw7IPiBpK7qh
         bcHW6RZHAugLltLeueMnBpg+qoHF5Fz2iBQwpgXAz5iuJOM4BM9LW0V6oniwqXERs1v4
         7vf5Osbhky9+WD7+qm6ZqmK03HgppmBfuLjYKyRXMKMUeQeGOOO+EWaAhaM0ODGCWif+
         O2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738441506; x=1739046306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8bf5RcY8i16rD0QiWrZhv6qgVFg9w2YATA1BYWElLo=;
        b=P8NFc5aeoboHg+6CnTS3aEp39otLe3xHlZwhCyiKNUeOBB+JVTUu9C+H1TUUOwFUMm
         GyMZ7cZmQrGij53Z/cZJVnh5CKQfjJtka7lcTm8VuJWk96eSQ4VrTY8Kbene5CHpImY3
         lsj8bKQ+QQckAGX0C7hVheHPOc+aI0FhPzO08B2Dn16zGZcwSZFxMDcYb30XPOVIYLE4
         uyAggjiILGnu2CtGshOPhl+S665XJCZ1rtBWZReK2ttsTzYdrgZtA9Gj3KbrKAqEUx5J
         3w/Y8jucQZRkvsoqAEpX/tgZ8FzzFfhl42zt83uZkU6WYJTEWFjbcBOIKpTQhk8woFxC
         nA3g==
X-Forwarded-Encrypted: i=1; AJvYcCVYQw/WVRgEUzRlNcP4vYKR3JX4hmHCYrVrd2T/HlGMmb6QyOO8mbn2XY88lS9oN6h4FgpcuYTy@vger.kernel.org, AJvYcCWYMDcfrMOFyOuWH5xIIZ9+RyXAMhu4r2vjKsMv5Xk1LDxcUL1/2Kqyvcqa7iV3GU0kmD7kEVIYCi7P6eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52KID/BguRT9T949bRkMWE1sYXqcUUmfz2vi5fWK3fpPgkjeu
	fCJ+BrUFeZVgPqwLG5lOBGMvYIGNe8ba0WZBPZHw1mksIUThG2Gj
X-Gm-Gg: ASbGncvefmZg/8CC+R6ab+zikR9vVHsA0da4enX/00aJuZ23qPzb1HfoERK4AXevg09
	+9xxVajjmW6mSbyULWlgbYvfpORfOSXHeufBPDhDWqesGz7DIwat6RBqoPObNsX+tj2Tr16nKgf
	+OsZGT+zzK2fFfGYKvJOX3wkF8bCUWxKdD6oJl6RQSUAQREkCw1rnoWDbXkqYchgfahSUUsidWf
	PJZVBRfYQqPyqFgVw5v1ONjEzHuDR7DaL4V8fpF/J0DD/nXO5L/taG9T5QIbal9FSBUZ5RZUaWc
	xiKcnH2EuJahwk3H4CQXu079w++/lkagHOjjYl0nhwKC5bYF+jO5fKVrEQfqAuLJ
X-Google-Smtp-Source: AGHT+IHuUQac2dADA+dcQYq/xnMmFYr0AojLl5JbY4u3LHnKk5mKteXK47vQgExRYAE/vFAnj51spg==
X-Received: by 2002:a05:6a00:3924:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-72fd0c679b4mr23294882b3a.18.1738441505935;
        Sat, 01 Feb 2025 12:25:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba418sm5551561b3a.105.2025.02.01.12.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 12:25:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <084020ad-5f58-42e3-9521-413ab8175717@roeck-us.net>
Date: Sat, 1 Feb 2025 12:25:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Yanteng Si <si.yanteng@linux.dev>,
 Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
 <35ac46e5-1a5c-4416-a6c8-1fd42ea47d37@lunn.ch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <35ac46e5-1a5c-4416-a6c8-1fd42ea47d37@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/25 11:21, Andrew Lunn wrote:
> On Sat, Feb 01, 2025 at 11:14:41AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
>>> When Tx/Rx FIFO size is not specified in advance, the driver checks if
>>> the value is zero and sets the hardware capability value in functions
>>> where that value is used.
>>>
>>> Consolidate the check and settings into function stmmac_hw_init() and
>>> remove redundant other statements.
>>>
>>> If FIFO size is zero and the hardware capability also doesn't have upper
>>> limit values, return with an error message.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> This patch breaks qemu's stmmac emulation, for example for
>> npcm750-evb. The error message is:
>> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
> 
> Hi Guenter
> 
> Please could you try the patch here:
> 
> https://lore.kernel.org/lkml/915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com/
> 

Yes, that works.

Thanks, and sorry for the noise.

Guenter


