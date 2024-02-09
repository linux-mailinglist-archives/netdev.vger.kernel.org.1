Return-Path: <netdev+bounces-70429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5A884EF5B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B5B1F21540
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880CC4A39;
	Fri,  9 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI9PdBA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7F4C7D
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448828; cv=none; b=mRxvylffGFt6cEBrAPlPvvRIGj89jRT/+nXUC7Uv2QTWuyiV/258U7UiUM3q7xA+AnAlzpKdbRizCQ0I/iodfx8yzmnA42ELYyjomv9nly8QN9iAAmmpR35XWyz0ps35zZDgs8aeyxbYVEvpCQOyBZlR4FKsv93QEol7wGFgg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448828; c=relaxed/simple;
	bh=yEqvWvHOq972ux9JztuYexzmQQ9YCpAVvoA96ogj04s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VZM+y+IB+H3X8DUivTgLU27/+4j3rtNJECSB6qX7S1CvqBOsQhI920hOi1PWxKPLPuUhtBlryslclE9LkFgMiStGgda52dYdtlwsbKwpCFKDB2/RhJJeq/Dj0Ck+iaTbYMXByKXFlds7YMFtsuylo4dacNMYM1ROpeB56a1z/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI9PdBA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9501C43390;
	Fri,  9 Feb 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448827;
	bh=yEqvWvHOq972ux9JztuYexzmQQ9YCpAVvoA96ogj04s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jI9PdBA81mEWtkIS/A3xIjrfVgbu+PRJ2pWAjojjmmTeNiBxplVgzWSvSJxtBjj4a
	 s7ABwDwMWW8p5ONW8oLxhoBhrXE5Jl9Aw78L7eWpp17kGhmDxz/XTfZvphe6JNGM94
	 7kekb5UzuKghZr9Ra69NTkRLsZIsejrNMsl2yTEsbhBU2rPKGuQQFJ4Flae9S9ojug
	 CxvxvRUb5Vy8KB3RgfBfl11eYDHzxGrgWuezO3DeQ2Fr+MYuEoymYcVdnGuqMadq71
	 Xq4FM6yQHD1Wt560Jcr4uS29hlSji00QFwJm6kKDPF7M7tcVIQ5yYsi5DDba+tOd5O
	 DmDfsWwBbru8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEABFE2F311;
	Fri,  9 Feb 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: do not use rtnl in ethnl_default_dumpit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744882777.28492.9941915560632520807.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:20:27 +0000
References: <20240207153514.3640952-1-edumazet@google.com>
In-Reply-To: <20240207153514.3640952-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 15:35:14 +0000 you wrote:
> for_each_netdev_dump() can be used with RCU protection,
> no need for rtnl if we are going to use dev_hold()/dev_put().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ethtool/netlink.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] ethtool: do not use rtnl in ethnl_default_dumpit()
    https://git.kernel.org/netdev/net-next/c/e7689879d14e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



