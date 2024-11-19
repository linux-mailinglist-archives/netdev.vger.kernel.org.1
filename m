Return-Path: <netdev+bounces-146078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F189F9D1E89
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91B71F22661
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2087B146A71;
	Tue, 19 Nov 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh2jy+V4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD92E3EB
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985229; cv=none; b=e7N8y2M7L+zGD8u5b+jN7OcIGtjOW3buXzJt86QzLbv3jhRvbCyd16nSE8zdUDm3+VA87v2l70xGvlDHjkCPVMcW8KY5ialdQwJHesJsdHbAdemn/AfMcN2FaEJmiWqA4Nfg0MiWrkKFRtrdca3/T7Aw7oGtTsVV2Cc18Zcy8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985229; c=relaxed/simple;
	bh=sHGMtXmuCRzKwQHj9ob4bT9tcp6gogIaU+2M3HIFo9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cS4FPDv7im2t5+QAA3SdWaF19Iq4KooH+lmM2oK3rzPuTJSgBDgLLg1VSN4xj+UbMtWkgv7faXxowBJtapg19G9UjrpZLCuwo8VGPmgo1SVeRvq2AGdzgL7Vj/s5fhvcuRSvjwWC3NzyQijLIELwO4SD493zSeCNkR8H0LAaAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh2jy+V4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84258C4CECF;
	Tue, 19 Nov 2024 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985228;
	bh=sHGMtXmuCRzKwQHj9ob4bT9tcp6gogIaU+2M3HIFo9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lh2jy+V4iS+7pKcCkcHu7WRaV8hQ+waupvyeBh2+/VFJyW9U5H3innicIDaYYvxCe
	 OWwkJIrvlQc0Za0StLJzolRY6fbxhQYCKzc7nCRbbX6+fb2ShsN+/WVCCjU1M2k6iz
	 awDG0cQkGcEc54Kuk9anlIADxAyEK7Wr6goevoZPX+WwEqNhqcT2gMkquxhHFnToce
	 Y8pUAdc560ZmAguBXims8uhL5SkTlIV9Y2saibdYmr9RJJ+g67b0FfSN1I8ZdBSTiQ
	 xyBRGZlEL2owKq1M7O4eBQLIRE9YYvDfShoxTPApp+5R2047viVEbfor1w2TKvoZv6
	 k5N3UX+1X2d0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E683809A80;
	Tue, 19 Nov 2024 03:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/neighbor: clear error in case strict check is
 not set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198523999.84991.6122075715714882223.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:39 +0000
References: <20241115003221.733593-1-kuba@kernel.org>
In-Reply-To: <20241115003221.733593-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, joel.granados@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 16:32:21 -0800 you wrote:
> Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
> data checking") added strict checking. The err variable is not cleared,
> so if we find no table to dump we will return the validation error even
> if user did not want strict checking.
> 
> I think the only way to hit this is to send an buggy request, and ask
> for a table which doesn't exist, so there's no point treating this
> as a real fix. I only noticed it because a syzbot repro depended on it
> to trigger another bug.
> 
> [...]

Here is the summary with links:
  - [net-next] net/neighbor: clear error in case strict check is not set
    https://git.kernel.org/netdev/net-next/c/0de6a472c3b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



