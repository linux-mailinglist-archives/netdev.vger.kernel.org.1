Return-Path: <netdev+bounces-125562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6196DB05
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2F5286B17
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0019DF43;
	Thu,  5 Sep 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q86ju7tx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308519D063;
	Thu,  5 Sep 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544958; cv=none; b=P658F00VvEVZ/4pXNBLBJamHqN6mqAV0dXozScki7a2DUTIJ8RJ54Sf8U58rWJxcQIcIOL5DIMVJWUBhkfstkUkjVbXyobU5zDQEig6D8DKWKKMvl01Ag3CNqtDTfPBGrKrgKSMrkqnkTKP6jxRcSv3+gGxVNgmnVkfMBp7iwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544958; c=relaxed/simple;
	bh=xMQV+8l8+5mTCTXCyFjxEP3OVVJlVV0QUzfCgom1ynA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYUwPa1isAuJQhFToFOjfCQLikSfTjqOSahNyx0dwSdzoAmk/TV2pzDKRtSeYFrWeuuBRJBY0dkcdDE5+wvlCzHSmvqR9BsE5SbRAaXBHaNY5tBn4+izxZ266GAMk5ukcg39/fd0poaYOW+zDcNAeO3hXCOnoLxouJ+IZS9/L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q86ju7tx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5befecad20eso129835a12.2;
        Thu, 05 Sep 2024 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725544955; x=1726149755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yg3+jwU4jsvMwPvd27IzjCRFri5P2daDxYa2vfW+fU=;
        b=Q86ju7txzoIq6pojrQFYeq4DNrHBxTdz/zXMThgSpstPiXj6ipKiqG3zJZ9I+q9QsK
         EZg+/yvc6fCF840cFaKPDpBxx1O8DD2591/w+ehElxoa5yhEjlum1NNEVTddQ8u+X8GU
         rnMASxgZ9PIjGIL2QRRrdJXbswCERZnE2kZFJH85ASzj5mVbkerrsZ8HLkDbdz1iaqZJ
         pur73g8nBY/i8pClSmm/Ab51T1d00vb5a1alkvwICpd8jwhXFHvaho9uOoreVD0eeeq5
         Fq4+Xiy7lcQlkXSH81g83onM7e3G4yLcoUzXcXpVG2jxvCQGQs1Okw9n3tE8oi3b3JPC
         KxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725544955; x=1726149755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yg3+jwU4jsvMwPvd27IzjCRFri5P2daDxYa2vfW+fU=;
        b=dGRrbg+pfH0iNIDFlUQBqy0zmiAA5Gb1vtZ27e8DzLHXDluHFziG+XTbigr2NmgjJY
         Wuv3Ys9n2at9CxUMsnshFauTz3yuVIAR5KFC63ap/U0PDQhUL3KFdpYjGGzFGZp+G+4J
         HGV0nVr1B6RXGQe7HRu1Ra/VmykIIyCM58xuC/RV4tmInr0V+GRJd68VmeYLwQzZcKEg
         BrCVoUILtPdJxNOE77atwLCs3cLXPDZp1UTZNo5bd6V8XiL7JjxGGQPUHszXVe+ot/rx
         dgNsALX7h4bQr4Vav+723pwmalDQdoHdX8TWRDTYB6bmIqWWOwu8I5Bq8l5wGHGRXfuf
         sJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUR3qQGyoWgeywvwSmOc4/5xIbbuNfcgsT3XW6wVoIkOqHYJE3Pf6R8bLQv62f/deVxnvkeKZgCR1fhO2M=@vger.kernel.org, AJvYcCVZjZAFSgEjiP9ojc1TcyPpBvE7Q7UV0rCDSeNNx3TBbn30/w0T1Bp/WNeMUzXa6gqodFDqVFsd@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKylddqWi3nvXrU83tdRtg1e/J8BAugIcAfWJbIruJarKWGpa
	CMsFWXVjWGLzbgGnQWBPEBOW9jatcjd/+DMuN4cPQz1nAoO3jfQe
