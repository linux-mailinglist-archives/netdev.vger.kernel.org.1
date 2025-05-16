Return-Path: <netdev+bounces-191225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB60ABA6BC
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E851BC7273
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930027874B;
	Fri, 16 May 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI1Wicrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449323644F
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439392; cv=none; b=phVwBAvpQ91+H4AYhx8Q0qa3uk99mdxhWqNNHjZhluettgyXfPMfEl0z4v5XXn6P1R7DisyCP7hEFBsKamEcM9TV3Krp7WetfGmj8sHVF9hi4x2WlwSTQuCTiHkytStoSe9nu5kZEFmYefjmbBVpxnqRwwPP6yJT4sgUb5RuNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439392; c=relaxed/simple;
	bh=b6wGr4nm8FmvhV7tpeuwJouVaFkxQSU7UDHKGORepGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hebzR0kcThHSqb/5o+AVqvmZsx363eD4iM+3XQgYz/xVMHZs/mKjeYNHzOP0gMrwPqzX0cZtk2puKMBKMW92wTNTUuCh33j9pMYTu4QkryxjDdqA4X3mW9AZrVz7CzDkfXOoeIJo9vjnTBC3QS0mR92mmCg5YsqKR8bKvT5Ukzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI1Wicrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4120C4CEE4;
	Fri, 16 May 2025 23:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747439391;
	bh=b6wGr4nm8FmvhV7tpeuwJouVaFkxQSU7UDHKGORepGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JI1WicrfpAAd/Sa/1/MCZHdS33jVEdrHOV2wmp5eT9wukgNroKm2zw85ABQnMF9po
	 SQkkVQHjTFDGxJqXyRbV5Ah2gPnvuZf0gyyCIEJxoR0wSHAxTbYgb7M+DM1OfIaxJJ
	 +7ckNvnBJ0TZzE0qug38rEk7s4Lg1mlqAaOLC0SbpLqz6/R9C7gVfLJ5vufqADD2hX
	 sNZUamfCL4JSsoUmZ55s9qZBQyEnG9jAGjwOnsJSq+4qkYPUqBXjcleX/BeS97SkCN
	 Rqb+wKtAatJ4Y4xUIa9c7leAS9HfHcQ3y4gimPB+zYPkNSEqHUx+KIoQd3slFR0dJ7
	 casHz5V5J2qow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0933806659;
	Fri, 16 May 2025 23:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Fix page recycling in
 airoha_qdma_rx_process()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743942851.4098936.12041671721533040373.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:50:28 +0000
References: <20250515-airoha-fix-rx-process-error-condition-v2-1-657e92c894b9@kernel.org>
In-Reply-To: <20250515-airoha-fix-rx-process-error-condition-v2-1-657e92c894b9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 08:33:06 +0200 you wrote:
> Do not recycle the page twice in airoha_qdma_rx_process routine in case
> of error. Just run dev_kfree_skb() if the skb has been allocated and marked
> for recycling. Run page_pool_put_full_page() directly if the skb has not
> been allocated yet.
> Moreover, rely on DMA address from queue entry element instead of reading
> it from the DMA descriptor for DMA syncing in airoha_qdma_rx_process().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Fix page recycling in airoha_qdma_rx_process()
    https://git.kernel.org/netdev/net/c/d6d2b0e1538d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



