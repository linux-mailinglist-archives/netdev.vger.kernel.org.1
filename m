Return-Path: <netdev+bounces-178787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D0A78E2A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857FB3B0D4D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745DD239095;
	Wed,  2 Apr 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRjmFgSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FB230BD2
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596478; cv=none; b=CACRn60KdGHo7aY0Z61kRhxVrTjRPp7ydE6H5wYoh/0e9p5LfXtUE5VldZ69iiYx5/eAzGmLDfTEeR2bdkf3/aj6QNwMnbLVzZZKg1BV7OwE3HOzXxqbbptZ/ZLkGCIl7MdYeqvkkTs9qhryFX/lYmwoA2pI6P4/VHKn4buq3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596478; c=relaxed/simple;
	bh=04KC2t/enBPxl7ewSckeR8faG0rGkhU/QjZmWGxfTHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBf/ExY+itzXIPHp1hPuliTdeTrOxwm2ojwQomjduUiwWCQ/nXn8qXAnM1dMuAhhTI6D8x83BaOFwpYlHhLdYa4ZzxL2ukIikCgeZZ+LOL5aWbWLg0GRSE1q6dPZBcbRdh1isCCYDkX2AyGASuspf+NMtmkYv2UukeZaoThoS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRjmFgSQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so45982061fa.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743596475; x=1744201275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZ57URpXz8K0WnUtjiuiycsS1O21HDukR/BRM4SgP/8=;
        b=BRjmFgSQghN+6crzqQyc4t+Q+yTkKSdv3ZGEqFw5Z3rlIp1LVZ3d5BEFFhBM8AOgf2
         i86Gi6GOuGorglgQOxwMZxETqzhHy29WRFRPrkUtHSVWkA8GdLRN4UXjjJckwWTRROV/
         X5HxexmBiCahEo/SBPeR8xsj2U92kpm38cjqpuYdq3/LoYkRU6FE4WSA6GfTUd6xGFod
         KPz8Wt53FsYYKrrg4mfh71GNovV4hINCjJJ2yeYAW9rOt4DdjPsfXpIWZcAD8EnEfhMA
         09YMurBnAGngXYb3iHeqTLTXMucttZBDZqdMWAoAl5FNxf9MzKL6yJNkZfdfrsoXfWBz
         UBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743596475; x=1744201275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ57URpXz8K0WnUtjiuiycsS1O21HDukR/BRM4SgP/8=;
        b=nlO1Doe0X6Ak+QS7SJRI/ucKSyVhRziORnATmWvcw4Zr/t5Grv3rjXXEJBs3GLoBuy
         b9Ckzt8IMJLq6c543oI1vZlUkJ8rgkFMA52iT5uTfLfBJhU18vPn+9XIh0GWveH60/ii
         gT07ZxLbGA8nxtFHVoBJWNoX7VzzSvfPZhIGxsvTlVncxmOuhMWR4xRlYYrscb5dnf2d
         kjIAwVGL934melqdek9WZe+WPdCPeu33gCW1ws/MEJWEcweusPKOyJ/DtD6lWto0tCkK
         l/LDTpsQDGY0u83lYo3XD9upLtp7Zzc5n+2KDE5qM3T093samjQ9NIjMGB76t9Fde7+J
         OHPg==
X-Forwarded-Encrypted: i=1; AJvYcCUcuxwURSlB4cWmOA8yMUrmvCAwBg2wLtWoTFZGWMNJ/7kJ3kiVAfcPzfEFOddC0fBLZNA5An8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2+phzvigmG2RCgmdpkyUJUfpqhGrkuZaRCoaF4nyJZgsGF2d
	Y7c1ajcW7+bHEVRL2gu/5cjmL/S/arGos1p+UpeMCDZKHruUvVqFxlVtBg==
X-Gm-Gg: ASbGncsEN1du8UDiorfllSdTMKGAxXat9TPLdj59uVN0vuSjbRc9nuL83oXxZuT07GD
	1O6nN7ccCe903kK7hkCq6OnH0Erd5wTy6wRmLRs0bKeXrNmw7zb7wIYxZ5zJmhM6iUZUBl5PO4U
	RNPREmG8KHxLLK/ePyr6OJSSXR2JACywbnoEX08jbS4bdeH7uwRjCgjwuyHz5ScT4K3SycA8r4s
	8VBm3sxDtDNmIqbDF3l/o2il+l9CsS2NxqberO5+sVUsWSvpUJ11YcxxsrbBTW/07V5pnSc6lTF
	cDeH9HjSN+VxXGim5KezamMHcxZ8rurATmeHt9phsndCNUOHKgVB/WbKkI6fFqhawg==
X-Google-Smtp-Source: AGHT+IH1AfQOHrCBIg8CaSOZxM0+KRW9DRWOHCl61WZfVndTvecz5Z74xiH9DXYzz+tNjaCpE7Og+g==
X-Received: by 2002:a05:651c:144b:b0:30c:d32:aba8 with SMTP id 38308e7fff4ca-30de03294d6mr63612301fa.30.1743596474577;
        Wed, 02 Apr 2025 05:21:14 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.140.143])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b4cdeesm20203921fa.80.2025.04.02.05.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 05:21:13 -0700 (PDT)
Message-ID: <c53b8db8-fee0-4c50-8253-fd9ce6e5be0c@gmail.com>
Date: Wed, 2 Apr 2025 13:22:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: move mp dev config validation to
 __net_mp_open_rxq()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ap420073@gmail.com, almasrymina@google.com, dw@davidwei.uk, sdf@fomichev.me
References: <20250331194201.2026422-1-kuba@kernel.org>
 <20250331194303.2026903-1-kuba@kernel.org>
 <32917bbb-c27a-4a65-8ba6-1df5c4729c12@gmail.com>
 <20250401080036.5aad536b@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250401080036.5aad536b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/25 16:00, Jakub Kicinski wrote:
> On Tue, 1 Apr 2025 12:37:34 +0100 Pavel Begunkov wrote:
>>> -	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
>>> -		       GFP_KERNEL);
>>> +	err = __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
>>>    	if (err)
>>>    		return err;
>>
>> Was reversing the order b/w open and xa_alloc intentional?
>> It didn't need __net_mp_close_rxq() before, which is a good thing
>> considering the error handling in __net_mp_close_rxq is a bit
>> flaky (i.e. the WARN_ON at the end).
> 
> Should have mentioned.. yes, intentional, otherwise we'd either have to
> insert a potentially invalid rxq pointer into the xarray or duplicate
> the rxq bounds check. Inserting invalid pointer and deleting it immediately
> should be okay, since readers take the instance lock, but felt a little
> dirty. In practice xa_alloc() failures should be extremely rare here so
> I went with the reorder.

I see, sgtm

-- 
Pavel Begunkov


