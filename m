Return-Path: <netdev+bounces-95605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9D8C2C9F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DB11F227C4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268D13D244;
	Fri, 10 May 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhiqAuKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854313CF93
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380157; cv=none; b=il+zFVwAfmytRTAR2bJbRuDCCWq/fDi92pyWg+eD+m20P6EBALc1WTiYrhQ6D55VHt8W1/TdW4G3oZ7Gma2Ct+eiTcwdFgrqyE0R9OWjEp3Odsy7MRMTG11glp3RulYNRcoY4h4LUOfu4T+73r/6wfkjJuJvTJ7ZS1hLW+Ik2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380157; c=relaxed/simple;
	bh=otqxuXlHk2jUbvkiHjxKJo4Hc3MokUq6vG6yxZjpnks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSpoh1OMGGUAQ0GXkTE6xv+jalxi/Uu0ur9RkdUdcJs823m555FyRJruG6kfme+IWf3wWUPLKBdBBCMP5MMVWENEfn47RHslfJYaJyWOxu2nmXhavN7Uoky9jynRuJoUl/KoPZP4c/o2Oag+WhiZ0yJdNQqfr18suSU4przt9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhiqAuKg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34d8d11a523so1616700f8f.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715380154; x=1715984954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPiPnY9OngDh6dZl3Giv9avMuLgwTDyzFozkOv3mp+Y=;
        b=UhiqAuKgDm34JNf7NbEkUa225OFSDmVn+GNvBeFFHIqWVGoPFtwMVjekr3RMfURhZj
         hFNXufZWQ8SBqe8oSYC30V7XAxPYI2jRYWoFYgV0oEoZXHpsyCsRW5MXKRiDn8PuUssN
         Rkk6ki5p0mYtQp0iAJwUp2hTgD5d316+qMmif30LKaVJBUlJE+qqRZE5cl3TeFJFQYsl
         Fukat3Ej9qKjtDlWk/lrYvjrSMLRd+TfagRvBp9asb7nfh6OP7RF+NEFNdbE80JAijqt
         bLhKoCFjN10KPjLxlw+U9l/d/rIAcb8pUuGZlDvUzTMiRaEvPE4meKyDcAH5UrLawR8F
         7v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715380154; x=1715984954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPiPnY9OngDh6dZl3Giv9avMuLgwTDyzFozkOv3mp+Y=;
        b=gxz1wuIjpTGF6fRLJDveorzkDY4NADV1Dvu3gZFWEzvv4j1BAAM7amEcw6iFSoJPru
         OiWfif9RQqPg8cNaLRW8DD4ZsR5KaPgJOlbdnZT+jM3wsfXRCFYZgErM5YL8P8orE/gf
         BUhdJ3pCDY70IrMyE71wLbiUdgC1Pgxb+PG7bR7C9hCiWPK8Ow87b0AN6eULXLW2bJB8
         ud8+V3QLv1qQYq0AutOASZihDzKZqbW4IwKjlGSceQQEWaRkRDebr3lImPAVw8Kg9Vns
         TlGxcaE5dRRpgeFVTDlbzb9ii7LUKrwWGbBLOTDORbFyE6XrqiCf2GaB21yq75UUHZQL
         pMiA==
X-Forwarded-Encrypted: i=1; AJvYcCWURZiEl6FYVAAUSTXC0O9cVuy2iQa2k0LE+6H2eNJo0h0rU2CLxGHFuHLDOMODWCV+tKtNUk8KNRvlByPLbRdrJRjVgwKE
X-Gm-Message-State: AOJu0YzK/hrDZxkbhK40x/lYY56sKe96QAJ2D4mywuGbC9CGzt4v1/XU
	Fmm9fQSyw23fAVpIRhEv6DRnUsFqhIbtwHCflbiptLnuUHr4B1Pa
X-Google-Smtp-Source: AGHT+IE8vg6lApxXGbudUHE2UP4/Y/WrtQhz/gzXAsYvxYQB9YTC3EQp7nd7tLtR8HSmuhqZH2oSnw==
X-Received: by 2002:a5d:45d1:0:b0:34e:2814:875d with SMTP id ffacd0b85a97d-3504a736d34mr2920243f8f.26.1715380154231;
        Fri, 10 May 2024 15:29:14 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be1dsm5613058f8f.10.2024.05.10.15.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 15:29:13 -0700 (PDT)
Message-ID: <f0305064-64d9-4705-9846-cdc0fb103b82@gmail.com>
Date: Fri, 10 May 2024 23:29:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: transmit queue timeouts and IRQ masking
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
 <f4197a6d-d829-4adf-8666-1390f2355540@gmail.com>
 <5181a634-fe25-45e7-803e-eb8737990e01@gmail.com>
 <adfb0005-3283-4138-97d5-b4af3a314d98@gmail.com>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <adfb0005-3283-4138-97d5-b4af3a314d98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/05/2024 23:06, Heiner Kallweit wrote:
> 
> Nice idea. The following is a simplified version.
> It's based on the thought that between scheduling NAPI and start of NAPI
> polling interrupts don't hurt.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index e5ea827a2..7b04dfecc 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -592,6 +592,7 @@ enum rtl_flag {
>  	RTL_FLAG_TASK_RESET_PENDING,
>  	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>  	RTL_FLAG_TASK_TX_TIMEOUT,
> +	RTL_FLAG_IRQ_DISABLED,
>  	RTL_FLAG_MAX
>  };
>  
> @@ -4657,10 +4658,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>  	}
>  
> -	if (napi_schedule_prep(&tp->napi)) {
> -		rtl_irq_disable(tp);
> -		__napi_schedule(&tp->napi);
> -	}
> +	napi_schedule(&tp->napi);
>  out:
>  	rtl_ack_events(tp, status);
>  
> @@ -4714,12 +4712,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  	struct net_device *dev = tp->dev;
>  	int work_done;
>  
> +	if (!test_and_set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags))
> +		rtl_irq_disable(tp);
> +
>  	rtl_tx(dev, tp, budget);
>  
>  	work_done = rtl_rx(dev, tp, budget);
>  
> -	if (work_done < budget && napi_complete_done(napi, work_done))
> +	if (work_done < budget && napi_complete_done(napi, work_done)) {
> +		clear_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
>  		rtl_irq_enable(tp);
> +	}
>  
>  	return work_done;
>  }

Reading this worries me though:

https://docs.kernel.org/networking/napi.html
"napi_disable() and subsequent calls to the poll method only wait for the ownership of the instance to be released, not for the poll method to exit.
This means that drivers should avoid accessing any data structures after calling napi_complete_done()."

Which seems to imply that the IRQ enable following napi_complete_done() is unguarded, and might race with the disable on an incoming poll.
Is that a possibility?

