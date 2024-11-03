Return-Path: <netdev+bounces-141332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF099BA7B9
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247C52817C8
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6318A6AB;
	Sun,  3 Nov 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcieTXmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896F14F9E9
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663424; cv=none; b=tcHE0EzucrVjgeyYM9dhKjXr1FbSmX/DK+ayRHbLMg32wLsO3KVkZaulHbzO1JCgEwFobb8W/CP/owyPZnForlKuNWXKMaVdttIj1TeeFiL3/R283VWhuOWRUQL8u4D4ymkf9w74+6zxtC4nvyMovf7QypUykKBmeN2b4DfXVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663424; c=relaxed/simple;
	bh=Ypbd15yIw2s1Z8w6mWrmifXgG2SzsMfQdISET86SSmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ilYdx7S4x0WLRb977CU5u1cPMwn9rwyKLK4iZYgGmyF2asj1k7PNW8tnTDXYUm1i2oSOxU7574mp9wO12w/ScCqA/T6Zuuy0hpb8eIxbZJewkQmahuDpZ8zUouXkkATJGCIX5DJ8blt/351U7HQucq8PJr1mpuxaY+me+m9onJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcieTXmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35C5C4CECD;
	Sun,  3 Nov 2024 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730663424;
	bh=Ypbd15yIw2s1Z8w6mWrmifXgG2SzsMfQdISET86SSmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lcieTXmQNr0EMVdcmIYWA3kb2ssDDEyXWXGAAj3Q+O7J/6HWuJq4Mc3OOjkPCObIw
	 Wz/Fjr+SnFh7x2CXGuXuL6XWfuMypc7w5/beclN7G7v6VpijUkb6cV1Joy8AjXbljq
	 NT+m3I6u7YL5lHrTgrMQN8s6p2HWqPT4GclJ74+fOOrcLeguY4wNGO9g482odaxCij
	 Yex+PB54+1Dfa8UE9SvZt3s/nG0EXrJPsM29eJBCwKb43J7GBGVyDedf7HXVXwSotC
	 RFMReuydX1AxAUt5mRRMU+JadjEjr4twQ4akOefbUQALTeidT5MFWHh+g2LikuUTzE
	 a6uphw00Ikp6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC1E38363C3;
	Sun,  3 Nov 2024 19:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Simplify Tx napi logic in airoha_eth driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066343223.3240688.14365751396868795673.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 19:50:32 +0000
References: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
In-Reply-To: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 13:17:08 +0100 you wrote:
> Simplify Tx napi logic relying on the packet index provided by
> completion queue indicating the completed packet that can be removed
> from the Tx DMA ring.
> Read completion queue head and pending entry in airoha_qdma_tx_napi_poll().
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Read completion queue data in airoha_qdma_tx_napi_poll()
>       net: airoha: Simplify Tx napi logic
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: airoha: Read completion queue data in airoha_qdma_tx_napi_poll()
    https://git.kernel.org/netdev/net-next/c/3affa310de52
  - [net-next,2/2] net: airoha: Simplify Tx napi logic
    https://git.kernel.org/netdev/net-next/c/0c729f53b8c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



