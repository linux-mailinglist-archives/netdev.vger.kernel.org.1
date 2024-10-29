Return-Path: <netdev+bounces-140055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6459B521B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009092846C9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E0205159;
	Tue, 29 Oct 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/eGoRkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D06205142;
	Tue, 29 Oct 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227831; cv=none; b=cKuSCvUR2A5DpDSkxKj34MVqbCIATEI3Yj8REOThx4spY9CehTfO/5pvd9liMESCkLcszRGfLkOGyEyFK6MM8Zl+hu3VwsExYXTZMS99f3+Ky+ZZKTuJmAxnGJ+o5QCrKga5Fb9yG1Q2G2CJDaWqZNNORycy3YgFjm0whwE59XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227831; c=relaxed/simple;
	bh=rBlUfcEgUOmTcOfhfC4jTlmlQQnYu0Q2rPINT1JL2Nc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RyDKZESVJaMtUNRJD5XnLG2cmw6hVIHQ4br+pyfEdt4as/GcegLwZXaEQJDSd38qQVV6BPvaH5oAw2QsF26KUrit302rA8U7Rxli/rqGDzZlB+DlKZlmSS5RmLNvSS+D8xiBqk3DOToO/vpv9gpTqBLL4NlyC2RSL4Og1GjakNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/eGoRkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20125C4CEE7;
	Tue, 29 Oct 2024 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227831;
	bh=rBlUfcEgUOmTcOfhfC4jTlmlQQnYu0Q2rPINT1JL2Nc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f/eGoRkfJaIKzSvmN5PTob7DvzlHsBAQbvujdC9eS7ewy1DOYBYr5AhKk10UqR5vh
	 VFvLeXhAZxvCWQ47FJ0l3TuN2H57opJJsWGkjRv/oaSmfNU3QnbELvWVyFG7AvsGly
	 QkZ9UEIukh2gJxEM3C/HiHJ1oz3nooJ624dDLRYssyr3uCihq4v7rNHxU8WqAbKiTL
	 lvfGukUZrcWKTYYpIK2lz/AAklB/Js8akrh4wd8PF7r5tJq54XF/XPQet0APvF3Vpy
	 1EKJmzFhDuD77ya9eMiW165CjbTmXUjJnf25eWIXsFWyw9azLw4Anmb7H5fnwUuZQ0
	 VN/DYT2Ax73kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB000380AC08;
	Tue, 29 Oct 2024 18:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_api: fix xa_insert() error path in
 tcf_block_get_ext()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022783875.787364.1221720357635899586.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:38 +0000
References: <20241023100541.974362-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241023100541.974362-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, pctammela@mojatatu.com,
 victor@mojatatu.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 13:05:41 +0300 you wrote:
> This command:
> 
> $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> Error: block dev insert failed: -EBUSY.
> 
> fails because user space requests the same block index to be set for
> both ingress and egress.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()
    https://git.kernel.org/netdev/net/c/a13e690191ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



