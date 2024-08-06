Return-Path: <netdev+bounces-115963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60F948A30
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C50BB248BE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4280166F1D;
	Tue,  6 Aug 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FbjRBqio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437A15F3EC
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929687; cv=none; b=ReZYmsk2WwvxR56ufFSQt+TyGv5wUyb6roZEvmxTRHVLTW5q/IFHZ2u2UucClEquyeqNJNtaxrYTdKoa0u++ePmPYbH95KLTHz1q2jJuIAd/u6nzv7Zlj4KTcHjxM/8Cz74jUc5jY+dpwqSm0bgxZonSVfEzfHL+4WK60ynte6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929687; c=relaxed/simple;
	bh=55gWQtAXMFTTpi7jpzXMXqKEJTXZZmmHsBtPR9LbyxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpeyGdNK+xLwORPjDrAGrzE0tdcMSB4u9sosdern3b9YV5lZWs8Se3uFtyj10KB/Zvt9TgLKT7caB4Ujm7aYLZd2FBI35dXE6cjln35ctaARScvx8YeDyqWsB14LV1XfrmuVzwOHxKigDA8yrT0+hp48ciuXLhZBaVwqpYOfT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FbjRBqio; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f035ae1083so3814771fa.3
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1722929684; x=1723534484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cojje0NgqQhFEUPTcwEliyWCA6eVmhHl0uuQefpE1jk=;
        b=FbjRBqioc1AL10u2/Qr3e7cVX85tnocqPHOL3DHc56SpC+30wx4ZAmJ0sGKlGKGVoY
         hX2KTy+ebTIZQeqr/lYAbtaIsNzJRb81g5swaP2jXnvYuFtbBNurpCm5oHN0lUTDvrfV
         r8/FPM7PPsQPZ2/Kck+n1+lfsgF79xBIPng9Bcu6/MUufEHT0lGJ47pctHoFq1ksRoCm
         SijuxRQIkP8c+Tb5fyNEl+EknIwv2q5ip8HYWOT/e+tdg6q4XO4XFcOLaRNOVh86DYr/
         s5mpIbdS4Teo2JvAeXPUgWiPdtxDUpPopjM0bbnIpLd1lwaQY7ZSm5sBEzHIPODs/QWS
         V9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722929684; x=1723534484;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cojje0NgqQhFEUPTcwEliyWCA6eVmhHl0uuQefpE1jk=;
        b=CytBUNzbPa3d230a3g8ezLU/yZUW9Q8K2q6kDbU5Ct19C6CMnnYiUqjrJqhxv0A/Rj
         91iConomCBkiSIyd/FhEkNhY4sunSKmbGFpWWIOxD4UpunP6C8iHtukP39chy7A+9esS
         l4ZiubRupUdlt50OHorRvl6/ShRiAT/Mrbwfx5xLkrRWOjX/EMCLYfYqKM6jvfxJvoWH
         MIJtkaYse2iUppLazUJ7al3s0BJ7lwvoA1eWHx618eXt74ZCsJSzx3d5Z+xJwzaq+kGM
         fsPIVXoXdOy+QYZeF2CE4ceYhhnXqIZrz7YcPralL+XBoQ0W6amxnpGFw6KfPSfCrXfr
         ImKw==
X-Forwarded-Encrypted: i=1; AJvYcCUoA4iWO+wG4MpeJhqnOT2ZyrfHVe7X81SzVbGiIYmD7W/68j1aQsxX1W4ZG5u6KbeZ/kuDdaCphD8ZlH//B8wEaFs4qrrH
X-Gm-Message-State: AOJu0YwRYr9X4HZInL1ZMsqR1RWrPpgYQAjM/05PTsEkkCp8Wo4Vmq0F
	K2n0vDx6l5HvIJztV3TUEYekXR/x1Y4Hwj964kSl72aTibny6Tnbl8vPaenOz0Ob+vAoAYucknp
	7
X-Google-Smtp-Source: AGHT+IEKUUDFBc25n+DfFynKB6ukFiPCNzwQXURUKaLlve+6TgRpyJmxzz/8c7Kqgmg1asqozL2iEA==
X-Received: by 2002:a2e:97ce:0:b0:2ef:2e6b:4102 with SMTP id 38308e7fff4ca-2f15ab38302mr84697931fa.43.1722929683713;
        Tue, 06 Aug 2024 00:34:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:400c:6f2d:f80c:1b34? ([2a01:e0a:b41:c160:400c:6f2d:f80c:1b34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adaadsm229930205e9.12.2024.08.06.00.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 00:34:43 -0700 (PDT)
Message-ID: <3bcdec5a-a93c-45c4-83a1-e941a39cf1fd@6wind.com>
Date: Tue, 6 Aug 2024 09:34:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address
 not found"
To: Geliang Tang <geliang@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Benjamin Poirier <bpoirier@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 06/08/2024 à 06:20, Geliang Tang a écrit :
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> So many "Address not found" messages occur at the end of forwarding tests
> when using "ip address del" command for an invalid address:
> 
> TEST: FDB limits interacting with FDB type local                    [ OK ]
> Error: ipv4: Address not found.
> 
> ... ...
> TEST: IGMPv3 S,G port entry automatic add to a *,G port             [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> ... ...
> TEST: Isolated port flooding                                        [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> ... ...
> TEST: Externally learned FDB entry - ageing & roaming               [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> This patch gnores these messages and redirects them to /dev/null in
typo: s/gnores/ignores or 'hides'

Nicolas

> __addr_add_del().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index ff96bb7535ff..8670b6053cde 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -839,7 +839,7 @@ __addr_add_del()
>  	array=("${@}")
>  
>  	for addrstr in "${array[@]}"; do
> -		ip address $add_del $addrstr dev $if_name
> +		ip address $add_del $addrstr dev $if_name &> /dev/null
>  	done
>  }
>  

