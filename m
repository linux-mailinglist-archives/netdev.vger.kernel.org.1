Return-Path: <netdev+bounces-200091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A8AE3166
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 20:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988E33A6EB2
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0D1F4621;
	Sun, 22 Jun 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtyQbCZ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BF2260C
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750617580; cv=none; b=Ogr65GNgxESuR+ztl0hramH2Dri+jj5+QGtHi5ChFCGBeMRx8qpA3aAy94CkXPdecqS89b4OLzFhWJ/1Skq66/0cXS3rZy/mRHDwJBUgmdr+zD95Wh8uhnV2k5mTpgx2muCXjIw8Cod2Y1mm2ke3eLhgA1higs5aB8E9Rern0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750617580; c=relaxed/simple;
	bh=/+6gCxWiq38mffkA1J2dp7RgEUwkuLqXcDTl5t/VU/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mx9/WlTQ+UWnUfKFanGc0DV2upjj9lUshWp8vGjNqh0bKxqL9qFwLtfliFEg9wZanGeS45cB+c695isJdEOzm71z2wqZck/R3cigZRSorLtsDHzinvLv1RVfKnXuC/7iHB7Vjg+LX1rTdj/P++ZThwPMHX4rep7w67sVEwq4l80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtyQbCZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6A1C4CEE3;
	Sun, 22 Jun 2025 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750617578;
	bh=/+6gCxWiq38mffkA1J2dp7RgEUwkuLqXcDTl5t/VU/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MtyQbCZ40Z0uJKNlVfL490OQcpeftszZ2/QEoALjkbL78jjdgVn+qnwusMGBkixkh
	 zht+0uKCoPo1vq8+alYouYG7iq37x6YbAIRNx1QKf1WSmCd3GpjYgXTYIFiK8xQa2a
	 JkhS4s6MN1gi1uPL56F4VxTXwlHJXx+iNEvx2zwUNZIGqiECFmuJoS6eIqr5v34RcD
	 eoqGhRm3AaL5nSJdQeHlDyG+ZCmsgHRa8RP+5iW+KImY+Wr/W+AdBJNL+we/NM/jY2
	 yaiLR2SKWESCv8/fvHcZmZtiUAVMh0YMVzjfEwpZ5gJl81sFcYHq7cSfvGw8yV0wu4
	 eHSMx919HE9VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A9339FEB77;
	Sun, 22 Jun 2025 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] atm: clip: prevent NULL deref in clip_push()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175061760600.2119423.6034814634556380596.git-patchwork-notify@kernel.org>
Date: Sun, 22 Jun 2025 18:40:06 +0000
References: <20250620142844.24881-1-edumazet@google.com>
In-Reply-To: <20250620142844.24881-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com,
 xiyou.wangcong@gmail.com, l.dmxcsnsbh@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Jun 2025 14:28:44 +0000 you wrote:
> Blamed commit missed that vcc_destroy_socket() calls
> clip_push() with a NULL skb.
> 
> If clip_devs is NULL, clip_push() then crashes when reading
> skb->truesize.
> 
> Fixes: 93a2014afbac ("atm: fix a UAF in lec_arp_clear_vccs()")
> Reported-by: syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68556f59.a00a0220.137b3.004e.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Gengming Liu <l.dmxcsnsbh@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] atm: clip: prevent NULL deref in clip_push()
    https://git.kernel.org/netdev/net/c/b993ea46b3b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



