Return-Path: <netdev+bounces-207270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC38B06833
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE7D7A344C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1E2BE645;
	Tue, 15 Jul 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="pcSIr9jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF01218858
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613185; cv=none; b=Qjx/juA9Bn4WieV6anSgNkLMDqKBAykdJh/JGlfzoaeKSnWvPxhzb7bb9x9DHO/91TajfnRlLCOe+MNRg3kh4ImWAtRCGYeMP7RKe083QsLRWOAw7UUhYq6ruc5iSMIxUknQtHyKTM51k7UmS4g94kfUeAwgJzP5ZyFcYFQ2F4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613185; c=relaxed/simple;
	bh=jK2PJ1pLXHoKPhr1KHcSC8ZcmaKbtsnsQeWzZk5oydU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPigKBz7O/K+7wMkCkSB9SLy1wLYiy/OSyW8VCmyHsTeFo/0/iBEbhELUbsFdIKh2cyT6wzcyA/qnKQn7X9wbror80teW0Ac8oCMNgjKI2aMlwLzqKrNgnUw1QJH9ZvqO6SlzoHLM5kV6Dul0qNfeZQhp2UBpx4bx7apr7ftd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=pcSIr9jg; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-41b8e837427so472777b6e.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1752613182; x=1753217982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpLIXS+YHqc5mxGfOSQbNuEZInQXTG4i5qkw5Ltm2ew=;
        b=pcSIr9jgyi0qz6jMEw3Kj0N+o0JdXAhJvjL9aE8lRhKq3Bi6XwtKLTRt3VC0vPgM/Z
         Ieg+9+61MFZbn72asU+Ghm0uWcjxHzZl26i/+RcneLG+V9N/BOztS1mV5LhcM3dkWtxt
         tRKrLq7AVaQg5ROuFXqELVkPPXd2Lcvmab6R/+hGW7oUtWz557LKnI4atsG2W7D09PPX
         LZY68y9GX9h0gveRoFOTt4JLmL5gfvBhAQdjakG8L15cvMoBtex1IVRL8TRDY2OQMaHm
         WTYropf59CMzEywtkC9ArhZkB6kHZFSZn4SHxYAJz0UkS/hA9b3YsSnt26gyqKO/+TpD
         t/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613182; x=1753217982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpLIXS+YHqc5mxGfOSQbNuEZInQXTG4i5qkw5Ltm2ew=;
        b=CLeAOt1OitAIWNyjzDLMXKdi3KVrXkbYQnfyvVrOJrllUXE7iSy+1vDrTeQW30MFuQ
         VGBfpRIxrBmKFEBG2kwF3SNloFjBv9EmqwnMjXeOkkzdCuN11Dx1ySkQcmvvxWa/2p74
         Co7VmNQhNdoUfVmau4u1+y2f++vvkM6H/NoIr81qt7rg6k3SGE9MbP51IQvgamG8yicl
         1uCVJHhrwrAprVcFOlkfEMMpBHWC0QZnqCxCTxxE8ABEieQKpLPs9QD3AEzon4rN1FmE
         M4Pvgpa7oshjOMnbg1HQwc/zFvLdb5GXi29gPNFCNbT/yVd+CaF3nZIgrotOqvl8Rka8
         cuDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBOp1QqHeULkKaBcn44/MaB4tVGLiP2/tddL+qb25iGLe42w9lxvdgaMMTKpaBn06HE6PgX/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRLM6S8AVqhD7hKLtOIy1X2KC7vet7jf8YDb7JIhioaGZjpDF
	JSR/Hmr3loANyx3j4ZAqTC43BC16mMbscaF1ldONz/rp6BTNgdKBtpHL9LNkes8bh00=
X-Gm-Gg: ASbGnct26QhcC18/XbLUCMEvK9CUSkVQ+Mv2ZNDQd5Jz+pFV5ZAoA11aYJzNSGnPWuE
	vPAiolNCpm6dM5Tw44O9YiVuq65qrRaDMeIJqGexOXWF83eVAGYSdE3SqZbodD4l/IS4tysAlXv
	3sRULx1HHb/APXorC2afkOhiQRvFvoRFWh7yAo58VUOrJwmGSiNXXF/qfaqTdJKOxMlG2+aL/lB
	yWRrNveMLlQOCJYMDJRokAaTZmxG3po8wnt06EdwNGTvNDevzIll5+Y4/+6kf1YYrxX81dRjaCm
	eWBHDXaDKnZdw+VBOdrW45x0kw1iX4aYnvV1pg0yyfykghc5eo6Of978Nbs8M1dY8kQ+dDymvI1
	X+yfuj+KhnQzRn6phm09kFh/4262C+eGAap7HtRVJNf/cBFBDGQQVMCXf0eDrwwYF
