Return-Path: <netdev+bounces-210905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF0B155FD
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962A3171992
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7B27A130;
	Tue, 29 Jul 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoKoSOF5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4B21D001
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831793; cv=none; b=fcYxLS8awUwGizAgyLskbDZdARfuhDGaCTYTmsqznO5LMrVFCXKPC9R31QpPlKEvDSzvKh+In0Wj481S2NOseXYCIUqGx31t+Iaame7AXr9CJISGX7RNLVpvI8edzQnh0sV8lqbzTIW9Jf86uYjvewW4rE3++THloPVlKk7uUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831793; c=relaxed/simple;
	bh=UaT2FKap/VRB4mwyIScTDAZHVsq3GhMugEgAzTSjszk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qgpVYFj4+dZDpyJwUyB5bn1lZ2NaSWCdVcHnGXNKhpqKlex68xAk4cRooW149MpC7OCYrs5VflnKXPkxvbqGYJiNqijOeQYSmSseqCw1aZBZdgwq/i1HibWc2BLvYmyX9L4i7Cjb94q3wwAwCMRkuzBYKlFEV0+I+1KbHQfOGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoKoSOF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1518C4CEEF;
	Tue, 29 Jul 2025 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831792;
	bh=UaT2FKap/VRB4mwyIScTDAZHVsq3GhMugEgAzTSjszk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoKoSOF5cdeLVqOK/jXffzTde6YEP74+R+lpYzVSIkwv9m+QNe7NrW2Qt8YztKhRK
	 35ZwIea+JNdVOWCKP8TqjMIEFp8pSfYMpnpUKq6EaKIS19XISuIuzZyyyaKXBbttGc
	 3OZEtsNGQjqrejdGkptDZTndRHaH0i3pZNd3L6lfeYOLMpWkYn7zmTgMbru2n38OH5
	 ii3Svb/wEkhWvcGcTUaqWWPw24TvFEuiKqXRxEuNwOo+sIlPA9gQBungspMAs77FrL
	 cSSKEVFDskSuY5mTnnQh8C4aziRDBGpqkY17Qgo8o7hRadaKgarhg6Dl/q//2UCXIC
	 2w+QagjLT5qAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BB9383BF5F;
	Tue, 29 Jul 2025 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 iproute2-next] misc: fix memory leak in ifstat.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175383180900.1684209.15145851286092023895.git-patchwork-notify@kernel.org>
Date: Tue, 29 Jul 2025 23:30:09 +0000
References: <20250719104212.34058-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250719104212.34058-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 19 Jul 2025 13:42:12 +0300 you wrote:
> A memory leak was detected by the static analyzer SVACE in the function
> get_nlmsg_extended(). The issue occurred when parsing extended interface
> statistics failed due to a missing nested attribute. In this case,
> memory allocated for 'n->name' via strdup() was not freed before returning,
> resulting in a leak.
> 
> The fix adds an explicit 'free(n->name)' call before freeing the containing
> structure in the error path.
> 
> [...]

Here is the summary with links:
  - [V2,iproute2-next] misc: fix memory leak in ifstat.c
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0b09a1b053a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



