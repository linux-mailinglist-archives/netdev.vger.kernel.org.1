Return-Path: <netdev+bounces-119690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01A95698A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0F72813E4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81611667C7;
	Mon, 19 Aug 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCgO72Y9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9282142900;
	Mon, 19 Aug 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067769; cv=none; b=PVthiVSv7Aoz1F4OEKIzwiT7KCvMzFq/vf4XINVAPww149i3U2DMHigYUsSF+tU6bgaSWHLXSj8Dz5zc4FpIRhzTOohDH983jp05PCLx0x99aRMNy3f59CGUqeD7DvfMGC6MxPJw+PJ4ydYXQ2nX5ZI6P5NZDdVpOtnA0mcuxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067769; c=relaxed/simple;
	bh=Gy+DICQJXZTweU/a67MRigBETvV0Yf56AR/zrbKPj3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u72rDXgPFgZNS7czRo0cV+RY4r+EgIPKMZI65AxTX/Vfiyg0F/skerNXiiag64xlcPDOAfuZ9QMNzAeHR2YSs+moJFOCBC0IO/3gfrn9uNmcmShYD4Ij0io30oi/DOtndS2WRimL8/h/QOuLW0EjUya8Xu2M5/VPcXROsDK+9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCgO72Y9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3719896b7c8so1564204f8f.3;
        Mon, 19 Aug 2024 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724067766; x=1724672566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MO3Bgs9Dy2a9RAD8UjB1CU4gKYO/Woxp4kWSfJ4CEcc=;
        b=WCgO72Y9IV0bbl4se6LYH1nwGS/gVDoDy05alRAmsbQtIbOOWL5Y3ylQQnotW0vqsl
         SqZc6XsPlqBunkb8PT1y1qEE+/qKinWoYtSPwUEYNAZZJJ8tft9Lff7gRZdPjAruH/Or
         AdisGH8oCi3QJP5AbG/1dWY93sChj1sDCuSs13dBLYqj19O2n2XZAvsx3c7ni33vgjk9
         67n4GpRjp3sgNWRCuv/t7oCiGYQXdCIN2spiZIsCtETQxH7lfdpYjLWQy9YECwcwJpFn
         zjIv0G9I//IfBK92uRyUwLweH1/TACeMT/A9y9yhPeZ+eW4S2YbYZtZjqMQVsE3KvhPJ
         FMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067766; x=1724672566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO3Bgs9Dy2a9RAD8UjB1CU4gKYO/Woxp4kWSfJ4CEcc=;
        b=fhwkmwYrw2/criFaS3M4z1/YU8gpKuSknitiCiw9nyTpp9Y4QdSTkmiblHRmk8cU69
         TPLGp7NRcyK/YoHGShWLMwaaDp0L/DyG0bIpsOmwtmaiz8yhiVMsEISXU0fw5uWpQ+nS
         yCRHwP5btUI81tuDFC1PmIFuogTBq41uVg73fKPy4CWp47r5Q3UqUGjpDI1sFxNQHnGP
         bZw9SMR+ZPsxm1l2q/23Pk0gl7rJjHaptiuqbJeWPTkBA0aXE9qTfoNQUHZFV1x3wdtx
         we2Kz3ocFPb0cp8Ib92h8CaF1O3wQELnrddJgNtV+0EoLck5Vj8MZXsCyOODX/tAYXaq
         4BfA==
X-Forwarded-Encrypted: i=1; AJvYcCXkl2jCCRnW+OGCbaWoLytc9vx+zImohY2bXfSTIjHQzWlCNmLvAPg+e9/vSSuJhGMzr4FmVzB2tt+DchqdzKtI+ec9aoxR4Qy5lCJWfVFABa95KmuENurTDR5HRz3YL0K3xEw1
X-Gm-Message-State: AOJu0YynVLpZoPLeQ2bRSbpIsJQsiIxPRVxKXLMffuJeeGUKYN8sKfos
	UhIksC90H4mI1XRmQDoO4TnmEnztWhEM7/IE8JwycCtmVS0+RnqB
