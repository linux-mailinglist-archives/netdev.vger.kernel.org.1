Return-Path: <netdev+bounces-258243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB9QIblRjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:54:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA412304E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBB0D3008E2F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB935DCFC;
	Wed, 11 Feb 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuwWeAcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878F352958
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803387; cv=none; b=NK2n4SUgaJgNE6o1wFBr/t3OBPSf71d9LmxWpuzFZGkbg9s9Pj6zjUQs4HQkYv8B5yEKae6SesTc1uy40FS6yX8+ntzSBRLn1LLdHXInZa/mjJ5hLlMwx2oWznY26lnSLT9cEs3dl55pA9gZL5u4WYR5QeamW7V8alQ1oXAUwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803387; c=relaxed/simple;
	bh=is6F9YWzj5cLLqecwe4EGSIbvR/To03p4cw1opS9LXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxtlANVFwp0jKaXXxovoZq/j9ihJHuuaznYac5RYrzTBXyw2OZ/DTq6YAmX7rUwZQS5g6PCa3j7orykzvQe94T7fE4sbdfd/Jj9LMTQ8QCZ6+dOZfMP3aTjhZG2p5lzx6/oHww7c0xAml9nVHm4Ej8tLtmR74TrObJIz199uAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuwWeAcm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-436356740e6so4351562f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770803384; x=1771408184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQC1lhyVCL73nrMJZVZ2qEc1D6TozGhb74GLuzPmgog=;
        b=KuwWeAcmwrIf5OcUgTTGPJJpsFdjSpF+qgz0GRQ/eW/awKxdPVRK6Y3DFpkiy+boJa
         zs1/DM9kChQkL5MVank6vI+KTdHL65yvCcutv7zIUHgWG01/hcyJpJky49NdJ0GEBneA
         L+DuKQtyEFvEA0JrIGULQSch0T9lASt+7d+jESbRDu+xuYVjNEQszUtyzNFgaDpMEe2+
         2f2c2pM7hH2ItidBLwzgy3A9dyDVFhJ0dw3Mg18DRuBpVXoipYJSBXAUw3qS7jWC4l4h
         nJJKzEcC03kgrgSjI+GvTnFuutzYXFUdCGIw8y41d01ywqNb1QvbNB3pH9N1PEsfrEuL
         sR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803384; x=1771408184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQC1lhyVCL73nrMJZVZ2qEc1D6TozGhb74GLuzPmgog=;
        b=JKaZ+fmKo+D348Dy0Gae//dISKJzboxFKs+Y/eYA/k0KDn5a5m07GAMr12aP97ixrQ
         x+904tqfQs1dGAhaQDArjoi8LLB1Y5iQhvKAK4tLif61sLPjgCLGqauQfxhNKcB6o/O5
         bBRFfg9s4gy6AD8eOcmbK/VMqh4lskPU1Z5av5WsXIall2PvjVGcOQbdpa5b1Fq15LCb
         gqZGteOS6kYAv5k7hHAvJfw43OTvhWb3TxhOdqxyS8OZxPpVLm6aOe9BgoN2vvG+T1CM
         2zYYMKw7jV+innDQFe9vSVQkk6HH03hHIPwp+/3CFpRogLyyivl/dYxdBsyxZ+Q86X9s
         +pHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW78YhjBRhfK17RQzkloY7PHs/e1KozhK4t0SIZuBd9gfjAeiS59VHNcv1ZZdcHSKq8JNYCR20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZytCQIhU1S2J1iDO71mgLHEryLLbSbIC619+aQEpkOjSY9cE
	xl0rjrb3fkW/eUqEWppi9rAonNYrySCrhZlOIw9/XeUyaLtKP9tG9IlMXTrVFg==
