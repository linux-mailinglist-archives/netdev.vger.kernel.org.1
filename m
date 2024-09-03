Return-Path: <netdev+bounces-124342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D41969107
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A451B2095E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6301CCECB;
	Tue,  3 Sep 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTXMmwgY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCC4685;
	Tue,  3 Sep 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327628; cv=none; b=WmQQtCBueIzFS0UxJZgYNxQdN1peuj3otEIV7CRBkh7U2xD/bkW+95Bm4EIPpVhaFEGf1GCNPSm/zfioaZKyzdnXqH7SRxDHE1YPJAS0jXILR1xX4JI6hQRNKWShrqqA4+QyhQo2W9nEa2uwGgLHxBRoKKwaOIp2iDS3uhvr1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327628; c=relaxed/simple;
	bh=fLY1zZHneHkscAokWVVEhoFYpulyXBBVEIROgVCIbrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FThyw9egSZg4NcZ5GZbuw6mbznjRhsMa8gpA5K20zhOzpoqS/POfwWSfAu5Ap0T5ZdZAolbFDOFvb6KjhKAdM9/DmAueoJRWm9vLcig2OZ8Eh2Hr2KG8eBCCjFs+5nwq/iTeajfFDhLUS+N6JrYVSwzkLqilxT59pIeecaSw30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTXMmwgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D175C4CEC2;
	Tue,  3 Sep 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725327628;
	bh=fLY1zZHneHkscAokWVVEhoFYpulyXBBVEIROgVCIbrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tTXMmwgY5EaC4asHayQkTwE2bHEnAU2JLE1SF7ME08hMKfBqDIVr5CQGk1gnssWLn
	 1ZOQafCCB9icAHF07TRxKhUtKTV312zpR8xXuLWIY3uDXDOpDH5NlHMQcKKXJsKsaI
	 IALxS+/CilptWzvK91bMf1eNECmT6t8B4Jg1HC5RcWxm3cU3du5QhVQoSYUrSZG/V3
	 4En1l0Li8Lq4an+ZM6wY0TCDWV2+DWlm8pZRdaoQXFcJwZx5l9aQpgbN5AAHKCMdft
	 TGMQSMuE6dipEVTpqhHZhxQ7DHiV+lPpU7tC/xOJt+gCPKR639bckPz67bUj3qs+Ay
	 pAPQP35aV2Cbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6F3805D82;
	Tue,  3 Sep 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev-genl: Set extack and fix error on napi-get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172532762901.4027019.9275970527114180608.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 01:40:29 +0000
References: <20240831121707.17562-1-jdamato@fastly.com>
In-Reply-To: <20240831121707.17562-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, amritha.nambiar@intel.com,
 stable@kernel.org, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sridhar.samudrala@intel.com, sdf@fomichev.me,
 danielj@nvidia.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 31 Aug 2024 12:17:04 +0000 you wrote:
> In commit 27f91aaf49b3 ("netdev-genl: Add netlink framework functions
> for napi"), when an invalid NAPI ID is specified the return value
> -EINVAL is used and no extack is set.
> 
> Change the return value to -ENOENT and set the extack.
> 
> Before this commit:
> 
> [...]

Here is the summary with links:
  - [net] netdev-genl: Set extack and fix error on napi-get
    https://git.kernel.org/netdev/net-next/c/4e3a024b437e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



