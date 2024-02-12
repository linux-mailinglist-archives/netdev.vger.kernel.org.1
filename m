Return-Path: <netdev+bounces-70936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF685120B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227881F220D6
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586439843;
	Mon, 12 Feb 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmVwWMcm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DD38FB9
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736825; cv=none; b=ojCBD7LYLp6zw8WOOTgv0wPv0B3QrpHDujxPQ1SpkFgYJ0sOO5R+DUCS7r9088OFgFY7jkxIvslyJwnyKPkCjsJtOVwveAPQ0ZMVDKQm/8lKoNWcBwgaGz+wL6cJHTC+tBEez8zkV6NIQ+RRV5YgtKj5WRwJ7MiM7vwsOj41Rdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736825; c=relaxed/simple;
	bh=He6qUZp/lD5xnbj5T+VnLX5Ad9lhTSQpI/0MYjY8fI4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0HpEmV8O0/BjQCOrx6TovqqJnkI/Spg9Za9KkH71AZ3w27KOBdc0MT+xwiVMubOxiK5rwwhcuHSI0YE7saiaikJoahfOmn79lg8zZS4pJxgqZJ3F/eCKUfnv5/TKK9ta6Y0jmsYusaR36hSIbr/6n5Dda6mc8SR46f7WZE+FDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmVwWMcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A59BC43390;
	Mon, 12 Feb 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736825;
	bh=He6qUZp/lD5xnbj5T+VnLX5Ad9lhTSQpI/0MYjY8fI4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YmVwWMcmN2/C2JC6zmoIua9upcYKSwdcFs5aRknc0iCRGanRrTJUnLsn4WaGa0FXQ
	 Q37Bt0TXR3odViGmCaaL/q9cwMZ1XEse7H9Mv8wYJhYhgqtQak70I7qhL85M0nrFsu
	 FCTzVSdAUicgQ99LvyYtX9k3YC0mhvbGbPyFd56kXMXKuFd6SFIU6eNyF75c4UZ4Xr
	 ejHxkMGvJTZP+CsgIohp9+PVWOMQCVbtj0tuH+2EMX6RNCfJKo/S/unFXKjbidI14Y
	 lMSQAcsc2yYtrfHoP7TLpFDISiWiW4VxFv0Hi72TrrlVGw0QFqg8DuaK0f9TI+5avA
	 EazgZZ6q3I+Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E15DD84BCF;
	Mon, 12 Feb 2024 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: fix bug caused by uninitialized variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773682505.12302.5838793391548965435.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 11:20:25 +0000
References: <3e4a74f6-3a3b-478d-b09a-6fb29b0f8252@gmail.com>
In-Reply-To: <3e4a74f6-3a3b-478d-b09a-6fb29b0f8252@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, linux@armlinux.org.uk, andrew@lunn.ch,
 pavan.chebbi@broadcom.com, mchan@broadcom.com, netdev@vger.kernel.org,
 sraithal@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 9 Feb 2024 07:47:39 +0100 you wrote:
> The reported bug is caused by using mii_eee_cap1_mod_linkmode_t()
> with an uninitialized bitmap. Fix this by zero-initializing the
> struct containing the bitmap.
> 
> Fixes: 9bc791341bc9a5c22b ("tg3: convert EEE handling to use linkmode bitmaps")
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: fix bug caused by uninitialized variable
    https://git.kernel.org/netdev/net-next/c/0972d1d979cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



