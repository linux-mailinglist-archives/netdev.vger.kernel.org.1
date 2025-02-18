Return-Path: <netdev+bounces-167239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A14A39589
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E8216FEA3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E322C352;
	Tue, 18 Feb 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="biSovEpA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD122AE59
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867760; cv=none; b=orawY4ebKPR211bJvB7+3kKCzzsaPBZohMMOz7LaqH7Cwr+5xyRDej4UKeFxhLFLqqmDid7acK4rPMthoCSAFHfUU5zY9g7Iec1EuSduPxf/ozeBhHD5ahDo9mWIZXu5LPLnv1cnzXu1cKpa8yeTrBazMi157a5KKeVBGs5XJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867760; c=relaxed/simple;
	bh=feF1eHyyT0zWjy4z/Md8u1+8+0ZLHRFpAShbWTlr/Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHA/fxtXEV8lRGiuFPKWJzJoo/Oi6eLP++4jptmSAE8Tbdrj6TedNIcA2Vr+2fLDb40v0zloFrumckJbP6aqWdIbdbqJzk4Y1rC2+bIw2oByAeUz3RdNM+KD+eonThjCOu2rlbT1iXNMn+wnWnYQkKtb0ZNJxI2hPHkLs9WATEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=biSovEpA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4399509058dso493745e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739867757; x=1740472557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MSJ23b7dcp2nXbCFtNTYLtGlvCk+YzKblQR08ITEHhc=;
        b=biSovEpAlE38/v4+KDQyJgZSbwF/zPlf7WvgG0duyMN04oAZ1udX/rkeLmf0f2KCes
         XrIqKcLyBtVy4U69nNVrLi+R3ED3wNcTTItEWUA95EOZQggaqiiwnHp5FAhAdw+d7WM6
         6YH3sZqKyFoDwtoor1DIE3P0tEy7dnIWBIE1D/porQxnkqyikFrPxAQD9R6z3RVCO2xV
         ncQ4kcuE/DlHyoRwoj1I0DsngPlfYWFv2DvjHifmtuoZnjewTO9Dp7B30PWzu8fadltL
         BsiL9577C6AYT4GGiBC1yyEO6fZsw4trvTKikHqS5wGApwmjxTWYFAVkqLHQGRZoKa34
         rJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867757; x=1740472557;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSJ23b7dcp2nXbCFtNTYLtGlvCk+YzKblQR08ITEHhc=;
        b=fmWiN3SuTyrV3EqmpJh2U3+d9KrQKOnUvWyhrWwY7BLE3nW1BDQE2Wev2PsVQDzSg1
         4MOQfiJZGv07xnrEM8NzSbY0Dt9SojicHR90iIPIqmtreqXUEMFBNpMc+yhkYqLdZus5
         oOf+rZkxSXXVRC6yt/ZhczGDjQtM39h8e5fN9v4MguXtH7SBMszT6G3sUVthaWCQXBE6
         wq4RXwTN4sA8NOUaysrSDGwEkZeMg/ldVIronLGrA9ZhmGrWYj/yNBkKX9DQtZubprSI
         lJvtBpvYoxO4iQiREKfTuEAlLu98tsXc7z5sl/2DJbkr1+OtgeBqhg9a2qJFuBjXa/wf
         /roA==
X-Gm-Message-State: AOJu0YzN6NEKoEHje3p9d+SlwEbDmQy3ZYrLi6fWjHZ/24h0A/aUk+a5
	pfzozqDw+kVBnr1KpRvgBR9hzKXLhfMFCpxWoOIW3ecmIOE8IokrQ3y5BONoCbk=
X-Gm-Gg: ASbGncv4tavh1mcSkmVuObbeYOgLXuDeP6usURCYTcqnrYJS2RbIikqaZYR/Hbv4tyM
	Pe5NaG8gOUW3PB7uVs/Y968Nf0jDKvCh/oql0jsmHRkqrCkbZwZG3bQeSpjgmD4tNJVsjZGZyEq
	tABGIs5SCr8GibzbRoGdVPDAZNhpdXjJc8N9XEgnDSSf8b23+yCsT9Cecb1ORVTmUyRP7YGWwKx
	W+fueIbXni/hwXnTr7JUn5fieS80gxNC01efRxuomUBRJJ8IXTg2H38rV7rE6y0rba9hFwWZ+kU
	skK57pt6728HFoK6s+3Zgkfe3pz0x+MLfvfIMqW6CC67+xVCDFIisJcFjsK/7RshPTYy
X-Google-Smtp-Source: AGHT+IG92hjCJWGEFWUkF1TNBt8VJRHE77BbFuIFujokh0dlUjpL0uxRKa49heL6SedL+6HcLajH0w==
X-Received: by 2002:a05:600c:2d04:b0:439:84d3:f7fd with SMTP id 5b1f17b1804b1-43984d3fb0bmr21918935e9.4.1739867757357;
        Tue, 18 Feb 2025 00:35:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:8e5f:76fd:491b:501e? ([2a01:e0a:b41:c160:8e5f:76fd:491b:501e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm48100965e9.29.2025.02.18.00.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:35:56 -0800 (PST)
Message-ID: <715a9dd2-4309-436d-bdfc-716932ccb95c@6wind.com>
Date: Tue, 18 Feb 2025 09:35:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] net: Remove redundant variable declaration in
 __dev_change_flags()
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/02/2025 à 16:48, Breno Leitao a écrit :
> The old_flags variable is declared twice in __dev_change_flags(),
> causing a shadow variable warning. This patch fixes the issue by
> removing the redundant declaration, reusing the existing old_flags
> variable instead.
> 
> 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> 	9225 |                 unsigned int old_flags = dev->flags;
> 	|                              ^
> 	net/core/dev.c:9185:15: note: previous declaration is here
> 	9185 |         unsigned int old_flags = dev->flags;
> 	|                      ^
> 	1 warning generated.
> 
> Remove the redundant inner declaration and reuse the existing old_flags
> variable since its value is not needed outside the if block, and it is
> safe to reuse the variable. This eliminates the warning while
> maintaining the same functionality.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

