Return-Path: <netdev+bounces-145089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F69C9572
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEEF1F21A90
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F01B0F38;
	Thu, 14 Nov 2024 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P0WaCcqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B71AF0DA
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624855; cv=none; b=EuzhLtZQOPbYw4Np1g3n2NWyJP3Oqn2r8vkl7BK7bvtYqe6LMVAmLf9p8r4u65IKPSaPT7nvLSAwdOzYT3S2x3SrOrrVLjUQ3lipv1c0XuLW8uSbE+1lwB7Yl5NA6dutQ6lzhYjnw52lAkt/B4Ch5+FVl2q1vnQCaPoRsPJjwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624855; c=relaxed/simple;
	bh=LIHR4LGL7WwbNGUgFVhMm5bNuDIIq4hOUw8N7u3EQGU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAHaXjXmDGefPrN4ttMfN75rHBk3jBbNbgQ96QXscb9Ig/u1i3PQyOTn6YFoZnGM/04iTEnkREbjPpdvaU50bLjc4IvGcfGO8K6mRvf4j8kEsyh2kK9+tG2ko16RLuGywt0FIafEZuRdqggPtcMbp9xS3AzUkgB9VLl6tmZefTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P0WaCcqa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46094b68e30so7614161cf.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731624852; x=1732229652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YUtLBE3rs6mKFaFy7Jyfyl6IxV4Rw+eaYKaFp2EllY=;
        b=P0WaCcqaL36kebd4PSUseQzvE6op2t6UqMbbfWSETw8LYKWtGRYrjooZm+Jv1Jvxx/
         FGHzjf8Udsws4KbifM9uC/OfQAU91Xipw2pgmzxtklB/ErEprRtZfRgmh5tfMLi3EKYz
         N3nMyKPoUKpmtySnGyGxwMzG10vm6kuUayWXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624852; x=1732229652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YUtLBE3rs6mKFaFy7Jyfyl6IxV4Rw+eaYKaFp2EllY=;
        b=YSct5CCfUqbDqaz9VjoBnvsXcekDPt+Ya59Wg/OSLtTIAtNLpBJt9WJvq3YdecqvSV
         iPcyW/Mwo8QqiPkZEfcOX032pUT+uEjDexrkMAeNQdfmoSY262P3MXVvEcDgTxKkZvaf
         e4A+0z7ACPfG92cJc1/ojB8e96J2MIfpxQS5aMUDwBDwoiemFFz7hfBMKxoFFbeBNmFU
         F1IGse1xm5+B59OD2QFEP1gkDnnCRSSDSZMVboe6FPOjeNYvAKf8jUr9ZPpAl8xr9VO3
         byjftntkF/VNF+ygVNeYpa0Q/ysYqq2+CriXRAp/+PFvAqCmUWU3nPMIwJl+72uDNDmf
         kI8A==
X-Forwarded-Encrypted: i=1; AJvYcCXTU/f7ZqvJ2bIwFh6eTzX1+ICfz0a2L6JofQEMZ7dVGvSepUT3Z+B2oUdLqm4Kb6um8PPzfLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xs+w+25kvAoWm6ba5jHT14AW8kc+iYp1AdJ5EpICYIvpsXe7
	hiFd+TJU9uVqt+NfNTBd9rGbRIMnFuMN9N5Ip31hvAdrFsLIhn1UkC0NZIOS9g==
X-Google-Smtp-Source: AGHT+IHByLHlbnjvYndU8j3N1EN8B62U5lQIgP9aNg+s3Kq06rymLLR5mxYj5voF8xrR006xrW0YUQ==
X-Received: by 2002:a05:622a:4d4b:b0:460:9d81:4bc8 with SMTP id d75a77b69052e-46363e941c6mr7332131cf.42.1731624852097;
        Thu, 14 Nov 2024 14:54:12 -0800 (PST)
Received: from JRM7P7Q02P ([136.56.190.61])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab24f9fsm11362001cf.62.2024.11.14.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:54:10 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 14 Nov 2024 17:54:07 -0500
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, almasrymina@google.com,
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
	andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	dw@davidwei.uk, sdf@fomichev.me, asml.silence@gmail.com,
	brett.creeley@amd.com, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org,
	jdamato@fastly.com, aleksander.lobakin@intel.com,
	kaiyuanz@google.com, willemb@google.com, daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v5 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <ZzZ_jzoX2nrqY8Ux@JRM7P7Q02P>
