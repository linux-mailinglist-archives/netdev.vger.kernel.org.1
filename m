Return-Path: <netdev+bounces-228006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4ABBEF85
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 345804F2E54
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3D2DECDD;
	Mon,  6 Oct 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK2paM9P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47172D94A6
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775426; cv=none; b=k6GfE0FM/Hy++7TJP0x05/B3hIFg1jzQkf+lqkmdyGPPzoQWlSSBc+mPXWh9Hj0UcXwMiwuZUPtL4WIqel3fei90JggqwW4xGoDq9Pw0bsAr6ub9FDy8dxhMZ0ha9akh/xvIJVNI7k4GR0O3LbwcNPdVeYxTWXD+RQn18mRcUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775426; c=relaxed/simple;
	bh=17UqxpsqeCwp8Rab8mSc4j5DTlk2xzws/gnwEJ52Xfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fEbKr4nmwu3Jg+T+TGZT0D2tklxJohpRcCgGbj9rwscztRDEyXPNvNgNdHE8mPyaaL3h62ietawOiN9JlGaeKYdlVpD4RQvsZUHlfWpeJ3yMTWUYDT7g00f/oejR2NsI3xgq34CB3va0TKJdAsop5QZilf8tRm+ZGLeO2zDamUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK2paM9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D87EC4CEFE;
	Mon,  6 Oct 2025 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775425;
	bh=17UqxpsqeCwp8Rab8mSc4j5DTlk2xzws/gnwEJ52Xfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OK2paM9PkIF0YYNU2ZTPznVNLucB13lb50Gu0cFNxIUjTn7epTbwkK9yQdKXmWYtm
	 54nyKDp3rkqFCqA3FkdZZZrUOKaTHsVTg2tnOaEJn+XVt1yVGVf6luCHt/n189EJyD
	 GwFu33YyQ3rKzQ+Ot8Cm3iEMZzRpqo1QHMmytqpa5+qNqOWPvI/Lcl+JD4DcnnDIIZ
	 dfTxnVFpTLawtw4wWV/awr9GKfxANHC08mwQDZp3MP8Agj7mE7h3SmaeD0TQWh48KA
	 N6zt7NssWWuq/ln/H2/1IdPJ5LDyIyvt7C8OygTBkUn5qqbwPmWUH7C2XeH83/y34o
	 DpUcHIYTaXYOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8039D0C1A;
	Mon,  6 Oct 2025 18:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Don't call reqsk_fastopen_remove() in
 tcp_conn_request().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977541474.1511446.13505792083816767366.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:30:14 +0000
References: <20251001233755.1340927-1-kuniyu@google.com>
In-Reply-To: <20251001233755.1340927-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Oct 2025 23:37:54 +0000 you wrote:
> syzbot reported the splat below in tcp_conn_request(). [0]
> 
> If a listener is close()d while a TFO socket is being processed in
> tcp_conn_request(), inet_csk_reqsk_queue_add() does not set reqsk->sk
> and calls inet_child_forget(), which calls tcp_disconnect() for the
> TFO socket.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().
    https://git.kernel.org/netdev/net/c/2e7cbbbe3d61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



