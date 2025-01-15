Return-Path: <netdev+bounces-158351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABDA11776
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127B4167592
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F81E32BF;
	Wed, 15 Jan 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtIAtuDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBFE13AC1;
	Wed, 15 Jan 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909407; cv=none; b=Vg1dLKtD87ZUbZxDKiCrDVkltrcYwNdiETvw5KpTgA2iwfruVZQgRWGak/mk6i0oj7fK2wTjJI8KkHUI+qQJqgvl+jhXfe4pQaaTsp/bSPucqI/G4Mx50iLBB8mo/3JE3C8kJkqEAN+Af3uictxDFkuic2USrEE03lZDjvmCnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909407; c=relaxed/simple;
	bh=5vRjQ0Ak6VS4Bjx+qWcc5Jj1D3n45Hd5LDHX8d9QKn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VeI+T2/IA3YGUCuMMQbn3ZSHVx68aTBeqv546E+iHRWBMlMjuJvzfgTftoMwRv1rBBHKA6cOoPNtCUmPqs1iFI6jwj2KRtST7P8mYuBLYeQjt0bsI27kkP/AhI6dGAxt9CwY7OwgzUQWyyUkj11JrN/ryxWX3gjoKT0W+zmazQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtIAtuDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F77C4CEDD;
	Wed, 15 Jan 2025 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736909407;
	bh=5vRjQ0Ak6VS4Bjx+qWcc5Jj1D3n45Hd5LDHX8d9QKn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XtIAtuDPC8ZoAKXRSvQZPgrINdu6+yLfXeaxx4hkNSytMzWdJUl5+OUuxxUqWFSvl
	 6w6q5+Eyn61VkcEImP2yFp0RIszDU3Rw+CcXlHgKi2M6ivUEiCuKfRll1MkRyf325U
	 ANt/xD0v5GPtuSI2pwYbPnfv2gLrscp0izMghGiLxtmQ9kApe0riBH5JhXjI1lVFts
	 0o7lbAhgcOCBEhyq1SElfozY42oTWS55sXz5aww/VBmYQL3mS+aA1mit5FkA++zbg0
	 1qcNBcbEZwGaILamacTtei7hjoOlkfwznQsi/GEOt9mOgP6kPkoMMnXj2U1wMCgOSz
	 e44EVgZMe+zCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 356FD380AA5F;
	Wed, 15 Jan 2025 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net: fec: handle page_pool_dev_alloc_pages error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690943001.230797.14718449559307154902.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 02:50:30 +0000
References: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
In-Reply-To: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
To: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 10:48:45 -0500 you wrote:
> The fec_enet_update_cbd function calls page_pool_dev_alloc_pages but did
> not handle the case when it returned NULL. There was a WARN_ON(!new_page)
> but it would still proceed to use the NULL pointer and then crash.
> 
> This case does seem somewhat rare but when the system is under memory
> pressure it can happen. One case where I can duplicate this with some
> frequency is when writing over a smbd share to a SATA HDD attached to an
> imx6q.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net: fec: handle page_pool_dev_alloc_pages error
    https://git.kernel.org/netdev/net/c/001ba0902046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



