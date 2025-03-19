Return-Path: <netdev+bounces-176065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF19DA688F7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8A81898B0B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77122505C3;
	Wed, 19 Mar 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLebxJe7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3420C46A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378397; cv=none; b=hi0pwltmGw05DpETHxDtVxZZ34lvt5ruqEqjQO4A1JcZYxHt/qNYXYXUJ4CyxRW+eNJvUd2vQ9bBKO9+3XOAlpmHxBSTjuozlCrp/aFJj6xVHcH0PFJYclWSLTgUuJX33DohEybsHNg//hJIBYYl6bNTKKaPIq6t2UeMJJWvnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378397; c=relaxed/simple;
	bh=kb6grukJo+NiUVaGN1gz0MMF4T/hfLtAvxaAfo2R9Ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dC3/6MxC8I/qeTKKc9ikQeG4XeFaUHwcrx0MJPAKwaFtlVlOLCdLlPlnUyxRjKkNP8giAdhWGWTZS1xXhF4wA1XXrMB6Yg5nFW41ze59q7PJhkSF/CvLdX1iBA+/pcHYIjeVWJQZTzQAOHHpE9o9jWN0bpK2RHp6YV8uG+mZExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLebxJe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF7DC4CEE9;
	Wed, 19 Mar 2025 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742378397;
	bh=kb6grukJo+NiUVaGN1gz0MMF4T/hfLtAvxaAfo2R9Ic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NLebxJe7TIPnUz8Kp1KPZ1DD+i+nHEUkrIgPn4GFpRJExp4sIZtQvNzRq2ze8KLLE
	 7dK+73Te7rU1T9j+vaTq9RuqEEGHv/qw4kQy5fv+hWhRABuQd1LUmROTJwcrmwJedi
	 wujIORaWhgtXN9cGYXt77I99CyafosPuUfcQ0mplmH4+e29nI7fmFm16wwvb237Fpv
	 5K3hvU5Avuq6yVuT1dS3qtMcL1Ysn+x7wcQvuTKC5EAZ/PXB3xg8S1HYbN+fUKMpUy
	 FEcqOnjKBDoNI3oFkUAnzsikPSeJ5m1B4/c281z5YznTa+EZYsrA07Q5lNemrE6GcL
	 G2WIgFdgGElMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF40380DBF7;
	Wed, 19 Mar 2025 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174237843274.650850.13644149896681069880.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 10:00:32 +0000
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 pierre@stackhpc.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, christophe.leroy@csgroup.eu,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Mar 2025 10:52:48 +0100 you wrote:
> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> from xa_alloc_cyclic() in scheduler code [1]. The same is done in few
> other places.
> 
> v1 --> v2: [2]
>  * add fixes tags
>  * fix also the same usage in dpll and phy
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] devlink: fix xa_alloc_cyclic() error handling
    https://git.kernel.org/netdev/net/c/f3b97b7d4bf3
  - [net,v2,2/3] dpll: fix xa_alloc_cyclic() error handling
    https://git.kernel.org/netdev/net/c/3614bf90130d
  - [net,v2,3/3] phy: fix xa_alloc_cyclic() error handling
    https://git.kernel.org/netdev/net/c/3178d2b04836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



