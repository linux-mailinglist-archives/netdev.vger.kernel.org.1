Return-Path: <netdev+bounces-107809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E0591C6B0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5902867B0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D077F2F;
	Fri, 28 Jun 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XYTSJiQw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUwSc8lz"
X-Original-To: netdev@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A967710F;
	Fri, 28 Jun 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603275; cv=none; b=FwJHcXlIOiPRCAlknDM/73kDVdc7fkVaCdR/pmS4JIHn7wUIA4V5o3QUrgBfbKfvRWc0lk9x8WJRb2thfu79y7s9FxNN+qL/KB7KFxXuMJa3E2t8u2z8dBPcIOZHz28frg8YoJJwuSqefSweB6D3dI8lvi/Oln36E7nR1fyByCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603275; c=relaxed/simple;
	bh=AFMoDQdX7hn6J12nDvb9s2bIzDWeTMdWUsM9YsorTJQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=APxiBL+Zc7EBnaXRW4S7LkLuaEIIZCtQIhqpxOoKhQn76UZJfM+NzK9EpiAS1MkEX2/yQWWosItgDu0h8CXhM+FGricJBDZfR3JDKwJAMGH/cpHCive8c6hXtBvte42ckOO0QRC649ci3T9xEFqZ3XobPvNLoLLUoNIaAfosMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XYTSJiQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUwSc8lz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 36D3F13802A7;
	Fri, 28 Jun 2024 15:34:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 28 Jun 2024 15:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719603272; x=1719689672; bh=Wxu9sEJ1TD
	kI5LBy6kIUfNj65JHyIWj4yuKsUbp66t8=; b=XYTSJiQw2dIYD2vwjt+lihbq+v
	Dwx4pnN4pLkywVzOgqLgBViSvNo7mji6p/ddP/PY04kxkIUgYOLpbtbNHp5vOoyA
	0n5oHJ3PbCduekFH6IlOr9uB5a5TSsmSJvf691C4BMBWbF/0Hc+XPIn4Xq2WN/sm
	c0qhU1k/IuPp4jwRQBourv/BcktlbC4/U885m+LZyXSszG4410Wz4lLgwrizoydy
	SiT2W3IHih7YRGt1JjDO9RHVlFfTo/jODB/Svh3+Y6YZ79JC5WpURbyApB7qNSz1
	ZCf9VSjgB9psp4WjC3ECf7zzXc71M2H5/ZI7O3VkYCpyjmnnyIMf+8osF2+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719603272; x=1719689672; bh=Wxu9sEJ1TDkI5LBy6kIUfNj65JHy
	IWj4yuKsUbp66t8=; b=XUwSc8lzOMy/aZr13G+qyB8U0OO4/Eg8O0DE93ZBeqQE
	YlHWzfUSqviEB7SpDpQkASIaqOypPBDkAMkJfTreW5wQuIEKWy2TfvKlRHT9M+g+
	n46zUlEgSB1JbjyMT6LtYm/W0AxWOphV1P2npA46isXxTI1TF3DmXU+9zd9qnRWV
	/jj3wcPIFsTlZsxblhNWSAfVNBBKLPOTpVFXa73DrRjQHX4+qZ3ZcLA/YIG2RlUR
	17K8nUphQ3I9ya+Pc6FN+jAnJ5UJZJgFLePZ8i2qkOAo6Jqp2G3YegM40vpx+wEy
	TJDysX1f8B9P5TzBFI4Qg0nUX6bTJMPGOhuo2WavEw==
X-ME-Sender: <xms:RhB_ZltGMuYHFFTD1nxrxJ4b0Bj7ELjnqJGADvNm6cIRI4pqwERLRQ>
    <xme:RhB_ZufSdzzfzC9aSwDsuu3zW8w-EsmqNi_UC0SrpU-h8FFKKWdOe5mDrsXc5udac
    BjX03KA4Qa1xyp9QbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:RhB_Zoyu1BxahTZCfqo_8xbPFIyjw8jNwBSHsq1erqfDqAakxSWkYw>
    <xmx:RhB_ZsOFU_EMomsUr2WPFlcG8rvQzoZmdvf59HkF6Lj8yVEG_Bjkmw>
    <xmx:RhB_Zl_qxHB41NBLNjtOW8xP5BrQLetZ9CAYGfE_5FMpO3j86LXF3Q>
    <xmx:RhB_ZsXA4-AtNmdVYeQro8UjzJv8aap6DrPXlbz3cr-xLvOFCwDDjQ>
    <xmx:SBB_ZhuqCGnt_zDaitfVCTQzqqP6z-AmelM_awCtY1zuhtNZdxqdqa-s>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 64557B6008D; Fri, 28 Jun 2024 15:34:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b234ecb-e870-4e5b-b942-bee98e139590@app.fastmail.com>
In-Reply-To: <Zn7ykZeBWXN3cObh@lore-desk>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
 <2d74f9c1-2b46-4544-a9c2-aa470ce36f80@app.fastmail.com>
 <Zn7ykZeBWXN3cObh@lore-desk>
