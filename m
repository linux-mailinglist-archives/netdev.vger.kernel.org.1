Return-Path: <netdev+bounces-125283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2E96CA14
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BFEB20A67
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C9153812;
	Wed,  4 Sep 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuPw7aTW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65482863
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487831; cv=none; b=dOij5ZhsMWGT8MY+o3I+o3dL87aurgyYLcQZXQqNoCo/TaLTK2CP8TBk9F2yH9C4nwCxfIYC8qT5Q5vo0fGKetugcLfXm103CNYZos+MwOqLcWjA1821uMx0j8KwVn6FLx4uNZFRRKWsIwF2cXlG/SF/pZfsxEQsUbRLOrbQtJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487831; c=relaxed/simple;
	bh=698hKg7swKCSxS39UbhP04If908T+NX+B6hKaamwBXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0dyl8969NzfPaVUIdLWPSYEl0/5ptk4vo1UORs8GQ8YUrEo6IWowat7vzLYSTp+e87kVLLDBcMBpOLnoMQWBzOMgin7mTX4GJ0ibci5dj3mNWafmCsxWd/AhMtg9I2TOm9TwtU2oHjPPZr8hOCx+cq+sLZaGtj8NJTh9S6W20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuPw7aTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13D3C4CEC2;
	Wed,  4 Sep 2024 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725487830;
	bh=698hKg7swKCSxS39UbhP04If908T+NX+B6hKaamwBXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MuPw7aTWnlnfxH5HELNa74UeRazXoAAXaIqRajOavGFFzBbyiN2DULSj+ToXOE8wf
	 uOKVUUL4Cz+kv7cHltXTQqeZW5y1Zot3EK5W1O1NZei3Ljv9knfSyP0ArQlmHMbCKq
	 dlrUBy2LZ3mbqDvdIPROE74DiVV15IP2Td7y24lDeoYId1vo7PaSNB8GpXs89pAKJg
	 gqRS2CZUV4goHwq4Au20+CpTVrh+o10DFgpOljimykFA81PN9vfLMUVCq4iDqzFcqi
	 21e8w4iL+1lc0UoFEBR9OtFKnZScPnJzoYLjpGpGZiJfR0oObOqnX7GLtP93EXeqcB
	 vnp3/kpSRInaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0583822D30;
	Wed,  4 Sep 2024 22:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172548783077.1182949.4091771088430315105.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 22:10:30 +0000
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
In-Reply-To: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, martin.varghese@nokia.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Aug 2024 17:31:07 +0200 you wrote:
> Bareudp devices update their stats concurrently.
> Therefore they need proper atomic increments.
> 
> Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  drivers/net/bareudp.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net] bareudp: Fix device stats updates.
    https://git.kernel.org/netdev/net/c/4963d2343af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



