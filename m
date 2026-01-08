Return-Path: <netdev+bounces-248023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF23D04621
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876433456530
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C2337BA1;
	Thu,  8 Jan 2026 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbzR4bJX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5mNlI2i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22123D2FE1
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865540; cv=none; b=bdHGdtri5KUyCk3qfGn6xeY2agiv61u3fp4laCphHGrRfNi+f7XJhxtZNWeVL5olUfmMGO8IQTRq9fF4pGSF/3Uh3tsAq7bpJL1tTUk5sCfromsioDvitz9EAjO58psbNZcQalt03163sFyzHwvX5PIPJ06tF7/FydtmN7PL0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865540; c=relaxed/simple;
	bh=9NNn2g+m8mrfCDb6ev0dF8+BqSQCya9RPVaGJiFpcH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHM25MMgEkSnqBs7ov+P0GhBCOxBx6hZy7E2BHJQ18ElamABbeLm6a00FsVpujMU8HjjHkqI+tY2WduWmJAYWh24d56vS6sibA6HGn0b697c1iS5QZdnxpg6W33/JvlHbh0pvwYRnmQOGbDGZSNKF0aH0RPrInaPhEOFlqOoC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbzR4bJX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5mNlI2i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767865529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3pd0yyWHrqq5g9oB7NslaocuC698B4UCeS18BEmIZM=;
	b=WbzR4bJXXLChVPjrLUKWEB9rH3mT1dkUPYvBHonS3k+9M4TJJKAayBLa5GxxB8ldfdExBs
	O+gnoqcNYR0HDubZXAxYq/8/fM2sQ2uUlVCD/kKF364hbQ449Ura9QvUnaMok13ZUoFhMx
	qioMvEr/VJ7yBdBpputPAbqWklV7o0E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-f9-j07k-ORmexOWrhuIUsQ-1; Thu, 08 Jan 2026 04:45:28 -0500
X-MC-Unique: f9-j07k-ORmexOWrhuIUsQ-1
X-Mimecast-MFC-AGG-ID: f9-j07k-ORmexOWrhuIUsQ_1767865527
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso1959866f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767865527; x=1768470327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3pd0yyWHrqq5g9oB7NslaocuC698B4UCeS18BEmIZM=;
        b=g5mNlI2iQVeMVTO1gexZfVDlX+01qq9G0256t//HYRTQUFop0yBXmE+Hl8PQai+ZRh
         MPEXcvO1N27iNFkE4NFpXazHIGJ48vm7xXi5Jjc21cYLfOGcFpoa8PeuMYrx2ilQ2/+p
         TGHhSmP0rjZmVYOsSJNWmWmAvpnrgF74/eOi/QusNoWIdzOCde/yYMhvltjrXdKWI5iy
         2dr9uskf4OWZRm6YzGyBeggh+uXlVvc6oiHygbKRI4souOFG2cm5+5kAAvQAtPIvN3/5
         WWFgQITzPV4JV6zrTzcCLEvl1lFOJeu+bgSwNUkv7QVfiiMme8s8+Q7Cdyl1KhNFv1m6
         LtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865527; x=1768470327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3pd0yyWHrqq5g9oB7NslaocuC698B4UCeS18BEmIZM=;
        b=Zh5zF9dvwgsNPNuovhLjc51wZ9RrvwRkg2Ou79w/Nh/z9TSvT4k/OpMNwBMhw9oK3M
         LWXruu88rd1cPajBO4IxIYujnftUHV8iNBqUGg53KpU/szOJ0/FE4wrqeH77Bs0LtW6I
         /oOmMWAJJFgm/xodYhhxOJpNRR/LJuhPJdGLOGD+0OYRCkhIzIrVr16klB4uFcENOUjS
         CLrtPO02QSE2SjnTuoaWOr60iyo0yZ3rr3+oshuL8hdqrOUWzkhGm3Maz6oiEvq0UmJD
         SmiDwsVQLUPzr0ZzLkV4CnjRtvVdeeMre3tyOi2I4wT/1ayYDUjxV+HD+5URF6ABo50U
         ys8w==
X-Gm-Message-State: AOJu0YwQS/5hIwjcMOudEvwGUEPWVmyOWTTHjWqNZlrALvKcJOd6ud+n
	wENO7dYquR5Hyv37ItoyvwLkVgDOXr7nuAcBn/mSzKiuiiL/twp33u//VOugUZGJTFaV33B2rOb
	FEDtFYO2TaEbLWL9fBYpqmUJhNtXkgBzyfGArTO76ged4B1GD3w1DBDcskQ==
