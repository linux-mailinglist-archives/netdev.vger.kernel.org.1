Return-Path: <netdev+bounces-120761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494AD95A8DC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415261C220A0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906816FB9;
	Thu, 22 Aug 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIiEb07t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD84C99;
	Thu, 22 Aug 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286629; cv=none; b=XO4wFiqF7b2leXf8Njrm/8MUr3g4qELmrCGjTOA+0rJwHcZvu+HZCbImZ/fcNCSVdmaLa/es+BE0MMZeF7D+mLe7m09dUqvg2aFF+lKeY6lefmtJCZDtQj4nYuGReD291jJ5IkL3wNLvA+e5GiIaAMUm6xOo5pgmoKKoL8Da1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286629; c=relaxed/simple;
	bh=/vPWdiwC8U6rUVR/97LIJfgKmQ/76JxWfWoos4Ndpc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NFXiWK1D97WbVIuu7/xjyUg7N5yR3lZile23WP4tSAleELcpbOjf4d+el7edaUZIoMx+pcJ/yFlFas9yiNzHmEYFXlnZ6cJTdA3eyqKGrdE4j+Fwxpn5E2uyQm+XRqBcuYHl2m5wLl4PoF3TByiPKHtRL54vBPZu9F3JXg1c3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIiEb07t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C5FC4AF10;
	Thu, 22 Aug 2024 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286628;
	bh=/vPWdiwC8U6rUVR/97LIJfgKmQ/76JxWfWoos4Ndpc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DIiEb07tyzg4M32GN0YFM3egshmM/9YIGCXDpUy4LD4ALERpVpxpxBd3U6tSQdtQ5
	 ZIDfSXhnPNkcsPXDvFF25F6GiIndEojrQ2l7oX0x9tlyYGIQJur9B79tIAeKowa9kY
	 JYHIg9EzZzQ3Hrul3UNHFht4hvJiC/8JzV5JWFSHNuRMASP79PL0dCI2pLmxoCjAMj
	 7G/CpT2mmQ15trHi1SmzR0Cx/ZpIA1joFJHUQYojOxkPzcFiDsADS1vuuEfHD5adZ0
	 aBHstPTfxIgagM+APa0enPUTxFGZzrlm7noXhLGMmljk559GUyWDeea30V4f0d/zRx
	 duGJoYBO31Ipw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC93804CAB;
	Thu, 22 Aug 2024 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: fix receiving fraglist GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428662849.1870122.1430198362940131383.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:30:28 +0000
References: <20240819150621.59833-1-nbd@nbd.name>
In-Reply-To: <20240819150621.59833-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 17:06:21 +0200 you wrote:
> When assembling fraglist GSO packets, udp4_gro_complete does not set
> skb->csum_start, which makes the extra validation in __udp_gso_segment fail.
> 
> Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/udp_offload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] udp: fix receiving fraglist GSO packets
    https://git.kernel.org/netdev/net/c/b128ed5ab273

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



