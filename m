Return-Path: <netdev+bounces-99938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A526A8D7274
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F00A281F84
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CFB28DD2;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxNGgKW7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4251F959;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280434; cv=none; b=mgH9Nq6k/NPMXpBUdssYB4fOLr/FYmkEcnYMFDWqdusRqWrUKkXwdVUAutQICp6qwUFMvsnqRtIGbU6BThegNsDFoRgKICQe3eVCrpaE0jaJGYU5cnx3VxS+Hg1CpQyUwqIUwPpCP1iIXkpxCLJQz7mqZYv/izZ1eXwyGA1Lw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280434; c=relaxed/simple;
	bh=zqQztH8UIqfKQXixjYZIEyf0ArNAJe4EDVGpd4JB9Zk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ag3w0QvgeGRgKy/lAquLsZc6UQUiiQl/+CL3vjJbr70wEhgnRbdjoJJDubtoGXo0MfKPDt1wOk26FVWB/4wRoYwcJCxRdHy1CW1WxV8CjyfGp5+AIqIbyGHQB2sP1ooS80Br925nVk7kOdfaTC7S0pSxSSgSpjD6QGs4+aZPrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxNGgKW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE44C4AF08;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717280433;
	bh=zqQztH8UIqfKQXixjYZIEyf0ArNAJe4EDVGpd4JB9Zk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxNGgKW7RfsKyCfn+ExcjePaDpueWJVfXiJZctQovRBCIUzuQ6K/qiSFdBli/Pe4b
	 JiCGQ4w9nfpSg7M/rpAQYLuWZ+LxgRE6LMsAnKqUH5HaSGNOlNDtmbh5Pb+i04i5El
	 V7I4LvB/e4D6mj+OL2GGBhvh9za9cDAydN1fN9VCSMA/30qldmDoVcQ4cT1lb87hek
	 8Ck523nR0stJPGU7ym7GAx3FPP5Wa0hpxh84/AQuGhoV/RsHC7xyAw60UUpPLvoG/6
	 nD2GTYuc0H+uO8AL8LvFSEO+aeiVJl6P2yiammRlPcT3/Xyuqp8HQe90ZRmlBmhv0G
	 svkjfgRE10QNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D959DEA716;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] virtio_net: fix missing lock protection on control_buf
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728043364.17681.12481815300308463832.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:20:33 +0000
References: <20240530034143.19579-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240530034143.19579-1-hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, danielj@nvidia.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 May 2024 11:41:43 +0800 you wrote:
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
> 
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] virtio_net: fix missing lock protection on control_buf access
    https://git.kernel.org/netdev/net/c/30636258a7c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



