Return-Path: <netdev+bounces-299269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u2baJpkOL2pa7gQAu9opvQ
	(envelope-from <netdev+bounces-299269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21257682275
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:27:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DIsnci7y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299269-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299269-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 814923001D5A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A02242D89;
	Sun, 14 Jun 2026 20:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AADA17993
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:27:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781468823; cv=none; b=T/83VI8uhNy/KgtQjbGvQJ7pFDj7uY7LxhetTy0+PlC5BjY1HQAb4slZ+Osfr6qErHBQGCuCChLVlK0Ja1Httkifsfkno2kF6YLpZgmtd78FBxEFJlXg6cI5T67fXNU+a5Ih7CgvVARZXUI1j8efNUsN+tecRrdEab5fjPBui0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781468823; c=relaxed/simple;
	bh=h7lPB/S5B31nLvaOm5KXiTkYe9b3vaGozMShEa8td+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mh2YF3qvc8CJmhIF1OOYmQh++kIJRdm3RkFDQf48i2wEYcAEoHTHXKns+7g7o46q7vzwpM3qvo0PygL6rIOe0UZrvk0/B076uZRIUygptmUzqs4fglkajl6fIBsy0wWuf3A7cl13bZsnuBx/JSXjynGmrxB7OBAbYGi/LBCKUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIsnci7y; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b9318997so18821235e9.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781468819; x=1782073619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+Z9JoS/GOkojVYg9rHkFfzRH/klwQ1mBsb7LuJucAw=;
        b=DIsnci7yFalo55wo3aBpphdi2TxNxhNLbP/lBpK5X8FO1F8VTDrCApXyUwTZyoxl41
         V81FUziuIkMQW4ZFboVLdDYNQKZvWQoIY8gqot4yxqIzNpMivIJu693dlhLpbqQqi+3q
         LDDb06apSGWGaSRE6uNj1saz3DfN4OwpRsjZv3wzDwiUhGGF1mjW45WmkamwROslkkxI
         dVte927n684Eu+jqS/t5O6qxnAx6wBfRIFxnCSBREeVY0IUAak07DCn59G469PVeYOcs
         EpgquBsJ3iVVs6YgOjtYOMzc8Wb3uocGdL9L6Fv0ZICKEbzF2x4OxNrzgM2ye6BRvX6c
         A9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781468819; x=1782073619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+Z9JoS/GOkojVYg9rHkFfzRH/klwQ1mBsb7LuJucAw=;
        b=ea/voKuWrqMpXB2w6QaqT9BaA/KTtodm3WhDJmEezkeNJN4DZr5g9xuevdofhTwpQH
         F9OdIbRP8TmcJBGJr+F7dcwfOhrpDxEva6fyBVyc2HKww2XypeK6VM4IazH6ZdFeeYy4
         OB+3S4odDoA9OXY4PiFQVrwcHpQGuaiwOm81hug8OFUkRadxVaCWOrA+TKwBr09SA7Ca
         ytXXjHOokMj1fIAilEpIVtg/QltYsD91zB1OY3YeCVVDRDg0Xe9+dKGELqdSidoSVBC8
         RgBDleYG33f7+K+PRC7kkBTjNX+H21Pf8E7nKVpK629JiUEmausl+/QibjQgfU6FcosF
         wCuA==
X-Gm-Message-State: AOJu0YwXo1mrzXlezhk3brHdkK6JftNNLXNNsODjvncxeFpt9wasXSwh
	F30Wji0iNkaNdZ2xZNdMi1Lkjj8IFacPBM+7RcEm8H0OMZMGy61L3NGu
X-Gm-Gg: Acq92OFKaWv0ZfhLicwPm6fbVvMq5AriKsnheDxOROZtZ7uvImhClgIftqhIIOM3obo
	ERwZ+IDGDowVrNJPkfywQjL1oes13x8gp6Qflfml82tyUEx+PUyR9IZnUyvcZo+xZcSS0FDxU+o
	x1oe8n7axKWLxRlh8eaF4ascbXUj+QUoHzmzUNe6IhI0WxkKwy7vDlGKeZjikzQvimAbM3hD8Bm
	XNjl8Yv85je5hjEfO/2MvQk9rkGwW+jTe/rIyd1GDG6pxyxKVqfX/0T5fk7Y6RHAVFGaSXZ1z0l
	9zzFW8qC/y8IcWV/9H8fetU9q1iJGyJYVxTKIheBgwpYIv5+5sl4xQ0NgL92Athz49ZGub4IeWz
	wTN+9uU9moahTkGN3FrE64CdLdip00FwnLGV+NQM8MUHcDmst09TiJ3P+YPQRqW5/isCSdICBT/
	Zhckx/8T3KRspV12xWn6o5cAX7PHKFWGSx6osZRn2uNyP2sYDFBB7AyIH7CDszqEE7x8bzRLPH+
	qV0GsG+SeRhmNCw7P2SqY2GQt7kjoWR2x8rCRN6EpT8UUnX7YGp0+ZhALo8RVUWpw==
X-Received: by 2002:a05:600c:ac8:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-4922014383fmr69298935e9.27.1781468819212;
        Sun, 14 Jun 2026 13:26:59 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f0e:3200:99ef:ffe6:2586:a7de? (p200300ea8f0e320099efffe62586a7de.dip0.t-ipconnect.de. [2003:ea:8f0e:3200:99ef:ffe6:2586:a7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm24280046f8f.32.2026.06.14.13.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 13:26:58 -0700 (PDT)
Message-ID: <04959cda-8631-4346-bbbf-edc444ce242f@gmail.com>
Date: Sun, 14 Jun 2026 22:26:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: migrate Rx path to page_pool
To: atharva-potdar <atharvapotdar07@gmail.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20260614054137.32181-1-atharvapotdar07@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260614054137.32181-1-atharvapotdar07@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,pp_params.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21257682275

On 14.06.2026 07:41, atharva-potdar wrote:
> Replace the driver-managed skb+copy Rx model with page_pool
> zero-copy in preparation for XDP support.
> 
> Key changes:
> - Allocate order-0 pages via page_pool instead of alloc_pages + dma_map
> - Build skbs directly from pages with napi_build_skb (zero-copy)
> - Add rtl8169_rx_refill() to replenish descriptors after processing
> - Track dirty_rx boundary for efficient refill scheduling
> - Cap max_mtu to R8169_RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN
>   (order-0 pages can't support arbitrary jumbo frames)
> 
If I read this correctly, max_mtu may be lower with this patch.
This may cause a regression for existing users.

> Tested on RTL8168h with iperf3 (~470 Mbps, 0 retransmits) and
> 1000 pings (0 drops).
> 
Assuming your link speed is 1Gbps, 470Mbps is quite low.

Did you test also on non-x86 architectures? We had DMA-related regressions
in the past which showed up on certain non-x86 architectures only.

> Signed-off-by: atharva-potdar <atharvapotdar07@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 128 ++++++++++++++--------
>  1 file changed, 85 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa..9d8d678ac 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -31,6 +31,7 @@
>  #include <linux/unaligned.h>
>  #include <net/ip6_checksum.h>
>  #include <net/netdev_queues.h>
> +#include <net/page_pool/helpers.h>
>  #include <net/phy/realtek_phy.h>
>  
>  #include "r8169.h"
> @@ -70,7 +71,9 @@
>  #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
>  
>  #define R8169_REGS_SIZE		256
> -#define R8169_RX_BUF_SIZE	(SZ_16K - 1)
> +#define R8169_RX_HEADROOM	ALIGN(XDP_PACKET_HEADROOM, 8)
> +#define R8169_RX_BUF_SIZE	(PAGE_SIZE - R8169_RX_HEADROOM - \
> +				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> @@ -737,6 +740,7 @@ struct rtl8169_private {
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
>  	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
> +	u32 dirty_rx; /* Index of first Rx descriptor needing a new buffer */
>  	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>  	u32 dirty_tx;
>  	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
> @@ -745,6 +749,8 @@ struct rtl8169_private {
>  	dma_addr_t RxPhyAddr;
>  	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
> +	struct page_pool *page_pool;
> +	u32 rx_buf_sz;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> @@ -4148,37 +4154,27 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>  	return 0;
>  }
>  
> -static void rtl8169_mark_to_asic(struct RxDesc *desc)
> +static void rtl8169_mark_to_asic(struct RxDesc *desc, u32 rx_buf_sz)
>  {
>  	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
>  
>  	desc->opts2 = 0;
>  	/* Force memory writes to complete before releasing descriptor */
>  	dma_wmb();
> -	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | rx_buf_sz));
>  }
>  
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  					  struct RxDesc *desc)
>  {
> -	struct device *d = tp_to_dev(tp);
> -	int node = dev_to_node(d);
> -	dma_addr_t mapping;
>  	struct page *data;
>  
> -	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> +	data = page_pool_dev_alloc_pages(tp->page_pool);
>  	if (!data)
>  		return NULL;
>  
> -	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> -	if (unlikely(dma_mapping_error(d, mapping))) {
> -		netdev_err(tp->dev, "Failed to map RX DMA!\n");
> -		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
> -		return NULL;
> -	}
> -
> -	desc->addr = cpu_to_le64(mapping);
> -	rtl8169_mark_to_asic(desc);
> +	desc->addr = cpu_to_le64(page_pool_get_dma_addr(data) + R8169_RX_HEADROOM);
> +	rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
>  
>  	return data;
>  }
> @@ -4187,15 +4183,17 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
>  {
>  	int i;
>  
> -	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
> -		dma_unmap_page(tp_to_dev(tp),
> -			       le64_to_cpu(tp->RxDescArray[i].addr),
> -			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> -		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
> +	for (i = 0; i < NUM_RX_DESC; i++) {
> +		if (!tp->Rx_databuff[i])
> +			continue;
> +		page_pool_put_full_page(tp->page_pool, tp->Rx_databuff[i], true);
>  		tp->Rx_databuff[i] = NULL;
>  		tp->RxDescArray[i].addr = 0;
>  		tp->RxDescArray[i].opts1 = 0;
>  	}
> +
> +	page_pool_destroy(tp->page_pool);
> +	tp->page_pool = NULL;
>  }
>  
>  static int rtl8169_rx_fill(struct rtl8169_private *tp)
> @@ -4221,11 +4219,28 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
>  
>  static int rtl8169_init_ring(struct rtl8169_private *tp)
>  {
> +	struct page_pool_params pp_params = { 0 };
> +
>  	rtl8169_init_ring_indexes(tp);
> +	tp->dirty_rx = 0;
> +	tp->rx_buf_sz = R8169_RX_BUF_SIZE;
>  
>  	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
>  	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
>  
> +	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +	pp_params.order = 0;
> +	pp_params.pool_size = NUM_RX_DESC;
> +	pp_params.nid = dev_to_node(tp_to_dev(tp));
> +	pp_params.dev = tp_to_dev(tp);
> +	pp_params.dma_dir = DMA_FROM_DEVICE;
> +	pp_params.offset = R8169_RX_HEADROOM;
> +	pp_params.max_len = tp->rx_buf_sz;
> +
> +	tp->page_pool = page_pool_create(&pp_params);
> +	if (IS_ERR(tp->page_pool))
> +		return PTR_ERR(tp->page_pool);
> +
>  	return rtl8169_rx_fill(tp);
>  }
>  
> @@ -4312,7 +4327,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
>  	rtl8169_cleanup(tp);
>  
>  	for (i = 0; i < NUM_RX_DESC; i++)
> -		rtl8169_mark_to_asic(tp->RxDescArray + i);
> +		rtl8169_mark_to_asic(tp->RxDescArray + i, tp->rx_buf_sz);
>  
>  	napi_enable(&tp->napi);
>  	rtl_hw_start(tp);
> @@ -4776,9 +4791,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  	for (count = 0; count < budget; count++, tp->cur_rx++) {
>  		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
>  		struct RxDesc *desc = tp->RxDescArray + entry;
> +		struct page *page;
>  		struct sk_buff *skb;
> -		const void *rx_buf;
> -		dma_addr_t addr;
>  		u32 status;
>  
>  		status = le32_to_cpu(READ_ONCE(desc->opts1));
> @@ -4791,6 +4805,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		 */
>  		dma_rmb();
>  
> +		page = tp->Rx_databuff[entry];
> +		tp->Rx_databuff[entry] = NULL;
> +
>  		if (unlikely(status & RxRES)) {
>  			if (net_ratelimit())
>  				netdev_warn(dev, "Rx ERROR. status = %08x\n",
> @@ -4802,9 +4819,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  				dev->stats.rx_crc_errors++;
>  
>  			if (!(dev->features & NETIF_F_RXALL))
> -				goto release_descriptor;
> +				goto recycle;
>  			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> -				goto release_descriptor;
> +				goto recycle;
>  		}
>  
>  		pkt_size = status & GENMASK(13, 0);
> @@ -4817,24 +4834,23 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (unlikely(rtl8169_fragmented_frame(status))) {
>  			dev->stats.rx_dropped++;
>  			dev->stats.rx_length_errors++;
> -			goto release_descriptor;
> +			goto recycle;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> +		dma_sync_single_for_cpu(d,
> +					page_pool_get_dma_addr(page) +
> +					R8169_RX_HEADROOM,
> +					pkt_size, DMA_FROM_DEVICE);
> +
> +		skb = napi_build_skb(page_address(page), PAGE_SIZE);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
> -			goto release_descriptor;
> +			goto recycle;
>  		}
>  
> -		addr = le64_to_cpu(desc->addr);
> -		rx_buf = page_address(tp->Rx_databuff[entry]);
> -
> -		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
> -		prefetch(rx_buf);
> -		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
> -		skb->tail += pkt_size;
> -		skb->len = pkt_size;
> -		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
> +		skb_reserve(skb, R8169_RX_HEADROOM);
> +		skb_put(skb, pkt_size);
> +		skb_mark_for_recycle(skb);
>  
>  		rtl8169_rx_csum(skb, status);
>  		skb->protocol = eth_type_trans(skb, dev);
> @@ -4847,13 +4863,34 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		napi_gro_receive(&tp->napi, skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
> -release_descriptor:
> -		rtl8169_mark_to_asic(desc);
> +
> +		continue;
> +
> +recycle:
> +		page_pool_put_full_page(tp->page_pool, page, true);
>  	}
>  
>  	return count;
>  }
>  
> +static void rtl8169_rx_refill(struct rtl8169_private *tp)
> +{
> +	u32 dirty_rx = tp->dirty_rx;
> +
> +	while (dirty_rx != tp->cur_rx) {
> +		u32 entry = dirty_rx % NUM_RX_DESC;
> +
> +		if (!tp->Rx_databuff[entry]) {
> +			tp->Rx_databuff[entry] = rtl8169_alloc_rx_data(tp,
> +								       tp->RxDescArray + entry);
> +			if (!tp->Rx_databuff[entry])
> +				break;
> +		}
> +		dirty_rx++;
> +	}
> +	tp->dirty_rx = dirty_rx;
> +}
> +
>  static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
>  	struct rtl8169_private *tp = dev_instance;
> @@ -4921,6 +4958,7 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  	rtl_tx(dev, tp, budget);
>  
>  	work_done = rtl_rx(dev, tp, budget);
> +	rtl8169_rx_refill(tp);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done))
>  		rtl_irq_enable(tp);
> @@ -5775,8 +5813,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  
>  	jumbo_max = rtl_jumbo_max(tp);
> -	if (jumbo_max)
> -		dev->max_mtu = jumbo_max;
> +	if (jumbo_max) {
> +		unsigned int page_pool_mtu;
> +
> +		page_pool_mtu = R8169_RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
> +		dev->max_mtu = min_t(int, jumbo_max, page_pool_mtu);
> +	}
>  
>  	rtl_set_irq_mask(tp);
>  
> @@ -5808,7 +5850,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	if (jumbo_max)
>  		netdev_info(dev, "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
> -			    jumbo_max, tp->mac_version <= RTL_GIGA_MAC_VER_06 ?
> +			    dev->max_mtu, tp->mac_version <= RTL_GIGA_MAC_VER_06 ?
>  			    "ok" : "ko");
>  
>  	if (tp->dash_type != RTL_DASH_NONE) {


