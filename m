Return-Path: <netdev+bounces-206306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F6DB028C6
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 03:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9626A167F06
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6813B5A9;
	Sat, 12 Jul 2025 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATgotfOX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BEF1E487;
	Sat, 12 Jul 2025 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281984; cv=none; b=SCbsyEFo3Kl7qqZvM53kRjyhrWSUdY6oDK1iy1eptrTCevu59gMbgJfuumYVnet/OhuzM4yhVyH707KvOUqHAvG0WnqWUjxe9G96ZEDzqxHeYql4GZUaQfvlHbvV4TFhHS3+FSPxfP7JB6ecQVBKazvlj8i3ZP8HCa9s+x+EEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281984; c=relaxed/simple;
	bh=Hye0BFH1APFxLA6XWqKMNPEqihZOu0d3cyOZ0mcmpro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gEfRhN1RttZbg64NGNWt4jxF33RnpP752jSi7XCZyf9GMVaxwaE1aeRYz6Ybmtk4rpBUWRTPNxbm+tI6Ov1BaSdl0wmMWoF72C9zuGkNwAQ6q3BYZANzmS4motHX7jLPg0kO1b8OpbfeqbFBdL63QH1DC2xl3q9Iw7ussg1Cgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATgotfOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA66CC4CEED;
	Sat, 12 Jul 2025 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752281983;
	bh=Hye0BFH1APFxLA6XWqKMNPEqihZOu0d3cyOZ0mcmpro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ATgotfOXXMGo+vTbbfjxVvFMfzW1SfJV1C/jLm8GvKrT0LfUeLoRI2nLo/xTVN43V
	 ZsZVQRyrZu56wLGqXwxY/NcICZiVeKebPrDun2EG2cTX7he8QNgjen3WPRB31DFMTw
	 XxMw80hW3+Bf38ke6IM+KU4a+vhccBNIAFvqllkcYLM7PRy3auRNFRN4OiQ9TMbNij
	 pXpMxR0M5a9w+SGanK0yR8zkLrkaPaBuo4BPONAGk7lz2oQCayXVt8Cd4VYjjiO8tQ
	 1i0TOW5UB7Xk5GGUJ5EC8lir7/IEw6wEwdCDvJJCNQo3d8aQMczW8eabM2EFiFZNDy
	 gh47vVkK21Hyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD11383B275;
	Sat, 12 Jul 2025 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: emaclite: Fix missing pointer increment in
 aligned_read()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175228200576.2451869.14862021372428501844.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 01:00:05 +0000
References: <20250710173849.2381003-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250710173849.2381003-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: abin.joseph@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 darren.kenny@oracle.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 10:38:46 -0700 you wrote:
> Add missing post-increment operators for byte pointers in the
> loop that copies remaining bytes in xemaclite_aligned_read().
> Without the increment, the same byte was written repeatedly
> to the destination.
> This update aligns with xemaclite_aligned_write()
> 
> Fixes: bb81b2ddfa19 ("net: add Xilinx emac lite device driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net] net: emaclite: Fix missing pointer increment in aligned_read()
    https://git.kernel.org/netdev/net/c/7727ec1523d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



