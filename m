Return-Path: <netdev+bounces-262130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCZeBDDvomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:35:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D7D1C3478
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8723049717
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D82BE02B;
	Sat, 28 Feb 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="etzbcauT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4E2139C9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285727; cv=none; b=djiXQgIXTkXNfeeZeoazSGAEfqhjfkDSl8mrOWSxRGPKCh6qVwhUbeb7G5xBWMXHRCp4Y32Nv1t818NRMr5rEXOQqctYhG4DKrbYsjBoGGdNU6AgGtQcQnYIt5XeKjVlvnq/GPye5TDoeH37xI4WBM2Fcou2MiA26JgnqRhV6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285727; c=relaxed/simple;
	bh=ln1PY0DlZKT4RYP3A9q1YZ0m2XLVhqAHG9J6t0KQ/pc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rF+beM8/SljgoHyia8EWFk0ZVSbVzN5GU/9oBcDoJnQAw1Ndw5T94xd3H3hQHL3F1UK5okKUNK8m8IDUjE1o4uYPXrTXfLNE9MP1JgzGp5zhhDo4TT3+e0L/kcfx3ambK9pd+6lvdDHt9SPWZFsre3u1eGGQMVeJ6CTMorsxV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=etzbcauT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371119eacso35347405e9.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285724; x=1772890524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9NTUP01HwOEXmkT5Si5cBmb1YnpCmN0+EXSES2QRV0g=;
        b=etzbcauTcMlUDjrZFeIXjfJTxKk+aRR3FZIAtFmy4JpuW2LmBupZWU8nxpyPreRMZY
         yU1qAXiMyyfX3W8Il0ytf2oOq7Zj6U1vNMvst5jdAfK3nu8v+X+IyCKPxZ9L+8fSj3kN
         uaLN7iRBkYEqg5LJAuj+sGH/PP2tuQOG3eEe5KHZGUC84tl8Ghbfno7wUAb0o2TyrRor
         5ssp2mMsJtP4uPHKFXEBtQEA8HDMSB22RC0YlawWaWUD0xlIo2loIbjxkPet3S2p1yO9
         Lm9bqCHDoRX5tSnvavGd4IiERZ3p/4TRxN/QuXg+1NCwUql0Yb1u4/aNGw6z539sMfE5
         PwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285724; x=1772890524;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NTUP01HwOEXmkT5Si5cBmb1YnpCmN0+EXSES2QRV0g=;
        b=ax391quRFH9IxyGbDZE9TOW6keA54PN695R/RzG2ZLuazA/EHDFJXgXdMjI7c+ClP8
         GG12sLe2BFXvB8D7ycpKPg/bG4gyhSk8lcZSpHWlvYKHmOYFHIXnj/ydL08K0NuumMDL
         oTxydY3XLqJcZlhyXs8MpyuQS597IxazH3GQjGCsPP/zKtcJfhXlMyCYWDJMYZBHt0JE
         +YPjdQQef2yHaNKR4y0Dwgi0/vbx9F+Mx2+6m9bH3ZLuREbW38MfAvnTg47H+YxBz3nd
         9d2vvN09VG+Uhu1QvKlXAbAseeEV1OOKW5ZkIDZEfYOOthD+KdYfkl1JCba17uxEHaGN
         t0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/zf4dI4suCkBVdYng7fL9EvWtxAeGrkxWhUNe+yMPu7OHK8UGLS05AWwPQomVSbXKpLfMc68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovB7PbldhmiLmPpsVxklmSnWyFJ9xDaZXl3jPNrm6wHmsoSEE
	Z/t9nDBL4MdfC/nN31Y4Bs4nlkmn0znvfjNwee/thAvtVTEnV7dNnCH/L3WJeOBUkpY=
