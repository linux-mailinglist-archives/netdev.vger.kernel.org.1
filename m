Return-Path: <netdev+bounces-153666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E249E9F9232
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB1016ACEA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0E204697;
	Fri, 20 Dec 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AEBsVdtI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AD204696
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697686; cv=none; b=HaAp1q0IGPLiuEfqmH53WLEPnYB+xG2W+w34i3S8eU5elF1ZMPdL/v76Ao2mzaGWh8bZl5cC0CjoccGw0MW/FKXW/w6uSqM1egXYMA6RHH++9NvBmk+MDsV4fLwozTXI9l0JujWGpc7PUDvb5/s7nfnwgzzZ/NDKk2I+De/E/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697686; c=relaxed/simple;
	bh=crwUz8w4erOpuUncroLz8rVV6rCiCKVlVqP8+2IqluY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4umRkFg0dqQuimCUf2eobN1iymLsDxi6gYH3SNfHPGWFCpxypzP2yIK0x+95PAyVI2WJxdrGP1mm0a/QfOQZzvqTGR+n/0yeUi0Rx3W3ByTB+HQcQhp13fAC1oH+//HkzLCuYw+IvYgfYiVDdHb3DPxpwx3CzzYZxP3Sj4g6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AEBsVdtI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38637614567so938318f8f.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697682; x=1735302482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XW/eDTIh8MSvBLVk4dolZoBmyg128cNU1krHt3uwMlA=;
        b=AEBsVdtIUKJj27uk+G8WIkcjwhU4OPhpHkxI2y0CUYjUOnlijZ3XolYrfQ9K8nw0ID
         VEIt2R7jbau3a3K6dsubwv5OEWHI4Ue2yjdKEnovN8KNTDdjFRCggXcJHdcTqeCLGiFG
         VMuAYWSG7n0NFAr8DrUQodQATGxY0sZBpMS0+729nOvqAg0H9Zj9WQ0c1Z4LT1eWX7FW
         o7ZjCi8qPHIZ93IA96QhVio2nIMLjoqJrUg0MpIRsOiICDCK+aiAi7ot5oW1TH+vfu0Q
         n4HEE6JFrGYIt3+ZnV4xL78rJyap+ty6y/++2Ch5rRpQOQgMDc/DqaLHYE51qspap0SM
         ThVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697682; x=1735302482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW/eDTIh8MSvBLVk4dolZoBmyg128cNU1krHt3uwMlA=;
        b=Jtc5aF4ANko9dlNXBSKTrpoaC9BURhhNjXbO9pNrX6y8KLmL77mfbBKHs030okn1fy
         elxzUmmnhqeDmBg1j8caH5rWI5Y2HmLvCuqv2RI2kZ0LDsau2KQHCK8Z6OQYG/0IN/1S
         +JlBZ6JPLe5U2IIZMoVROGNXcc66Xiht5qccbgGN1U6/3N1/ryT5lwyVDuBgWH4jfsh1
         EfcvlB1kFWxRY2OUkBO9nUn0FQ3AwUJ4jm/l40l7Jy3PkgLEVYwzxRTmgtcQdDMARi9J
         SPq7pWY/S7phZNZB+S0WYoJLo76z8gVFytRHc4WXtIQWFgURpv29KOO7qF733MZoCNMj
         0yvg==
X-Forwarded-Encrypted: i=1; AJvYcCVu/GLTR/PI4BrGAJv78wEXiUuSzqxGlFOkwCEbdGEJ/rxNaAO7LAnhg9o6EMNBh3Dw1IFwlIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXoHr6/EQWYn44J51JajzU9zjEYTYILMSXWieLaf5LgiRxvpf
	dAqSIC59J392+D068Rv+Cd1cpadsFIDYGkVXSexfVQUMdE+NM8oM0YDvxmt3tH0=
X-Gm-Gg: ASbGncsBB7fQn0KPFvCZtG5UhLdvCaAwT1d3AKRmkyRVMxl/27RYsZv2eAJkUVFUd8g
	lavwOMEiPiShiNU54yfcrymeykVnE70wOGFVIDiI9V/6lzK924YizcOciWnjANGyOWaaleWQAsU
	BtDZp2bp21+i7TOTyrknU8mDpnIaMqaodM/XeHAtuWO9zSPO/TLAkOLA9DsRuzsSmgSt8hpwTvM
	whMip8KDSooQadQvIfaMuuloHTWNeg7yLdZtgwOQ72iaKxAWpJlK7jnd2nGzl39s4KoqLK8Ntan
	ySlGwn9CJM/0
X-Google-Smtp-Source: AGHT+IFIskpEmOR+YWcUP2jYS4Ck9DjO4dUxfusvUv9OGLXmeydXNRW2PPdKQ1wOV9XNaCqV5iGhzg==
X-Received: by 2002:a5d:47cc:0:b0:385:fa2e:a354 with SMTP id ffacd0b85a97d-38a223fd65emr2840355f8f.47.1734697682184;
        Fri, 20 Dec 2024 04:28:02 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84840asm3944688f8f.61.2024.12.20.04.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:28:01 -0800 (PST)
Message-ID: <5012d081-eae1-4424-9588-3dd8fc7d933e@blackwall.org>
Date: Fri, 20 Dec 2024 14:28:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] selftests: net: lib: Add a couple autodefer
 helpers
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1734540770.git.petrm@nvidia.com>
 <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Alongside the helper ip_link_set_up(), one to set the link down will be
> useful as well. Add a helper to determine the link state as well,
> ip_link_is_up(), and use it to short-circuit any changes if the state is
> already the desired one.
> 
> Furthermore, add a helper bridge_vlan_add().
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
> ---
>  tools/testing/selftests/net/lib.sh | 31 ++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index 2cd5c743b2d9..0bd9a038a1f0 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -477,12 +477,33 @@ ip_link_set_addr()
>  	defer ip link set dev "$name" address "$old_addr"
>  }
>  
> +ip_link_is_up()
> +{
> +	local name=$1; shift
> +
> +	local state=$(ip -j link show "$name" |
> +		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
> +	[[ $state == "UP" ]]
> +}
> +
>  ip_link_set_up()
>  {
>  	local name=$1; shift
>  
> -	ip link set dev "$name" up
> -	defer ip link set dev "$name" down
> +	if ! ip_link_is_up "$name"; then
> +		ip link set dev "$name" up
> +		defer ip link set dev "$name" down
> +	fi
> +}
> +
> +ip_link_set_down()
> +{
> +	local name=$1; shift
> +
> +	if ip_link_is_up "$name"; then
> +		ip link set dev "$name" down
> +		defer ip link set dev "$name" up
> +	fi
>  }
>  
>  ip_addr_add()
> @@ -498,3 +519,9 @@ ip_route_add()
>  	ip route add "$@"
>  	defer ip route del "$@"
>  }
> +
> +bridge_vlan_add()
> +{
> +	bridge vlan add "$@"
> +	defer bridge vlan del "$@"
> +}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


