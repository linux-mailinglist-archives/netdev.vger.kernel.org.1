Return-Path: <netdev+bounces-262129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGOCMgTvomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:35:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 236EA1C3463
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D4E304917F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA32BE05F;
	Sat, 28 Feb 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GeuS3dKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C3280336
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285698; cv=none; b=Kw9TgFYwpbxvAanoEhVe6S49rHI1J0PzXt23F1eTMh10pAOR8W1SUs9/FK70m74yaicAnBoVIPdUTe6XditqGOb4BzFurL1s2zHyxXMkfMSDkwoddbkCqdV+SQKtTTPoz84ZCcwTpox7c8ID3BYXL3ZTPE/QfZ7V6O/l1XrzP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285698; c=relaxed/simple;
	bh=zR1JGdVilOiH/ao9CDQ2y5rcfb4bZHMpQovk2X03rzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ztb+XQubMscBRTpgx5dNVUzTNeHXQDJ/3AYmVZW9d+ECpGWBOaLLQ86aSSgq4IKgH/bWgMeWRbi/1IdCM6+ZYDDoT6CmMuPW9kLLxKso8d0oUR0l4BX/KjJxZgxoExvMwncvrx9eNlKlRrwGFNDNX+mnoJ5Xl6+I2cycocBKVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GeuS3dKs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439a7efc0c9so250203f8f.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285695; x=1772890495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLua3tlT0LHoQ9UnT8CQIIV+m8rXW8Qs+LItPZrHAFY=;
        b=GeuS3dKsn1VWD4A+JlgtekmRNmWmfu/KdVbMb2QGxxr0dv2oPNT/nhnTFc46Bng/o7
         VBKoPGHg7ZI0FFU675Od2+2pU2JhyqHPvV2pZUYdS8SU1YufN3cLo17jhi9xxVn1UO53
         SEY3MeSn6H7CHiFdWetyZemmheyGhlyS4fzw7uF7ngpf3MNPwB8q+KZGi8qILEGhsUNz
         zygeSQq/fnCKFhMLbyWaX4EfJuDOCWMSQKxsKR7Y9JQQuuhqoGatuinlLuyYlz36ayHZ
         L26SW7rkUPip+CPt1/SFx8Z7loj1yRNo46kgEqpic67CTxINyPNeBR7xhPCICA1OV8VR
         uEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285695; x=1772890495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLua3tlT0LHoQ9UnT8CQIIV+m8rXW8Qs+LItPZrHAFY=;
        b=ZWuU7R2aVX8h6iP05IPyttUJRtu0QNcPlpEmDCEOneZO4RVICqVh4pFsqo4IKBnWvY
         +K9RAUlJQ4aE6xob33viIN75zTdCYqLJh+uFQWGPXtJrbBQFo5UAxbWy2Puk/yNeqqDW
         NpU0bxD2f0m7jkKNk/60Hmwc3w9KjysVx6by6JdF6GTYcKCDQXLo+l2qQrVEnCxKe/Wg
         pGiuTrygvbfw2MVMhLejwPZg8ahLJzy9bfvLLSg+DXLoZ98CEuXkq9vISBMj2gx8RRwl
         q9t3xR67Y6sfOlQJgzm6+7NXjeR3GHQKoYbMoi4S8eAHdfNl2YFZPHtUn4GD6Fvn+QI+
         aVOA==
X-Forwarded-Encrypted: i=1; AJvYcCVD1SSOZhzT8k0V/KOFOpjiU3INCReuA3a5Bkw5a2dQ5a1iT8JnQyu7dI8gwVBvppkGfgxS8Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AUW5VGhBNrMkewGdzv3IgkwF2m/iuBS447zXtn1cn1qaSWpf
	Iplk9YZwwMnbMUUhcycRJOPdIPlCQMsTDKEz9hMSwzSY+Mw1kDHuuIUNTOT5a/968m0=
X-Gm-Gg: ATEYQzyRu3ykpiAQRnDUBkb2qwIIfbGebZ1NYJcrgIuasLz65F0v87IHz2XF9bmrxkm
	jvHTMUO2J819cNGkOs4YjUZSG+nJfQwtuVgzBeCJ9ctlFYUUffWwzE8M1PyGKhO7sS/TL4V0XCu
	vAgtu3cQq7L2HFnI25vcBNSSv7DpilerEJAa7IQPZP2P/DkKn+U4X4pNohFBavtOuY0VqsGVWQB
	iUQmfGyJBcx4h9q/xZxOFo3xJocSQyYVTtA6tdY0uFJa2aL+qD0So9QznHEuGEpYBX2V34MnPtM
	u8lM5XR03XIaLsoQvDL5rfeG7+qUPYiErO4UY7H3Jnz5WyvMIQ86GcigeO8s1rLS/UR4zILiySo
	egpZYAghJn7j1MMtZFL11XtllXCibGF2nwNXeo/sG12cUEYPG3L+wTgO/3zKXn5SKo93bkTDen3
	yw5j+LC0KJwkxDEa6baFh2Ept+HI4Q7Q==
X-Received: by 2002:a05:600c:1d09:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-483c33cab13mr167664195e9.5.1772285695185;
        Sat, 28 Feb 2026 05:34:55 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c764a35sm15413159f8f.30.2026.02.28.05.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:34:54 -0800 (PST)
Message-ID: <c84963c0-2f13-4cc0-9d70-c69b22a24e06@tuxon.dev>
Date: Sat, 28 Feb 2026 15:34:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] net: cadence: macb: implement EEE TX LPI
 support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, phil@raspberrypi.com