References: <20241113173222.372128-1-ap420073@gmail.com>
 <20241113173222.372128-2-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113173222.372128-2-ap420073@gmail.com>

On Wed, Nov 13, 2024 at 05:32:15PM +0000, Taehee Yoo wrote:
> The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> userspace. Only the default value(256) has worked.
> This patch makes the bnxt_en driver support following command.
> `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> `ethtool --get-tunable <devname> rx-copybreak`.
> 
> By this patch, hds_threshol is set to the rx-copybreak value.
> But it will be set by `ethtool -G eth0 header-data-split-thresh N`
> in the next patch.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Tested-by: Andy Gospodarek <gospo@broadcom.com>

> ---
> 
> v5:
>  - Do not set HDS if XDP is attached.
>  - rx_size and pkt_size are always bigger than 256.
> 
> v4:
>  - Remove min rx-copybreak value.
>  - Add Review tag from Brett.
>  - Add Test tag from Stanislav.
> 
> v3:
>  - Update copybreak value after closing nic and before opening nic when
>    the device is running.
> 
> v2:
>  - Define max/vim rx_copybreak value.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 ++++++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++++-
>  3 files changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 4c1302a8f72d..d521b8918c02 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -81,7 +81,6 @@ MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
>  
>  #define BNXT_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
>  #define BNXT_RX_DMA_OFFSET NET_SKB_PAD
> -#define BNXT_RX_COPY_THRESH 256
>  
>  #define BNXT_TX_PUSH_THRESH 164
>  
> @@ -1328,13 +1327,13 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi, u8 *data,
>  	if (!skb)
>  		return NULL;
>  
> -	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copy_thresh,
> +	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copybreak,
>  				bp->rx_dir);
>  
>  	memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
>  	       len + NET_IP_ALIGN);
>  
> -	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copy_thresh,
> +	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
>  				   bp->rx_dir);
>  
>  	skb_put(skb, len);
> @@ -1827,7 +1826,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
>  		return NULL;
>  	}
>  
> -	if (len <= bp->rx_copy_thresh) {
> +	if (len <= bp->rx_copybreak) {
>  		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
>  		if (!skb) {
>  			bnxt_abort_tpa(cpr, idx, agg_bufs);
> @@ -2161,7 +2160,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  		}
>  	}
>  
> -	if (len <= bp->rx_copy_thresh) {
> +	if (len <= bp->rx_copybreak) {
>  		if (!xdp_active)
>  			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
>  		else
> @@ -4452,6 +4451,11 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
>  		bp->flags |= BNXT_FLAG_GRO;
>  }
>  
> +static void bnxt_init_ring_params(struct bnxt *bp)
> +{
> +	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
> +}
> +
>  /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
>   * be set on entry.
>   */
> @@ -4466,7 +4470,6 @@ void bnxt_set_ring_params(struct bnxt *bp)
>  	rx_space = rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) +
>  		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	bp->rx_copy_thresh = BNXT_RX_COPY_THRESH;
>  	ring_size = bp->rx_ring_size;
>  	bp->rx_agg_ring_size = 0;
>  	bp->rx_agg_nr_pages = 0;
> @@ -4511,7 +4514,9 @@ void bnxt_set_ring_params(struct bnxt *bp)
>  				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
>  				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		} else {
> -			rx_size = SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH + NET_IP_ALIGN);
> +			rx_size = SKB_DATA_ALIGN(max(BNXT_DEFAULT_RX_COPYBREAK,
> +						     bp->rx_copybreak) +
> +						 NET_IP_ALIGN);
>  			rx_space = rx_size + NET_SKB_PAD +
>  				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		}
> @@ -6417,16 +6422,14 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  
>  	req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
>  	req->enables = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID);
> +	req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
>  
> -	if (BNXT_RX_PAGE_MODE(bp)) {
> -		req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
> -	} else {
> +	if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RINGS)) {
>  		req->flags |= cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4 |
>  					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>  		req->enables |=
>  			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> -		req->jumbo_thresh = cpu_to_le16(bp->rx_copy_thresh);
> -		req->hds_threshold = cpu_to_le16(bp->rx_copy_thresh);
> +		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
>  	}
>  	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>  	return hwrm_req_send(bp, req);
> @@ -15872,6 +15875,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	bnxt_init_l2_fltr_tbl(bp);
>  	bnxt_set_rx_skb_mode(bp, false);
>  	bnxt_set_tpa_flags(bp);
> +	bnxt_init_ring_params(bp);
>  	bnxt_set_ring_params(bp);
>  	bnxt_rdma_aux_device_init(bp);
>  	rc = bnxt_set_dflt_rings(bp, true);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 649955fa3e37..d1eef880eec5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -34,6 +34,9 @@
>  #include <linux/firmware/broadcom/tee_bnxt_fw.h>
>  #endif
>  
> +#define BNXT_DEFAULT_RX_COPYBREAK 256
> +#define BNXT_MAX_RX_COPYBREAK 1024
> +
>  extern struct list_head bnxt_block_cb_list;
>  
>  struct page_pool;
> @@ -2300,7 +2303,7 @@ struct bnxt {
>  	enum dma_data_direction	rx_dir;
>  	u32			rx_ring_size;
>  	u32			rx_agg_ring_size;
> -	u32			rx_copy_thresh;
> +	u32			rx_copybreak;
>  	u32			rx_ring_mask;
>  	u32			rx_agg_ring_mask;
>  	int			rx_nr_pages;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index cfd2c65b1c90..adf30d1f738f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4318,6 +4318,50 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
>  	return 0;
>  }
>  
> +static int bnxt_set_tunable(struct net_device *dev,
> +			    const struct ethtool_tunable *tuna,
> +			    const void *data)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +	u32 rx_copybreak;
> +
> +	switch (tuna->id) {
> +	case ETHTOOL_RX_COPYBREAK:
> +		rx_copybreak = *(u32 *)data;
> +		if (rx_copybreak > BNXT_MAX_RX_COPYBREAK)
> +			return -ERANGE;
> +		if (rx_copybreak != bp->rx_copybreak) {
> +			if (netif_running(dev)) {
> +				bnxt_close_nic(bp, false, false);
> +				bp->rx_copybreak = rx_copybreak;
> +				bnxt_set_ring_params(bp);
> +				bnxt_open_nic(bp, false, false);
> +			} else {
> +				bp->rx_copybreak = rx_copybreak;
> +			}
> +		}
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int bnxt_get_tunable(struct net_device *dev,
> +			    const struct ethtool_tunable *tuna, void *data)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +
> +	switch (tuna->id) {
> +	case ETHTOOL_RX_COPYBREAK:
> +		*(u32 *)data = bp->rx_copybreak;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static int bnxt_read_sfp_module_eeprom_info(struct bnxt *bp, u16 i2c_addr,
>  					    u16 page_number, u8 bank,
>  					    u16 start_addr, u16 data_length,
> @@ -4768,7 +4812,8 @@ static int bnxt_run_loopback(struct bnxt *bp)
>  	cpr = &rxr->bnapi->cp_ring;
>  	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
>  		cpr = rxr->rx_cpr;
> -	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
> +	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_DEFAULT_RX_COPYBREAK,
> +						    bp->rx_copybreak));
>  	skb = netdev_alloc_skb(bp->dev, pkt_size);
>  	if (!skb)
>  		return -ENOMEM;
> @@ -5341,6 +5386,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
>  	.get_link_ext_stats	= bnxt_get_link_ext_stats,
>  	.get_eee		= bnxt_get_eee,
>  	.set_eee		= bnxt_set_eee,
> +	.get_tunable		= bnxt_get_tunable,
> +	.set_tunable		= bnxt_set_tunable,
>  	.get_module_info	= bnxt_get_module_info,
>  	.get_module_eeprom	= bnxt_get_module_eeprom,
>  	.get_module_eeprom_by_page = bnxt_get_module_eeprom_by_page,
> -- 
> 2.34.1
> 

