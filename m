Return-Path: <netdev+bounces-224947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FFB8BB04
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71167E0A50
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33681F2BAD;
	Sat, 20 Sep 2025 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyMucRm8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1311F2382
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327630; cv=none; b=CQVPTemt2rpVtj/7lnMG830HMOyqlgHRMGHFH+Lk2CJ+d5Hm7RL01FEJPu5PMtmR0kgztNv0MDn8KBrnwsd6fGFY88J06E/7xM45z7k5iF7oEhzx6DPCUy/SrX9dagH6gABGA5T5cUuo7Vft7pZ6190F/jS7ZNznZ02nX1H6TEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327630; c=relaxed/simple;
	bh=kp7YWAup9ZBurIU7D//+YN/nbbCGn70enNCLaEXkjf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tY7K3KV1kZewI2+U4KIyWgBnkE13eP1cha7NFQcRtbN81w4Y83Yz7Nrd8cPKNzmMyhs7zAJfa1nhcO8f3jvfpTxV1R7/171R9ohKksq2f9YzwhmtdKpvG8YkEQAFyja27cMc1OkCt05TypXvNyGxgokc1Dq550nbG5l4JaeTo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyMucRm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70887C4CEF5;
	Sat, 20 Sep 2025 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327630;
	bh=kp7YWAup9ZBurIU7D//+YN/nbbCGn70enNCLaEXkjf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eyMucRm8PDVmkbrk/3Vc/DKey34rkvlz56el1PUPEQQZtQtRevGHvX1yS3eM1zpWu
	 XxfRIRX02db7BxnIZoIrnGmqNPkVf6uWkL/NF+1HzTOWReMvu3z/trqeUM+Y7nxPvo
	 RYxys+HoD0BtSVSf3lmX46OQ/sly2GAngLoOVdVmeDdPZbgGCRd11RQ8qPSfaNdA8j
	 sf5IyxcFuNR0tn3P/cKs1VytXnIWklpaWlHaHJ5ivN0LYPMWeHYIJYw3EVSzAPXTIp
	 0xCSpIPKprRE7/DeNxcaT9UJONKmaBf7KZKfauYXJDsjR4K1ytRnXkSL/LdraA6Tj8
	 IA2BuXKi91xWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACCC39D0C20;
	Sat, 20 Sep 2025 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] psp: clarify checksum behavior of psp_dev_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762949.3747217.7655231303829787715.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:29 +0000
References: <20250918212723.17495-1-daniel.zahka@gmail.com>
In-Reply-To: <20250918212723.17495-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 14:27:20 -0700 you wrote:
> psp_dev_rcv() decapsulates psp headers from a received frame. This
> will make any csum complete computed by the device inaccurate. Rather
> than attempt to patch up skb->csum in psp_dev_rcv() just make it clear
> to callers what they can expect regarding checksum complete.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] psp: clarify checksum behavior of psp_dev_rcv()
    https://git.kernel.org/netdev/net-next/c/85c7333c35f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



