Return-Path: <netdev+bounces-202884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D18AEF862
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0F01C03428
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49215274653;
	Tue,  1 Jul 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4NnV64h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F05273D8D;
	Tue,  1 Jul 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372659; cv=none; b=ci1H7fj2MQqMIHFV48fsXy9jLQ5MkAvsGCBId+h5qbXRUpB+cBDojjsZXv1FJEVVP3Q8Dv2kQnI6ADtu1e1Z/r0zHtC0kbVhyo1y2zA+z3tEw1pkvRMUr8Y6ZYoMcQONR/3dGSRj5+ydJ7kWg1BpEq/d1BfZTZcXwT6gLPyoOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372659; c=relaxed/simple;
	bh=INulgcH/nzHPzEw+6nx7yLO32379I/EfVJ0SS1QNbJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAn4UXAMc5dEytmjjNCzld0u6XRXOqHdLCwkyNK984R9HDuwirXacb4ey3qlM+aMdUjAZ8F8tX2Fdcrp3li7ypBSwNcbZv0g9Uu8XWwP9jAPN0lWC21KvBXNKaVjHGDIx/Mq0KiGKy9BqCOLOTUanAJ6JnKz6tO3RfQFBHV25lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4NnV64h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so4038321f8f.2;
        Tue, 01 Jul 2025 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751372656; x=1751977456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3Wtg2aGHhRy0M6H8IQ6x3ipYCPJsyzm0Bs4otQB+Po=;
        b=T4NnV64hbTHJUSPimdGt6vMDp5+63nczOttfPLL9qNP+OyHoZYgRJlzUBqdyvOwNCi
         SJZofkkUOP7n2vIIQm9DmYAIg4k/u/S+qd/XoXNagKiqpRwyeVv/88yZUozGUfD5oEDk
         zYHVR0exRNCrrREbVpYd5ocL6VAGiod2IVKn/tpsmhS/n1OQKZf+93A2tyXffeZKVJ50
         N6rnjfUuSLTY+V1/gtlNKLrYiIDeDUL7qENFrYklauq0mnqrssttqUCSW8WjB8f11Y7Q
         Y4OIScHqTvVBSFEXqUlUt6endcv/kmrQPJgQMlSbPN1B1XAqDHP2wnpKTx2Rj0EMEb3n
         znsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372656; x=1751977456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Wtg2aGHhRy0M6H8IQ6x3ipYCPJsyzm0Bs4otQB+Po=;
        b=dG+cLtb2BOR5usfcrk2xEAX+YNEu5vIsrMdh1QNV7Zcq1PbA+w/zWUHmu4hgtcauSE
         xC/w+oBvvS33D38Aa2cMzohcurHg/LETPFpet480nPhZrOQfNTBSSFkbdVuEXQWXL44K
         qjdWfRPlGyF5SuVbr9EfkvUwxsUl5kMsgFaNZEpCZxNyeFG0f/yLauEyCTUcSB8dEVNK
         OXAbw22eCR/hYGobpIxI6qX+4F5gn4eu8uN5zao0gcEwefODgAfsQx+Z58f9Z+5XdNKL
         Tj1+YwMrO3qJ8OoE7TJ3x7RdWFojQ1Zn4PobPmH/Wi3ECZru9MZktLw/g2wE7kD8Uj2K
         KQaA==
X-Forwarded-Encrypted: i=1; AJvYcCXSIzhFHSIOuip0GPFvNYY84ttvND6Y6iDu8U9+hAvJbULW1ULIga1kRx3zvqhC54l50XAYRn7VQ5/8x0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOtfdxibH1kKsRfDHO8OIs2v6mhL8/yi7zaP5bQ6cyY1opQ/w
	lIy3pe6Nt5ufA3wZXp5KmBjl2kLqA/PVLTodtFETrBXCBL0l5tp37OcZ
