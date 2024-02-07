Return-Path: <netdev+bounces-69686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496584C2E2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A19285E0E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1DF9D6;
	Wed,  7 Feb 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCjfWTSm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7BF4E2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274829; cv=none; b=lrbVE0G/RF15TobrULRnT7o6VYWRD4Nwsoc6Hp6t0NUo1ZtUr/1qFN+Xcc8jNaccHU/3bDNPokMz1sNIoJukMir5BB4xpIrm3lv6hZ5DC5WoGdSYMZWBib3MqM8pNQIviMzAyC3HvJltqp3uBpZc3mI1ovjcnpb4/K+M3ME1ikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274829; c=relaxed/simple;
	bh=Vu48buhJ/uu9bTsKmOeWN4pvo6pDNBdyks5KwttrnGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ACpPbGZTFq2cC15nGen53nd8BfNBih9PJ7/B9jfQkWgL8f94WIVnW640oX9cZRJt1tZU7Dqs9TlA4FjvaybdvoZzdVLYMxXoATRm3lqghiWJ6R5v54WAHUb27nfZOu935HKdEg3Hhu+hIAI1IIKUv1eD83iP5jSy8FqEyx7C72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCjfWTSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C858FC43390;
	Wed,  7 Feb 2024 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707274828;
	bh=Vu48buhJ/uu9bTsKmOeWN4pvo6pDNBdyks5KwttrnGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCjfWTSmUA3Z5IPDdNB5D4A8QtqgBmu2cn1AXZiXkfr3V5nnn71f7Nb7C6QcvRO2t
	 g94RwPWBP33Qbj8QAvh7pIHwGflS/Q03nix2ZHdjnmd2Vja51OtMeSOX+FZ6suZQ0/
	 r7mczWFoHu4U89E8bjSEu8Sdd9JZyh5JjqrMiVJ6hcnkMR7dwU17MQfmKzokiQcSrU
	 iXnZhg390Nis8tJ83L+0es4/YZiH0W0Na+zu5P6NFNazrhs92Bzdip1fVGiiAV9apa
	 aGK3UGCnqMO/DFrvHNrOciuqPAUJw2mYCpS04X/4z6mr9v6L0yD7fbT2gauSKPSW40
	 XF6v/zDpfeQTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEF11D8C97E;
	Wed,  7 Feb 2024 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] devlink: avoid potential loop in
 devlink_rel_nested_in_notify_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727482870.2210.16189297380885540820.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 03:00:28 +0000
References: <20240205171114.338679-1-jiri@resnulli.us>
In-Reply-To: <20240205171114.338679-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 18:11:14 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In case devlink_rel_nested_in_notify_work() can not take the devlink
> lock mutex. Convert the work to delayed work and in case of reschedule
> do it jiffie later and avoid potential looping.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] devlink: avoid potential loop in devlink_rel_nested_in_notify_work()
    https://git.kernel.org/netdev/net/c/58086721b778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



