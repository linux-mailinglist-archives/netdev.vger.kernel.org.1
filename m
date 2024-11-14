Return-Path: <netdev+bounces-145091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8189C9575
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2B28368D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163F1B219C;
	Thu, 14 Nov 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ou86nAxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E51ADFEA
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624899; cv=none; b=G0PHTJc6O49qzdBnnKmBo4pYxKpF60Y2dAhZPbeYKjCrcuzkWiFlclp9qamkXHi6mcXQWvEpdPyIqZcZDHAjNy5Af/kTh1AOMwd1Iiv/+GbBKy/NwgE+LiWGNUjfjlxZdPQzi4ctRgmLBPyMimthmnYdJg8TmxLzEm/Kd7L0ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624899; c=relaxed/simple;
	bh=pUIYfIPMV+rqYYHYYrQ9QqFRB4FPvK6acfY0tYp/RLY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwv/f3zkwDHu630X7naFK0c8vjoWCYN5vfA7WQ+9CLtJKlsKaEGEloB9F67kOy/VKbudGAfHLsbi+bysLPOWa7HoD9OgD3dh3+jPOPg9UoGi6hAQLL6YvQYrt+PsCEt9Rr1I5mmm97h6Gm5y/7YzJlD253ymwXW57D4DOynwnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ou86nAxk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211c1c144f5so9898455ad.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731624897; x=1732229697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bj0r1DowSE7Dy2cC6wyg43DGxO4wrZbLso3g2VmRfyg=;
        b=Ou86nAxkhZrSY4SzBEQt3VJtAJQq8TPZ6P/yOguLKaqA4duyU7HLrJxbzRs0vAiPLd
         pwU/WmQDRutxGqMihQngB8bcgTeCPRoKXO0CV8heaq5FYBsWoH9Mbpci4mY7dFdqYlkl
         ZYB2jQjdCJSMfncvxytUVbXAHxVCE158dEvTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624897; x=1732229697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj0r1DowSE7Dy2cC6wyg43DGxO4wrZbLso3g2VmRfyg=;
        b=eUI7RCrZGtVXkzZA6YdIOmZvOI3VtAcfcrQ4ng7EuCN1kXrA5dDpxg+BV0eoknvwDJ
         4HALLQ/PP0eRnsn4vPh9/1XV4AeJmnRdX7flMeDeG8iOMziC1/zdLxI3cw1iUQ6UoCge
         DvpWpjwmgsus5GgQWQ3q7fSkuM+k2DvgRqKpkEHqsosti6N3pzhir4LJViYi9GcgUx+r
         KNIfMs8C4UvB9Lm7OShlQ7TP6PbN4I+2CCFvontnNZjE98IAvITqzXL1ISgXE9lom7QX
         7rSROdCTPO3P92lZE4dYr+AWfOzvH3qVfLCYIxvNTFsAf16mK8cw0nvdD9aOctSGzaIL
         fbqw==
X-Forwarded-Encrypted: i=1; AJvYcCXsKSfrBwHm1vUId1yE6ny1GxA3iQCwwQAC8p2QfgEwYw19xTa4gD8GBtSlgSN3Ks3oJcTtLcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtsSPgAYcbyHmgMpH0dyBVQMe1ae2NigVOglVrbHo8TsCIdhe
	+CAT0qJUSSLEF30JScHEmbL4cGybZGy089nrV3v6fjCAEXo0uFawo1OUfv06cA==
X-Google-Smtp-Source: AGHT+IHnilQgWQPJVeY+qrmOKlLYBqj0hv71H3lzzkLlEXl3i1kWtnei3zIHhlt9toyWjhUR4Kl9Rg==
X-Received: by 2002:a17:902:ce86:b0:20c:cd01:79ae with SMTP id d9443c01a7336-211c0fc12a4mr76195575ad.24.1731624896917;
        Thu, 14 Nov 2024 14:54:56 -0800 (PST)
