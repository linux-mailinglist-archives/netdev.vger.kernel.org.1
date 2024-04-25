Return-Path: <netdev+bounces-91159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F238B18FE
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D52855CD
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD35134AB;
	Thu, 25 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m96FRFCU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AAAD2D
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012829; cv=none; b=FWV0nZD+MZsNivtVVOCp9hMC6rqBB8EVe1SmrOfZYHEDF/L8F0rT7sp4lHEL6YtwiVkxv/NxQ9cUExrbqytzGgfimPq7Sc6NoRQmJRXZR4lFiU6vIfxzVXbqKLozq83Ty9bfduzxLPkuKCbXQZRBkOe5w+firkvr3A/FqeVVIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012829; c=relaxed/simple;
	bh=s3n/tQBBuQ0xgJM1UpJuy8GUGRIJcOqQducdG5oOk1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOEJLEoB3usnkWoAubgW/vL0tLTru3kM7cAphkXMPhdcLD4fy6HlLwxRz1soHwWXCK9xO3GKJq7xqohdkX4OBb/iZR9O3e2aaNpA1xFbK0AluGdXutB3scTmoGFUn/wqb+j6YZcX+o5GzGhZKeS/n5K0YKVTiYbEr8xy/X3OmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m96FRFCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5948FC113CE;
	Thu, 25 Apr 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714012829;
	bh=s3n/tQBBuQ0xgJM1UpJuy8GUGRIJcOqQducdG5oOk1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m96FRFCUKzDmzfTbpcYG4EjUxmKDTtsty+X9IC4Mkg4IB7OGhOBlYDmOiKeppvWEE
	 4MQWts1PV2m/T4dtPnuihw2inStn2IshGMSjL4y39WGm2hDcOmy2Jg+nnr2nVNy3TR
	 1Bbfxsf2roAxvHczmvFW0aoNLFwD+gT/gZv0pKIPjKZdh7SKSmcDa5gftxgPvRiIg6
	 ncFe04X95RDu45EgBAJ580d2iFBTOCD0wSHoPDqnLtrwZemeIe2xAqBiaJR6BV5y0S
	 lHz7EIS1p1FQrNwciSxvDXwyxH6t+wadbiMwsSrsFlR5WDaNS50D65fxwL9Xtph5Ow
	 LarFMf2Z1GnNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F3BFC00448;
	Thu, 25 Apr 2024 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: openvswitch: Fix Use-After-Free in ovs_ct_exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401282925.22297.6867193227538969798.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 02:40:29 +0000
References: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: pshelar@ovn.org, edumazet@google.com, imv4bel@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dev@openvswitch.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 05:37:17 -0400 you wrote:
> Since kfree_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of ovs_ct_limit_exit, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
> 
> To prevent this, it should be changed to hlist_for_each_entry_safe.
> 
> [...]

Here is the summary with links:
  - net: openvswitch: Fix Use-After-Free in ovs_ct_exit
    https://git.kernel.org/netdev/net/c/5ea7b72d4fac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