X-Gm-Gg: ATEYQzyPXpMftHFWieJyuHx42ts4urWphprWwKtN3xNnHOraADFDstz6fDrD8yUVOqG
	gj7JqPGWHSP2RBgGmAw3Fxsv5Iso5JIDNf5vEVqx1aFMA1RtcxWkzaFYoATJ1QH8MBqvHI2KMYn
	1Khvzhp3soRnu7eDlsWWEdYYTeXgEf17+sblWDW7Q6fspF+38quqDhNlw1vQimCUI8QAPxjtlKT
	G1fKHWvjmH8tON9ayk/hAJI4oAcE6E+tTsybosfzmskL7wB7cAYWw9DA1Tu2zzrfhQAhRoqhiha
	PQYsnp72azmGj9O8LxeL1HcBOHwRLymmJt4inbH7wKc4V5tii0rfQ6Cl3fXtNP8YudvwFbPpQtX
	LNCejbtrKFqRD9C/2Am5Aa1BzqwT/KIuGqdXpZE7Umm2nSjBJgXwTt5Z8rlPr4z53x67ieu9qyY
	TVcoVoTuapEVXmUt/fZMsTpqcMZ7svzBny363DUEYf
X-Received: by 2002:a05:600c:4f8b:b0:483:498f:7953 with SMTP id 5b1f17b1804b1-483c9c21525mr101267535e9.28.1772285724247;
        Sat, 28 Feb 2026 05:35:24 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a0f6sm16847128f8f.22.2026.02.28.05.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:35:23 -0800 (PST)
Message-ID: <62879963-ebd7-4392-aa6a-acf664171fbe@tuxon.dev>
Date: Sat, 28 Feb 2026 15:35:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/4] net: cadence: macb: implement EEE TX LPI
 support
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, nicolas.ferre@microchip.com, pabeni@redhat.com,
 linux@armlinux.org.uk, theo.lebrun@bootlin.com, rmk+kernel@armlinux.org.uk,
 phil@raspberrypi.com
References: <20260226090608.54802-1-nb@tipi-net.de>
 <20260226090608.54802-3-nb@tipi-net.de>
 <df5d1dd7-fd23-44a5-808f-145080fbbf87@tuxon.dev>
Content-Language: en-US
In-Reply-To: <df5d1dd7-fd23-44a5-808f-145080fbbf87@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tuxon.dev:mid,tuxon.dev:dkim,tuxon.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: 34D7D1C3478
X-Rspamd-Action: no action



