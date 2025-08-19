Return-Path: <netdev+bounces-214928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FDAB2BF16
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D861B641CA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786354690;
	Tue, 19 Aug 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TezlJBbT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/jwHUwE/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TezlJBbT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/jwHUwE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6321322A2E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599795; cv=none; b=qM4eVlfHLwRqShQ3Vrwa5W7GhgLnGFlEjjgvsDEEnhjDRLCfMlLvGB9Ak4E38nUKijuC8W+36FI0eLkZZe8gRl2/KstUMKCTfePtfpFx4u3s/dIP08KCWufydj+9vHskLwjL9p/pTTfT2r7pqcl3sm1ZkV8RIiKdsuW7peDTCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599795; c=relaxed/simple;
	bh=37aey4AK3mJUZeNmjMHYQZ6v9A4NtdxD2XjaKTFYXno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3F0gemuEw8/QCiGrF+p2WSv/6SFK5PZfSX3FDWd0vXyjcw1NLB/kTicjiTWgGRixkaIyzGD9gmkAuXjsS73K6lvV6Gxjw4/oVKjq58FfwzZGowNEQ7YIwhMZAjgsG6yD8LqEEw2frJPtzbr2qIwWHToRmrV2g9Omb6m+QEfSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TezlJBbT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/jwHUwE/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TezlJBbT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/jwHUwE/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0BB31F785;
	Tue, 19 Aug 2025 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755599791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCP2sXh2gwfCkPbU6Wb/CWK6RQlUL1v1Xohq8MIEbiY=;
	b=TezlJBbTjtioKcepFdP4s5z7tTYZPn/Bt16uIdS+IRohLyiD0pdEFo44EnYqhEkY4Kl45p
	+MV5ArsmtY3a8cMD0JsUKBcHduBJXeE/cTuVXDR1d8FOlbcJ3zNUEG9tnB4Jgut4IG76JY
	TZFidaoiG5mtq+uH5e48WIz8d7XnhqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755599791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCP2sXh2gwfCkPbU6Wb/CWK6RQlUL1v1Xohq8MIEbiY=;
	b=/jwHUwE/R4yDKWdeW7jVCqMk9g+olXYtz4c0NA9J4bRs5ABxBInaUESpbCJAJ1ECVdZw5O
	DPfFpH32Tp19lVAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755599791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCP2sXh2gwfCkPbU6Wb/CWK6RQlUL1v1Xohq8MIEbiY=;
	b=TezlJBbTjtioKcepFdP4s5z7tTYZPn/Bt16uIdS+IRohLyiD0pdEFo44EnYqhEkY4Kl45p
	+MV5ArsmtY3a8cMD0JsUKBcHduBJXeE/cTuVXDR1d8FOlbcJ3zNUEG9tnB4Jgut4IG76JY
	TZFidaoiG5mtq+uH5e48WIz8d7XnhqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755599791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCP2sXh2gwfCkPbU6Wb/CWK6RQlUL1v1Xohq8MIEbiY=;
	b=/jwHUwE/R4yDKWdeW7jVCqMk9g+olXYtz4c0NA9J4bRs5ABxBInaUESpbCJAJ1ECVdZw5O
	DPfFpH32Tp19lVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBFCD139B3;
	Tue, 19 Aug 2025 10:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vVAZL65TpGjVWgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 19 Aug 2025 10:36:30 +0000
Message-ID: <437a8d6d-8d59-4ae3-beda-d9eab1300109@suse.de>
Date: Tue, 19 Aug 2025 13:36:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-2-svarbanov@suse.de>
 <37427c1a-68af-4c50-ac6d-da5ee135c260@microchip.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <37427c1a-68af-4c50-ac6d-da5ee135c260@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Hi Nicolas,

Thank you for the review!

On 8/19/25 11:29 AM, Nicolas Ferre wrote:
> On 15/08/2025 at 15:59, Stanimir Varbanov wrote:
>> In case of rx queue reset and 64bit capable hardware, set the upper
>> 32bits of DMA ring buffer address.
> 
> Very nice finding! Thanks.

Hmm, that reminds me that I have to update the patch body because the
credits should go to Jonathan Bell and Phil Elwell if I decipher
properly the description in raspberrypi downstream kernel :)

> 
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> 
> A "Fixes" tag might be interesting here.

Sure, I'll do that.

> 
>> ---
>>   drivers/net/ethernet/cadence/macb_main.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/
>> ethernet/cadence/macb_main.c
>> index ce95fad8cedd..41c0cbb5262e 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1635,6 +1635,11 @@ static int macb_rx(struct macb_queue *queue,
>> struct napi_struct *napi,
>>
>>                  macb_init_rx_ring(queue);
>>                  queue_writel(queue, RBQP, queue->rx_ring_dma);
> 
> For the sake of consistency, I would add lower_32_bits() to this call,
> as I see it for each use of RBQP or TBQP.

Ack.

> 
>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>> +                       macb_writel(bp, RBQPH,
>> +                                   upper_32_bits(queue->rx_ring_dma));
>> +#endif
>>
>>                  macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
> 
> Best regards,
>   Nicolas
> 

regards,
~Stan

