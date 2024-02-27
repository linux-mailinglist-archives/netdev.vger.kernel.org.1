Return-Path: <netdev+bounces-75176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A5F868788
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 04:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6010E1C21699
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665E1BC27;
	Tue, 27 Feb 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwk7fJ5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257C182BB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003429; cv=none; b=A6PCp4w8OI6YPCXWiN7hPNJ5R5i6sDtjTCEdN1utpZqcrPtondPTYAipl+cRCHZb98siErDQ0keRDp+NDDerUeZWr2Mn1ofhAz5ZoWJ7cAQscFJ7fkUefB6J0qI8dl5kt2DjV8QizIxexuGy9Hxuz3FnAAHopUHFBkIG1dvLsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003429; c=relaxed/simple;
	bh=qdDTMTR7qCN+PieV3v2JY/BVYV8WlYCOL8HyrCRHJ1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oose1Isar1XMV6LjQA3mu61bTCNFI7GSMmINjOE3srrKeKJ4a1GpKRLNzHJ2Rb/EMABK+2R8AzQKdN1ReEmAqkqKyvkBITbyusiIxAsdSu0Lu4AHfvCHGMSDjGDBHdqYrqif2T07XgZlDYXbXD23pnHnIQBSTVvyH82oeNLwjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwk7fJ5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C31A2C433F1;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709003428;
	bh=qdDTMTR7qCN+PieV3v2JY/BVYV8WlYCOL8HyrCRHJ1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nwk7fJ5gWlcTGFUjfBXSwi2cTFs2zKDW7p6cBw8bLRNyLsEgu3tzC+9d6dBAGr9Z+
	 7gVv+pGfz3uqNm/A4pD92HYSYCKVpbqeMvdJ8YYNRLvJbzcsgg9g64P259Zq6qIeuu
	 r5rqtaQ3kI5qbT36uLrgx0UdKeP8xHOvGgMPhPhD6hE95Diovs9olktMXjKx3iLJxC
	 8vbsuFkkiI8mH5BD8xqRZx0HO+SPuhHo2sTSTd8wQM3FB++6gfn70OHIRpxe88HTk1
	 yOnuDYlD2Py1LBIiClpiVEVqVClgnoBgLTlQlmOaZB2vN97vQwGfe0OOAHrvSIpD5R
	 RrZKVglRfNwSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC058D88FB2;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] dpll: rely on rcu for netdev_dpll_pin()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900342870.19917.4713964463786092641.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 03:10:28 +0000
References: <20240223123208.3543319-1-edumazet@google.com>
In-Reply-To: <20240223123208.3543319-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jiri@nvidia.com,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Feb 2024 12:32:08 +0000 you wrote:
> This fixes a possible UAF in if_nlmsg_size(),
> which can run without RTNL.
> 
> Add rcu protection to "struct dpll_pin"
> 
> Move netdev_dpll_pin() from netdevice.h to dpll.h to
> decrease name pollution.
> 
> [...]

Here is the summary with links:
  - [v2,net] dpll: rely on rcu for netdev_dpll_pin()
    https://git.kernel.org/netdev/net/c/0d60d8df6f49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



