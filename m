Return-Path: <netdev+bounces-165344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A63A31B85
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E218E3A6F92
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980833D3B8;
	Wed, 12 Feb 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbdIcVzc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2027E107;
	Wed, 12 Feb 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325003; cv=none; b=vAqoSh8i9VAevT+YVdnaPPlKORPYAVlX8SJuM3OJHio5rphN3uhH9Ab2yGfeHQgiVQfSah3pT6cTusmSGv3ukYfTaRSb7VXdqHHTYRFUSPlUF6+afB2v/YKq9QUwnuRNK2RgI02wKuZI7Ld/64pSTCrE8ke3i8Oww7ipFxjB0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325003; c=relaxed/simple;
	bh=RcBOJtFnt5SO715AomEHczw2nrAlehkgCPdhVKmK6aw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QKvS6pe0tl5dkxrwVJ25GtXHxOHt75wGuJ0lQc11WOaRVZuOOnzA/yiAZg8kr8LFL8L2Jxom5n5FraCIetxhOyB2uNWBPh8ktb2Njdj7g4mpwNtkYHuLBJLtUzDTTaTzw7UOIw2Lq4b94th1lVe1J/PJpAr8Brwg1rBKvoNLOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbdIcVzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5D9C4CEDD;
	Wed, 12 Feb 2025 01:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325002;
	bh=RcBOJtFnt5SO715AomEHczw2nrAlehkgCPdhVKmK6aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kbdIcVzc/sNXX22TX4mk9NHK5ea3WL5LgBfO41qIUPvqLbYLDremK0GhhIEMa38id
	 j93KDg/j59iXnTwbnOzgELz6S+4lRGAnOk3xCjyiWkiT8Vvp9wbTM1mPlag+AtBXPU
	 LsZB2TuvbAjlCT4+C3A8KbrDMEGSXAiCdr1mTIOrKZX7nCeQXsdxvRr3vZehtKC2/6
	 2JOKpnJ0bnfY6v3SPntkLnE4AvEHA41kIlUGM/9WxdahDt1KlHTP2obZeRMGewH2BF
	 Lghd0QUyH6viEJl4HcNsngFUzWovIVZp/MH1LaMViecmtYUg+Rt9wRnOmCxVRvaIVh
	 yKgdw8JlcTfDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1EA380AAFF;
	Wed, 12 Feb 2025 01:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rxrpc: Fix alteration of headers whilst zerocopy
 pending
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932503149.66696.9164898747441609940.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 01:50:31 +0000
References: <2181712.1739131675@warthog.procyon.org.uk>
In-Reply-To: <2181712.1739131675@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, chuck.lever@oracle.com, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 09 Feb 2025 20:07:55 +0000 you wrote:
> rxrpc: Fix alteration of headers whilst zerocopy pending
> 
> AF_RXRPC now uses MSG_SPLICE_PAGES to do zerocopy of the DATA packets when
> it transmits them, but to reduce the number of descriptors required in the
> DMA ring, it allocates a space for the protocol header in the memory
> immediately before the data content so that it can include both in a single
> descriptor.  This is used for either the main RX header or the smaller
> jumbo subpacket header as appropriate:
> 
> [...]

Here is the summary with links:
  - [net,v2] rxrpc: Fix alteration of headers whilst zerocopy pending
    https://git.kernel.org/netdev/net/c/06ea2c9c4163

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



