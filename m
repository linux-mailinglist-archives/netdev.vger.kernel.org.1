Return-Path: <netdev+bounces-262127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OIxEfzuomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:34:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4F71C345C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B42D73004634
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B042D1907;
	Sat, 28 Feb 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X/jKZkx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72285FDA7
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285609; cv=none; b=gSWB0rtPnrCf5uXcW2p/BtG/JEmxTuOqFpFLqNyJFjvHO3SoIVb585T7pC1oArEkmBcygXYiX0ecRQyxz+caPotrl5VSKpB/ee4P2TzcgQ6+cw2ttM4bSLRooM881YsV+a/aiEqAYXsPJFQwtqFuhH87jFACMJ5nTDt8+SsuC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285609; c=relaxed/simple;
	bh=phJmOBRpWKyzvt7+oGo9C0cXEbpM+ahEkFN0vnRurZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJiwhbeF4ROtRU1BZk8CmTTg0APqSojpAJK4S20urOuUgWf33dKL5bMBY+U6h/IK2dVO3GFcaR7SfQ7ZcPIILsNKWdvZD1coyDrQKu5QPszRr5CnOVe49QyWpioNZBlS+tpCdizFsXJrlYZSAerrAm61HOJu4J86P8ZYaEvgJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X/jKZkx4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48379a42f76so22919075e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285606; x=1772890406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lcd+Cqq7tPuRfOedkjg9XXWgJucsCFpiuer9kY4KCk0=;
        b=X/jKZkx46LHtUnX1QQKNsngkOaxHvXOaXDKaY0xwv6N3uTgmZE26p/I9UMoGd1oTDV
         4Y03RgP7HNMKNKd4/3GQKobxyHqX42mQ1zQyjJ9R6RkTA3IlfGdK0m8fMw5vG7K1UqIy
         hPMbh7RAI62cRPm/pdr3cDKeoCgE5xxJ/b7eqmFH6ssfRJbnptxH2Qz20IcXJMFL2oGl
         TbBhJHXYbAvCL9vPJmfxG70pq+R+eSumtLw5+uucrg55biyfqkOyAfhhx5OVmkxKjS5O
         0zdHUa6cLpxr3MKdbTHybiE4Bs/X/G+/FYhwGLXLTYW2edRNx3vHaXyGBvG/Z1U5cfnV
         aO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285606; x=1772890406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lcd+Cqq7tPuRfOedkjg9XXWgJucsCFpiuer9kY4KCk0=;
        b=hTGwUGLnIcp/MqZudQE0eD3QcWB6eSoQLB3rVv1FtfLfK9UY4J0I0/gvWaMFPm+nFf
         68C8QlM1NdvuhHCVfGbGDMn8jvnP/z7dnUaIM9bTJ6g5tE0NmiBSJA1QlOUR0YUG8IFm
         Y9ww8yA2+XWyQSEufrZaujZOy7b0HLVO/uKkFKn7IK1R0NkDQ8LDCX13+Hh7+9duc/rh
         SqkvJjmB2ULJ3RXiK+OCKB5SJkbtWKUd4udVfHM29ki6uw2qDEROb4It99AeUBxjl/p5
         k0+0A3Cj8Xzyv3Qz0f6W+XnoLbGYtjdz/4ETHOU5Ni/nsb8kS7LMnqpausUGim09iwgP
         oeLw==
X-Forwarded-Encrypted: i=1; AJvYcCVtMBYwSjsxHNFSY48nSw6AT4XSj4Uk6NH3FewochiR7y/WmpcUa8/ihzLmWcBbJisDTsKdlJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgsqA+XZGaRjN0p6fIv+VYI9Rup6USodFeJVcn/VyQB6i0NrV
	7ku746remEduNE+kSmBYGPs3t3HhhGxt7kJDmuw+mhP/BeWwMgZJn9E2g8aBRdArXGg=
X-Gm-Gg: ATEYQzwua00njDWUMIs8WLZFYDwwGLzhiyJlUkc4uDfoyL4Z5FAGu9fASG+3bnglzA7
	jrCK0QZ8VtcrlHKYD2ojjYznZStKqFuMhZABi/KBjULDoHIa31NGsuca2f5L1qCosCLW78o5svQ
	GNzI/kMaRn0rLVkbly5MtAVxevMKJ+zTVic/dhN2eofnnhpeNdyzQo56RiETLY2Ne/BhxKFDjFt
	lOWS8V7KsLeWNzLZYDatm7pP690R1xufrsz4ixFuLLxOLLR9Tm/+4SwXPg7Cdb1QjX4znkrYalQ
	axGAI8sO89peGt+hpt2I+XlC48WhHTjCTEcEh1pyOrThZJbRxiFyErR8kKPo3J+pjU2ei8dpMr4
	kseGIRChGSn8SzY1pibb/hP6xlKKg0CigNSWaFncYvNgk9O7PEYTiJwFhsEiPW7GBMKe0gr1KI/
	Ni3ZU0rJv281FoZi/ptE7DPwlE5LaUsw==
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483c9c243fbmr110047035e9.35.1772285605670;
        Sat, 28 Feb 2026 05:33:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb1390bsm165470175e9.1.2026.02.28.05.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:33:25 -0800 (PST)
Message-ID: <df5d1dd7-fd23-44a5-808f-145080fbbf87@tuxon.dev>
Date: Sat, 28 Feb 2026 15:33:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/4] net: cadence: macb: implement EEE TX LPI
 support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, nicolas.ferre@microchip.com, pabeni@redhat.com,
 linux@armlinux.org.uk, theo.lebrun@bootlin.com, rmk+kernel@armlinux.org.uk,
 phil@raspberrypi.com
References: <20260226090608.54802-1-nb@tipi-net.de>
 <20260226090608.54802-3-nb@tipi-net.de>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260226090608.54802-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262127-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim,tuxon.dev:email,tipi-net.de:email,bootlin.com:email]
X-Rspamd-Queue-Id: 4C4F71C345C
X-Rspamd-Action: no action



On 2/26/26 11:06, Nicolai Buchwitz wrote:
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
> index 43cd013bb70e..6b9c63195970 100644
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
> @@ -589,6 +590,94 @@ static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
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

