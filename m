Return-Path: <netdev+bounces-132905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645A993B57
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C631D1F246B2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B221C173F;
	Mon,  7 Oct 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pquGL2AD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92B1C1735;
	Mon,  7 Oct 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344436; cv=none; b=XL1q7aaca9gS+zL1h4BchsZMWJ0GpTUG1kSJooSdCoav0JX7choMXj9TpFZyOAVxYCc6HemFiUwwcMWG8to91q17QVPgdwEWdr2LZTeJ4GR9kn4mDn9i3VC2f6O7F2/FGjiIzh89ktLdHbYuVTl/6WF75Q3h2kUQYVbg5mKL5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344436; c=relaxed/simple;
	bh=SGETYmsZKUXFo7TaGMMNBKR1PTn6kxgtInZrcSU5fco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+4+LAIWXP3qTIFmxn3JM0OJKbe0jpv1jyZ7YPNvTeFiekm7wNziZQlTV6QtFDOlQPc6VFn7m4OX47HRXJMyAM6kzkd1FDbA44bANhM2BS4RAF4bmrOdzqLWr3Gkex3Ybtuu/t0UAW5eTcx06KDVMwbsl5HdUJHl4esTnCPCSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pquGL2AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210D8C4CEC6;
	Mon,  7 Oct 2024 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344436;
	bh=SGETYmsZKUXFo7TaGMMNBKR1PTn6kxgtInZrcSU5fco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pquGL2ADFxBuZYmD+GBV2PUpGl5eAYQSq5z0tG6DaFZ0C20ScoqExzgpVY7WGnuwe
	 CUPFf/pdLVHUf7QC9WNSrQP1Yx2p8skU02Myy4pT5ZMHLgssACD5XqDecCGZQ2bEwm
	 kinh0xz1VTDxhBsbLF6VXqnybMPH5cgGZhUpDEw7NOZ9m6RstIrwGW7bdpSfQSssfM
	 /mBy3ilyhiptgX4Sik2Qattzx3B4JYT7hJvBH2KGQmXXBdB6SDj4fjWfCuFuZ5KjAg
	 T6aogJGJ/R5h9zSGmuf2ceJ+BPMvSP6WTOtq1WGhHmqTnprflUsraTqT/OoBYyeLwS
	 wgQ1t7YybJqIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BBE3803262;
	Mon,  7 Oct 2024 23:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: tcp: refresh tcp_mstamp for compressed ack in
 timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834444024.18821.12180555939100702405.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 23:40:40 +0000
References: <20241003082231.759759-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241003082231.759759-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dongml2@chinatelecom.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 16:22:31 +0800 you wrote:
> For now, we refresh the tcp_mstamp for delayed acks and keepalives, but
> not for the compressed ack in tcp_compressed_ack_kick().
> 
> I have not found out the effact of the tcp_mstamp when sending ack, but
> we can still refresh it for the compressed ack to keep consistent.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> [...]

Here is the summary with links:
  - [net-next] net: tcp: refresh tcp_mstamp for compressed ack in timer
    https://git.kernel.org/netdev/net-next/c/269084f74852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



