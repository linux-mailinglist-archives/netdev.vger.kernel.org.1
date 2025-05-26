Return-Path: <netdev+bounces-193449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451CAC4130
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D500D189A08A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16720F079;
	Mon, 26 May 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3zgUI6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3620CCCC;
	Mon, 26 May 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269194; cv=none; b=oYsNILOgFTXlEeFedKQQYFSeRAaVhXVrs8F8IZPal3Vk126aSUVDL4s28nOaBVH9MqNnmSHt9FZpGXraE41o+juaKprlfwlgQtyorQxMGvTmv/2S0WRFBbJ0tREmiE0m64LIXwNvp5dmO1zT+4WuxKld5/vSl3xp9uNoRQ6Db48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269194; c=relaxed/simple;
	bh=xeJSnqHA0JVNhysIqhxWNknATT0guijmTw8rMyR29DY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L+58AbxRKvKWNIKvEGFLbEL83YEGOyynyPkovbXe+RPh9qqS5vU9Fh/kkTq1z4va0GATEghaC4oNBpyPXCx7pC+SPyKFDx6WSMSrJuZ59qCk76447Lq+VyS2s3lmmu/igzEaThRoOh/uhDC4ams1VGcvoa1QTPbJlWjujlXzYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3zgUI6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCC2C4CEE9;
	Mon, 26 May 2025 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748269193;
	bh=xeJSnqHA0JVNhysIqhxWNknATT0guijmTw8rMyR29DY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3zgUI6n3NwRmIAVvm8ZHf7np6UTirqaICARVa6YnI+03m8Vk9+MMMAbl5LVsT/oA
	 tiNxRFdQb6w5a05rJ/YwGt3mfVl3yMspBNyNIfroh5bbdOo1u7DTf0GEvvkqfsRqZn
	 jr1nvVXWBopiK2tkT8wiPbRzc9at5zQkw+UT/Pyf7L2YtFf2DQLMQkLuUdXoAvUXQz
	 uRjkdwX7dCsmATU0bktFFOch+R6kep2NXifX17lPpqDZkLB3aYWbixAlx4vlbhzALG
	 hC4bFgfZe37ZlJTt5JBmT3Wkx6qWv7zsHDxD7ZQnbhZigYK4siiiKwZAQe6TIXPXSZ
	 KmqvZ32X2rOqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8B3805D8E;
	Mon, 26 May 2025 14:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: aqc111: fix error handling of usbnet read
 calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174826922825.939427.1321439383834289633.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 14:20:28 +0000
References: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 May 2025 14:32:39 +0300 you wrote:
> Syzkaller, courtesy of syzbot, identified an error (see report [1]) in
> aqc111 driver, caused by incomplete sanitation of usb read calls'
> results. This problem is quite similar to the one fixed in commit
> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
> 
> For instance, usbnet_read_cmd() may read fewer than 'size' bytes,
> even if the caller expected the full amount, and aqc111_read_cmd()
> will not check its result properly. As [1] shows, this may lead
> to MAC address in aqc111_bind() being only partly initialized,
> triggering KMSAN warnings.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: aqc111: fix error handling of usbnet read calls
    https://git.kernel.org/netdev/net-next/c/405b0d610745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



