Return-Path: <netdev+bounces-208047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EFB098A7
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DC93A9BE3
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788923D282;
	Thu, 17 Jul 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AenJVz5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9549641
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796207; cv=none; b=eu3hyb6828PpPy3c2KTeS0eJ0Or8f//uWXZHweBxHG+pQSwq63URi4EidVymaUClK39NDOT3xxc7CfteWgQQGM5QR9yfdCHkvbNER2TDCI3iXaw3xMq0ERWAOE6BLwA8DzofQ2qr0gxm8lRdrtiu0AzB/pExc88JVdFj8sJliIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796207; c=relaxed/simple;
	bh=sInIpVs4T+rp5BzQYD8t3+vbPTWN/PEcr8zQtepOpNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fK5Yehn3nCkls871nV3wJCYLq8/l3yOKq6rJvCANMyf6ACnBDfXfCeK0jX4PiK2md3kfmOKCQRx+lVbtojuVwI3f93b0+n+p7l1NgxtdP0pAAQcsieIxa8CK3p1F/VuIrVS2np59XJEaYfQ7ZgiKIAlZVrtKbYeQm37Kuw9jB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AenJVz5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867A4C4CEE3;
	Thu, 17 Jul 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796206;
	bh=sInIpVs4T+rp5BzQYD8t3+vbPTWN/PEcr8zQtepOpNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AenJVz5Bz7OLUaEHoujbmUstEYWT9IW/BWDAAWd++mMXc1D06B3ZdtsuYCn595mJh
	 asK5C7qjO0yZ6u0/7G8L+CeU3BqoJ72DgoyeHrPaWF+TbsCvVMdihI1+uMlN6O3Ijv
	 dxJCcKxfDpj61PUGZmqm5CqRGjAnRO26Db0WhNvaimuwlzrh26SlrGnT++b4RVa0j9
	 8cxluVIilEK9XWxfu/6G3qSHNzRiEZ0dML/+OlzTANaOu4Bz4Xe0ww2qXTKUbJEBuu
	 DnVaF+EbWBHJZXhtbW+x6IzrwA6DRrY104+bYigpOnONyPI3Hmz4lbMZlEB9h/fnAp
	 hG6wRUlJ0dncQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF1383BA3C;
	Thu, 17 Jul 2025 23:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] neighbour: Convert RTM_GETNEIGH to RCU
 and
 make pneigh RTNL-free.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175279622650.2114222.281952232273235731.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 23:50:26 +0000
References: <20250716221221.442239-1-kuniyu@google.com>
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 22:08:05 +0000 you wrote:
> This is kind of v3 of the series below [0] but without NEIGHTBL patches.
> 
> Patch 1 ~ 4 and 9 come from the series to convert RTM_GETNEIGH to RCU.
> 
> Other patches clean up pneigh_lookup() and convert the pneigh code to
> RCU + private mutex so that we can easily remove RTNL from RTM_NEWNEIGH
> in the later series.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] neighbour: Make neigh_valid_get_req() return ndmsg.
    https://git.kernel.org/netdev/net-next/c/caf0a753a8eb
  - [v3,net-next,02/15] neighbour: Move two validations from neigh_get() to neigh_valid_get_req().
    https://git.kernel.org/netdev/net-next/c/f5046fbc1b6d
  - [v3,net-next,03/15] neighbour: Allocate skb in neigh_get().
    https://git.kernel.org/netdev/net-next/c/3dfe0b57dcda
  - [v3,net-next,04/15] neighbour: Move neigh_find_table() to neigh_get().
    https://git.kernel.org/netdev/net-next/c/0e5ac19c7865
  - [v3,net-next,05/15] neighbour: Split pneigh_lookup().
    https://git.kernel.org/netdev/net-next/c/e804bd83c1fd
  - [v3,net-next,06/15] neighbour: Annotate neigh_table.phash_buckets and pneigh_entry.next with __rcu.
    https://git.kernel.org/netdev/net-next/c/d63382aea70a
  - [v3,net-next,07/15] neighbour: Free pneigh_entry after RCU grace period.
    https://git.kernel.org/netdev/net-next/c/d539d8fbd8fc
  - [v3,net-next,08/15] neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
    https://git.kernel.org/netdev/net-next/c/cc03492c7b92
  - [v3,net-next,09/15] neighbour: Convert RTM_GETNEIGH to RCU.
    https://git.kernel.org/netdev/net-next/c/ed6e380d2d41
  - [v3,net-next,10/15] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
    https://git.kernel.org/netdev/net-next/c/32d5eaabf186
  - [v3,net-next,11/15] neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
    https://git.kernel.org/netdev/net-next/c/b9c89fa128fa
  - [v3,net-next,12/15] neighbour: Remove __pneigh_lookup().
    https://git.kernel.org/netdev/net-next/c/dd103c9a5375
  - [v3,net-next,13/15] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
    https://git.kernel.org/netdev/net-next/c/b8b7ed1ea83a
  - [v3,net-next,14/15] neighbour: Protect tbl->phash_buckets[] with a dedicated mutex.
    https://git.kernel.org/netdev/net-next/c/13a936bb99fb
  - [v3,net-next,15/15] neighbour: Update pneigh_entry in pneigh_create().
    https://git.kernel.org/netdev/net-next/c/dc2a27e524ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



