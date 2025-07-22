Return-Path: <netdev+bounces-208950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92709B0DAA5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6997A2D29
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE12C08B6;
	Tue, 22 Jul 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llEK+/Tj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03228BA96
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190388; cv=none; b=YBvJRa7hj+PkmmvXUfByO/j3V3CI6/ClOMSSmwV1xO7GWVB6S1tMmNV7nR3Vqg3fbdW1pXwAPJcpOz9f3LY3zRllRcy+at0X+WimF4Zp4WyLXOscxKCWCpQ2RDmDFQXlxzXG0e38xLh1cQl8WXlqHmpiAlbCWhVURWge8DcBqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190388; c=relaxed/simple;
	bh=EOUEFcX5YMS0VQlMFjStfuaBMv69udOXsuXdiFYXua0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQDzIkN234TPrGuiMEm1L+uqZgrvW3/I+JENPIh5ClEqSKBnZGqKu5F1RY5Yg41GIeg6fmRbnYQyDlFwaTnKkscJLTTD+VbZwZtgbQUBVcbGn1nLWj/1ZikWecL9lyRkDhwfl6KqBMCptkHtYwOiNK8Zwo7LLyN3xU2vCRTL2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llEK+/Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C970C4CEEB;
	Tue, 22 Jul 2025 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753190388;
	bh=EOUEFcX5YMS0VQlMFjStfuaBMv69udOXsuXdiFYXua0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=llEK+/TjVjIbZT20yjBUA72UyE338a49pBeh3LR+0wGjbmeI3yhyKhrPajmD8MDDz
	 WUGdtoKnb+XxHldyHRRtqO3XoREotJ0TxL1ZGkjf5C33Wz6mNVAldHqirC3A56JJSp
	 W76vpFIjVhLVbPe2rY+73eB8TGSqVMuZ0t82N+ld5BWrQ9Kl4rYbkheAyqjAc5HDKn
	 yTdMmlw3n3bi5/xQ0XNE5Iyin16XNfFcSHNm27EXk5BQwcWZ3C6p6zigtuO045ULN6
	 odsDpOHzn8SbDuvl78NtX22+mNU5mGF8QfwFzkuOMa3AATdk606rirTWRupYmO3rn6
	 5TRWq5YaYu7lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB325383BF5D;
	Tue, 22 Jul 2025 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ibmveth: Add multi buffers rx replenishment
 hcall
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175319040676.805808.11285306488247395666.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 13:20:06 +0000
References: <20250719091356.57252-1-mmc@linux.ibm.com>
In-Reply-To: <20250719091356.57252-1-mmc@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 19 Jul 2025 05:13:56 -0400 you wrote:
> This patch enables batched RX buffer replenishment in ibmveth by
> using the new firmware-supported h_add_logical_lan_buffers() hcall
>  to submit up to 8 RX buffers in a single call, instead of repeatedly
> calling the single-buffer h_add_logical_lan_buffer() hcall.
> 
> During the probe, with the patch, the driver queries ILLAN attributes
> to detect IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT bit. If the attribute is
> present, rx_buffers_per_hcall is set to 8, enabling batched replenishment.
> Otherwise, it defaults to 1, preserving the original upstream behavior
>  with no change in code flow for unsupported systems.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ibmveth: Add multi buffers rx replenishment hcall support
    https://git.kernel.org/netdev/net-next/c/2094200b5f77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



