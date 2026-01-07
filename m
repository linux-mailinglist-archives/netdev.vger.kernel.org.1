Return-Path: <netdev+bounces-247825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF089CFF8F5
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A863384F82
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1636C5B3;
	Wed,  7 Jan 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN6AmzOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939213321D4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804866; cv=none; b=pw0VR7EyDN6OKinzbX01F39oJLp+86aYtkg/KhpGWTMgzPe0R6ZEGT12NLuovTdhq6aNEWIEltw8N3PJflBxsw50PKZPzeqqb6EyKHJifrivBWByBnV0+3yeOlR0YlZFnrJkv9gIbwP20Qpx8TyU3g3NhB229N+aZ2nRymIygDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804866; c=relaxed/simple;
	bh=0AT4vDUEv9TRIpgQaj8IPoc6NLue6jXParSmt1JLomA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jonI00X02tbLfkcekI23bx53v49Jd8W3Y5K92VhJHBtqjTsHN7xlKp3hmx6gX/r6snAegh0XH1HLlvnuQBQxDAkvRD4gXZRRIuG9e+T9u9dtxC+A0qT6pH6e7wApw7vV718hv9MJsdcnkhEXrkxiwROZZa52HnhAmIg1cD62JbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN6AmzOJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6cc44ff62so1718352a34.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767804860; x=1768409660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2/0HmhG7k85iV1s6ltr9FzFKtQeEZoSv5TM3GkAWOo=;
        b=eN6AmzOJWjC2hJ9JEzrW8NQnwd4tCwlzUScERAU/ghYw72a040cUDqytc36IeeCfcI
         QYf5UnAGJHuJ6b9lLQ3kh0AtYmbSFSi6IKnwsCY8bLQeAqL3p+y4Pl2Yxn5P36xqvOx/
         Nbw46vrwI8j/iMArDtOIdaNjPWJ1YEpnKZvro4y9pHCIDAOQkw1umMQX0bHUPiD6vIaa
         Yhuhyxh9u7VmoSEho4m2ydkNzvjIfbOZ0i1rPE6kB85QT1DbyT1i0GxrRkcsdcBS6rij
         G2sRqQdKsFFL1UskrbJQIdOkbQ503m1jT3GaQnE+srmgMeTGJTwsw5cAjFCmeY/MZ5xG
         TaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767804860; x=1768409660;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2/0HmhG7k85iV1s6ltr9FzFKtQeEZoSv5TM3GkAWOo=;
        b=SXfL5cn41XphzabrtZHnBuSoLDJvKkRJLMdZexy7n9L0+EPqzcdKDtj+kORFL6QcCX
         4zH5SAEwqryqeebZLj/vyAxkjXFo+2mvLfLQX28aniLXDTOLUdSR3cqmhDtAkvWZW+zA
         5FHd1uQygYTTPa7J9O2CflHKw95irvg0RB7K+9v0YoT6+7YM7jGxM0ihysSQBTbhtztZ
         TlGEcNQ8YTnVKK3krWorhk+0mHoteOrzHZD47cIUnnE2RjWDzuNmZZy9CU2hkjqi5DEr
         +GbaDB2yfUb6FD6wk3cboVrM51Ukueuae8hQMac0lcr4350ViQ6cjjLHLDoK7U7QQhMY
         VD3w==
X-Forwarded-Encrypted: i=1; AJvYcCVMb2bn4/1No9qkZGPTBIidO7GddIsex5x9g1Ztox3PhWeo7910x5iAVNtpUfc0W4CMAw8ZgHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUfPY6WM9tpoH1Bf4TFPhHLx4WNO6SNM+qqqIa2x74jEHQs8d
	UX9xGQyDMPhgUFgz91Hn5/G38e9Y31sFdIAdhhNXWqBzlyYP0asvL3qJhtFIQg==
X-Gm-Gg: AY/fxX7nszG8QxYK6mXjlQkflN9+QAmiQLByUjdG7CHpADxWRViPXdlr2Ci2Rt1WP/P
	g3iCM2eOrBdZq/dUMRlROqTSZi9MF1sWyRGmoyWWAJuwXS5WZi5175/sV2o+w1WRFdaHhMSx6Z7
	hxbg1ZBpz7ukXAuUpBioNc+LL1lLVWSTKmSIgWNDAlNZ4xwkYl9mT3OhekGuGMfxJYvU8xSZaO/
	ni1/WVb+xrsxh29wkIV1w/SaIaan9qdMBz48llBE7KevLxaiJAUJ2Oe9/Oe+0SkWv8lWI7nVUzT
	737ZyoyZBMy/znErtmNHLbXXvgc2jEVI6SiahqDkbmWtGJOvDg6xtGR46TooHDTQyAMbjQWCv13
	SS12pGFeoUoQ4isTvphWvX3w3phCIce6ubF9N6LkqjEJnc6nhQl+zNAtomL4jfCnV8BCP6+JvOF
	wXefEfCsR9KK+d6bR6VLHv0Qcq5t2dxNY4JuOF/8q89sWQ69Xp85Hl/0dDHGhqn2ydSbLe06Guh
	jSe4A==
X-Google-Smtp-Source: AGHT+IH3TURYhqXDjS5eIt+UBZOiMLbIVAUARYGtI72QyXHgQSNy+qIQHsmlUlbAYuLLsfiNM229aw==
X-Received: by 2002:a05:6830:3593:b0:7c7:827f:872f with SMTP id 46e09a7af769-7ce50bfb970mr1364725a34.37.1767804859907;
        Wed, 07 Jan 2026 08:54:19 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:e5d0:14cb:7d17:1826? ([2601:282:1e02:1040:e5d0:14cb:7d17:1826])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7ce47801d58sm3739883a34.2.2026.01.07.08.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 08:54:19 -0800 (PST)
Message-ID: <fa3ba651-67a8-4cde-b9d2-da2d89111341@gmail.com>
Date: Wed, 7 Jan 2026 09:54:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] utils: do not be restrictive about alternate
 network device names
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20251221174945.8346-1-stephen@networkplumber.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20251221174945.8346-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/25 10:49 AM, Stephen Hemminger wrote:
> The kernel does not impose restrictions on alternate interface
> names; therefore ip commands should not either.
> 
> This allows colon, slash, even .. as alternate names.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/utils.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 

applied to iproute2-next. I wonder if the checks should be removed from
iproute2 and left to the kernel logic to decide if the name is valid.