Date: Fri, 28 Jun 2024 21:34:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, "Felix Fietkau" <nbd@nbd.name>,
 lorenzo.bianconi83@gmail.com, "David S . Miller" <davem@davemloft.net>,
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

On Fri, Jun 28, 2024, at 19:27, Lorenzo Bianconi wrote:
>> > +static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
>> > +				    u32 clear, u32 set)
>> > +{
>> > +	unsigned long flags;
>> > +
>> > +	if (WARN_ON_ONCE(index >= ARRAY_SIZE(eth->irqmask)))
>> > +		return;
>> > +
>> > +	spin_lock_irqsave(&eth->irq_lock, flags);
>> > +
>> > +	eth->irqmask[index] &= ~clear;
>> > +	eth->irqmask[index] |= set;
>> > +	airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
>> > +
>> > +	spin_unlock_irqrestore(&eth->irq_lock, flags);
>> > +}
>> 
>> spin_lock_irqsave() is fairly expensive here, and it doesn't
>> actually protect the register write since that is posted
>> and can leak out of the spinlock.
>> 
>> You can probably just remove the lock and instead do the mask
>> with atomic_cmpxchg() here.
>
> I did not get what you mean here. I guess the spin_lock is used to avoid
> concurrent irq registers updates from user/bh context or irq handler.
> Am I missing something?

What I meant is that the airoha_qdma_wr() doesn't complete
until after the unlock because this is a normal 'posted' ioremap()
mapping.

>> > +static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
>> > +{
>> > +	struct airoha_eth *eth = dev_instance;
>> > +	u32 intr[ARRAY_SIZE(eth->irqmask)];
>> > +	int i;
>> > +
>> > +	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
>> > +		intr[i] = airoha_qdma_rr(eth, REG_INT_STATUS(i));
>> > +		intr[i] &= eth->irqmask[i];
>> > +		airoha_qdma_wr(eth, REG_INT_STATUS(i), intr[i]);
>> > +	}
>> 
>> This looks like you send an interrupt Ack to each
>> interrupt in order to re-arm it, but then you disable
>> it again. Would it be possible to leave the interrupt enabled
>> but defer the Ack until the napi poll function is completed?
>
> I guess doing so we are not using NAPIs as expected since they are
> supposed to run with interrupt disabled. Agree?

The idea of NAPI is that you don't get the same interrupt
again until all remaining events have been processed.

How this is achieved is device dependent, and it can either
be done by masking the interrupt as you do here, or by
not rearming the interrupt if it gets turned off automatically
by the hardware. My guess is that writing to REG_INT_STATUS(i)
is the rearming here, but the device documentation should
clarify that. It's also possible that this is an Ack that
is required so you don't immediately get another interrupt.

>> > +	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
>> > +		return IRQ_NONE;
>> > +
>> > +	if (intr[1] & RX_DONE_INT_MASK) {
>> > +		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
>> > +					RX_DONE_INT_MASK);
>> > +		airoha_qdma_for_each_q_rx(eth, i) {
>> > +			if (intr[1] & BIT(i))
>> > +				napi_schedule(&eth->q_rx[i].napi);
>> > +		}
>> > +	}
>> 
>> Something seems wrong here, but that's probably just me
>> misunderstanding the design: if all queues are signaled
>> through the same interrupt handler, and you then do
>> napi_schedule() for each queue, I would expect them to
>> just all get run on the same CPU.
>> 
>> If you have separate queues, doesn't that mean you also need
>> separate irq numbers here so they can be distributed to the
>> available CPUs?
>
> Actually I missed to mark the NAPI as threaded. Doing so, even if we have a
> single irq line shared by all Rx queues, the scheduler can run the NAPIs in
> parallel on different CPUs. I will fix it in v4.

Ok. It's a bit disappointing that the hardware integration
messed this up by not having multiple IRQ lines because
that adds a lot of latency, but I guess there is not much else
you can do about it.

>> > b/drivers/net/ethernet/mediatek/airoha_eth.h
>> > new file mode 100644
>> > index 000000000000..fcd684e1418a
>> > --- /dev/null
>> > +++ b/drivers/net/ethernet/mediatek/airoha_eth.h
>> > @@ -0,0 +1,793 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Copyright (C) 2024 Lorenzo Bianconi <lorenzo@kernel.org>
>> > + */
>> > +
>> > +#define AIROHA_MAX_NUM_RSTS		3
>> > +#define AIROHA_MAX_NUM_XSI_RSTS		4
>> 
>> If your driver only has a single .c file, I would suggest moving all the
>> contents of the .h file into that as well for better readability.
>
> I do not have a strong opinion about it but since we will extend the driver
> in the future, keeping .c and .h in different files, seems a bit more tidy.
> What do you think?

I would still keep it all in one file. If you extend it to multiple
files later, it's easy to move those parts that you actually need to
share into an interface header. Most likely the majority of the current contents won't be needed by other files.

      Arnd

