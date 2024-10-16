Return-Path: <netdev+bounces-135943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804CE99FDAC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45816286E66
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE318452E;
	Wed, 16 Oct 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ8875nA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4445186E5F
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040428; cv=none; b=fqEOSRoX708m/MusjjOFl+jdeOAb1whZLnBiXevF2re1NN8Z+YN+OnL1HcyE1t4Mf8YuxRD4VzC2+w0wurQwOli+r+gu6z9VsVGolb1cj4sdNDCH+hdueSjTi7gUSVBR8miCfuGTTtt/OlH1S/av6yHvIkScl6j/lPGvBpxnGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040428; c=relaxed/simple;
	bh=lYQeWFCYZeLnSPpknAUYuSKVINzVgnNbeuWp5q8557M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hs3TduwDG14RACQz4HMAbXUz7cWisrd+JV9kQDhTOqlQR2PDbLCHk7U7oYeVbH+o1Aq2LAVOpsAJ0nb6/cjk9qrZb0Vwd2w7/AAwnretlP/NgvKLGSIhujj5/SZQPJcLGBetGA/fDpcLZLXAS0a7HgKED88aFGqeJL8eEO/7no8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ8875nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B92C4CECD;
	Wed, 16 Oct 2024 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040426;
	bh=lYQeWFCYZeLnSPpknAUYuSKVINzVgnNbeuWp5q8557M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KJ8875nAC3lYtIZf9wyIJaaH7Xaq+PbClcyo9qXG2OVSshbUglGCQp+GbBCHsRM0g
	 c56ocXKy3ji1AamoAp6vdt2eRimVmz8VPj7a0bpRtZAlhsat/v1G2p8I72p6C/vHHa
	 YfC3l+JpthIHQZPRxqu8iSZ9mB87BjIfV9CUk4Wu0m2X9UpXRByp8K+OiP45CJk0PK
	 cCEQz/KgaM/i6zoe+h2alk9TM4Y+DM9j1gqNptJYLJwVvCLPNq+O1dUJJC1K9Xv605
	 97nwtiHoWdXUtd/dnjxIdgDtO/+R35BTROlGh1OrqDFC0dOPMwX6uBPdnYKOlI+xoz
	 gCPJo7w+4zLxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE05F3809A8A;
	Wed, 16 Oct 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] genetlink: hold RCU in genlmsg_mcast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904043123.1343417.496516714849823258.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:00:31 +0000
References: <20241011171217.3166614-1-edumazet@google.com>
In-Reply-To: <20241011171217.3166614-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jchapman@katalix.com,
 tparkin@katalix.com, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 17:12:17 +0000 you wrote:
> While running net selftests with CONFIG_PROVE_RCU_LIST=y I saw
> one lockdep splat [1].
> 
> genlmsg_mcast() uses for_each_net_rcu(), and must therefore hold RCU.
> 
> Instead of letting all callers guard genlmsg_multicast_allns()
> with a rcu_read_lock()/rcu_read_unlock() pair, do it in genlmsg_mcast().
> 
> [...]

Here is the summary with links:
  - [net] genetlink: hold RCU in genlmsg_mcast()
    https://git.kernel.org/netdev/net/c/56440d7ec28d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



