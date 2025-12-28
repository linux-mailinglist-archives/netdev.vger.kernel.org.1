Return-Path: <netdev+bounces-246170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27556CE4A3B
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5129A3021E50
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28829B20A;
	Sun, 28 Dec 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Tc+Hrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4629ACF6;
	Sun, 28 Dec 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766910896; cv=none; b=qAg4vidoFPkmK8q2dLL+mx7MIoyNbW/Lu/LInYkBsjYpI2cRphpg6FR2xbtwxI1QQz+EQbxYkQdKJUwWcV+F/+tWy28VdBJ934FMMSi3xUPlEpICQYew3AQ7ABUsLZhWUp3ziRxJP0gkuRpYRMrx1oJosBG2qaw+G3T4RANB2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766910896; c=relaxed/simple;
	bh=szvOrIGDUyBJC4hXAhpNCK0CU7meFnljLke81IS0tCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PeNARz4fy7baX2OeNbNeNRhS1/yZabu3kI3C5QsxFpVV8HDl0xx42sVUNL5oINIyfnLsEvKDSM0Yfw5bl8VaDp8vNc0fLLUaNA8Acr2kvxtA/wPDBDK8pCOn306OsaUzIvXwDKXvimIfIcEnu0YcGwS/5vYy7CTz1AM96o6UEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Tc+Hrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E4CC4CEFB;
	Sun, 28 Dec 2025 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766910895;
	bh=szvOrIGDUyBJC4hXAhpNCK0CU7meFnljLke81IS0tCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6Tc+HrvWo5hvKOt3ib23O50a1jg9qCE7pC4g0zJgwGd4ROYmDTEHpZGY4yG565Ne
	 lzENcvp70QArj9BwWqKPp/eurVUU2++fE6Ww4jmSGBP6DjBMO3rsZQOeBS3cBE5M4U
	 o/vFZo+sHzBxMrifA3ldSfqGsDACIAdW1t8kiiasGbkUmzTha0ZOQcxaSzyUYiXrB9
	 0AMCBgqVP0Fm8RFeV9R22BSY+GA1AYobAwYawOBuKN9bNp3/4TXdE0iLEfXp8wjdHv
	 NHiF4sqAvrGIxSKbKKN2mPkhJ+HozTWBTcO1qRD3vhcN2EId63JZpfJa+A7fvzSHmb
	 1sUEBn48zDG2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BC923AB0926;
	Sun, 28 Dec 2025 08:31:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: asix: validate PHY address before use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176691069878.2288022.11429668150024259840.git-patchwork-notify@kernel.org>
Date: Sun, 28 Dec 2025 08:31:38 +0000
References: <20251218011156.276824-1-kartikey406@gmail.com>
In-Reply-To: <20251218011156.276824-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, khalasa@piap.pl,
 andriy.shevchenko@linux.intel.com, o.rempel@pengutronix.de,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Dec 2025 06:41:56 +0530 you wrote:
> The ASIX driver reads the PHY address from the USB device via
> asix_read_phy_addr(). A malicious or faulty device can return an
> invalid address (>= PHY_MAX_ADDR), which causes a warning in
> mdiobus_get_phy():
> 
>   addr 207 out of range
>   WARNING: drivers/net/phy/mdio_bus.c:76
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: asix: validate PHY address before use
    https://git.kernel.org/netdev/net/c/a1e077a3f76e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



