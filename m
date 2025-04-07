Return-Path: <netdev+bounces-179860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DDAA7EC51
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EB542226F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FCD26156C;
	Mon,  7 Apr 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6x3QZ0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08818261565;
	Mon,  7 Apr 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051202; cv=none; b=O27Th+oSNEyTAs7GhBVHBGcNryBv7KIEksCx06RW62kG9IZMmal4GQnqQlBhvpB98V9Rc7QrCEiX5XoUcXdosFfTUDoYDpVsX2IpAS+j90WY+RCeR356fKZBsDwgHRhioA9nIYqm9laUfDDnhEZN7PakuIRVubWb7KwY0hcyLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051202; c=relaxed/simple;
	bh=BqAYBDV85npiuG9lUU6aZSMxUQypt9VFmCg1ipp2j7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CROxuHzqXOKBrDdbi6Sye1h5RDt/ADNOcvPfyyW/nTDZ3Zhwl+ayNkIOk4T6t+aNO1VpNac3cR38PSGdzGnsuiBdWqnw82YS3GrpvkFkEb2mgtct9ajxe2+iP0QOZrMAjRwX4ZQDMFiaAYWJu/FSbwOCfvka5SPgk3JU2gIWMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6x3QZ0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6050EC4CEDD;
	Mon,  7 Apr 2025 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051201;
	bh=BqAYBDV85npiuG9lUU6aZSMxUQypt9VFmCg1ipp2j7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c6x3QZ0BwKoxZD6akefXms+h1fypLN5lMIPrt0sDhIxCfxWTlzVR5tYnXEEE6tnOS
	 qv8kysHeTGITEKiYRIk9xsm6cTQmvdgN+uehYm/niLVMeKFiCjbaAr+iwIZZUE1rN2
	 LxWivKUSaXJiU3yPRrSL8VULxbx88lzeMG1q0agfOxncWL/WOaIYIHHIF4qIox80TO
	 6SnO4SjzojsAO1O6nULIhndkElXEZnuwQRO+u/WhBNg+E2UN7U/m+0GXm9+4YVT4ob
	 53549X+KUPkp16Gr9UURw0pj+QU+YeQCscyIsz+yvAhmkW/KZdI+Lsl1/hYxKO/byJ
	 fKZKXMDDkwkIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB818380CEEF;
	Mon,  7 Apr 2025 18:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hold instance lock during NETDEV_CHANGE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174405123877.1227543.13613718146765643033.git-patchwork-notify@kernel.org>
Date: Mon, 07 Apr 2025 18:40:38 +0000
References: <20250404161122.3907628-1-sdf@fomichev.me>
In-Reply-To: <20250404161122.3907628-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kuniyu@amazon.com, vladimir.oltean@nxp.com,
 ecree.xilinx@gmail.com, lukma@denx.de, m-karicheri2@ti.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cratiu@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Apr 2025 09:11:22 -0700 you wrote:
> Cosmin reports an issue with ipv6_add_dev being called from
> NETDEV_CHANGE notifier:
> 
> [ 3455.008776]  ? ipv6_add_dev+0x370/0x620
> [ 3455.010097]  ipv6_find_idev+0x96/0xe0
> [ 3455.010725]  addrconf_add_dev+0x1e/0xa0
> [ 3455.011382]  addrconf_init_auto_addrs+0xb0/0x720
> [ 3455.013537]  addrconf_notify+0x35f/0x8d0
> [ 3455.014214]  notifier_call_chain+0x38/0xf0
> [ 3455.014903]  netdev_state_change+0x65/0x90
> [ 3455.015586]  linkwatch_do_dev+0x5a/0x70
> [ 3455.016238]  rtnl_getlink+0x241/0x3e0
> [ 3455.019046]  rtnetlink_rcv_msg+0x177/0x5e0
> 
> [...]

Here is the summary with links:
  - [net] net: hold instance lock during NETDEV_CHANGE
    https://git.kernel.org/netdev/net/c/04efcee6ef8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



