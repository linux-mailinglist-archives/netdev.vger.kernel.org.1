Return-Path: <netdev+bounces-177454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D4A703DD
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EEB3A7A6F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBCCA52;
	Tue, 25 Mar 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjQSHFdf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175A25A326
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913007; cv=none; b=st7/nEL7DHwG0wK9tL1E0lRBv8Nt2U6dkIZ2McNeGDcG2DxvA8hKBKbUGQWRCMHzvqclbzZzZOzerV+qBj8x7eOSfkDBVoCJhLpjyPZULkr5wh3ntsGLkfYlUfPcEJzbjVuLrJGJUHh9pBE+EiJ5EfZHiE9XkDWJ/+qEAavBTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913007; c=relaxed/simple;
	bh=8DHXaGGQe9ZGM1frtfxljGAjILYPdaHP4Qa/euxKa1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=suKrwc2x8W6tXskw6XDwxbqxOyDblZKPHBHdk0zQ+2CObbNAgz79XX0twyhrTLXzlnRuPW22PIzH5GR8siZK8PYi00HXIh07ropZ9cs3fGArniyo2+eDkH1PxwrZiZrdXcdPsIuKqUjG3Oo66cXYAkTmeSC5F5oXtvpX6gvimM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjQSHFdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F7C4CEEA;
	Tue, 25 Mar 2025 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913007;
	bh=8DHXaGGQe9ZGM1frtfxljGAjILYPdaHP4Qa/euxKa1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GjQSHFdfjhfx+in0KcabjRDBu6kVgWlrMv63L9D70vWXQjVOLedncw/lU9eO3M1gV
	 CK9siT6h3D/Y1BVJ9tmnXN2MQ4M8byGykNBXurN5v+bq2GUzLR04VzihFNYKyzvjrI
	 /tXtD3RFAJ5RB2HW6VtmmuGj99+84KS/EDSlL28xGEpiS8xgJO14ep+visaY+9tFE5
	 B6+zRscolazAqaiMrk6DKaS14rhaOMSmSs6sFV+U289ZAmHA8s0O3Xsw5KXD/X7FTm
	 EsXEn8eekY1Fo3HKiJ41rgVpK/7y4HvgFuesWLr1YXryt3ej98GOaCQOsbg4xJbMJt
	 TmNOX5i2DNhuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B97380CFE7;
	Tue, 25 Mar 2025 14:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dql: Fix dql->limit value when reset.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291304300.595107.14420806181887211265.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 14:30:43 +0000
References: <Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000>
In-Reply-To: <Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000>
To: Jing Su <jingsusu@didiglobal.com>
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, horms@kernel.org, netdev@vger.kernel.org,
 jinnasujing@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 16:57:51 +0800 you wrote:
> Executing dql_reset after setting a non-zero value for limit_min can
> lead to an unreasonable situation where dql->limit is less than
> dql->limit_min.
> 
> For instance, after setting
> /sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
> an ifconfig down/up operation might cause the ethernet driver to call
> netdev_tx_reset_queue, which in turn invokes dql_reset.
> 
> [...]

Here is the summary with links:
  - dql: Fix dql->limit value when reset.
    https://git.kernel.org/netdev/net-next/c/3a17f23f7c36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



