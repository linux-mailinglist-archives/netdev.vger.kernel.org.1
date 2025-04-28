Return-Path: <netdev+bounces-186597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECDBA9FD66
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489B21A88547
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D334216605;
	Mon, 28 Apr 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOblO8pn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D912165E7;
	Mon, 28 Apr 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881207; cv=none; b=mevnbBBMRmsWYDhEOp0xML1xzOH1lNCddwRrE+MUDEAioy+QWQEcd4nhUar23VStTqabaoPs6tZdx4xbJi7P5Q/nQwcDLjynUjhHt44NN7XgWO9QkXd2K6XkGk25h8e8hJms/pTccDSI4tOi6OQ/PpYDyEKtJGe+IFOGIgj6W2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881207; c=relaxed/simple;
	bh=+jr1pXW8/0vwyUPzbw2kYLE7uX67prwhm7CwUieZEIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SlsyilTH4uSW1xjUw0GiUvgJ0txuo19KysCz63j6RDByzfmg5Lsi+B3SlMfRfA+wgXrwIWXQdyr/CPMgrbm7AgceGxb7Kvgk2Beb/K4WVuiUWkrP/CdGz+1G0X/XsMHq9qs+6F7hVm1e1vTsKFckEz77HiWs0C34iUaK1DsOqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOblO8pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BBAC4CEE4;
	Mon, 28 Apr 2025 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881206;
	bh=+jr1pXW8/0vwyUPzbw2kYLE7uX67prwhm7CwUieZEIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IOblO8pn09UiUSeXaEg7HuFrw71RZxTB8jLXHATdn0uZt7nCQ/HcNXwh4BINhRetX
	 iXoLeB5craQ/FM1E/dPelNvuc2HyBklhfcdG2OGfKsjYmsVLVbLM7Zi3D3DZBl3WYU
	 ryCOTzXATxzmULF0T0xZgBlZrqatVGqPS0587hi76f28RTCL2hSn2VLp3bjRCpmOLg
	 tlSxNd2JrSc5x5WfIlU+97HHCP/WwOYxQblxrbkwUaQ4FBtqQ9Po32XOP7BNyiE/cD
	 9lp5qOOMzhsfm6K1TR6bqlbwZ2KvKrPWnIPAmISs7UBzaB0neHiAJmpV1EPTcoipkv
	 rhXUIATSGBuaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1463822D43;
	Mon, 28 Apr 2025 23:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: remove write-after-free of client_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588124556.1071900.9575309402812835802.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:00:45 +0000
References: <20250425203857.71547-1-shannon.nelson@amd.com>
In-Reply-To: <20250425203857.71547-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 13:38:57 -0700 you wrote:
> A use-after-free error popped up in stress testing:
> 
> [Mon Apr 21 21:21:33 2025] BUG: KFENCE: use-after-free write in pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
> [Mon Apr 21 21:21:33 2025] Use-after-free write at 0x000000007013ecd1 (in kfence-#47):
> [Mon Apr 21 21:21:33 2025]  pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
> [Mon Apr 21 21:21:33 2025]  pdsc_remove+0xc0/0x1b0 [pds_core]
> [Mon Apr 21 21:21:33 2025]  pci_device_remove+0x24/0x70
> [Mon Apr 21 21:21:33 2025]  device_release_driver_internal+0x11f/0x180
> [Mon Apr 21 21:21:33 2025]  driver_detach+0x45/0x80
> [Mon Apr 21 21:21:33 2025]  bus_remove_driver+0x83/0xe0
> [Mon Apr 21 21:21:33 2025]  pci_unregister_driver+0x1a/0x80
> 
> [...]

Here is the summary with links:
  - [net] pds_core: remove write-after-free of client_id
    https://git.kernel.org/netdev/net/c/dfd76010f8e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



