Return-Path: <netdev+bounces-193781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD1AC5E83
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE5F7B12DB
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE791C7009;
	Wed, 28 May 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuKiHcdK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F41C3BF7;
	Wed, 28 May 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393399; cv=none; b=PmfOrIZ1bDoUUSvJm1AV7+S28M+M9bz9LZckvAwLwMAagj8Z2R9rJFTGK3W2j4fdPnmiyFcnsyKDCzvsWKf0ul9kjf6PK638ESM3SI8P2h1fGQsuN2Pnk4UkEsvSrFvchWRZfTQCNMniZoX7YsJFNGSEhg+PqzoXAZzFHusxjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393399; c=relaxed/simple;
	bh=CfqVPgulqZestb/yPNFJQru5z9P9asOFSloEWbORY3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bd784K20P6G+VZnt9BWkz5qkXaOuofHecoDGSfnAzlDoFRll5dddL6NmjqJxdhIk4H2QF/rzJQpv0pS9wbrrX4OeIXKlkOP95l3SS3YrXJbXP5Xqd/ifvjfjlXXGriBP2iYD5HK2OslB+CTyODkm6Voh0gSsuZ96yhjhuwcN2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuKiHcdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17999C4CEED;
	Wed, 28 May 2025 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393399;
	bh=CfqVPgulqZestb/yPNFJQru5z9P9asOFSloEWbORY3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZuKiHcdKz/TbDOo1ZDkFcDVIdEWmQ2y9oFEVDTbpMEZvSbQCMSAhq2x+IuTekBHNV
	 9TOTPmEuX6FusfWxuabVwb1HktdypjecnZkPE414o2yw9Lh6bSrnQUh1RiKZcSNqpP
	 dq1405TgknJ8AEppaPwwhqna13/e9tF8SAvpxkIDuC6tai/ztqX9HsS/rau9oF4O2w
	 XKvH9vFynmjs1ALmWnH2h7XWrerKHuc2HCek8OG0ibgZBlYU5sfYKgyIRfqO7xRK2R
	 Fn3emF/cJwIbOsanuLdHoXoEYznHuSIqwUtoab3u1kJKE4y8X6ehvxS9D8GmRLXU9h
	 mpLwMoOvMibdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71120380AAE2;
	Wed, 28 May 2025 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839343325.1843884.14339456243155225714.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 00:50:33 +0000
References: <1b94b91345017429ed653e2f05d25620dc2823f9.1746715755.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1b94b91345017429ed653e2f05d25620dc2823f9.1746715755.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 May 2025 09:29:11 +0200 you wrote:
> If register_netdev() fails, the error handling path of the probe will not
> free the memory allocated by the previous airoha_metadata_dst_alloc() call
> because port->dev->reg_state will not be NETREG_REGISTERED.
> 
> So, an explicit airoha_metadata_dst_free() call is needed in this case to
> avoid a memory leak.
> 
> [...]

Here is the summary with links:
  - [v4,net] net: airoha: Fix an error handling path in airoha_alloc_gdm_port()
    https://git.kernel.org/netdev/net/c/c59783780c8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



