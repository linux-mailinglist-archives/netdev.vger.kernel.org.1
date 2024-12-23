Return-Path: <netdev+bounces-154082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF29FB3D1
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C56166783
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F71C1AD4;
	Mon, 23 Dec 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtC5JxZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A521C0DE2
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977417; cv=none; b=cBQ22IVyuO7/0cwTATnt74BuqJLSY88b4QYNJ/1fmbRcM+F+zSsN9We4nw7YjY2autOW9eKtVNCtLUB3z1KKY2l0f2wJqCJ0M6zXZq18FcaDKjo/Yxb6i5foWX0ku5ad2HZUEQjT5X3x9u3liVun/eGrSW0r0qHrC1XRMp+W7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977417; c=relaxed/simple;
	bh=iXI/smPbFYNx/DcVICCJ+70TL3GUEYIUm3GHSLcD9Cc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MMpYwV8Y88ZoTmYPfW0AOPL+wSNlsVkXwRe2je+5yOCtDAzZ+h8UUEEPYHu/gWDn177jV1hHX2DANFjNlF1NJxtlJ1I18jSTlwC6oifq1ooH26ILH9YvWvWjqWK6RD06Ox62P25mwQlaCRxqx8lx81eIGv0zERs0/ecGjo/RUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtC5JxZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4836DC4CED3;
	Mon, 23 Dec 2024 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977417;
	bh=iXI/smPbFYNx/DcVICCJ+70TL3GUEYIUm3GHSLcD9Cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MtC5JxZsZAjR4NVyg5pLvlMQu25Pk/6jbLnqaucEPwZKvN9L0XzxPsGs0STS4Oosu
	 HorpnRAfDnTF63oQP/lhF7ZjkoP44uzyzemSSAVfNY3rkNGW1TtH+W5ix6KJ+svJEe
	 jqc13PVCnApVcE/+LrOhidjJrPYbKdK5gGqh9FNUaTwsuZ20zp0xHs0tIaKQR+axqk
	 s5EpsLYSRyPuFsiiXAVtgZP+STsE1fddoKbLsTvk2BP6FEvg7yEsSBAria1hWjzgby
	 n+7rrZ0pA+bzP2MQfBbPdpYyJmH+l0V2hd3KFSKBdPKSmUZel3ww270wIfqioX6mm/
	 ATE2tT41ZOb7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB403805DB2;
	Mon, 23 Dec 2024 18:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Fix netns for ip_tunnel_init_flow()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497743545.3921163.7394913074374940004.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:10:35 +0000
References: <20241219130336.103839-1-shaw.leon@gmail.com>
In-Reply-To: <20241219130336.103839-1-shaw.leon@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 21:03:36 +0800 you wrote:
> The device denoted by tunnel->parms.link resides in the underlay net
> namespace. Therefore pass tunnel->net to ip_tunnel_init_flow().
> 
> Fixes: db53cd3d88dc ("net: Handle l3mdev in ip_tunnel_init_flow")
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 3 +--
>  net/ipv4/ip_tunnel.c                                | 6 +++---
>  2 files changed, 4 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net] net: Fix netns for ip_tunnel_init_flow()
    https://git.kernel.org/netdev/net/c/b5a7b661a073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



