Return-Path: <netdev+bounces-157250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD89A09B9E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211223A3627
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61AC24B244;
	Fri, 10 Jan 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YdRZssMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D724B221
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536270; cv=none; b=Lru0VHJiy9cVLaffYKBhlNwfE9mCek2e/ebt3yvUO/StM281L0IkBMHgVj5huEHNw6sEDECyJBXp3ZO9dvoVuxVsaaxBvDyb+yOr0vSxWJF+28U2vSvQLi9J0ms8hd+BgV3TUHAtK9r1MLhRM216txQ5YJ0Y62d8AGBN9ITW+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536270; c=relaxed/simple;
	bh=d7LEHL47N6wMK44Ge7jxy/mGaD5w+51wIfWg9yr0EKY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPrxVDuYgLRuV6h1Dp44XMZ4NrJ/kiMjOssRzJ6MEeNLV8JJTdixGrxjE1+wPHMTcJ6XHkFTg98DxbmqLBV9JJl7ZuAJocrQlCQZDKPwD97bx99CmhvIStABdav5royYyFB57HreLZJvTordod94+X7SybIzB5el2jVnFb+TsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YdRZssMI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so34093805ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736536268; x=1737141068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pffu+tm5jud/DZabNUeuJ9zswBLsn5jDxY5xLwnU/fA=;
        b=YdRZssMI9AFUhjsqERCMVVXA2LLyg7RdocTyoQV86tE+VdgcNuh1wEVDaWX44GTKvI
         sE0q9A0x+raffgHIt/SsUp0M0fcvJYUnHx1wMxh+ER9LvGeozvNLCbRAKZlfOyLc9LZK
         hVOLJhmwn59Au8w+kGR/fqRt2lccctnCylxz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536268; x=1737141068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pffu+tm5jud/DZabNUeuJ9zswBLsn5jDxY5xLwnU/fA=;
        b=WO8oGXamLjxXjpNdW26r2R/96wYuxLu5QklFtBzqvtJfgrzEP+hDTe5hTLeeksaL9O
         FwrCBvdUhDwuQCiC2fgVJ7DnCcil+Aiea2XbneP4rx0Jr9s5VMFx7N8dCxGlGMpdSX4B
         pnpjm1A8bPdyIEyIsaTRnTuybVU2fPtIUg88GK/6ZL8mF7c3NwBT7m4l0DqvFCSnRKB/
         TENwIENQobU4CMeub0jviolble1dxt/OS7GL2p99oVPCwdA85DDurNKW2Xwt8Tpdupae
         6MMMgjNvX92AmhWWJk4sqFP10Zs+UK6fAUc3JUIncuvWCwRQ5TauXIdrTYUThMxjBMZV
         6s1A==
X-Forwarded-Encrypted: i=1; AJvYcCVR7rm5RRIlL7qyxpyZpQUPb1A2Og90dgtAVgYcAKUdJteVnxf4DZKXvubI4qg0duYyyODrYCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eoHtvq/5xD5BwkA2mxnylGjrTjLaP2bpMYmZUX3QxY9DTlXM
	PdYj4DhEMZVpIweLlVv7WBUeTnc7Paf1XInrGVrqulycjS3cAsnBqOjZ+3n5bQ==
X-Gm-Gg: ASbGncts7o8M+SrlfirpeRX61zvrsFAF/3lgLeZjRzWNeorWqN6ia434VvIlacSu+1s
	v4Nk2drcmglSX0ru+MCZT5rAkNjQlR4FRMozEcoqfPAkesMy6VcSsTAebnShgydwrs+iGTIk6yf
	ESvbXSi6JpYt9rrbOCxDl2sVtRICAm7tvyX19lmQzu/0x2G4P4RUYnd1bimcjFETWOr3Oicddk6
	ZIyEwYSTJg7ffQ90i0NcQUInS8F/Z56fuFQGZV02i5GRzYVoYv3vUxKixJye8bVpdFs2ildRQWR
	CFeZ8ZbPxmNa9uVhy42S8hFsnCNHdtAfWvhH
