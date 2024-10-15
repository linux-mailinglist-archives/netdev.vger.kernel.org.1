Return-Path: <netdev+bounces-135709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD499EFA2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F47B22242
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0321C4A3A;
	Tue, 15 Oct 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc9G1Z1E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E71FC7F6
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002778; cv=none; b=Pkw9L4Jz+KfDP9z7cqlRF3QuQR56C6FFYdSNAERW4/9a9SfStHIVOHT4QEpjFXiTHAeG8JLL1qHIIJUxFkN8/03O02rQkToD6BTa31AAI26yX9BPJuU+wu1xWMMf0qTUAgq9UZYvzwVGS7aEm5khp942aEXPqo4125gFfrRux8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002778; c=relaxed/simple;
	bh=qiIdI+oKKf7EnhVJ9UTp2/T9X1iGlVqfTw1ubb8h0MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BffTQzix6NLy5dgLgjj2sX6d0eRTORFbh7b3FurNH6KS9HOX0JFY2Jcbn1HVwek1NBVlaJf1OUaMFz5uF3ytuVP5ErlwLtxJpmkMrb1TUNsMARKuk1/LIqUt2Ku8Xl93l02P5RcnyE0Nzco7CCg1rKisydBPvVS4PR/7TGCmE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc9G1Z1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D66C4CECF;
	Tue, 15 Oct 2024 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002777;
	bh=qiIdI+oKKf7EnhVJ9UTp2/T9X1iGlVqfTw1ubb8h0MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hc9G1Z1Efr+MQFhbIYFxZW5fRw3i2SaqqyRekw29bIHD7b+7ONrDfVlLdehPrNOs6
	 LRjuZVWnllcBrtbv6+fjnSKjEFqTUkC6Nc39en0PDl6pQF9GXeWeObklF8XqfzHfNE
	 G0JwdeHgWNJfFK6OuU/U3ySXaDCuXopuT/m/kzKrchWHQrPX8bJZ7Xt4X1ot6YIt2y
	 mlfR3eNeu4AO9/ptLwLYNaUnJinhOE//kzQl8A59WMR6EXNamg+/xBAuMOJYuPVoyN
	 bHcEkSaTq5g+K06G7XHolHUW+8am0ZQ2I8JSqg2mRy48rtVANI3bLI43+GgGnMjxFt
	 rarUoOMJnU5Xw==
Date: Tue, 15 Oct 2024 07:32:55 -0700
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
Message-ID: <20241015073255.74070172@kernel.org>
In-Reply-To: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 11:01:11 +0200 Lorenzo Bianconi wrote:
> Introduce BQL support in the airoha_eth driver reporting to the kernel
> info about tx hw DMA queues in order to avoid bufferbloat and keep the
> latency small.

TBH I haven't looked at the code again, but when I looked at v1 I was
surprised you don't have a reset in airoha_qdma_cleanup_tx_queue().
Are you sure it's okay? It's a common bug not to reset the BQL state
when queue is purged while stopping the interface.

