Return-Path: <netdev+bounces-201247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A4AE8962
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2494A514B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6182D131A;
	Wed, 25 Jun 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW/rGBrh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF942C0313;
	Wed, 25 Jun 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867997; cv=none; b=jHyGMXhpBcBZ21AhidQjpsE3/1GlgIwGmNLX7g609UtVewJWrZytTMrJ1/ZI8cEmb9l6bKP71elKM5QgR1W2Z/XAf3qADYfog5ufzaUrmJXn8QTqzTO4IR7CVuXS+dppq8VeF2F53pepupcY2iG2w0VMuVxvPF+/KjFDYusQo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867997; c=relaxed/simple;
	bh=DnBrjOnLROKAPcA6st0d17zXsamWXIAl8n+L6mmpAoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTKRIVRRO+RtSKlAYvhQC4eu43FDThqAcgD1p2Sj1AcO/6A5NhDXLhjY9iT5vFJ0mV9vgtKCHpxpf7Bgp9OrLgUjL3DKacFCjCKYX3RL/i6+TH1GCqlQZhwoMbqlmWMURA2Cl0bu/lDdvF2Tx+8vcUIwJ6tk7cHp6i/K1gwNLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW/rGBrh; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40a4bf1eb0dso44071b6e.3;
        Wed, 25 Jun 2025 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867994; x=1751472794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNyvWl/xutcaLaXnAbFimz+ZVP6hj/B8AiD4Lu9fPLU=;
        b=DW/rGBrhEFbKRF5WYB+YYFEL8hjjf3P2+dVWBqagXUijya5fE3omyyp+5FsIbyTFcA
         UmyvJHaNurBPfskw+vAlFJG+9fZPpNZ7z09dBYHnRfZ2pMuYHgWrJvRn/rM802U7F7AE
         Xc169UoUP9u0m1HegPFNsHUZjFDlqS0yioU6hTCS+AJdiemXhq+lSuShW+APGw1Kwz9w
         YZwuTZEI+wmBp936lw0Sa5fsToM4eVjdHe07QwK1hifE3HsYLpf5q+xzE3+s53kko412
         HkUid4Gd3lFviyYClcTiDaritJnTfvyBaUbFydW4Tr9iTYmKiXE7D50K0GsFpceGRH9W
         /TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867994; x=1751472794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNyvWl/xutcaLaXnAbFimz+ZVP6hj/B8AiD4Lu9fPLU=;
        b=bj9tQDKDd+CRTP/42kWw8TsLb8yJZgwsFtrjJ00x3LTaMNjQPbjU1VKRzcxxcJT8ki
         fWvxv3vLZdWEtUcNfdWkxuM1ScjnqFNkIKa2Csqtgb6QBcyrq6zahvCCvmlsw6G1nlmn
         Ww32q6G23eE+l12nX+lb12F3E4fG9ysf33l8qFRZKQYFS3WvexFrCoLEEoZHCMHNz1/p
         qSZJzIZPUyJMIOGP545MKxhmKwssPfL2jfzlDkh/KS5L7yuEu0+oqQd2M5qsTdu9saI5
         3iI/9rmB3sdHFHZfmCKeKzy82292PL7z3VAYfzvKQhMXyrk2ul3mKh2BJykSAXjkrAc8
         2p6g==
X-Forwarded-Encrypted: i=1; AJvYcCUqZfoCPZmAFtmB+HXvcZtE06XeTxiNFs2cmh6+VH9Iqj2T/rfSijQQlL+adadAAbZ4TBzMet2w4c0Nq+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1n3D2rra7SD6Q9UY6D5/UrZlxb/BhjxiqMHWeedrU/rKPvic
	mDhXa6+TuHDsM5BvXZh6AA5rlNPikE1jZa+ng+GJrdCp23yuKw0p4WtS
