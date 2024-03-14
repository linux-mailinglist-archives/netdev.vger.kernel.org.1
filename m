Return-Path: <netdev+bounces-79838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8A87BB41
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7921F21E9C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F037155;
	Thu, 14 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFQGiysg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CD2CA4
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412229; cv=none; b=BSAggwQtVsM5KxqtZa4a+T4UTecTShae5oLqzrmu1cZ34Gf/gsKhoPO3cgBI+r9dmVznxOfmAUK8O6er4U4M816z7kj5u/WG13b2soKqr7eb849778/sa9TSy3VPxNebnvIeLd3xhJXEt8xryUUpdW0UpMPduSNy9/iwHUAW5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412229; c=relaxed/simple;
	bh=f12IFfXxQ2kcJcyzDaKMCOwKfucld2bvgaX/OKNdro8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L7MW+DKORCqcXsG2uAYkgqh7vcQg/Hmu4VfBnB/RIuKDLRXqaK0l7gEdUrgIpI/lBBkQx7L4kPGtFUdojN3hO+YNwV2QdrcO1MrSYovj7qZjN5YIxik/XfbHHyHRgkaIpTriFQqDLWiIlOMqQJhpqIu48b8wWp3ivmiCNhA9HNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFQGiysg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57EA7C43390;
	Thu, 14 Mar 2024 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710412229;
	bh=f12IFfXxQ2kcJcyzDaKMCOwKfucld2bvgaX/OKNdro8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GFQGiysg7XzJ3DOJLEVMrIGXPM2SJzv+yj2O2nwi4RbqgKnvOsVTns95lhh5Fkmla
	 NUaBGcYuMcudwhk0Mszplr13FXx2CL1KhO/6bV+ZMgPHXpFNkxyBRduwxtqcsEdinF
	 cfAzQoELX6SNNaAvwJb0nR1kL0+jeurogfV4AeCTzESDph9RtTy167qYBtCqQ0IdLy
	 GUjJ1wRJ6QoRzVwpamExLuBRZqcCqsPAj6khznFvciJ5aN2EnvbZleynmLx91btkzd
	 4o6FliLzsAiihyxKBWGbuphHDrDxYsTIrndTJTu8TUd7OqXhyBnBx8f7CDDBIOS+JU
	 EVy0o6oZ6Hemw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C4E6D95055;
	Thu, 14 Mar 2024 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Fix refcnt handling in __inet_hash_connect().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171041222930.21784.1498217095730507058.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 10:30:29 +0000
References: <20240308201623.65448-1-kuniyu@amazon.com>
In-Reply-To: <20240308201623.65448-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, joannelkoong@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 8 Mar 2024 12:16:23 -0800 you wrote:
> syzbot reported a warning in sk_nulls_del_node_init_rcu().
> 
> The commit 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc
> failure after check_estalblished().") tried to fix an issue that an
> unconnected socket occupies an ehash entry when bhash2 allocation fails.
> 
> In such a case, we need to revert changes done by check_established(),
> which does not hold refcnt when inserting socket into ehash.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Fix refcnt handling in __inet_hash_connect().
    https://git.kernel.org/netdev/net/c/04d9d1fc428a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



