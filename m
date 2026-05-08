Return-Path: <netdev+bounces-285725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKf7I+am/Wl0ggAAu9opvQ
	(envelope-from <netdev+bounces-285725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:03:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7454F3FCF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304593022960
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7024386423;
	Fri,  8 May 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Qsovx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384F30FF08
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230953; cv=none; b=kgr5lD0rqk6zpAtoeSj339NSTsYMRPEIkoM6wv7Ch/1jhGKHX1Fjxm8N8pvY22VL3c9GBeHkF0hO3lLYId3DgAiCJuVXAAtzRVgXGzNIT1V3K4N50OdoEKeJNEwqoo/1JlLMEFP+RjOIAbqiCqx2NZqWyyJQ986Ue7C3Tmb+cHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230953; c=relaxed/simple;
	bh=WIPNyT+MJITZgScNy15NlVstSPVx6hRR32XdQhokLmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3Pmdu+YrVGBpi53KmZmACE/UUvi0igoYlWKtGuGrjoa2zpuQ4HogiOC1Z6xvocNaif0NybdikUKLItYEM2c0+kjb20lg5arTX7MWHtWQ6oIutZXFj/IAdBjJPP6IxyLVuo5SWlmitK1i83aM6CTAc7k3kOOBcJN26i6DpaddoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Qsovx+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso19013035e9.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778230949; x=1778835749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlYOG3XzQZlo22JT9TgpdXVisycjOjKnbVWOM2UqaHQ=;
        b=Q7Qsovx+vjB2CNZ4ZmA2+m+ZuI8vwuwxbbdeGJoUUWWBw9hvhSYU6URCEk/d1U4X9e
         Sm9Kx2yekUieIDnw9LLiiQ4U1aGJMhdyZuqDkCr9ZochQvNtTkuwm9pE1LXVGrCmr1TN
         GTPK5fvtZtazkSAzSH5XLMxeyKwaV1TIqcRfCMs2CK0MFJ8dmCbYMumqW2yp1gevmXev
         xOvSutn2JztZ5JFleB1yaGZH0t9ZcUtvhd55sAKsLjyAbxep7tZ2eDw6IWH6yCj4XlIl
         0Spu4x3Eh7OT14OrYzVL2gD5Dk8kKHbueUx1OzsfkNttganF5ZGtaEYPR1rLSm8MkilM
         rCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230949; x=1778835749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlYOG3XzQZlo22JT9TgpdXVisycjOjKnbVWOM2UqaHQ=;
        b=sengFCAi1HXPjhePUjZfidRo3nnU+XwmK2LTnOVJ1yAfNvs+lGFmowKhSlsZvejxiJ
         V7BSN7st5Yjai3dWHUyFTftc4HzkqUHnDNYGXyntSBPH7Hep+ae94QDgHPtnbAtkxqOe
         BrDSCrYcjXfp3pExpziMuuMBW3kq0hZl9VWO1RYis6aIK1rFLbj024QPs2QgUoLiGGfS
         Da0TEdo69XPVsyxWunTEbqIefGra5psRRpifqHrT+SCq1JeKPFIXEl417dXB6+LHaGgT
         v8gRE5d0BPiV5aNHx9Trz5BWVFRHLmuq3cjM9FZlEhHzd7tkrH/7e3C5x9v7HCKASikY
         sZ1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/pGH7kTHT3FHBAONYFe/7/LFRr/WMdMpeblvvauiBSBEK/J+yuDZpraF0tXV4juX5pGsyETGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlvM2HdaEunU3/GRuxveXXuc2FqvuhLXEPqc8dDcmXnkBrv0m
	BVKKExU0uvVpQgcRKOVpzUW2v1VTR+1iof4GG44lGZtB7rL1jm6MRQeE
X-Gm-Gg: AeBDiesD9aeHa4PdFpqRZrMKKoLDhFMRVUte95vn1Xui1vE6vOLzrWjR8KU21I5C1T0
	jTHf7aeGDQFLOCLraEBh3OvEsdr4o4MK/XasEqay3oMVpRDSigyvZEMu/TxTg03BV5YkjZcdRYU
	qpgI28zgC2/FV9zIm8m3z8MLhcaf+QXkrrmwoSmIaJvWEzK+yo+O0PLxfHetGGinxHcQth46/BU
	jCT/s+XpMQy9wvuPpeu26wdXiut22zMZBHWCf7qlAXBRIetwUJigIs50mjRSQalPoOPwAWONtPq
	CpvxAJ1NFhYFW9r7Ty8SvSJ6tkd/ZU0wPP8BhN4QctCPTWt8gatHNAsLRQ6wvdiB+vU5nuLWDyL
	TvN1bkCV+jyuCXcfnxnwRajb9/krk46xRZrO2Dlw+Z5i03dJjUXOZi0hedFfeSmjBk3F8m0NojJ
	BAAZVMcDlsqL0uo3ofm8UnAV+F6z/6tm6cAFdkl97VtboZyc4d4uKCUQDS0FNaJ2BA
X-Received: by 2002:a05:600c:8011:b0:48a:80cb:1bb4 with SMTP id 5b1f17b1804b1-48e51f3b00emr178439985e9.22.1778230948591;
        Fri, 08 May 2026 02:02:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm2842091f8f.29.2026.05.08.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:02:27 -0700 (PDT)
Date: Fri, 8 May 2026 10:02:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 <oss-drivers@corigine.com>, <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
 <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
 <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
 <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
 <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
 <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
 <michael.chan@broadcom.com>, <pabeni@redhat.com>,
 <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
 <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
 <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v12 net-next 2/9] net/mlx5e: trim stack use in PCIe
 congestion threshold helper
