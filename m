Return-Path: <netdev+bounces-270870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zy/yFLEZwmlGZgQAu9opvQ
	(envelope-from <netdev+bounces-270870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:57:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61E30218A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF4A30398AC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6A2773FF;
	Tue, 24 Mar 2026 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxI6cPhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C43BB5A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774328238; cv=none; b=LKn5cCv69qV7YmegB1r1IYOqcCUBN0hyg/Sr/ewABWKJYyok5bkbuDGmwGXsRDuCtq3/sR/EQmmpuxgVVVQTXHrjCtrJ8FY/q+Dv3sAw0MWNaso5aw9pXjFy0sdNPOLMmGJ3wWX9YOaobtUzTHKL7Ou0/DUV5rcXEt0yDiL44Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774328238; c=relaxed/simple;
	bh=/UR8wWz094cA/s9q7qC0SIS2fH2q7D8OfbwfO9Scy78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFRbn+4L2RWyAgidAUuh87cCKkJWHXvm3JWC8UXlejTxSWLs9I/h1EDl92O4Uwx54jCCJ1k7DQFI0DMQA0mgf3dorjABXWuilMxBFXb3q1uiY5LMUYjIxi6Ibpm7/rRtEgRIuhz3/4T6e6VkXC2kjgiluN9U0g3xy213/edM6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxI6cPhK; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso968658eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774328236; x=1774933036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCz3wAhWRycloO+9zp2e8Umhe6r/PhDyYcrP6wtjtvU=;
        b=NxI6cPhKpI5OrTbwbhi4n3j+EC0/KfIxDg0gh+6l5KFQ0wx30DyDV8ipq7lmBJanmm
         dQXxUaK/MLKSe7Dr9ebWHt3Jutmxv7VxdhirprOIQ4fsMPCp/xWHVhnQGZD2CRFXtj/3
         ThWl1zcAFpvzXvvyz9FhBfD800JuQlGGxbysKbQ4+1iTOJtr7VMunodsHzRWD1s26DTn
         IKIzFrAvARCg/7c3/etuz2uTDsrmDPAQ05SUSvKcd644AwbvP4BrmpV8eDrwPfEQTgMM
         yaOa4cmRuXwn/gD1tjPQ16jfouPWbNGeC85n3ZhVl9FrlYKiMVpk2+dLX8bvIU/7BjAm
         8xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774328236; x=1774933036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCz3wAhWRycloO+9zp2e8Umhe6r/PhDyYcrP6wtjtvU=;
        b=l7Cl8XNSffzDQtUycX4zfutA+x7FZWkcFNFbOjoKFiIhvvIkvT6P2NQbSQP1LlIaSh
         nRhwf+MvOafUh4VC261RVGY/sDYb1xSh13ygRExMAxBNo9rmvDcNNZozAVY8LWM/FSiV
         G3GTpd3OeBiuMFqynM7EoL5x1NZMV5j4uuPjGmPlRZAJAuqQqQRmT7IBPpiWzuXvfexN
         awrZ6onlSxbhDyUbQCa0oKQuf/ngnkWkj7varCyRsfom2px3uW3gS55dFLSnZ+BH4e2Y
         s05l7ApDLf09bFyjoALfIU1Gu9OR4UL/1OQsmtrJ9BKsc72GlFGBZclRGyHXyj0kX5GC
         1azg==
X-Forwarded-Encrypted: i=1; AJvYcCUSyQKqEmLcNx/hwsA+oEsoVP/U/15jfTKBPXZn3zfZ3nIInwbz18t14hAWy2OS7IhzQmnkyQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Jr+AqerN4+BfBTIsEOH7kTFQVk56nOLVdBWS7cHxAdtH4F6O
	qJhq/B1iBDcl4qSCyt/brC2EvUImmkuioEo2OhVwgEB0PjQZmwCdq0jz
X-Gm-Gg: ATEYQzxO9wPUxpmIgJY+yRzWfJyYrG/5l7ZNyhs2N88c4YTJV7CTO7x86W1luXScn34
	Rd3ZFzEakv6aQF2O2+uFgYmkOkgtzuNj0NojN7U4pNUCFaluGRRJFXpXe+01YC/GjVGOnYlC5bI
	BOqf6nTKxeI7nRelrfNdHg53pMmqxY/zLKvVtmZDnR9oeP/g2IsXeZT6iz0/RKdK6WQjm1cSLRg
	hhzar7mhz0u2Ft6ia2s+xTk9c0qAPTDc1gb7BSGJCrSWWxSI/Kj8bShPORU1biw9K09Q7vZmpO6
	jcmsqdMA56TgfQji6V433tXmq8Q/JkBgxM3Vk/QvxizMPhZrP7VulOw83gB+7RyYmavA51cfrZT
	6gcPKCmYmJAgApyXlTdK7pAwbVPpcfOq13ZKGnX3igYn7hA0qbokCg9yJMxiXTgZx1GvlYHhaWr
	UB/aUs6ttGvTZGQy3TdNSXiQ7UNALPdvXbwyygeuDQQGNPNTfeXmZDGPSAXi0X
X-Received: by 2002:a05:7300:3252:b0:2be:80c4:2c8c with SMTP id 5a478bee46e88-2c1095fe003mr6284544eec.8.1774328236434;
        Mon, 23 Mar 2026 21:57:16 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::14d8? ([2620:10d:c090:400::5:2e41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm17282697eec.24.2026.03.23.21.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 21:57:16 -0700 (PDT)
Message-ID: <e4505f22-94e4-4034-b76d-0654e3f530a0@gmail.com>
Date: Mon, 23 Mar 2026 21:57:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/7] net: macb: add XDP support for gem
To: Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
 <20260323221047.2749577-7-pvalerio@redhat.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260323221047.2749577-7-pvalerio@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270870-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A61E30218A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -		addr += first_frame ? bp->rx_ip_align : 0;
> -
> -		dma_sync_single_for_cpu(&bp->pdev->dev,	addr, data_len,
> +		dma_sync_single_for_cpu(&bp->pdev->dev,
> +					addr + (first_frame ? bp->rx_ip_align : 0),
> +					data_len,
>   					page_pool_get_dma_dir(queue->page_pool));
>   
>   		if (first_frame) {
> @@ -1683,6 +1878,18 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>   				queue->stats.rx_dropped++;
>   			}
>   
> +			headroom = bp->rx_headroom;
> +
> +			if (last_frame) {
> +				ret = gem_xdp_run(queue, buff_head, &data_len,
> +						  &headroom, addr - gem_rx_pad(bp));

Just to clarify, Is xdp support only available for single-buff case? Is 
it possible to receive multi-buff frames? If yes, should these be 
allowed to bypass XDP or should these be dropped? The later case would 
probably require explicit handling?

