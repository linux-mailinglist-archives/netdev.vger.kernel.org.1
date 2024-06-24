Return-Path: <netdev+bounces-106249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A491578F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 22:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F861C23467
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5C1A01B5;
	Mon, 24 Jun 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LFBnTCbn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDem+zt2"
X-Original-To: netdev@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6B19E7F8;
	Mon, 24 Jun 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259566; cv=none; b=ccMsB1s1Kh/U1URJvcT6XDThAW+tHMOQzzUWDhBBTih/JFtTuda5AF2QPCi3x8X/vjtdBbTgcdqq8mccUMP9K68yR5qZGhb6tlMhPV6MH0U/N2zRoSvYzkoTi6cNyLjJMh+d7oAxsBaVNp0Erfelh3Oh8rjiWnyL6JDPx6ArwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259566; c=relaxed/simple;
	bh=9qomBob0fR2P8jrN+7om1adwcHmZcjFfFJa7riJwUqs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=hNqbRjqoywHlgNapdEIfzZUSvyf3IjUMGDyKggXNk3gL59wLtVb8uCN0tbOuCKEhPeXJNDkThPbSPvNMNu/hl76Q0UsqsKeXK2eG8d15hFDARx0p2AYioNc6jSDWlxxinNqMjwEu5RI2+JCcTj81M5CneZNhZb1RqU/slBIP4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LFBnTCbn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDem+zt2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CE9FD138026B;
	Mon, 24 Jun 2024 16:05:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 24 Jun 2024 16:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719259559; x=1719345959; bh=kMCQDF+NK4
	+6zwlcz9UrfDi3Y8gNAgLfB+D2xGxb8TY=; b=LFBnTCbnhMmRpk5j1bi8Bp7qhM
	d3YKR92LnQREyvmtKuzTSJv5Zcc+XnzbMJA/F/cWfLyAPwpRXuqBrZGBDoEE8mCM
	8hbVtHvcU+siIjufemtdgMYfFstAVYHGwUunw3lEAdNOp3wHSGpVnAdP8wHcyJdq
	dOt2jOUchGFEJAPUaWGJICA7i3fz6bF0ccewp/Tz1BfK/YrFIgi9I4qps86mRZ0j
	LFz2ApPa0N+Y5SbIePOyhYKCAyrRP24pddCoQa9RKWv3uUCOuGfSQy7qBqHSf42W
	j1ZldY+OttqqmjoBOoJHbAROi8X1YnWWy1tT8qEQHDCfC0dYyu7bldsP9Ppw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719259559; x=1719345959; bh=kMCQDF+NK4+6zwlcz9UrfDi3Y8gN
	AgLfB+D2xGxb8TY=; b=TDem+zt2IuxwzB7BENlA2Wavkv55R9h8CWFOLqKc6iLd
	t9F31AaW1Zzp+e8X41MUYuDYReLNpMdjTkl004LEC3L2AyE0BLb47BOMXnbyna+T
	QlepLAAF+Q+lbjMqOOWl2G/8O0WKWlRlcM6Frd+RTosWETFGDYBJC839iayCxu3E
	rXWt+Ojzq/zXhkqMYtFnx7TgXECq7WEWlt/UgsQJ0tl1Hg57ezrkQHFkMq45YFWF
	tMfAWvtWJWkkgSCSG1NgOqu3ssDkCCYM1kNUi+aTB9bwi4DB+93lywpJxpZzMczu
	FaqHvCequ5jmR5M/EnvIJJt5MNEYi4vae+33o2p/pw==
X-ME-Sender: <xms:ptF5ZpmfrbKbYxll2bXLgyWQqYa-K_GmvXNV8efIQn9PrECBO-Mtcg>
    <xme:ptF5Zk2GUiifbNNAGhDIKy8nJLsg8mhs3rjJcQaegzBrVfaLEiOBHU3duHXbI6CYk
    we-mgO5AldBYYEAkyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ptF5Zvq0KNybY6mRfXdG5yUZ1CkatYfK_1wIi7-1fZg4I4bXe70jvw>
    <xmx:ptF5ZpkWSTd02Wy-mQtUKU3lWChWNexIR2EoGc6VeYnK0EiHGte-tg>
    <xmx:ptF5Zn3Zu_MDlECZjF0skKVTCECNkRwkm_aEzKVQaDVdkzLx75VlqA>
    <xmx:ptF5ZouEhPKfPc68z4OU-3N4j3iOk9FOtRVZuS127nqye4WzAFG8EA>
    <xmx:p9F5Zll6j6AiXlnbHnGeYK3GmoHM3zWnNYkMxl2V3gLHUI1gRkDur6xd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B92E6B60092; Mon, 24 Jun 2024 16:05:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d74f9c1-2b46-4544-a9c2-aa470ce36f80@app.fastmail.com>
