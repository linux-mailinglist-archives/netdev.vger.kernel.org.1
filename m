Return-Path: <netdev+bounces-112641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA05C93A4BA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6984E1F21338
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E28157A7C;
	Tue, 23 Jul 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qCTatXom"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7F14A4C9
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754695; cv=none; b=Ep4gYkLnyYhv/bIZYP4vG2UyuWRHt7BiI2n0u00PO9+ZkVgkL01ASVN/YPMhrBCQMxiMgc/xmEmpoRsvB/mj4lTcF4oFPaWzv/BABVCPctGZMveho6IKBZDzLyyPiTWJx5ZylODECMKl3mnplPKhwBM4/hbDYKAfpKRyMeD2wCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754695; c=relaxed/simple;
	bh=isWGflkoO86SgZH3nmLkfFtT7g7nJqjcDjS/VDDroJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npVmHbyOGekVB1KHCPadNoom0HZOz+HDej1mYNIx1GIu2TtTb6dDidiN/K/ciJTuJNa6UfLUenGOiAhdR0TKLTKjhBojKOw7wt4iwpRbmlFmy/1QMEWb3+mDPpUsdh2ct5HDTu4MUCPj6IIkgiFWjwsg0RuurnTcr3fh8cme1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qCTatXom; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so26988a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721754693; x=1722359493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lbPE0UM3Jrs4ydCsNHNwpK7/1H6fvrGuUR3T5aqgjQ=;
        b=qCTatXomcWrhT71d+Ag2BbyduM46bOfs3X/QLugKUL+34Ye9cIKxq3ni5dOtlvf+PD
         pezzWmKLAtJ8Tu6uhuUkAhhckj6d3CDoSMOZS5K3VxOuc9h4vq6t3dI8LKmCUmrmbu5i
         d2W6yCzY6A9NDfcNbmt4qFixwpg47YeL7b4+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754693; x=1722359493;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lbPE0UM3Jrs4ydCsNHNwpK7/1H6fvrGuUR3T5aqgjQ=;
        b=jQQDK4lJqMyUWa4672u7RZfd41K1RXpn8oZXlR5I87AIjaV0T6Vzw2ZbrPNY90/gq2
         g/unc+J0y1nokYRcnexZ650knwqdOXdG1a3z+iX7D8qDvOrosTia9Xs/n7z06y+OMVzF
         x+la5CEwfRfcSzJtaAmmYZXGEc9eNZmDN82Me4DJvHsE2Rh9dexUrwb6Hl/a7k9XTOoC
         91i/dxJsn2BiS5fCOKJ9WlOwPunzoQcDnXZ1A/cep6dXzSxon7uQPmt9xYoYSKnCoGUg
         UWUcb0LxrrLrVl+GqIom4lKPl+DcXk0Gi0Oomd5GSMcsq0JcDjiHcfp3+u/LE12bhSOx
         XY+A==
X-Forwarded-Encrypted: i=1; AJvYcCUP5pdf7lniE5+g/NW6opSX7t6lOnEdGNrjo8LhVrDdRw039rS18CitBm4JmhdN/3elxYWFVI8IY0ChuESGBnDxJ3HtmnS6
X-Gm-Message-State: AOJu0YwkhZwy38xVn6/WNFRYt5aru5Kqyj4+n79TuR902Pr1zn3GuQlV
	sPnLu1UjYSnmst+grK4S/n5A4FAKY/+gYyHh0DLHHJ1V/1ZIALz4DddfkPw6M+c=
X-Google-Smtp-Source: AGHT+IERjQE12AVH/9qhh0rA29w4YYdzDBuRUtXQS1+HbTSvKLuxlXY1F1l06HpgRZuGpGjZgC3M/w==
X-Received: by 2002:a17:90b:4b8e:b0:2c2:d6ca:3960 with SMTP id 98e67ed59e1d1-2cd8d10997dmr4384702a91.17.1721754693040;
        Tue, 23 Jul 2024 10:11:33 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb773045ebsm10516402a91.16.2024.07.23.10.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:11:32 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:11:29 -0700
From: Joe Damato <jdamato@fastly.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Julien Panis <jpanis@baylibre.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, srk@ti.com, vigneshr@ti.com,
	danishanwar@ti.com, pekka Varis <p-varis@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: ethernet: ti: am65-cpsw: Introduce
 multi queue Rx
