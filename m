Return-Path: <netdev+bounces-177473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE163A7047B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0463B16F1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D943F25C71F;
	Tue, 25 Mar 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To8MPC85"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE325C6F8
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914811; cv=none; b=nAodAp17pQEG7pkRBHTkeqSDwpyPALG9p497XaneE2knhRDPl8hUOTeqRu9rGdhT9/l8jFX+rt+SBEDw4p4Dy54+UJMeAx8a5Pxz9SXmQtIidPNaXjGpcBhfpOei+XZU1eakoTLtPFDlgj/oUWas3oHBA2rimTWNdoghcXCF0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914811; c=relaxed/simple;
	bh=WaU/c0h+tGAATC4kS6vxy9TMJWbnhmBjIwstrx0pEK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bSTWYarZcF4fovrCVxKiVQwS9ARet0WdtwsgQHlJ3l/+/9Au7+4cn4etDJp4H1KzlShEXpz7ItGMebHw5/emtaYU9aFhy7wrOQixtFh0/cwhZ61K1sJe/yz5QIQWecg/ivGF3sh5PrdFm6wKLtJscPSJbnpxdP2TcJW6zeFt2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To8MPC85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341EFC4CEEA;
	Tue, 25 Mar 2025 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914811;
	bh=WaU/c0h+tGAATC4kS6vxy9TMJWbnhmBjIwstrx0pEK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=To8MPC853X3QBVXICcWBAGDnP2ZxIOYditbIIFDmUyTx4bBL95XN5dvtVVwCLnF7b
	 VtvmaV9zBx3zB7a8zeJiTxLguxshmc33dc6xE9GrGPIX3tTTnrZQeiKOpl9XznvxBe
	 YQXRBZ0BSTJv/1mV+XWDQJcR2JiVtyqJ93J9CbF7W+of0lkFFOlT6bNLNn2K3Um9ZM
	 wZbeWHSM6Mffc7daYUO1f6YCM6fXm2sTaBFUX2kraJlXyWfFT8pJiS6aLli44R5h13
	 vl06jUwHApOX/hs/Mff2aGOhG41TfhZ6eFP9iVw3fbDKmddV15DENVY/Vt+TE1yp33
	 pdaJdAT1i9COg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE31380CFE7;
	Tue, 25 Mar 2025 15:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: avoid atomic operations on sk->sk_rmem_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291484726.606159.5377223002671909937.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:47 +0000
References: <20250320121604.3342831-1-edumazet@google.com>
In-Reply-To: <20250320121604.3342831-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 12:16:04 +0000 you wrote:
> TCP uses generic skb_set_owner_r() and sock_rfree()
> for received packets, with socket lock being owned.
> 
> Switch to private versions, avoiding two atomic operations
> per packet.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: avoid atomic operations on sk->sk_rmem_alloc
    https://git.kernel.org/netdev/net-next/c/0de2a5c4b824

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



