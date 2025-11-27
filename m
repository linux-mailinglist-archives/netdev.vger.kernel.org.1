Return-Path: <netdev+bounces-242233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D3C8DD6A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F93AF3B7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23063315D3E;
	Thu, 27 Nov 2025 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jzbv7caM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B282F90E0
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240646; cv=none; b=qII4MYx8rn5Dk0xHuJUFvYRl6k9oMisBMCGfI2OljFmxJDbG2OP2IbJOX0IRzY497aCHC6tx/6nEbwJ3L0QMehySRRAeLUi5XLcxRWuGqMejw6rdbgaMIlesxdn0vBu+5JA87STgPeZwR9YB4e2UnQPzhKRsNqcyZ7izzIx9/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240646; c=relaxed/simple;
	bh=JcaGwUJAobgLtz3RCO9tEJGbLTZn8Kb/Kdw1cJ08bZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mr02Q5q5dtG8bByK3BtvPF3fmvl79Q05kp0Y6jIHd1rGeOEWLzLJNThQLJCeQFuBVQGWqSiNMR22+si2q9Jwyh8rIEeYZtrLi3OYug2/mr+b1xNPji8jkVZxFcu5/T+RvK6S4hBst+YyZcEH8bZ/ru9kO/DwqLfsOgiZBYHQmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jzbv7caM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2D4C4CEF8;
	Thu, 27 Nov 2025 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764240645;
	bh=JcaGwUJAobgLtz3RCO9tEJGbLTZn8Kb/Kdw1cJ08bZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jzbv7caMw5y3FRfM1MmY3ifGzBvaM73nAuWyyCNF3kTr4ms0Gc8gVZZdl84b+/3Bs
	 oEG6Dm47YZlnMm7OKysa8lF2X4Tw+/1XTT70gpUrs02fdK0dhEkkGJbPscupMvHq9o
	 n3YImadghVd6LEL3ob/6rRPuVLYlYoap1YS6jinsFxrYcKwvpNzbplQQFQGD4MqjKF
	 XttRBwjCwl5UDER1azpj/cr65SBCZ0lSaJe4cw8+u1cawDu5vcm5n4Y0WHyLycQMbj
	 lDo742dPDNgTJSfsNyPv3XlW+ozEPdQ9cvxPsWXSu6aLQIaBvWEGIrcLpBSEMLb4sl
	 zip7Zk8RQULpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C22380CFD2;
	Thu, 27 Nov 2025 10:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: unconditionally set skb->dev on dst output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176424060687.2521938.14818012886663483055.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 10:50:06 +0000
References: <20251125-dev-forward-v1-1-54ecffcd0616@codeconstruct.com.au>
In-Reply-To: <20251125-dev-forward-v1-1-54ecffcd0616@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 vince_chang@aspeedtech.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Nov 2025 14:48:54 +0800 you wrote:
> On transmit, we are currently relying on skb->dev being set by
> mctp_local_output() when we first set up the skb destination fields.
> However, forwarded skbs do not use the local_output path, so will retain
> their incoming netdev as their ->dev on tx. This does not work when
> we're forwarding between interfaces.
> 
> Set skb->dev unconditionally in the transmit path, to allow for proper
> forwarding.
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: unconditionally set skb->dev on dst output
    https://git.kernel.org/netdev/net/c/b3e528a5811b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



