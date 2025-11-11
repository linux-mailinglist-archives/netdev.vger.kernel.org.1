Return-Path: <netdev+bounces-237414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A28C4B2ED
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A303A6A21
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9653469FE;
	Tue, 11 Nov 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWYJw75b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D23469EF;
	Tue, 11 Nov 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827044; cv=none; b=Ca29lUi5jSELwsI7KbHzGiJZXxUsb/3CqmPan6b7LxRAJ93U52T/ufwpmOGX5InNGVMcs0MVAqda1LVyE998hnGPgjXzpnEmuZ5sQjvHNd1TuXJ9LD4ZiWXkyKYdw/Fcy+/OPDdACi/868/KiGgkMGiaSlMSYQa0VsK9AKgPnsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827044; c=relaxed/simple;
	bh=Vucgi6gs/xD/jJPBBcH7kSn3eGn5xTJkLGubZx9DDpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaREkKbQ31Xg+CdgDQhj2jZLPWpQf4ocxIvoioQIvwKKNzEoapVSGDvywCNojU4I/brI9apuYkDpsY+JogotltcJq5G3GAyU+AJ0c2IjPyxluwIyAw5wH5B3Xv/osSODB4Uv649qp4o7ll4Ii4XrGljYUsg+5dehe0foLKSeMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWYJw75b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFCCC19424;
	Tue, 11 Nov 2025 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827043;
	bh=Vucgi6gs/xD/jJPBBcH7kSn3eGn5xTJkLGubZx9DDpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WWYJw75bYYDPlbhbnspGcufdAEl7lQzQeq8Y1kCw1SQ+7DweTKkSu43JO+m8gYzTr
	 EleCX1Yfm4bguFXJIfOWNY+TqOsWME7Hzh2eau7lDkA18fAmOwiUAX47uNYX90La2H
	 sq+2+ADMFJehj3qKTHKCKGZf1Yaadfw/uskjMgs4W85U8/b8vikpl6zw8uyx4m2eq9
	 o9huSQj08xXzpXdVNW3MJ/CTR3PAkboWB5rClngi6QdCdbJu4V7e7JXklba/01QQNY
	 ZRUgNAk/wXNj3C5WfLp7XWhfuLoSfiJ3qwcJdD965USl/e4zM569S0gIha5mnXSdAM
	 r8tdEIg/y4k3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8B380CFD7;
	Tue, 11 Nov 2025 02:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/handshake: Fix memory leak in tls_handshake_accept()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282701408.2852248.347346618365991178.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:10:14 +0000
References: <20251106144511.3859535-1-zilin@seu.edu.cn>
In-Reply-To: <20251106144511.3859535-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 14:45:11 +0000 you wrote:
> In tls_handshake_accept(), a netlink message is allocated using
> genlmsg_new(). In the error handling path, genlmsg_cancel() is called
> to cancel the message construction, but the message itself is not freed.
> This leads to a memory leak.
> 
> Fix this by calling nlmsg_free() in the error path after genlmsg_cancel()
> to release the allocated memory.
> 
> [...]

Here is the summary with links:
  - net/handshake: Fix memory leak in tls_handshake_accept()
    https://git.kernel.org/netdev/net/c/3072f00bba76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



