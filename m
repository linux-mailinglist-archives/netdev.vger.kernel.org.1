Return-Path: <netdev+bounces-99247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EC8D433C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3D21C231E0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDA17BA8;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph7h1rCP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5314286;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034432; cv=none; b=u1e+VKwpj7A25VOE2rIJzSp5aKCdqaGk2OBp0jeWLCMRt8jHPy7Z47MZMK8c9n9i7Uy1pnBU2uXE9Uyi5YDRSVUO6BpPGqvbeGyJh2Y7CP32Kj+roW63ci6nooVgMVqIlviTwKVmWUrTypQcKYFCR50p1i7a7UeppYh4MtVSMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034432; c=relaxed/simple;
	bh=giUOLxIduZvTBVTj8dQhszO7U46VjwbPQTAZbzSBxX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l1qO7pSLI/RJpQj0wd/wo8ZwEhkVUxoYs4UxSNOAI1f7qRac1lRinwJTPaegGk3+Ii0IWWFRVTshXnn3VdflKexLoakgrIxZA4rtLMWAIX+PaWbQkwr0/hcIBODomkIYPlWjCYjoOcqvOKXpvhPv9+wKxe88CVGbbqhYPQWSJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph7h1rCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58363C32782;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034432;
	bh=giUOLxIduZvTBVTj8dQhszO7U46VjwbPQTAZbzSBxX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ph7h1rCPZiI6AWd1luIlQY43/fXJIM2064EvMijjM2RbaUqF6sM4vDJlS8Bf0Ucgo
	 Cfc2BGIYFpzQTcMvZDYo1/Kl416wW8TsmSRGikm0Goe5tW8cXd445Q2SCT9jIdOE4Z
	 7qjjJbiTf8D0MJTVBICU6WfJeW2KPACbejv9WusV8gTBL9FGmeRcv8xhHwF7Zg0qJo
	 CqpwvTdw1a9zXQd+T6s4GAyuG2HheJlSemG7vfPYS8thnC+5rA8izbRJyLtUsQa9xA
	 bR56e1LOyDAl2xNr5nRaHO3RNCS2wtn79lBlpv/rqfu7/GC2pNoXFjs58eGrxKCUpd
	 8q2zVv7DZJudA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46821D84BD0;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: correctly iterate over the target netns in
 inet_dump_ifaddr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443228.3291.4714432873121553067.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:32 +0000
References: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 pabeni@redhat.com, stgraber@stgraber.org, brauner@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 22:30:30 +0200 you wrote:
> A recent change to inet_dump_ifaddr had the function incorrectly iterate
> over net rather than tgt_net, resulting in the data coming for the
> incorrect network namespace.
> 
> Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Closes: https://github.com/lxc/incus/issues/892
> Bisected-by: Stéphane Graber <stgraber@stgraber.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Stéphane Graber <stgraber@stgraber.org>
> 
> [...]

Here is the summary with links:
  - [net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
    https://git.kernel.org/netdev/net/c/b8c8abefc07b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



