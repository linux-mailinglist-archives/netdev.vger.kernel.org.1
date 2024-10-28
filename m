Return-Path: <netdev+bounces-139718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D751F9B3E6A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F320F1C20F9A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79117190679;
	Mon, 28 Oct 2024 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4xAyje0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEF18FDD8
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158225; cv=none; b=N/9m9tQFIBGhyGUKlvb3VOYq3wGCvzx8ldixPqIHWHDt922pexcNyeXlqsbPaEpnMwNJOp4MXeELoylim9zmgdRjv25q0CWn7Q4C62En1lkjP07BiyQA+cP2Ow9rBVOO8epUKRaYZvB/gSI49aPNO/Sjhto3R4B5oWrw2dEbHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158225; c=relaxed/simple;
	bh=gTBtL/ex7jxveq6ta4PIW3b0KtAqTbtbzOW4AHpgbE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMwZfc0rBfe6NfuI/DoDbhNUXS+ToLhp+vqzbshJmiyIV/MQJm/Mf8nXFAIJ2dAQ+gf+oGi8DJr23gJvh7sOCtSzqYUw7QdxwB7526RZJ3VOhNG5OXtsWMlkjTGaQJthcTiZfnekh4fXLXlwtiVXtNEecWkAgyj4TkdGDAkIunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4xAyje0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC522C4CEC3;
	Mon, 28 Oct 2024 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158224;
	bh=gTBtL/ex7jxveq6ta4PIW3b0KtAqTbtbzOW4AHpgbE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d4xAyje0LzdkkVwJyCQy5tR9tZveFG06qIoS6/vdBcRbodRS+Kob4wxtwWzpHFMQM
	 O9Vc2kHqV1HBUAWbYxUmMmaH0Ky8uMfOFk6De5spnz7NJHyc2i4q7FLM9ivGYVjf6s
	 ld1iJ2naeavYopfZXcX58n4u+bToqkxqTxufzyQ1aXxVo2IJ8bG5U99tZtSHAf6NfX
	 MEiG+N1oMQoaMRhhLbe/LnTKu24Zz0elU7p3BjKvnfaKEBAsjRmPveh67/5+Te4+ja
	 PmrzpbFkUSLDJhDg6HdrqN0VmCJD1iI+I3it0T1Za30zGpLV/B6SAL6WWypCPL9VLG
	 gkm+dvm2I5G8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B2380AC1C;
	Mon, 28 Oct 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] macsec: Fix use-after-free while sending the
 offloading packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015823226.212000.8120352168152068818.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:30:32 +0000
References: <20241021100309.234125-1-tariqt@nvidia.com>
In-Reply-To: <20241021100309.234125-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, sd@queasysnail.net, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, jianbol@nvidia.com,
 phaddad@nvidia.com, cmi@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 13:03:09 +0300 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> KASAN reports the following UAF. The metadata_dst, which is used to
> store the SCI value for macsec offload, is already freed by
> metadata_dst_free() in macsec_free_netdev(), while driver still use it
> for sending the packet.
> 
> [...]

Here is the summary with links:
  - [net,V2] macsec: Fix use-after-free while sending the offloading packet
    https://git.kernel.org/netdev/net/c/f1e54d11b210

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



