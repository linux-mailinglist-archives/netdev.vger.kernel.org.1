Return-Path: <netdev+bounces-181552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC2A856F1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CF23AD52D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF829344B;
	Fri, 11 Apr 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BQZRS5iT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6D20B7F1
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361232; cv=none; b=e8G7nqBvIMFgrpEnUy7auJv7R21/E8SJf3zfGSBb+vWqTK2opoG28NurH1w7obWOXzBcjb/8QNoxCACUyiT5gy4dmUgmsay4u922pMZhZ8957kg9iZO114MrMEP+l/GcsEW0kCJHKFp5aAKfhQcq69gbDzk/V/JUOpqmfZt9jTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361232; c=relaxed/simple;
	bh=1kXLBhEZE6OqkXjDzfvvDI9iR/ZxHUV/Xo7u2tQ2L8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxmBCa9EjqGihePgLiQ1PNKG6DQQm7J65zLPuI9GXnHnPj5m+qNAR5ruP03LvbCwr5tSoW7kwweYUDZ1y9lPL1dE/85mHP87AE6GhwLF4IZOeu4usn5xMgDezhwfnA0V+eiYJxQw3Rh6uZV9KsQZ017TVwysdVMlcSkpruXRjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BQZRS5iT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso12781555e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744361229; x=1744966029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=av0XyEZV8I7O/09NYxy8b4TdCFcXqsTkZCmrtSFqumI=;
        b=BQZRS5iT3GBsa7AjVYzOqaU952B7CXiCJxuYy6rfrVgU4YiEkMyWl03xiJMBPfq5rH
         5kpHkLYcxApWgmcnPNBIPuEebiEAKhNeFTCmmZpMNYjfadMlWWF39ObVScswQ7ZhGYob
         dxCnbHM2dKNgXHHuuGMhj7090FmID0CrE2hrv+9ZvmOVSIrqmqn2QDnN1WjMNlDF9rLF
         h7cdrkD+Jc6hKuDpFVgxluNecRub/++ZxTxvdnaqBEADR9R7ggNS0yq7Ovvr+BjtIqJP
         bimNEW3fa5lZ7Hd/oEFaJKchYqgDqKq7KSSW3U4eh0LrnITaGRxJhWkA7yM0C/ihb3Mg
         SErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361229; x=1744966029;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av0XyEZV8I7O/09NYxy8b4TdCFcXqsTkZCmrtSFqumI=;
        b=kqA3SBUE81q1/vGiYeTbq+fctUDPJ/5NIHf4hwk1nXjxyxMt2bT0yXcTAiuqgwGJO9
         3hQbnT1/M/+elr0WB3zCGkVUSUpaYVCANquITYgrGsyxxdGMGdVWQvoajv8kmjF3GzGg
         A9YXNnaIXSGASc0zF+scfW7bfCHJVinQJ6QUVyAsOMwYMDEgZrf44p4IRPnJaS0TPCFq
         5kfbTKp4d8zGk17nOVOLgCf3FdezBEIHcbiAcUbaxwZTA9+4GMv73SLn6UL8br1wXeJn
         MM5KhTRl404LhBED/m6Q1DOLNWK7jU0vIYxQ+vK3v4YRaHEtG0BZ70JblFVMCzRateww
         fM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjiu2Rx9nYjcteZTJXK7Cj0U+Jhao69F99o3TFqmZdbsToeRT2Ex6roeF4kmO6Q1qwr31YjmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNuCg1qdnQNXPgjzEzboZ55CV/9kVPXsNY0vx0ojjgZZjdyQBE
	2mgR+ot6MCqyyD7F/XiuhPrRywSvvC6s9WEOrB9WQfIpnmrLv1k6wt5wAEwwYitbukorlTcoz7C
	8sw3AJMB+CGwU0hqtH2d6OF9pcicdtrAnt+PpXwkJluE0sfk=
X-Gm-Gg: ASbGncv6WkLr/osT9AZr2bFOfr81ERHockyuMsKc+x0+ladvqwAo/TugCEbtreZP8rn
	9Hqq45H9gMC68/6f8Z/0kXDbRtDRU/EQe/0aTDH6Vs1vFjr2XZXUADXr6b2gxAMy0+DY+DX85u+
	OxI595tx6+5k1WPaOAk5775pppU10v/bLr90OT0yM7VIaYmL/OLMO6arOyY4fBPvzTgeMD8UrtW
	fbQWBlo2cWj1CD1Z0QJuh1+xyb7UuW1fhlXh3tdJ173qK3J+e+KRYhIfAHwVD4ojLDdqbJGWuNy
	6JasjE/KkgWV5khl/M2dAjxfx49UMer4Ot+xE/J9LWLPUPaVDdD7CoiAzSAR6YnklH1GGP7zw5i
	9sYw=
X-Google-Smtp-Source: AGHT+IGJGJgfDhxLW8iHULpCr4HAz0c9G33EsC6d7ew/p76jeG1SxX9V0NsZpEV6JXd9okm4Kw08YQ==
X-Received: by 2002:a05:600c:4f4b:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-43f3a959415mr13584425e9.15.1744361228774;
        Fri, 11 Apr 2025 01:47:08 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e8be:40be:972d:7ee4? ([2001:67c:2fbc:1:e8be:40be:972d:7ee4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm81137665e9.17.2025.04.11.01.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:47:08 -0700 (PDT)
Message-ID: <44edfa99-a3a0-4d86-845b-e13c1dff7f2f@openvpn.net>
Date: Fri, 11 Apr 2025 10:47:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
 <7bffe8a8-56f6-40e1-90cb-d9589fd41bee@oracle.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <7bffe8a8-56f6-40e1-90cb-d9589fd41bee@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alok,

On 10/04/2025 19:51, ALOK TIWARI wrote:
> 
> 
> On 08-04-2025 01:16, Antonio Quartulli wrote:
>> Although it wasn't easy to convince the community, `ovpn` implements
>> only a limited number of the data-channel features supported by the
>> userspace program.
>>
>> Each feature that made it to `ovpn` was attentively vetted to
>> avoid carrying too much legacy along with us (and to give a clear cut to
>> old and probalby-not-so-useful features).
>>
> 
> typo - probably
> 
>> Notably, only encryption using AEAD ciphers (specifically
>> ChaCha20Poly1305 and AES-GCM) was implemented. Supporting any other
>> cipher out there was not deemed useful.
> 
> 
> Thanks,
> Alok

Thanks for reporting various typ0s.
Will fix them in the next version.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


