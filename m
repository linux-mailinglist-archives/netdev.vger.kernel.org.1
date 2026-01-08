Return-Path: <netdev+bounces-248030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D362D0238C
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B6D8305C43F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D540B6F0;
	Thu,  8 Jan 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPb2vrHu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqao1VeV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48C3EFD11
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867003; cv=none; b=JzLKqrIL1nJauLsECQzVcasXitSOG3A18/3gsTc5spt4VqSuY3FOZYsFtDvztuSdjWczKLd1baQvoOpVfxi4X4sKYHiAqz/kBbxT4j0IjGBS3djaHvbES/ib5wTfX9uR748irfJsUs6cseK0VvaFE97/CiodohG0M1eBPyGD660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867003; c=relaxed/simple;
	bh=ORqcGiDWnbGMcdNMjlxt276QmQHGNQ6nRO84ZHYwsW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lh3LOJQ77KqgJHKNrwGFFJGsYpvrE4xYc3mkN3GcSk0cFVFp4A9yDi9eyrElkVobb94us1JJyQ5VBFxUzcrlfZ101z1QoUbI7gDss1KesEPw5QBX22/UcOr4QSoAuPW4ZVQswGGFlMD7veFcx+wFad640L8ciajbLxVrJTrYdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPb2vrHu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rqao1VeV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767866998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InSMkyEy1m7AWwToQTOv1fSBR4IiczdqH0r4ArpPmIU=;
	b=aPb2vrHu6DDBLBphpryThgJfIa+4u1MSTWnCoblik2fJk0hZ4NNJfQJ09LqVsLgN/tUUTV
	GIpAptrILbSu6FtYOTdGzFqpIzVLBt74HtFE2WNSvSjtuccUIxIyzLeiKbXMKGzo8BeK4k
	yf7IBfIGeeQBHtsPS6dMGMlj9EGL7Lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-SFoy51e9Pe-H1gLzetNWrw-1; Thu, 08 Jan 2026 05:09:57 -0500
X-MC-Unique: SFoy51e9Pe-H1gLzetNWrw-1
X-Mimecast-MFC-AGG-ID: SFoy51e9Pe-H1gLzetNWrw_1767866996
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43284f60a8aso1850874f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767866996; x=1768471796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InSMkyEy1m7AWwToQTOv1fSBR4IiczdqH0r4ArpPmIU=;
        b=Rqao1VeVAaJQu7MKhFvMzvVYuu+Kwkz4udlJXP+RjPjkQ+N5VKmEh2hxiXsN++lPAo
         kkK6aGbaNXOrGOT1UWP8Z4WIzlS+AbZNnasw+hC/iHE63TFbkEYBV1hspAhIbJrHxROR
         YIh6MYVul/jimB8ZEMmD4dCW4iS0hv7Kn5Vz3G+45awULSmZgFMg3w2dx726aTe7OSbd
         ffvlnZaYib/rHu+3nia8EhPuR+p2KzUHCosq+tr/TBeE4aqL7vzIWJAM5qvrheN8Gn1P
         l0FvKAB6QhGb5M6qdUY3Ts83uG3tzpbRcHDsqj2CTjGXNCl7JfPNEfHT7f26hEUeYSJl
         WA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866996; x=1768471796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InSMkyEy1m7AWwToQTOv1fSBR4IiczdqH0r4ArpPmIU=;
        b=rPidLw8pLgB74gZXxDhG/4sixjN5DFDFpmX0g1u3MvkTA92XyRDORc0Ng0Tns9pyVA
         tOITMi7+ZYZRC6ZqyoQQSEIKLL2ok4N1JAZyKyS2wC6fxSyTa1ugeGD+jPsG/vFTNDMH
         JjAcOCBxqA9bs3sIC7Zm4FsQnfLP2TnT9HPJuNs41pSNdcX4ucO5HVfqIvFmggEBQJgf
         BF1Lgh2Pnnbmj75WKtc0r7FYLD9oitLXzsS7XKE45yQcr0AwoflbZEjaCOSlUnydTDuU
         P0TPR6MXDn5tGN22hxugi5dEfvo/ZYjq7MgUZT0aH7bMNxVYaKxYkp79+5LR3//qeida
         cxhA==
X-Gm-Message-State: AOJu0Yx/mG4EE/vLZefxGOUFh/9NVAqGKxGI5Eu3EABdEMpYK+KKO4rd
	E0lv0XMp+YXMAuI2zrr/eevADNORKU6wFz1cBCmmCWmIdIxFR300IFHVdgoiz6qub/8a+3dbdiC
	4cGuzQBD7YBMfiTKtM4vz2B94xYDliPGNQozRd5UvM9jhojGJZEeKRbAeYA==
