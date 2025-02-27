Return-Path: <netdev+bounces-170087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD02EA473E3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918313AD8E7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798DA1EA7F3;
	Thu, 27 Feb 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr/7qiXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4E270031
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628803; cv=none; b=DfAJF+ADcct0bgQQulC3CgM1OinAKExT+Dz4RxJ1IzXfp1uOaaIc60nB+umdqGV0R94T/IVj+YXouu91cwGn6tYmtGb2s1/NiBQds98HnAArwbv9OMurjEE+dUMikGnvqBu2ConpMi8PxIy2EAg5AnRIlONweDSFJItlRt7AWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628803; c=relaxed/simple;
	bh=60YtClcORqYLLZhjdQN1g9T2hOXxpbaAlj9iALGeMOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M+lP/seIEogs4RjzqZyCIHjCokMRoBdc7bUzTK3/7ISNaxJCSmF/x5XDSJDNATQbJAlZW3mYwkdcB3k9BUfuuplF1ujQFT54yRhKInLsv+LU4Zz7PVP1J5WXGxihdo3FoB3BqK7uQQlQoCz41m1kOfZwuMOPb2OyQW2PceygQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr/7qiXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63D5C4CEDD;
	Thu, 27 Feb 2025 04:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740628802;
	bh=60YtClcORqYLLZhjdQN1g9T2hOXxpbaAlj9iALGeMOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yr/7qiXH/X4UzvRVEheI1El+/583DumERS4DzLWjLpLuFglyVvnB0BrMfHBC+hJrC
	 wSCtGRnNK9bokUks82YPUl4VPZZMDxPDzntSx0QATJgdELLtobh97S3BXx9jzKhcef
	 rw2T0WAcMLmcQRPYPn6guVekIivmEkxAKfxnpfoueWr8y5rp/qbJs8q3I3eGClrTHp
	 Uqfoa7bDVlEy3N5IWxsQPRc5GZzyJFaJk6VhOmiF6C6uVED4fV6/REM9xfJWisvakQ
	 L0t9Mqd9ADXjdZ0pfDN8g8mp2kLFDLeMyGCptYpTezyxk0I5Z0+07GHK2/8mWOBVKt
	 q39GzUv5bJY7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE22380CFE6;
	Thu, 27 Feb 2025 04:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: skb: free up one bit in tx_flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062883448.960972.9031773189651154624.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 04:00:34 +0000
References: <20250225023416.2088705-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250225023416.2088705-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, kerneljasonxing@gmail.com,
 pav@iki.fi, gerhard@engleder-embedded.com, vinicius.gomes@intel.com,
 anthony.l.nguyen@intel.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 21:33:55 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The linked series wants to add skb tx completion timestamps.
> That needs a bit in skb_shared_info.tx_flags, but all are in use.
> 
> A per-skb bit is only needed for features that are configured on a
> per packet basis. Per socket features can be read from sk->sk_tsflags.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: skb: free up one bit in tx_flags
    https://git.kernel.org/netdev/net-next/c/e6116fc60557

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



