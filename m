Return-Path: <netdev+bounces-100921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5F8FC885
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16A01C20970
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A5190050;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN9dr2dI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528618FDCB;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581630; cv=none; b=LeJLxfxKhGtRzIHlMDKvELH8kZ2kJynnnxNrQDwmuVwpDchvNM+YZIClaFuNqknAm58J3+FeG95KC1IA7hn4+P5kr8N/pTLxTOPmk72z6SrCI8juRwMbr4tYFKogEyWfAlhbk9QuvFsUxffStUacQGlL1BNFW+EAedsQ2N+lBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581630; c=relaxed/simple;
	bh=ah5lFcGcUNfO3Al87vNORNPuk9qkbXVFZHSNOODN1L8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=flHkni1vy4z1kutgWJPxX5ocOoC8aa9yjcvOyYtLPxkV5JgDHt74FgmYH9lSixbobgtOubfOZrvTztbwX2lmfdT9ZJ4fyvYrFdRgFn6f4w+Vu6kKvKYyW/SuqmU6BQOJ5BmCPE26GX4XgBdLnBHkHx7Y9NyWeH+LQ1eSQK9MRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN9dr2dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F7A7C4AF07;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717581630;
	bh=ah5lFcGcUNfO3Al87vNORNPuk9qkbXVFZHSNOODN1L8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eN9dr2dImjRgewatrIX84FtUyLBi+fGq6EemypavzJkdIFm9bNqu2JgRFmnzPDIWC
	 4Piw4d6b2qmSoj8Z0PT6jPwQDOjRWcAZgpRhpewDmqn+OHuWdSIiVP6P2PcMPUYjt8
	 sFB2Vk5yypPizDw6/qnZE5ZqwRKVSb1WC/0XwTgmPOG5VEQdzB1Ep5aXVFYel74Jqe
	 zJT12sfAz96k8K0WX4Ek88Rqhz3lYyO6A+UEeZN1ltrOyOM3FLwZb6OX73FurobD0D
	 sDivVS95uN8VjlnSpNUkasV3kFm3UwrcZWUQgzhezVSWAjG41zmDET0l8Yefyp1+1r
	 sA4anLq5XdIbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D57ED3E997;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: sch_multiq: fix possible OOB write in
 multiq_tune()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758163044.24633.5703861256787494559.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 10:00:30 +0000
References: <20240603071303.17986-1-hbh25y@gmail.com>
In-Reply-To: <20240603071303.17986-1-hbh25y@gmail.com>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladbu@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 15:13:03 +0800 you wrote:
> q->bands will be assigned to qopt->bands to execute subsequent code logic
> after kmalloc. So the old q->bands should not be used in kmalloc.
> Otherwise, an out-of-bounds write will occur.
> 
> Fixes: c2999f7fb05b ("net: sched: multiq: don't call qdisc_put() while holding tree lock")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: sched: sch_multiq: fix possible OOB write in multiq_tune()
    https://git.kernel.org/netdev/net/c/affc18fdc694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