X-Gm-Gg: AY/fxX431eoPAK/E1bf0xrKllPOuQI1Uv4khzF/n6UhoQMxXd5eQMfxD2LkyWYWraLy
	XmFqI1xwchsfLFxrUVWDpdtQh1CrMCwcIFEdh7mr3W4bF6K8J6F0GI5nIfeSwkHYkragN43ySWY
	vdEMgLo6w+ktA91D2Bqctd6FhHC6BG2jVCyIyYMFKT0xRWaOGKL9i4xwmSBHNcungDemqXcq3rL
	1l+T/qCwICixE47ZV8ei1TnsSbi7sdpKdbt2tkteKz4h7bzVDgKbhoMd2xKCuDyc7C9ucBTXJaJ
	q26iZpp3Zh/c4AkQWgcSbeV20lzzePcsU+1PvuVB9mUm6kiKNZTZBKZrjfzh+QUkhcDOYPMVBsG
	xehkjiffIYygkTw==
X-Received: by 2002:a5d:5f55:0:b0:431:8ec:9372 with SMTP id ffacd0b85a97d-432c377421amr5839042f8f.55.1767866995731;
        Thu, 08 Jan 2026 02:09:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsdCaT3Ms/qWwPYFNdE67s1BUECKILhv9mQqVH6xO7pPALo6mjaBw59eTmPIryI1uAyI162w==
X-Received: by 2002:a5d:5f55:0:b0:431:8ec:9372 with SMTP id ffacd0b85a97d-432c377421amr5839009f8f.55.1767866995203;
        Thu, 08 Jan 2026 02:09:55 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm15969515f8f.8.2026.01.08.02.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:09:54 -0800 (PST)