References: <20260227150610.242215-1-nb@tipi-net.de>
 <20260227150610.242215-3-nb@tipi-net.de>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227150610.242215-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262129-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tuxon.dev:mid,tuxon.dev:dkim,tuxon.dev:email,tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 236EA1C3463
X-Rspamd-Action: no action



On 2/27/26 17:06, Nicolai Buchwitz wrote:
> The GEM MAC has hardware LPI registers (NCR bit 19: TXLPIEN) but no
> built-in idle timer, so asserting TXLPIEN blocks all TX immediately
> with no automatic wake. A software idle timer is required, as noted
> in Microchip documentation (section 40.6.19): "It is best to use
> firmware to control LPI."
> 
> Implement phylink managed EEE using the mac_enable_tx_lpi and
> mac_disable_tx_lpi callbacks:
> 
> - macb_tx_lpi_set(): atomically sets or clears TXLPIEN under the
>    existing bp->lock spinlock; returns bool indicating whether the
>    register actually changed, avoiding redundant writes.
> 
> - macb_tx_lpi_work_fn(): delayed_work handler that enters LPI if all
>    TX queues are idle and EEE is still active.
> 
> - macb_tx_lpi_schedule(): arms the work timer using the LPI timer
>    value provided by phylink (default 250 ms). Called from
>    macb_tx_complete() after each TX drain so the idle countdown
>    restarts whenever the ring goes quiet.
> 
> - macb_tx_lpi_wake(): called from macb_start_xmit() before TSTART.
>    Clears TXLPIEN and applies a 50 us udelay for PHY wake (IEEE
>    802.3az Tw_sys_tx is 16.5 us for 1000BASE-T / 30 us for
>    100BASE-TX; GEM has no hardware enforcement). Only delays when
>    TXLPIEN was actually set, avoiding overhead on the common path.
>    The delay is placed after tx_head is advanced so the work_fn's
>    queue-idle check sees a non-empty ring and cannot race back into
>    LPI before the frame is transmitted.
> 
> - mac_enable_tx_lpi: stores the timer and sets eee_active, then
>    defers the first LPI entry by 1 second per IEEE 802.3az section
>    22.7a.
> 
> - mac_disable_tx_lpi: clears eee_active, cancels the work, and
>    deasserts TXLPIEN.
> 
> Populate phylink_config lpi_interfaces (MII, GMII, RGMII variants)
> and lpi_capabilities (MAC_100FD | MAC_1000FD) so phylink can
> negotiate EEE with the PHY and call the callbacks appropriately.
> Set lpi_timer_default to 250000 us and eee_enabled_default to true.
> 
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   drivers/net/ethernet/cadence/macb.h      |   8 ++
>   drivers/net/ethernet/cadence/macb_main.c | 112 +++++++++++++++++++++++
>   2 files changed, 120 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 19aa98d01c8c..c69828b27dae 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -309,6 +309,8 @@
>   #define MACB_IRXFCS_SIZE	1
>   
>   /* GEM specific NCR bitfields. */
> +#define GEM_TXLPIEN_OFFSET		19
> +#define GEM_TXLPIEN_SIZE		1
>   #define GEM_ENABLE_HS_MAC_OFFSET	31
>   #define GEM_ENABLE_HS_MAC_SIZE		1
>   
> @@ -783,6 +785,7 @@
>   #define MACB_CAPS_DMA_PTP			BIT(22)
>   #define MACB_CAPS_RSC				BIT(23)
>   #define MACB_CAPS_NO_LSO			BIT(24)
> +#define MACB_CAPS_EEE				BIT(25)
>   
>   /* LSO settings */
>   #define MACB_LSO_UFO_ENABLE			0x01
> @@ -1369,6 +1372,11 @@ struct macb {
>   
>   	struct work_struct	hresp_err_bh_work;
>   
> +	/* EEE / LPI state */
> +	bool			eee_active;
> +	struct delayed_work	tx_lpi_work;
> +	u32			tx_lpi_timer;
> +
>   	int	rx_bd_rd_prefetch;
>   	int	tx_bd_rd_prefetch;
>   
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 02eab26fd98b..c23485f049d3 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -10,6 +10,7 @@
>   #include <linux/clk-provider.h>
>   #include <linux/clk.h>
>   #include <linux/crc32.h>
> +#include <linux/delay.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/etherdevice.h>
>   #include <linux/firmware/xlnx-zynqmp.h>
> @@ -621,6 +622,94 @@ static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
>   	.pcs_config = macb_pcs_config,
>   };
>   
> +static bool macb_tx_lpi_set(struct macb *bp, bool enable)
> +{
> +	unsigned long flags;
> +	u32 old, ncr;
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +	ncr = macb_readl(bp, NCR);
> +	old = ncr;
> +	if (enable)
> +		ncr |= GEM_BIT(TXLPIEN);
> +	else
> +		ncr &= ~GEM_BIT(TXLPIEN);
> +	if (old != ncr)
> +		macb_writel(bp, NCR, ncr);
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	return old != ncr;
> +}
> +
> +static bool macb_tx_all_queues_idle(struct macb *bp)
> +{
> +	unsigned int q;
> +
> +	for (q = 0; q < bp->num_queues; q++) {
> +		struct macb_queue *queue = &bp->queues[q];

In case there will be another version, to have a unified approach across the 
driver, this loop can be written as all of the loops on queues in this driver:

     for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
         // ...
     }

Apart from that:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Thank you,
Claudiu

