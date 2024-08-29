Return-Path: <netdev+bounces-123001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687959636CC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF106B23549
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCB8BE0;
	Thu, 29 Aug 2024 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhUjDxCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524833C9
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890838; cv=none; b=Hda5zb+bp2ODSFeKUR2PDDnv2X4biWalqDhvXcj/HsvokKuixMHqFK/P6cBxUy4haPj+JEA42s44gD5KQTsIuBYYXwljG2IBBw6HO2jNLeQb6yMDFgw+R10EbKcRha2WDY74DtbCEZQtxvHlpPtHbMguyJNvNdUWKywji+OZzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890838; c=relaxed/simple;
	bh=QHUs4ZYOqMD9MOQBDDoFhMSMBTFTk3/XLvypvcKCa8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mLxKKCTNGbTImldMeaYILztSaWbLc88KNTjWjIGN2y6V/OnsHiKa1J+3a8wBJ/yXmSFp5ozsIH5Gndtp7M8XhtmCoZJvx6B8oaIEita/pbwW8UIFivNJ6/cOjxVnLJ9Ip/2MT+KuyqB6Mf6RsJVRMmkkzVBiy7Ph8PBW3sFMqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhUjDxCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE0FC4CEC0;
	Thu, 29 Aug 2024 00:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724890838;
	bh=QHUs4ZYOqMD9MOQBDDoFhMSMBTFTk3/XLvypvcKCa8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UhUjDxCyHNP8Va+PN40dvhzxol0W+UYqQskI5NGgTfmG12/uAyqlLH8p+SB8f0JfM
	 fdCUKoN7TQAlufhW0ukFpXx8HXDlV3H5yrgY1o2bzuVbIZIAhcLcdgHC+WpfDxCWNN
	 Ouo3eoeOX9MpvHdjMtvwNMpgqf6Fk9K7sbIu4JWBFE7YeerC0qazeSttP/cAGzQb+T
	 yuI5Zrff4RcZ/ekCOOPePn69bzyNe5vO3lSKl7Z8b1CbKKCOHaoQDatQAfSTLK8zxm
	 h+nEwiskKEQ8ybMNFGbazu2Ad+rXclTwU3KESLhdO3WTYODTP/k4YhklRlMDYgmF2h
	 wr0p3GGcocYLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3713809A80;
	Thu, 29 Aug 2024 00:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: take better care of tw_substate and
 tw_rcv_nxt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489083849.1473828.1249684148136615223.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 00:20:38 +0000
References: <20240827015250.3509197-1-edumazet@google.com>
In-Reply-To: <20240827015250.3509197-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Aug 2024 01:52:48 +0000 you wrote:
> While reviewing Jason Xing recent commit (0d9e5df4a257 "tcp: avoid reusing
> FIN_WAIT2 when trying to find port in connect() process") I saw
> we could remove the volatile qualifier for tw_substate field,
> and I also added missing data-race annotations around tcptw->tw_rcv_nxt.
> 
> Eric Dumazet (2):
>   tcp: remove volatile qualifier on tw_substate
>   tcp: annotate data-races around tcptw->tw_rcv_nxt
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: remove volatile qualifier on tw_substate
    https://git.kernel.org/netdev/net-next/c/3e5cbbb1fb9a
  - [net-next,2/2] tcp: annotate data-races around tcptw->tw_rcv_nxt
    https://git.kernel.org/netdev/net-next/c/c0a11493ee61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



