Return-Path: <netdev+bounces-74457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56B58615E5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E811C236B4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34A80615;
	Fri, 23 Feb 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MAP6s0Gz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEB823A8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702442; cv=none; b=mgYcnw9wb82hC698QYiEm/08xjMVp4KYVRlj4IK0NkHLGTZeuybMu7jaxRsgEe3btgKl1PYcV85twB5aKll0F8xM4d+Jy17jKNqc3eUshpik/tjna3CTYKY7bRaAUE3QlqoMTOQczna5ntJSAjzteFYJxhbEXVZCwBnhUmsrgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702442; c=relaxed/simple;
	bh=vdBr99p6bAykkT5Kv2wcJizRaXadoVKw3jqFLaUR+I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0dBluA2e1MkYIs5gnIWh+x/NIHelGomPb49odvCk1mPMs4gEawH4SRosV3FyZgeMvEH5QFjOs3JZLF7hLRe+uDVk6qmIwEKge20y+Wgr4n9MP8QEx9hTg2zt0hfI6vEuWkymYD+E1i3G6GzxhYf6y1cyOcupT8AUW2rfdhTsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MAP6s0Gz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ce8cbf465so657836f8f.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708702438; x=1709307238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+wFU3fXlGWoAaxXFF2EEILrI6It2RtvGw94MDuZQGiM=;
        b=MAP6s0GzV3W6P4czzKPtbbDTxOoEydDTRdZqMgXDBwYBJ5jeo3QbHfXviF6Yiys8ri
         xyIeZW1Ra9yLnoHUbOwsXx8NJwpNn9bRckAGUOGSq0JJz/6GdVF5JGWql8cyJAeBGkpD
         hwcIATtMAY9kvOCqhfcCxXW4M5TZ2gCrnzKAqLSrqPghUh6/tFzwrKqshbY8VBPLHt8U
         QYWfpGIx5chM/3QTkSXk0DS5e3HF1m/h53G51qOm6jmn05uEr2RuV/ZZ6sL8g7KKnh6X
         tELjOmof2UCsNWqW0R5liyy3uxkNdoIb+CveTw4mamfOSejPM0xOw0sI/HPCsee3sfEq
         GAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708702438; x=1709307238;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wFU3fXlGWoAaxXFF2EEILrI6It2RtvGw94MDuZQGiM=;
        b=Xqpqc/lnF0y+cB/go/Kzm4/yhRXZw0JeBU7P8shDCP/PomWgfeAtj67Qvs4dhnAVTu
         y8JtMGq4cpba1k84XTDf8I8dTZgmTyZlLNseH3O8T7E3yzUuasaxeAEu02xttnWeAThz
         cxBYUn830p9JdoiYHtrI3KraGpUEVcy0/fBx1ciznPlrl/w/S4FMrDEVCzx0GFjl9FAL
         TRIv5LY3G3WBD1qXFF+Uxrng2gqgyDbPklW3SYC8s7f4nCbHKIEwgTLCYz3UqJJs4dvl
         vNXexkIfJN7OHooUgbsh+s08qS3EBee5D9Le4X9/6LeV0qmXfWREHvQgLK9NG/KBdY+0
         36Cg==
X-Gm-Message-State: AOJu0YxnL/zImXpT6L+njSDTbSfUDNZeXCA7deT+DzF0JpGVQ85lirOs
	tF4OUwFIXq4aawlRGCUZKSSplEP4iPwULsmsU0mfDSDAgYMwvpf9BsHnP9q72vU=
X-Google-Smtp-Source: AGHT+IGoWeHpzbIA8rTb0cgWJiiW7pQ13fjBovXmfBpQez7uRXGAFfxe8XLp2xHzUq8U8GVbPtDFuw==
X-Received: by 2002:a05:6000:1757:b0:33d:9eda:c817 with SMTP id m23-20020a056000175700b0033d9edac817mr70692wrf.44.1708702438375;
        Fri, 23 Feb 2024 07:33:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id ck7-20020a5d5e87000000b0033d7003eed4sm3395460wrb.73.2024.02.23.07.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:33:57 -0800 (PST)
Message-ID: <e481d437-f55a-4895-ba1e-ccfac5dd0d9c@6wind.com>
Date: Fri, 23 Feb 2024 16:33:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 08/15] tools: ynl: wrap recv() + mnl_cb_run2()
 into a single helper
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-9-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> All callers to mnl_cb_run2() call mnl_socket_recvfrom() right before.
> Wrap the two in a helper, take typed arguments (struct ynl_parse_arg),
> instead of hoping that all callers remember that parser error handling
> requires yarg.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl.c | 56 +++++++++++++----------------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index c9790257189c..96a209773ace 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -491,6 +491,19 @@ int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
>  	return MNL_CB_ERROR;
>  }
>  
> +static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
> +{
> +	struct ynl_sock *ys = yarg->ys;
> +	ssize_t len;
> +
> +	len = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
> +	if (len < 0)
It was '<=' before your patch. Not sure it's worth running mnl_cb_run2() with no
data, but this doesn't seem wrong.
Maybe a sentence in the commit description will be good to tell it's done on
purpose?

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

