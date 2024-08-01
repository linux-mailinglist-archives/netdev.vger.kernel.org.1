Return-Path: <netdev+bounces-115142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0DE9454C1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CF81C230BE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832014D44F;
	Thu,  1 Aug 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK696Q+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B81482E2;
	Thu,  1 Aug 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553658; cv=none; b=oZxdzp9QWV6F09LRr7sqs1spwWvLQKW37aB/UzMzXzBSpqDgvmFQtW256V1u0keBtznB8pPMZSLMpjjd3++WeMjonHBo3+6wkAn95n5rPIb3NeYjVy9fHqXICNw0vTkPI3/aEAYGI9iBV0bHuAUlte8zhvA71YxHy5syW66RZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553658; c=relaxed/simple;
	bh=PtIa2QtTSywr4ng8EMKGCX2UJ1Jj3D83kU099Jn6C/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fepwmcIIdT0flXZEbQnFkaoqT1RxZx3QG9zlibts+nfguonE8ZhdwneMxU29+rZ2QKBOoMxuP66PlxvlFFVLJZpWu0CzKARLZaWpoHLnBywZOQtXX277IG9R5vRz4N8TRPM91UPPMAwP7hMgEcH2y4sMvhE8WHa3x8pdPkcwgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK696Q+o; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so11012699a12.3;
        Thu, 01 Aug 2024 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722553649; x=1723158449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTzwkxXMjCnXxGPm8SS63wasgARHwPjwYcFLo4i11LY=;
        b=MK696Q+oH+Gg86qGd8cJwuY1I3b58ttOhKmMGUtXP8wnceDU/An4Pj35q8S+FN6rmZ
         oWXZ89MARGPSuhRm2BKCKEZio6HyAVUu3g3gy0Vsz9FSNIbU6MvIHd8OXTDpp+uwV38r
         fVLeJf3nWnlTKToKuMs4j8nR+oCY8o5D0bOJiwchENHO8lDklIbj24+BvLUZTSRCN8CF
         V3jU4vIDWWnumsx3BOrB1AYSdfJpv9og3RYKINCjNypa19NxX2rfwiOdtxfxqtYZgpxv
         jmq+uBT8shtGg1xW6T2e90e3wTrEs7sDQgbSnO5uGSvZSJdrq9KuIYNKdjcZKzUdkdRx
         UFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722553649; x=1723158449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTzwkxXMjCnXxGPm8SS63wasgARHwPjwYcFLo4i11LY=;
        b=DbXsvyWxcFv4jC99DkRQdjZZN9kzQXcA9isFEAkdzP+QS+qe1k/Oetgker47GFPBtR
         mlPEXTsCUSzmcjKquIuPNMQRCpG6uNjFNJ/oP7Y0YUNZZpChX/bOz7g0toROM047QUV+
         ncLF13/vd+Wp27Vv2zb4vZGqb2ZkIMw/atpNXIiLdW8snPU8Xvggu+ONk/+72PSAhtMC
         h/8jjH78ziZoitA12QZaIBhoaYHlU/vpDwvAHN/9ZiQX0AEe0fLqacltGvy5UNfQtRas
         NgOD8gUWMLTYRHiV75uieLVRFIzFFAImqNTICF0EeIB6hxBjm/pVSQe5dfcnoBaseqpK
         l6yw==
X-Forwarded-Encrypted: i=1; AJvYcCW98mElQB9DZbDMKWL2wFag1h1YFZGRupSPo/l/oBBCb5iwnfeObLKI5ccJd6gd0/GCxGVW3llvqht1KkTSQepsilkjv6BAXwJ6Ia/6rQ8yWSm64ydFbFDbErfS8KtWVy44pvTs
X-Gm-Message-State: AOJu0Yws+2lkM6Kjy7lD454Ve7pBOFxHO+9Dyj8h253fm0SzdLfyYt0E
	g31IXU6YvnFoiKkeBQiW+Y1eDLV7q2rTy9fSoe7r890CsMwrrqfcMW8rBmrQ
X-Google-Smtp-Source: AGHT+IFv2aAGzMN11Iigqz0ZSdZXSz3c8So7Yv+NTGX6LRfrYtmGi031rLkNH9XJUmYnnVE03dMx+g==
X-Received: by 2002:a17:906:7956:b0:a7a:b8f1:fd69 with SMTP id a640c23a62f3a-a7dc4e4ae17mr140198966b.18.1722553648600;
        Thu, 01 Aug 2024 16:07:28 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0b6besm30094266b.52.2024.08.01.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:07:27 -0700 (PDT)
Date: Fri, 2 Aug 2024 02:07:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 2/5] net: stmmac: support fp parameter of
 tc-mqprio
Message-ID: <20240801230725.nllk7n3veqwplfpo@skbuf>
References: <cover.1722421644.git.0x1207@gmail.com>
 <cover.1722421644.git.0x1207@gmail.com>
 <df005cc6b2f97e7ea373dcc356fb6a693f33263a.1722421644.git.0x1207@gmail.com>
 <df005cc6b2f97e7ea373dcc356fb6a693f33263a.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df005cc6b2f97e7ea373dcc356fb6a693f33263a.1722421644.git.0x1207@gmail.com>
 <df005cc6b2f97e7ea373dcc356fb6a693f33263a.1722421644.git.0x1207@gmail.com>

