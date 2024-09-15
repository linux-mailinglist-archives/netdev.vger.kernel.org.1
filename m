Return-Path: <netdev+bounces-128411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EF979772
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789941F21373
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CE1C7B88;
	Sun, 15 Sep 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxLMbYBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFDDDAB;
	Sun, 15 Sep 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413532; cv=none; b=kghzeLixga/EQ/fyQl2gLhc55yCqyMh6gU1/aur4SWd/LFUr6SDwBriM1OyPcjifKsxhPBM/ndSLkQ4p38NiP8W66d+PBH9Ps7Ya3VCjPcCShTLAoeCEL5mKIbn42WXCUaYfREowo77YHsO8JixU+16VEvemyxU0rX84+bB7Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413532; c=relaxed/simple;
	bh=w+V1owSmOt7tIUFoiSiZjBRPgwwvWiamnXs3pgVPsRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtrZ600D9Al1l5cKQugQq6FPEcrf1I9xCZhnsDAQ6E2Gr4UAcU77czea+qrAI9r75tG0nX3hKB70HMFeRcqF+4P7977oLbAn5rWNIgwVF3uIKScvYgVDJg4d++en5Kf2jMmOi6kNsbatk9qG7dVKCwbTA+XczuTbiybdY9tpCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxLMbYBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED373C4CEC3;
	Sun, 15 Sep 2024 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726413532;
	bh=w+V1owSmOt7tIUFoiSiZjBRPgwwvWiamnXs3pgVPsRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AxLMbYBmk5A6sXn6Wl7ezRcDo10xlHXNsLkbInaKNGhUoy/N4KEhyMHPoSzRgucbo
	 8fGoYXFa6K7vOyaUNzPWiw5iQbqq/sxNRz7FoNwwQj83WmjnAbrCVQ+9j2gXZKbdqt
	 BJCRhPniQOnnbBnt461v95djELhZCOT5vKwCu8AAbSIuAD/5kT+6v7+szbyU2o5wVZ
	 yQ83FUJ8pZj8v4Kdeu+fFoh0gEfL81nKxzXgUdjm3ywSz1s77QB4k4AWzErhRVKSWe
	 ZyHDRw73rJ9XFA1L0yD4eiF2Q6E86sSm93O78LBFrSrvZwVUI+e5xfegmFxg6iH0cG
	 L00qDwj96hMBw==
Date: Sun, 15 Sep 2024 17:18:45 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
Message-ID: <20240915171845.4f233a0c@kernel.org>
In-Reply-To: <20240912025127.3912972-8-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
	<20240912025127.3912972-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:51:24 +0800 Jijie Shao wrote:
> +static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
> +{
> +	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
> +	struct hbg_priv *priv = ring->priv;
> +	struct hbg_rx_desc *rx_desc;
> +	struct hbg_buffer *buffer;
> +	u32 packet_done = 0;
> +	u32 pkt_len;
> +
> +	while (packet_done < budget) {
> +		if (unlikely(hbg_queue_is_empty(ring->ntc, ring->ntu, ring)))
> +			break;
> +
> +		buffer = &ring->queue[ring->ntc];
> +		if (unlikely(!buffer->skb))
> +			goto next_buffer;
> +
> +		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
> +			break;
> +
> +		hbg_dma_unmap(buffer);
> +
> +		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
> +
> +		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
> +		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
> +		skb_put(buffer->skb, pkt_len);
> +		buffer->skb->protocol = eth_type_trans(buffer->skb, priv->netdev);
> +
> +		dev_sw_netstats_rx_add(priv->netdev, pkt_len);
> +		netif_receive_skb(buffer->skb);

why not napi_gro_receive() ?

> +		buffer->skb = NULL;
> +		hbg_rx_fill_one_buffer(priv);
> +
> +next_buffer:
> +		hbg_queue_move_next(ntc, ring);
> +		packet_done++;
> +	}
> +
> +	hbg_rx_fill_buffers(priv);

don't try to refill the buffers if budget is 0, if budget is 0 we
should only do Tx processing (IOW this function should do nothing)

> +	if (likely(napi_complete_done(napi, packet_done)))

same comment as on Tx, don't call if not done

> +		hbg_hw_irq_enable(priv, HBG_INT_MSK_RX_B, true);
> +
> +	return packet_done;
> +}