X-Gm-Gg: AZuq6aK1dWcDijZOOceNUFfit9RPIBw54hU6aEdJinRAKExW/wo/yuj3F99SIFm2IEl
	+XhlRiSWvgGDYE2DlePJPdaFgNOvLFb4c4pVFjtPLOozjKDtpCjy7HRFdjw4Ctua60qlz7LOKUu
	EVD4YJcZdb9bJfGKu6CpzYTD9CbG2Eku45hW0fKuwvv1hArPghM4kvRrT/sGp0YLqmB4ipFYOAd
	LYUwdlVPGMDxALMU4zq65vIO3QIa3H/fDInVFdAOCwTaDlXKADyJ1oFrOgyGvmghHGiHkF2zX8r
	JvpM+Ajo56TqZeRqeCHFIwAU5q1baOgISC6jMCxMC6n9z0Cr3z7rOOSWODM4HA2Q6JA6x+XE2+0
	3IRnSlYQUsL4i2jocTvya2z+QkKFVgPjI5L7AzrOaTsZJ3Le67iXpuVYsZrVwxnS9bqc6Qsi8zo
	UDAsw/F6N26r+LjVOceGrcZdisFbk0KxWxcbyMcIr3LF4=
X-Received: by 2002:a5d:5d87:0:b0:435:9223:bfda with SMTP id ffacd0b85a97d-43782c24fe4mr2863950f8f.21.1770803383767;
        Wed, 11 Feb 2026 01:49:43 -0800 (PST)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e3cacesm3634785f8f.31.2026.02.11.01.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:49:43 -0800 (PST)
Message-ID: <b108212c-99c8-4f02-9e61-3564e544eab3@gmail.com>
Date: Wed, 11 Feb 2026 11:49:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 5/5] eth: mlx5: Move pause storm errors to
 pause stats
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux@armlinux.org.uk, mbloch@nvidia.com, o.rempel@pengutronix.de,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 vadim.fedorenko@linux.dev
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
 <20260207010525.3808842-6-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260207010525.3808842-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258243-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CAA412304E
X-Rspamd-Action: no action



On 07/02/2026 3:05, Mohsin Bashir wrote:
> Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
> the ethtool_pause_stats struct. This counter tracks pause storm error
> events which indicate the NIC has been sending pause frames for an
> extended period due to a stall.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>   .../ethernet/mellanox/mlx5/core/en_stats.c    | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index a8af84fc9763..2fe779c164e4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -916,6 +916,23 @@ static int mlx5e_stats_get_ieee(struct mlx5_core_dev *mdev,
>   				    sz, MLX5_REG_PPCNT, 0, 0);
>   }
>   
> +static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
> +				    u32 *ppcnt_per_prio)
> +{
> +	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
> +	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
> +
> +	if (!(MLX5_CAP_PCAM_FEATURE(mdev, pfcc_mask) &&
> +	      MLX5_CAP_DEBUG(mdev, stall_detect)))
> +		return -EOPNOTSUPP;
> +
> +	MLX5_SET(ppcnt_reg, in, local_port, 1);
> +	MLX5_SET(ppcnt_reg, in, grp, MLX5_PER_PRIORITY_COUNTERS_GROUP);
> +	MLX5_SET(ppcnt_reg, in, prio_tc, 0);

No interest in all other non-0 prios?

> +	return mlx5_core_access_reg(mdev, in, sz, ppcnt_per_prio, sz,
> +				    MLX5_REG_PPCNT, 0, 0);
> +}
> +
>   void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
>   			   struct ethtool_pause_stats *pause_stats)
>   {
> @@ -933,6 +950,14 @@ void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
>   		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
>   				      eth_802_3_cntrs_grp_data_layout,
>   				      a_pause_mac_ctrl_frames_received);
> +
> +	if (mlx5e_stats_get_per_prio(mdev, ppcnt_ieee_802_3))
> +		return;
> +
> +	pause_stats->tx_pause_storm_events =
> +		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
> +				      eth_per_prio_grp_data_layout,
> +				      device_stall_critical_watermark_cnt);
>   }
>   
>   void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,


