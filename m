Return-Path: <netdev+bounces-221173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EAB4AB5E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00007AAEC3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D79289805;
	Tue,  9 Sep 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE+iAqWz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F631E11D
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416203; cv=none; b=gXtqgD32L28Mann+qB916uaSh6HdVfRESJjfw8z+vEBDpxsVwWzkyagRlbSNKlOXU2qaK+1OXBKhavJTWKjKoMrb5ysoSHiIPAiu93WfcDFA3ighWk0qXgM2hkVgzeoL4Lxnzee8ltf5BBBfBK40ciJzMJoV0DY4ghaOKIe4ApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416203; c=relaxed/simple;
	bh=Qhi16CLrvUE+Eg3J9d8NLHZ6B+APcfvuUubEC9hVHZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nxRFyfChi8iaMmboVGJ+DkSm67m5L7PLLu1S+QEzc6W/wfuX2juH6yjLE/PLcgFTS/zGp5+gpmtWGQGB4KkPUp+JHe68/9MbV+FkxtFMw9BNKN003EXHYWekIYWdje/dLt3GrVTXCKkU8eDkMsW7tZpZGENx9yhPX6qticpcy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE+iAqWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF8C4CEF5;
	Tue,  9 Sep 2025 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757416202;
	bh=Qhi16CLrvUE+Eg3J9d8NLHZ6B+APcfvuUubEC9hVHZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iE+iAqWzLLekEUu6QoYnDO2I4aKcnza3YIq7qfBaG9GMD4e4Nmb5eesAhwZAsMy1b
	 HuK1IpkE9GXB3js2slCgXO6GRqxjkdnXNnlf0ZgY4fd6dWwWmtVT1YNbmERRvuEHdg
	 DhhvoRh/9a/LGYBc7fgp0YWwVR5IjuPtgQ0yt144szR7AWK5S2spGyzV4IiZIVk+yX
	 TXEQC5si9FGbMvdId1Xgnx8m4qCR+MYoH/luZWl6o/5V28V3L3QHeXCkOiD6OZ5euw
	 jTr4/nM2Nf6sHew3j5f0Qe7xXODBkXJIw0kKqGvkba/viqeBXdRoqfTh9GFsJWz04t
	 h2NbCkDCZAhgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715A4383BF69;
	Tue,  9 Sep 2025 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: reset the GSO metadata before reusing the
 skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175741620627.630466.5436341441435572519.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 11:10:06 +0000
References: <20250904125351.159740-1-atenart@kernel.org>
In-Reply-To: <20250904125351.159740-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 sbrivio@redhat.com, amorenoz@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Sep 2025 14:53:50 +0200 you wrote:
> If a GSO skb is sent through a Geneve tunnel and if Geneve options are
> added, the split GSO skb might not fit in the MTU anymore and an ICMP
> frag needed packet can be generated. In such case the ICMP packet might
> go through the segmentation logic (and dropped) later if it reaches a
> path were the GSO status is checked and segmentation is required.
> 
> This is especially true when an OvS bridge is used with a Geneve tunnel
> attached to it. The following set of actions could lead to the ICMP
> packet being wrongfully segmented:
> 
> [...]

Here is the summary with links:
  - [net] tunnels: reset the GSO metadata before reusing the skb
    https://git.kernel.org/netdev/net/c/e3c674db356c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



