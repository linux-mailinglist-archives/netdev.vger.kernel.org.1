Return-Path: <netdev+bounces-137364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE99A59A3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71264B221C3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79079192D77;
	Mon, 21 Oct 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNAxcD9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACD629;
	Mon, 21 Oct 2024 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487167; cv=none; b=hlg1JQCmxW3b/TMYjCZnRPar5oxyjvbZ9NchWbR/OY8aHxOIqCEWX+Er1Zny2GmAnFcq85utMncHJsbtRc9Ks9AgNxhtR09Pm2jKochLS6Ct2M/G+fx8KhjIzWpyDV1igARs/LdpNjERa4TlLUAkRSRPLwNT5IEGEr5sTfSkJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487167; c=relaxed/simple;
	bh=MgRSmbWGUnNutfhDtyB3M+teZjGQysKDhFqGvpIwpzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWdHY0RscfAOwrJqO1+AxM48R0LTRUTcuUsnCZ7s56iIeOnhUQLBcHOczruEKK1IMnVgsWh+a7ezRiVeNMB1M6dYwZBeTSWHOmFs2aQj0vxjGfIYGmikExWKezQpqoT5HjFCmAQxk6PDrQ3Pc9o3QANam4ZygT7OLw08lOfIH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNAxcD9o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cceb8d8b4so22714145ad.1;
        Sun, 20 Oct 2024 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729487165; x=1730091965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia8mDRf0t3XivCUQZ/+4vX8Trnl04korBJf9mPFCzns=;
        b=RNAxcD9o7CokhfFKsHFvkwListPmP5KySgJvbHlWKW6byTniknv2jnGS012+CQ7ygU
         CLg4MomHGVE3hJkoWArQS8H3ZzeSlslLzDitvV+28o9RWzPXwUvLhRJDlWm9yVEXmXjL
         KahLk5wegdGGqL3jS8ju9Ya9Mnb9tUO/DfUjuxrjgAJn4QVDpGIFV3FxEHrJhqkZxHts
         BA4CV5k/QvEilPILujpAUWWGhs9LDn5RLVBAQC2X2qWiZc0BqiX6Jxji9sZP4Pcp+0CZ
         IsZpReoAFL2EKZ3uYk81vM/naFaHE2VOfZdyf8yRhUmGujcHYiuPkQaIxLWEj8JCiV8e
         dgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729487165; x=1730091965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia8mDRf0t3XivCUQZ/+4vX8Trnl04korBJf9mPFCzns=;
        b=FScn7Vm1iVXc2w4f/FFoGIiEfxLp5bkwwBqxV7xnFI7aikAHdWhFW714JMd3mXBzQn
         ksPjEDpehWH1feqaH3Ov/dPbB8E2onwJZiBL0+P3KBKbR+Wlif0Q6YcSJU+zOHwKn+pF
         zZyol6+hU6rnMYdTwgxrMfgGIBJlyI8CiG/e7HLdu+PHL7794I09n/MQIcCUjxqUjqDX
         c13n7g0sgdmLk02UL3CxdWM7WeWAdUZruHQ3+VNUAGEC+Turg+lNSzUir4RNKo9/VEdJ
         w+4DgZXr3OMqlfQfOVxBi9EbnbO5uKUswC5/pygks0yaAo7KxHPDl0lb/VHeYbfodyYT
         t6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU35rlx6ZsK5Ltp4w1y3c7WCrclhwnVkH0vfe7/ttu4EkPSlYKXooA72b6Jn0Gnt9BdJpfWCTnuQMLxYZQ=@vger.kernel.org, AJvYcCXLNgxVrP59PxKaW3dnG+SitgQbaArOZB23b02FrHLVV+x4o3/EzKNFOcPvokXvAxK16h8dCfzi@vger.kernel.org
X-Gm-Message-State: AOJu0YzEW2HHazzNGJuMQEghJhRl2TP+OrtnIlz6X9QAxdac0pir9hFq
	VuX5wyTDVB014KRso/vh5SqBvrRUQD1p2X799jxyj1ajChGYnEcb
X-Google-Smtp-Source: AGHT+IFduHHYOeGnIjHKPhqSRTid9Q8opnKcs7z5l4h7HwBhUORtSS/HEc6X+MCCWiyS/K7HSNxigA==
X-Received: by 2002:a17:903:244c:b0:20c:f39e:4c04 with SMTP id d9443c01a7336-20d471ec6ddmr224478475ad.2.1729487164568;
        Sun, 20 Oct 2024 22:06:04 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0e1ba7sm17686565ad.238.2024.10.20.22.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 22:06:04 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:05:54 +0800
From: Furong Xu <0x1207@gmail.com>
To: 2694439648@qq.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 hailong.fan@siengine.com
Subject: Re: [PATCH v1] net: stmmac: enable MAC after MTL configuring
Message-ID: <20241021130554.00005cf5@gmail.com>
In-Reply-To: <tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com>
References: <tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 09:03:05 +0800, 2694439648@qq.com wrote:

> From: "hailong.fan" <hailong.fan@siengine.com>
> 
> DMA maybe block while ETH is opening,
> Adjust the enable sequence, put the MAC enable last
> 
> For example, ETH is directly connected to the switch,
> which never power down and sends broadcast packets at regular intervals.
> During the process of opening ETH, data may flow into the MTL FIFO,
> once MAC RX is enabled. and then, MTL will be set, such as FIFO size.
> Once enable DMA, There is a certain probability that DMA will read
> incorrect data from MTL FIFO, causing DMA to hang up.
> By read DMA_Debug_Status, you can be observed that the RPS remains at
> a certain value forever. The correct process should be to configure
> MAC/MTL/DMA before enabling DMA/MAC
> 
> Signed-off-by: hailong.fan <hailong.fan@siengine.com>
> 

A Fixes: tag should be added.

>  static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e21404822..c19ca62a4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3437,9 +3437,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  		priv->hw->rx_csum = 0;
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Set the HW DMA mode and the COE */
>  	stmmac_dma_operation_mode(priv);
>  
> @@ -3523,6 +3520,9 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  	/* Start the ball rolling... */
>  	stmmac_start_all_dma(priv);
>  
> +	/* Enable the MAC Rx/Tx */
> +	stmmac_mac_set(priv, priv->ioaddr, true);
> +

This sequence fix should be applied to stmmac_xdp_open() too.

>  	stmmac_set_hw_vlan_mode(priv, priv->hw);
>  
>  	return 0;

It is better to split this patch into individual patches, since you are
trying to fix an issue related to several previous commits:
dwmac4, dwxgmac2, stmmac_hw_setup() and stmmac_xdp_open()