X-Gm-Gg: AY/fxX77GYO39H2MfMLFHy78ZuFq0c2F7dWtTY7Uqlxw4g+4zjHi6tuy7lhgQSMHoBi
	d1OleoDthO9NLSNNP09JrIMng0kIOY4rAKALxBhmkKuPh9RLR9zFECdkZ0pK6hMjKQCosXD6TH1
	hCsblo3St95jJS6wWHRokJR8vjAsJemfu1iLGy3q1FNSRpqVqoif8wXPcL30Lpz7HoFPTMcgZKQ
	eIzb/xMyq9kak5dPtdjWx2R8yNqPa3xBJ011jtAZb0ry4w7wWzghtemwrBTvS5Cdi3TiOLMNIdI
	i1THoGTRd+px2Q3MYOIcfKaLDtphHhWOluhqj2zWgLS69rvqDIUg0TRi4drfDMDvwy84s6l+XZx
	Kb6cpIxxOjhhaBQ==
X-Received: by 2002:a5d:5f47:0:b0:430:f622:8cca with SMTP id ffacd0b85a97d-432c3775729mr7519851f8f.56.1767865526838;
        Thu, 08 Jan 2026 01:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7v6OqNTZ4kaF4S0a3XVyvAMoaqgmz8oUpSc9d0+MBxwW9XcXvAi/s8JvPyXc8xtEmMYWl+Q==
X-Received: by 2002:a5d:5f47:0:b0:430:f622:8cca with SMTP id ffacd0b85a97d-432c3775729mr7519810f8f.56.1767865526341;
        Thu, 08 Jan 2026 01:45:26 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm15649671f8f.15.2026.01.08.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:45:25 -0800 (PST)
Message-ID: <a3aab7af-3807-4f37-92e0-5ea52df1bd4c@redhat.com>
Date: Thu, 8 Jan 2026 10:45:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260105072143.19447-3-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> new file mode 100644
> index 000000000000..4da4259095fa
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> @@ -0,0 +1,198 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_HW_DEF_H_
> +#define _BNGE_HW_DEF_H_
> +
> +struct tx_bd_ext {
> +	__le32 tx_bd_hsize_lflags;
> +	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)

Please use BIT()

> +	#define TX_BD_FLAGS_IP_CKSUM				(1 << 1)
> +	#define TX_BD_FLAGS_NO_CRC				(1 << 2)
> +	#define TX_BD_FLAGS_STAMP				(1 << 3)
> +	#define TX_BD_FLAGS_T_IP_CHKSUM				(1 << 4)
> +	#define TX_BD_FLAGS_LSO					(1 << 5)
> +	#define TX_BD_FLAGS_IPID_FMT				(1 << 6)
> +	#define TX_BD_FLAGS_T_IPID				(1 << 7)
> +	#define TX_BD_HSIZE					(0xff << 16)
> +	 #define TX_BD_HSIZE_SHIFT				 16

I'm quite suprised checkpatch does not complain, but the above
indentation is IMHO quite messy.

please move the macro definition before the struct and avoid mixing
whitespaces and tabs.