X-Google-Smtp-Source: AGHT+IFTHXZF/Kygyg2GeFlEexjRun07g46Rg8fnTdbK4URXrkrQG0hN6dN+YvbeF08Vd52ORQadgQ==
X-Received: by 2002:a05:6402:2687:b0:5c3:c42e:d5f2 with SMTP id 4fb4d7f45d1cf-5c3c42edc9cmr2009136a12.1.1725544953626;
        Thu, 05 Sep 2024 07:02:33 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc6a51d1sm1270730a12.89.2024.09.05.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:02:32 -0700 (PDT)
Date: Thu, 5 Sep 2024 17:02:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v8 5/7] net: stmmac: support fp parameter of
 tc-mqprio
Message-ID: <20240905140230.42bdnndi5fn5ifmi@skbuf>
References: <cover.1725518135.git.0x1207@gmail.com>
 <cover.1725518135.git.0x1207@gmail.com>
 <b12e36639ee0cd77f3238fe418af70f975988fc8.1725518136.git.0x1207@gmail.com>
 <b12e36639ee0cd77f3238fe418af70f975988fc8.1725518136.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12e36639ee0cd77f3238fe418af70f975988fc8.1725518136.git.0x1207@gmail.com>
 <b12e36639ee0cd77f3238fe418af70f975988fc8.1725518136.git.0x1207@gmail.com>

On Thu, Sep 05, 2024 at 03:02:26PM +0800, Furong Xu wrote:
> tc-mqprio can select whether traffic classes are express or preemptible.
> 
> After some traffic tests, MAC merge layer statistics are all good.
> 
> Local device:
> ethtool --include-statistics --json --show-mm eth1
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
>             "MACMergeFragCountTx": 35105,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Remote device:
> ethtool --include-statistics --json --show-mm end1
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
>             "MACMergeFrameAssOkCount": 35105,
>             "MACMergeFragCountRx": 35105,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Tested on DWMAC CORE 5.10a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> +int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
> +				    struct netlink_ext_ack *extack, u32 pclass)
> +{
> +	u32 offset, count, val, preemptible_txqs = 0;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	u32 num_tc = ndev->num_tc;
> +
> +	if (!pclass)
> +		goto update_mapping;
> +
> +	/* DWMAC CORE4+ can not program TC:TXQ mapping to hardware.
> +	 *
> +	 * Synopsys Databook:
> +	 * "The number of Tx DMA channels is equal to the number of Tx queues,
> +	 * and is direct one-to-one mapping."
> +	 */
> +	for (u32 tc = 0; tc < num_tc; tc++) {
> +		count = ndev->tc_to_txq[tc].count;
> +		offset = ndev->tc_to_txq[tc].offset;
> +
> +		if (pclass & BIT(tc))
> +			preemptible_txqs |= GENMASK(offset + count - 1, offset);
> +
> +		/* This is 1:1 mapping, go to next TC */
> +		if (count == 1)
> +			continue;
> +
> +		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
> +			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
> +			return -EINVAL;
> +		}
> +
> +		u32 queue_weight = priv->plat->tx_queues_cfg[offset].weight;

Please do not put variable declarations in the middle of the scope.
Declare "u32 queue_weight" separately and just keep the assignment here.

> +
> +		for (u32 i = 1; i < count; i++) {
> +			if (priv->plat->tx_queues_cfg[offset + i].weight !=
> +			    queue_weight) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack, WEIGHT_ERR_MSG,
> +						       queue_weight, tc);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +update_mapping:
> +	val = readl(priv->ioaddr + MTL_FPE_CTRL_STS);
> +	writel(u32_replace_bits(val, preemptible_txqs, DWMAC5_PREEMPTION_CLASS),
> +	       priv->ioaddr + MTL_FPE_CTRL_STS);
> +
> +	return 0;
> +}

Otherwise:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

