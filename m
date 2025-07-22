Return-Path: <netdev+bounces-208872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF206B0D734
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413C77AEFD2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD22DFA3A;
	Tue, 22 Jul 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJzqA3lM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF42DCBF8
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179587; cv=none; b=DzxTGnP6giYXFhMvWMRBEWjDccjnnV6wIJJOAr8BZ1guE+pZ8LF3s8BkzVQqxkywLlMgFOzRNz8CSOU9q4B+4maPRvGdinpnK7zy2UT8m8rS4shLxQFpOSYVfv8m6RVcI0BMa1OF9UohtaryhJZHEzttK+hWnaUpxA7kWmO0p/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179587; c=relaxed/simple;
	bh=uLEMnNuoinmcnvFghjFSR8yAkndmKOfhxLRxs3OWMhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzFcuCF+YbkY1NRYxeGNJEPLSeea2Owi62PobCLHcJPgz315alrYiDbk1W37ICxkl5n+QLZFUJaGGOzbECwPgwhC9DdcvdF8SyDutjONw8OcSJiZO9kwO//G6pnutEvOeiXDbyFkMdxGOe3Z3Nm5TXk4u4lLIrsoTcvSa8/9rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJzqA3lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB8FC4CEF4;
	Tue, 22 Jul 2025 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753179587;
	bh=uLEMnNuoinmcnvFghjFSR8yAkndmKOfhxLRxs3OWMhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tJzqA3lMKdSGXWlv7h3J7fULDRCOmtE1QRwdy2sksbgmRbXhGhjhc4k2FIUUcVZYj
	 dup0M5DnIS86cEeTgFxhLHnutxlkm2yJdaR8jRU1rwYqB2FmsyhGUPg6MfV33JikPC
	 dMVDbiyKLmoIDwydhfL44XXydPqbipPkJvRegt2xeApY+7HjyZaYUNdYzQ71msvnhI
	 pbz91X5nPzStx2dmox7R4I4LFC0TN0HDEOvVDMcU3egzXLq9AQeWBnrGNqH8fd9OmE
	 gXQZNi8+mPl14o86IGzqJDWlaZvYExQbigPL+IJGMtMlmUqLv3eXdkFdNGXvnh4rD5
	 mqPglBYri96nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CEC383BF5D;
	Tue, 22 Jul 2025 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net/sched: sch_qfq: Avoid triggering might_sleep in
 atomic
 context in qfq_delete_class
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175317960626.748884.2193607550680698831.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 10:20:06 +0000
References: <20250717230128.159766-1-xmei5@asu.edu>
In-Reply-To: <20250717230128.159766-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: dan.carpenter@linaro.org, xiyou.wangcong@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Jul 2025 16:01:28 -0700 you wrote:
> might_sleep could be trigger in the atomic context in qfq_delete_class.
> 
> qfq_destroy_class was moved into atomic context locked
> by sch_tree_lock to avoid a race condition bug on
> qfq_aggregate. However, might_sleep could be triggered by
> qfq_destroy_class, which introduced sleeping in atomic context (path:
> qfq_destroy_class->qdisc_put->__qdisc_destroy->lockdep_unregister_key
> ->might_sleep).
> 
> [...]

Here is the summary with links:
  - [v1] net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class
    https://git.kernel.org/netdev/net/c/cf074eca0065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



