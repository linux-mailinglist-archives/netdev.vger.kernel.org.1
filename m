Return-Path: <netdev+bounces-168311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EBEA3E79D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7147422C72
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9741EF08F;
	Thu, 20 Feb 2025 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1EHRweY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2541E9B35;
	Thu, 20 Feb 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091122; cv=none; b=svKntkQx3g6hX5NyVwac4LlGWh8y0WDtLnD1QvQsJJtSQPkAmQp0XgKtjWSxWOal8pS/AZVDjZRxdRq7BHFt5jqBmyiX870RVKNoxVDE8kcx8pDkNvaoaab4fM1eQZ6MtjaIW6yxofkHlU/TVkY2eIWIbQSao/oJbX65k0IS+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091122; c=relaxed/simple;
	bh=Ppb+Pfz3YL9zU3Tv9OOPt/0hADKUh0x5VfaDJ4uMAxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGv13olighb2UNngxVqbd/a2RufMd0nDkk1NfD0QEkI+9vO+/r6vCvMUcni48pb25iC74D2vyY1/OXLQQ/Y0QfZq5FSLLhHOX7UK1zYSL3FbeF/mwwr8MbDSQ+AREsyLleoJks+VCIEOKLBMfOgof3uUFjYiMVLfDxKnEqqn3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1EHRweY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20999C4CED1;
	Thu, 20 Feb 2025 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740091121;
	bh=Ppb+Pfz3YL9zU3Tv9OOPt/0hADKUh0x5VfaDJ4uMAxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S1EHRweYEqCVnw8MdjHn1EbXyRrAQOMZG+ts3WicxTwQyQc98jIF31ONIX/dFppWi
	 7VDHDOLyraPnqZxLhiI/Qnz1tBoZSMwLvKtsARCL3vWMQbb7uuFU3m/FWkWlaeyvXJ
	 uaW1AhwLPj6x2ceW7XscmLvJLbQxvI8NgbMr8fBr9J5iSut/JvK4384yQ+vPLjwQxR
	 CZ2L2X/45evioSs4MGk7cn4Yls8l1lR4sWwz0o6mV5kpsCr1MjM+n8jycZrox5wmoc
	 SgWZdSMtcJbXGX9eIqRPXofKHapj0ZH60OVTfgx3+8xvrI7UNyXjzQua6/p1049FwC
	 kAfQ+FbCmTydA==
Date: Thu, 20 Feb 2025 14:38:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 upstream@airoha.com
Subject: Re: [PATCH net-next v5 12/15] net: airoha: Introduce Airoha NPU
 support
Message-ID: <20250220143839.5ea18735@kernel.org>
In-Reply-To: <20250217-airoha-en7581-flowtable-offload-v5-12-28be901cb735@kernel.org>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
	<20250217-airoha-en7581-flowtable-offload-v5-12-28be901cb735@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:01:16 +0100 Lorenzo Bianconi wrote:
> +static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> +			       void *p, int size)
> +{
> +	u16 core = 0; /* FIXME */
> +	u32 val, offset = core << 4;
> +	dma_addr_t dma_addr;
> +	void *addr;
> +	int ret;
> +
> +	addr = kzalloc(size, GFP_ATOMIC | GFP_DMA);

You need the actual "zone DMA" memory from ISA times?
I think that's what GFP_DMA is for. Any kmalloc'd memory
can be DMA'ed to/from.

> +	if (dma_set_coherent_mask(dev, 0xbfffffff))

Coherent mask is not contiguous on purpose?
Quick grep reveals no such cases at present, not sure if it works.
Maybe add a comment, at least ?
-- 
pw-bot: cr

