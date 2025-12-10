Return-Path: <netdev+bounces-244209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913DBCB276D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C613034ED5
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E87302167;
	Wed, 10 Dec 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrxgVk8J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B7242D60;
	Wed, 10 Dec 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765356792; cv=none; b=hpnA/qsotX9JdBb5pnIhz9qFHLLH5WESJBxeGR3LI0sr9VxhuYrva/ILxgzvxBXSJVNgTTETRGvu1897a6otpkdsHeSd+7pzkg/J5KuIU0SEV6OkMXjQ7eUVPkoKx/B7X5yDGwZ3Qj5fe5ecOd6OY0xMMOgaNvAFmN7FH+Hr8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765356792; c=relaxed/simple;
	bh=qDoGNCAWf0schiIM49QK83nRwlPkw6VFdS9o9n6aVxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8pclmPxHlepgJ6htQtsEI0HzxRlxeagrGfDu67lV3HYQWxP01FRJ+wS5WSga85JLrecv+j0x4giqTJorTwx5tUm+ehDnbqKv3gBACQIUFprxhgA0B1lGay8O8nwwsubex1XdvchWQ5tD4EKtczf8iy+IbhiGq1l0jbXKpsvOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrxgVk8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB5C4CEF1;
	Wed, 10 Dec 2025 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765356792;
	bh=qDoGNCAWf0schiIM49QK83nRwlPkw6VFdS9o9n6aVxE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JrxgVk8JnZhTB9JlhdOSG9CMgt6QfDEM53yavRekh/ZjZbOFCkY+p55WeZUivMrZC
	 HRTWc3LIgjPQVmGt0SlFZ+TpzHtZvvJubTDo8+LDyDSXrOvzth6hDmKmcvg1NVgvDX
	 3k7K+M5X5OOkn2tmYV/+yS+YXX87FNQvPU+ML3tREK4XH/NIR+vEviliGwceth+jeI
	 AO/tAn9rLt6VyETOL5ZlU/SYDpSnebileohUdRAitUZA7om21UShFITWA135ht+qjT
	 ZauARhCB/ulkZwqTVvC3KH6QPLF2LKgkk4yZolCdkmJ+lK48DoUfIOhDyLt1oRmZcT
	 iWHPnpFBq9cig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA423809A18;
	Wed, 10 Dec 2025 08:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix middle attribute validation in
 push_nsh() action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535660704.514912.11425837372382255386.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 08:50:07 +0000
References: <20251204105334.900379-1-i.maximets@ovn.org>
In-Reply-To: <20251204105334.900379-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, echaudro@redhat.com,
 aconole@redhat.com, w@1wt.eu, kwqcheii@proton.me, zhuque@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Dec 2025 11:53:32 +0100 you wrote:
> The push_nsh() action structure looks like this:
> 
>  OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...))
> 
> The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
> nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost
> OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
> inside nsh_key_put_from_nlattr().  But nothing checks if the attribute
> in the middle is OK.  We don't even check that this attribute is the
> OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data()
> calls - first time directly while calling validate_push_nsh() and the
> second time as part of the nla_for_each_nested() macro, which isn't
> safe, potentially causing invalid memory access if the size of this
> attribute is incorrect.  The failure may not be noticed during
> validation due to larger netlink buffer, but cause trouble later during
> action execution where the buffer is allocated exactly to the size:
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix middle attribute validation in push_nsh() action
    https://git.kernel.org/netdev/net/c/5ace7ef87f05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