Message-ID: <81fe0e2e-5f05-4258-b722-7a09e6d99182@redhat.com>
Date: Thu, 8 Jan 2026 11:09:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4, net-next 4/7] bng_en: Add TX support
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-5-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260105072143.19447-5-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> +static void __bnge_tx_int(struct bnge_net *bn, struct bnge_tx_ring_info *txr,
> +			  int budget)
> +{
> +	u16 hw_cons = txr->tx_hw_cons;
> +	struct bnge_dev *bd = bn->bd;
> +	unsigned int tx_bytes = 0;
> +	unsigned int tx_pkts = 0;
> +	struct netdev_queue *txq;
> +	u16 cons = txr->tx_cons;
> +	skb_frag_t *frag;
> +
> +	txq = netdev_get_tx_queue(bn->netdev, txr->txq_index);
> +
> +	while (RING_TX(bn, cons) != hw_cons) {
> +		struct bnge_sw_tx_bd *tx_buf;
> +		struct sk_buff *skb;
> +		int j, last;
> +
> +		tx_buf = &txr->tx_buf_ring[RING_TX(bn, cons)];
> +		skb = tx_buf->skb;
> +		if (unlikely(!skb)) {
> +			bnge_sched_reset_txr(bn, txr, cons);
> +			return;
> +		}
> +
> +		cons = NEXT_TX(cons);
> +		tx_pkts++;
> +		tx_bytes += skb->len;
> +		tx_buf->skb = NULL;
> +
> +		dma_unmap_single(bd->dev, dma_unmap_addr(tx_buf, mapping),
> +				 skb_headlen(skb), DMA_TO_DEVICE);
> +		last = tx_buf->nr_frags;
> +
> +		for (j = 0; j < last; j++) {
> +			frag = &skb_shinfo(skb)->frags[j];
> +			cons = NEXT_TX(cons);
> +			tx_buf = &txr->tx_buf_ring[RING_TX(bn, cons)];
> +			netmem_dma_unmap_page_attrs(bd->dev,
> +						    dma_unmap_addr(tx_buf,
> +								   mapping),
> +						    skb_frag_size(frag),
> +						    DMA_TO_DEVICE, 0);
> +		}

There is a similar chunk in bnge_free_tx_skbs(), you could avoid
douplication factoring that out in common helper.

> +
> +		cons = NEXT_TX(cons);
> +
> +		napi_consume_skb(skb, budget);
> +	}
> +
> +	WRITE_ONCE(txr->tx_cons, cons);
> +
> +	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
> +				   bnge_tx_avail(bn, txr), bn->tx_wake_thresh,
> +				   (READ_ONCE(txr->dev_state) ==
> +				    BNGE_DEV_STATE_CLOSING));
> +}
> +
> +static void bnge_tx_int(struct bnge_net *bn, struct bnge_napi *bnapi,
> +			int budget)
> +{
> +	struct bnge_tx_ring_info *txr;
> +	int i;
> +
> +	bnge_for_each_napi_tx(i, bnapi, txr) {
> +		if (txr->tx_hw_cons != RING_TX(bn, txr->tx_cons))
> +			__bnge_tx_int(bn, txr, budget);

The above looks strange to me: there are multiple tx ring, but they are
all served by the same irq?!?

> +	}
> +
> +	bnapi->events &= ~BNGE_TX_CMP_EVENT;
> +}
> +
>  static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
>  				  int budget)
>  {
>  	struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
>  
> +	if ((bnapi->events & BNGE_TX_CMP_EVENT) && !bnapi->tx_fault)
> +		bnge_tx_int(bn, bnapi, budget);
> +
>  	if ((bnapi->events & BNGE_RX_EVENT)) {
>  		bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
>  		bnapi->events &= ~BNGE_RX_EVENT;
> @@ -456,9 +548,26 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
>  		cmp_type = TX_CMP_TYPE(txcmp);
>  		if (cmp_type == CMP_TYPE_TX_L2_CMP ||
>  		    cmp_type == CMP_TYPE_TX_L2_COAL_CMP) {
> -			/*
> -			 * Tx Compl Processng
> -			 */
> +			u32 opaque = txcmp->tx_cmp_opaque;
> +			struct bnge_tx_ring_info *txr;
> +			u16 tx_freed;
> +
> +			txr = bnapi->tx_ring[TX_OPAQUE_RING(opaque)];
> +			event |= BNGE_TX_CMP_EVENT;
> +			if (cmp_type == CMP_TYPE_TX_L2_COAL_CMP)
> +				txr->tx_hw_cons = TX_CMP_SQ_CONS_IDX(txcmp);
> +			else
> +				txr->tx_hw_cons = TX_OPAQUE_PROD(bn, opaque);
> +			tx_freed = ((txr->tx_hw_cons - txr->tx_cons) &
> +				    bn->tx_ring_mask);
> +			/* return full budget so NAPI will complete. */
> +			if (unlikely(tx_freed >= bn->tx_wake_thresh)) {
> +				rx_pkts = budget;
> +				raw_cons = NEXT_RAW_CMP(raw_cons);
> +				if (budget)
> +					cpr->has_more_work = 1;
> +				break;
> +			}
>  		} else if (cmp_type >= CMP_TYPE_RX_L2_CMP &&
>  			   cmp_type <= CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
>  			if (likely(budget))
> @@ -613,3 +722,277 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
>  poll_done:
>  	return work_done;
>  }
> +
> +static u16 bnge_xmit_get_cfa_action(struct sk_buff *skb)
> +{
> +	struct metadata_dst *md_dst = skb_metadata_dst(skb);
> +
> +	if (!md_dst || md_dst->type != METADATA_HW_PORT_MUX)
> +		return 0;
> +
> +	return md_dst->u.port_info.port_id;
> +}
> +
> +static const u16 bnge_lhint_arr[] = {
> +	TX_BD_FLAGS_LHINT_512_AND_SMALLER,
> +	TX_BD_FLAGS_LHINT_512_TO_1023,
> +	TX_BD_FLAGS_LHINT_1024_TO_2047,
> +	TX_BD_FLAGS_LHINT_1024_TO_2047,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> +};
> +
> +static void bnge_txr_db_kick(struct bnge_net *bn, struct bnge_tx_ring_info *txr,
> +			     u16 prod)
> +{
> +	/* Sync BD data before updating doorbell */
> +	wmb();
> +	bnge_db_write(bn->bd, &txr->tx_db, prod);
> +	txr->kick_pending = 0;
> +}
> +
> +netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_tx_ring_info *txr;
> +	struct bnge_dev *bd = bn->bd;
> +	unsigned int length, pad = 0;
> +	struct bnge_sw_tx_bd *tx_buf;
> +	struct tx_bd *txbd, *txbd0;
> +	struct netdev_queue *txq;
> +	struct tx_bd_ext *txbd1;
> +	u16 prod, last_frag;
> +	dma_addr_t mapping;
> +	__le32 lflags = 0;
> +	skb_frag_t *frag;
> +	int i;
> +
> +	i = skb_get_queue_mapping(skb);
> +	if (unlikely(i >= bd->tx_nr_rings)) {

Under which conditions the above statement can be true?

> +		dev_kfree_skb_any(skb);
> +		dev_core_stats_tx_dropped_inc(dev);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	txq = netdev_get_tx_queue(dev, i);
> +	txr = &bn->tx_ring[bn->tx_ring_map[i]];
> +	prod = txr->tx_prod;
> +
> +#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
> +	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {

You should probably implement ndo_features_check() and ensure the above
condition will never happen.

> +		netdev_warn_once(dev, "SKB has too many (%d) fragments, max supported is %d.  SKB will be linearized.\n",
> +				 skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS);
> +		if (skb_linearize(skb)) {
> +			dev_kfree_skb_any(skb);
> +			dev_core_stats_tx_dropped_inc(dev);
> +			return NETDEV_TX_OK;
> +		}
> +	}
> +#endif
> +	free_size = bnge_tx_avail(bn, txr);
> +	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
> +		/* We must have raced with NAPI cleanup */
> +		if (net_ratelimit() && txr->kick_pending)
> +			netif_warn(bn, tx_err, dev,
> +				   "bnge: ring busy w/ flush pending!\n");
> +		if (!netif_txq_try_stop(txq, bnge_tx_avail(bn, txr),
> +					bn->tx_wake_thresh))
> +			return NETDEV_TX_BUSY;
> +	}
> +
> +	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
> +		goto tx_free;
> +
> +	length = skb->len;
> +	len = skb_headlen(skb);
> +	last_frag = skb_shinfo(skb)->nr_frags;
> +
> +	txbd = &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
> +
> +	tx_buf = &txr->tx_buf_ring[RING_TX(bn, prod)];

The naming (TX_RING() vs RING_TX() with quite different meaning) is IMHO
prone to errors.

> +	tx_buf->skb = skb;
> +	tx_buf->nr_frags = last_frag;
> +
> +	vlan_tag_flags = 0;
> +	cfa_action = bnge_xmit_get_cfa_action(skb);
> +	if (skb_vlan_tag_present(skb)) {
> +		vlan_tag_flags = TX_BD_CFA_META_KEY_VLAN |
> +				 skb_vlan_tag_get(skb);
> +		/* Currently supports 8021Q, 8021AD vlan offloads
> +		 * QINQ1, QINQ2, QINQ3 vlan headers are deprecated
> +		 */
> +		if (skb->vlan_proto == htons(ETH_P_8021Q))
> +			vlan_tag_flags |= 1 << TX_BD_CFA_META_TPID_SHIFT;
> +	}
> +
> +	if (unlikely(skb->no_fcs))
> +		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
> +
> +	if (length < BNGE_MIN_PKT_SIZE) {
> +		pad = BNGE_MIN_PKT_SIZE - length;
> +		if (skb_pad(skb, pad))
> +			/* SKB already freed. */
> +			goto tx_kick_pending;
> +		length = BNGE_MIN_PKT_SIZE;
> +	}
> +
> +	mapping = dma_map_single(bd->dev, skb->data, len, DMA_TO_DEVICE);
> +
> +	if (unlikely(dma_mapping_error(bd->dev, mapping)))
> +		goto tx_free;
> +
> +	dma_unmap_addr_set(tx_buf, mapping, mapping);
> +	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
> +		TX_BD_CNT(last_frag + 2);
> +
> +	txbd->tx_bd_haddr = cpu_to_le64(mapping);
> +	txbd->tx_bd_opaque = SET_TX_OPAQUE(bn, txr, prod, 2 + last_frag);
> +
> +	prod = NEXT_TX(prod);
> +	txbd1 = (struct tx_bd_ext *)
> +		&txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
> +
> +	txbd1->tx_bd_hsize_lflags = lflags;
> +	if (skb_is_gso(skb)) {
> +		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
> +		u32 hdr_len;
> +
> +		if (skb->encapsulation) {
> +			if (udp_gso)
> +				hdr_len = skb_inner_transport_offset(skb) +
> +					  sizeof(struct udphdr);
> +			else
> +				hdr_len = skb_inner_tcp_all_headers(skb);
> +		} else if (udp_gso) {
> +			hdr_len = skb_transport_offset(skb) +
> +				  sizeof(struct udphdr);
> +		} else {
> +			hdr_len = skb_tcp_all_headers(skb);
> +		}
> +
> +		txbd1->tx_bd_hsize_lflags |= cpu_to_le32(TX_BD_FLAGS_LSO |
> +					TX_BD_FLAGS_T_IPID |
> +					(hdr_len << (TX_BD_HSIZE_SHIFT - 1)));
> +		length = skb_shinfo(skb)->gso_size;
> +		txbd1->tx_bd_mss = cpu_to_le32(length);
> +		length += hdr_len;
> +	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		txbd1->tx_bd_hsize_lflags |=
> +			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
> +		txbd1->tx_bd_mss = 0;
> +	}
> +
> +	length >>= 9;
> +	if (unlikely(length >= ARRAY_SIZE(bnge_lhint_arr))) {

a proper ndo_features_check() should avoid the above check.

/P


