Return-Path: <netdev+bounces-224952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A223B8BC35
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 03:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14BA64E2EB0
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3D2DCBF7;
	Sat, 20 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffis2AsM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84D2DE6EE;
	Sat, 20 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330010; cv=none; b=fuk8tUvmWlmaB57rhsj2tZfXZ9cVbNQisdS1lEOL06jaY8Yjblb/nDjzeMzr2gQk4ZqnVhqC1O6GTfzl9GMbbb7rfp5plcayQdzeemdhFgdC3W0kQ/frLR/ettQmKr19oRQSU+w//wddkRsjvgNh2Va6jlE2UTWGfRPbk4WeE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330010; c=relaxed/simple;
	bh=2qJLkz2bUY0cv4oFIA2AmdjP7Jd2VRRlmZ/MXWgPdU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pP/NHYbx2SxoHI+/xASj3D/nF8eZTXTNKgpuV3ieBIhAYy2WW5jALO1vjW1yzvekouUjQ+rv/zdJqRagGPq7CYC9uH4NFmyNznXyY9JYVnxI3IH1FZqAhbWgchGttkmkkeeWFtf62KtBHNsbdZ0ws1tiKP6qxs1aUCijOli7IFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffis2AsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEC9C4CEF5;
	Sat, 20 Sep 2025 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330010;
	bh=2qJLkz2bUY0cv4oFIA2AmdjP7Jd2VRRlmZ/MXWgPdU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ffis2AsMJ/r63H0kQB8/LiQwIo3vLOqX8EFCvoSMm/TSDW8uZgqPpsgjHTBZqP6Zq
	 eX3znfg6Kcc9ac4R73//86DEA+sUsk+5Hc1LLYsfr8H3CMUmz6kVNlaUUAjJPPGOyt
	 i9IevfeTcXckbzVDDKc9Xh57NBZGCX08U7XNBsGEbYZpwl5diKckRo3VuiILAHnzt/
	 yq6m03cnGWeNLc5Bb051EnaZlCuvMMrocQGOGo2o4+6ddmjP7WEw7GNl5r49dpji3c
	 m8szbYDpgXz/oTR1PcgDct8o/qFVp7MQ1RmeTANn3+ZD2/SBb/EtM22cymsdLx7th2
	 Vzu1fknhmJjjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F5439D0C20;
	Sat, 20 Sep 2025 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: netpoll: remove dead code and speed up
 rtnl-locked region
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175833000925.3754580.12058481985804816840.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 01:00:09 +0000
References: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
In-Reply-To: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, efault@gmx.de, jv@jvosburgh.net,
 kernel-team@meta.com, calvin@wbinvd.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 05:25:56 -0700 you wrote:
> This patchset introduces two minor modernizations to the netpoll
> infrastructure:
> 
> The first patch removes the unused netpoll pointer from the netpoll_info
> structure. This member is redundant and its presence does not benefit
> multi-instance setups, as reported by Jay Vosburgh. Eliminating it cleans up
> the structure and removes unnecessary code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: netpoll: remove unused netpoll pointer from netpoll_info
    https://git.kernel.org/netdev/net-next/c/b34df17d588d
  - [net-next,2/2] net: netpoll: use synchronize_net() instead of synchronize_rcu()
    https://git.kernel.org/netdev/net-next/c/614accf54553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



