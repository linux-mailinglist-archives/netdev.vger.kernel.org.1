Return-Path: <netdev+bounces-196900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C8AD6DC6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B9517F810
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E884233D88;
	Thu, 12 Jun 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Jq0ulMUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC522F389
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724315; cv=none; b=DOQH6xjX/3F+jEHsWwR0u5GRhS2B8y70aaJ3Q20Q2TZJNWQoUGHoORDSPfQQH1rzzcnLg8GlR492vbSKA6NrDkv4xN26dLARy8mn5+AoPgKPlIxKU7D+OdYk8x6YoI3thPjBKrbokp1jWpbLjwQqm2ESzaOqcxAfOrABqWCqruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724315; c=relaxed/simple;
	bh=TQo2INi/+XHSNfMGc/koNdD3LLyRZXzBpWZx+FUt9Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEouSHD/lSuN7cmISYR4/CTIuqUDsa0KuVW4vX7ZBgGQrt3GNLdHxXAn4J2qHeVZ5jufH6jL97s5A8MQ5KJL5nFWYCdF5DMizGd6RkTsQpFBmDuSKs4WUkq0V2EdTN5btJ72fcApinOCyMx9lFML19xhw0IMj5rb/tIk8eeYlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Jq0ulMUf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553246e975fso846829e87.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724312; x=1750329112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gwfEMHcoSZi22U6QrxsFXcirJO9ZdGHF407QwjIpSo=;
        b=Jq0ulMUfIvgH4RoQvYvNgNRfko9HqpUgnU79XdFenO233LrnOWUWB+9ZY/AH1g9AL5
         ZiFhXzAITgOFNJ5H63PacLmLYKdkF5UYnZvUNwPnMoyxk4kd1ZcyNOQy1pXz52cmxdM5
         A/R+TRAYcWcSpnb17TFtcq39rcytvYvqJibrU/SUhLYz+U0B6o0vhr3q8rrCfObUstxC
         +zr0zcfod4UPllxNJgDvzSgekHJq7Og/wjpRHN+99mQPgssUfAt7nOeBe8+buzIGJ3Ip
         3Nhq/Se5jPzPEFK+wLrEuRVlTH18+XOEqbvo0jBEpoTbXf4agrpW7XFV6HMIiY/+ciPe
         zcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724312; x=1750329112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gwfEMHcoSZi22U6QrxsFXcirJO9ZdGHF407QwjIpSo=;
        b=ohtysdi2FsTFaM6qfdxg4DtlJdgvN+dHnVFTUflVehwTSUW1mPHEH2Gg7lFkgPuDUS
         Bu10xofZt4wfPaMVDH9kq33ZPayQ4r0SwXxjoParG+HzC+9VxrxlI9AHiP3A0NeQBMhp
         yFmQErFHPtOYC+S5Avha86U61WeSgvb3TZeKgQuNAyPX+47hZ+xUEE7B1vpAIrfbfwaK
         I/O2/xtD5GeEtc05JLbw1Lvj1nJsNfw9tajVoUCw4vK/M/SpbjmEYXfkg28pPetba4Ws
         vLMA9fLA57+JQqtGosd6BjkU6tuXc4zU7WBFxlzMVKUFLlOXe3j8blasWgBzbIYesn9l
         5tCw==
X-Forwarded-Encrypted: i=1; AJvYcCW6u/Jra+4/mmCGTDvvd9S1kJ/D5y3JEZs2hjITJyX9BRmWsGauo15NQQlFSUYCm7or0VsCDmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qezxqMg0KmduP9VNtIzxXhPkXY+kkiN9mUgoeSH71pKaQHpG
	CxngN0CD+nHwmNCYH6CxQDjsgCV9B4zrAosn+QojwZYnOa4ict1aXxyvyNxcoWktyXk=
X-Gm-Gg: ASbGncsvVaLnS4MyXgte4XP7zZ9Dnbxgb51jtp1iWXBHbV5gn2JcSGcCR/bN6RbqnhB
	T18GClzuMpUjcIlpeKvXwfdwQuX4LEfBveCx4Jx+9XI2kxOz6FWx+HMqLKl6MLSZV5Th6Lf6I0r
	mltpJNJixG5F9HjS1WWfUAWiOWpIaa5xKWlTO1jDyK0g25MxkWVftfiyY2sB3fWyG2YfghogmN3
	4L6RwdqOdTHBov0ktN+Pa6528xudhMZFr78zI3KLJjvM+nszLTir+z6fjINTt0XVQIrQWTO3eF7
	AQZb3nhejlMTuNfOoujY2UZv3aCCyUm9ev7ZAmT4zColOLK5+FXl5IhggYWjtq+RcXGSNHFDQ9Q
	hSp9+ZNFc0+kK/5VlzJORSXjlbl1FHX8X0Wau/VPk2g==
X-Google-Smtp-Source: AGHT+IHtkIfA4GRZi19NGAmQjD5gAwdeujXINtg3jsJbsmd7PFlOr9ieVObNfMl7rzdoVtzwYLvnvw==
X-Received: by 2002:a05:6512:b02:b0:553:6488:fa56 with SMTP id 2adb3069b0e04-553a556713bmr978480e87.43.1749724311710;
        Thu, 12 Jun 2025 03:31:51 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac116968sm67953e87.32.2025.06.12.03.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:31:51 -0700 (PDT)
Message-ID: <6d4cb2f9-f030-4a0d-9880-b2c3ad875626@blackwall.org>
Date: Thu, 12 Jun 2025 13:31:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/14] net: ipv6: ip6mr: Extract a helper out of
 ip6mr_forward2()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <26200b4fe0680cc340da11e6bdfe0a67d682552f.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <26200b4fe0680cc340da11e6bdfe0a67d682552f.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Some of the work of ip6mr_forward2() is specific to IPMR forwarding, and
> should not take place on the output path. In order to allow reuse of the
> common parts, extract out of the function a helper,
> ip6mr_prepare_forward().
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/ipv6/ip6mr.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


