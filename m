Return-Path: <netdev+bounces-75949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D854386BC54
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EA1F23BE5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6B7291D;
	Wed, 28 Feb 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKoUWHeF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204A13D2E8
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164229; cv=none; b=Txx/V9A8noMFGzx5TOE672jaTjLx14yTQ5cYzF4BKzUmEE6tqy8VdIwiB7y+fwXacIAn52kcrfrU2y2VWih2t/zn7hGD4XJvgwJNq/zxvKdx7LgHMzTU0oLJMEbBdEPGRAcZBZm5BLeg3cZaLVpO+5NoFpSvX7xLtM0dE406Md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164229; c=relaxed/simple;
	bh=P2IGIIm3DgCBpyDwvSVe1Z8zJBRCnOxBA/7SeHre8X4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=skJ6cqajNDkFrBvz8p3j//hZVm6gYgihBU++6V9EwigDLZJ/UxKzT5bv8S0qYGulJhD58JQ3c+qDb6q6Na9bEsclK6mqrZrzCzYd44CG6hQbhC/DrTFumAxSGkWDDNQk8abqZCeZx9h0dku0UTpDz0chbGOx0DPt8N7o5sDOU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKoUWHeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D349DC433F1;
	Wed, 28 Feb 2024 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709164228;
	bh=P2IGIIm3DgCBpyDwvSVe1Z8zJBRCnOxBA/7SeHre8X4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QKoUWHeF1GzSyt8tegcgPBpJNtvSHhFoZlYDtUDmdmouZ6Bx68HM9PRxZoLSYWsnD
	 hbdyEyePD0znI6hbZi3qp0j8EDE7i5VYDTURB+nPRGzcjlY8JWdA7X2jW1H3GvsDkX
	 eJ8J9b06n/hQMjFWsmEwX8KQBpiPZh5iMtuX6LkQM6TK03nkciXHTBfV2kyUW0JEfb
	 8snDpGepUg1wrEL2oxlk7IXIeydQlCDZHSWkT/8MR8Ggxv1kUwGHqwsdKQqWGOfWEG
	 ZVhKowCb24OterTgx/qsNpB+a03Wv2KWTc6NuOFqlMNJ2xmndjAMkiIHJHkLg3Z0z9
	 +5dao3gEXcE3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB8F6C595D2;
	Wed, 28 Feb 2024 23:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix handling of multiple mcast groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170916422876.30546.600600139648517204.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 23:50:28 +0000
References: <20240226214019.1255242-1-kuba@kernel.org>
In-Reply-To: <20240226214019.1255242-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 13:40:18 -0800 you wrote:
> We never increment the group number iterator, so all groups
> get recorded into index 0 of the mcast_groups[] array.
> 
> As a result YNL can only handle using the last group.
> For example using the "netdev" sample on kernel with
> page pool commands results in:
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix handling of multiple mcast groups
    https://git.kernel.org/netdev/net/c/b6c65eb20ffa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



