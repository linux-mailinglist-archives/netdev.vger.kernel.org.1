Return-Path: <netdev+bounces-205636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9315AFF71A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9508A5A1C62
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8624280CC9;
	Thu, 10 Jul 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvCDQ+yv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FA28000B;
	Thu, 10 Jul 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115801; cv=none; b=mpHUUgHcxeMNzAq20bO9sNy5cxDEXEnD9ICka9/Re8VFriBzO9MkEhUiWUNldE0jv9/rushN6s8r6KoWVlpHe1ztXrG5emJoVDCLzLv85Wq1435Y/4McQn0jf6d7WOtJZ+m9fwj9GorbkzzvGlD98Zpcbpv2b3sM2cfD8uvHuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115801; c=relaxed/simple;
	bh=OAoJskV8tOibrlMBU16d1scMvJAKVDqmRycGZ8Il5sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpSAov0KxGiCfpRd1EAqjMub8tvbz+tUrMOAeHSKhv0Has9zCs57ilOrZBwE5Q5C3yZV4tGNPfuK5NLa4/j0B2HYp4KIFHzrhH/MD7Mq/T4xhtjLWBtGwafewmVsr6yl/ZnKyNKOKBU8l9EBGekoH5HTdFytPvOC5H5gO4IiXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvCDQ+yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95480C4CEF0;
	Thu, 10 Jul 2025 02:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115801;
	bh=OAoJskV8tOibrlMBU16d1scMvJAKVDqmRycGZ8Il5sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WvCDQ+yvrlNQd/I4PcisFVV/LKWFEzJ5Po0I28Rbht2/K3vdQTIv24kWo00mM3MOh
	 XngjVSXc/+tLIxpx5XkTg5bhomT8eixGy6FVeBPLZYwcF7WYHfhxl2WYl+Iz/DfHvk
	 bSFu5YVB1qMuyz0qLr8gyFrj5y/G5BlRIz1SfOE25FfJayvmlVu1g75cwej6cLAMpx
	 epn8qbilMngl6H5EIHVclEQMGlBTc7OB0q5JZ5uvh73YH+XZfzp7FOSuEvdPyw2p1c
	 8fAir7iMhI4RZLjCs65jXqg3Fa3ArkFaS3eEzCzTNIQyT6DdDMmdx6OAwMDz2Iqbwn
	 ToaOEPO2jnPUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE57383B261;
	Thu, 10 Jul 2025 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: enable the work after stop usbnet by ip down/up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211582275.967127.3179852673309162720.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:50:22 +0000
References: <20250708081653.307815-1-jun.miao@intel.com>
In-Reply-To: <20250708081653.307815-1-jun.miao@intel.com>
To: Miao@codeaurora.org, Jun <jun.miao@intel.com>
Cc: o.rempel@pengutronix.de, kuba@kernel.org, oneukum@suse.com,
 qiang.zhang@linux.dev, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 16:16:53 +0800 you wrote:
> From: Zqiang <qiang.zhang@linux.dev>
> 
> Oleksij reported that:
> The smsc95xx driver fails after one down/up cycle, like this:
>  $ nmcli device set enu1u1 managed no
>  $ p a a 10.10.10.1/24 dev enu1u1
>  $ ping -c 4 10.10.10.3
>  $ ip l s dev enu1u1 down
>  $ ip l s dev enu1u1 up
>  $ ping -c 4 10.10.10.3
> The second ping does not reach the host. Networking also fails on other interfaces.
> 
> [...]

Here is the summary with links:
  - net: usb: enable the work after stop usbnet by ip down/up
    https://git.kernel.org/netdev/net-next/c/6dfcbd7d1d65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