On 2/28/26 15:33, Claudiu Beznea wrote:
> 
> 
> On 2/26/26 11:06, Nicolai Buchwitz wrote:
>> The GEM MAC has hardware LPI registers (NCR bit 19: TXLPIEN) but no
>> built-in idle timer, so asserting TXLPIEN blocks all TX immediately
>> with no automatic wake. A software idle timer is required, as noted
>> in Microchip documentation (section 40.6.19): "It is best to use
>> firmware to control LPI."
>>
>> Implement phylink managed EEE using the mac_enable_tx_lpi and
>> mac_disable_tx_lpi callbacks:
>>
>> - macb_tx_lpi_set(): atomically sets or clears TXLPIEN under the
>>    existing bp->lock spinlock; returns bool indicating whether the
>>    register actually changed, avoiding redundant writes.
>>
>> - macb_tx_lpi_work_fn(): delayed_work handler that enters LPI if all
>>    TX queues are idle and EEE is still active.
>>
>> - macb_tx_lpi_schedule(): arms the work timer using the LPI timer
>>    value provided by phylink (default 250 ms). Called from
>>    macb_tx_complete() after each TX drain so the idle countdown
>>    restarts whenever the ring goes quiet.
>>
>> - macb_tx_lpi_wake(): called from macb_start_xmit() before TSTART.
>>    Clears TXLPIEN and applies a 50 us udelay for PHY wake (IEEE
>>    802.3az Tw_sys_tx is 16.5 us for 1000BASE-T / 30 us for
>>    100BASE-TX; GEM has no hardware enforcement). Only delays when
>>    TXLPIEN was actually set, avoiding overhead on the common path.
>>    The delay is placed after tx_head is advanced so the work_fn's
>>    queue-idle check sees a non-empty ring and cannot race back into
>>    LPI before the frame is transmitted.
>>
>> - mac_enable_tx_lpi: stores the timer and sets eee_active, then
>>    defers the first LPI entry by 1 second per IEEE 802.3az section
>>    22.7a.
>>
>> - mac_disable_tx_lpi: clears eee_active, cancels the work, and
>>    deasserts TXLPIEN.
>>
>> Populate phylink_config lpi_interfaces (MII, GMII, RGMII variants)
>> and lpi_capabilities (MAC_100FD | MAC_1000FD) so phylink can
>> negotiate EEE with the PHY and call the callbacks appropriately.
>> Set lpi_timer_default to 250000 us and eee_enabled_default to true.
>>
>> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> ---
>>   drivers/net/ethernet/cadence/macb.h      |   8 ++
>>   drivers/net/ethernet/cadence/macb_main.c | 112 +++++++++++++++++++++++
>>   2 files changed, 120 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/ 
>> cadence/macb.h
>> index 19aa98d01c8c..c69828b27dae 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -309,6 +309,8 @@
>>   #define MACB_IRXFCS_SIZE    1
>>   /* GEM specific NCR bitfields. */
>> +#define GEM_TXLPIEN_OFFSET        19
>> +#define GEM_TXLPIEN_SIZE        1
>>   #define GEM_ENABLE_HS_MAC_OFFSET    31
>>   #define GEM_ENABLE_HS_MAC_SIZE        1
>> @@ -783,6 +785,7 @@
>>   #define MACB_CAPS_DMA_PTP            BIT(22)
>>   #define MACB_CAPS_RSC                BIT(23)
>>   #define MACB_CAPS_NO_LSO            BIT(24)
>> +#define MACB_CAPS_EEE                BIT(25)
>>   /* LSO settings */
>>   #define MACB_LSO_UFO_ENABLE            0x01
>> @@ -1369,6 +1372,11 @@ struct macb {
>>       struct work_struct    hresp_err_bh_work;
>> +    /* EEE / LPI state */
>> +    bool            eee_active;
>> +    struct delayed_work    tx_lpi_work;
>> +    u32            tx_lpi_timer;
>> +
>>       int    rx_bd_rd_prefetch;
>>       int    tx_bd_rd_prefetch;
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/ 
>> cadence/macb_main.c
>> index 43cd013bb70e..6b9c63195970 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/clk-provider.h>
>>   #include <linux/clk.h>
>>   #include <linux/crc32.h>
>> +#include <linux/delay.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/etherdevice.h>
>>   #include <linux/firmware/xlnx-zynqmp.h>
>> @@ -589,6 +590,94 @@ static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
>>       .pcs_config = macb_pcs_config,
>>   };
>> +static bool macb_tx_lpi_set(struct macb *bp, bool enable)
>> +{
>> +    unsigned long flags;
>> +    u32 old, ncr;
>> +
>> +    spin_lock_irqsave(&bp->lock, flags);
>> +    ncr = macb_readl(bp, NCR);
>> +    old = ncr;
>> +    if (enable)
>> +        ncr |= GEM_BIT(TXLPIEN);
>> +    else
>> +        ncr &= ~GEM_BIT(TXLPIEN);
>> +    if (old != ncr)
>> +        macb_writel(bp, NCR, ncr);
>> +    spin_unlock_irqrestore(&bp->lock, flags);
>> +
>> +    return old != ncr;
>> +}
>> +
>> +static bool macb_tx_all_queues_idle(struct macb *bp)
>> +{
>> +    unsigned int q;
>> +
>> +    for (q = 0; q < bp->num_queues; q++) {
>> +        struct macb_queue *queue = &bp->queues[q];
> 
> In case there will be another version, to have a unified approach across the 
> driver, this loop can be written as all of the loops on queues in this driver:
> 
>      for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>          // ...
>      }
> 

Replied to the wrong version. Please ignore.

> Apart from that:
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Thank you,
> Claudiu


