Return-Path: <netdev+bounces-185524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3BA9AC84
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E0E1B66B6E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652F22A7EF;
	Thu, 24 Apr 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0x6VSFZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B390226CF4
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495628; cv=none; b=OIWX/1vAnrtajgjGpct0dpTZjigp7WvALOk+3L/F+iufFr1zlkwmD6rOJOpcQVT7H00ddtql1kD504oUbZjcH9fUmkgvepwO3+NQphT6XRDBYEEDzTGt/SRL2SFoNdX1JLaolyHUvW7n5DIuaLdDqx7t6nuYMRGiUP/wq0eDVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495628; c=relaxed/simple;
	bh=Fpd73RRnHn/l4PYVjhLh24iJQjof1gdaW83Nyo/GhgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ui9gIxh/K/SVCDdXMEI8B5vzXWKtcLXD3ZCB9FQGiVtYbX+1p8p0cG5R6uVdD1H/gyo83ACmOMAsi0T9XFMfw80yFb9AnoT6NIL552mFoUyJEX9qX9FAbt41yKEwev+aYtVkWfMsvNmce/fxYMOZFNhw4yBTKXQaCoxT9Ezd0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0x6VSFZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745495624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7O71wS6omUP4Za+qu8KkJ9Z+HYsi5jrXQRVuEjbLS/Y=;
	b=U0x6VSFZpsG194wzvpvDS5puCDW1O4c6T2wxbF4VaeOkTqTz8aUnoZ8dIdiCV/bFQlsJSZ
	B23RuiJbzuIAYP2Xey7gg9+hQdr3WC79uHcoQquf/Fi6bzAfYF2wBwlEraZgplsbU8nYh0
	NP2+iAKn90MetYoSuwWcWga6M4nmHfA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-ItO_5vGYN3WEsdv37-LQ3w-1; Thu, 24 Apr 2025 07:53:43 -0400
X-MC-Unique: ItO_5vGYN3WEsdv37-LQ3w-1
X-Mimecast-MFC-AGG-ID: ItO_5vGYN3WEsdv37-LQ3w_1745495622
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so5921135e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745495622; x=1746100422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O71wS6omUP4Za+qu8KkJ9Z+HYsi5jrXQRVuEjbLS/Y=;
        b=xKOmzuULiBz670GWzC7xHjWBoN8j5OliCro/gYj+M0bOobbtM8R9imljXvycC9F75s
         lza2pAUgT+av9UsDJ8+dSXHKqbwqsU2qYD7MvCraahD6obh2eI5GqIR5NONP9pKmVuca
         NdKi6L2UtDONzlpNCdLeH4AEn/ZZstSwrfqkpO5DM18OVrTXvwXONOTKhGW3bHKqfvFe
         asFLyYgsAWDTCqTvMcC4Ap2503xMeFmpVRp8kpl4pugamtG5CYjw1D5LGoIm083KHE5G
         e/lrPcIdVWD+35ijI9wfzGWLQqBN52H66Dz2eC49RzU9538fzK+TavgPJlT01B5d0S9O
         XMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYBsWA2Uo88CCvSVbRMd6M6yFBdByj57SxRg0jyDGmjdgJ6NzHI6RfjVZOW8ejnt0qGhMhii4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNId+di0+4EGhUlGKbSJNzj3XkkuMN6CU34NTzMtsuZJ61L5G
	xgKqUJtO+bqy3Z+8WB6wclL5DbTN/M2ag7vI6xpiIal4I1cShWinJHyteHb8yQC2BcTsQ6KoAeM
	dgjgw6ddTCK8IhqsEFEkI9XWa4ZBSZIwgyZ92OwHLltncntB3S54f5w==
X-Gm-Gg: ASbGncu7XRL5TRcZCEV2UX237Hq1043Yc5VgSHbdGMJi8kUYlIChmlM+vwt+KYl8bJb
	1Rryu2fA44Q2u1z+4DeQilOtA7sqWdHSaaLi+2hlXEBnqFnPGnOjwuVR/R6isIjrlIIbjRSDtcv
	ZVkYEiEYhc73bIVn8C067nCiGLJmJZkQ6QFNgeANF3qxOMzmNm4Zptket2omBFlZrp3vt/VAAkO
	MvbVeSRmgXZZKIiuVaOfaH0X1blaRiVMEtBacvcUK+XFhQhwWaGqYPsyzRHDGr03/FzIJAQ1hXa
	QIPJQaZNqVaRjV5VMuvM2X0k/1+DktX3efRSVt8=
X-Received: by 2002:a05:600c:4e0a:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-4409bd210eemr25352715e9.13.1745495621869;
        Thu, 24 Apr 2025 04:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUAI2NQUKhz4qnOoSRg3Qvi8tq8xdza5SLA8RiijZXZRu9gfA8tceguZucQbwMmFsJdyoLyg==
X-Received: by 2002:a05:600c:4e0a:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-4409bd210eemr25352255e9.13.1745495621516;
        Thu, 24 Apr 2025 04:53:41 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54c246sm1831740f8f.86.2025.04.24.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 04:53:40 -0700 (PDT)
Message-ID: <edfa1585-c10c-4211-a985-ebfcb8e671d5@redhat.com>
Date: Thu, 24 Apr 2025 13:53:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
To: Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Tien Sung Ang <tien.sung.ang@altera.com>,
 Mun Yew Tham <mun.yew.tham@altera.com>,
 G Thomas Rohan <rohan.g.thomas@altera.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-3-boon.khai.ng@altera.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250421162930.10237-3-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 6:29 PM, Boon Khai Ng wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index 389aad7b5c1e..55921c88efd0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -4,6 +4,7 @@
>   * stmmac XGMAC support.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/stmmac.h>
>  #include "common.h"
>  #include "dwxgmac2.h"
> @@ -69,6 +70,21 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
>  	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
>  }
>  
> +static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);
> +}
> +
> +static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)

Please, avoid 'inline' function in .c files, especially for functions
that will land into function pointer like this one.

Thanks,

Paolo


