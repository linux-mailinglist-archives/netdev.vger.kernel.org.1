Return-Path: <netdev+bounces-137280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD39A549C
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D098F2829E4
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE074194A70;
	Sun, 20 Oct 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onCoc+Nu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B2194A60;
	Sun, 20 Oct 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435833; cv=none; b=ubXxLw3WrSVIbK52pvbmNEQ19VFVgtQszMt7+C5Ji2BfSefmYXqknEY5ApSDNI85nH+fUwBkZY4zDJn9MsLa88ADkiETwyg3gOaUVje2/tD/JnAbhAXSKtNa/CKWw6+UhdDUq+eeeGOQrIeKEwdRDvToGspczvLjvsqRTJnDLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435833; c=relaxed/simple;
	bh=z8sKs/NfddSVEvVe25hftGklMvedreOTkAq9QqyUdLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sd2TDkUFkzfLFkPJQ+Gugw2FPRmJKkX9QIFUlqRn8tlgYiPOZ/oVWBmT+9333XeGFb4g/PSwbC2+f+skAJWCQ0Zl7zao94hqtSoLM+Ewq+YeLsacMNOKtWR2mSTXYGwUJ3uwbS8DrbNvuY0pjJaEOpl46gH6lZ3+s3YKI2RPxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onCoc+Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571E8C4CEE8;
	Sun, 20 Oct 2024 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435833;
	bh=z8sKs/NfddSVEvVe25hftGklMvedreOTkAq9QqyUdLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=onCoc+NuVZpvAJN8Z2zqJyo3OTR50gZUkUnwyqUs5q6C04A/4kAmT7K9Kcfow+X4/
	 QsCypwIbIjjEUHOzdrDwT9RTbnJb1iQVBVWZ55Zuq67U0qsMwNuy6Tz4U4xEZaU0Id
	 JmPZLzGRf/lz6U2PuAsOn5gFTSPY0pHfapunBWp3z8QsxL+u4qtaYaSsfsKpyUUpqJ
	 YJlX/btLQeGZNnR9l4cGC13z/up1zggLhTi7nHKgZkQRKdjwt0bmK9IVnEvfblEs+w
	 Ie25NVHrtgGk8t49iNVR2GW8f6CyVB2Du7hC8XusLE5MX+oKLSgCi8jQfIgmEKR8vV
	 Zkm+fZ50XN6oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710963805CC0;
	Sun, 20 Oct 2024 14:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: plip: fix break; causing plip to never transmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943583925.3593495.5521515496449183220.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:39 +0000
References: <20241015-net-plip-tx-fix-v1-1-32d8be1c7e0b@gmail.com>
In-Reply-To: <20241015-net-plip-tx-fix-v1-1-32d8be1c7e0b@gmail.com>
To: Jakub Boehm via B4 Relay <devnull+boehm.jakub.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, gustavoars@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 boehm.jakub@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 17:16:04 +0200 you wrote:
> From: Jakub Boehm <boehm.jakub@gmail.com>
> 
> Since commit
>   71ae2cb30531 ("net: plip: Fix fall-through warnings for Clang")
> 
> plip was not able to send any packets, this patch replaces one
> unintended break; with fallthrough; which was originally missed by
> commit 9525d69a3667 ("net: plip: mark expected switch fall-throughs").
> 
> [...]

Here is the summary with links:
  - net: plip: fix break; causing plip to never transmit
    https://git.kernel.org/netdev/net/c/f99cf996ba5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



