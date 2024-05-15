Return-Path: <netdev+bounces-96530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA65F8C6525
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB71F1C20E77
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6E5FDA6;
	Wed, 15 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV7UbtJx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FA5F876;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770230; cv=none; b=N3x0jodVXlBaV2cnmv0Q4gl3BCqkwJ32QRFJrrIgBvrauddbJQ6tmJBsh+P+jwXU6d1TBH/Ms7DeOyMaAy6RDN0v0AzwjlxwmCbmPTZGCpQ+2tSxB/wi8K/EdaipDwH5D1pVdfPmReHNjRGIOL9at48XK68XN+abCOnfzmlLJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770230; c=relaxed/simple;
	bh=HpHdRrwjGUKTtq1QqhmVI5uJcN5E47R88GhAOUE3SHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bP5l9nunE0bYTFUuupl8BSema6+SHiabMtqrdRmIZiSZ5233YNrDeqr18fW1m/wwbXE+ftf+RLaJ75yzql+6aBoJ8p9QGKLzRynUC6ZJrt0M+ACXCc/KP5xZE1vCWXG68fjF2yL7ue71pB8rUWoZSH210xUZT4k63gV7G0NwSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV7UbtJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA77AC32782;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770229;
	bh=HpHdRrwjGUKTtq1QqhmVI5uJcN5E47R88GhAOUE3SHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OV7UbtJxOuaUqR9zH3VRBPxCi7LPnchrgFDmYsbBy2P9rCczUcieyVhYDd3iLqi8V
	 WEBmc95WyuIRD6lyCCnbQQWK2U1fm44Rolo1DR+z0OtTmBIlspBpjJsgkPJixQzz+v
	 TAps5JDqx2fGDK+f+p6qt5kCODqtzQypLY/7My294iF3Jv7j5ZU4ktl29SA5xZ0/q4
	 ydUKKG2T1a7vGuuuZYEaeL52k1FuXyDtnAMiYd+HS5KcloBu4ZowrHWE9RIbsTivjS
	 28Jc7maU/ZxraNuW/HIg4NQvbd6zMgPvhBOS3468ddbRiQzp3Vsyc6SdQuyOmy0B+q
	 IQMn3IK5nSVHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F90DC54BB6;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: mst: fix vlan use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171577022964.14646.1553082232866025544.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 10:50:29 +0000
References: <20240513110627.770389-1-razor@blackwall.org>
In-Reply-To: <20240513110627.770389-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
 roopa@nvidia.com, bridge@lists.linux.dev, edumazet@google.com,
 pabeni@redhat.com, syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 May 2024 14:06:27 +0300 you wrote:
> syzbot reported a suspicious rcu usage[1] in bridge's mst code. While
> fixing it I noticed that nothing prevents a vlan to be freed while
> walking the list from the same path (br forward delay timer). Fix the rcu
> usage and also make sure we are not accessing freed memory by making
> br_mst_vlan_set_state use rcu read lock.
> 
> [1]
>  WARNING: suspicious RCU usage
>  6.9.0-rc6-syzkaller #0 Not tainted
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mst: fix vlan use-after-free
    https://git.kernel.org/netdev/net/c/3a7c1661ae13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



