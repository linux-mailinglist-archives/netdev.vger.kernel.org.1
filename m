Return-Path: <netdev+bounces-174308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5002DA5E3AB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9343F17A37D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8425742D;
	Wed, 12 Mar 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAiW5GkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA52571C4
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804199; cv=none; b=LXsMXTIr9d43MoezrLIVDcf+UWwHXy0SZxQXdJhYYk6pfIomMby8bPNV8BrV8EcVxDnCKRWxe04qWm88N1vq1iEQUKcRUQwjcw0tLi9JpWqoVtrgs7Um4HEdohU4CvduKpj/yJJ+LhjTqprny5za45hFnAnrVUCRd1ic3QQTtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804199; c=relaxed/simple;
	bh=7qxBbYyOQugkREWjgcod15eXhNtBtWpwB/iwHb2nyns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uYsI0478BaGWhH5WfmxQV20/qXG4SESyQyWo4LGfR2PpgMmhIdyYKcXOmedfvStI32RNxNPAkbM8m0cXGisdx5jVcl3Si66+UW4bJZAEc0ADy3SnwroupmZgckVVwCsBrhtUMsG1/uWTVGNOnfHjrxynnElcJdUQttDQufAOwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAiW5GkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E914C4CEEA;
	Wed, 12 Mar 2025 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804199;
	bh=7qxBbYyOQugkREWjgcod15eXhNtBtWpwB/iwHb2nyns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OAiW5GkTkDBEG2sIQuj+zwqdX6VgMBKTm5nbmH5haLeH3djfBUcMEw5MGWRbXbkvg
	 FTFX6OoSb50LvXZf4EI64u5OCiXbNecQPGbiLpA1/qFR4HGc5qbOZ/IOBZXddB3wAt
	 qlWTiMF3igQqXwsPyjKtm8e81Qfwkris/NkhKmaHXnbF3VhsVGHq/gpGJ7YgS9D0ze
	 XzDglFNaxXAXHrovMoju2nG10UOnV5YHIXtkTA6EwnNNN29ImddyeEg6/D4yDZdSUi
	 pOz+N40jbApSXvIUg1AJdNBq2c6Fs6HCsR3Y9iL88FQoueQZE+6uf/WpjBO0vXQgL0
	 jQQ23vSVmnLVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4F380DBDF;
	Wed, 12 Mar 2025 18:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc: nat: ffs should operation on host byte
 ordered data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174180423373.890466.587957696271695930.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 18:30:33 +0000
References: <20250306112520.188728-2-torben.nielsen@prevas.dk>
In-Reply-To: <20250306112520.188728-2-torben.nielsen@prevas.dk>
To: Torben Nielsen <t8927095@gmail.com>
Cc: netdev@vger.kernel.org, torben.nielsen@prevas.dk

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  6 Mar 2025 12:25:20 +0100 you wrote:
> In print_nat the mask length is calculated as
> 
> 	len = ffs(sel->mask);
> 	len = len ? 33 - len : 0;
> 
> The mask is stored in network byte order, it should be converted
> to host byte order before calculating first bit set.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc: nat: ffs should operation on host byte ordered data
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=afbfd2f2b0a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



