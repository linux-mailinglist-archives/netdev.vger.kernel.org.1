Return-Path: <netdev+bounces-104456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263F90C9AE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF93287582
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE814F9E2;
	Tue, 18 Jun 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drEOUT6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C714E2E0
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707232; cv=none; b=QK5UdbUbZauCEfalh1lm/pl7qh6RQA34KHrmvmR8pTYgQ49MSLO69FAcvbCtNyZtTCpJzTdGL8T+UjsB9Eq76JYNHQ8z2B/DGrORaqYYCufMoVmpk+RVmnDO90V1BhvpmyYSdEXnjAoQowVcEegkRM7W+rZ1fC3ToxS/7gE/bDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707232; c=relaxed/simple;
	bh=VLLrNfmlqSPOom9/DINcolNHmglbfFS5/VPk5eADx/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OGfnZDLW6qyQsKm3QPOLYzgk3YZgphgyR5PRc+K0Df+0CcVOXGuChZdkN5H9Zxx8Ug43WStME2MkFIrSBlgxuvfKxIRMdi+Z0/Q89bRNFHQ0QL4tubqqtgdoubvRhrqGY42anjAD0kNCJNXJMXxdHiocDUHnQVviI/dQQPWb8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drEOUT6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDC2AC4AF48;
	Tue, 18 Jun 2024 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718707231;
	bh=VLLrNfmlqSPOom9/DINcolNHmglbfFS5/VPk5eADx/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drEOUT6vQ10TuCQK5imDiG568hNdVGKHLAtyddCxAs4LPggV8aSc82QVtN0ncfzae
	 8ur/8SdED6hBnpJVaj2uj3jUzZ//S168IIQQuVvPYDKdiRsgy1e/mUPMYflFcy3cCp
	 DcbvPx077gkUPK87lC90ufnuuYYs1rqzoj8y4MLlFdJIAHrgnzCSkt2tRTIBXaKQM8
	 gQDaeoObjmWSrTVjbDphlHvMuhr1mZy/rtF8jB7IiOHudvty9IdwBhR4wNWOphJBF9
	 wOuW3N8pCvjN/UqDvxkGEmB25xN76hI4bmh6DNKp6c9ROxgwe3w/TlVIUCsn4mBvt0
	 Duig/DRSwI5lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D4EC32768;
	Tue, 18 Jun 2024 10:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/sched: act_api: fix possible infinite loop in
 tcf_idr_check_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171870723185.3952.10944703031016003851.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 10:40:31 +0000
References: <20240614190326.1349786-1-druth@chromium.org>
In-Reply-To: <20240614190326.1349786-1-druth@chromium.org>
To: David Ruth <druth@chromium.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, marcelo.leitner@gmail.com, vladbu@nvidia.com,
 syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jun 2024 19:03:26 +0000 you wrote:
> syzbot found hanging tasks waiting on rtnl_lock [1]
> 
> A reproducer is available in the syzbot bug.
> 
> When a request to add multiple actions with the same index is sent, the
> second request will block forever on the first request. This holds
> rtnl_lock, and causes tasks to hang.
> 
> [...]

Here is the summary with links:
  - [v3,net] net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()
    https://git.kernel.org/netdev/net/c/d864319871b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



