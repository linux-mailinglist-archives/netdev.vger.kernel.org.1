Return-Path: <netdev+bounces-131819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8EF98FA5F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEF8B217E6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D121D0438;
	Thu,  3 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPfjqUV/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714321CB330
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997632; cv=none; b=KeoyQB19NMJR3dFi1QyLPqv1cI9k8RFhlegr6wld+nyOPuKxYgs+B87DR+I91Syif/7CARjRk5kQBVgeLhlkVLKWYwCCbptNFvUnaC4e0CixYSWXZuKDfn2XAOIKLJhnDhmNhdkfcMLlmZng7ev5zehHZN5ih/BcR7s93zxIbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997632; c=relaxed/simple;
	bh=EiRYavCn30w3un30lkc0OamwToYc+bD5mPY0j3M9tSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HWCaCy8ImJu/upL94rHs4V/LM0pJjZYHkisTDVpydnU9ZOG6Cd/AJE0r4/fwMa7NGImz41+bzt81BpfJgbFL+jWVrRk99wioao3UACrNZEA0LsSffFRdngzGlnT66+j5/yhfvECx7/msykRtu+gs/uzlE93u2UkfkUTMJ7xK2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPfjqUV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1048AC4CECC;
	Thu,  3 Oct 2024 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727997632;
	bh=EiRYavCn30w3un30lkc0OamwToYc+bD5mPY0j3M9tSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IPfjqUV/tAW1r4/cuwU+LusRzQhSsBFpubW84jJFWf4SN+qqmnXSepxGVnneAtEoG
	 oQeJMR/mAkuQZWJ560j6UpmRHQq5mfH1tmht7MzXPKk93Nl8xle4SH3sd9fywmQoP0
	 BOITbY/ebU854wxVVvL7XUuF7wrV9zpAdqpTShxARvYmuqaPFTuKx+0jRvUTer1Ge4
	 nq4VRbw3PuZqTrX6DPkDzD0QvhZNFXqeKGA5Hkkc9W72d1FMOzLMe7cnDgZYwZ/kUd
	 2tQzQsMxfUe5C5RxlPHDzDPKrCddEiK2mQHo8Hmb5n95qEsRpnrUw5EtKg2f5BpZEe
	 A02QguAYc6Nrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3C53803263;
	Thu,  3 Oct 2024 23:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv4: avoid quadratic behavior in FIB insertion
 of common address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799763549.2024724.8780437992184484954.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:20:35 +0000
References: <20241001231438.3855035-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241001231438.3855035-1-alexandre.ferrieux@orange.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, alexandre.ferrieux@orange.com,
 nicolas.dichtel@6wind.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 01:14:38 +0200 you wrote:
> Mix netns into all IPv4 FIB hashes to avoid massive collision when
> inserting the same address in many netns.
> 
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---
>  net/ipv4/fib_semantics.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next,v2] ipv4: avoid quadratic behavior in FIB insertion of common address
    https://git.kernel.org/netdev/net-next/c/9b8ca04854fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