[...]
> @@ -1756,6 +1757,78 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
>  	return rc;
>  }
>  
> +static void bnge_disable_int(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	if (!bn->bnapi)
> +		return;
> +
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
> +		struct bnge_ring_struct *ring = &nqr->ring_struct;

Please respect the reverse christmas tree above.

> +
> +		if (ring->fw_ring_id != INVALID_HW_RING_ID)
> +			bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +	}
> +}
> +
> +static void bnge_disable_int_sync(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	bnge_disable_int(bn);
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		int map_idx = bnge_cp_num_to_irq_num(bn, i);
> +
> +		synchronize_irq(bd->irq_tbl[map_idx].vector);
> +	}
> +}
> +
> +static void bnge_enable_int(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;

Same here
> @@ -298,6 +343,10 @@ struct bnge_cp_ring_info {
>  	u8			cp_idx;
>  	u32			cp_raw_cons;
>  	struct bnge_db_info	cp_db;
> +	u8			had_work_done:1;
> +	u8			has_more_work:1;
> +	u8			had_nqe_notify:1;

Any special reasons to use bitfields here? `bool` will generate better
code, and will not change the struct size.

[...]
> +static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *data,
> +				     unsigned int len, dma_addr_t mapping)
> +{
> +	struct bnge_net *bn = bnapi->bn;
> +	struct bnge_dev *bd = bn->bd;
> +	struct sk_buff *skb;
> +
> +	skb = napi_alloc_skb(&bnapi->napi, len);
> +	if (!skb)
> +		return NULL;
> +
> +	dma_sync_single_for_cpu(bd->dev, mapping, bn->rx_copybreak,
> +				bn->rx_dir);
> +
> +	memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
> +	       len + NET_IP_ALIGN);

This works under the assumption that len <=  bn->rx_copybreak; why
syncing the whole 'rx_copybreak' instead of 'len' ?

> +
> +	dma_sync_single_for_device(bd->dev, mapping, bn->rx_copybreak,
> +				   bn->rx_dir);

Why is the above needed?

> +
> +	skb_put(skb, len);
> +
> +	return skb;
> +}
> +
> +static enum pkt_hash_types bnge_rss_ext_op(struct bnge_net *bn,
> +					   struct rx_cmp *rxcmp)
> +{
> +	u8 ext_op = RX_CMP_V3_HASH_TYPE(bn->bd, rxcmp);
> +
> +	switch (ext_op) {
> +	case EXT_OP_INNER_4:
> +	case EXT_OP_OUTER_4:
> +	case EXT_OP_INNFL_3:
> +	case EXT_OP_OUTFL_3:
> +		return PKT_HASH_TYPE_L4;
> +	default:
> +		return PKT_HASH_TYPE_L3;
> +	}
> +}
> +
> +static struct sk_buff *bnge_rx_vlan(struct sk_buff *skb, u8 cmp_type,
> +				    struct rx_cmp *rxcmp,
> +				    struct rx_cmp_ext *rxcmp1)
> +{
> +	__be16 vlan_proto;
> +	u16 vtag;
> +
> +	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
> +		__le32 flags2 = rxcmp1->rx_cmp_flags2;
> +		u32 meta_data;
> +
> +		if (!(flags2 & cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN)))
> +			return skb;
> +
> +		meta_data = le32_to_cpu(rxcmp1->rx_cmp_meta_data);
> +		vtag = meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
> +		vlan_proto =
> +			htons(meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SFT);
> +		if (eth_type_vlan(vlan_proto))
> +			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
> +		else
> +			goto vlan_err;
> +	} else if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
> +		if (RX_CMP_VLAN_VALID(rxcmp)) {
> +			u32 tpid_sel = RX_CMP_VLAN_TPID_SEL(rxcmp);
> +
> +			if (tpid_sel == RX_CMP_METADATA1_TPID_8021Q)
> +				vlan_proto = htons(ETH_P_8021Q);
> +			else if (tpid_sel == RX_CMP_METADATA1_TPID_8021AD)
> +				vlan_proto = htons(ETH_P_8021AD);
> +			else
> +				goto vlan_err;
> +			vtag = RX_CMP_METADATA0_TCI(rxcmp1);
> +			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
> +		}
> +	}
> +	return skb;
> +
> +vlan_err:
> +	skb_mark_for_recycle(skb);
> +	dev_kfree_skb(skb);
> +	return NULL;
> +}
> +
> +static struct sk_buff *bnge_rx_skb(struct bnge_net *bn,
> +				   struct bnge_rx_ring_info *rxr, u16 cons,
> +				   void *data, u8 *data_ptr,
> +				   dma_addr_t dma_addr,
> +				   unsigned int offset_and_len)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	u16 prod = rxr->rx_prod;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	err = bnge_alloc_rx_data(bn, rxr, prod, GFP_ATOMIC);
> +	if (unlikely(err)) {
> +		bnge_reuse_rx_data(rxr, cons, data);
> +		return NULL;
> +	}
> +
> +	skb = napi_build_skb(data, bn->rx_buf_size);
> +	dma_sync_single_for_cpu(bd->dev, dma_addr, bn->rx_buf_use_size,
> +				bn->rx_dir);

Why you need to sync the whole `rx_buf_use_size` instead of the actual
packet len?

> +	if (!skb) {
> +		page_pool_free_va(rxr->head_pool, data, true);
> +		return NULL;
> +	}
> +
> +	skb_mark_for_recycle(skb);
> +	skb_reserve(skb, bn->rx_offset);
> +	skb_put(skb, offset_and_len & 0xffff);

It's unclear why you pass 2 different values mangled together and than
extract only one of them.

/P


