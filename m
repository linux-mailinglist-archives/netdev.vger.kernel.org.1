Return-Path: <netdev+bounces-97802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D88CD507
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E76B22C2E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59713C693;
	Thu, 23 May 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf/gE9r/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E391E520;
	Thu, 23 May 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472233; cv=none; b=uBjBIPZw3phm6FygI3CenZfnxrz313ZWNZHTEh/K0qx7hzB7xWJMyb6XF5XiQmcMdAxeR8VgwlTVD5+aQ3T9ATPJl7RBmJF10ashh2zofPWVu+doHPnLeVmdb12agllDEQn/NT/clRfjP8QMg+YoN2j0mSF+PSPoW3GK+Mx9C2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472233; c=relaxed/simple;
	bh=0FPVxqB8MsuRU7zVBGwoH7CD4rdtZo3sn9+8u1bSIEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ns0phGDLKKLWqgjEvsZUEIRKiI2O+0t48pwLTBL1uowXxcoxkkVnQqLxCXu68FHMhcUnxlBNlW8vUIn8ms0Ko8M7yjqa6x805PWAPiohmbLAJECxe0BynCjKvsF9xJzScX3i7LSLiy51P0IeCA74V7M26QrLBf4g1ZC8S7ZVVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf/gE9r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 734C5C32781;
	Thu, 23 May 2024 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716472233;
	bh=0FPVxqB8MsuRU7zVBGwoH7CD4rdtZo3sn9+8u1bSIEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jf/gE9r/9WlOfXaseYRYcUo6kh6mQ9PcUTEmKHL5UOxEDlQd9XeVsGHXmP930rUcI
	 zPM6TVEpFgcNUsLDiX4vmBcUmEdooRftz9/2oUpgLaLvMnyeRY6k2QwJnb+VoD7C9G
	 zdjXjUNLwlYQ+Og8TZfJhNYu/N7M9w1izlV0mzAij3JDmB0ZRBs7QPnRJR2gtL+olg
	 a3RiXdh5AtbbLWm3wWbRORW2r2AgxGbBK3Ht4vkknCg2sAZG3qpVoMfoguRJf9bHI8
	 n2TwJwlAmhVdtbZnNFBeqNpLgTYK41S+nIvuFLsMX9TsFdbfSwCOdfgKhtIR68Hii3
	 WD1a36VcLJbpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D1ECCF21F1;
	Thu, 23 May 2024 13:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] r8169: Fix possible ring buffer corruption on
 fragmented Tx packets.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171647223337.20832.10658924978055829464.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 13:50:33 +0000
References: <27ead18b-c23d-4f49-a020-1fc482c5ac95@gmail.com>
In-Reply-To: <27ead18b-c23d-4f49-a020-1fc482c5ac95@gmail.com>
To: Ken Milmore <ken.milmore@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 23:45:50 +0100 you wrote:
> An issue was found on the RTL8125b when transmitting small fragmented
> packets, whereby invalid entries were inserted into the transmit ring
> buffer, subsequently leading to calls to dma_unmap_single() with a null
> address.
> 
> This was caused by rtl8169_start_xmit() not noticing changes to nr_frags
> which may occur when small packets are padded (to work around hardware
> quirks) in rtl8169_tso_csum_v2().
> 
> [...]

Here is the summary with links:
  - [net,v2] r8169: Fix possible ring buffer corruption on fragmented Tx packets.
    https://git.kernel.org/netdev/net/c/c71e3a5cffd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



