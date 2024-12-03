Return-Path: <netdev+bounces-148440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136F59E1AD0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD3FB47851
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6581E260F;
	Tue,  3 Dec 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBuBw2Op"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937A1E260C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222416; cv=none; b=DAgK/52nLxHOxIYQQ1nF/N9m+HnrjvlwlmNoehYhw8+r8VAvnq5xeLugbddtygHir5abRbpNCPopcjD9AQ4/iptoazsiIA8eZTS4Y7b227rd1FTg5fRq4sKt6yTSn6QowJkW2/9fIbubabzmhP1dCYOmRJmdBnPQgipZXceTQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222416; c=relaxed/simple;
	bh=v+PmmP09i/Uo9rFLN1HqrjpY86uRNEMAGx4pmtmqW0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UpcXtZTGixq7jHcbch2TFKhY2Okhnm1zmRPl+I0sfdg+ugHnC8t4mJyRcShIGNDtK1p7z1MajEMPiEPOGM2PwVAG2LIbqnM5te0qvmkkGTWBNx95msjmqAAAEFtd8wMyQeb5zhdp6/j79qo/0TkXJVC0czh0I6+yH92B9aiSAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBuBw2Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9913C4CECF;
	Tue,  3 Dec 2024 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733222415;
	bh=v+PmmP09i/Uo9rFLN1HqrjpY86uRNEMAGx4pmtmqW0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JBuBw2Op20c3wrYPILHJN6gsmajFLGm05nTM2AWOQsHwxKZe0weJhymFYjTGJK0he
	 glnzYDnXz5tDSpc+GzCWnwBtGq+GjoTYbyHd6r8f6oyJ25R1fmoB7j+By8jmlH98QY
	 RRHkH1ERsf/76zUkOzwXvQLI2GF9fYWMVcY9Yok4XPbraW2yFmc2stZv2LqDVAMuts
	 E0gwoZXZj7TL4WAgtMSJg1/XWXWEzvKZOx/G0+3wsuHpc+GDw+qFEB9gh0gcaAx/n6
	 21nC4vgEym8XgKgjXJTEaxxb5HZ+8fKpuH1Lgfx+lXzNfTDBgg6LKVNkaCw6fIG2dd
	 YyzV0uB1EmKFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A643806656;
	Tue,  3 Dec 2024 10:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net v2] rtnetlink: fix double call of rtnl_link_get_net_ifla()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173322243001.10445.16406152761850784134.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 10:40:30 +0000
References: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, cong.wang@bytedance.com,
 syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Nov 2024 13:25:19 -0800 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Currently rtnl_link_get_net_ifla() gets called twice when we create
> peer devices, once in rtnl_add_peer_net() and once in each ->newlink()
> implementation.
> 
> This looks safer, however, it leads to a classic Time-of-Check to
> Time-of-Use (TOCTOU) bug since IFLA_NET_NS_PID is very dynamic. And
> because of the lack of checking error pointer of the second call, it
> also leads to a kernel crash as reported by syzbot.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtnetlink: fix double call of rtnl_link_get_net_ifla()
    https://git.kernel.org/netdev/net/c/48327566769a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



