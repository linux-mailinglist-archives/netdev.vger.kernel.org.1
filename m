Return-Path: <netdev+bounces-40914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43857C91C0
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF231C20BB4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9036B;
	Sat, 14 Oct 2023 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY68IhxN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2357E;
	Sat, 14 Oct 2023 00:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E68AC433C9;
	Sat, 14 Oct 2023 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697242825;
	bh=cfRnollf93GlHOWzLc4/JD5iRWpUYQRm38D3NguFwmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PY68IhxNr7JF9rn7y9V501IfKAKXIjMdOPJfj2HJNewGGSYvH7XQuQue3s+tAYjFM
	 Hn9gFyfY7C5XpM7Xl6l4RDGT8atOIIUU+Xqj+qC5NNeDVEjLRu5+k8UL7dOmuWwrB+
	 +EO9JSbMQbIGGrI49j/Bleq4gFB8Pm7bBnl/2usFfI6XJTUAdQ1KeoTbwYpC1qhBrB
	 AxMS1ZmFF/naDs3iEynF6zeYHuFIlFyDd/ic5+dk8QeJbmULv1TDvNCVaT9RkUiPN0
	 2riEIhWvyCvkdkCEuOUO0djfhm1qrNgPO2VRuAqH1K38w7Abjg+qttkt9U9LqCHPY0
	 DAEwcopkkzAMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA824E1F666;
	Sat, 14 Oct 2023 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724282495.20328.14649814507738116651.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:20:24 +0000
References: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: louis.peens@corigine.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 21:48:39 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect res->name to be NUL-terminated based on its usage with format
> strings:
> |       dev_err(cpp->dev.parent, "Dangling area: %d:%d:%d:0x%0llx-0x%0llx%s%s\n",
> |               NFP_CPP_ID_TARGET_of(res->cpp_id),
> |               NFP_CPP_ID_ACTION_of(res->cpp_id),
> |               NFP_CPP_ID_TOKEN_of(res->cpp_id),
> |               res->start, res->end,
> |               res->name ? " " : "",
> |               res->name ? res->name : "");
> ... and with strcmp()
> |       if (!strcmp(res->name, NFP_RESOURCE_TBL_NAME)) {
> 
> [...]

Here is the summary with links:
  - nfp: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/d273e99b5623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



