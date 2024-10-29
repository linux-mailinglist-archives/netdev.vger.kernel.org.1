Return-Path: <netdev+bounces-139736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C59B3F09
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E12831C0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E9567D;
	Tue, 29 Oct 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL6AzFE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3FB664
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161309; cv=none; b=Vs/Psl9iggDgjLCrpPY/i2sDm6ZQRjLlTGznmwa3Pw7XrKAt5e7y3P/nSJ0STN5HYL4bK0A99bWkYuZNS6svOKn7EbtvsIki47f3nt3hJvVY4yhBMFXqi/yViQdnQrPWoELZ/CI1K9P2bcJHEu9yp7hMdByKPdUi/m7o+4vT97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161309; c=relaxed/simple;
	bh=Spr/9gVQ3ixnPp96IeqLwNnmNbT1srTZhFONFqG2HrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4nVw5nobT3P0oqF15Kzu3ybbHlcTJOrbr5ZvseOUeVluajycczbZ7UuFSfGRcaL00VT0KRwe6datOfVi040voO7SluPPeC8ve3cuc2HcEwlb6BlTWpz8r9CuJHTIib3noWv9NkTcimEHU8cQdKB2drQB1t1mOAs24VmRhQ3+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL6AzFE+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316cce103dso64729205e9.3
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 17:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730161305; x=1730766105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWbzABAqI/ojBk78q2sv3ilITM+mSGZHAe/vl0Koep8=;
        b=iL6AzFE+Qc7RRjfgE/VJM8oDfSlrJAAqzCg0B8NT87DDn1Veuxe+jnlAm/xXICOPXO
         dF9RRWrZ9Q64YRBqf8y87GHsM3QH6nZ3YUr8iMHP4S6AV958CSQ0qem3IezbQeBQRf+w
         OTapJA7k6F5e7CnxWtR/8amBoNrzl61Biarabjjhx/8iLxpqNpmqCOWrf+RQ602edKFQ
         IIvlK8kmxuvoYkIG+k3iGSf+e5ekeGjDL6wYOeGGxVz2aihusWa7JGka7F7q04byPvnC
         Bm2aj/GWWI4JiB7D3FoXg+9k2mI7Vdp36ugJ7GG3ab3qabI2fIC0p3Zztq70Nokpx4u6
         25XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730161305; x=1730766105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWbzABAqI/ojBk78q2sv3ilITM+mSGZHAe/vl0Koep8=;
        b=vzx6PuXOuXnIsDgktMj5R/AtYurPHZkjqhHDffkwi6MtsoOOWFe/tQVGnOFqv7r1WN
         Zkc94UweYhP4dCFFg2J9oXF1kMssklSevKmZmUN+0Qs/FEFaJK9DXNWr2AmnnHjr9ed2
         bqqTh6MCTM3Ni1HfAg/H9mVPCoy/e2bCxiHA8snLHCbv4oUraKbk0SO1rNGl1jTskExx
         Yk+iHjonW/JvNzhzV57I/TuDpynZ5zYOJFbyfpd9AQWWoH1OMyyeW+ZHDSceEpBm7WFC
         aFfd1X6CEGhzFeUgzkaJGJot0O2Zhw8yeuEvb52UuCA921bU0P+5vg/kvb/G2vSED0V/
         wTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXuZUCfd3xDniqoNOStNV7hPwwSWFawF5sj/xNQgP1/CIxrSH88IajAsZjJZoAHjoaTGAvOoZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgyhO0U9DOAIXtpGtjSb/EYza85fJraOCaNPvX6tx1broHwBUJ
	PWCVduAzTX4YD86+aGi4Pao8zY1BZEdognaA3lcL8p9xTw2ereIY
X-Google-Smtp-Source: AGHT+IGj0S3WXjl/0uGVzhzJ69zkp3mVZZB6MmaUnIx+ClV50f+D6rqZ1LJKFUWgsLo4MMNYbycKxg==
X-Received: by 2002:a05:600c:4ecb:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-4319ab8cbfbmr107182805e9.0.1730161305160;
        Mon, 28 Oct 2024 17:21:45 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431b4598b8bsm4874735e9.1.2024.10.28.17.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 17:21:43 -0700 (PDT)
Message-ID: <42f19231-dbe3-4fce-8836-75089f280296@gmail.com>
Date: Tue, 29 Oct 2024 02:22:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] wwan: core: Pass string literal as format
 argument of dev_set_name()
To: Simon Horman <horms@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, llvm@lists.linux.dev
References: <20241023-wwan-fmt-v1-1-521b39968639@kernel.org>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241023-wwan-fmt-v1-1-521b39968639@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Simon,

On 23.10.2024 15:15, Simon Horman wrote:
> Both gcc-14 and clang-18 report that passing a non-string literal as the
> format argument of dev_set_name() is potentially insecure.
> 
> E.g. clang-18 says:
> 
> drivers/net/wwan/wwan_core.c:442:34: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>    442 |         return dev_set_name(&port->dev, buf);
>        |                                         ^~~
> drivers/net/wwan/wwan_core.c:442:34: note: treat the string as an argument to avoid this
>    442 |         return dev_set_name(&port->dev, buf);
>        |                                         ^
>        |                                         "%s",
> 
> It is always the case where the contents of mod is safe to pass as the
> format argument. That is, in my understanding, it never contains any
> format escape sequences.
> 
> But, it seems better to be safe than sorry. And, as a bonus, compiler
> output becomes less verbose by addressing this issue as suggested by
> clang-18.
> 
> Compile tested only.
> No functional change intended.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Theoretically, we can pass a string literal there and all the arguments 
required to build a proper device name of multiple elements to save some 
ticks on the format string processing.

But this will require a deep rework still with intermediate string 
formatting. And since the performance of the name allocation is not the 
case here, lets go with your solution as way more simple and clear.

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

> ---
>   drivers/net/wwan/wwan_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 17431f1b1a0c..465e2a0d57a3 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -431,7 +431,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
>   		return -ENFILE;
>   	}
>   
> -	return dev_set_name(&port->dev, buf);
> +	return dev_set_name(&port->dev, "%s", buf);
>   }
>   
>   struct wwan_port *wwan_create_port(struct device *parent,
> 


