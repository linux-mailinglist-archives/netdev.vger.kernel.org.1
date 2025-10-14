Return-Path: <netdev+bounces-229198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9739BD9160
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7403A4B2F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8B2DC359;
	Tue, 14 Oct 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siYWm+7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3712296BD1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442383; cv=none; b=NSVSmNrBirFfFMQN+CTFcqtiWH0Dk+EREsoEZloGEZ4wbcCVM3TyXisDKDQc16YE0Ks0CS6XM95zhjlZgdGcB9RddnVLVzH8FjogXxP2JCRXsSIN2d24inL1HTphAvCG1/kZt1ww7MGFcSSUQBaVd6YFbF/KkjkKeE5f4kkFdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442383; c=relaxed/simple;
	bh=WKayDwfPOkpRvbADRbbwCtSvR3EOhJFvSghU0m14F58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRkl+beQG2wLvDgSHocXVQuXrIHX9tKjPxPrEabKWKayIjnTat96mcXhsrMq3chAaAd+WG2w4CtGypHoP3lnCuKu1T7YwuCUUa6Bd8dTXUpcdeF4xgoSCAkvmp8fYa0IWh+eZ2t5JCROJj42jEDzYvfvEYIaBCtPMKCbj66KhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siYWm+7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE49BC4CEE7;
	Tue, 14 Oct 2025 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760442382;
	bh=WKayDwfPOkpRvbADRbbwCtSvR3EOhJFvSghU0m14F58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=siYWm+7oXvRfUExM1AUHo4jr1PgfeFJW4/C0fsk9UZkj1ZlgTUAFutq7E39Sn8ywk
	 oN5QIWTAyYj2uP0vsJvf+hGwK4j9QSMx8SSgQNot9jTwlDoFYSdAGB18yFax3ZN/yS
	 b89RNCBNcbspQ4KreCfQ1s3rlO67pUfJFEoD4tlx+oiosf18OOnycbqgyxbQtZoRqh
	 3zxjd8g3thkm1i/TnhzcQnrTC1gHqBYSKKzU/lum4LEVhJnybtOU4cx+3su5tCJmpY
	 7nvsQFNi3F2M2wsUkLJ0kkPgau53LPp3QIO1DkdR4mqY6hhoG1BCdenPnjHne/KT6J
	 BEXgUXkB7oapQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340EF380AA4F;
	Tue, 14 Oct 2025 11:46:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176044236799.3633772.8727248209077665958.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 11:46:07 +0000
References: <20251012-airoha-tx-busy-queue-v2-1-a600b08bab2d@kernel.org>
In-Reply-To: <20251012-airoha-tx-busy-queue-v2-1-a600b08bab2d@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 12 Oct 2025 11:19:44 +0200 you wrote:
> Completion napi can free out-of-order tx descriptors if hw QoS is
> enabled and packets with different priority are queued to same DMA ring.
> Take into account possible out-of-order reports checking if the tx queue
> is full using circular buffer head/tail pointer instead of the number of
> queued packets.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Take into account out-of-order tx completions in airoha_dev_xmit()
    https://git.kernel.org/netdev/net/c/bd5afca115f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



