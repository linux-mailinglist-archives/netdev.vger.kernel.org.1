Return-Path: <netdev+bounces-202882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88790AEF858
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33DB1C022CA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1A27381E;
	Tue,  1 Jul 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGAMvX4p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B02737FC;
	Tue,  1 Jul 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372618; cv=none; b=Co8MOvwNqD6YnluwKQkPu3Y5ZEQUMBqOvq2eytEAoNgBXKiWwe3scnfWYznj1IiVMe66BepNkkvdtH52R559r5liXYST2L5oxlb6XfPXPcCKqtK1nTz8GZl64g0xe3EozpAFV8g2g3gih7+IjXIN2ODJvaYSfXg3OkUMlCiBBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372618; c=relaxed/simple;
	bh=1IJZmycdygb2FNMX3Uuv4XKld9BxDXJf7I34c2THYzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbAw4hsV9MzhyffLNIwuqjviAtDIDk31r8XyxLLurNS0FIxF/S/dsPu4+l7qVzjbNtApC1taNc89DaOqKgAOd2oW/dvz0SR2x6Y4e5g+ZRw9Gk7LtqXRc/5IVE1xWJj1+CB6nFiOZxwmL/TbgoSQDUGLjpt4DVdpXTO7HSv37jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGAMvX4p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso55573765e9.3;
        Tue, 01 Jul 2025 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751372615; x=1751977415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OeOZKa+V1VR3U9TmZkrX8cCU7YzI//R+gnVShUPhgI=;
        b=jGAMvX4psJ+9GnF5N53URavy0izagKypJJXXfWldEJJUL/IvuWYsm8wWKHiNNL/ArR
         j4xDtaKKdQhN9SmBVKWJ+ReUVU3fb5+xI4ZIyA6Rq1buSlA+U41W9s6TbXgOFGXsQg/B
         Fht2VZ/TC6vpMB84fy/aXa0GaoYHhESh1kXQJI6oLFxhTjGkn1JWMWNNQp5En02aaJYx
         y2lR6BuLh0TtbukaoH2DueZuGXuPZ3hTCPWq/UUDCtsYm+LGQSDG+VC6ejCzmYhrUqX3
         KcDSiLOUlAAPeocw1YhPMiVrPGyEeWnp2orw7iiNZYzbuV7Xf+gkX8SvXOQMau9adtt0
         KPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372615; x=1751977415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OeOZKa+V1VR3U9TmZkrX8cCU7YzI//R+gnVShUPhgI=;
        b=D+MDM9ib0mTivNY5XHuFuGSMOydifOLpblQM2H9jabInDXSKDBrdRZA03nf9C4+1Wp
         nk6AvdTcwZi5SDuRjlNF8Q4WljewAhOeeRZRsQDbgDu9po90r6SZesNDsG6t5k4ic6do
         NYmyv/GBqBd9o27aWb6XTY6eDhwSIi+/VJCobZUAPdLVIUzsxw1Be83gc3VUZ6jMJbgg
         cs+1t7CzJaxepQcBjFFeUg6fLjzORUjHL4wihQNS+VzByipAEzCisgrVJjwfaOlm8WHX
         2BEWFHsE05mmgzh9RNg58kUheWFPIOqHA0W8vwfmm20qYpTsOj/0qvz5CO/N7eq3ALY5
         LlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyX47wQA4citBqCv4Ka/4sisjisp3ZF7G/uWCSDCUpKlXynrgmsXjBoKBOZooXk+Fe7c8flHHsYSNoq1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcdCahb7Qpk/nXx3CqcaNZeMAnpJ/A5mihdfXWvfPqtn0pTbz
	/5aYxgA8ljP+ImzdZ06yt0LRW/nFS57WskHu/SgAZ2KnigAJnG9t+5ys
X-Gm-Gg: ASbGnctUQAGoBd4ZQtr9isnwC9p1rRDXkcyn3IMZckwf9weAEC8TaARXnknPVnxkskX
	oGC43/YXGyz3cv1WQp/IGLgDJpmavSeAshlmPogPsCDmmF8zuavd0ic0dtXb6QQvmwB/j0yO7lp
	x/jfcecMEKLB0U7eVs6OKEj05m6Xs1WZPjMHDcTudsBZikHbOoQuKXrVyndmFw5KUSWyPqAu7fU
	3QdxS6v7Vf5HwHjwoCVX+MVXrRPRJrfeuoo+V8o4WzB/DYY2xMEebc/TT+2rCpjqD+A53eoA+7z
	uvC8GXmhQKdaFWFcvEMLZ3R7M7gIZUMH+TNWqSw3f2Vtzq/aoV5piDUL/g8qEwAGz0Xay/zBsHo
	ZLqdzvXOB8YpGBW5/FdO5Da3lxFP+5ydllkM+v1dsErih+j2S2Q==
X-Google-Smtp-Source: AGHT+IEI8DrVM5bM76qZ1eWDUC0X+amlHQWQ4U0tbSmI4ccGNui2QsTm1Y2Im3xc0PZ2bueeF8L6WQ==
X-Received: by 2002:a05:600c:1d1c:b0:451:833f:483c with SMTP id 5b1f17b1804b1-4538ee15b83mr174442105e9.7.1751372614689;
        Tue, 01 Jul 2025 05:23:34 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ba553sm190420435e9.31.2025.07.01.05.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:23:34 -0700 (PDT)
Message-ID: <c84d46e5-7aae-4110-9b81-76a0d73bc12c@gmail.com>
Date: Tue, 1 Jul 2025 13:23:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] sfc: siena: eliminate xdp_rxq_info_valid
 using XDP base API
To: Fushuai Wang <wangfushuai@baidu.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20250628051033.51133-1-wangfushuai@baidu.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250628051033.51133-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2025 06:10, Fushuai Wang wrote:
> Commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/siena/net_driver.h | 2 --
>  drivers/net/ethernet/sfc/siena/rx_common.c  | 6 +-----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
> index 2be3bad3c993..4cf556782133 100644
> --- a/drivers/net/ethernet/sfc/siena/net_driver.h
> +++ b/drivers/net/ethernet/sfc/siena/net_driver.h
> @@ -384,7 +384,6 @@ struct efx_rx_page_state {
>   * @recycle_count: RX buffer recycle counter.
>   * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
>   * @xdp_rxq_info: XDP specific RX queue information.
> - * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
>   */
>  struct efx_rx_queue {
>  	struct efx_nic *efx;
> @@ -417,7 +416,6 @@ struct efx_rx_queue {
>  	/* Statistics to supplement MAC stats */
>  	unsigned long rx_packets;
>  	struct xdp_rxq_info xdp_rxq_info;
> -	bool xdp_rxq_info_valid;
>  };
>  
>  enum efx_sync_events_state {
> diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
> index 98d27174015d..4ae09505e417 100644
> --- a/drivers/net/ethernet/sfc/siena/rx_common.c
> +++ b/drivers/net/ethernet/sfc/siena/rx_common.c
> @@ -268,8 +268,6 @@ void efx_siena_init_rx_queue(struct efx_rx_queue *rx_queue)
>  			  "Failure to initialise XDP queue information rc=%d\n",
>  			  rc);
>  		efx->xdp_rxq_info_failed = true;
> -	} else {
> -		rx_queue->xdp_rxq_info_valid = true;
>  	}
>  
>  	/* Set up RX descriptor ring */
> @@ -299,10 +297,8 @@ void efx_siena_fini_rx_queue(struct efx_rx_queue *rx_queue)
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
>  void efx_siena_remove_rx_queue(struct efx_rx_queue *rx_queue)


