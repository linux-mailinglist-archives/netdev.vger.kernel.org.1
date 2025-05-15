Return-Path: <netdev+bounces-190595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF31AB7BB1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A379E000B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A3290DAA;
	Thu, 15 May 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQED/SGa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF290BAB
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747276799; cv=none; b=rvPoJJHoCo2e5SX2Qd/2+wgsS90SFCm3VlgT1eOu4up20Fhy14hASlTkCYtpBlIvE/iOUXLY2dKDEWO5tlAUkewd4VR6q3dNZtLU6FuJbhlGETpuv8dSaYj9qmKWXpDhHysaDJrhvMHAgY0IijOVDysuamYbHyNvNn0X+Y56OKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747276799; c=relaxed/simple;
	bh=dhRDrOGKin8NAoake3kg671qdzY1z+anW+PXDUhifUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aeORa3n0rgE4R8SOml7AiNE4+33rqxfZRjHbtLGS7oMZZmxPZf4WjfDUHFRAmwFIBdvzxWyj5c24h5XBcbIkTm5zpValJBWhxxHs8ETEyx737dfHIgOSE1zY5l/LPtNSiNolQfgiv2M1Os7fpV5pSQZc952DRAkuIPH38/HRdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQED/SGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27B6C4CEED;
	Thu, 15 May 2025 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747276799;
	bh=dhRDrOGKin8NAoake3kg671qdzY1z+anW+PXDUhifUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YQED/SGaj2vS87Sfy3afxnTOKezDR9qx4DZF+1ic6pzVDkXGHMlb7CDWycdFSWKmI
	 G05LcXAU5j5cfUPTSKOFt+s7Ya2T9ibY7+ia2qyX52jA5W3tcHWcUAxbKal4/fAM5q
	 Vpv93NgEgpO7f3A3v21+lz1qjknyY/F1JreZcs9Ifbsdu/tULj9DNFiGplLLjSCM0n
	 +pBoeuNmSjCDi2bzQfbd+NgRApnqJtmqg9BQL+4At1+8xY0AsRK1mM19OGpnIxPCBM
	 z2qnPljfgbvlXvVJM/bcCI9fAjgQnmagC54/q4ISkVk5QFGpsY5Zc4TWBKoyTALNDu
	 8Kbuq9ozdKHqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C70380AA66;
	Thu, 15 May 2025 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/3] net: txgbe: Fix to calculate EEPROM checksum for
 AML devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727683624.2587108.11100371561351472378.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:40:36 +0000
References: <1C6BF7A937237F5A+20250513021009.145708-2-jiawenwu@trustnetic.com>
In-Reply-To: <1C6BF7A937237F5A+20250513021009.145708-2-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 10:10:07 +0800 you wrote:
> In the new firmware version, the shadow ram reserves some space to store
> I2C information, so the checksum calculation needs to skip this section.
> Otherwise, the driver will fail to probe because the invalid EEPROM
> checksum.
> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: txgbe: Fix to calculate EEPROM checksum for AML devices
    https://git.kernel.org/netdev/net/c/141a8dec88ba
  - [net,v2,2/3] net: libwx: Fix FW mailbox reply timeout
    https://git.kernel.org/netdev/net/c/42efa358f033
  - [net,v2,3/3] net: libwx: Fix FW mailbox unknown command
    https://git.kernel.org/netdev/net/c/09e76365baa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



