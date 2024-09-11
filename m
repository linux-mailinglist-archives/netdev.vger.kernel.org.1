Return-Path: <netdev+bounces-127606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F4975DC4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29857B23A1A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989081865F9;
	Wed, 11 Sep 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+ZcnKWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB686126;
	Wed, 11 Sep 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726098702; cv=none; b=fxlDL0hhGMPT8BBzkfkU48g4uUEQ5LXcOw7t0+mdrNv9Yr/TRdPZvJl4noopw4jR9GReSZ1nm3e+h+U6QlhAn9cuw1wy7XdDNL/lUUjc+RBzcGGwqHPEjQbzjdAzKRCK5whq0p3I5V6etYIUAsOosFkxSySsyIRfQUvoFDk+rfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726098702; c=relaxed/simple;
	bh=Y6kf4Wi6KDs88Xo6Q2D9THZIQ/bLuNqar2amyrJ7IBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmqMqKab0rfybZub1CDKOSLH2fesGgFBLsAiXsjN6w/WIWjPW1Jtc1vfsypoeQZYp3A5GmZbpakdyn/1ibULeLY8SsJlH/rn4RM2VPlAUYHweK5FN3OAagJAo7XQw/iu1vA8+LR3k6mwSo7BtjVCPOz/NCVMOVHvC0r/N0bvwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+ZcnKWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AE2C4CEC0;
	Wed, 11 Sep 2024 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726098701;
	bh=Y6kf4Wi6KDs88Xo6Q2D9THZIQ/bLuNqar2amyrJ7IBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f+ZcnKWyi/9UeOBLlF/Z3b+5pgzmUkwOiy10JBnuRxQTfqc4Hosspr/wpoDJIXVtI
	 kk0Li2BICh2E/3SN852se+VptdvCM2DHcgLnkE0ORU+Y5ST9cfAITgQLxSLvpZtB8l
	 cP7ALk2w2e5Qos/NuLD9CdmEP0Ect8bsLcdMpfJ8b1+b2HAIht0Sp/fZ2cd7GyPmJy
	 9bLOKQqMIKNXXxWOnOx+r8fPJc/IqtLrGWUeo4yJE6I75CJiYJahEgze1GP1U7y7fn
	 Ix/Lxos3H3MZngCNdicv+J6H7X8MkOpu7NQwIqH8EH1F754GbaaG0nel0DeqXjyNbk
	 87ebwq7P0sF9A==
Date: Wed, 11 Sep 2024 16:51:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney
 <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v2] net: stmmac: allocate separate page for buffer
Message-ID: <20240911165140.566d9fdb@kernel.org>
In-Reply-To: <20240910124841.2205629-2-quic_jsuraj@quicinc.com>
References: <20240910124841.2205629-1-quic_jsuraj@quicinc.com>
	<20240910124841.2205629-2-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 18:18:41 +0530 Suraj Jaiswal wrote:
> Currently for TSO page is mapped with dma_map_single()
> and then resulting dma address is referenced (and offset)
> by multiple descriptors until the whole region is
> programmed into the descriptors.
> This makes it possible for stmmac_tx_clean() to dma_unmap()
> the first of the already processed descriptors, while the
> rest are still being processed by the DMA engine. This leads
> to an iommu fault due to the DMA engine using unmapped memory
> as seen below:
> 
> arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
> iova=0xfc401000, fsynr=0x60003, cbfrsynra=0x121, cb=38
> 
> Descriptor content:
>      TDES0       TDES1   TDES2   TDES3
> 317: 0xfc400800  0x0     0x36    0xa02c0b68
> 318: 0xfc400836  0x0     0xb68   0x90000000
> 
> As we can see above descriptor 317 holding a page address
> and 318 holding the buffer address by adding offset to page
> addess. Now if 317 descritor is cleaned as part of tx_clean()
> then we will get SMMU fault if 318 descriptor is getting accessed.

The device is completing earlier chunks of the payload before the entire
payload is sent? That's very unusual, is there a manual you can quote
on this?

> To fix this, let's map each descriptor's memory reference individually.
> This way there's no risk of unmapping a region that's still being
> referenced by the DMA engine in a later descriptor.

This adds overhead. Why not wait with unmapping until the full skb is
done? Presumably you can't free half an skb, anyway.

Please added Fixes tag and use "PATCH net" as the subject tag/prefix.
-- 
pw-bot: cr

