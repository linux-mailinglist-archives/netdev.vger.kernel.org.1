Return-Path: <netdev+bounces-96801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E008C7E0A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B571C20F73
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F701581FB;
	Thu, 16 May 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaeEEhLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C26147C74
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895114; cv=none; b=bHxcvhG9iE4Ob4p0vuuWuM3gklYpRElwf7ghmURefO6okkZMrukPPBEoMRK3RmyCpDlXOiShHWN3o+HG/tWxLywNJEBAgywKE21abpJP+rf4zToRrafF42oaGC0b1W6dqYU4GzYDx+8Dqunv6OymMGZ7fKVJZzkGs09pIKDZo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895114; c=relaxed/simple;
	bh=dWEsyXECZb5vz/jEuRxDlTGdSGb0ibqZ6FK/BaklKnU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bwkNgISvJtmWuKP73HX6YHc+BBqHCtyfbuMYCLnwvyjTkDl1yJVOSRZP4GiDGWzPks9z4ey8NbzQht/CiEW1mKwZ0uwoYoQ1HakCd6MaUC1ClB9zty/iokaAQ67pFHd93yM9ZkRpax0G2FBCr9RiCEE7fAuVUtCIJddYT7ViXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaeEEhLm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso34780445e9.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715895111; x=1716499911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWFJX/odXOheA4CWceLwWbFjXuwGo7CAuvfYKfk6UEE=;
        b=XaeEEhLmg5cbps39pw04Fek8VW6dHXaZeoewDEzdeFpZDZCgqV2tjLNKbkvt5gRATH
         Y6ruhqXeVRUun/D3rmAAAt7cfz+gFNh3KGvfWI6myBiqvXJohgg7PPasdLxu9JQ8Zh4d
         lqrSAVlBI8beourXPwEQvvHCs89hNuOiMAKhy1zte/faBbHRZTDmA3ZVjtEGWmZ8n9sR
         zxg6OkmzX+ev+wiahYN7AThFct8oNsSV0B5lgvUasaLlcXV+2IuirQi1dNLALDnh7Emy
         6IOtLOaVCFvjxqh9kO4q0m37siyygkFQIf9YxKbjQIPerB25S26PlcLZnBFJ2uWDIaw1
         A5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715895111; x=1716499911;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWFJX/odXOheA4CWceLwWbFjXuwGo7CAuvfYKfk6UEE=;
        b=e2kPClQetMx+vYQkHHSPgk+V8qIbpdPxsXOWw13+2z3r94v7lQtuD1yYNGYuQ7QxQC
         57bxjJjwYmHtWycBL3AWzcm9wHTvs5dp7BpP0Rr3bGw99UQNXMrSLSEjIXEhp7RDVjQg
         F9G43QwDBN2fnO2lY/ccaxPXOTwOKE3NUtFIV++BBnn7P/zbEhognj/EPZ88nICZ908m
         M83qTG5TD0cCqilWtJqwDaNA7LNfzvLSb8f8knEVycLXBC8LfdIsqHZbGZt79pJlsVOP
         HtfJLweIuHdKohx7Hszv8Cwp/DlI7Ajji7/LwSgxuc+xtLJ2ePSoSPNrCDmMnrM77x8b
         W5uA==
X-Gm-Message-State: AOJu0Yx9dwu+Ek3Hyl4RrhXUBOflF/DqTw1EWtFkM3IVn9iFYprECVFb
	EAK63YByveOYdJaysgsgy4lhfm5PcYiUki6OR8J063uwh+/NTtVNXHKS9M6V
X-Google-Smtp-Source: AGHT+IFWKhCkD1kauQDeNEoF3nAuTIOPBYjmMEHzAo1PETE3kRf/5sCAxzFw/49rF28LeDdZ6C6dLQ==
X-Received: by 2002:a05:600c:1d21:b0:41b:e4dd:e320 with SMTP id 5b1f17b1804b1-41feac5b124mr157385895e9.26.1715895111161;
        Thu, 16 May 2024 14:31:51 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3504660753esm18270214f8f.8.2024.05.16.14.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 14:31:50 -0700 (PDT)
Message-ID: <5b3e33f4-86a0-4f6e-a250-e7443bc5c6f5@gmail.com>
Date: Thu, 16 May 2024 22:31:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if
 NAPI is, scheduled already"
From: Ken Milmore <ken.milmore@gmail.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
 <84d8b645-d756-4a07-9062-cece62fcfd50@gmail.com>
Content-Language: en-GB
In-Reply-To: <84d8b645-d756-4a07-9062-cece62fcfd50@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2024 22:10, Ken Milmore wrote:
> To test this hypothesis, I tried the code below, which never disables
> interrupts but instead clears out the status register on every interrupt:
> 
> index 2ce4bff..dbda9ef 100644
> --- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4610,7 +4610,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  	rtl_irq_disable(tp);
>  	napi_schedule(&tp->napi);
>  out:
> -	rtl_ack_events(tp, status);
> +	rtl_ack_events(tp, tp->irq_mask);
>  
>  	return IRQ_HANDLED;
>  }
> 
> This passed my iperf3 test perfectly! It is likely to cause other problems
> though: Specifically it opens the possibility that we will miss a SYSErr,
> LinkChg or RxFIFOOver interrupt. Hence the rationale for achieving the required
> (status & mask) == 0 condition by clearing the mask register instead.

Sorry, that patch should have been:

diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 2ce4bff..e9757ff 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -4607,10 +4607,9 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
                rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
        }
 
-       rtl_irq_disable(tp);
        napi_schedule(&tp->napi);
 out:
-       rtl_ack_events(tp, status);
+       rtl_ack_events(tp, tp->irq_mask);
 
        return IRQ_HANDLED;
 }


