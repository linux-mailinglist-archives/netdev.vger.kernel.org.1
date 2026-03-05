Return-Path: <netdev+bounces-264298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JsLJlNhqWnj6QAAu9opvQ
	(envelope-from <netdev+bounces-264298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:56:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BA210247
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67B233048921
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16311370D4A;
	Thu,  5 Mar 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxTbqscW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k3/vZKXT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6932364EA7
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708007; cv=none; b=qUMsNSJQndcqrk/HSZL0DnDS4kN0CKkMhW+t5ppsloSwEzTQFP/1ebMwQFRP7hrt8/e6VD9a8526k/8MIWMAXeItm9grD66NxCyCNjfs8spHiEqB16HZnX5vUUI38i9eJY3Yo8F3WtSmmNv0EJuhx/bZbQCik/eJvtbbvkRxFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708007; c=relaxed/simple;
	bh=Eab+ZJ/4NLOYqgBa06weMKL6XqFlkLnTZPg93WUHzOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDTzSwMOagte+vg2FcmYrerJyJhwA1+E1jVz/ofz6fxaznjALHNPHBvbHdA0b8EfFQHm6OL5OZ63YfmTQBGsZ/2922Zsu5xsgPP7yn+RZ7gSDsxd8JM2hKpm8bEm6c67c19SfyUhaEvBnRA4/qTsIkskbK7JvWnGwXHRufCFKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxTbqscW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k3/vZKXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772708005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLX2ghML9aiudKPkgNbhffH/qN+3rsQlF+RIgXC9EUY=;
	b=dxTbqscWBttT5EDg3PSkgqVGmHc3d1GtHfPqMzevzrlRkiQOB9PwxU0TKgTmpr0FK+7F5G
	JajQpXFTPFCu2TOZUD6x88XHmCwIl0r7h2iKUepefbjL+HUqpAM6tZW4Ok5syQreS/grYN
	hsgQ6lCHV4AwGWgJFgZZ1S+JIy+PDRU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-eyDGrd7IOx2i4lWlW4y4yA-1; Thu, 05 Mar 2026 05:53:23 -0500
X-MC-Unique: eyDGrd7IOx2i4lWlW4y4yA-1
X-Mimecast-MFC-AGG-ID: eyDGrd7IOx2i4lWlW4y4yA_1772708002
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439b484ee04so2855610f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772708002; x=1773312802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLX2ghML9aiudKPkgNbhffH/qN+3rsQlF+RIgXC9EUY=;
        b=k3/vZKXTMBxhQhkGivIZJUJRWCKdOEtkOpejQVGGS0zWKgh7mwkfPX19Y4rU40cdbA
         84xe6qzS0rnxu70w1g5xbYraNhiajy+hcRCH0pU9KZB+obFMmcJtdAxhl+ablXelNmH2
         J9NIwkmgccUso2w6OsnFZZWAIt04t9vHhe9D0ar0ngFUWnETvKyLhfMdSCrI9Ab4CKlN
         mdZF0y5P5Ipux2B9Wk0pzqIUlY6q8vXuQALdPSKCpCLCNvcRA6ZObTO1tyd4ab2700pI
         miUU7xfr79nb0YotiV6YD5S5nnj+sAabyv5Oa5O4KEXdsMWDSsoocCcjqnRTIH9uRgUq
         ohHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708002; x=1773312802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLX2ghML9aiudKPkgNbhffH/qN+3rsQlF+RIgXC9EUY=;
        b=lfW02JOznwJKCU/uQ9XD98qZBZb0hNn+OcBxg02QDRoQKTzTk8cMfpWbg+7DJ85kh4
         yRIUDbMi/P+8KPkpGrxp8x4XFvxLumYrq3CVQJHWFaWXmuVMvA++sHk9jQRz11IUa4yN
         oFB+5JBe8x1W5CdVb1AXKnYfQGrUdf7hOx4frD4VInbyvMkw0RWzWK02B/K1ATqVtNbA
         OPxII7QAuHn1f0zDPA70VOnrr9++3I9itvsVPciNbe9rZXvUDsFg+YZMqAN2Vlq9f2pm
         o45K0E5mrehOirVYdHbGAR6IvXlHshU7Y+t0BHuVVvVqZq2kA15KsLvAPqycvESXyxRI
         ExWw==
X-Forwarded-Encrypted: i=1; AJvYcCWDszsELHzqUJjyc/QaPb6AyN2WhIaisWWDydW4BMOU79UVyyqAYO6uRJmrOBCnfNPYeOmpaO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOnM+w78gyVQmRdhuB06h1EE7yWNxTDP0+mEgcfx/smQnEs+V
	4qMw6mG6gCYB4tWGPI3l5wnkRtXMwcb35o5iIrw52LDN1vYxhRKwg5pzalsQ8awpZ/0yPUg496Q
	7Si1VmrXI4z3CVeD8o/mL5cLH5yVZ+u8WK1jTJFBWxPn0adgp8jDgsfcgyA==
X-Gm-Gg: ATEYQzyWzdtK8fXcp02iyPcNOUTofsKi53Umi3Oi65sa7pyu59BoVIqYifSYpGrXpdI
	0kznqp4k+yNRCUdWuMvuUGuPYMvmD9ZrsUqAFheAt0nF8kf0+2sm/GW2keS5LPE8PTQqDN5Nnx+
	YttrIMeb3Y3VEM9D40bJ/eyBKm3nDCqBZRtlt/jz7fnvo/QzCn5F87M5DuqqfbIQhuJ69qaf1cS
	0/UwKND3hT99RRKjzVuEuRRlC9xsOm6yvnSQEt0iw/W0K/X9ooeCff3+qgiYrVOL/DTt28zOOWI
	a6pUjVI+woc7a8e9rEvp0Ek2Fuw174a7taNkY86oQDF5qT/gLGXrs90R9opOjj/6dkjJBot9BP1
	ge6goq6O5MyO0Zfoja/2BlUqtVg==
X-Received: by 2002:a5d:5d86:0:b0:439:c078:9a57 with SMTP id ffacd0b85a97d-439cfd459b1mr3518450f8f.25.1772708001757;
        Thu, 05 Mar 2026 02:53:21 -0800 (PST)
X-Received: by 2002:a5d:5d86:0:b0:439:c078:9a57 with SMTP id ffacd0b85a97d-439cfd459b1mr3518408f8f.25.1772708001284;
        Thu, 05 Mar 2026 02:53:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c2f7eca1sm15467080f8f.11.2026.03.05.02.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:53:20 -0800 (PST)
Message-ID: <4a7c8f45-abe3-4673-9b7c-abc1040b0bdc@redhat.com>
Date: Thu, 5 Mar 2026 11:53:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/8] net: macb: Add page pool support handle
 multi-descriptor frame rx
