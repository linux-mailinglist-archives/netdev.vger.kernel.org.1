Return-Path: <netdev+bounces-224475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F7DB8567A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216A93A6FA7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E2023182D;
	Thu, 18 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb2pIjnL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F01CAA7D;
	Thu, 18 Sep 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207614; cv=none; b=rxLT4IVkgiuCDe31wJzqOCGRmhb7kzkEvYWKVS5aE7dAB7K/bv94zx6U6d0zemedwiCsa8gLx14vEi1LND/jfHBvCpBjiHfZGRAOka8HWXLDLnk3IFREx3/hCCKTGpgMvd7vm6Kv7Of13fIdDx/bvDqmb1BunVOTTnAZUHoaJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207614; c=relaxed/simple;
	bh=G+h/bFhRE3Ywkt/pPjHSXcrMue/DE7K8aAgXSM/YxEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WFMVCrPse/kXBhJ9kBM88g039vYPYxr+mj9KiFD+sSrqyRcxmGSI6rtT2U0zQBji3sXG3qgzGWjo/MHxhBa8+iPWD29vK0i5B7j/Jlmd4EI1KIVvC2NAo9oIS47qwExfNnqtKgXy2c0IEQ/dlXzDPGW1w0tbOfU4FICnyiTjj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb2pIjnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72209C4CEE7;
	Thu, 18 Sep 2025 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207613;
	bh=G+h/bFhRE3Ywkt/pPjHSXcrMue/DE7K8aAgXSM/YxEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mb2pIjnLVhdeSMjqc8S4L92XZtWlZcyxOv7E/pprI0v94MN9qzkeCf4u3wAPyprrO
	 tNXr09OXRSQPd/eLYHMzkhaeS3ZcpVjPogMkBOSpQC5FokIwHYBEDtp9tHr/IxQuh6
	 mbnGgYQglCGJ2nAzgZg9XdxXE7rxqGQEnwTam795yoVo/qIQNoIt0RR7NNdw6ogYVC
	 JPo9V5Tn82zuxq669FlDIfMg/tVGGO8MYPkhGVQufatOtK9UfnDBbwsIhsDGHdBeSx
	 p4tEdJmmSPXAkyO+U8EoD28q/YoKYq18FZDS8e4roi144DuvkTNsmx6i7r6dXpFQ64
	 KfIKta2d8Qkkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AED6339D0C28;
	Thu, 18 Sep 2025 15:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] cnic: Fix use-after-free bugs in cnic_delete_task
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820761326.2450229.3063488196557086048.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:13 +0000
References: <20250917054602.16457-1-duoming@zju.edu.cn>
In-Reply-To: <20250917054602.16457-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 13:46:02 +0800 you wrote:
> The original code uses cancel_delayed_work() in cnic_cm_stop_bnx2x_hw(),
> which does not guarantee that the delayed work item 'delete_task' has
> fully completed if it was already running. Additionally, the delayed work
> item is cyclic, the flush_workqueue() in cnic_cm_stop_bnx2x_hw() only
> blocks and waits for work items that were already queued to the
> workqueue prior to its invocation. Any work items submitted after
> flush_workqueue() is called are not included in the set of tasks that the
> flush operation awaits. This means that after the cyclic work items have
> finished executing, a delayed work item may still exist in the workqueue.
> This leads to use-after-free scenarios where the cnic_dev is deallocated
> by cnic_free_dev(), while delete_task remains active and attempt to
> dereference cnic_dev in cnic_delete_task().
> 
> [...]

Here is the summary with links:
  - [v3,net] cnic: Fix use-after-free bugs in cnic_delete_task
    https://git.kernel.org/netdev/net/c/cfa7d9b1e3a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