X-Google-Smtp-Source: AGHT+IFZTrBX6YA12HWm9OtprwRvH4zewZqUug0b8USQ60djV1GCW+ITnzIWOR5LawlipfSD3fffdA==
X-Received: by 2002:aa7:88cc:0:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72d21f4ac63mr17707306b3a.6.1736536267997;
        Fri, 10 Jan 2025 11:11:07 -0800 (PST)
Received: from JRM7P7Q02P.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a75bsm1922327b3a.66.2025.01.10.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:11:07 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 10 Jan 2025 14:11:00 -0500
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
Subject: Re: [PATCH net-next v7 08/10] bnxt_en: add support for hds-thresh
 ethtool command
Message-ID: <Z4FwxI-HcjcP2SIt@JRM7P7Q02P.dhcp.broadcom.net>
References: <20250103150325.926031-1-ap420073@gmail.com>
 <20250103150325.926031-9-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103150325.926031-9-ap420073@gmail.com>

On Fri, Jan 03, 2025 at 03:03:23PM +0000, Taehee Yoo wrote:
> The bnxt_en driver has configured the hds_threshold value automatically
> when TPA is enabled based on the rx-copybreak default value.
> Now the hds-thresh ethtool command is added, so it adds an
> implementation of hds-thresh option.
> 
> Configuration of the hds-thresh is applied only when
> the tcp-data-split is enabled. The default value of
> hds-thresh is 256, which is the default value of
> rx-copybreak, which used to be the hds_thresh value.
> 
> The maximum hds-thresh is 1023.
> 
>    # Example:
>    # ethtool -G enp14s0f0np0 tcp-data-split on hds-thresh 256
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    HDS thresh:  1023
>    Current hardware settings:
>    ...
>    TCP data split:         on
>    HDS thresh:  256
> 
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Tested-by: Andy Gospodarek <gospo@broadcom.com>

Still looks good.

> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v7:
>  - Use dev->ethtool->hds_thresh instead of bp->hds_thresh
> 
> v6:
>  - HDS_MAX is changed to 1023.
>  - Add Test tag from Andy.
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
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 +++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 7198d05cd27b..df03f218a570 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4603,6 +4603,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
>  static void bnxt_init_ring_params(struct bnxt *bp)
>  {
>  	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
> +	bp->dev->ethtool->hds_thresh = BNXT_DEFAULT_RX_COPYBREAK;
>  }
>  
>  /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
> @@ -6562,6 +6563,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
>  
>  static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  {
> +	u16 hds_thresh = (u16)bp->dev->ethtool->hds_thresh;
>  	struct hwrm_vnic_plcmodes_cfg_input *req;
>  	int rc;
>  
> @@ -6578,7 +6580,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>  		req->enables |=
>  			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> -		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
> +		req->hds_threshold = cpu_to_le16(hds_thresh);
>  	}
>  	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>  	return hwrm_req_send(bp, req);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 7dc06e07bae2..8f481dd9c224 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2779,6 +2779,8 @@ struct bnxt {
>  #define SFF_MODULE_ID_QSFP28			0x11
>  #define BNXT_MAX_PHY_I2C_RESP_SIZE		64
>  
> +#define BNXT_HDS_THRESHOLD_MAX			1023
> +
>  static inline u32 bnxt_tx_avail(struct bnxt *bp,
>  				const struct bnxt_tx_ring_info *txr)
>  {
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 413007190f50..829697bfdab3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -833,6 +833,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
>  	ering->rx_pending = bp->rx_ring_size;
>  	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
>  	ering->tx_pending = bp->tx_ring_size;
> +
> +	kernel_ering->hds_thresh = dev->ethtool->hds_thresh;
> +	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
>  }
>  
>  static int bnxt_set_ringparam(struct net_device *dev,
> @@ -869,6 +872,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  			bp->flags &= ~BNXT_FLAG_HDS;
>  	}
>  
> +	dev->ethtool->hds_thresh = kernel_ering->hds_thresh;
>  	bp->rx_ring_size = ering->rx_pending;
>  	bp->tx_ring_size = ering->tx_pending;
>  	bnxt_set_ring_params(bp);
> @@ -5390,7 +5394,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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

