Return-Path: <netdev+bounces-80534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D374987FB04
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DA31C21834
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB47CF0F;
	Tue, 19 Mar 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="U73PrjoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1107C0B2
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841408; cv=none; b=OiS0kEUJ5b/+lok3wlVAXQdzbbG7y0s+hZah0TbupA5UIZpCtNO1AISY3srm8lM95VwFLB/XrJng2TBD8fhxzef4KCXj/f3VgEFTZcGqNnuiH0/JBVBvdSpblimPUoLeNGWLeaUPBWcB2F9BHRrWwJOIf+3plYuXR9HbcW4W4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841408; c=relaxed/simple;
	bh=kA0AWcxFrS/WYfgodKR9oeBm8rr+wVGkk3W8YvC2eQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYfNfVUx2vNGL9NvXnitHfCPbUClRPXQTyo0yYM2NdxVc3zXZQPHSwGJb+OgD4xrxKu8EK+/5iZPrP55Og/0aC2T2do6KQ3w9MXOb8PtJIZ/yvrcMNV8WN7Vcg/EcRpKaSegGrYuDSuLke3nhbeRxgVeVEGwGbtkLhpQ0p5u2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=U73PrjoC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4140fcf4d02so15637135e9.2
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1710841405; x=1711446205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRx2TS7k3oIGhgqrwykAQIqX4uoVNjQvCocuO/gtRLo=;
        b=U73PrjoCIsX9lh1lmwNUHWWM2fvqR/tYi/f5k/P6DpSegGJfo62WNtoHUz6wg+KCrk
         AS0GeN25SHo1yFE9e8EizkFPGfuoqAxwdIu76BOSpmgznfysVZfeJkOpnNsQMq+Bl5y0
         rtECTzFwQVyhqvj3v/uG0AjmDLunXD9hWSUqpmqYtfw0wlCK+VTNSx4NMiI/1547BXj0
         6gGjZuYqV3Ajq55rKQBbVqhHO8dkwe9hYnt10rzdv3eh1E5i0PAvLC+bCcrAdvH2HPb+
         aIhYwRRsjgpDJ9UjAs6sSTVfDrnOK/wBLNmt4fZRoxQtL5RmhL4aev6N2Gy1nlaLyUvc
         xzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841405; x=1711446205;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRx2TS7k3oIGhgqrwykAQIqX4uoVNjQvCocuO/gtRLo=;
        b=S4ydTTVBeFxM81MHlpzJSvAKfYlD5DQT/yEMqAKO51bfXcmajEaNQWa6n82+wJIdY/
         SF1C95zyL19bnwBzQFBmO2yPa5eahWqwaAiUJ5e+gehnOeoICuCYg8FGrduHRDuDjD2m
         16QdNSubkyNi6qhSU1+1zD5KeaeeYqNeNe7Y2gG2zPq8rFOYVXrQrMrYUUg/wQPq9/Xx
         Lr+cZAbs+5MXx4+pBt/M9ugAIi+2DoAyNqgX/BVc1601d7Uc2J4JarbJ3jRW4N1laBWG
         yonuJDzv/4fHMV5GRwMwoIKPvy4PsUt4I/7Yv1/SkJZxrHCFC9ChqRBEUdeewWfvPnCW
         8N3w==
X-Gm-Message-State: AOJu0YwhWaVICWEFzWzurvqamKVAZXTfw0wa+mxPQP3OxQI8QRwrauNN
	KUmq7D6xocAMeP983TthZzXnm1zdBcR9WEaVhsHcKXWCl8W/+hNtLsEjAZkogbU=
X-Google-Smtp-Source: AGHT+IGoOPyeIflZkDq/HsGrkkiuxNwjiO8XeeX33beNvXAgxyl+0ayBezF5nfJE50j/AxYbaaxtKQ==
X-Received: by 2002:a05:600c:45ca:b0:414:f6b:f8fb with SMTP id s10-20020a05600c45ca00b004140f6bf8fbmr1534351wmo.20.1710841404572;
        Tue, 19 Mar 2024 02:43:24 -0700 (PDT)
Received: from [172.31.98.152] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b0041413aefeb9sm4417353wms.48.2024.03.19.02.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:43:23 -0700 (PDT)
Message-ID: <ddef2e4e-e9b3-493a-b540-d2ff116a08c5@6wind.com>
Date: Tue, 19 Mar 2024 10:43:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] ipv4: raw: Fix sending packets from raw sockets
 via IPsec tunnels
To: Tobias Brunner <tobias@strongswan.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/03/2024 à 15:35, Tobias Brunner a écrit :
> Since the referenced commit, the xfrm_inner_extract_output() function
> uses the protocol field to determine the address family.  So not setting
> it for IPv4 raw sockets meant that such packets couldn't be tunneled via
> IPsec anymore.
> 
> IPv6 raw sockets are not affected as they already set the protocol since
> 9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
> genereated skbs").
> 
> Fixes: f4796398f21b ("xfrm: Remove inner/outer modes from output path")
> Signed-off-by: Tobias Brunner <tobias@strongswan.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

