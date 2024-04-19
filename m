Return-Path: <netdev+bounces-89565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D688AAB6B
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126121F222AF
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C4762F7;
	Fri, 19 Apr 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NeKvRrx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EF71B3D
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518735; cv=none; b=AEpNAqRBRoJ5Pp0obsTNTJ4KfzQmJMtNHYCHFm5HXTJJCItTnOzYihyJw/TTSHI/XtCcrsVWMuEt0haZu5/ztV4tlXVP2V4Zbq1I7CWa9AoimXnAs1PijC+kGZz93M6D02mEgiNPpSUsT7TD5Ge8fcoXHoJfAaOCcAIg0naiGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518735; c=relaxed/simple;
	bh=lwfbCBDs1tEwbE1UZPUD88YzNGmP7APawOKjZXevzwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5dIlbiymf4uoD9HxmL/9bFg5iK6YDCSmbeYAPTyY85cVtv9sJVu3xgJh1eFjBm5opI4Png8FFgZzzEyO3O1vfIgLZ6MjdsgZaMR3ArsCcDzOaXfcjB3QRO5PzD481qQwcivbXTUAOBSHxg7gWT8jOO01o84Ar2AJ8fwHd/URA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NeKvRrx+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso2971744a12.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713518732; x=1714123532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwf2npPrMEmhMxrv7/NTurvJ8uTzmGNrt6EeJbqzv9U=;
        b=NeKvRrx+K3ym/Yws05TwWOIoU8OCv8MtO9S0BivDeLTO6lR5HI2ufjBZu146maCX3Q
         /+izX/ETGVLfqtqxLw76c5PykF4H3LFLAQbYNxoxv3zFNLRqa4haOmS3q9k98uSfKLMm
         nd7YbHT+pd/CN4MSz4sVV5F5ou6o4Z+wm4Ua/WrqqTTcHoJqZtuzorF8oBCZWG7UC/kV
         8rizRawzDtsO6XGPS+bfR8RFNbA6OJe4Fbi19SX083qF23wQqg5QeAewMN4H6u7NgVE3
         L/GNjdKu4zRB/jPrPsh+R4aY26oyvh0n8eniRTkgIil1T04wkxiSg37k5mS7OqSJIBFK
         630g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518732; x=1714123532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwf2npPrMEmhMxrv7/NTurvJ8uTzmGNrt6EeJbqzv9U=;
        b=iutSTmFx9HtlUFMw/9p9r1lf5dBh80D58pR9uEDVhA2X6tLny+fzJvvVLNx0fBVmY3
         3VUjgOi2S+iJOmFzpMMjJF7Oc8OnbJ4RYSnWAuA6hjLt97YrVZUzJVYtfKxDJSDVgnnj
         n1VEI5u5Yzg8uMU8S4yLOC7gmtZvcMb1F0sbjcfFEXwuZ1JNGAkRdKJt902hZdT9BZ/A
         dG70p5G8RsU7znFj1rSJOhLQCuKqPsODfrgVLZPCHhttDy/jQCj47l9r28CngDC31Tlt
         1rGC7Yg+x+ymDGLFQM3tcHw4vzxREhqJSPOKMoEeVh65DKeZxsMz3gQkwsYLQqpSSA6N
         zsrA==
X-Forwarded-Encrypted: i=1; AJvYcCUHkjAo2IhUbTqwS66tHAj+aHd4k7lmPBaVUooOSve43KHkeB3LRlzO+YNBiVG5GN9kYM71rYsQ+GJp8u+vmk++fZi4DL/m
X-Gm-Message-State: AOJu0Yw0sSN57+gGMmYOI5BHBq0+e+2Vy9oK+iNPzfCWE/qfuYLn7sgg
	Swohtzhio1NOIMUKAAWgLrtLLHbmzGyIYfvdXmDJn114yAaDGVJesJ9cwppqUyw=
X-Google-Smtp-Source: AGHT+IEl3rvlq6QmdmVaDorfQOCxAXtCAgbkDlD27c2AQSzMAYnN5ZI4Sw4Kv8LA4OlLhHlCmYxBjw==
X-Received: by 2002:a50:9508:0:b0:568:b622:f225 with SMTP id u8-20020a509508000000b00568b622f225mr1041542eda.30.1713518732359;
        Fri, 19 Apr 2024 02:25:32 -0700 (PDT)
Received: from [192.168.0.106] (176.111.184.242.kyiv.volia.net. [176.111.184.242])
        by smtp.gmail.com with ESMTPSA id fi5-20020a056402550500b0056e598155fasm1875341edb.64.2024.04.19.02.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 02:25:31 -0700 (PDT)
Message-ID: <441dd6a4-281f-4223-ba96-8767cc902e7f@blackwall.org>
Date: Fri, 19 Apr 2024 12:25:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge/br_netlink.c: no need to return void function
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, bridge@lists.linux.dev
References: <20240419080200.3531134-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240419080200.3531134-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/24 11:02, Hangbin Liu wrote:
> br_info_notify is a void function. There is no need to return.
> 
> Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   net/bridge/br_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 2cf4fc756263..f17dbac7d828 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -667,7 +667,7 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
>   {
>   	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
>   
> -	return br_info_notify(event, br, port, filter);
> +	br_info_notify(event, br, port, filter);
>   }
>   
>   /*

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

