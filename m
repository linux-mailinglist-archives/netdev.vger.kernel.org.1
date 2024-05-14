Return-Path: <netdev+bounces-96206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C458C4A5A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A3F1F21C25
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A6365;
	Tue, 14 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us+/EkHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783C191;
	Tue, 14 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645428; cv=none; b=Cfg4pVUOWBiWMaf0PZconr02RJbpj44RfJHiPQ1rOvVymH9AH231CDtFYQ18sVdpgjq+krsAQax3SKJwu7uWikkKgMq2AlgU8X+V1d/1l5gHVVzl0s77dDZkeriyFaaqzzRbAD+5mlsJOBf2ZSod7nMDoRSiTsGtbLQNUAyeFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645428; c=relaxed/simple;
	bh=PLhszwQfItzGoZC8T0fYcEKOxeUk9OsHxGzZfw3Lzts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k7rkr94cG+Lz7Z0/ER+eAylwQfyZEMKuzBmOz7qcnkA8+Vv3IdMJiJIhUmd7jnuU3aEXOtUnPJKcHOhamFd1AsRxwFZPiTIRiOxsfHa6lrtCubVZaPC9ys2/A9pcGZPQz58UCyOM6Ox++B+JAIHhKBzsl1yO0mZR8FdkRSJ4jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us+/EkHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7212C32781;
	Tue, 14 May 2024 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715645427;
	bh=PLhszwQfItzGoZC8T0fYcEKOxeUk9OsHxGzZfw3Lzts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Us+/EkHxavwD3ds0pqRD9qQYunxaO7E8skKY1vmhTqW/ATmW5zp8Dtsr/6bgr56Nl
	 2xoA1UlfyY1TbCqQQjJXs/9+wDjgJXYzB6OUyuLZ4lIWKw4Gic5KF31R3xK6fmb40A
	 Ngo7LnMNFFXQWq9eeoGeBFXZOLHeJ75z8R05RMJRpT2c1nUQKd78VB0aS8iKgxMVm2
	 uHWzLkZyorJgSi6Ydtlt00fI5ey/GoNuJzcTMvLoXbJyXeY0G1LSsM1sGm9Opcld3X
	 SlHp0uLSiWE6WflaamBthQZUcuyf32/Sgf+DhLpMwjlfhFhuARuZTVpZUygrFp+rTS
	 yhJt1Ho0XUmZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B10A8C43443;
	Tue, 14 May 2024 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpll: fix return value check for kmemdup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564542772.9413.11990406378490828644.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:10:27 +0000
References: <20240513032824.2410459-1-nichen@iscas.ac.cn>
In-Reply-To: <20240513032824.2410459-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, davem@davemloft.net, jan.glaza@intel.com,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 11:28:24 +0800 you wrote:
> The return value of kmemdup() is dst->freq_supported, not
> src->freq_supported. Update the check accordingly.
> 
> Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/dpll/dpll_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - dpll: fix return value check for kmemdup
    https://git.kernel.org/netdev/net/c/ad506586cb69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



