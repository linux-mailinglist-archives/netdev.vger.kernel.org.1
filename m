Return-Path: <netdev+bounces-137799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393749A9DF8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA30DB21D4B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C8A1547E9;
	Tue, 22 Oct 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuPm9AMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509D14C5A1
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588226; cv=none; b=HHYRfbnbWl8YjzlocM95UM91/j6KF/KbSirZ2nfMUckJp8owNlI/UM5uZ6gNtTRs65OV+pTJLUoJIwoVEjxaduDS6mCvudWoYhrbSNC3fPz31LNlZ0sg94aun/b2giDzoGY2+khqQrGvGgw5I7eovrd+XYvk0oxCnvwBDR2twMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588226; c=relaxed/simple;
	bh=PcdskuQoceV05WVL9zN6DE9InTmW08VJISHAi1W2DdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=osUxJjMC2Xx7oU5ZsqsduL2CWMCcVcdWMQ5PsJtqgZ39aKNE0vEBdAYe+TGtBtEgRmKhlWfzKRrL4YDdx7oRrIgoaWJyOcBMVzGuSoSEKhpAFEq+zeMFiCKFHKI1UcfQD/1yXougnELc1mp6lhy4uX108wOf9m7idQTOyT6wu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuPm9AMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46026C4CEC3;
	Tue, 22 Oct 2024 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588226;
	bh=PcdskuQoceV05WVL9zN6DE9InTmW08VJISHAi1W2DdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VuPm9AMwxhXhb9vFW5a+i/m7+Ic0h6axkDhEOIYd1hechM3IeXGJyAx/bzvimTVs9
	 3Yvtv8jbnRXIv6MNxJJqPtPJgdmbtUldG/g4M+hD5WisGpDah10KyeckGHx6UsTBdW
	 oIL4cczUKFaQSZBtqF29oUzQoyzZP04CGddZNv3h3G5MrMfOhfgU3M+tqvt3IBwuVs
	 lTNBebZ6Kkgj1+8AdpT7v9+2n2FAIbmGReFksg2YSkbBRzUpjD7AwyLR6oWAOrgyVi
	 LtGldaktiRVNBvHxcL59brynVsBWlHWfOq65CpLTpfaeC6LmmuBGWD+9GoGNuYJoZ3
	 sidUouNTh9cpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF213809A8A;
	Tue, 22 Oct 2024 09:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/14] rtnetlink: Refactor
 rtnl_{new,del,set}link() for per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172958823250.899631.13319996759425945060.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 09:10:32 +0000
References: <20241016185357.83849-1-kuniyu@amazon.com>
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Oct 2024 11:53:43 -0700 you wrote:
> This is a prep for the next series where we will push RTNL down to
> rtnl_{new,del,set}link().
> 
> That means, for example, __rtnl_newlink() is always under RTNL, but
> rtnl_newlink() has a non-RTNL section.
> 
> As a prerequisite for per-netns RTNL, we will move netns validation
> (and RTNL-independent validations if possible) to that section.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/14] rtnetlink: Allocate linkinfo[] as struct rtnl_newlink_tbs.
    https://git.kernel.org/netdev/net-next/c/fa8ef258da2b
  - [v2,net-next,02/14] rtnetlink: Call validate_linkmsg() in do_setlink().
    https://git.kernel.org/netdev/net-next/c/a5838cf9b2ee
  - [v2,net-next,03/14] rtnetlink: Factorise do_setlink() path from __rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/cc47bcdf0d2e
  - [v2,net-next,04/14] rtnetlink: Move simple validation from __rtnl_newlink() to rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/7fea1a8cb4df
  - [v2,net-next,05/14] rtnetlink: Move rtnl_link_ops_get() and retry to rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/331fe31c50ef
  - [v2,net-next,06/14] rtnetlink: Move ops->validate to rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/0d3008d1a9ae
  - [v2,net-next,07/14] rtnetlink: Protect struct rtnl_link_ops with SRCU.
    https://git.kernel.org/netdev/net-next/c/43c7ce69d28e
  - [v2,net-next,08/14] rtnetlink: Call rtnl_link_get_net_capable() in rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/0fef2a1212f1
  - [v2,net-next,09/14] rtnetlink: Fetch IFLA_LINK_NETNSID in rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/f7774eec20b4
  - [v2,net-next,10/14] rtnetlink: Clean up rtnl_dellink().
    https://git.kernel.org/netdev/net-next/c/175cfc5cd373
  - [v2,net-next,11/14] rtnetlink: Clean up rtnl_setlink().
    https://git.kernel.org/netdev/net-next/c/6e495fad88ef
  - [v2,net-next,12/14] rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
    https://git.kernel.org/netdev/net-next/c/a0b63c6457e1
  - [v2,net-next,13/14] rtnetlink: Return int from rtnl_af_register().
    https://git.kernel.org/netdev/net-next/c/26eebdc4b005
  - [v2,net-next,14/14] rtnetlink: Protect struct rtnl_af_ops with SRCU.
    https://git.kernel.org/netdev/net-next/c/6ab0f8669483

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



