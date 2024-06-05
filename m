Return-Path: <netdev+bounces-100962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EC8FCA9C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C782828371E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0A190069;
	Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4oXe7JP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6114D6EF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587629; cv=none; b=WkUjDUpQ5xndewHJtEX98Mgr72UkMCf5RYKeGW+sOH9AeitOqCGgUgiICVcDA3M2ejNzmuNnJihx4yjQm4TFodC6GQjlg0M/ViCrJ93PIEiU3uFMmTsxpDrVV/Y/ZCsiW2Jou4x8naPqa3XcnFps6cqBioPLdeeioB0QAGE59ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587629; c=relaxed/simple;
	bh=4+kH16YBe2V2JZk5hiVoBbkDmnr57eqBk7tPn4b5yE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/NG8pshViDN1L0of3S0cEtYlr8e1iIJvljyCv7ZXXgqJOgbLCJ/d79UM8WilwiUN0S9+yoB6SEZ6hs6c+2cis53Skjno0BTC4D1yLjBG4wiS31aS88DA6udKf5Qtjy7MCwPexVjiaQutlUtCC0RI3qtP1BoAqBlD6WRa2+CM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4oXe7JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D14E7C32786;
	Wed,  5 Jun 2024 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587628;
	bh=4+kH16YBe2V2JZk5hiVoBbkDmnr57eqBk7tPn4b5yE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I4oXe7JPBOKrqCMCNl0fX2VnKRe3rn9yAo9dpkNWbUlRY2Nr7NmDVYnFfPeZiT9Af
	 nk7OxwkgHzZG1OK0hCV9O5uKSEJe2rsA7VCULsH9syas43jQodDFgpz3uwktNIb//K
	 XVsDwa9ud/g4chfS8h45rXWE6R8MEg/DiSh2iF7fLqtXQZ91RjfBzuTyCKqJnCgGDh
	 WyS9LQTEOKUiQJ4N2n89J8c919LIdbbdMmbZZP6qjOzi+aDRpO2an9JamSp0sARrdE
	 cdrfNuZ97evOQVzSrfTWUNVREtb9pHsVbxu7ploif0xOofuhPJGzbdfK86+MpJ+n8x
	 Yo0jRAsOWZxXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE152D3E997;
	Wed,  5 Jun 2024 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] rtnetlink: make the "split" NLM_DONE handling generic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758762877.21278.45849023083521100.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 11:40:28 +0000
References: <20240603184826.1087245-1-kuba@kernel.org>
In-Reply-To: <20240603184826.1087245-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jaroslav.pulchart@gooddata.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 11:48:26 -0700 you wrote:
> Jaroslav reports Dell's OMSA Systems Management Data Engine
> expects NLM_DONE in a separate recvmsg(), both for rtnl_dump_ifinfo()
> and inet_dump_ifaddr(). We already added a similar fix previously in
> commit 460b0d33cf10 ("inet: bring NLM_DONE out to a separate recv() again")
> 
> Instead of modifying all the dump handlers, and making them look
> different than modern for_each_netdev_dump()-based dump handlers -
> put the workaround in rtnetlink code. This will also help us move
> the custom rtnl-locking from af_netlink in the future (in net-next).
> 
> [...]

Here is the summary with links:
  - [net,v3] rtnetlink: make the "split" NLM_DONE handling generic
    https://git.kernel.org/netdev/net/c/5b4b62a169e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



