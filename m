Return-Path: <netdev+bounces-301157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Ft3FPVcOWqGrAcAu9opvQ
	(envelope-from <netdev+bounces-301157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:04:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6CC6B0F65
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301157-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301157-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCA930459E9
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A083CAE9B;
	Mon, 22 Jun 2026 16:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465535839E;
	Mon, 22 Jun 2026 16:00:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144056; cv=none; b=ojdGcI2dEKQgHUZ2Cq1y/1Zmm2UL3fCf1II8tLtauUdRgpAvcTughLRWOcYFZYFI508pBn1zL8EsCjNVbT+spjvfDe1YYIh8XyYKRuA5jbLn3Mf5B22NdneT32TOwtIWuTmlKuqiHDtDa8xE9oUPlu7iLDbOOM0ricy6CbEILHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144056; c=relaxed/simple;
	bh=7UT5IRWOiV6egMs7KlbG/lfk0lDn8cic0obhliOTZ0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVoHJJ6BYfTmvNbZasLmqW/Zb9RwEqQ9iVb0kagNDZSPToSTBWxNKlAAvppHhT663nWKwhr1euwFdjlvMHcCTZZHYh/wGRW2UEHEiIRI5GEApQmjekyG3fUqMZ6xlLPZiDQsGrHLyxnkV+Qrv8CekFOryIiiG63EM29KNyh18vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2FF704C28871AA;
	Mon, 22 Jun 2026 17:59:55 +0200 (CEST)
Message-ID: <40abd0b5-7f3f-4cd4-9975-9db4498d15d3@molgen.mpg.de>
Date: Mon, 22 Jun 2026 17:59:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting
 when NET_RX_BUSY_POLL is disabled
To: Ding Meng <meng.ding@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jan.kiszka@siemens.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, wq.wang@siemens.com
References: <20260622041718.6106-1-meng.ding@siemens.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260622041718.6106-1-meng.ding@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mpg.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:meng.ding@siemens.com,m:florian.bezdeka@siemens.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jan.kiszka@siemens.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:wq.wang@siemens.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-301157-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,molgen.mpg.de:mid,molgen.mpg.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B6CC6B0F65

Dear Ding,


Thank you for your patch.

Am 22.06.26 um 06:13 schrieb Ding Meng via Intel-wired-lan:
> When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> from the NIC no longer works as expected.

Maybe paste some logs/errors, so it can be easier found by people with 
the same issue.

> This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> fails to perform its driver lookup, and the igc driver's struct
> net_device_ops::ndo_get_tstamp is never invoked.
> 
> Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> a field that the driver has not populated.
> 
> Fix this by populating the hwtstamp field with the correct timestamp
> in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.

Maybe detail, why the adapter needs to be passed now.

Also, please describe a test case to check the change.

> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Ding Meng <meng.ding@siemens.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 38 ++++++++++++++++-------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8ac16808023..1da8d7aa76d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>   	return skb;
>   }
>   
> -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> +					 struct sk_buff *skb,
> +					 struct igc_xdp_buff *ctx)
> +{
> +	if (!ctx->rx_ts)
> +		return;
> +#ifdef CONFIG_NET_RX_BUSY_POLL

Is there a way to do this in C instead of the pre-processor. That way 
all the code gets build tested. (Is there a config with disabled 
NET_RX_BUSY_POLL?)

> +	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> +	skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
> +#else
> +	struct igc_inline_rx_tstamps *tstamps;
> +
> +	tstamps = ctx->rx_ts;
> +	skb_hwtstamps(skb)->hwtstamp = igc_ptp_rx_pktstamp(adapter,
> +							   tstamps->timer0);
> +#endif
> +}
> +
> +static struct sk_buff *igc_construct_skb(struct igc_adapter *adapter,
> +					 struct igc_ring *rx_ring,
>   					 struct igc_rx_buffer *rx_buffer,
>   					 struct igc_xdp_buff *ctx)
>   {
> @@ -2013,10 +2032,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
>   	if (unlikely(!skb))
>   		return NULL;
>   
> -	if (ctx->rx_ts) {
> -		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> -		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
> -	}
> +	igc_construct_skb_timestamps(adapter, skb, ctx);
>   
>   	/* Determine available headroom for copy */
>   	headlen = size;
> @@ -2686,7 +2702,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>   		else if (ring_uses_build_skb(rx_ring))
>   			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
>   		else
> -			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
> +			skb = igc_construct_skb(adapter, rx_ring, rx_buffer, &ctx);
>   
>   		/* exit if we failed to retrieve a buffer */
>   		if (!xdp_res && !skb) {
> @@ -2738,7 +2754,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>   	return total_packets;
>   }
>   
> -static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
> +static struct sk_buff *igc_construct_skb_zc(struct igc_adapter *adapter,
> +					    struct igc_ring *ring,
>   					    struct igc_xdp_buff *ctx)
>   {
>   	struct xdp_buff *xdp = &ctx->xdp;
> @@ -2760,10 +2777,7 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
>   		__skb_pull(skb, metasize);
>   	}
>   
> -	if (ctx->rx_ts) {
> -		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> -		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
> -	}
> +	igc_construct_skb_timestamps(adapter, skb, ctx);
>   
>   	return skb;
>   }
> @@ -2775,7 +2789,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
>   	struct igc_ring *ring = q_vector->rx.ring;
>   	struct sk_buff *skb;
>   
> -	skb = igc_construct_skb_zc(ring, ctx);
> +	skb = igc_construct_skb_zc(q_vector->adapter, ring, ctx);
>   	if (!skb) {
>   		ring->rx_stats.alloc_failed++;
>   		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);

Otherwise this looks good.


Kind regards,

Paul

