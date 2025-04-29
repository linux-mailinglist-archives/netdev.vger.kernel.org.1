Return-Path: <netdev+bounces-186865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F44AA3A09
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B79B9C0056
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC58253F2C;
	Tue, 29 Apr 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udVGbX89"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545412701C4;
	Tue, 29 Apr 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962942; cv=none; b=uMqo7LsBKQRoZfxpLt6lG1FrywmDiPQbND1mwEKoWf7yE1vwIcM5Yx+AESVAnHkPzOrZ2tCGKHEPNI8yOwpLMeNAx1Hldu/c1TqSiumZqv1auuraxXYSozKcJmRWrHwROQc9aZwVXnXFQ8qMk0MoSHRsOgYEjf/XNpLLteyNkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962942; c=relaxed/simple;
	bh=ZcjOsmCvWQ9kEExyzI58z4KQxafFY5Y4gSQ0njQDjII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BC+oAycd8n52k7wqPlqKfWIoUY4fzeAVM+V6iXgdC4CmhdUc5Sl+3v+NvBC71ChhNb0dL0Jrs7+L+7x/5+Ga3lTTNzmPzc3kj9qD1dUEcbyQLasmR068HdZjszlqv5EoOWMNtkxWFcrDtTCrI6IbNYh0jpoQ/BNPlJNoO3tP2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udVGbX89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0DFC4CEE3;
	Tue, 29 Apr 2025 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745962941;
	bh=ZcjOsmCvWQ9kEExyzI58z4KQxafFY5Y4gSQ0njQDjII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udVGbX89zU8DeYmtFGU+gzWJlcMtURBcxIH4Psb+cVWjOfnZupIH1yPFYAcfS2wpH
	 8vxF5+/cJtINC7hRKLxvR8VVewkoJjKdxjFpi/3OFf+rs43TeGnIo72DrUTimtSMEP
	 NWnq94MKjTZvke7TabGqu/VEfkZZ1Dgb8JUPz5r5gyKaNClUv3kHTP7BI84oaSRpLR
	 uHZlXnMon8R4kZjlXXXlwPxWCQ3qI1E8cuPwEBWJXYNeVMP6na6Ne5cgbE3hG1IpK0
	 p+CAet7cAUBatY9HTflZ3Lm4C22ZXKusib7ZZ6WvnspIt8R7UK2u1tK/snOxJ2lgBQ
	 A6YG+6b3YwIsA==
Date: Tue, 29 Apr 2025 14:42:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Chad Monroe <chad@monroe.io>, Felix Fietkau <nbd@nbd.name>, Bc-Bocun
 Chen <bc-bocun.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix SER panic with
 4GB+ RAM
Message-ID: <20250429144220.5d22fc1f@kernel.org>
In-Reply-To: <4adc2aaeb0fb1b9cdc56bf21cf8e7fa328daa345.1745715843.git.daniel@makrotopia.org>
References: <4adc2aaeb0fb1b9cdc56bf21cf8e7fa328daa345.1745715843.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Apr 2025 02:05:44 +0100 Daniel Golle wrote:
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
> +			if (unlikely(dma_addr =3D=3D DMA_MAPPING_ERROR))
> +				addr64 =3D FIELD_GET(RX_DMA_ADDR64_MASK,
> +						   rxd->rxd2);
> +			else
> +				addr64 =3D RX_DMA_PREP_ADDR64(dma_addr);

I guess it's correct but FWIW it reads slightly weird that in one
branch we use FIELD_GET() and in the other "PREP". I get that the
macros are a bit complicated but to the reader its not obvious whether
the value stored in addr64 is expected to be shifted or not =F0=9F=A4=B7=EF=
=B8=8F

> + rxd->rxd2 =3D RX_DMA_PREP_PLEN0(ring->buf_size) | addr64;=20