Message-ID: <20260508100226.49294dc3@pumpkin>
In-Reply-To: <20260508034912.4082520-3-rkannoth@marvell.com>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
	<20260508034912.4082520-3-rkannoth@marvell.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C7454F3FCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285725-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

On Fri, 8 May 2026 09:19:05 +0530
Ratheesh Kannoth <rkannoth@marvell.com> wrote:

> union devlink_param_value grew when U64 array parameters were added.
> Keeping a four-element array of that union in
> mlx5e_pcie_cong_get_thresh_config() inflated the stack frame past the
> -Wframe-larger-than limit.
> 
> Read each driverinit value into a single reused union, then store the
> four u16 thresholds in struct mlx5e_pcie_cong_thresh field order via a
> temporary u16 pointer to config.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../mellanox/mlx5/core/en/pcie_cong_event.c   | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> index 2eb666a46f39..88e76be3a73d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> @@ -252,28 +252,32 @@ static int
>  mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
>  				  struct mlx5e_pcie_cong_thresh *config)
>  {
> +	enum {
> +		INBOUND_HIGH,
> +		INBOUND_LOW,
> +		OUTBOUND_HIGH,
> +		OUTBOUND_LOW,
> +	};
> +
>  	u32 ids[4] = {

Someone will suggest that should be 'static const'.
It may make the code smaller.

> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
> +		[INBOUND_LOW] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
> +		[INBOUND_HIGH] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
> +		[OUTBOUND_LOW] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
> +		[OUTBOUND_HIGH] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
>  	};
> -	struct devlink *devlink = priv_to_devlink(dev);
> -	union devlink_param_value val[4];
>  
> -	for (int i = 0; i < 4; i++) {
> -		u32 id = ids[i];
> -		int err;
> +	struct devlink *devlink = priv_to_devlink(dev);
> +	union devlink_param_value val;
> +	u16 *dst = (u16 *)config;

You can't do that - far too fragile.
Maybe &config->inbound_low - but even that assumes the values are in order.
A safer way would be using a temporary 'u16 val16[4]'.
(Or even overwrite ids[] with the result.)

But the code might even be smaller if you just unroll the loop:
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW, &val);
	if (err)
		return err;
	config->inbound_low = val.vu16;
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH, &val);
	if (err)
		return err;
	config->inbound_high = val.vu16;
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW, &val);
	if (err)
		return err;
	config->outbound_low = val.vu16;
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH, &val);
	if (err)
		return err;
	config->outbound_high = val.vu16;

-- David


> +	int err;
>  
> -		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
> +	for (int i = 0; i < ARRAY_SIZE(ids); i++) {
> +		err = devl_param_driverinit_value_get(devlink, ids[i], &val);
>  		if (err)
>  			return err;
> -	}
>  
> -	config->inbound_low = val[0].vu16;
> -	config->inbound_high = val[1].vu16;
> -	config->outbound_low = val[2].vu16;
> -	config->outbound_high = val[3].vu16;
> +		dst[i] = val.vu16;
> +	}
>  
>  	return 0;
>  }