In-Reply-To: 
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
Date: Mon, 24 Jun 2024 22:05:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Bianconi" <lorenzo@kernel.org>, Netdev <netdev@vger.kernel.org>
Cc: "Felix Fietkau" <nbd@nbd.name>, lorenzo.bianconi83@gmail.com,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Conor Dooley" <conor@kernel.org>,
 linux-arm-kernel@lists.infradead.org, "Rob Herring" <robh+dt@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org, "Conor Dooley" <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, upstream@airoha.com,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
 "Ratheesh Kannoth" <rkannoth@marvell.com>,
 "Sunil Goutham" <sgoutham@marvell.com>, "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support for EN7581
 SoC
Content-Type: text/plain

On Tue, Jun 18, 2024, at 09:49, Lorenzo Bianconi wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> en7581-evb networking architecture is composed by airoha_eth as mac
> controller (cpu port) and a mt7530 dsa based switch.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.
>
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I noticed a few small things that you may want to improve:

> +static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
> +				    u32 clear, u32 set)
> +{
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(index >= ARRAY_SIZE(eth->irqmask)))
> +		return;
> +
> +	spin_lock_irqsave(&eth->irq_lock, flags);
> +
> +	eth->irqmask[index] &= ~clear;
> +	eth->irqmask[index] |= set;
> +	airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
> +
> +	spin_unlock_irqrestore(&eth->irq_lock, flags);
> +}

spin_lock_irqsave() is fairly expensive here, and it doesn't
actually protect the register write since that is posted
and can leak out of the spinlock.

You can probably just remove the lock and instead do the mask
with atomic_cmpxchg() here.

> +
> +		dma_sync_single_for_device(dev, e->dma_addr, e->dma_len, dir);
> +
> +		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
> +		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> +		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
> +		val = FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, q->head);
> +		WRITE_ONCE(desc->data, cpu_to_le32(val));
> +		WRITE_ONCE(desc->msg0, 0);
> +		WRITE_ONCE(desc->msg1, 0);
> +		WRITE_ONCE(desc->msg2, 0);
> +		WRITE_ONCE(desc->msg3, 0);
> +
> +		wmb();
> +		airoha_qdma_rmw(eth, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
> +				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));

The wmb() between the descriptor write and the MMIO does nothing
and can probably just be removed here, a writel() already contains
all the barriers you need to make DMA memory visible before the
MMIO write.

If there is a chance that the device might read the descriptor
while it is being updated by you have not written to the
register, there should be a barrier before the last store to
the descriptor that sets a 'valid' bit. That one can be a
cheaper dma_wmb() then.

> +static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
> +{
> +	struct airoha_eth *eth = dev_instance;
> +	u32 intr[ARRAY_SIZE(eth->irqmask)];
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
> +		intr[i] = airoha_qdma_rr(eth, REG_INT_STATUS(i));
> +		intr[i] &= eth->irqmask[i];
> +		airoha_qdma_wr(eth, REG_INT_STATUS(i), intr[i]);
> +	}

This looks like you send an interrupt Ack to each
interrupt in order to re-arm it, but then you disable
it again. Would it be possible to leave the interrupt enabled
but defer the Ack until the napi poll function is completed?

> +	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
> +		return IRQ_NONE;
> +
> +	if (intr[1] & RX_DONE_INT_MASK) {
> +		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
> +					RX_DONE_INT_MASK);
> +		airoha_qdma_for_each_q_rx(eth, i) {
> +			if (intr[1] & BIT(i))
> +				napi_schedule(&eth->q_rx[i].napi);
> +		}
> +	}

Something seems wrong here, but that's probably just me
misunderstanding the design: if all queues are signaled
through the same interrupt handler, and you then do
napi_schedule() for each queue, I would expect them to
just all get run on the same CPU.

If you have separate queues, doesn't that mean you also need
separate irq numbers here so they can be distributed to the
available CPUs?

> +		val = FIELD_PREP(QDMA_DESC_LEN_MASK, len);
> +		if (i < nr_frags - 1)
> +			val |= FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
> +		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> +		WRITE_ONCE(desc->addr, cpu_to_le32(addr));
> +		val = FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, index);
> +		WRITE_ONCE(desc->data, cpu_to_le32(val));
> +		WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
> +		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
> +		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
> +
> +		e->skb = i ? NULL : skb;
> +		e->dma_addr = addr;
> +		e->dma_len = len;
> +
> +		wmb();
> +		airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> +				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));

Same as above with the wmb().

> +static int airoha_rx_queues_show(struct seq_file *s, void *data)
> +{
> +	struct airoha_eth *eth = s->private;
> +	int i;
> +
...
> +static int airoha_xmit_queues_show(struct seq_file *s, void *data)
> +{
> +	struct airoha_eth *eth = s->private;
> +	int i;
> +

Isn't this information available through ethtool already?

> b/drivers/net/ethernet/mediatek/airoha_eth.h
> new file mode 100644
> index 000000000000..fcd684e1418a
> --- /dev/null
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.h
> @@ -0,0 +1,793 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Lorenzo Bianconi <lorenzo@kernel.org>
> + */
> +
> +#define AIROHA_MAX_NUM_RSTS		3
> +#define AIROHA_MAX_NUM_XSI_RSTS		4

If your driver only has a single .c file, I would suggest moving all the
contents of the .h file into that as well for better readability.

      Arnd 

