Return-Path: <netdev+bounces-288388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCJ5MFpfB2pa0QIAu9opvQ
	(envelope-from <netdev+bounces-288388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FB555C7B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA2730B6269
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE92F7EE8;
	Fri, 15 May 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5VFlTlw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3A2F7EEE
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865282; cv=none; b=JR3qo2zgJ0FmQF2m8z79edWg+TaGXBFRekgTTvcpQpnfNsuPFaAK+85HANYdCfgFFXMnrZr+EXwNpc90HXtz1RMH8+4zl7bxsDIrqjS2kpi6kA2w3EIcRy5TewXk91xnntQ6q/R7fgHSpiREMZrI9jvGRblbhTQ9oxy2XZRMnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865282; c=relaxed/simple;
	bh=LC9OHNbKrC9FZOQQTTEG4Hsi4cBNCQbZa9CGypc8kAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl37riEz8jjgPsWy5q5mGf9nnLERqimp7hceHUw7o+SuRQVd6zGRMjWlG9jQmLVdhb6Q3bJdVd5QY41vuh77JNJBbZzb3JUiCspC90xtiHaVXXHsjLS35Co1LDYLHYZxk4qnyAvJNktqMnLAnN8kaiYV87wLZ+96Ej1YV0bekZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5VFlTlw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-452169ae568so3924f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778865279; x=1779470079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJZqzlC/MyiJvlvFMtDR9fBoSavw/3np+GiRJ/Jc3kc=;
        b=f5VFlTlwlYmSe8QBChqZRu+LWF1ATfuRN2mjf/AwvGNoh5XQat36fadiqP76vJdx7U
         xTvn0TnSmfimZJ2yFQAcdC9TfEQmkkR4Uwi5vd/zaVkbFc9AvfNIqhF2QYC8ULkCDfOD
         osUsSOvO9sMMtRvxJLHQ62H1yYXob9slmx/x/tgN35lB0VzMZEkSkaY69ENEe3As2SDb
         behhUt0p8zeE+Qa36HjuegqtsCTGYihudraO/f/AYlEXm0AhTUTKSYaTdVm/fNM2R3rf
         vW/S90iOpOKruwXLzVKOgT2fPMkcYbr0d/4hvGex+cwElBI3EjAcpcoTpo0lRmhGCVEb
         qRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865279; x=1779470079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJZqzlC/MyiJvlvFMtDR9fBoSavw/3np+GiRJ/Jc3kc=;
        b=E1oS/y8bME0IkfPbummZvQtmDi4Hv10fs3pWpgFdC5KTHJelRU8wPxj/2XJ7OZaVM4
         54Nju/UR1dQmMj3eBJlOk6UeLHPBHn+IOuJCb/OdNAX2arqquD5tFZ9qBE/ngQP6Sfux
         KaKbWBV/wG35VcypH1qQJlDQFelX2ZdM5Zm+RgGber0+C6imlT0JCFPkdhNqGBC3dALc
         D8w/zIzWyfdZqbMae8d8LYfH8P5TzffTNHtaGV+IEmZ7J6wAwEhFLKKBh8GkURGiqtT+
         DgzFwfI2aicatGLLKlvic5byJtu7depEdkKVTNGZoVh1a64heap5LA6dlrZ1B7jcbGHI
         0Fsw==
X-Gm-Message-State: AOJu0YybZJr7BCeFynZV3qjAgwMrXl2Mr3pivezkmyO4Exr+X8/AfOcY
	wHrYgh8iF+Mcc8i7PpxqUES/Da9e/gJ9rvn8+MfEOHNeFhIHgh62fByH
X-Gm-Gg: Acq92OHZytyr1YX/3L+luujnZcp8Pgp67T2nTcOSRbpQjt4fISs/ePJY59xa/d6NWG0
	poSP/6C8CVD/osRtDP5vvdSjf4WWJKaHlzVm/eq63BqQPZRGetWeTkFIRGewVGjMH1jW/hKr5UO
	4EK7O2mhQu6SowjVFDlS3w1dgDEbRQSIBddbNpURPdRvAuQ6ApSuQreA5OvqbT6RudwUmnJUSX8
	JMM66QRlDnLG2f3pfdewdiMSit2FKIsnuoTB1xIX2dLeuAKChmWzZVQ/pQoO4m+UA2j6qTB4yUY
	bvFtqjUE4RPjvWBUBUh09fYHxQsnv1NwBi0qHX71xUqSfEi6jhpx3G93A6vKhemJS1Y0Sy/TZMk
	L0AzIjJLEHptivfUHwTHgSsO8j8sdxsDv15eu6PmsXBLnHnXxhIDZqlCCm5LhcVVWB1gYLmNJyA
	HL5FfQNia7JjSH3lOMUWgWf6Agool51/e5MM33xZ6d2mefYaE65e14ljkuyDXZTeZlaN/uy5odc
	m4fbkU3e8IHjeVdnv08yJDSXmJxZG1zA+6JsqyB9AaX0bEikfrX+8nu+/fQoXM9ig==
X-Received: by 2002:a05:6000:24c5:b0:45b:d2ff:4d4f with SMTP id ffacd0b85a97d-45e5c612fa3mr6819668f8f.40.1778865279184;
        Fri, 15 May 2026 10:14:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f17:5b00:3d43:d343:a252:9fd6? (p200300ea8f175b003d43d343a2529fd6.dip0.t-ipconnect.de. [2003:ea:8f17:5b00:3d43:d343:a252:9fd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm16005465f8f.20.2026.05.15.10.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 10:14:38 -0700 (PDT)
Message-ID: <18fbc6cc-2ec8-438e-afd0-bf25e576670a@gmail.com>
Date: Fri, 15 May 2026 19:14:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: r8169: add RX allocation failure counters
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515143015.64018-1-kshitiz.bartariya@zohomail.in>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260515143015.64018-1-kshitiz.bartariya@zohomail.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 489FB555C7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288388-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.in:email]
X-Rspamd-Action: no action

On 15.05.2026 16:30, Kshitiz Bartariya wrote:
> Add driver-private ethtool counters for RX allocation failures so packet
> drops under memory pressure are easier to diagnose.
> 

Could you please elaborate on the use case? What would you do based on
this counter information?
I'm not in favor of driver-private counters. If there's a valid use case,
then it's driver-independent, and related code should be in net core.

AFAIK the kernel complains anyway if allocations fail due to
memory pressure. That's the reason why extra error messages
for kmalloc() returning NULL are discouraged.

> The new aggregate rx_alloc_fail counter is incremented when the driver
> fails to allocate an RX page, fails to map an RX page for DMA, or fails
> to allocate an skb in the RX receive path. Individual counters for finer
> details are:
>  1. rx_buf_alloc_fail : failed to allocate an RX page
>  2. rx_dma_mapping_fail : failed to map an RX page for DMA
>  3. rx_skb_alloc_fail : failed to allocate an skb
> 
> These are kept in struct rtl8169_private instead of
> struct rtl8169_counters, which contain the hardware tally counters.
> 
> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..c1a200e14f6f 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -766,6 +766,10 @@ struct rtl8169_private {
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> +	atomic64_t rx_alloc_fail;
> +	atomic64_t rx_buf_alloc_fail;
> +	atomic64_t rx_dma_mapping_fail;
> +	atomic64_t rx_skb_alloc_fail;
>  	u32 saved_wolopts;
>  
>  	const char *fw_name;
> @@ -1901,6 +1905,10 @@ static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
>  	"multicast",
>  	"tx_aborted",
>  	"tx_underrun",
> +	"rx_alloc_fail",
> +	"rx_buf_alloc_fail",
> +	"rx_dma_mapping_fail",
> +	"rx_skb_alloc_fail",
>  };
>  
>  static int rtl8169_get_sset_count(struct net_device *dev, int sset)
> @@ -1999,6 +2007,10 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
>  	data[10] = le32_to_cpu(counters->rx_multicast);
>  	data[11] = le16_to_cpu(counters->tx_aborted);
>  	data[12] = le16_to_cpu(counters->tx_underrun);
> +	data[13] = atomic64_read(&tp->rx_alloc_fail);
> +	data[14] = atomic64_read(&tp->rx_buf_alloc_fail);
> +	data[15] = atomic64_read(&tp->rx_dma_mapping_fail);
> +	data[16] = atomic64_read(&tp->rx_skb_alloc_fail);
>  }
>  
>  static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> @@ -4167,12 +4179,17 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	struct page *data;
>  
>  	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> -	if (!data)
> +	if (!data) {
> +		atomic64_inc(&tp->rx_alloc_fail);
> +		atomic64_inc(&tp->rx_buf_alloc_fail);
>  		return NULL;
> +	}
>  
>  	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
>  	if (unlikely(dma_mapping_error(d, mapping))) {
>  		netdev_err(tp->dev, "Failed to map RX DMA!\n");
> +		atomic64_inc(&tp->rx_alloc_fail);
> +		atomic64_inc(&tp->rx_dma_mapping_fail);
>  		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
>  		return NULL;
>  	}
> @@ -4823,6 +4840,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		skb = napi_alloc_skb(&tp->napi, pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
> +			atomic64_inc(&tp->rx_alloc_fail);
> +			atomic64_inc(&tp->rx_skb_alloc_fail);
>  			goto release_descriptor;
>  		}
>  


