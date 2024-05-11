Return-Path: <netdev+bounces-95657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00748C2F06
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C12C283463
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92223769;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF+XTHGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65186224EF;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394634; cv=none; b=Soksq63J1cQuzsqcxfXgo5mgAHeIzGDwlyiMdel6cAtz+v36Hk747xyZ8097LxMKCLQ5adDTYC2FwqLvJSH6Ixh0ts7WCMdNX6AKwU1+AUldCiqmiSC0BxDsz1NnyQCl63e9QqwSboqA0jLlMZORaMayH57T6/5e9Mw+YORSk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394634; c=relaxed/simple;
	bh=HD+5smsK01v6C9DhD/j1qHOMHvdo2Dn80RrIU6w0X6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UG+GDNSxyVU6ai0BKnXOQyE0DOOh6HOkes05xyEU4loY7hNpXr+6atLgG6sDd7pWzDdcqIDYc5CMyIACDwpyYjYqL1+aYvkSE+UFsSYyYjQALGOloDLZlrc5LcOEAO13F01YbPvHP+ZSghoeNz1PFdKjxv7z9WhiVN1Y3//wADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF+XTHGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 093E2C32783;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394634;
	bh=HD+5smsK01v6C9DhD/j1qHOMHvdo2Dn80RrIU6w0X6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FF+XTHGgd7vLcId9kzVSUpOWDI+XOfvwmcKlR5rAXXXjGAfe48hprh2QVigS49J7e
	 syosgXigvkaBJboOFnNIlLIpTXftL7Zx7iJXdpXcwxrY7kczAo1XtznuyZ+R+mmTFa
	 1Li9vXz45hAKLvM+gsdBJx2PY5v2X/Ds9EY/aBFI//AoBT8YiD7suMaesxAK+CdGFo
	 f4EIXN6l68kHsk8L5JKesdplTa538dYzeBTDVKTJXyYtmpM93wWECvuYJ8uJuO8SlJ
	 zQTpKQ8EHeDLio2VgkJFZWtRal1vtZmigBX5oOTqYKnPW5mhI10s6iHjDXvkaIsbwb
	 WOSugWJuiVJdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECA07C54BA3;
	Sat, 11 May 2024 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] af_unix: Fix data races in
 unix_release_sock/unix_stream_sendmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539463396.29955.9318182800976964824.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:30:33 +0000
References: <20240509081459.2807828-1-leitao@debian.org>
In-Reply-To: <20240509081459.2807828-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 paulmck@kernel.org, dhowells@redhat.com, alexander@mihalicyn.com,
 john.fastabend@gmail.com, daan.j.demeyer@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 01:14:46 -0700 you wrote:
> A data-race condition has been identified in af_unix. In one data path,
> the write function unix_release_sock() atomically writes to
> sk->sk_shutdown using WRITE_ONCE. However, on the reader side,
> unix_stream_sendmsg() does not read it atomically. Consequently, this
> issue is causing the following KCSAN splat to occur:
> 
> 	BUG: KCSAN: data-race in unix_release_sock / unix_stream_sendmsg
> 
> [...]

Here is the summary with links:
  - [net,v2] af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg
    https://git.kernel.org/netdev/net/c/540bf24fba16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



