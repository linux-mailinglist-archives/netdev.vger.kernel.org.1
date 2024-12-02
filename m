Return-Path: <netdev+bounces-148196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E29E0C55
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536641654EB
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A431DED62;
	Mon,  2 Dec 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVRUtgm8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA91DED5F
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168417; cv=none; b=LeKWlzSouVnKTH5qUw/zKQvaBBdRd046egaLzJ3rz3a1bkSyHZNktQ+ONdQxbz5yLbJV+Ns94jeYh5m0gldSjBnbSuWNxZy8B00Ooo+drYgA4KXCSwVy7sryaOCR87319O6qsQn7EUkSOI3HTUcv7+ghKVUcw2WUU1igDaxdPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168417; c=relaxed/simple;
	bh=UlEOERXcozjwdrvIIh6LO4viPEq6OisSFY32daHo7As=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWzl6Pp+WEeE+SWE5exhRgMLxjKil7KQqr7+eu7gkN32eZLt3JRFHFYC48iqGU59+krigHtwjYN9x/io9yd8CAeY2NddJTH3yJztEVTmo+TbZmQ7ym25XEy/zqqVBWVmI9qDtMafjyIjLhrCy2AjjK/PhvHNtkfwuhMPQLDLzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVRUtgm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259BC4CED1;
	Mon,  2 Dec 2024 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733168416;
	bh=UlEOERXcozjwdrvIIh6LO4viPEq6OisSFY32daHo7As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CVRUtgm8d99XQEa4oOHoxwq6eQ7vRRcjakWnHaufRKK+DSfrHQ9XRvbnY3EwJvL+g
	 x/fWrAo0xJmqLRbV1R5vsG8UxTjBYPL/OFn4EBojOUWsHupeV+iq3BJE/tKIcOAJnY
	 9DkkwtNUuIlFI+mQ/d33NQ32Wk7qldviLxSlUUj/aJd33cuQqrnNZjh2j7P2sXGmPZ
	 cFavJf4/6j8wxfHFGwktQq8m5Np4KQPHbYgX7vSwQwGdyHBzS032l5k4iHRADkXXOK
	 ApxI38rkJb40oiQO6jMwpJAU9fkQ9UO1pmQHa20u9/qHxR0tEMJDPAXrnhVPiptYjb
	 WCCOadc39IOaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E2B3806656;
	Mon,  2 Dec 2024 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2] bridge: fix memory leak in error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173316843074.3871672.16208625269238916831.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 19:40:30 +0000
References: <20241126021819.18663-1-heminhong@kylinos.cn>
In-Reply-To: <20241126021819.18663-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: razor@blackwall.org, netdev@vger.kernel.org, stephen@networkplumber.org,
 roopa@nvidia.com, bridge@lists.linux-foundation.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 26 Nov 2024 10:18:19 +0800 you wrote:
> The 'json' object doesn't free when 'rtnl_dump_filter()' fails to process,
> fix it.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  bridge/mst.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [iproute2,v2] bridge: fix memory leak in error path
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5682cf3ac6f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



