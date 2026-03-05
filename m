Return-Path: <netdev+bounces-264403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNtyLWKPqWni/gAAu9opvQ
	(envelope-from <netdev+bounces-264403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD100213114
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F4F3042DE0
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266443A6EE9;
	Thu,  5 Mar 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWVeuOIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152D3624B5
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719938; cv=none; b=L2VL4POSIAJKO7yH1M3w/P1JS+BXNfxaZ0+qc0BHzpJbxRVLFXSj70rup4ccDpJocF37zjf8DHjXgeWuQf/jLe9a8QP7ulGvZ6kzMcrDqZqzw25N7I3/xzB23RwDTpPMd97TLCqvKEvFbLzmvCZcTCbjtSQ4I10EAnlvKkcbq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719938; c=relaxed/simple;
	bh=mWUWRxoauzJOOGx1fQb6UZox9B27uD9K39OrpcrXzuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWCe8uS6ZwCMzMYTTaQ7MTKXrzkaAlEFzkikFeJDr9jwUROzZcx/2yWdhZsuSJ+6IpNQRDiLtAXiLcFauiRn8ey2QPxECXTpi35HCC3hawzeXh6SJcfw9Bl1KXIUgh/vRA7BtjCqwyZm4Vs+CvXCjiOhI5MNR6tnIA1VDU2CTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWVeuOIq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439bcec8613so3156677f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719935; x=1773324735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ae8c1J9pdWn7b1F5/jsy8UBNAYMEbo6epboWQWtLHg=;
        b=HWVeuOIqpF0iObb3QPWJLOdeXE3TrRF7H7HLnUM7k+/9qDbTJzkhw1dSyMsos99pSv
         tgzu6lzfoXn7xZKk1EXGqhQcV5Xd/MS3mos2kJocR18UIejtXP4xFTmsTGczVmVtnLtF
         ji5KnVON/C7+g67HsVzYlyDWxnE0HyMWywNQYGncc3TIjbn+wVb+k5EMhmcEiUyz6AkM
         JO4bjG/TKcvG9+nN9KXkbf+9TdVp81t1WwZnU1Sr0atNflul8MMIAtUId3Zbb6DsVQAp
         AprUFqhEDjJ2uWWwFmk8Cec5gPxL+MddNYvwF7znJTKy0ufeZM3psjdsgb0vy+THiPmO
         g3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719935; x=1773324735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ae8c1J9pdWn7b1F5/jsy8UBNAYMEbo6epboWQWtLHg=;
        b=maofHO/E/HCV9LetdiauC8FHSzEANddVNlhX/MNAJV8ZedagnwVBwiEewJdaTo2pHR
         SYPAcPxcIFj3TSwq4266jDwIbsrjVXf/Fg8fS2x/svMjKKdKFRmFctr8rNKntU+s1huY
         4wSJkQGIWLvC3McHzEZbMPK3+Oh9MXzFE5xi6oH8Pu86bHa+dW1bjA5NE1KZBf6eyvs2
         cyAR1Y80k3uUgTpSFdhDuySUXU48Y1XFKSuYSgX716pf86ttfjX+PrzxFif7BGMlOwc7
         j5QhIuMAuj/Ein7Cs4JnYAvNcFP/st2/rGapa40scApj/g+rqGkJQ5Ffky78e4asCPSM
         Mr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXg1VIGVdRaYLPJRqLYYMAQQJkNGaFaD/smV63LeztHW7NpGDM7HZh2TfIFPoPvQkTUe1NDFlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDwMA6mM1MLbJyni8TlFOz2BRx2z1BsIUB1gsG7MFLJtTf+Zi
	Rdi2WJi+nfYl4ekQiGezyojZvQz6isWdgg1xQQxq0ZrNY82VV5dmuQyR
X-Gm-Gg: ATEYQzzpbAPl7gpVoSDcbffVUCF9shNgPmbaUN12UFm6CXkWcs8eEMeW11vVckRJ5Cy
	zA6GdLeLToScO0p8W5/Qb+vCMpg3RhJmPHkha9KVCV9FUMz2hi1ya4NvCl3A+YFtGoI9ALtsD1A
	RQpRA3xaVl2XM+CH740+PeW33crv5HLF5OsIMRXHe3lZaQslY3lgTSZ2iRQ1QbGmEh4bfO/VpIe
	w3cWWlEG+PEGRCnVHpQMo3xXdCEhwhajC5L8gihUQned5AusEQ/CdGLiQK2wBu9FHC2R/Dh2glZ
	EUaLTIs901FsUFO7eXvw4sQZ0xXT4BWH2JH6+dG+1bjSeiuUhGult2fWBAM5jstodyQ6L/FSGeF
	V96emZCd4aXfP/80YrtHNLh1pNj388DO4+bltRUipMBshcwBElHwyfvTDKENqU5y+VWKYUsrjbc
	2QDaW+xQ2Un9mVu1sF5mAokvWBGol0ZW4yTPfgOlu00oTsF7o=
X-Received: by 2002:a05:600c:4e0b:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-4851982e869mr108951345e9.9.1772719934829;
        Thu, 05 Mar 2026 06:12:14 -0800 (PST)
Received: from [10.221.197.238] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae475csm41723335e9.8.2026.03.05.06.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:12:14 -0800 (PST)
Message-ID: <d02ac6b1-7322-49d9-881d-126b3a8d1d17@gmail.com>
Date: Thu, 5 Mar 2026 16:12:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V4 5/5] eth: mlx5: Move pause storm errors to pause
 stats
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, dg573847474@gmail.com,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, kuba@kernel.org,
 lee@trager.us, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux@armlinux.org.uk, mbloch@nvidia.com,
 mike.marciniszyn@gmail.com, o.rempel@pengutronix.de, pabeni@redhat.com,
 saeedm@nvidia.com, tariqt@nvidia.com, vadim.fedorenko@linux.dev
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
 <20260302230149.1580195-6-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260302230149.1580195-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD100213114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 03/03/2026 1:01, Mohsin Bashir wrote:
> Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
> the ethtool_pause_stats struct. This counter tracks pause storm error
> events which indicate the NIC has been sending pause frames for an
> extended period due to a stall.
> 
> The ethtool_pause_stats struct reports these stalls as a single value,
> whereas the device supports tracking them per priority. Aggregate the
> counter across all priority classes to capture stalls on all priorities.
> Note that the stats are fetched from the device for each priority via
> mlx5_core_access_reg().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---

Hi,
Sorry for the delay :/

Overall patch looks better now.
Just one small comment/question.


>   .../ethernet/mellanox/mlx5/core/en_stats.c    | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index a8af84fc9763..1a3ecf073913 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -916,11 +916,30 @@ static int mlx5e_stats_get_ieee(struct mlx5_core_dev *mdev,
>   				    sz, MLX5_REG_PPCNT, 0, 0);
>   }
>   
> +static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
> +				    u32 *ppcnt_per_prio, int prio)
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
> +	MLX5_SET(ppcnt_reg, in, prio_tc, prio);
> +	return mlx5_core_access_reg(mdev, in, sz, ppcnt_per_prio, sz,
> +				    MLX5_REG_PPCNT, 0, 0);
> +}
> +
>   void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
>   			   struct ethtool_pause_stats *pause_stats)
>   {
>   	u32 ppcnt_ieee_802_3[MLX5_ST_SZ_DW(ppcnt_reg)];
>   	struct mlx5_core_dev *mdev = priv->mdev;
> +	u64 ps_stats = 0;
> +	int prio;
>   
>   	if (mlx5e_stats_get_ieee(mdev, ppcnt_ieee_802_3))
>   		return;
> @@ -933,6 +952,17 @@ void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
>   		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
>   				      eth_802_3_cntrs_grp_data_layout,
>   				      a_pause_mac_ctrl_frames_received);
> +
> +	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
> +		if (mlx5e_stats_get_per_prio(mdev, ppcnt_ieee_802_3, prio))
> +			return;

If we return here, tx_pause_storm_events remains unset, while 
rx/tx_pause_frames are already assigned.
Is that acceptable? I'm probably fine with it.

> +
> +		ps_stats += MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
> +						  eth_per_prio_grp_data_layout,
> +						  device_stall_critical_watermark_cnt);
> +	}
> +
> +	pause_stats->tx_pause_storm_events = ps_stats;
>   }
>   
>   void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,



