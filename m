Return-Path: <netdev+bounces-113595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7093F3F8
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A688F1C21F08
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D0146018;
	Mon, 29 Jul 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l59nb7dF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9814430E
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252245; cv=none; b=fgL4WQiONybdSRcKkH+/tQLlapcMNSajHiBn6R/goAWCYLKuR3bL970Zx8XCAcgJbZd4j8nqj59y+CRc2heJ5yZigukuH09Fi4WzmUMbmQ2r+iMC1rJpLJ3mtS6JuxfLxoqp5j/yflEDXnJM+opthTQNR+yDgg6fhQvfVGPZ5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252245; c=relaxed/simple;
	bh=Y9jDSqA8HuRLue9Lay5Sk7z/Vw9ZtGkFXeySxKY6HW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KkpPEMmaloTqc/VHUrkdLiaZUKz3I4xCYRIFnLa5tpzOo+J7ZCFDXj8anSRh/hUb/abpn+OJoI5fm/hjFRfaNJtDTlInJ3UT31NFAL4wCcl8L8oItoM+QAdEQMOi5JkNVfxa3YPtPHC1glCuY2Fdm6+p/KAA7TLLdHVubPv4jhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l59nb7dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8B6C4AF11;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252244;
	bh=Y9jDSqA8HuRLue9Lay5Sk7z/Vw9ZtGkFXeySxKY6HW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l59nb7dFH5VA0ydv5H5KN6S/lmkMeufKoZHQaJWx6pYX2+NgyFD8fZLigVbUlV/+S
	 GP4PfcgxYMPSntCzVaNmh6YhhG+eX8rGr7t5X3pr4Ltb2GylPAwk5TnDRJwbkkXDmi
	 S0Bu84hQbDsnztnX6jyAY8hI+lDFNGK5VdGiWtBmZFJtHPd/AqV8RWEP8BQP/0H8Z4
	 II0TkSi7tCIT6v3P5D8ueiV/dXdD4RnVA6BjXK+nANQNYAQDdIOGuMF7ult7lTVTv3
	 m1tyMWcLLM5HbU4ChJk0IzkeMsLJKF38S7Rif7vLrTC/lcd9LswViFFzuesyVI3EGd
	 sUXeqK/Do1Vmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60E50C43613;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] rtnetlink: Don't ignore IFLA_TARGET_NETNSID when
 ifname is specified in rtnl_dellink().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172225224439.15294.6286489955129075220.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 11:24:04 +0000
References: <20240727001953.13704-1-kuniyu@amazon.com>
In-Reply-To: <20240727001953.13704-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jiri@resnulli.us, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jul 2024 17:19:53 -0700 you wrote:
> The cited commit accidentally replaced tgt_net with net in rtnl_dellink().
> 
> As a result, IFLA_TARGET_NETNSID is ignored if the interface is specified
> with IFLA_IFNAME or IFLA_ALT_IFNAME.
> 
> Let's pass tgt_net to rtnl_dev_get().
> 
> [...]

Here is the summary with links:
  - [v1,net] rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
    https://git.kernel.org/netdev/net/c/9415d375d852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



