Return-Path: <netdev+bounces-154107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05C9FB439
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9343C1660E3
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9A1CDA16;
	Mon, 23 Dec 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7MZ+K4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFD1C3C0F;
	Mon, 23 Dec 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979822; cv=none; b=UZF6XjxFmkmAtn4bnUvGdTK3xTv0yRexjgfmRPRbRaKad1D19pHVb2p8ncrasr0VWpgHO0sRxiaa94p29TB/Fc6ZdgzBu1xbdi5AF5ie0IHZo816o8k2X22YHrXy0hd6pTUEGbj+2BJ+8oi0g97xKMuf3Sa3FTKYuhprD62kkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979822; c=relaxed/simple;
	bh=XLVV7fmygJG/ZwXO76vQqSy68dy8S10NlIe2GVy5f6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bp19vQDprA4evZBVgP0cLjrPq2pXmXvGJj4/HCFaAhpdVuMYAgm5iMSkyFnAXHn+QuqxoOPAHQg4OyXkQ6l6bDN2z8XE0T8s5M3wGzLXTWjS29qxytB7vA/VdBH+AKxYDr74o63MVs3JkmlBRJzGRHgustPuwoAmoNgyKdBTIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7MZ+K4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE3C4CED4;
	Mon, 23 Dec 2024 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979822;
	bh=XLVV7fmygJG/ZwXO76vQqSy68dy8S10NlIe2GVy5f6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F7MZ+K4zJI2Q/1hIWU+XKkl2dSYTSuSdREbnw3ACavIKumUF1D2/15wS5Fmid8wDH
	 Y2WcvWdK2Q58dJNX/Nkz0S044St5l6pLvvcwJ5e/bACv3ajEbZW9RdwQsnJwMmdqhw
	 E57UTSbAML9z28P4UnyncnVRflpthT257eiCv5sp6085pTtmGXo8aJvJP5H4Kt5Z57
	 cPkLLZijeOXNQepz0kDCbGuQS9dzMlqYu14AfRdQs2XTCroXhd5NZW4oZnsoRjW/GM
	 m7mNeZ1brqFeJF9DuSrPfSMBRjsEXg6al1l0kIYcbjeMYulbCk2JtE56840yq5SHtG
	 YK2dEJYoFvxMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE123805DB2;
	Mon, 23 Dec 2024 18:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ethtool: Fix suspicious rcu_dereference
 usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497984025.3929264.1326704419746922009.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:50:40 +0000
References: <20241220083741.175329-1-kory.maincent@bootlin.com>
In-Reply-To: <20241220083741.175329-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com,
 thomas.petazzoni@bootlin.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 09:37:40 +0100 you wrote:
> The __ethtool_get_ts_info function can be called with or without the
> rtnl lock held. When the rtnl lock is not held, using rtnl_dereference()
> triggers a warning due to the lack of lock context.
> 
> Add an rcu_read_lock() to ensure the lock is acquired and to maintain
> synchronization.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethtool: Fix suspicious rcu_dereference usage
    https://git.kernel.org/netdev/net-next/c/4c61d809cf60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