On Wed, Jul 31, 2024 at 06:43:13PM +0800, Furong Xu wrote:
> tc-mqprio can select whether traffic classes are express or preemptible.
> 
> Tested on DWMAC CORE 5.10a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  2 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 12 ++++
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  2 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  8 +++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 61 +++++++++++++++++++
>  6 files changed, 87 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> index 5d132bada3fe..068859284691 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -655,3 +655,15 @@ void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
>  
>  	writel(value, ioaddr + MTL_FPE_CTRL_STS);
>  }
> +
> +void dwmac5_fpe_set_preemptible_tcs(void __iomem *ioaddr, unsigned long tcs)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + MTL_FPE_CTRL_STS);
> +
> +	value &= ~PEC;
> +	value |= FIELD_PREP(PEC, tcs);
> +
> +	writel(value, ioaddr + MTL_FPE_CTRL_STS);
> +}

Watch out here. I think the MTL_FPE_CTRL_STS[PEC] field is per TXQ, but
input from user space is per TC. There's a difference between the 2, that I'll
try to clarify below. But even ignoring the case of multiple TXQs per TC,
there's also the case of reverse TC:TXQ mappings: "num_tc 4 map 0 1 2 3
queues 1@3 1@2 1@1 1@0". When the user then says he wants TC 0 to be
preemptible, he really means TXQ 3. That's how this should be treated.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b1cf81c50ea..a5e3316bc410 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6256,6 +6256,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  	switch (type) {
>  	case TC_QUERY_CAPS:
>  		return stmmac_tc_query_caps(priv, priv, type_data);
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return stmmac_tc_setup_mqprio(priv, priv, type_data);
>  	case TC_SETUP_BLOCK:
>  		return flow_block_cb_setup_simple(type_data,
>  						  &stmmac_block_cb_list,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 996f2bcd07a2..494fe2f68300 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1198,6 +1198,13 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  			 struct tc_query_caps_base *base)
>  {
>  	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +
> +		return 0;
> +	}
>  	case TC_SETUP_QDISC_TAPRIO: {
>  		struct tc_taprio_caps *caps = base->caps;
>  
> @@ -1214,6 +1221,59 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  	}
>  }
>  
> +static void stmmac_reset_tc_mqprio(struct net_device *ndev)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
> +
> +	stmmac_fpe_set_preemptible_tcs(priv, priv->ioaddr, 0);
> +}
> +
> +static int tc_setup_mqprio(struct stmmac_priv *priv,
> +			   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct net_device *ndev = priv->dev;
> +	int num_stack_tx_queues = 0;
> +	int num_tc = qopt->num_tc;
> +	int offset, count;
> +	int tc, err;
> +
> +	if (!num_tc) {
> +		stmmac_reset_tc_mqprio(ndev);
> +		return 0;
> +	}
> +
> +	err = netdev_set_num_tc(ndev, num_tc);
> +	if (err)
> +		return err;
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		offset = qopt->offset[tc];
> +		count = qopt->count[tc];
> +		num_stack_tx_queues += count;
> +
> +		err = netdev_set_tc_queue(ndev, tc, count, offset);
> +		if (err)
> +			goto err_reset_tc;
> +	}

We might have a problem here, and I don't know if I'm well enough
equipped with DWMAC knowledge to help you solve it.

The way I understand mqprio is that it groups TX queues into traffic
classes. All traffic classes are in strict priority relative to each
other (TC 0 having the smallest priority). If multiple TX queues go to
the same traffic class, it is expected that the NIC performs round robin
dequeuing out of them. Then there's a prio_tc_map[], which maps
skb->priority values to traffic classes. On xmit, netdev_pick_tx()
chooses a random TX queue out of those assigned to the computed traffic
class for the packet. This skb_tx_hash() is the software enqueue
counterpart to what the NIC is expected to do in terms of scheduling.
Much of this is said in newer versions of "man tc-mqprio".
https://man7.org/linux/man-pages/man8/tc-mqprio.8.html

Where I was trying to get is that you aren't programming the TC to TXQ
mapping to hardware in any way, and you are accepting any mapping that
the user requests. This isn't okay.

I believe that the DWMAC TX scheduling algorithm is strict priority by
default, with plat->tx_sched_algorithm being configurable through device
tree properties to other values. Then, individual TX queues have the
"snps,priority" device tree property for configuring their scheduling
priority. All of that can go out of sync with what the user thinks he
configures through tc-mqprio, and badly.

Consider "num_tc 2 queues 3@0 2@3". The stack will think that TXQs 0, 1, 2
have one priority, and TXQs 3 and 4 another. But in reality, each TXQ
(say by default) has a priority equal to its index. netdev_pick_tx()
will think it's okay, for a packet belonging to TC0, to select a TXQ
based on hashing between indices 0, 1, 2. But in hardware, the packets
will get sent through TXQs with different priorities, based on nothing
more than pure chance. That is a disaster, and especially noticeable
when the mqprio mapping is applied through taprio, and there is a Qbv
schedule on the port. Some packets will be scheduled on the right time
slots, and some won't.

So the idea here is that you'll either have to experiment with
reprogramming the scheduling algorithm and TXQ priorities on mqprio
offload, or refuse offloading anything that doesn't match what the
hardware was pre-programmed with (through device tree, likely).

> +
> +	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
> +	if (err)
> +		goto err_reset_tc;
> +
> +	stmmac_fpe_set_preemptible_tcs(priv, priv->ioaddr, mqprio->preemptible_tcs);
> +
> +	return 0;
> +
> +err_reset_tc:
> +	stmmac_reset_tc_mqprio(ndev);
> +
> +	return err;
> +}

