Return-Path: <netdev+bounces-234219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3547C1DF34
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716A2189C072
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046621D5AA;
	Thu, 30 Oct 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8cNZ77W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546321CC59;
	Thu, 30 Oct 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785438; cv=none; b=eJjJojJ+kfzH2efnCWjCK5bZdCb9Wh6+8Mz03B0mVbvm0wF81L4NQAGIa/80v35JXFQxcZoNxhl9m/hfM+Iwq/OpoCb+1tHyKT1zFaQx1pDOWsngD3QgqNsIdfsBPkYO52J7Sh6CsDeqrhNw9Sbf2BgaY1HvT2HyiMZADxoMOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785438; c=relaxed/simple;
	bh=7xyDtXFYWXSrVN03wahi/wmzYK6WP0+VW95heOvG+38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xp5S6f5np8pNQcD0lsFYgRDNoORqCPhGVlE5DH4W34QHCAxJAss3I0ujuNuhUypAX8+1ki/IcDeC6JQxBK4h9pDGVQeB7n+3ijOxZEIER1Omi7Gd5ABSLReohyOzV6++KGjSA2bB5Jp/CuyIw0YP6Fb/MgGqkWcGrHWGkDY4ISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8cNZ77W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE0AC4CEF7;
	Thu, 30 Oct 2025 00:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761785438;
	bh=7xyDtXFYWXSrVN03wahi/wmzYK6WP0+VW95heOvG+38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a8cNZ77WjcVCKKbA6KOdX8mZrlghwHbJS22IaY3AiZY8PRnNmy1asQYpkKLrlS+n3
	 0VqJksgm5cEGGA5ulghYgasCC6x9OwAhA6Htlnl8+0DRWIig4VOB3aKqEaacaWb86M
	 jPFIvGUxDFyIOtaDHMeH+pXpQ0NSzV4cf6f4MttX9jpuyxbM4QoAwq3NU45YPIAk/v
	 Hf+qQNfK8eIkE2L053wEm2AlrEldLL7QwXJ96qkmYu9N9G+6P5AGAozTu2Dob6uBtc
	 lHHlyyizSHptdo+ngLVnYlFpAN+UB0JytCIiIeTYiugFM0/FcQRhP4Ner9RqYch/Nq
	 ZeNiDmbxG2Utw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB63A55EC7;
	Thu, 30 Oct 2025 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] netconsole: Fix race condition in between reader
 and writer of userdata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178541524.3267234.10609785417431668528.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:50:15 +0000
References: <20251028-netconsole-fix-race-v4-1-63560b0ae1a0@meta.com>
In-Reply-To: <20251028-netconsole-fix-race-v4-1-63560b0ae1a0@meta.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: asantostc@gmail.com, horms@kernel.org, leitao@debian.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, thepacketgeek@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 15:06:32 -0700 you wrote:
> The update_userdata() function constructs the complete userdata string
> in nt->extradata_complete and updates nt->userdata_length. This data
> is then read by write_msg() and write_ext_msg() when sending netconsole
> messages. However, update_userdata() was not holding target_list_lock
> during this process, allowing concurrent message transmission to read
> partially updated userdata.
> 
> [...]

Here is the summary with links:
  - [net,v4] netconsole: Fix race condition in between reader and writer of userdata
    https://git.kernel.org/netdev/net/c/00764aa5c9bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



