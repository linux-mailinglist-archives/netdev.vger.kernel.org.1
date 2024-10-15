Return-Path: <netdev+bounces-135779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCE99F33E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5161F24224
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2581F76B2;
	Tue, 15 Oct 2024 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5a10nqR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076371F76AF
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010969; cv=none; b=Wht/4MYTT1udEXwoI7skD7hTnH9NoOJAijnC/SL47xAbkNybIaHvi+D0MVGeNLND+eosGiQVShen/FWxyLhqeO3yZDcMnzHJfRpGcB8TgPRiILmzawKNFSTHpNjsAj/ASRo8Q7ePxlLPA67GaZDYDpuTLNMtITx1SWws2mGON2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010969; c=relaxed/simple;
	bh=DcKp5q+RHk+DHa/BFz1tID2TndoFA5bGkqZxw6rymp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atR6vbX/+XLilfNiFTfqPhM9Mjnp2XxiOm6UhCnMU1FJn2z4GnqixgcwPEcsYUcKyp23p+Nauj1a/CbtUuBT4ZfPLaPRGfLqOOZzKLVH+9X8s4ZgK14fcRtDkZMs3SbgNkcldyIWMXdes9xLdRA3mS1J8Je4t3/9U8v05dJfNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5a10nqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03A3C4CECD;
	Tue, 15 Oct 2024 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729010968;
	bh=DcKp5q+RHk+DHa/BFz1tID2TndoFA5bGkqZxw6rymp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5a10nqRl3p5qSk2VIfEQoEAxcK2ZtEZPtoeJJmx5hRDfq3oOxVefVb2qoj0XzSe9
	 f9LOPY45DXOpNse0xHNSEvI1GlQPfOtJrYZYnCgkA+QlFCd9o77hDYqGvo8VnkHqVg
	 G4u8/SwPayhuHkUIXz1OStFWR+HgC6RTllpn+NX/27oEJmrkmpsNgZKI0N0bAjrNAO
	 90CEqvroXFuyn7CJ2P7bQrJrfNVAYFrUTibqKX1kwaWOVtTI6H01aVrPGp7uhIwhxz
	 Fv+MKcXKv9y0o6hZj25KMIUC/vG0YnylvLhj0VW2CQvcCmRF0wqLkX0LOOIBdMdkJK
	 xSrQp9IO1+2zQ==
Date: Tue, 15 Oct 2024 09:49:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next v2] net: airoha: Implement BQL support
Message-ID: <20241015094926.594c9827@kernel.org>
In-Reply-To: <Zw6ZyoJCv0_EOnpf@lore-desk>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
	<20241015073255.74070172@kernel.org>
	<Zw5-jJUIWhG6-Ja4@lore-desk>
	<20241015075255.7a50074f@kernel.org>
	<Zw6QUxpdnJtorc_e@lore-desk>
	<20241015090952.6bcb5856@kernel.org>
	<Zw6ZyoJCv0_EOnpf@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 18:35:22 +0200 Lorenzo Bianconi wrote:
> > So to be clear I think this patch is correct as of the current driver
> > code. I'm just wondering if we should call airoha_qdma_cleanup_tx_queue()
> > on stop as well, and then that should come with the reset.
> > I think having a packet stuck in a queue may lead to all sort of oddness
> > so my recommendation would be to flush the queues.  
> 
> ack, I will post a fix for this. Do you prefer to resend even this patch? Up to you.

I'll take it. I don't think the stop rework will be a fix.

