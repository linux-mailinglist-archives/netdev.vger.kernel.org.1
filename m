Return-Path: <netdev+bounces-190346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9DAB665B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C97AF9F8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CC121A428;
	Wed, 14 May 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M5aD5Yyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91A21518F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212337; cv=none; b=i005ZqNk0pd0LIXhZTeL3BXnV6uJLcjinFxV0TWZ6gdyuRalHopn2bEFZwJ82N9WdO0VXsa4xhSfU7G9KK5XRFUSsbtiEHThKVWgq/jv7mzTdoLA0bO4LaIw04ylaDTcQ/TIxiBFl1s5/bVlVTQgAJfSOtPNT5MUvcRAiTSSSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212337; c=relaxed/simple;
	bh=k+JHv0XVi54wbwq6bEgxtmCxeoEp1UKIWaYdn0D/15o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BkA8E4EqHtmLHTbeLnAo9ooO+cgmLMsgoAOB97lJDSqMEVhLHqylHEZDp2a+dJM22e8blPcLoZUUhTJVDchg3N9BQpAFYzp+BCBiYVPJm2yz7PJERh3+Qxg+ymqT6byVRQjGsjHOR9TjCml4W+ohdyuyZ04wEgWTUe5qJ4SbZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M5aD5Yyr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7423df563d6so5243831b3a.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747212335; x=1747817135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dqfaI6lq6zJ1eRV2oVQK96ezohU415kTZ70pK/0AFE0=;
        b=M5aD5Yyrn8khguH/OUVmWuJtgy1Pf46c4Ud7epDTnCqMnYnHPjbxjq/Wne4khCQlL1
         cyf5xsRWhe1SmDBQvMbErCuZMmn+PqOmcUWP5VX/P+SOcmJT/GJhW0uKoK3SRp3NHRPn
         WeNVhQiS33sUAiGKPcxtP78ApJaGyTtyu5GWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747212335; x=1747817135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqfaI6lq6zJ1eRV2oVQK96ezohU415kTZ70pK/0AFE0=;
        b=ael2cXxFtQN+kZg8F4Wf+9pJTieMT0DCFM+0rJ08K5EzAiWdtiNLQP+/WGanv/HuKk
         RyaPH1c2siyGy1LNqXt2aYIomcN7SX3pVK08c9GT8l0dHeWANH3ddTBEuvIE6ukWvQK8
         TxUsXK5V+1/CVbqC7OKb3DcvU5VCQMuYoBRpT8jFeq0uGcb+Mo0FCMERN+BSoi/vGscl
         LxNzbtaiIIv+DAQwsUtTUwOI3LPzcnbCpT4DnTD2BxbzE81mHzH4CjeRIGwOZC7PiuXi
         MC4BVpyi7Z62TpzLBDkOVLNyJkt+VgZ1g0PmZswWnqnUHsz789P5rftZYWBDWrlNPrX/
         cPZA==
X-Forwarded-Encrypted: i=1; AJvYcCUX8bj20/RQ5NV2S/AA9DMPeO+/zNI/FiUIXlVo5cW2vmx1u7cPyb8Vj4+lRwTYXh2VCn5YZRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/+QUNtLzWVMdZ3m2X/IDgrEZ5v1et4l5rd6xddFr/G2+Z3+J
	HMdIoJkf+Lb6EQrZUj/9MDTFS0cpxEP1dI1xenkw2FG0rjRrDMB/Szt610C9Ow==
X-Gm-Gg: ASbGncv7V2d01xTv2b0vDFUe291CxCRe6dTfcfMTSxdOSjHrAAjRt8JkvJeWpoEU88C
	WZg0SEbOy0rs/if85TTVLWAxW0CG03Um8P5xT0swPpDuCboXh668NF4vQx1iV+rOYSQRYTfoAyn
	uY/SLTR/xVaxc0xOv+aePQNCqthn7TFGM929SjZH8i/GPflN/BY2Nzz+YK9P4qPeY1YXRQaT7SO
	1JnentdpB+hipbBHVehDn/fysBuA4l1cAAnU2A2BYB/e0WN8PrAMuL08jLWqp5z7LRye/ydFnge
	czi9pQ5NhvWt7EUiaWMdHWdTiJgKOyqo2wxPhHLX1NBQHCdPSQwmfNRLI9R7y3QQVk2mQlNKOFt
	c0g==
X-Google-Smtp-Source: AGHT+IHheWBGRMi5B8z6uGT+BiWaum7PrTyN+U6ONEj4/ZVUQsz41yaiHBfuxbJ/bJ1fXa38lNCRjQ==
X-Received: by 2002:a17:903:198b:b0:22e:3b65:9279 with SMTP id d9443c01a7336-23198186ec8mr40757895ad.53.1747212334984;
        Wed, 14 May 2025 01:45:34 -0700 (PDT)
