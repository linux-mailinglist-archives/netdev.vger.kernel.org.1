Return-Path: <netdev+bounces-168908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50672A4172A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C616F18958F4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F2186E56;
	Mon, 24 Feb 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioprYjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CB78F37;
	Mon, 24 Feb 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385199; cv=none; b=eXvSs07LBKhpLjA3VFt6OL+p19KGSJYVSHC7JrbUk8EFYNS6zzt9as8OIPPwCCbQcoiuvCzaus89+mFWIBITM83Ls5xfM8SSONh2bsCfSyGLJJerfDOFjZqt3dGZ/JxIMwrSyDAcOW+Oy6MtAwRE9qxhC2dMAhBeHau5SK2XdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385199; c=relaxed/simple;
	bh=WRw3GU6KiQoW+w4MXfMGNhDMrQVEmkbV4uPnsG3VKG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UPEM4ftkRXPCAzRsyZKparz2zJNUW7d7nFO4X2YOh8sRUZxDirI3PdybI4gOOYq7dNDS/0A/TllwqOcPHAThvOJd7iF+XHYhvhapgfi13+tBcZaxvNaySWPcQNgUN3BiOWXL06zWnOE4BDoSwKlR1Ag62uIQWbSp3qo4zRgUGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioprYjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20D0C4CED6;
	Mon, 24 Feb 2025 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740385198;
	bh=WRw3GU6KiQoW+w4MXfMGNhDMrQVEmkbV4uPnsG3VKG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KioprYjfkW1/mlNCa+plyyJfoYmYZMq9olgl7Hqj5bx1rryFQT3wpFU60apUe2LrP
	 y1wOYtMuUqP4iW1BPL8AccuOr2jThYxMU/cQHc1IdyGP3SdqxM/B5r1d3+WtChLNZU
	 ewPSBaBDer8cXVPafVza/xCmXW6cMk8k1wi5xr2xje5VwS7ausun7WdfRe9hlAkfQD
	 wrXgAB5RQQOn6bh3h284gRxq/T/3suR9Hd1/KmQtDZQAJkcCBoPzbxLMNwSRmDlYlS
	 dCFJ6C2syMBUyt/MA26gKfQCxemrSrNgWuF48Itt1hzWuXq22W/SUdJ/8vF2ZjgdDU
	 gV8Z9/ilvRvzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D89380CEE5;
	Mon, 24 Feb 2025 08:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in NAPI
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 08:20:30 +0000
References: <20250218023908.1755-1-jasowang@redhat.com>
In-Reply-To: <20250218023908.1755-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Feb 2025 10:39:08 +0800 you wrote:
> There are several issues existed in start_xmit():
> 
> - Transmitted packets need to be freed before sending a packet, this
>   introduces delay and increases the average packets transmit
>   time. This also increase the time that spent in holding the TX lock.
> - Notification is enabled after free_old_xmit_skbs() which will
>   introduce unnecessary interrupts if TX notification happens on the
>   same CPU that is doing the transmission now (actually, virtio-net
>   driver are optimized for this case).
> 
> [...]

Here is the summary with links:
  - [net-next] virtio-net: tweak for better TX performance in NAPI mode
    https://git.kernel.org/netdev/net-next/c/e13b6da7045f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



