Return-Path: <netdev+bounces-38678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33B7BC18C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0652D2820CF
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF260450C3;
	Fri,  6 Oct 2023 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIB5D7QU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738344483;
	Fri,  6 Oct 2023 21:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B17AC433C7;
	Fri,  6 Oct 2023 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696628829;
	bh=7ShH9lM/jTtdIpDBd5tkXIdLZJ6EOzXUhDKKnj55xPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIB5D7QUgappiPLI6dOoUHSxvt5YAjXDxSa8MYt3/cAFv/c5IHJYHnYTPpU858ZTu
	 ClL/Cf8dYmT/K2AsekQJqM/9c+T/Lu+ejjHS7ojVK3HC8q8o9i3501u//0M0XEEIUA
	 kQhpB665WwNyXG+96GLLJwQmYMwetRfLQ0qkrS4cswc44g/UYawosmoi4NMFiFOe4q
	 duYX45Tg97UhJ6fdrukD6yY2MmoCfaH9XlYzON02quQybVLTyXOqpCIZOPLdLN7pvz
	 WNUh6/12mNBI+Q820T8snzNGUsqfrHG91QPyG1E9MvoRh77CxpA+aVQH87ZXbvLdOH
	 hY2YnF6sVQk4Q==
Date: Fri, 6 Oct 2023 14:47:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Simon
 Horman <horms@kernel.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 10/30] net: wan: Add support for QMC HDLC
Message-ID: <20231006144702.778c165e@kernel.org>
In-Reply-To: <20230928070652.330429-11-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
	<20230928070652.330429-11-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 09:06:28 +0200 Herve Codina wrote:
> +static int qmc_hdlc_close(struct net_device *netdev)
> +{
> +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> +	struct qmc_hdlc_desc *desc;
> +	int i;
> +
> +	netif_stop_queue(netdev);
> +
> +	qmc_chan_stop(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);
> +	qmc_chan_reset(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);

stopping the queue looks a bit racy, a completion may come in 
and restart the queue

> +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->tx_descs); i++) {
> +		desc = &qmc_hdlc->tx_descs[i];
> +		if (!desc->skb)
> +			continue;
> +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> +				 DMA_TO_DEVICE);
> +		kfree_skb(desc->skb);
> +		desc->skb = NULL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {
> +		desc = &qmc_hdlc->rx_descs[i];
> +		if (!desc->skb)
> +			continue;
> +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> +				 DMA_FROM_DEVICE);
> +		kfree_skb(desc->skb);
> +		desc->skb = NULL;
> +	}
> +
> +	hdlc_close(netdev);

