Return-Path: <netdev+bounces-222878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C35B56BFF
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5B37A4BD1
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B82E6CA9;
	Sun, 14 Sep 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMVgcAYj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB72E62CB;
	Sun, 14 Sep 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880607; cv=none; b=L/ZRm0q/S/HFAsWJIzxCKwYzL/YqfYZlEWuBWqGgBMkSzbFaKHthg8PTFzLzaU+Ss7RSb8kutlqTe6tl+w9YZdd7tOReu0VSh0BzD38mBTl6hL4aArDVPieAWXPfRH/AgKA3EjOQe0GZDts66eqiXyuvbWeWmDqh0K4CE5H89iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880607; c=relaxed/simple;
	bh=19lS0O7FUOcbmcnH0vFRXIiYWoKWCyuXNumFd2V++g4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tahLVXkP9ZtowUZadr4Ehd+SZTR0wG9cArWoQDVzzMHOGyjnxrMMhkA5Z3hZHCDHWBshCy9TOpCnN8Yk3hzKJ7CjoJ0rVaanGFTfNmoObxG7B4x2sLpHZwJuTa2CwzrNHxkCQRMlXkhgGa1k+1i65PxYrPbIYHyAwawJc/jZe2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMVgcAYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44545C4CEF1;
	Sun, 14 Sep 2025 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880607;
	bh=19lS0O7FUOcbmcnH0vFRXIiYWoKWCyuXNumFd2V++g4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMVgcAYjyQYPhYYkqT9e/dXs1tp6BrrxFRcYUb/nux0JbNYfD/Cc6WE3JN4gHZxL3
	 jdbg4o/eY1QwqCry211ELq/3EJY8fjPE8kx7sVrlMSn6YxaBX71YGOToXSF47V5QNa
	 g+PWjhNFEeaziSnXfHqQEpykhSh2FKTX9+/yAVliXyn2sO02ZuSOynuAE7w9cMZgAI
	 q9o8i9eER2a6cHI9VUSxEk2jVt7CeJGS21tUAW8+kgxdUDNm19kcEzMNxEjcdNnijQ
	 GqkhG9L3f3L9aTodkRyqmsIXph2qPyaTh937g3xlF04y+Jwv19fBUQ+EIsoJmxSgua
	 kZtD07KAzWHnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE739B167D;
	Sun, 14 Sep 2025 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: fix clock quality level reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788060899.3540305.399701938272261111.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:10:08 +0000
References: <20250912093331.862333-1-ivecera@redhat.com>
In-Reply-To: <20250912093331.862333-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 11:33:31 +0200 you wrote:
> The DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC is not reported via netlink
> due to bug in dpll_msg_add_clock_quality_level(). The usage of
> DPLL_CLOCK_QUALITY_LEVEL_MAX for both DECLARE_BITMAP() and
> for_each_set_bit() is not correct because these macros requires bitmap
> size and not the highest valid bit in the bitmap.
> 
> Use correct bitmap size to fix this issue.
> 
> [...]

Here is the summary with links:
  - [net] dpll: fix clock quality level reporting
    https://git.kernel.org/netdev/net/c/70d99623d5c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



