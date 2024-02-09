Return-Path: <netdev+bounces-70410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BE84EEEA
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E3028BFF9
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CC37B;
	Fri,  9 Feb 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTCYXgkd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C217F8
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446427; cv=none; b=rnj9Isnx87qta2XcdA6cmhxMzussVAzbxZwa8asUfLEDFpbY//ZuArtF2ORF+47Vg5FDHA9wqCpOc/RPmwX44uCK/0MIdq0TySfglT+4PYfVN5Yx/2IWlYCBVMK3kc8c3cozzs2OagsITicnFfbh5Os6a2/sHLJz/H7iJp/GvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446427; c=relaxed/simple;
	bh=Czb2gDQN0ZYGw6CZX0LMcjTkbnAOAFxzMs7t6h+hDkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZTMaCtpcSwxLFoRBL9mprK5GFKuGBC9/CryjZmKd1I9XvRNIkHNI+RpccHomBMJDFg3nTZLfhsj6gXhEeiT1KqwZ/TO17zFRhAwbtodHXS/tB4ApUNW81Qx9sqSutKTynb/BA8347MwCZ+M1FplkCStC8DgSOzZSDjTsezu6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTCYXgkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7D2BC43390;
	Fri,  9 Feb 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707446426;
	bh=Czb2gDQN0ZYGw6CZX0LMcjTkbnAOAFxzMs7t6h+hDkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GTCYXgkdwqWrhPqTc7UTmbRgGbz4JJJZqvw2ENa2rjVCrthxZJUzUw9UD4ZtCR1I4
	 ANXI+u4fwkTbx7PmsLeCIIvkb1h2a/zLbAm/TeQQ0nQiXxdEyqcbV7zCFGMvrnxX0I
	 9gIxSJIJ3UycpDYnAOl1smbgHfQBs5Ygwp1P+MLXtWEyH96gkVWnG6T2HGCLU2cxCb
	 0bVy5QyzyvTFoDRKoAVBH+ecwQZMmgogAoHQVP1asRWmitcnX3W6VAnpfI4JE6eSZr
	 QeX/DxCfYqEFIx2+I3pjmhdZiuzhZFGWRNRBb6Gv09+9XaU0Xgz0mBRTD6rMacMmjk
	 +k/5hQL4gXuWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3AD3E2F311;
	Fri,  9 Feb 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net v2] dpll: fix possible deadlock during netlink dump
 operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744642666.9225.16381035156348426464.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 02:40:26 +0000
References: <20240207115902.371649-1-jiri@resnulli.us>
In-Reply-To: <20240207115902.371649-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 12:59:02 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Recently, I've been hitting following deadlock warning during dpll pin
> dump:
> 
> [52804.637962] ======================================================
> [52804.638536] WARNING: possible circular locking dependency detected
> [52804.639111] 6.8.0-rc2jiri+ #1 Not tainted
> [52804.639529] ------------------------------------------------------
> [52804.640104] python3/2984 is trying to acquire lock:
> [52804.640581] ffff88810e642678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: netlink_dump+0xb3/0x780
> [52804.641417]
>                but task is already holding lock:
> [52804.642010] ffffffff83bde4c8 (dpll_lock){+.+.}-{3:3}, at: dpll_lock_dumpit+0x13/0x20
> [52804.642747]
>                which lock already depends on the new lock.
> 
> [...]

Here is the summary with links:
  - [net,v2] dpll: fix possible deadlock during netlink dump operation
    https://git.kernel.org/netdev/net/c/53c0441dd2c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



