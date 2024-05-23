Return-Path: <netdev+bounces-97764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264008CD0AD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF25928314D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC113D253;
	Thu, 23 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0e/+pTw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807E1C3E;
	Thu, 23 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461430; cv=none; b=GDDepekzE4cbFcaztlgzbJVHuaZYRew7m+LbzsCMyuMhVymGMuEYnntQXG425qInKwynuAV7dJC224zaj02QKq12AWj1roLABYbpQRBPWOjc+YbbXMUMfs4HLBdlMyD76TIURCISvbwKGsS+AvalHivUVj+uMro1Qb7GRvhab0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461430; c=relaxed/simple;
	bh=U3rQgZ1jsLT6vz+WXMunVVaPLcX1du4l2FEblxXiwTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b6j1w/HDCLXcFN/bCH1SvJAcCDK6aQMzZcWrXtexNFD81wDWkVajAnuKLxj5M4ikfkO/pt7qMkkIod9pyNO+J+YMJCtA8lkoc5bNHBSUAyQetaDAP3/pbOkgLFFNoDSXqnaVqOR4Y0QvK4FpkyMV/fLk/+fpD9CC7h04mbXv9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0e/+pTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0D64C3277B;
	Thu, 23 May 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716461429;
	bh=U3rQgZ1jsLT6vz+WXMunVVaPLcX1du4l2FEblxXiwTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g0e/+pTwI7tFYMSYactaqQ86rCoXTs7+8PkPQuryCASVVJpsF5UDLIfN0ixpSg5rJ
	 IcZZT5YTSryFAgXvAkgi043uwoVVUawM0JRQP6MmK0zHr3omxErz8agOSxkUpwJLUK
	 8ZT0bCp7tUH9XGuaTI0aDPgyeshPTxjyM182yCSilJqMtNMCuBMqDk+l4PjsnfJl+6
	 M65npRiYVtnGJJyHTBdeGBx7fVuoQ93qPNBNWvs+g8SgKx8xE/ol5FUGQjB6lnQytx
	 qo/0yaGZabBKZItwv63DsgecTCUmvDHqsWZzVmCI0mXK6xk1gUkazayuTl3kD7nAwk
	 urLZpZfR/1wBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C792BC54BB2;
	Thu, 23 May 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] nfc: nci: Fix handling of zero-length payload packets
 in nci_rx_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171646142981.5301.3498011653773354257.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 10:50:29 +0000
References: <20240521153444.535399-1-ryasuoka@redhat.com>
In-Reply-To: <20240521153444.535399-1-ryasuoka@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syoshida@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 22 May 2024 00:34:42 +0900 you wrote:
> When nci_rx_work() receives a zero-length payload packet, it should not
> discard the packet and exit the loop. Instead, it should continue
> processing subsequent packets.
> 
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
    https://git.kernel.org/netdev/net/c/6671e352497c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