X-Google-Smtp-Source: AGHT+IEL53gDLjuRZcqGEa/kN5yhO0fwxMEnDdHkMbcEE+bMHmvUJLjzmajFixcoI15UC2irOx6iCg==
X-Received: by 2002:adf:e88e:0:b0:36b:d21e:bf85 with SMTP id ffacd0b85a97d-371a7477a4bmr4403906f8f.51.1724067765493;
        Mon, 19 Aug 2024 04:42:45 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37195650163sm8280650f8f.98.2024.08.19.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:42:44 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:42:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v3 6/7] net: stmmac: support fp parameter of
 tc-taprio
Message-ID: <20240819114242.2m6okk7bq64e437c@skbuf>
References: <cover.1724051326.git.0x1207@gmail.com>
 <cover.1724051326.git.0x1207@gmail.com>
 <28f3b68dd0e0744e851a0b9d90fdee69792fbc0f.1724051326.git.0x1207@gmail.com>
 <28f3b68dd0e0744e851a0b9d90fdee69792fbc0f.1724051326.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f3b68dd0e0744e851a0b9d90fdee69792fbc0f.1724051326.git.0x1207@gmail.com>
 <28f3b68dd0e0744e851a0b9d90fdee69792fbc0f.1724051326.git.0x1207@gmail.com>

On Mon, Aug 19, 2024 at 03:25:19PM +0800, Furong Xu wrote:
> tc-taprio can select whether traffic classes are express or preemptible.
> 
> 0) tc qdisc add dev eth1 parent root handle 100 taprio \
>         num_tc 4 \
>         map 0 1 2 3 2 2 2 2 2 2 2 2 2 2 2 3 \
>         queues 1@0 1@1 1@2 1@3 \
>         base-time 1000000000 \
>         sched-entry S 03 10000000 \
>         sched-entry S 0e 10000000 \
>         flags 0x2 fp P E E E
> 
> 1) After some traffic tests, MAC merge layer statistics are all good.
> 
> Local device:
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 17837,
>             "MACMergeHoldCount": 18639
>         }
>     } ]
> 
> Remote device:
> [ {
>         "ifname": "end1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 17189,
>             "MACMergeFragCountRx": 17837,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Tested on DWMAC CORE 5.10a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index a967c6f01e4e..05b870b35947 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -933,7 +933,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
> -	bool fpe = false;
>  	int i, ret = 0;
>  	u64 ctr;
>  
> @@ -1018,16 +1017,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  		switch (qopt->entries[i].command) {
>  		case TC_TAPRIO_CMD_SET_GATES:
> -			if (fpe)
> -				return -EINVAL;
>  			break;
>  		case TC_TAPRIO_CMD_SET_AND_HOLD:
>  			gates |= BIT(0);
> -			fpe = true;
>  			break;
>  		case TC_TAPRIO_CMD_SET_AND_RELEASE:
>  			gates &= ~BIT(0);
> -			fpe = true;
>  			break;
>  		default:
>  			return -EOPNOTSUPP;
> @@ -1058,7 +1053,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> -	if (fpe && !priv->dma_cap.fpesel) {
> +	if (qopt->mqprio.preemptible_tcs && !priv->dma_cap.fpesel) {
>  		mutex_unlock(&priv->est_lock);
>  		return -EOPNOTSUPP;
>  	}

This condition is dealt with by the core, now.

	if (have_preemption && !ethtool_dev_mm_supported(dev)) {
		NL_SET_ERR_MSG(extack, "Device does not support preemption");
		return -EOPNOTSUPP;
	}

where ethtool_dev_mm_supported() is implemented by issuing a get_mm()
command and seeing what it returns. There's a check for priv->dma_cap.fpesel
there already.

> @@ -1071,6 +1066,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		goto disable;
>  	}
>  
> +	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, qopt->mqprio.extack,
> +				       qopt->mqprio.preemptible_tcs);
> +
>  	netdev_info(priv->dev, "configured EST\n");
>  
>  	return 0;
> @@ -1089,11 +1087,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		mutex_unlock(&priv->est_lock);
>  	}
>  
> -	stmmac_fpe_configure(priv, priv->ioaddr,
> -			     &priv->fpe_cfg,
> -			     priv->plat->tx_queues_to_use,
> -			     priv->plat->rx_queues_to_use,
> -			     false, false);
> +	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, qopt->mqprio.extack, 0);
> +
>  	netdev_info(priv->dev, "disabled FPE\n");
>  
>  	return ret;
> -- 
> 2.34.1
> 


