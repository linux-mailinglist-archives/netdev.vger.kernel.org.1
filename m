Return-Path: <netdev+bounces-91185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF38B199E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC71B213A0
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F723768;
	Thu, 25 Apr 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEHb37gP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B14200C3
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016428; cv=none; b=IFTAKRVE0Dnz+Y3oWHqCPKbvu2FDg2OEMBo36RXWHG7FIGCJfvMypDP6N/ZS0/8lNjHZxiOLMNy7ibGYiD6XolPanQrvLljON34uHdjAsTYhjsTQIdMpD86SQzImp/f83t4CP0bznnaMW9obMgi2eR3WalQF+KW0W5XNSz3TRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016428; c=relaxed/simple;
	bh=tJCFAN95x3zb5AhyZ/GDoKWZY4OYt980WGKcQpMi+uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pW1XxLfPs9GGvIOfJtlI3zAHy8qexkaSEDH6jSiPxqVDKhWTC89eqHyWYlxyuMUAxGzVvIW9G7nSzW4PidEffRZv8vuO3lWPZ6UAB/nbc781nImVTgQz5SYIpopPZ3i1/YllpSwdSZsITlPK/6BlMD1mOJIyZWp1K+E3Pe/VlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEHb37gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89E5AC113CE;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016427;
	bh=tJCFAN95x3zb5AhyZ/GDoKWZY4OYt980WGKcQpMi+uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tEHb37gPxc9DD2MEKdN2eyobA3QaKuyeJ6x8MUuGKhiYTxWQeFhX8XgyQvGycf3m4
	 BCRg02v0ifQOGOH4BAGDXF1JmKke7R04L1d/+dZxH49k4QWyCo0KGrBCqSygjtlMAY
	 yCwD+1b8R7XaIoMgwt2QbjRZfT2bB36ceJOL4tFMN870wK0FZoD8GP8bxMWYJnAJHx
	 o3t1+w72doHXJ+Rsx7kW+ZrMFGQ0DWY2HZy0WsovNA7GAQfTUFug/yRdVcOF8+rQUU
	 F4M7FL78mdKJPkObBzjosPoSU0sImi6S0dYOJOt5VHZbiEBtnkuo3MjCAEK2k+H8MF
	 WsDa9TMxI1T5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 790D3C43140;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: bnxt: fix counting packets discarded due to OOM and
 netpoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401642749.20465.4420311650103709598.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:40:27 +0000
References: <20240424002148.3937059-1-kuba@kernel.org>
In-Reply-To: <20240424002148.3937059-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com, edwin.peer@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 17:21:48 -0700 you wrote:
> I added OOM and netpoll discard counters, naively assuming that
> the cpr pointer is pointing to a common completion ring.
> Turns out that is usually *a* completion ring but not *the*
> completion ring which bnapi->cp_ring points to. bnapi->cp_ring
> is where the stats are read from, so we end up reporting 0
> thru ethtool -S and qstat even though the drop events have happened.
> Make 100% sure we're recording statistics in the correct structure.
> 
> [...]

Here is the summary with links:
  - [net] eth: bnxt: fix counting packets discarded due to OOM and netpoll
    https://git.kernel.org/netdev/net/c/730117730709

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



