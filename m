Return-Path: <netdev+bounces-190702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89665AB84F8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF181899447
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A7298CA2;
	Thu, 15 May 2025 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlW7Rxsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCE29825E;
	Thu, 15 May 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308598; cv=none; b=GiFXSjNpYzc2jchPZkq7CTQ6YjLeG9j+z6ybDaw8LHmTlXJERQiUrd4+DRoT+jrc44lYEhnXq3mxW3B+ZhjHC0YcmByP/SjXb5jnogZUHo0LNoH4bLQRIhNqv4FDrskQzHllXiKKmyKzVYIdH9khAIfQRUZI+YAn7D9V/CN+a0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308598; c=relaxed/simple;
	bh=4RKdnUG0dHg03eLU/VPLKppJQU2g5ZLI4+rgxXB01/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AcZOayvEudU9zMKvT8MhJBpRgyJfHkY0xcBkoYepeU5KqvkMjuZARdeDyuRbXr4Kilqol1M0quIUKokkAKyNXUuA/I5y2QY+/bT14eGpyUM/wA5gjYJTFHsJ9ET1NsvaHA+8duic+6UmaZz+60WxAY32h9XpHnjmydZMNc4zqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlW7Rxsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E596C4CEE7;
	Thu, 15 May 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747308596;
	bh=4RKdnUG0dHg03eLU/VPLKppJQU2g5ZLI4+rgxXB01/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SlW7Rxsp4fDJxUFhUAWJsJrEpfYnZ/2l/SduSfcuFeiG/JAQwUNtnkykJFm0/qocB
	 6PPD7trPlYGJ3x9H0+Qv31QBSOehN2/eNr9nI3pHShnOgr8/RVr/IZaAlMRtDxNyJO
	 wXwYf0SBUQDvU9eZEguYoMhxkuPJLnJriwzrOyWEN+CpODv2DuZ1sWj6yU34xoYXFC
	 /um9e6stBA5dMWAuVjtGA3MVLle+6UkAv7VorhdxLTyw3yk8PzrjHsMoRceHXOFr/4
	 sBIVx7+ySKDGCNWLl1bsZFqJKgm5KFDkQzKZX5FZZCXg4tfRlYpP+PvG5bzwh7rOnv
	 RzyP2nH9BcjEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC83806659;
	Thu, 15 May 2025 11:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Look for bonding slaves in the bond's network
 namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174730863326.3069713.163823597511693615.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 11:30:33 +0000
References: <20250513081922.525716-1-mbloch@nvidia.com>
In-Reply-To: <20250513081922.525716-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: jv@jvosburgh.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, tariqt@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shayd@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 May 2025 11:19:22 +0300 you wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Update the for_each_netdev_in_bond_rcu macro to iterate through network
> devices in the bond's network namespace instead of always using
> init_net. This change is safe because:
> 
> 1. **Bond-Slave Namespace Relationship**: A bond device and its slaves
>    must reside in the same network namespace. The bond device's
>    namespace is established at creation time and cannot change.
> 
> [...]

Here is the summary with links:
  - [net-next] net: Look for bonding slaves in the bond's network namespace
    https://git.kernel.org/netdev/net-next/c/c16608005ccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