To: Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
 <20260302115232.1430640-4-pvalerio@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302115232.1430640-4-pvalerio@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 888BA210247
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264298-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/2/26 12:52 PM, Paolo Valerio wrote:
> Use the page pool allocator for the data buffers and enable skb
> recycling support, instead of relying on netdev_alloc_skb
> allocating the entire skb during the refill.
> 
> The patch also add support for receiving network frames that span
> multiple DMA descriptors in the Cadence MACB/GEM Ethernet driver.
> 
> The patch removes the requirement that limited frame reception to
> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
> contiguous multi-page allocation for large frames.
> 
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/Kconfig     |   1 +
>  drivers/net/ethernet/cadence/macb.h      |   5 +
>  drivers/net/ethernet/cadence/macb_main.c | 401 ++++++++++++++++-------
>  3 files changed, 283 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
> index 5b2a461dfd28..ae500f717433 100644
> --- a/drivers/net/ethernet/cadence/Kconfig
> +++ b/drivers/net/ethernet/cadence/Kconfig
> @@ -25,6 +25,7 @@ config MACB
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select PHYLINK
>  	select CRC32
> +	select PAGE_POOL
>  	help
>  	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
>  	  AT91 parts.  This driver also supports the Cadence GEM (Gigabit
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 3b184e9ac771..a78ad00f53b1 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/phy/phy.h>
>  #include <linux/workqueue.h>
> +#include <net/page_pool/helpers.h>
>  
>  #define MACB_GREGS_NBR 16
>  #define MACB_GREGS_VERSION 2
> @@ -1266,6 +1267,8 @@ struct macb_queue {
>  	void			*rx_buffers;
>  	struct napi_struct	napi_rx;
>  	struct queue_stats stats;
> +	struct page_pool	*page_pool;
> +	struct sk_buff		*skb;
>  };
>  
>  struct ethtool_rx_fs_item {
> @@ -1289,6 +1292,8 @@ struct macb {
>  	struct macb_dma_desc	*rx_ring_tieoff;
>  	dma_addr_t		rx_ring_tieoff_dma;
>  	size_t			rx_buffer_size;
> +	size_t			rx_headroom;
> +	unsigned int		rx_ip_align;
>  
>  	unsigned int		rx_ring_size;
>  	unsigned int		tx_ring_size;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fbd4872901c2..621bca2e1844 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1263,14 +1263,54 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  	return packets;
>  }
>  
> -static int gem_rx_refill(struct macb_queue *queue)
> +static inline int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
> +				  u32 desc_ctrl, bool rx_sof, bool rx_eof)

Please no static inline in c files.

> +{
> +	int len;
> +
> +	if (unlikely(!rx_sof && !queue->skb)) {
> +		netdev_err(bp->dev,
> +			   "Received non-starting frame while expecting a starting one\n");

The existing code already had a few of them, but this
netdev_err()/netdev_warn() messages on per packet events could DoS the
host should they ever trigger.

Please switch to _once() or _ratelimited() variant when the
warning/error could be triggered by an incoming packet.

/P


