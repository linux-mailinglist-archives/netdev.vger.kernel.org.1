Return-Path: <netdev+bounces-142605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509169BFC3B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071ED1F23247
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9D1DA0E9;
	Thu,  7 Nov 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V05QDBWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7714D6F9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944831; cv=none; b=jDN9n/P6gxeZGEWSKsHt5w9woxmNaTOMLRNW6HQXcGeXgfaSN/wtHTHCoHe1C+HChu6hrq9L6/H4/5PFHFytiPOyrQYJ8/3wYFtuF/OVNFQoCuY4dwU8BYMZen5zyiVn6F+MLMWar7lJtnbNvNvjQBAAubiKIUjZxrezH4c9UEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944831; c=relaxed/simple;
	bh=hmvAhuiFDksc240c4mWvAD8xlk3oQW1LU1Ko5KKFVbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/+GsyUs/XM6yXkYdnLuEkR87DHiWGWbBujFIZ0EybtW7IOevdyIXWFpQxYFR/r2B32iwbVjpQogbvgBGvhOt4K+lZVWbNKNqxUMgBLignaTVZUInP0pWYdDMAB7HajCf0WmR8UqqhwWUOOMxLhSl+7USo+lfvRJEjigAqTOQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V05QDBWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCF5C4CED4;
	Thu,  7 Nov 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944830;
	bh=hmvAhuiFDksc240c4mWvAD8xlk3oQW1LU1Ko5KKFVbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V05QDBWa3+f8o/9NHgCcvsYrsftqBx0lTJ13RrpWALYyXxp9n8WoP9R9bwYYv+aNe
	 G6sS9bcpCYW4OmPYVKZqfrjuomBns9Tu6FhgAeRfyEayB8k/szmL8uSPZgNP5GlkDf
	 LNBn4g9p/TSxp2gq7YSVM5mV9BtO9+8TcLhQCQyvh39bYDyZVE5NaqSbClnyTbrXWT
	 hi2TWBLQMQ5TVcoVdZjWVXC5mjvfI+ToQrPSBsnkbCk9js3vjx+6YESShDeyUyjGb5
	 S7a6a8oTyQY0+93OBYG0PgvP6dGBbSbOyKaAqoBeKy0uwGx160+BIxA91j2ArgHJGa
	 VJqAV9bYxTmGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BEF3809A80;
	Thu,  7 Nov 2024 02:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: respect cached advertising when
 re-enabling EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094483974.1489169.10356497869242486500.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:39 +0000
References: <c75f7f8b-5571-429f-abd3-ce682d178a4b@gmail.com>
In-Reply-To: <c75f7f8b-5571-429f-abd3-ce682d178a4b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Nov 2024 20:35:41 +0100 you wrote:
> If we remove modes from EEE advertisement and disable / re-enable EEE,
> then advertisement is set to all supported modes. I don't think this is
> what the user expects. So respect the cached advertisement and just fall
> back to all supported modes if cached advertisement is empty.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: respect cached advertising when re-enabling EEE
    https://git.kernel.org/netdev/net-next/c/516a5f11eb97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



