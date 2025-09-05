Return-Path: <netdev+bounces-220316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45CB4563B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B425841D8
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC230AACB;
	Fri,  5 Sep 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mQudW0El"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4312C158F
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071426; cv=none; b=bi5lfDjfJJQvo4UcMrRxpNwE+emgJNVk7QrUvnxmfZTVI2ywoHUb2RZyY3cR/2ZnOe6IEWGC/MtkO6yy6PZ8MRunsn+C5TXt/mN/HRp7w2sZQLc9lDn2Fxd9naezou7MklLAb1zbfMJORj0qR+1Ntjf5Bu7LPUdDDs3X9OzdwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071426; c=relaxed/simple;
	bh=SAnAeq90b52cRN3J2dhK7tdcZAB7hzZ117Wc6jSvgeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAYPlKLK7eea0ZIJRCdNg1L1rlC3uHP7tic4oFHqhU9k1/DSyzZ/3mTXnXGw5w0hFsAMg6ma9ueWvhwtSM0naQ8igjbmkO2RfEm1XGe7G6tBIZ++AW4FE/GoDdG1TBKulzGfbgGkKaRbYxQH5KCFblMl/WUgQv3LPTW/usO8Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mQudW0El; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f646b1db8so2215590e87.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757071423; x=1757676223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjePcgGVxRdnlx5tgUBvUSH1J9FdMgeg+3lood9bc5E=;
        b=mQudW0EljYz/GTX4WgJp43aGlvLGYe9gEb7GZVo9jqnRJJW46274RTD5GSS4rajjRM
         C2kxb7sgoHbdSh9iLxTpAJPkZuYQy4ZSCU3lEjzts+sAqVj69RlDF+pE5IDkYBXI8588
         43ycz6C2WupwceYTOxb9XZRgiHvnhnz3Kkx594yflLKjqZGyAagugRdOmiWHwF5/fG2O
         hstMcKPj8hJJXhYcQ32S2JpbuR6oaYmzFWdUQWp+tY/oS7bErVM15VED9POiBLCkXaQ5
         e33slLgKlmZkGq0u9J60kwh1NiMhoqtIhzSImLgXyQFxsK6j+61h8ymSxZR4lcqtbJ5l
         56Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071423; x=1757676223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjePcgGVxRdnlx5tgUBvUSH1J9FdMgeg+3lood9bc5E=;
        b=LtPl0GSvE9BTcwuIrZCuTcz+vB/kzkwdY+C3JTInU0uihHeevaRjeHXSqpNKvDjkKD
         8Otv92myXwcQ4PWNtc7e6UxbFV6coJTDehYSWnS3WL4w8xm6qJD85l9XSto3BTUd3Z6V
         c7rtTwU7bTQYvWf9iLBENkJ8VNSWhQNKv+95cVoYqj46HkBozv4vuslxVXqOXgBN5+xG
         kEVNvyxd79wTC/a5nMxbWmh9BGAGHBCelX+D6UPuW9ePfYvgOXDxodMvxATd+CPPXoRH
         ufaqMjPmheqHyN7lH4ymh/Iq2nUgc/j5v0h8/eJa4TcCOq3vStlKaoD67+/w35z/FMgF
         +6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKLx5JvdPvGB+r3CIUSQGcE14FjAshfKhe4f75+InSVu5R2bd06yJ+cw7UDns0rIkw/naJCQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNj3hXu2b7guGQQUa2LdfxJriEEEzSQPxHkDMfQ8dPJ62zX2B
	f2bbYspfs0GSjunMPiPqANAf7ERKVVrK6x85X1OheBhG81u5Fo2BuLjndABXS+XdB5c=
X-Gm-Gg: ASbGncsUkmQ0G5eBb6M9pnkehIPxjK85ZovumsduhuZpJFKakV/HjAP/tx79tl8AkMe
	7Jf8rbJxRsaQx40uK6P5L2LV09p4F70A3cTJevj5cF0dnRUMSpeD0m2RPni0FMW5mYFvG+nmoqF
	/Y9zh3xVnE5+aACOhK8OIph34JnNsHIPS99oLW9s7/JicfVDHitptjA4cphSdKMGZWgx0ei9Eob
	PRgtr631ezSButon/n4T40n0NZ4pXlb/SEtjiBdHuwsmPFQvOIBTZxr3cMvXmNzrrq/Hlt5rzIv
	7TQfRqoGg5cQe5wVKbkY5zP6eoSYRjGTrww2fn51tdgn8IxHbh6p8Pt/u9OtwHsXHuG3zSkZvcJ
	3AYXSblUNzo0BjT6QuTG8ctIAtpGgyk4H/O4VwnluM3bmiadAa0TiioBqkQH1IU1vMCMZXjbf8y
	w2qw==
X-Google-Smtp-Source: AGHT+IG7XfHY5EKO16EPZ02JXxyYGpGUowCGrABENprb58m965+F/rB1M7OFT1GyVqHp4CDfW0yTjQ==
X-Received: by 2002:a05:6512:10d5:b0:55f:63ef:b2bc with SMTP id 2adb3069b0e04-55f708a3797mr7677199e87.8.1757071422320;
        Fri, 05 Sep 2025 04:23:42 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e2e3sm1737828e87.147.2025.09.05.04.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:23:41 -0700 (PDT)
Message-ID: <f47c15da-f574-46ef-9ed5-e5c26658b116@blackwall.org>
Date: Fri, 5 Sep 2025 14:23:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Bounce invalid boolopts
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, mlxsw@nvidia.com
References: <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 14:12, Petr Machata wrote:
> The bridge driver currently tolerates options that it does not recognize.
> Instead, it should bounce them.
> 
> Fixes: a428afe82f98 ("net: bridge: add support for user-controlled bool options")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 4bfaf543835a..512872a2ef81 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -346,6 +346,13 @@ int br_boolopt_multi_toggle(struct net_bridge *br,
>   	int err = 0;
>   	int opt_id;
>   
> +	opt_id = find_next_bit(&bitmap, BITS_PER_LONG, BR_BOOLOPT_MAX);
> +	if (opt_id != BITS_PER_LONG) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "Unknown boolean option %d",
> +				       opt_id);
> +		return -EINVAL;
> +	}
> +
>   	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>   		bool on = !!(bm->optval & BIT(opt_id));
>   

IIRC at the time we did this was on purpose, the mask that is returned should
show which options were actually set without disrupting the call.

Anyway I'm ok with returning an error for such options as well, thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



