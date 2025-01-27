Return-Path: <netdev+bounces-161227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECEA20170
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07A1188686B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B571DE2DF;
	Mon, 27 Jan 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux4q+dSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96011DD539;
	Mon, 27 Jan 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019418; cv=none; b=u50CdV7vfCcPHtASERVfhJmWqtbcg9aGjj0xKt0NvIE9ws64CZxwWUKXEaBaYkmwDPQte5kuuGycfiuCUfw4m80qU7g70mmmNMCo4n2sRfSwietqT0GzPy/lrl5GJeg3pxDkzekAOnQGKQqz2tgB38U4/GiDpLbKM1fn/hnRhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019418; c=relaxed/simple;
	bh=NrtnSAjzxJEccIrHSzazpUs6t69g9DcO6QLLS95H0cc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B8EXsqNfVLeBv21bFHj9a/OGmOtQR2rspGK+OM6DX1TYeYhX5fhZKAT4vV/j9sOd+vXzPoAqYPNkZY7KuEP6gBdTeyvD/55mbXIizC1OLLtHfPBpQ88Mvckh3Y7E7B47Us+EM+S0Uy/yG4DeAadmnSYp/p5g6ileZxwSwmwcKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux4q+dSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167DBC4CEE0;
	Mon, 27 Jan 2025 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738019418;
	bh=NrtnSAjzxJEccIrHSzazpUs6t69g9DcO6QLLS95H0cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ux4q+dSQpkKUTSh9OnhuzcjxbhbU3gNh5Q0HxZ820WSHDvxzcpzdYSdsLAkKPeIIR
	 mjB8dvrYu5XPc7f1dz9dc+WvELP1gcZ9y0HfcfJE+jkfD/ueZ+ZUl9r4lhD4/5Z1B2
	 hSLEkokwYkVug3tjhB+AqiYkuUIq34bGMxn5nzKByD4wEDvJoNrjzaf5jfEn2leNA0
	 jqh6dUV6hMgvwSZgmKP9xFt8KI04X1inlw0oQK02ijFnXqEg/Aq+ea6gsOGn1eIyeC
	 +lGwt6ELcq1LmkOYkzFCTa3GyoDCJRP9iT+F9xmelz6rxvjC+gD0/EDhL26t/b5Ncn
	 NozgZTu+dusUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCA380AA63;
	Mon, 27 Jan 2025 23:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: davicom: fix UAF in dm9000_drv_remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801944349.3253418.2728026169564738945.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 23:10:43 +0000
References: <20250123214213.623518-1-chenyuan0y@gmail.com>
In-Reply-To: <20250123214213.623518-1-chenyuan0y@gmail.com>
To: yangchenyuan <chenyuan0y@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@baylibre.com,
 paul@crapouillou.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zijie98@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 15:42:13 -0600 you wrote:
> This bug is detected by our static analysis tool.
> 
> dm is netdev private data and it cannot be
> used after free_netdev() call. Using dm after free_netdev()
> can cause UAF bug. Fix it by moving free_netdev() at the end of the
> function.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: davicom: fix UAF in dm9000_drv_remove
    https://git.kernel.org/netdev/net/c/19e65c45a150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



