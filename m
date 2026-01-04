Return-Path: <netdev+bounces-246808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66313CF1418
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 20:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A8830222C9
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAD314D02;
	Sun,  4 Jan 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVnGkiYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BC314B95
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554174; cv=none; b=dpQ2iqbAmj+IZA5YHG2lAveawmMiTmGrig9zvo/Jj64pNJ+AazlI20EDdes/JGeePqWr9qGVXX6LXmBneibjHunn0Zec3wiVWlt5aMeIrU1RWsK116mjLDFokHb2B/8V19QbusL+94fwxmXRwBAQy5PshbbPA19oPTnYukyJOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554174; c=relaxed/simple;
	bh=K5yrJvyg0iz2WjTqNqO9rSIdjM4jCyGRHAZYXKmOzKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nxWUbN51ou/G/BBj6WtMSTQ2Ye9EtsjprEfTjz3ezHTcCdZ+Ac+m0pp3Tq55oXslxSJY4dPmJJtzA8AFGf7bvnWQBQaIFTYeVNDeDUoZEynflksmOuEurv8yDvPdVdLXHxLFOi0wc58pA1muwHB+DoEo0XaFgkoUgFjDpM2MIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVnGkiYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28771C116C6;
	Sun,  4 Jan 2026 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554174;
	bh=K5yrJvyg0iz2WjTqNqO9rSIdjM4jCyGRHAZYXKmOzKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UVnGkiYeYZ3oa2F4X1FB/HBL5DkAcQXz3IoSQ7MKA+vvMG91V4QVB4z0LUYsbN7hm
	 cyZmzKXb01Ggz5NHFnycmdnKzc5gbLwmiyJ7RztUyc+JHVuG7SsX4zT6QGMEtblDHG
	 cb+4LzbXHcd6ZoYKkS7uUgPrxVLGZZ5/nn22Yb93KthWxqwBFVW/B8Z7JZFlY6pJdz
	 zUNR54bLMZGtLwS/TwugoPJYekWuyFeLEh9yXfzAJGVIEFbYpfm5GCCLE9m8FXxjxp
	 FFC5a7aizwworQQjuG+acWQQuFewM6U0bVjnNw3QgR1aWMkWBfFZd1SsbQdL3CPRV2
	 Gnq9FbaXxiQsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B981380AA4F;
	Sun,  4 Jan 2026 19:12:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: Fix potential data corruption with HW
 GRO/LRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755397287.149133.1915323476983378414.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 19:12:52 +0000
References: <20251231083625.3911652-1-michael.chan@broadcom.com>
In-Reply-To: <20251231083625.3911652-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 vadim.fedorenko@linux.dev, leon@kernel.org, srijit.bose@broadcom.com,
 ray.jui@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Dec 2025 00:36:25 -0800 you wrote:
> From: Srijit Bose <srijit.bose@broadcom.com>
> 
> Fix the max number of bits passed to find_first_zero_bit() in
> bnxt_alloc_agg_idx().  We were incorrectly passing the number of
> long words.  find_first_zero_bit() may fail to find a zero bit and
> cause a wrong ID to be used.  If the wrong ID is already in use, this
> can cause data corruption.  Sometimes an error like this can also be
> seen:
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: Fix potential data corruption with HW GRO/LRO
    https://git.kernel.org/netdev/net/c/ffeafa65b2b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