Received: from JRM7P7Q02P ([136.56.190.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0dfcsm173521b3a.106.2024.11.14.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:54:56 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 14 Nov 2024 17:54:49 -0500
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
Subject: Re: [PATCH net-next v5 5/7] bnxt_en: add support for
 header-data-split-thresh ethtool command
Message-ID: <ZzZ_ub26phtVNmnK@JRM7P7Q02P>
References: <20241113173222.372128-1-ap420073@gmail.com>
 <20241113173222.372128-6-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113173222.372128-6-ap420073@gmail.com>

On Wed, Nov 13, 2024 at 05:32:19PM +0000, Taehee Yoo wrote:
> The bnxt_en driver has configured the hds_threshold value automatically
> when TPA is enabled based on the rx-copybreak default value.
> Now the header-data-split-thresh ethtool command is added, so it adds an
> implementation of header-data-split-thresh option.
> 
> Configuration of the header-data-split-thresh is allowed only when
> the header-data-split is enabled. The default value of
> header-data-split-thresh is 256, which is the default value of
> rx-copybreak, which used to be the hds_thresh value.
> 
>    # Example:
>    # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh 256
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    Header data split thresh:  256
>    Current hardware settings:
>    ...
>    TCP data split:         on
>    Header data split thresh:  256
> 
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Tested-by: Andy Gospodarek <gospo@broadcom.com>

> ---
> 
> v5:
>  - No changes.
> 
> v4:
>  - Reduce hole in struct bnxt.
>  - Add ETHTOOL_RING_USE_HDS_THRS to indicate bnxt_en driver support
>    header-data-split-thresh option.
>  - Add Test tag from Stanislav.
> 
> v3:
>  - Drop validation logic tcp-data-split and tcp-data-split-thresh.
> 
> v2:
>  - Patch added.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 608bcca71676..27d6bac3a69a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4454,6 +4454,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
>  static void bnxt_init_ring_params(struct bnxt *bp)
>  {
>  	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
> +	bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
>  }
>  
>  /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
> @@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>  		req->enables |=
>  			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> -		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
> +		req->hds_threshold = cpu_to_le16(bp->hds_threshold);
>  	}
>  	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>  	return hwrm_req_send(bp, req);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 3a7d2f3ebb2a..058db26fb255 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2362,6 +2362,8 @@ struct bnxt {
>  	u8			q_ids[BNXT_MAX_QUEUE];
>  	u8			max_q;
>  	u8			num_tc;
> +#define BNXT_HDS_THRESHOLD_MAX	256
> +	u16			hds_threshold;
>  
>  	unsigned int		current_interval;
>  #define BNXT_TIMER_INTERVAL	HZ
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index b0054eef389b..a51a4cedecb9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -833,6 +833,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
>  	ering->rx_pending = bp->rx_ring_size;
>  	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
>  	ering->tx_pending = bp->tx_ring_size;
> +
> +	kernel_ering->hds_thresh = bp->hds_threshold;
> +	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
>  }
>  
>  static int bnxt_set_ringparam(struct net_device *dev,
> @@ -868,6 +871,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  	else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
>  		bp->flags &= ~BNXT_FLAG_HDS;
>  
> +	bp->hds_threshold = (u16)kernel_ering->hds_thresh;
>  	bp->rx_ring_size = ering->rx_pending;
>  	bp->tx_ring_size = ering->tx_pending;
>  	bnxt_set_ring_params(bp);
> @@ -5363,7 +5367,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
>  				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>  				     ETHTOOL_COALESCE_USE_CQE,
> -	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> +	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
> +				  ETHTOOL_RING_USE_HDS_THRS,
>  	.get_link_ksettings	= bnxt_get_link_ksettings,
>  	.set_link_ksettings	= bnxt_set_link_ksettings,
>  	.get_fec_stats		= bnxt_get_fec_stats,
> -- 
> 2.34.1
> 