X-Gm-Gg: ASbGncsetaYBlyHM6bQcdq4TnZzxqFntx1TOVD2Ot9fP2L+Fe4SklUSkTzoB88ysdO4
	I67+0N89gv8SPn1eZzRSSqj955QS9DCNJjRj9ItYGVX5/uHB8kKJfmW3lSx2JEWpPB21dncZsLv
	I39r5sNlZ6bAFO+ogPRPXaBtgOJuNicfYGd+3jXm9Dr/R2Red1ra1RGqSiEXPZODB202To0t304
	Bvg+xOr+SI6SXC9h5egjXmoRaY9CHyTK3haCQuAnZH+95nFAStsp4Jw4ZYe7Xf//BN8BNmd/qWe
	vJ3jELjMXFEHoSCn5E7T/tAizf4lShEQ0o6YGXaui6gU6DM5rT/gtjAfHRiFEmn5C/DcHp6wzaO
	nO1NrGnLO7/d5M9MuxuBq7r8mIIN5pJJOsH9qOQTh5WfQx7h0lg==
X-Google-Smtp-Source: AGHT+IEdHa2GWAC+nA1I7Az+3sSIkB3DMYnYcteZoJDA7tqF8x9HkMnSSed6dCXo3WA205qwnvUpKQ==
X-Received: by 2002:a05:6808:f90:b0:3f8:3489:d93d with SMTP id 5614622812f47-40b05c2998dmr2736001b6e.25.1750867994315;
        Wed, 25 Jun 2025 09:13:14 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:7785:e0b4:eb15:e91d? ([2603:8080:7400:36da:7785:e0b4:eb15:e91d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d1915esm2242172b6e.41.2025.06.25.09.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 09:13:13 -0700 (PDT)
Message-ID: <1eeb3e3f-8acc-484b-b9c2-700516aa5cba@gmail.com>
Date: Wed, 25 Jun 2025 11:13:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: don't force LACPDU tx to ~333 ms boundaries
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carlos Bilbao <carlos.bilbao@kernel.org>,
 Tonghao Zhang <tonghao@bamaicloud.com>
References: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 6/25/25 11:01, Seth Forshee (DigitalOcean) wrote:
> The timer which ensures that no more than 3 LACPDUs are transmitted in
> a second rearms itself every 333ms regardless of whether an LACPDU is
> transmitted when the timer expires. This causes LACPDU tx to be delayed
> until the next expiration of the timer, which effectively aligns LACPDUs
> to ~333ms boundaries. This results in a variable amount of jitter in the
> timing of periodic LACPDUs.
>
> Change this to only rearm the timer when an LACPDU is actually sent,
> allowing tx at any point after the timer has expired.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>   drivers/net/bonding/bond_3ad.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab706afed9560bcdb5e6eca1934f5b7..a8d8aaa169fc09d7d5c201ff298b37b3f11a7ded 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1378,7 +1378,7 @@ static void ad_tx_machine(struct port *port)
>   	/* check if tx timer expired, to verify that we do not send more than
>   	 * 3 packets per second
>   	 */
> -	if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
> +	if (!port->sm_tx_timer_counter || !(--port->sm_tx_timer_counter)) {
>   		/* check if there is something to send */
>   		if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
>   			__update_lacpdu_from_port(port);
> @@ -1393,12 +1393,13 @@ static void ad_tx_machine(struct port *port)
>   				 * again until demanded
>   				 */
>   				port->ntt = false;
> +
> +				/* restart tx timer(to verify that we will not
> +				 * exceed AD_MAX_TX_IN_SECOND
> +				 */
> +				port->sm_tx_timer_counter = ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
>   			}
>   		}
> -		/* restart tx timer(to verify that we will not exceed
> -		 * AD_MAX_TX_IN_SECOND
> -		 */
> -		port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>   	}
>   }


Reviewed-by: Carlos Bilbao <carlos.bilbao@kernel.org>


>   
>
> ---
> base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> change-id: 20250625-fix-lacpdu-jitter-1554d9f600ab
>
> Best regards,


Thanks,

Carlos


