Return-Path: <netdev+bounces-200279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA9AE4376
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7637ABF2F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F681255E23;
	Mon, 23 Jun 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEWhMKLi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD0252903;
	Mon, 23 Jun 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685379; cv=none; b=cblPQkBknb5LPXQbimMJ+BjIStjKcAgMtrk3zcaRYCuBMIC7mFlcP7CN2QcDVUHyOHo+mxfFCREyjij4DsvEUJUL3HDDtpdi4pnGbaAGYuGfvDQuIY0inq88V13zSH5uCtgXWIAxcLUzlTiYqwb/y1beW7Ejbx+SajPwhN1zXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685379; c=relaxed/simple;
	bh=BrvzRSjoK59LpqzvZe89hKHpaWKJTtD8JAc84F/T6yk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYimWmPw8CyW/vTjYgkrRjhO9FGrdO02xeqw0Mf2rkQABkYlZ9Ll2cIXywjoTPz24bzs/w9pNnEvlmHERiYLW5K0+w3Kp0rqT8IzrpY4hdOxeakdwckwlTv/wvepskz25XpKDf8WmlUMSE1HyRh5eF5jJtqM5OUTdRfdcg3GxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEWhMKLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270A1C4CEF0;
	Mon, 23 Jun 2025 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750685379;
	bh=BrvzRSjoK59LpqzvZe89hKHpaWKJTtD8JAc84F/T6yk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IEWhMKLi+9qa5nppvIeLR178XwTQEN5/7cDr8nBZ0Ezf7Zv65MdgPmrm6SSJmtC7Y
	 gaqPbAOMQyoharJYcCV/Q1Z3CXuOAAaC3JdOt8RDVIruoojhJYxaVXdfY0mga/lTUT
	 w5vs+dUdZ+hk5uxsYQEali5u61vt0QYGC2QRMyO3AjrGPRPP74esQblmIYD1SDTV7o
	 88nS+SymxUtKhaRoi62ba8hFcnLIfLXxoEPgUNz8BxKQVKKX9ndFk+5oVcRWvcmi9/
	 YSriDeApWh+sM+1A6KUBynHRy0RSIsrE6AuMcbe/VjYS4sB1rIxYfL52IDoha0bV/L
	 MXkncgPmMEoRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717C638111DD;
	Mon, 23 Jun 2025 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qed: reduce stack usage for TLV processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175068540626.3152722.11490388428832541622.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 13:30:06 +0000
References: <20250620130958.2581128-1-arnd@kernel.org>
In-Reply-To: <20250620130958.2581128-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 arnd@arndb.de, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Jun 2025 15:09:53 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang gets a bit confused by the code in the qed_mfw_process_tlv_req and
> ends up spilling registers to the stack hundreds of times. When sanitizers
> are enabled, this can end up blowing the stack warning limit:
> 
> drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c:1244:5: error: stack frame size (1824) exceeds limit (1280) in 'qed_mfw_process_tlv_req' [-Werror,-Wframe-larger-than]
> 
> [...]

Here is the summary with links:
  - net: qed: reduce stack usage for TLV processing
    https://git.kernel.org/netdev/net/c/95b6759a8183

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



