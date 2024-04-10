Return-Path: <netdev+bounces-86634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EF89FA94
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591A228622F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3291779A8;
	Wed, 10 Apr 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFqn8M4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D47174ED5
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760458; cv=none; b=Mdt1WiK9g4zWmfeXjEB0Dzfx5AkeWzwHQDhbO8u8HfWxKNtzGx6shlZXjfW2nu83beKptxpbei0/gKZYgB2fqHKGzQNMItTtFXOxvtQD/sdaN9LfKrC9sJeO0ZqIo2BVx708qi6/RkzvlR97v7CA9L2ny29Vd8W38U39QxsMtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760458; c=relaxed/simple;
	bh=6/RJjChMZeuJ1sFZopI1MpxGwaiZSHcGdTPrXZSUdh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFrp6PzqynMcWzaOaUfIQ6dk7oCb3sTaBmfoVRCBkD3HaA08ESLrT8Fz7ANC1q6JtN5r4PZ3JKdgz8grd82M0Py7RaPThBySMQqz5xR/ok6Bze5xJ3x2A97IPU+O3uIvouON/WUv4bjhT6VMpkkSL9Wo0RGX5+uU06x4dNnLWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFqn8M4z; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d65e76c9b9so14716439f.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712760456; x=1713365256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKOVmLvUoGGaKoRV6SEocxpF219ceKd3WX6dxte9vao=;
        b=MFqn8M4zNIRdhrOaVMOZY7nAswVTWIbSytB8HGya1YXa9Z0AItz0I6wvcdSWaq5wYI
         Zegz03/2s8es7Avv2OssxRF2C1bMLaI+sJ4V0SFdbEFXsuNZhFeq8CpFRJ0Tpt+wsm5k
         4Rk6S09icUGqR5bZxwpP2tcIStIhf2Bl6Wm7U1u4A+NG15l1EYLC1VvF+7LP8psGw0UI
         FxTwIEXWKg/NEh52b3gg94WtuDNMnLJu7gglrlUUAfl/v6JUSXOXLMZLPVUMROdsbf/t
         6ceaUzyqyKW6VRfrNuwQ781dg9HvzgrVbMIsKOdDfLN9hO0AqcHj+V1J3wdfP3LEQDW8
         yLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760456; x=1713365256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKOVmLvUoGGaKoRV6SEocxpF219ceKd3WX6dxte9vao=;
        b=G7lWPVY3gIDWeJOQxm1POUvTzGvajgo16Ge0WJSkdih8hHK3xTXEqEO6+3bl86ocE3
         tQcHwowVT7BjwCMW4IeFotluWgKMblcs1O/8cVXuh9s0sr6w+ZpVpPq9P/6Qtr1OIEkH
         HOj0i0+PpWJc19/3TsvkO7Ixe9EZRCfMxdnGhfwbdHZemtrc3GCt6vAjU+I9sIABF0g7
         4YLZOs7eQZOpLYv4POipr5/b393oy/jVm08BvdQZa6lggywfY+4gUYakFkwJrEqarMjx
         b7a3HiMp67UP0WWS+PYMawUeadseHu8fON6XN0YNLws2YhXdEJ3v2e4/u/waR7F4dVMJ
         AMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMEOHUpTAQpeDOQ/b8EqpVDURlf3XWTXAIwo1lKGMdtLGTLIHpf3QgIRxz1dzhAiAVqHA010zFz/aWBemwHdpwTGnQJhR2
X-Gm-Message-State: AOJu0YyUmum+9oZbNz+l/b9DYQjkOwbhKzEvkscHHVpBmEnTZf/vUi+4
	gEi/ZtFpvJPPVW2khn/9gAai2ylZwqc1+13R4/FwWXI1VLmsuKtiMjazF9it
X-Google-Smtp-Source: AGHT+IF32ayrmHjL2zxAS9/AwKwCjIW0qutS2OSPDYqNB6mz6ImRyVHQ103fr2IFTb3fSaa6ebS4mQ==
X-Received: by 2002:a05:6e02:1388:b0:36a:1e10:6820 with SMTP id d8-20020a056e02138800b0036a1e106820mr3565576ilo.23.1712760455838;
        Wed, 10 Apr 2024 07:47:35 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:2d64:d194:fad0:6ddd? ([2601:282:1e82:2350:2d64:d194:fad0:6ddd])
        by smtp.googlemail.com with ESMTPSA id q3-20020a056638040300b0047ee01746f1sm3994303jap.120.2024.04.10.07.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:47:35 -0700 (PDT)
Message-ID: <0bc56a4f-ff48-43c8-87b3-8d5d23a30997@gmail.com>
Date: Wed, 10 Apr 2024 08:47:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ip: Support filter links with no VF info
Content-Language: en-US
To: renmingshuai <renmingshuai@huawei.com>, netdev@vger.kernel.org,
 stephen@networkplumber.org
Cc: yanan@huawei.com, liaichun@huawei.com
References: <20240410025154.55242-1-renmingshuai@huawei.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240410025154.55242-1-renmingshuai@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 8:51 PM, renmingshuai wrote:
> @@ -2139,6 +2141,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
>  	ipaddr_reset_filter(oneline, 0);
>  	filter.showqueue = 1;
>  	filter.family = preferred_family;
> +	filter.vfinfo = 0;
>  
>  	if (action == IPADD_FLUSH) {
>  		if (argc <= 0) {
> @@ -2221,6 +2224,8 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
>  				invarg("\"proto\" value is invalid\n", *argv);
>  			filter.have_proto = true;
>  			filter.proto = proto;
> +		} else if (strcmp(*argv, "novf") == 0) {
> +			filter.vfinfo = -1;
>  		} else {
>  			if (strcmp(*argv, "dev") == 0)
>  				NEXT_ARG();

The reverse logic is how other filters work. Meaning vfinfo is set, add
the RTEXT_FILTER_VF flag (default for backwards compatibility). From
there, "novf" set vfinfo to 0 and flag is not added.


