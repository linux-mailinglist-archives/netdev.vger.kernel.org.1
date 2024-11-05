Return-Path: <netdev+bounces-141985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338009BCD38
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641E81C21925
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180D1D5AA5;
	Tue,  5 Nov 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIRJm9bL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EA1AA785;
	Tue,  5 Nov 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811625; cv=none; b=Nr9eMKRT6NWLKltK8TLfBKwWLpqNJE3wIjRxnZXXmCQCr6je5DT4d/bw+wNRHT5czNF1Q5JENgUZhrchkDLWwVE7zLk6vO/ZghS4hbAnpQxmO1WZp1ski9DgpfNa1Z8mcGVqT5DcKXS2dxxXXdhrmjByfpTXqLJ+EeNGSXi74N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811625; c=relaxed/simple;
	bh=4Rj9bmc+FfBeB7t6LEWmU+X8nm4yfav9D2IcSlN6no8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s/mwBjEaWboOJjoH/8jIK/cO/el6gte92yfk8pg3dytvNTHQo2aRF6ECUX65qg8OQwdV43EcvMgKlwGAOzDP5tJHdO9iVkv+16pHbrUq7l5L7iG7P7ma2HuQvqhsMvFKQo+Jz3Dbuubf4VMDkRs4dLulbfTlC6J+wgpubivkFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIRJm9bL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF477C4CECF;
	Tue,  5 Nov 2024 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730811625;
	bh=4Rj9bmc+FfBeB7t6LEWmU+X8nm4yfav9D2IcSlN6no8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qIRJm9bLhbz5F/Ehl4Y7StUP8HY7scmBT8gxucqbWvthX2tI1mhvKRlITh9MjuDGv
	 hXVY0U+m1msXty6WYy2875vJEIpe69OtOvZXDwt2v8r2wAjWJiGM40JpEMlTCU2CTi
	 Jnp/tzVW8Tj7sndISC922p/iz2b1F0DSpcPEhpCVtqQiAj3T/ORJBCfJby7Uq7WK8J
	 gEZEMzzuulY1YroSWRH/YD9Bd+CsfRoqhCYgIB/9T7Yn9DTQ1EPSJCVUHusvGgdK0T
	 nNI784bYTaRHg4fcmnp3hLj29H4uWBnrj40lMOUKOfbTjM+yhE7vlIvk/VgKd1ArHC
	 7gh6wfzn7KXnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF13809A80;
	Tue,  5 Nov 2024 13:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hns3: fix kernel crash when uninstalling driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173081163376.547510.9501662949732713430.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 13:00:33 +0000
References: <20241101091507.3644584-1-shaojijie@huawei.com>
In-Reply-To: <20241101091507.3644584-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, salil.mehta@huawei.com, liuyonglong@huawei.com,
 wangpeiyang1@huawei.com, chenhao418@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 1 Nov 2024 17:15:07 +0800 you wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> When the driver is uninstalled and the VF is disabled concurrently, a
> kernel crash occurs. The reason is that the two actions call function
> pci_disable_sriov(). The num_VFs is checked to determine whether to
> release the corresponding resources. During the second calling, num_VFs
> is not 0 and the resource release function is called. However, the
> corresponding resource has been released during the first invoking.
> Therefore, the problem occurs:
> 
> [...]

Here is the summary with links:
  - [net] net: hns3: fix kernel crash when uninstalling driver
    https://git.kernel.org/netdev/net/c/df3dff8ab6d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



