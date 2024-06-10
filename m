Return-Path: <netdev+bounces-102251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54F902181
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A7D1C20A31
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B380C16;
	Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrJy2Hvx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719B80C07
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022035; cv=none; b=d3ZKMB/dFylRPgu64k+k2pXqhHKtgh3pfZ+bwJqcT9gYYecAK1TlVUBWS3wE3eZmgTlPxUihOaeYfZHowEIwwVDPjYX4Nf81yDpF3/A3z7lQ9crc/5+aOaSgEqro2bBY/OQbMs0CeLXE2weLeD57FsvMcufFXhjzXz8NxxLLYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022035; c=relaxed/simple;
	bh=ZgP9n3ctNubsQwEeJtgcDGDmuDTEQqUHtjjV4O60tYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYGq1lsSV1zAvNl6wnWSUvAXYqfMTHjQcQe15BlH//VLucxRrPrgs5pL07XKH0jrwVFCbJ+9FGMQ/es2LYSdX3nDz/X2siyGGoGsHuIXxiN/AGBiLqr2i9vwmWZsPEp9xrGOI6LF68T3Tsa1pLkEQmsE94BQZOc/vvumVp3/BJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrJy2Hvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4742EC4AF50;
	Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718022035;
	bh=ZgP9n3ctNubsQwEeJtgcDGDmuDTEQqUHtjjV4O60tYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jrJy2HvxL/PRFwvUjEFLZmvBccy+uDXCxDAMSs24e8KaMiT2YP882gnmEs3v9VNpk
	 R98yilEaxjhE/91lLdMhYSzP2+m9vl+QaVQ1ZHUKdM6eQupnXyGPAbf2pMcpgO7XqP
	 byC4KNsyoCcBtpBwkeBt9WMYouwd08/vKkC4mGE/V6xtNLFY/bo7P+m1ZJNwe1MRWz
	 5WYjhysb41Xgaw1RpsuW2wuIr6/U7Kg38j1yxsGagK5Dj7o/p+y9jj2KBoLR5EXlD2
	 ZV1pT5BbDhNe18nXPzY9P+xTVTQuLDbGzaUZ6u6dSM3oXk7t8mEQZROA9Jrv5Kf+iz
	 /+hwhClhgIyJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BFF6C595C0;
	Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] rtnetlink: move rtnl_lock handling out of
 af_netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171802203524.2008.7592611258075812584.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 12:20:35 +0000
References: <20240606192906.1941189-1-kuba@kernel.org>
In-Reply-To: <20240606192906.1941189-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@gmail.com, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jun 2024 12:29:04 -0700 you wrote:
> With the changes done in commit 5b4b62a169e1 ("rtnetlink: make
> the "split" NLM_DONE handling generic") we can also move the
> rtnl locking out of af_netlink.
> 
> Jakub Kicinski (2):
>   rtnetlink: move rtnl_lock handling out of af_netlink
>   net: netlink: remove the cb_mutex "injection" from netlink core
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] rtnetlink: move rtnl_lock handling out of af_netlink
    https://git.kernel.org/netdev/net-next/c/5380d64f8d76
  - [net-next,2/2] net: netlink: remove the cb_mutex "injection" from netlink core
    https://git.kernel.org/netdev/net-next/c/5fbf57a937f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



