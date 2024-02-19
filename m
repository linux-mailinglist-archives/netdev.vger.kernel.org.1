Return-Path: <netdev+bounces-73001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3185A9C3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BF01C23ACF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F741C9D;
	Mon, 19 Feb 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bavSWnQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06946B9F
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363130; cv=none; b=FeXfa+MXH7yaSYlTPz+WUD3V2Xcdioc/M127PmQK7AIKCXtApL+fefLVmwCHXz0FHVJSU5nVc/UnhS5KSwGoLr4zoM6qKM8o04lcnXwwrK61pAW1MaKGb+X55YmU+NTQg30XyBsG25DA5in//tHkTdJpiALPtAwMqMDPji+qr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363130; c=relaxed/simple;
	bh=K9wkix/FIZrrpMWu9FKkh9nPhgmIbCNSHndK2nbqPjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMy6iEhTQ8byZGJ8gP8Ym6+aKZsIXz+RRBvOmlSM3b097d0lirhO4pWsPlhFGcU6tg4aAOkk4MvYuCOWs7/4EMgMALyxuf/AxIOd/zfgkW04KcVvRwqJIElBmFDTeM2EVxUOQT3GmJAZCNIo9hJsVUYS/VJzqElSCPg5X4/vfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bavSWnQ2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4126b687bceso3054715e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708363127; x=1708967927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mBJlGh2Xzf60vdFhbvjO//9iXyVbgbG4VTV80JPMGzQ=;
        b=bavSWnQ2fH1zCyS989c934Om3QQSOF1y9vwQKZjR1q2I0lY2mShwzjBi8zwtbfbLyI
         zmCPzK++ay7VVAgoFc7rsa09BPnjZa6GHBFXz5WAG8AdaWj0qjcMbDs6LZziBtvUndHZ
         C6io5/ybVzvrgpTcpq2B7o2CXYZflJubcU4QeuqVQPAZ2AB/a8ev7987spJDWer9C7Dm
         mc7b5o77eah6hb9ss0ffiS6eb0taaWuhnSVFdD+0LTkUr1SXTowv41x41CAKUzpiwTjX
         coy6cCzLP0nHetpGNdp5371BqpH6bxP1LPaldkHpjm/K07ncNjbDhRYTFTBLxHELQEED
         3RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363127; x=1708967927;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBJlGh2Xzf60vdFhbvjO//9iXyVbgbG4VTV80JPMGzQ=;
        b=EvNMNnS53bBHWCcEHa51xRlLNzbR8W7gLUimXnCBcFLK8TtNhUSUxs0MMvRGpJPCmw
         fD5QKa+vpbiNrm/ZKhhf0Q/V5iyicB4qATYhlkiUhD75g56POvbtzTt1qJfO48UySPi7
         zC/mTY7fgIDE1Qz3xY4QXQ9pZAwSMgiH0b1tZdq+kfrtyh8Drfb+hzsL8Dx/U5lojx1P
         HrsD6EQtIVWLFT8CYYoFAM0p2GFgVZhg0tAOLJphxZwElCn0sQ9klWt/pAQY9PGkr0vr
         Qo8mwWzv0dDs/zqbwhoqEkDO9JKzdG38ajq27+M5eByUfSOIhNdHFdFZmfHbcgd45lWM
         NSEw==
X-Gm-Message-State: AOJu0Yx14+CHA96+GBz41xbAV16BBywXKQJ9RT0njFwt3tC9Ijw13jU+
	RVGO88iS5KfKcsl5AvfT4m12cS7syOlmI+fULS0HmewObujfc8voeeKo5b3hKDg=
X-Google-Smtp-Source: AGHT+IFdjvC3esrtRhBls3MEGALnYGS1wLQEdWTvlA4mfro/8lWw/SCv4JODGDjuw9vpX6P+hGFMWQ==
X-Received: by 2002:a5d:5011:0:b0:33d:d35:374d with SMTP id e17-20020a5d5011000000b0033d0d35374dmr8272374wrt.62.1708363126824;
        Mon, 19 Feb 2024 09:18:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:31d5:8fa3:ed75:9794? ([2a01:e0a:b41:c160:31d5:8fa3:ed75:9794])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b0033d449f5f65sm5213087wrb.4.2024.02.19.09.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 09:18:46 -0800 (PST)
Message-ID: <0b40eab3-0166-42a9-a865-e00393fe98d6@6wind.com>
Date: Mon, 19 Feb 2024 18:18:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 2/3] tools: ynl: make sure we always pass yarg to
 mnl_cb_run
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 chuck.lever@oracle.com, jiri@resnulli.us, willemb@google.com
References: <20240217001742.2466993-1-kuba@kernel.org>
 <20240217001742.2466993-3-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240217001742.2466993-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/02/2024 à 01:17, Jakub Kicinski a écrit :
> There is one common error handler in ynl - ynl_cb_error().
> It expects priv to be a pointer to struct ynl_parse_arg AKA yarg.
> To avoid potential crashes if we encounter a stray NLMSG_ERROR
> always pass yarg as priv (or a struct which has it as the first
> member).
> 
> ynl_cb_null() has a similar problem directly - it expects yarg
> but priv passed by the caller is ys.
> 
> Found by code inspection.
> 
> Fixes: 86878f14d71a ("tools: ynl: user space helpers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