X-Gm-Gg: ASbGncvqu6X4nZPNM9dE6jCZnh0YX0Ou1OSMFBjMaZhKU93MmcIQif6WXYlxIonI1Z9
	Qwta1HKOp7mou+m0mccEGLWcK0FxadrvdgkcEljV1crDLjBrMv8a3M/akq0yk9C9mO4nfjBcpZc
	tEECcesCXAs409cjkly1XnpZraD06xoSOZEJPUMjWbZ+2Q5wfJ4hvofSta9AcXlSNjYJo7ntsMI
	39VVvq1sbktdI5klZysc15Z0pB2lrgtcdI3KKQ/Ab/U5Kve4zqZn2bE7YxDkNSEm/7aihDmRHwV
	oG0x9DaScVJsHaHx43Mf0y97ZWFiibcjCNSC1Ush1zk3O2pGGabISnJe6/GTldpsuadoIqm1HBF
	mC683qVgR0jcYcmUp8YxPcYAC4uMyNGh09ABhlxB1dz2uAt0ndg==
X-Google-Smtp-Source: AGHT+IFVht3relObZqzWGT0XDyqUreLeTVUjvPsi4ZEg5WYRJLxoFHN8VFWY3YEcwMK3EIrI4A8Ghw==
X-Received: by 2002:a05:6000:3c1:b0:3a4:d722:5278 with SMTP id ffacd0b85a97d-3a917bc77dfmr15264267f8f.39.1751372655503;
        Tue, 01 Jul 2025 05:24:15 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab7asm13077348f8f.24.2025.07.01.05.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:24:14 -0700 (PDT)
Message-ID: <d152a6ae-4303-4889-b68b-25e29ea8eddb@gmail.com>
Date: Tue, 1 Jul 2025 13:24:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: eliminate xdp_rxq_info_valid using XDP base
 API
To: Fushuai Wang <wangfushuai@baidu.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20250628051016.51022-1-wangfushuai@baidu.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250628051016.51022-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2025 06:10, Fushuai Wang wrote:
> Commit eb9a36be7f3e ("sfc: perform XDP processing on received packets")
> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/net_driver.h | 2 --
>  drivers/net/ethernet/sfc/rx_common.c  | 6 +-----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 5c0f306fb019..b98c259f672d 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -404,7 +404,6 @@ struct efx_rx_page_state {
>   * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
>   * @old_rx_bytes: Value of @rx_bytes as of last efx_init_rx_queue()
>   * @xdp_rxq_info: XDP specific RX queue information.
> - * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
>   */
>  struct efx_rx_queue {
>  	struct efx_nic *efx;
> @@ -443,7 +442,6 @@ struct efx_rx_queue {
>  	unsigned long old_rx_packets;
>  	unsigned long old_rx_bytes;
>  	struct xdp_rxq_info xdp_rxq_info;
> -	bool xdp_rxq_info_valid;
>  };
>  
>  enum efx_sync_events_state {
> diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
> index f4f75299dfa9..5306f4c44be4 100644
> --- a/drivers/net/ethernet/sfc/rx_common.c
> +++ b/drivers/net/ethernet/sfc/rx_common.c
> @@ -269,8 +269,6 @@ void efx_init_rx_queue(struct efx_rx_queue *rx_queue)
>  			  "Failure to initialise XDP queue information rc=%d\n",
>  			  rc);
>  		efx->xdp_rxq_info_failed = true;
> -	} else {
> -		rx_queue->xdp_rxq_info_valid = true;
>  	}
>  
>  	/* Set up RX descriptor ring */
> @@ -302,10 +300,8 @@ void efx_fini_rx_queue(struct efx_rx_queue *rx_queue)
>  
>  	efx_fini_rx_recycle_ring(rx_queue);
>  
> -	if (rx_queue->xdp_rxq_info_valid)
> +	if (xdp_rxq_info_is_reg(&rx_queue->xdp_rxq_info))
>  		xdp_rxq_info_unreg(&rx_queue->xdp_rxq_info);
> -
> -	rx_queue->xdp_rxq_info_valid = false;
>  }
>  
>  void efx_remove_rx_queue(struct efx_rx_queue *rx_queue)


