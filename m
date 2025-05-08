Return-Path: <netdev+bounces-188945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96597AAF833
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D701882B5B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27B20E70F;
	Thu,  8 May 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4ak7ARX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABF1F4161
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700912; cv=none; b=caBbziW2P/wIESp2keDGh0C7nu0HumC4MCmm4Pi6HyTvCsuNPzoBdV2bE/bSXmXmdEckT+cWR2GqsQZGV/r9o8O2ZWLBWGnYrF2OBZfvY2MK1G828x0UdF6uQEggO/kRkID+JgekE6eEqQ88hI9iN1an5uETJ0hbtOJFAPXzOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700912; c=relaxed/simple;
	bh=iAlRYTTGZcQx0Pz5PzT0TtZvd6vf0Sfw6AJBcQntYCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm4exKAAVZBcIyexFohoRxhZnQWCvQsgwhO+uCdeWbuEv3sBMcCOT7k2sgZUfrZskEnjYQ2zBQ9LjhUCxb5xqfMzjGsDEUtdtBaYvjRLHY10KkndCkTqide2Qm3QGs+Skj+wCkRT5POWqc84CEiErdXMOxxCVaClBXht6PmwU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4ak7ARX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746700909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06W9iI3yI3A7kyidvO1CnfJ/RGZiJQ1fcRyuEYIQr5A=;
	b=S4ak7ARXbEEuVyoyGZaGHda0hkAh7bIzlqdu+VAgjeYE8JAWfCHosr9vJ6yNXg6rm1w4f2
	grmYqhbmnfzSUJAINvDddyyqUR34DcBb1TYNJX3Boj3mwtshHIi71UUvA54xGge8jcpSXh
	AVOegcGZmLJ8UMdxndTctehcjspQogI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-xtMeCEVNNtu8NWdHZMT3AA-1; Thu, 08 May 2025 06:41:48 -0400
X-MC-Unique: xtMeCEVNNtu8NWdHZMT3AA-1
X-Mimecast-MFC-AGG-ID: xtMeCEVNNtu8NWdHZMT3AA_1746700907
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b7cd223fso426782f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 03:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746700907; x=1747305707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06W9iI3yI3A7kyidvO1CnfJ/RGZiJQ1fcRyuEYIQr5A=;
        b=nLnbuL2w5Yujz9uPqunAg8RLxu7Rdzr/DMvlrh9RPvdK/naoLDFvajITm5QVoI0eq5
         5jUT5WOZyvXT9BX0DWDK+zWGBJfOb86EXEKnY5czThxuHuZPVkLInHLzbr6pgcqkGQRq
         /Ousr50F104ocodCyiBeULeScsQ/29u/u7OuJLHk+Xq1mf6j2vormTr/YCFl8V/8JnPM
         hosGcGMyWAyO0p3l2zX1ZEtMVV/E6jvM8ixWsiipxdNYD+5CHnWxVtGHZoYXBhysfvu8
         pDuu7t1E3rGAoQE5mq+ildANu94rRmbOHGX5IFrDwYkQAQx8O8HQX3DrWyZs+AUBYAEq
         Qd3A==
X-Forwarded-Encrypted: i=1; AJvYcCXCS7Ny4SmsJD+DoV04aIAPa+kIJquR/SZBhpXDAz5r8AbQWEwFX5jupCZf5HwOLbHCir4oXIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZRLZyVYmjfz95l/dUgi3rtt9PgpexsQz2ghEhIkl8kwPv4DT
	4cOmCLcPflpobhGAZhsqHSnFBzZ7hp9+SFbPfRa0a6lCGBaykbZqc8/3+kV55fIwT+xvBqQaaQz
	3wh4C1DgoXSLUOyuGLbyMRMCdBZS08KxUo8aOaCK0IAw6E/SaxeUiVg==
X-Gm-Gg: ASbGnctNjgJ0tm9lH4EyQYSn4KPX1XQ9Ydhgti96b2YbPEd1WyJyCEEnx3G7/lSBS7m
	SmHPzIIRyPfZlEMle6c2Dup+KUwmXfGPlHLhrOSdU3xftaVOa1AkvkiVjKdvAG1Oyr5C9ffzgtO
	8qfhur408vZbtElT7VeepsIDA135odwYg0zMEUqnyhWywAUGkopzvnqtXqXnAkqRSPAcu0Y7TYK
	pR6NISfWYWnoweFy88k2BnQPPwIK7gXWY3EImLYD5bz8enA7hHVQqr9v+qV/09gA4ozGp0Gw7i5
	DlmOI3zGATbnBQld
X-Received: by 2002:a05:6000:1883:b0:39e:e75b:5cc with SMTP id ffacd0b85a97d-3a0b4a1856emr6570230f8f.16.1746700907329;
        Thu, 08 May 2025 03:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzw7SZ/TOMN4QRjB2CTB/nANF+cPI/qY9ETolq9Ufd7U5MJbiRQptCsyXuxU8XSI4hHVVh+w==
X-Received: by 2002:a05:6000:1883:b0:39e:e75b:5cc with SMTP id ffacd0b85a97d-3a0b4a1856emr6570198f8f.16.1746700907008;
        Thu, 08 May 2025 03:41:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244b:910::f39? ([2a0d:3344:244b:910::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0ca4sm20112152f8f.14.2025.05.08.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 03:41:46 -0700 (PDT)
Message-ID: <14c78296-97a0-46b4-b2aa-0ac8fa026d59@redhat.com>
Date: Thu, 8 May 2025 12:41:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: cadence: macb: Fix a possible deadlock in
 macb_halt_tx.
To: Mathieu Othacehe <othacehe@gnu.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton.reding@landisgyr.com
References: <20250507101231.12578-1-othacehe@gnu.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250507101231.12578-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 12:12 PM, Mathieu Othacehe wrote:
> There is a situation where after THALT is set high, TGO stays high as
> well. Because jiffies are never updated, as we are in a context with
> interrupts disabled, we never exit that loop and have a deadlock.
> 
> That deadlock was noticed on a sama5d4 device that stayed locked for days.
> 
> Use retries instead of jiffies so that the timeout really works and we do
> not have a deadlock anymore.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

This looks like a fix that should target the net tree and include a
fixes tag, see Documentation/process/maintainer-netdev.rst

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 1fe8ec37491b1..ffcf569c14f6a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -997,20 +997,19 @@ static void macb_update_stats(struct macb *bp)
>  
>  static int macb_halt_tx(struct macb *bp)
>  {
> -	unsigned long	halt_time, timeout;
> -	u32		status;
> +	unsigned int delay_us = 250;
> +	unsigned int retries = MACB_HALT_TIMEOUT / delay_us;
> +	u32 status;
>  
>  	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(THALT));
>  
> -	timeout = jiffies + usecs_to_jiffies(MACB_HALT_TIMEOUT);
>  	do {
> -		halt_time = jiffies;
>  		status = macb_readl(bp, TSR);
>  		if (!(status & MACB_BIT(TGO)))
>  			return 0;
>  
> -		udelay(250);
> -	} while (time_before(halt_time, timeout));
> +		udelay(delay_us);
> +	} while (retries-- > 0);

I think it would be better to use read_poll_timeout_atomic() instead of
sort-of open-codying it.

Thanks,

Paolo


