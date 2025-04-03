Return-Path: <netdev+bounces-179029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B189A7A1B9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0D4175C27
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8E24BC06;
	Thu,  3 Apr 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkq/tlup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4624BBFB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678892; cv=none; b=fsEfpp5xzd1FS/EexzulrH+jvRtTkrH/pNpCzznz9GHzosjqiIvszHezMsVjxv2oRryPv2W8scqaK8Yi4y0wxtePgA/NOAA9kEfeBUZSg0FQX9v1KdpR5RwxU7RtTd3QpnNO0Lc/s/G0AO41pNjG+Ha9hH1o2dlkUJShoCxhUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678892; c=relaxed/simple;
	bh=xHoCtuELJnFSObBZBZHpGhMiUgSAumZwWBAKwcKnUxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/Vl5PqiaN9YyboVArRFaN+TvZngrmfVq/X8lNUxvYK8orQKpO0iPUdtIGdGcTYcJNh/LBlxi/mUOoohe8F3tqjuuGEkEhpjVVIf8AIy+G1neE1ip+sYqEqJfmKBHRdwCuHSStF5448jAFrHt8w0K6qZEXlgU5W3pl/qBHEOMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkq/tlup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D012AC4CEE3;
	Thu,  3 Apr 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743678891;
	bh=xHoCtuELJnFSObBZBZHpGhMiUgSAumZwWBAKwcKnUxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pkq/tlupGClQ+7wvJjMFetEr/rpKMeHvl4bMwVseKaA+0bAwFW9o+/YrhbgO9VHl/
	 GDP8oWDsTnRI8PVEBXGgMhJ8lgMo0umoTG6fTryaudNvFNeSSIUOaXu1S7vZeh6nE4
	 E0E32UlVy4wrGgbOTu+f5MLABwA6quDR66pub1VqrQ08suJwQZVeRp/++5auCsDVBe
	 7HIF9xKI2xlBzVzXHeu9A8r2+l0GxZ4va+bx3S74QrUm+RlMtqSFXHPrWbKHikfQhW
	 OGR2kX08za9AhhspcO1NISUibYPoxuEiNAneZLfaWsh2+ZZxZURpYWhWUeJYcQ26Z5
	 lD/Q8V+6G2OzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF13380664C;
	Thu,  3 Apr 2025 11:15:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: decrease cached dst counters in dst_release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174367892874.2450004.2056934652519736986.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 11:15:28 +0000
References: <20250326173634.31096-1-atenart@kernel.org>
In-Reply-To: <20250326173634.31096-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 26 Mar 2025 18:36:32 +0100 you wrote:
> Upstream fix ac888d58869b ("net: do not delay dst_entries_add() in
> dst_release()") moved decrementing the dst count from dst_destroy to
> dst_release to avoid accessing already freed data in case of netns
> dismantle. However in case CONFIG_DST_CACHE is enabled and OvS+tunnels
> are used, this fix is incomplete as the same issue will be seen for
> cached dsts:
> 
> [...]

Here is the summary with links:
  - [net] net: decrease cached dst counters in dst_release
    https://git.kernel.org/netdev/net/c/3a0a3ff6593d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



