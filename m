Return-Path: <netdev+bounces-296993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fYxcNcDaJ2rL3QIAu9opvQ
	(envelope-from <netdev+bounces-296993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:20:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA365E41D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:20:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eKbIZKDP;
	dkim=pass header.d=redhat.com header.s=google header.b=ihK58LuB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296993-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E7FB307ED90
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320F3F1643;
	Tue,  9 Jun 2026 09:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3E3EF65F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:12:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996363; cv=none; b=LpEGmcNuiJWydba4T2xMGGtc8TWPkRq2EIdohGq4dhrIouWxqC3ZUZRGVq0RUuKkcpEgc0Bt8O0gNCiaNM06NBhmPL+DCH2W1OBY2JtLdt24ONfl3GhJtC4xpa1FHeaP5FJrmF1/dK9C0EXwF4aeR3s46eNtWp5ECLr8GqnZUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996363; c=relaxed/simple;
	bh=10cg9KiaKBbEGvWmSJfGqcNdgvcKOeUsj7nt6yEU+NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tajUAFDL9RiEkEOqsCfFTQzrp+ye8fopI8/dWvdKMRQTy7DnfMXe5hnS7H7oSJEY1fY7L0vZ6EWChyHmrwP4U4qQwNUTZEVJS6WeWmLVozg2gZpZBUpgdXnXn0Xi2uxN7qIrkrHwJqdfJANblpcR6YbiCdrJAUTKMFhF4hHOO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKbIZKDP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihK58LuB; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780996361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKgIl6Y/DIXvhh/iM2FNPxoO5q9z7m7lhu6QQPfwtpk=;
	b=eKbIZKDP+tfcx+WvQquewiUXjy5lp7jL/O54AtIkkja7tHet/C/FwLomddjfrV18SUBIIV
	s31kWPy0bE1M/5bGmDNXVM+OMgyAFDhD0XAkJSQhGTyFFMhHy2JOVgh6oAT/L9oMHFgQrC
	36EPl3O0fX4YWSfD5g67SJerXJBomgw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-TRV0F3gKO6yv5-WZ5Xg_wg-1; Tue, 09 Jun 2026 05:12:40 -0400
X-MC-Unique: TRV0F3gKO6yv5-WZ5Xg_wg-1
X-Mimecast-MFC-AGG-ID: TRV0F3gKO6yv5-WZ5Xg_wg_1780996359
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-becd1c46294so512217166b.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780996359; x=1781601159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKgIl6Y/DIXvhh/iM2FNPxoO5q9z7m7lhu6QQPfwtpk=;
        b=ihK58LuBOWO62FGO4ecTOVvJK08DrF9/BphgVSy8Mcn8dObjyFONbLX6AqtIB05+zn
         TECac/oWRO3TvIvZW0gMsrZlZ30GLzyTwZDEEQmDhPCdB5taGpFR0DlN03HPYcD1eUQ/
         bwxdQXTyzLjqTs81NIjUWd4PqgJA7uPSHJJ8vYN0ivLTcvNgxyCvYsxKH70FXwBz4Tqc
         wFfHLuloWGW1yJbOawPHzSrh+AZKYWpjl97LH8Fu5YjxxBUPSoUZ8XeU5XaqlY6RE675
         TveaAiSnULt/5MrrFvC3N6OSY+u9Wa5LW75bg3c/wCDaFacD+sayfnhAph50SsdR18XT
         8aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996359; x=1781601159;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKgIl6Y/DIXvhh/iM2FNPxoO5q9z7m7lhu6QQPfwtpk=;
        b=Km5D1KY7MeFcJ/wX5vE57Ec4VMPlxmxPqhHhc6ksOoJ90d3s18BpVNhX8CGIvUZ0Fx
         DlREv9iOW2+1xxLmoM8q1snddOr1TnU82AEWMA1lmdi3tuz41Ecr9N0bxw4RjdkP2r9+
         miM7zCF/LWBGJI03XP0o/VnkJ1qCmAW1O/OUEch9RayHpKLcjqAFyY1AKa6K2RzXl/GH
         Q8vhw1CvwtaUl3Z8SHhX6guxvVa71e95Ev6XLm7kjPcB2esWz1XkxUcN0dZTmkQ0BMSp
         afMePzViQK+TxXlc+qQVaZBaH7VvhFziDmARuuMhvYMzypf30Zo2jVTKdhafGFzBDPFQ
         n1wA==
X-Gm-Message-State: AOJu0YxFMFpG5ujeJxl23I9ex6J2jYmYiP7tApMVAwR+3oB/CMvmrrxc
	mjd1WNOYWMv49hQ6smJ1fODS+kzqU/rFsLsHg6GXfToDbUCnBGLg8kTjLdrnFxdP269FSB+MQ88
	pshGt38LehOoGFgRCp9KthqFChoBB4+8ynJS9elhqd+4TYL5v18/seTKcRg==
X-Gm-Gg: Acq92OGGdDXt+MN7MTAMogaV41+gg6xGga7tU23Sz7ma9voluFuU2KdLCBUUsYD5/EZ
	9DlvGmwLR6jNA+LB24L3Cgh8x87n0tbC8D7XWdRXvpE0tBFhExYXc8ODb4qKYdLm1ZBof+rrD1l
	ACrkAudkiOPxqpMRb1P6U+fPg0aoMOvDWO1lrN5N92U6ZnGag4HrYLfDpMnwq761GoUW/xIHYy/
	6NF9nTpPpNo+dibnZ34KtQ2qCq1LifBrMqDCkI7UTxfN/Cqi9SB3jPkqpPr4Wc06gvgx644GmIT
	lHQ7+Dkop6sNgExqTqvBLorHNmC9x94N1zIMf54IsuWkryZDrV7fLRg6zfEPZhLHtYyKIT73GL6
	4mbHETfDLMQjNhPEH70WtOON2uDM1IjwwsTByBATJvtf7Qe8dyznMVP4Uz2kznI5YXA==
X-Received: by 2002:a17:906:ba8d:b0:bec:52f4:28f3 with SMTP id a640c23a62f3a-bf939b04be4mr90289966b.44.1780996358603;
        Tue, 09 Jun 2026 02:12:38 -0700 (PDT)
X-Received: by 2002:a17:906:ba8d:b0:bec:52f4:28f3 with SMTP id a640c23a62f3a-bf939b04be4mr90286366b.44.1780996358069;
        Tue, 09 Jun 2026 02:12:38 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553060dasm1006636266b.44.2026.06.09.02.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:12:37 -0700 (PDT)
Message-ID: <8bac773f-5016-4afb-8506-9d48eb2e70d0@redhat.com>
Date: Tue, 9 Jun 2026 11:12:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt mask
To: Simon Horman <horms@kernel.org>,
 muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Jose.Abreu@synopsys.com,
 linux-kernel@vger.kernel.org
References: <20260604094512.21243-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260608152717.157757-1-horms@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608152717.157757-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-296993-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FFA365E41D

On 6/8/26 5:27 PM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
> 
> This commit removes the RX Buffer Unavailable (RBUE) interrupt from the
> default enable masks for XGMAC2 devices. This is intended to prevent MAC
> interrupt storms that can occur under heavy RX pressure when the DMA
> runs out of RX descriptors.
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>> index 51943705a2b03..b5fdc253a2f24 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>> @@ -379,9 +379,9 @@
>>  #define XGMAC_RIE			BIT(6)
>>  #define XGMAC_TBUE			BIT(2)
>>  #define XGMAC_TIE			BIT(0)
>> -#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
>> +#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
>>  					XGMAC_RIE | XGMAC_TIE)
>> -#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
>> +#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
> 
> [Severity: High]
> Does removing the RBUE interrupt break the driver's ability to recover from
> RX out-of-memory conditions, leading to a permanent RX queue stall?
> 
> When stmmac_rx() processes packets, it calls stmmac_rx_refill() to replenish
> the ring descriptors. If page_pool_alloc_pages() fails due to memory
> pressure, the descriptors remain empty:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_refill() {
>     ...
>     buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>     if (!buf->page)
>         break;
>     ...
> }
> 
> stmmac_rx() then returns the number of processed packets, which will be
> less than the NAPI budget if the ring is empty. This causes
> stmmac_napi_poll_rx() to complete NAPI and re-enable interrupts:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_napi_poll_rx() {
>     ...
>     work_done = stmmac_rx(priv, budget, chan);
>     if (work_done < budget && napi_complete_done(napi, work_done)) {
>         ...
>         stmmac_enable_dma_irq(priv, priv->ioaddr, chan, 1, 0);
>     }
>     ...
> }
> 
> When the hardware subsequently tries to receive a packet, it finds no
> descriptors and enters the Receive Buffer Unavailable (RBU) state. By
> removing XGMAC_RBUE from the RX interrupt enable mask, the MAC will no
> longer trigger an interrupt for the RBU state.
> 
> Because no packets can be successfully received without descriptors, the
> normal Receive Interrupt (RIE) will also never fire. With NAPI stopped and
> no interrupts firing, the driver has no polling timer to retry allocation,
> which could result in a permanent stall of the RX queue.

Nazim, you need at least to clarify in the commit message why this patch
is safe.

/P


