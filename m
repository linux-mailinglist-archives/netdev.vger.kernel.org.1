Return-Path: <netdev+bounces-173873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3439A5C100
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AD7161A43
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE01254851;
	Tue, 11 Mar 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm6yg1lT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDE14F6C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695599; cv=none; b=fvuPXcuGwgeiAQ6bKDKTwMxKtFTKkK4UyCQgVfuYDyj/1oXD95secgxK2vgWC2XlyJNGJoELriUAwSzoViYz5vR/XfyiWPNWOSGY1+Uu9/Uh4vZZUgnRlTXwhVrvwSLwlah4fGLFW0rsA0DeAfRCf07v8DVwtetLqMAXVp/MVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695599; c=relaxed/simple;
	bh=MbpR1m1iArGmXCDtDc8xl0gwyOROfWfyoGm2oiG4Y10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+2zq8mcHPRswH03bawGULvuZUPgIvpPnhecokGJqlj9K3MSQY6cktLfWw3pug+fAv5jfGk7+nhG+6rZ7d9FJawRyggCPsK+bBzy4x+pf08fiTG24UF1HzhcZVvjlQq2SdVToi6ztIvlAnDC6P/ntJO2VsbSsgNRm1E9ueeu3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm6yg1lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F46BC4CEE9;
	Tue, 11 Mar 2025 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695599;
	bh=MbpR1m1iArGmXCDtDc8xl0gwyOROfWfyoGm2oiG4Y10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cm6yg1lTT8BpE2wFHJThth0EjMUIv6HNKXnqy6gXhNdGFSlKNqR5GdI4storK52uJ
	 8hKNHgjHzv0FY+n0JmF5UXVfZ1WGI9g7ocdckAYrECNdWdhjdsI5hMZ8kFYeJIzBOk
	 BkdQTWiyQKUlZpasc5DEE+d6mVAMAgiUEt4DYN41tUXokc/3fknVcZaEFcx9G/vxLl
	 wlxdG2voffEWWrlBN7RTunn08OlJ9WC+pDTrRocnu203jnP6mnFSIRVnhALOHGPXXT
	 uEGfXLYOAJ2oMEl9ny2/WqzkoCUGk36CJmfyHAJm3SLgZ5o4WIZdj8WbD/MMxiuPny
	 /ICroyWIxHR1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBA9380AC1C;
	Tue, 11 Mar 2025 12:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mctp: unshare packets when reassembling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174169563351.61999.16449045559572414523.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 12:20:33 +0000
References: <20250306-matt-mctp-usb-v1-1-085502b3dd28@codeconstruct.com.au>
In-Reply-To: <20250306-matt-mctp-usb-v1-1-085502b3dd28@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 06 Mar 2025 10:32:45 +0800 you wrote:
> Ensure that the frag_list used for reassembly isn't shared with other
> packets. This avoids incorrect reassembly when packets are cloned, and
> prevents a memory leak due to circular references between fragments and
> their skb_shared_info.
> 
> The upcoming MCTP-over-USB driver uses skb_clone which can trigger the
> problem - other MCTP drivers don't share SKBs.
> 
> [...]

Here is the summary with links:
  - net: mctp: unshare packets when reassembling
    https://git.kernel.org/netdev/net/c/f5d83cf0eeb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