X-Google-Smtp-Source: AGHT+IHMuvYgTjdEJouwL9rFNOehORJPx/jwpmcs0VZMmCrB+BtDdM4ygC9BoJ12UmywSThmX7MsOg==
X-Received: by 2002:a05:6808:1814:b0:408:f80a:bab9 with SMTP id 5614622812f47-41d033f488dmr188402b6e.11.1752613181573;
        Tue, 15 Jul 2025 13:59:41 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:68bc:2e93:4664:2a0f? ([2603:8080:7400:36da:68bc:2e93:4664:2a0f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41d05f24034sm42642b6e.33.2025.07.15.13.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 13:59:40 -0700 (PDT)
Message-ID: <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>
Date: Tue, 15 Jul 2025 15:59:39 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
To: carlos.bilbao@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sforshee@kernel.org
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <bilbao@vt.edu>
In-Reply-To: <20250715205733.50911-1-carlos.bilbao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

FYI, I was able to test this locally but couldn’t find any kselftests to
stress the bonding state machine. If anyone knows of additional ways to
test it, I’d be happy to run them.

Thanks!

Carlos

On 7/15/25 15:57, carlos.bilbao@kernel.org wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>
> Replace the bonding periodic state machine for LACPDU transmission of
> function ad_periodic_machine() with a jiffies-based mechanism, which is
> more accurate and can help reduce drift under contention.
>
> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
> ---
>   drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
>   include/net/bond_3ad.h         |  2 +-
>   2 files changed, 32 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..8654a51266a3 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1421,44 +1421,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>   	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
>   	    !bond_params->lacp_active) {
>   		port->sm_periodic_state = AD_NO_PERIODIC;
> -	}
> -	/* check if state machine should change state */
> -	else if (port->sm_periodic_timer_counter) {
> -		/* check if periodic state machine expired */
> -		if (!(--port->sm_periodic_timer_counter)) {
> -			/* if expired then do tx */
> -			port->sm_periodic_state = AD_PERIODIC_TX;
> -		} else {
> -			/* If not expired, check if there is some new timeout
> -			 * parameter from the partner state
> -			 */
> -			switch (port->sm_periodic_state) {
> -			case AD_FAST_PERIODIC:
> -				if (!(port->partner_oper.port_state
> -				      & LACP_STATE_LACP_TIMEOUT))
> -					port->sm_periodic_state = AD_SLOW_PERIODIC;
> -				break;
> -			case AD_SLOW_PERIODIC:
> -				if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT)) {
> -					port->sm_periodic_timer_counter = 0;
> -					port->sm_periodic_state = AD_PERIODIC_TX;
> -				}
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> +	} else if (port->sm_periodic_state == AD_NO_PERIODIC)
> +		port->sm_periodic_state = AD_FAST_PERIODIC;
> +	/* check if periodic state machine expired */
> +	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
> +		/* if expired then do tx */
> +		port->sm_periodic_state = AD_PERIODIC_TX;
>   	} else {
> +		/* If not expired, check if there is some new timeout
> +		 * parameter from the partner state
> +		 */
>   		switch (port->sm_periodic_state) {
> -		case AD_NO_PERIODIC:
> -			port->sm_periodic_state = AD_FAST_PERIODIC;
> -			break;
> -		case AD_PERIODIC_TX:
> -			if (!(port->partner_oper.port_state &
> -			    LACP_STATE_LACP_TIMEOUT))
> +		case AD_FAST_PERIODIC:
> +			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>   				port->sm_periodic_state = AD_SLOW_PERIODIC;
> -			else
> -				port->sm_periodic_state = AD_FAST_PERIODIC;
> +			break;
> +		case AD_SLOW_PERIODIC:
> +			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
> +				port->sm_periodic_state = AD_PERIODIC_TX;
>   			break;
>   		default:
>   			break;
> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>   			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
>   			  port->actor_port_number, last_state,
>   			  port->sm_periodic_state);
> +
>   		switch (port->sm_periodic_state) {
> -		case AD_NO_PERIODIC:
> -			port->sm_periodic_timer_counter = 0;
> -			break;
> -		case AD_FAST_PERIODIC:
> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
> -			break;
> -		case AD_SLOW_PERIODIC:
> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
> -			break;
>   		case AD_PERIODIC_TX:
>   			port->ntt = true;
> -			break;
> +			if (!(port->partner_oper.port_state &
> +						LACP_STATE_LACP_TIMEOUT))
> +				port->sm_periodic_state = AD_SLOW_PERIODIC;
> +			else
> +				port->sm_periodic_state = AD_FAST_PERIODIC;
> +		fallthrough;
> +		case AD_SLOW_PERIODIC:
> +		case AD_FAST_PERIODIC:
> +			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
> +				port->sm_periodic_next_jiffies = jiffies
> +					+ HZ * AD_SLOW_PERIODIC_TIME;
> +			else /* AD_FAST_PERIODIC */
> +				port->sm_periodic_next_jiffies = jiffies
> +					+ HZ * AD_FAST_PERIODIC_TIME;
>   		default:
>   			break;
>   		}
> @@ -1987,7 +1970,7 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
>   		port->sm_rx_state = 0;
>   		port->sm_rx_timer_counter = 0;
>   		port->sm_periodic_state = 0;
> -		port->sm_periodic_timer_counter = 0;
> +		port->sm_periodic_next_jiffies = 0;
>   		port->sm_mux_state = 0;
>   		port->sm_mux_timer_counter = 0;
>   		port->sm_tx_state = 0;
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index 2053cd8e788a..aabb8c97caf4 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -227,7 +227,7 @@ typedef struct port {
>   	rx_states_t sm_rx_state;	/* state machine rx state */
>   	u16 sm_rx_timer_counter;	/* state machine rx timer counter */
>   	periodic_states_t sm_periodic_state;	/* state machine periodic state */
> -	u16 sm_periodic_timer_counter;	/* state machine periodic timer counter */
> +	unsigned long sm_periodic_next_jiffies;	/* state machine periodic next expected sent */
>   	mux_states_t sm_mux_state;	/* state machine mux state */
>   	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
>   	tx_states_t sm_tx_state;	/* state machine tx state */