Message-ID: <Zp_kQX3dj3J1_u6o@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Julien Panis <jpanis@baylibre.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, srk@ti.com, vigneshr@ti.com,
	danishanwar@ti.com, pekka Varis <p-varis@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
References: <20240703-am65-cpsw-multi-rx-v3-0-f11cd860fd72@kernel.org>
 <20240703-am65-cpsw-multi-rx-v3-1-f11cd860fd72@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-am65-cpsw-multi-rx-v3-1-f11cd860fd72@kernel.org>

On Wed, Jul 03, 2024 at 04:51:32PM +0300, Roger Quadros wrote:

[...]

> @@ -699,6 +727,14 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		goto fail_rx;
>  	}
>  
> +	for (i = 0; i < common->rx_ch_num_flows ; i++) {
> +		napi_enable(&common->rx_chns.flows[i].napi_rx);
> +		if (common->rx_chns.flows[i].irq_disabled) {
> +			common->rx_chns.flows[i].irq_disabled = false;

Just a minor nit (not a reason to hold this back): I've been
encouraging folks to use the new netdev-genl APIs in their drivers
to map NAPIs to queues and IRQs if possible because it allows for
more expressive and interesting userland applications.

You may consider in the future using something vaguely like (this is
untested psuedo-code I just typed out):

   netif_napi_set_irq(&common->rx_chns.flows[i].napi_rx,
                      common->rx_chns.flows[i].irq);

and 

   netif_queue_set_napi(common->dev, i, NETDEV_QUEUE_TYPE_RX,
                        &common->rx_chns.flows[i].napi_rx);

To link everything together (note that RTNL must be held while doing
this -- I haven't checked your code path to see if that is true here).

For an example, see 64b62146ba9e ("net/mlx4: link NAPI instances to
queues and IRQs). 

Doing this would allow userland to get data via netlink, which you
can examine yourself by using cli.py like this:

python3 tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/netdev.yaml \
  --dump queue-get

python3 tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/netdev.yaml \
  --dump napi-get

> +			enable_irq(common->rx_chns.flows[i].irq);
> +		}
> +	}
> +
>  	for (tx = 0; tx < common->tx_ch_num; tx++) {
>  		ret = k3_udma_glue_enable_tx_chn(tx_chn[tx].tx_chn);
>  		if (ret) {
> @@ -710,12 +746,6 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		napi_enable(&tx_chn[tx].napi_tx);
>  	}
>  
> -	napi_enable(&common->napi_rx);
> -	if (common->rx_irq_disabled) {
> -		common->rx_irq_disabled = false;
> -		enable_irq(rx_chn->irq);
> -	}
> -
>  	dev_dbg(common->dev, "cpsw_nuss started\n");
>  	return 0;
>  
> @@ -726,11 +756,24 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		tx--;
>  	}
>  
> +	for (flow_idx = 0; i < common->rx_ch_num_flows; flow_idx++) {
> +		flow = &rx_chn->flows[flow_idx];
> +		if (!flow->irq_disabled) {
> +			disable_irq(flow->irq);
> +			flow->irq_disabled = true;
> +		}
> +		napi_disable(&flow->napi_rx);
> +	}
> +
>  	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
>  
>  fail_rx:
> -	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, 0, rx_chn,
> -				  am65_cpsw_nuss_rx_cleanup, 0);
> +	for (i = 0; i < common->rx_ch_num_flows; i--)
> +		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
> +					  am65_cpsw_nuss_rx_cleanup, !!i);
> +
> +	am65_cpsw_destroy_xdp_rxqs(common);
> +
>  	return ret;
>  }
>  
> @@ -779,12 +822,12 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
>  			dev_err(common->dev, "rx teardown timeout\n");
>  	}
>  
> -	napi_disable(&common->napi_rx);
> -	hrtimer_cancel(&common->rx_hrtimer);
> -
> -	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
> -		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
> +	for (i = 0; i < common->rx_ch_num_flows; i++) {
> +		napi_disable(&common->rx_chns.flows[i].napi_rx);

The inverse of the above is probably true somewhere around here;
again a small piece of psuedo code for illustrative purposes:

   netif_queue_set_napi(common->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);

> +		hrtimer_cancel(&common->rx_chns.flows[i].rx_hrtimer);
> +		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
>  					  am65_cpsw_nuss_rx_cleanup, !!i);
> +	}
>  
>  	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
>  

