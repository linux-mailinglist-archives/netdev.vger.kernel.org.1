Return-Path: <netdev+bounces-121202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA195C2C2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7953B22433
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB3DDB8;
	Fri, 23 Aug 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsg/022L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8CA953
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376028; cv=none; b=auCKby3y5fb+cUBFnMwe2I7fHvplcS7Fc3yHj4Vdgyz5YzKPOCtXVMGD2WD6L+82qJ6MnWWXtHhNPAneNiKwueeAzR2U022dd5X5v23dUDYtZ93rmfE9bAxVG8fzRcp7Bdvqvv0u2v0SGJZ3STk2Uy98kXy+XhIvg3rNFldK314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376028; c=relaxed/simple;
	bh=ZaFmiprQOwRhsuZ6W2KEZ0U0SUsKaaG+pQ2Y/cMl+Ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nV6rN9I7zdFXglyF2Gkp5FFAL7RQvC5z8YK6UBjrrOfrLhJ5WKntpo7qnMbsSxhus/jSZ3DMj3bUOCK1jToE8J9CIqSB5xpfX+yYiPGQ6T6ZI6vXKPiLUSO1rKAnML56/YPh7A6GEAjk2ief8X4ltBvvzSStSz1tlMS/gNDkWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsg/022L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F629C32782;
	Fri, 23 Aug 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724376028;
	bh=ZaFmiprQOwRhsuZ6W2KEZ0U0SUsKaaG+pQ2Y/cMl+Ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qsg/022Letfm1uiEdNCHzUOo6O/bQXif2vWl2NdDQONxOESzIxgjp8tpiPD+jsKY/
	 aslCwR8ptDZ09w2y5nlNc7B0Pvtog86gg/jZ8DC4rPI7XSkKkkPvSUaAaOx1E90Zbp
	 /8L3g2S3zYbsfHYiaTuVLmvv3quKlZ43U77IFBSN6z7tddvQ5mT2fFzHkcXfuQkPj0
	 aDXCoYOFc7bEJW2K/1MIJvESkOvfz1g3TyojzV7kHH+UT1J5BdkjJn8Lshx2MemYpK
	 vhegwXG36SVcJu0L3QcGeJNy19o42A9mEFJ+gFLfJi8eZ9WvE5TzQPwgjQXgS78pV0
	 52Ac61xflRXlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB34F3809A81;
	Fri, 23 Aug 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pktgen: use cpus_read_lock() in pg_net_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172437602776.2526835.8432803569402828187.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 01:20:27 +0000
References: <20240821175339.1191779-1-edumazet@google.com>
In-Reply-To: <20240821175339.1191779-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 17:53:39 +0000 you wrote:
> I have seen the WARN_ON(smp_processor_id() != cpu) firing
> in pktgen_thread_worker() during tests.
> 
> We must use cpus_read_lock()/cpus_read_unlock()
> around the for_each_online_cpu(cpu) loop.
> 
> While we are at it use WARN_ON_ONCE() to avoid a possible syslog flood.
> 
> [...]

Here is the summary with links:
  - [net] pktgen: use cpus_read_lock() in pg_net_init()
    https://git.kernel.org/netdev/net/c/979b581e4c69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