Received: from [10.48.4.8] ([89.207.171.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc764a52bsm94863785ad.59.2025.05.14.01.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 01:45:34 -0700 (PDT)
Message-ID: <b37ea0be-0f37-4a78-b6ce-fc49610c00cc@broadcom.com>
Date: Wed, 14 May 2025 10:45:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: bcmgenet: switch to use 64bit statistics
To: Zak Kemble <zakkemble@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250513144107.1989-1-zakkemble@gmail.com>
 <20250513144107.1989-2-zakkemble@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250513144107.1989-2-zakkemble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/13/2025 4:41 PM, Zak Kemble wrote:
> Update the driver to use ndo_get_stats64, rtnl_link_stats64 and
> u64_stats_t counters for statistics.
> 
> Signed-off-by: Zak Kemble <zakkemble@gmail.com>
> ---

[snip]

>   
> +
> +

This is unrelated to your changes.

>   static void bcmgenet_get_ethtool_stats(struct net_device *dev,
>   				       struct ethtool_stats *stats,
>   				       u64 *data)
>   {
>   	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct u64_stats_sync *syncp;
> +	struct rtnl_link_stats64 stats64;
> +	unsigned int start;
>   	int i;
>   
>   	if (netif_running(dev))
>   		bcmgenet_update_mib_counters(priv);
>   
> -	dev->netdev_ops->ndo_get_stats(dev);
> +	dev_get_stats(dev, &stats64);
>   
>   	for (i = 0; i < BCMGENET_STATS_LEN; i++) {
>   		const struct bcmgenet_stats *s;
>   		char *p;
>   
>   		s = &bcmgenet_gstrings_stats[i];
> -		if (s->type == BCMGENET_STAT_NETDEV)
> -			p = (char *)&dev->stats;
> +		if (s->type == BCMGENET_STAT_RTNL)
> +			p = (char *)&stats64;
>   		else
>   			p = (char *)priv;
>   		p += s->stat_offset;
> -		if (sizeof(unsigned long) != sizeof(u32) &&
> +		if (s->type == BCMGENET_STAT_SOFT64) {
> +			syncp = (struct u64_stats_sync *)(p - s->stat_offset +
> +											  s->syncp_offset);

This is a bit difficult to read, but I understand why you would want to 
do something like this to avoid discerning the rx from the tx stats...

> +			do {
> +				start = u64_stats_fetch_begin(syncp);
> +				data[i] = u64_stats_read((u64_stats_t *)p);
> +			} while (u64_stats_fetch_retry(syncp, start));
> +		} else if (sizeof(unsigned long) != sizeof(u32) &&
>   		    s->stat_sizeof == sizeof(unsigned long))
>   			data[i] = *(unsigned long *)p;

>   		else
> @@ -1857,6 +1881,7 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>   					  struct bcmgenet_tx_ring *ring)
>   {
>   	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bcmgenet_tx_stats64 *stats = &ring->stats64;
>   	unsigned int txbds_processed = 0;
>   	unsigned int bytes_compl = 0;
>   	unsigned int pkts_compl = 0;
> @@ -1896,8 +1921,10 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>   	ring->free_bds += txbds_processed;
>   	ring->c_index = c_index;
>   
> -	ring->packets += pkts_compl;
> -	ring->bytes += bytes_compl;
> +	u64_stats_update_begin(&stats->syncp);
> +	u64_stats_add(&stats->packets, pkts_compl);
> +	u64_stats_add(&stats->bytes, bytes_compl);
> +	u64_stats_update_end(&stats->syncp);
>   
>   	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
>   				  pkts_compl, bytes_compl);
> @@ -1983,9 +2010,11 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
>    * the transmit checksum offsets in the descriptors
>    */
>   static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
> -					struct sk_buff *skb)
> +					struct sk_buff *skb,
> +					struct bcmgenet_tx_ring *ring)
>   {
>   	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bcmgenet_tx_stats64 *stats = &ring->stats64;
>   	struct status_64 *status = NULL;
>   	struct sk_buff *new_skb;
>   	u16 offset;
> @@ -2001,7 +2030,9 @@ static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
>   		if (!new_skb) {
>   			dev_kfree_skb_any(skb);
>   			priv->mib.tx_realloc_tsb_failed++;
> -			dev->stats.tx_dropped++;
> +			u64_stats_update_begin(&stats->syncp);
> +			u64_stats_inc(&stats->dropped);
> +			u64_stats_update_end(&stats->syncp);
>   			return NULL;
>   		}
>   		dev_consume_skb_any(skb);
> @@ -2089,7 +2120,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>   	GENET_CB(skb)->bytes_sent = skb->len;
>   
>   	/* add the Transmit Status Block */
> -	skb = bcmgenet_add_tsb(dev, skb);
> +	skb = bcmgenet_add_tsb(dev, skb, ring);
>   	if (!skb) {
>   		ret = NETDEV_TX_OK;
>   		goto out;
> @@ -2233,6 +2264,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   {
>   	struct bcmgenet_priv *priv = ring->priv;
>   	struct net_device *dev = priv->dev;
> +	struct bcmgenet_rx_stats64 *stats = &ring->stats64;
>   	struct enet_cb *cb;
>   	struct sk_buff *skb;
>   	u32 dma_length_status;
> @@ -2253,7 +2285,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   		   DMA_P_INDEX_DISCARD_CNT_MASK;
>   	if (discards > ring->old_discards) {
>   		discards = discards - ring->old_discards;
> -		ring->errors += discards;
> +		u64_stats_update_begin(&stats->syncp);
> +		u64_stats_add(&stats->errors, discards);
> +		u64_stats_update_end(&stats->syncp);
>   		ring->old_discards += discards;

Cannot you fold the update into a single block?

>   
>   		/* Clear HW register when we reach 75% of maximum 0xFFFF */
> @@ -2279,7 +2313,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   		skb = bcmgenet_rx_refill(priv, cb);
>   
>   		if (unlikely(!skb)) {
> -			ring->dropped++;
> +			u64_stats_update_begin(&stats->syncp);
> +			u64_stats_inc(&stats->dropped);
> +			u64_stats_update_end(&stats->syncp);
>   			goto next;

Similar comment as above, this would be better moved to a single 
location, and this goes on below.
-- 
Florian


