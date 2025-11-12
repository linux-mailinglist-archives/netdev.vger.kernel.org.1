Return-Path: <netdev+bounces-238057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D130C53765
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EECB582490
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8733AD8A;
	Wed, 12 Nov 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XrFNB9x7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769F311C3F
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963530; cv=none; b=ZCWFEtCqFOr3hS0okhq5E5SI0A+2KWjdB2T1bJqzR8ILkIaH2WDb2LGUALiTjq3b2yHl/OkvapJVpp7beJSqZDzQCYKJviU+AFKTzE0z7Zul3oh9tiqVZxQEGTiLzxqNQ/Ezwradgyh8JQ3JmT+v2PdKeO5U8FCh2b0B6spQ4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963530; c=relaxed/simple;
	bh=o5Etr4QyEANsi+uSj2hcDtBvgqOSXbzR6waEVZNQKYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1bIsLqfKpggkYB9gH6rdD6l8n4vp8OwtwkL3PcwY95jiVMNItznGrpnssFUb5WaVbBTv25tV8XxvxkiTpDhukKURoj434vreQYp+sFmAWNhwXl5ODysvkwv8zB6vUJsfMKhCm2q7oofk+Jsff+TNJEDMZOMlbBy0PGwUNaKUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XrFNB9x7; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1584444a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762963527; x=1763568327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TjFbCBmI/k3Z2w97FG46OTUJ7HqHouhy0cGCZ1UQn0=;
        b=XrFNB9x7HapLGSg2OrL1UcdCDqC699bzT/H90YU6qIu2w0P7+bOdCrcX7BPpKsLzBi
         7wvG2iunlB2R74HtUuQPAixoCUaM00jNN0HKVANxHSuEb8OgpiyhYAxkp/WScW4h7QPf
         WCjmv46YKVXB4Sv3n+rKBdpYYFiuTzSGm21YZCALOaZiAyFJYFJG5nBRE8IMnB7sft6U
         +tFSptKpDFi1pYUZ9wcvFJ4c5ZzSyddYIfzmiQfvarffY7SsE2dkXKMaOJkdhmci1qei
         nPYTbCnAu4C+eMUjKyd0a8u2XQpkMX0/rrijCEgd2G3ycf/1a/m8FvE6OYzN7JY407zv
         ldSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963527; x=1763568327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TjFbCBmI/k3Z2w97FG46OTUJ7HqHouhy0cGCZ1UQn0=;
        b=dYLP7LZO25p9itOEAoh+1yt3ychX9gPInJD0NispfPAjk76mtyvPjm5AtOHk0oLQnx
         kkUFdSDJVWEIaB4T6J3pR1ObvqGf5yZx5ounvmTOBCwkurTNjvMoacWMnQOoO0kHY+dU
         swmLorRHD9+9y3RV8l44TyMHta5SjtOQXqCbJNbkRcQrzlMPEewKRmoAq0g0lk391Xgn
         kTKqEtV3RICfsqqXdT7garY6GD5DUSR7hsa7HEleVJ1O387t3qWFo9JSPWpzecoomxj1
         cn95kmwLd9ytA1I6idfoghNmlXPQYVmuNQWMP2T/FLPIrdMaMwu4fnmHUII8l03tzKjM
         LeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwBqAuBdzhNHmyWA3xaXd9NyiWhEIqq5nB/Lc5n8TQYq76a9/Givl188//QVg40Wz4PFA4LH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpjWIBWgqs6DEvhyRxeiT80EuKbRpDRTirwccmqwFhOuG5pXb
	SoLDq0O1Z+gWAo/iBbvk8J9MdSit93JZa+ouPGXoA0MTc2DlsO2s01m0hdkX5Obh5J8=
X-Gm-Gg: ASbGncus8xyWUp9qdktcSHUVCqWxN5wkPr9L9z8iuGHIoJF2Us7cSwkZGrqz4qs1x2s
	afref+O1bl4dFmlBMS0i/G6yFPokwu4YgF4haBYX0xu5JZaJQFQyXJA8fQK9TosY6+2rJf/dw8L
	K3N15lVVa/gUUNDgoRFKtETqxOVVn2xf483rPDOFYBzW1fNCDVZii4S2tlG63IQg2Q9jGT2H+LD
	GzuiPZazsivgHDsuSZx7CDi8Qe5Ci448BJ2iPGALp8WDPaTVJYBeObLgisTDUfXEQuTC3LMPfo3
	tcfoCcB3gkbCG3QavPCYzVycIiN93T3BcXUqkKcM0n64YsRIygR+0jmgWAhQpRGCL0hKmvxpfpH
	fdX4HbCDKuVUsAf398g6WqEDcqXOZinxFBWqeln/DeWg71JKTVw0sRLBN2ifueXV8CRuOySWkeG
	Y/Pjo/SvxmF844tZlwRhUG0U5LMBZEItA=
X-Google-Smtp-Source: AGHT+IGiInT7YZn/VKAAXo7YOv6njihsj9H4CmvrBEePVzXhQRgHQj6UC9y762MvDu/WctUaVNIFZw==
X-Received: by 2002:a05:6402:2753:b0:643:e03:db04 with SMTP id 4fb4d7f45d1cf-6431a4b4dbdmr3119267a12.14.1762963526653;
        Wed, 12 Nov 2025 08:05:26 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64166d06531sm10598424a12.27.2025.11.12.08.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:05:25 -0800 (PST)
Message-ID: <2125fef4-12e4-43c6-9577-42822151c7a7@blackwall.org>
Date: Wed, 12 Nov 2025 18:05:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove eth bridge website
To: Baruch Siach <baruch@tkos.co.il>, Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2025 13:17, Baruch Siach wrote:
> Ethernet bridge website URL shows "This page isn’t available".
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0c8b85baa6b..c79c182aab41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9264,7 +9264,6 @@ M:	Ido Schimmel <idosch@nvidia.com>
>   L:	bridge@lists.linux.dev
>   L:	netdev@vger.kernel.org
>   S:	Maintained
> -W:	http://www.linuxfoundation.org/en/Net:Bridge
>   F:	include/linux/if_bridge.h
>   F:	include/uapi/linux/if_bridge.h
>   F:	include/linux/netfilter_bridge/

I agree with Ido, the correct link is very outdated and it's better to
just remove it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


