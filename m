Return-Path: <netdev+bounces-224191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D57B82244
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A7F465089
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600030AD1A;
	Wed, 17 Sep 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjChzD5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF4226D0F;
	Wed, 17 Sep 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147622; cv=none; b=X+sGDGwQIZCyJnroJ8vdhVNmkCxtnNfczSdxiiX6HtNeYscDRDAiRQaoF/97Dj49PvUvE1qTJ6N643+NQIpvqkNM0FtsEcCBaoXfsYRWAv+pQGzBlq94fV44hP19obDdPl6MhIHrVDsvS5OhGyX8DS3zcyoX7ZFQ+J1ZHbeSRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147622; c=relaxed/simple;
	bh=qrK3jz3O9kgdxTDi2HCMPN/e0szIgRBa0OTHjlwdBCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IgMTOVGzkkS9qQOJ6QXu5JOMmWNGZOepNp+j9FnmlUF5L7jiZLjndTTyK0liwW1uPcruULWQiRXWnYykRkQJ3kLFIttOJYpZAY39wYkttAl33lsqE4BSjfkJsb+F6rHo0R7ZnfhPnLMyHTKkJqC1H4rcSRA7ZTyXikzdVKKPEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjChzD5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D59C4CEF5;
	Wed, 17 Sep 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147621;
	bh=qrK3jz3O9kgdxTDi2HCMPN/e0szIgRBa0OTHjlwdBCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bjChzD5SWTGMmCcdMOUsOPR0GCu2ajlvt11zsAoSeyqW7Az08Ef1GzpiYYbtH6EIH
	 9wLipsiN/2bJQXNEVZ/6emhVsqsLQfZ7QF7uLc/cDcJcBtGMv3tFAwtvnQZSp39WWL
	 /GhBx92kSzoVmcjobe7KD4yxoEU9c9sjzrjq9rm+DFvIyfgKIR0SKndhgC1DVsj3vr
	 a4b7vJH/GzEvsr5pYGN8sfUMRuTVTy5LgyACal1o6IumBlSji2WyM04qfM2VTJhWVD
	 CAqd1OBoE4mhXmV7Z0H1T/23DIjoca07SCrstBEXK7mIn6ZcCy0xr5dLuuOzfzLqRu
	 DcuXmJMUCjWMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE439D0C3D;
	Wed, 17 Sep 2025 22:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] ptp: safely cleanup when unregistering a
 PTP
 clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175814762198.2168096.17479042568343999293.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 22:20:21 +0000
References: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
In-Reply-To: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: richardcochran@gmail.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, dwmw2@infradead.org, edumazet@google.com,
 imx@lists.linux.dev, kuba@kernel.org, jonathan.lemon@gmail.com,
 netdev@vger.kernel.org, nick.shi@broadcom.com, pabeni@redhat.com,
 svens@linux.ibm.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, yangbo.lu@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 22:35:30 +0100 you wrote:
> (I'm assuming drivers/ptp/ patches go via net-next as there is no
> git tree against the "PTP HARDWARE CLOCK SUPPORT" maintainers entry.)
> 
> The standard rule in the kernel for unregistering user visible devices
> is to unpublish the userspace API before doing any shutdown of the
> resources necessary for the operation of the device.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] ptp: describe the two disables in ptp_set_pinfunc()
    https://git.kernel.org/netdev/net-next/c/0fcb1dc3e804
  - [net-next,v2,2/2] ptp: rework ptp_clock_unregister() to disable events
    https://git.kernel.org/netdev/net-next/c/a60fc3294a37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



