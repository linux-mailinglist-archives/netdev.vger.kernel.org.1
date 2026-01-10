Return-Path: <netdev+bounces-248663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BF6D0CD4C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89E4A303C81D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24323A99E;
	Sat, 10 Jan 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx3UT/TU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95482264D6
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011813; cv=none; b=IkSur3YEJvoUEpAqE4gzy7UYrOVk8r8erGPsAKqI45qRzt/gl4u3FAKnksXC+7Me/VtK40sGSNxdlY2iyjMa0p0mBbk2JepSv5h8jbUYcTTDgHUWwugSoqr/9V23PjpaFC3QYuUjDVlt0h13vl2K4MEAOOHCM9zYXaUN1iRaPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011813; c=relaxed/simple;
	bh=4bwJHeOVh47sqXhNHugjbvmyABmKyzBb0/g7KT9/tAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F5rRN5SzD0i2iIRnI67yL3aaFDKqtQ0X1Fi9NSSff3lwaV5z4tUTjho+KVEV46U0zlihLu1VMtkk0pB1zA4KhSe2cZ/t1XZ5wRTBQ75SxwnxaMa+iR2wlo/9ZddHVroNK2T7zDDAogtuO2z5khE8ccP2qcM2Syqw5fp5gM80btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx3UT/TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C40C4CEF1;
	Sat, 10 Jan 2026 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768011813;
	bh=4bwJHeOVh47sqXhNHugjbvmyABmKyzBb0/g7KT9/tAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yx3UT/TUkV+9sad6Ha2VV9r0lK2HuBp80cui4Uo1bMyqlMpIs3+1p1JEapJy2bYge
	 ynuSIHthdbxVqEiJ3K3QdmpcpJauf/dNVBaQrWQV43akFphprc/e1LxcuN2kvcajSG
	 EmsOl056Ywci3jLoeZ54XO5Xh5KP1M3f/hVcmfDGq2EM+udRQ2mUuI1/bum6f2p2IJ
	 kLUkjP5MblEZ363ELECPQTzu9HjfnPbZRUJiuY9PxxCkbyAmdm+a72FP93t+gEQwYy
	 BBHtUtn2vPKBvbKXsrLRBuuZ+2jfy3B3E2lZcAZK83l25TPLyICQn5/+7DeMVTpe02
	 APEVrJDkdtMkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA1F3AA9F46;
	Sat, 10 Jan 2026 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] macvlan: fix possible UAF in macvlan_forward_source()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176801160905.454777.4124494942189251189.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 02:20:09 +0000
References: <20260108133651.1130486-1-edumazet@google.com>
In-Reply-To: <20260108133651.1130486-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 13:36:51 +0000 you wrote:
> Add RCU protection on (struct macvlan_source_entry)->vlan.
> 
> Whenever macvlan_hash_del_source() is called, we must clear
> entry->vlan pointer before RCU grace period starts.
> 
> This allows macvlan_forward_source() to skip over
> entries queued for freeing.
> 
> [...]

Here is the summary with links:
  - macvlan: fix possible UAF in macvlan_forward_source()
    https://git.kernel.org/netdev/net/c/7470a7a63dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



