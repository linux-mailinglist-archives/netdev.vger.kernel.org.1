Return-Path: <netdev+bounces-120771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616695A901
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C761F247D9
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE706FB6;
	Thu, 22 Aug 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJOYzkF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EA125DE;
	Thu, 22 Aug 2024 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287240; cv=none; b=md6kNCpjOuIhIC+R5xIl4477YGSZxAXRn67wET9af7Dc7bJt89OfSyDJvhgQbKOmsPe5VfB0duyVN72K63BzK85dDsn5fNap4OvYxdbxOgvx8JrLSeKn0pxTrzOuUI2/FyD0HFBqlp2vBHjyp/z9RbHFT2j0cGRAh+IJU9/MpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287240; c=relaxed/simple;
	bh=b7nUoUlvVoGjFMH8+Uiil1I9wpRRS3dQOPm1lZtrews=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KwJ2n7XVMhaW4IrScwaqdKqenBLGNqwNcKJyhA54nyxv4z7/K7L1rZrrTYsBVg28CR+FhbGx9KCwKpo41uMERxWVh/QqnJU7urCU3D475rtFGD3RSJlcjSAQisZYGQa2fCJLKT+7ZmWhynhbhgN3r07P9rqtsyg95tAy8Gfuih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJOYzkF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F6C32782;
	Thu, 22 Aug 2024 00:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724287239;
	bh=b7nUoUlvVoGjFMH8+Uiil1I9wpRRS3dQOPm1lZtrews=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fJOYzkF6UhEYzPqWyAMtc92qi8xEjU+8pzsZ23VfzMA/zIxAoErM7QgGS4NJYBAVZ
	 FrTOmW4cwabqjemEQ4UtlrF3pPG7oT/FqYqkDBefRkatByooVhl5ZAtkKkLgAEGL30
	 sfDvpE5qlr1G2IQ6k/b80G3Ekyse523RHmjo2yH0VxiDEpNF8kvLX3k42qXlq//F3y
	 yisPzPfFr6/+wklKW8RddBw9+EHVj2q9bauyJYV4DgqmtWdcvkU3J8a4p/tmG0CSwd
	 zW/K9etD5ud9+66uYd2SmH2CM7QOzQj0Q60SbwuYJQ/GMk9JGQkx2lKhVZJxsZuGzS
	 RbxysRyc2RoBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E303804CAB;
	Thu, 22 Aug 2024 00:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ice: Fix a 32bit bug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428723899.1872412.15704401811722513523.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:40:38 +0000
References: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
In-Reply-To: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: junfeng.guo@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, qi.z.zhang@intel.com,
 marcin.szycik@linux.intel.com, ahmed.zaki@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 16:43:46 +0300 you wrote:
> BIT() is unsigned long but ->pu.flg_msk and ->pu.flg_val are u64 type.
> On 32 bit systems, unsigned long is a u32 and the mismatch between u32
> and u64 will break things for the high 32 bits.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] ice: Fix a 32bit bug
    https://git.kernel.org/netdev/net-next/c/0ce054f2b891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



