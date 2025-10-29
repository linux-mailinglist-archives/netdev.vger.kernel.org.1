Return-Path: <netdev+bounces-233730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3DC17A51
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9414F2D30
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82AE2D6E52;
	Wed, 29 Oct 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk8BCHwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C82D6E51
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699028; cv=none; b=JenDxBBXYmaZbBo0rDXyslUCq3Xe2zEvLCxvKrOP5uovJFIVpzohN/rWDqrjrZM9/pt+SaUbdg70b40MHNLpC1wO+jxmAVCs7vFS8MpkVeR5yaZw6KvO9B0vChEaM9LcCW4u3p7wyZypmfG8E/AWh/UQEk0eE+xB2ACSUNgn/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699028; c=relaxed/simple;
	bh=63Pt9nluawoceWkLJ9sFI3HipMRG00/QlZgCWzlFwLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fs8hbO4WhwSWhaEXYgz5BQNI1ch4tsMdQqI+isw5g/vFl8sFoH5h1hUkSA4Kd+TQ2gQDae2MvajWCpfdnwMm3mfq+4h2+UiQ7U/I00S1ItWtVlMP2k7CsAhSUsENKJm0x9lNMOJzAFHGaoAP+QexbGacdC5TJIuNYMutvKLkvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk8BCHwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4B6C4CEE7;
	Wed, 29 Oct 2025 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699028;
	bh=63Pt9nluawoceWkLJ9sFI3HipMRG00/QlZgCWzlFwLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mk8BCHwr/p96CHJWj9wdldHJAfvtOyhqqfsH/GeBw9L1nrPNMnRNwuteKhgzuyUGW
	 8GR0ez61xpus5NsEYGzMCMFix2fWdQ+Xn8YkGDH/syoY6WJsa+9jEYuyfh1hWgkqcx
	 QdsB/4aDP9fd6AWNVT6k/KbCqeZhmVj0S3bEHq2ozg7E/H7PgzRmSTWK1K7JulHJOG
	 ARTUUxyMU3xwfOOzf0pY1B9MFddk7odFG/luRL5uNkxTyg4SESJl//B95I4JWI05AN
	 I+BYVkvdZVm14xI93dzxmjb4pX31dlBmy67DYMjdTpACKQ1jrFrHmU4YJzkIlLz3Pn
	 wBLyABwLSVZgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8539FEB6D;
	Wed, 29 Oct 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: optimize enqueue_to_backlog() for the fast
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176169900600.2443090.15699593563364635043.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 00:50:06 +0000
References: <20251024090517.3289181-1-edumazet@google.com>
In-Reply-To: <20251024090517.3289181-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 09:05:17 +0000 you wrote:
> Add likely() and unlikely() clauses for the common cases:
> 
> Device is running.
> Queue is not full.
> Queue is less than half capacity.
> 
> Add max_backlog parameter to skb_flow_limit() to avoid
> a second READ_ONCE(net_hotdata.max_backlog).
> 
> [...]

Here is the summary with links:
  - [net-next] net: optimize enqueue_to_backlog() for the fast path
    https://git.kernel.org/netdev/net-next/c/a086e9860ce6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



