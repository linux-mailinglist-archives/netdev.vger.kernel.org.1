Return-Path: <netdev+bounces-106363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D91915FB9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F5B1C21863
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3BE146A81;
	Tue, 25 Jun 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yeQG+5Sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125A33C0
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299518; cv=none; b=YNONkNuDh5QfKfQXQIaSbQwkFT5DRymzgT09mSXlYB3lbQv/RssGj+bfAeceQJlbA9ZMSXSCJtzZsQmK8+VKjMcv88thaavUcONCi+lN5MlhMkLKXF3+HKCZfjWs2AEXJtQgxsh5qBYuBPPD8hh2h8AOR0RIeehLVe5UZcKwJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299518; c=relaxed/simple;
	bh=xUw0PyFaegpLdfysmtaepy0KOXgwtz4Ug3bKQffQE1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qf9WuMx0yLiRZ0ZOKKiGAfQInfOv8YdxORYvXE5W4w8GLRXJ6BsR7exkymTt3p2lW1c3OfKbo/KFaM1wL3OTO5lrzbzHFoDzfl1Ga0naya08flSrReTL1dS9emrXHoPOqDZNmFKEDsFOTqiaRzsf+4DijcnIK30C4waJ6tae4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yeQG+5Sz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso6022674a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719299515; x=1719904315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPS6ZFhFZOaUKT+6ZjzQ9R3YHRx6uh52cKqLSt3uvww=;
        b=yeQG+5SzyEnJV0y/TltV3ABpgJ+pdY2LsMo/ed49OR1eMB7NT005LQmzOI3yjqj15m
         YuYFbi2JKub/eOBn0qSWJuUlFaTM/WTSiYZldmtvu/cDWTwcRmcjJ2KRyxOaHUskTnhm
         YXzTy7HKevHtMDQEbFWM1SUs67sk6BPgsnUv98Pt6ELdQwdGAyd2PUjMXtMwm6fxLotP
         zZov+r63qUD7qVLTbsxVDh5YQHqfMLTapu7P0f3hTxdZJ2I2fxD0lzpsL3u6XSn+KO62
         d1NXVxyte7lub1DJGv55w9XxVYZ667svCmOejP8wyWivcruOdDsCE0azUZuMYtus7T78
         lu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299515; x=1719904315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPS6ZFhFZOaUKT+6ZjzQ9R3YHRx6uh52cKqLSt3uvww=;
        b=H4jD4gAoHXlIDrGMSJb+OMMYNBEFBJDW2hY+wh1jcWhpRF6YLkHmnV1lUR35AxUu9x
         yVxQQ29NKgc2HqkKoIAfoMpJTud0+Xg2gyAaP/nZ+wCdkuPusp8FuubQN02XLarlH/VQ
         CKm9q0yYf5qwJmASm/3sIPh94CMUms7oT2ar0YrOU4URxZCK74XZbxb3HtdCLJe44zrg
         9/RAfmJl/lD71B0XYMtq36pEajXkXyRs1z8YT4+ttixPRzxgtrb8pLrMvzL4eKli9PbY
         qqd9R7eppwOl5MwAfe9+vpfjQ9L6A2AucSmJXwcjV4Aoi87wElfCHze3ivRDpnE4kRg0
         pKAA==
X-Forwarded-Encrypted: i=1; AJvYcCXxmQIeShOC7SJ3WCTYkI7d6/lw49t/GguVkBkgkN3ssDunSJFNgjzpObVUAhoGP7AhAROKD3b/+eOuFvmozsh+PGIcOibJ
X-Gm-Message-State: AOJu0YyFEs6OIwlr43JyELGF+yfUZinfBzcZuWaUgPPJ4/QQze89W96G
	WpBCQy+NaL5d9/FZ2rsSWiCt2zICuBsbA9mBYgsMcE056QZ90ktxCBdeSAfm4w4=
X-Google-Smtp-Source: AGHT+IHmchx0S/+aZIzPgdQcHEc8EzqEjlraEknHtVVG1hf79tQOxbPnLMFkx/ATXCjgSdMDHzD1Gw==
X-Received: by 2002:a50:f604:0:b0:57c:aac9:cd8 with SMTP id 4fb4d7f45d1cf-57d4bd5648amr4484491a12.8.1719299515196;
        Tue, 25 Jun 2024 00:11:55 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042fd72sm5653628a12.48.2024.06.25.00.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 00:11:54 -0700 (PDT)
Message-ID: <13131adc-1e61-46ae-a48e-ab2b51037a98@blackwall.org>
Date: Tue, 25 Jun 2024 10:11:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240625070057.2004129-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240625070057.2004129-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2024 10:00, Hangbin Liu wrote:
> Currently, administrators need to retrieve LACP mux state changes from
> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
> this process, let's send the ifinfo notification whenever the mux state
> changes. This will enable users to directly access and monitor this
> information using the ip monitor command.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
>     context (Nikolay Aleksandrov)
> ---
>  drivers/net/bonding/bond_3ad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..7a7224bf1894 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  		default:
>  			break;
>  		}
> +
> +		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_KERNEL, 0, NULL);
>  	}
>  }
>  

GFP_KERNEL still allows to sleep, this is where I meant use GFP_ATOMIC if
under the locks in my previous comment.
Also how does an administrator undestand that the mux state changed by
using the above msg? Could you show the iproute2 part and how it looks for
anyone monitoring?


