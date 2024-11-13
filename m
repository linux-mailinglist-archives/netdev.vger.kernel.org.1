Return-Path: <netdev+bounces-144303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE49C684E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B871F23B7E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4A1632D7;
	Wed, 13 Nov 2024 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htvT6YRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31432433CE
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474020; cv=none; b=g6Eo+X8IgxMStGPeRFT8ppvTsoma30ceFAQR+t4NCKF3m74lNROrliHytuAJLM44+Uk76hTHU5gioFOPXMdMwUW0wJmzl/tWaDgssGSnMdg7dnn2Wz/LfyyeYLRCmJk5yOalBxM4JrAF5q72WyxS0WZYhmG92ONGRRs/7Dv98pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474020; c=relaxed/simple;
	bh=0GeoO2s8oGQO2m+344Gc7oklj7VxJ7fZKUC0b9gHAsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gbjOJa7UiwPTPvzhj/yQyjhDNlUlCa/kcVzSwN6zJiHjUX0CXuFjFqzuFQ5gCJRMJhooaz2NIvqgX7xbz28r5pJA41+Ov4BbJRJD8nTOgqDHmm+dVkSMRO/mLR+K/A3yrEFIkYU/1RdjB87wNhBAVjaXj3MtVgHWf53crVSA0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htvT6YRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8117C4CECD;
	Wed, 13 Nov 2024 05:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731474019;
	bh=0GeoO2s8oGQO2m+344Gc7oklj7VxJ7fZKUC0b9gHAsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=htvT6YRF+DTa/cneV95tR1OZgKzkdaPiHUFSwRlnqUDO01m9BDG97ZKrCzAUIvOpv
	 EfahREElkRHpXI5h+OK2co6fMNUkgmoJ0XVVf+pTv6OEqdCmSOKFZNrTY+O/tQoDuh
	 NoFoKsw5jm5eTDj7wTnaQU5TcuwAkQjr7cUQsxcEPYAQTo2NEZbaKmpui6ADuQ7c1W
	 PCGmUoMCm5sq+uE9GP3RWBgEuOYHrQaBmIx0ZAHQWLrM9e7saAG66V/+23mWMh20Hr
	 t2LIaX6dK/BYaLxwmk5ouq01KJh4N6bWYDV/DYXCPKvM+t6vKoolEjIEbgJIAdPG5e
	 2vY1yfxIld01w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1B3809A80;
	Wed, 13 Nov 2024 05:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7] net: sched: cls_u32: Fix u32's systematic failure to
 free IDR entries for hnodes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 05:00:30 +0000
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, horms@kernel.org, alexandre.ferrieux@orange.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Nov 2024 18:28:36 +0100 you wrote:
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
> 
> [...]

Here is the summary with links:
  - [net,v7] net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
    https://git.kernel.org/netdev/net/c/73af53d82076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



