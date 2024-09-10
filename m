Return-Path: <netdev+bounces-126896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3F972D3B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A381C247B8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00F187878;
	Tue, 10 Sep 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAPs8W4n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A217D34D
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959753; cv=none; b=Ha1Q4dY59phQz9+PxsQMBtfok6nBdei6SIJEyubq9kl/rs1OKyTQ/5oiS2DH1bOq/kmP+UlsQovko9LtuNlsRrRG/fj+fsvVAkbNZGmDNtGZDk2JyqVitHHep5YzhFI+Lh1LdvsG1CaQ1JVoKwzQ8hB4Rm4YHrh1D53i2k7cJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959753; c=relaxed/simple;
	bh=eGyGPmj8qP4a1HJ7icwsHB0lz2Y8kobW0ucA08xti3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyyVO5PXtcW3CcHiwUJ1KPAGMXOqJ4rH4+GbEmg131JzVMKBNDo+2OSt0JAnNw9i5OvlZx8d2petuTZYVsIZZBj9m+gX8H0OMq+cEVAjr7iFdg4qDUu/GqStTH3subv2BJ7moeGoZen3+pjRcArSX9iV6dLVJFbcT1Rw3EgTqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAPs8W4n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725959750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOrTsaC9yhyU98rc48UtcdzEBQ3VCVbDacgXHoEqlXI=;
	b=OAPs8W4nqHg+kaTblEl2K5dEUdeqIg0qcls/Wi5WRhCnMmo2NhNlrC7VV9pFS2qxVedHDZ
	Iwqvvql/uAzSRbZEvjFE2dYB2TrRob8ugyPItTOnpMvPAIb/U80XByGvispiJ92RuC8tmY
	SJcMVphT3nfj4FRaQe0uwIjxOYD3JL8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-pgX-CblwOE6geWGP2KynZA-1; Tue, 10 Sep 2024 05:15:48 -0400
X-MC-Unique: pgX-CblwOE6geWGP2KynZA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bb1e931cso3105629f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 02:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725959748; x=1726564548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOrTsaC9yhyU98rc48UtcdzEBQ3VCVbDacgXHoEqlXI=;
        b=Vre7p4bVcHk5LkMhnYwiOzVGrFYJlJyZOPBpoyGDZh+wL4pmjt3h733kWerEgyUdFk
         9e6avxETN/rpXWsxJfSxcevaf/NzqPB3klmPkTzY2Qz24Hgi1R3L/N6Nz69lRaEQRLmk
         EPDCWN1/CsMOhv5x+RqqViyUAzUbu+P31G3IE2H0UXUO8ZclsU+yX7MEB99kce88WZl3
         YN+u5sBXt4J7gLw+/0imzPCFVa1KK5PrqUuDi9RZpvA8ENqbJXkSBWdSM9iZPZZRsJD6
         ZRehu9j31PGDW7yXbQdELsXcgyWD1+n1tnSUWt4U0AMjJWLkwGQpDd9Nh5K4UB2NMSAG
         60Mw==
X-Gm-Message-State: AOJu0Yw5YLBIC/gLMyr3bI1teztSn8dlZUj904yPvbkJPGGdbXsr4iue
	IK7tuG62SaKbBXIw9A2eiR8k9lmYn33w+z9NQbckKdVzZTq3dw8iobvAFRrWHvUsnpbQF110do5
	OfxBwzH155vmKnVDd71/fqqs+oXisv1qjqVIpLwL/kWJ3mJn0kFb0wQ==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1421998f8f.24.1725959747764;
        Tue, 10 Sep 2024 02:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDlVz9KnKxoBPJUs8BJvknxY3Fteh43Ykemjb+fUuzFfRMvSS6AWG+AceJowT+ugSPw6DlDA==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1421962f8f.24.1725959747193;
        Tue, 10 Sep 2024 02:15:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a52csm8331824f8f.11.2024.09.10.02.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:15:46 -0700 (PDT)
Message-ID: <f8b58d30-cd45-4cb6-b6ca-ac076f072688@redhat.com>
Date: Tue, 10 Sep 2024 11:15:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: lan966x: use the FDMA library for
 allocation of rx buffers
To: Daniel Machon <daniel.machon@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
 <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 10:06, Daniel Machon wrote:
> Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for rx
> buffer allocation and use the new buffers throughout.
> 
> In order to replace the old buffers with the new ones, we have to do the
> following refactoring:
> 
>      - use fdma_alloc_phys() and fdma_dcb_init()
> 
>      - replace the variables: rx->dma, rx->dcbs and rx->last_entry
>        with the equivalents from the FDMA struct.
> 
>      - make use of fdma->db_size for rx buffer size.
> 
>      - add lan966x_fdma_rx_dataptr_cb callback for obtaining the dataptr.
> 
>      - Initialize FDMA struct values.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 116 ++++++++++-----------
>   .../net/ethernet/microchip/lan966x/lan966x_main.h  |  15 ---
>   2 files changed, 55 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index b64f04ff99a8..99d09c97737e 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -6,13 +6,30 @@
>   
>   #include "lan966x_main.h"
>   
> +static int lan966x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
> +				      u64 *dataptr)
> +{
> +	struct lan966x *lan966x = (struct lan966x *)fdma->priv;
> +	struct lan966x_rx *rx = &lan966x->rx;
> +	struct page *page;
> +
> +	page = page_pool_dev_alloc_pages(rx->page_pool);
> +	if (unlikely(!page))
> +		return -ENOMEM;
> +
> +	rx->page[dcb][db] = page;
> +	*dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
> +
> +	return 0;
> +}

Very nice cleanup indeed!

Out of ENOMEM I can't recall if the following was already discussed, but 
looking at this cb, I'm wondering if a possible follow-up could replace 
the dataptr_cb() and nextptr_cb() with lib functions i.e. operating on 
page pool or doing netdev allocations according to some fdma lib flags.

Cheers,

Paolo


