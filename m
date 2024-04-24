Return-Path: <netdev+bounces-90743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5128AFE48
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C081C21FF1
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667212E78;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsXLXw0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72107C13D
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925228; cv=none; b=BtdwMgAPPT9dICm4gtITBf2MQtIZ26IaPLR8q8Fb3S/DlrhLX1q5VaYca95gCbGXnOosfb1Gb1tmOyoF6walDJn5Sc96Jy0p/iGbZzTfH3wM9yT2Fg1k5Pjl3WkuOd+xETE8NRmWURAQxHBq9PQkYCfjCaYJwyWdeGCmN1gOGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925228; c=relaxed/simple;
	bh=EkvIIGNfoyZ46YWuoThwyobFWbYwlsmwUA+R7NAG3xE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=evT2tKLSecnbup334NIf3ySYM1dw2NqTT822fgIEhFiqEpItSyB9X0sonXiZTCMYRl7JBMggF2CKbin7FyPzl614aZ4vfY5EQEwfF+sypuX0bhmP9zLAw3DT8SePlJnNUpwo0GR0FYRYS2XCchk9Ny8+wOTRMNuUWPP5g9td3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsXLXw0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B3F3C32781;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713925228;
	bh=EkvIIGNfoyZ46YWuoThwyobFWbYwlsmwUA+R7NAG3xE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KsXLXw0V0XUmgW4BEVcgMsZADTXguy71Ue911uyot/oIQ3ewW2vFsKcGSf1PAgbcC
	 ZRAbj/zamZbIYHFwakpo6Tc5mpw0HB3kScQo6TLG+cKtV751HPy1Vgs3Zrh1Oc0tf1
	 j640oLiNBeBWCsxDho8dmNWctpfp2KvLWECaYpgMPoU48PMOtOxz6i8GGDNGyTsUym
	 SGYTKlv1/IPVuQ+tUfUdcRu1yp1atByRqouTdfooiVX9JVkcwepkZ7op2XZl/AaQyj
	 w2n02MtndiQsaVg9XfrbcA5/r31fp9Llaj4ThuokbMgs2knsCxwRMa0JSVB9cwf6Ir
	 Uo+/5BawX9GMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12209C43140;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix sk_memory_allocated_{add|sub} vs softirqs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171392522807.21916.18094372722686134679.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 02:20:28 +0000
References: <20240421175248.1692552-1-edumazet@google.com>
In-Reply-To: <20240421175248.1692552-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, willemb@google.com, ncardwell@google.com,
 eric.dumazet@gmail.com, jonathan.heathcote@bbc.co.uk, soheil@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Apr 2024 17:52:48 +0000 you wrote:
> Jonathan Heathcote reported a regression caused by blamed commit
> on aarch64 architecture.
> 
> x86 happens to have irq-safe __this_cpu_add_return()
> and __this_cpu_sub(), but this is not generic.
> 
> I think my confusion came from "struct sock" argument,
> because these helpers are called with a locked socket.
> But the memory accounting is per-proto (and per-cpu after
> the blamed commit). We might cleanup these helpers later
> to directly accept a "struct proto *proto" argument.
> 
> [...]

Here is the summary with links:
  - [net] net: fix sk_memory_allocated_{add|sub} vs softirqs
    https://git.kernel.org/netdev/net/c/3584718cf2ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



