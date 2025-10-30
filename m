Return-Path: <netdev+bounces-234225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12385C1DF95
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B27E834C107
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709325334B;
	Thu, 30 Oct 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsY8r/tP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4B24C676;
	Thu, 30 Oct 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786040; cv=none; b=dvqWiL8v5pxsKYSy/wd0PjHfa6JH9kik+uEKAFvpPz4LKOz+OMaSOkZXL+HXxKISFIU1tSAo2kd7Q4ZsnQ9V1bYaWcadM9rZ+vo+mvd1dR7FnXKv8V+fiBsxwK1OzROOAOT3hhkjksNZjbDx2SoEdE+Yoylop02yvPwXQeGcLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786040; c=relaxed/simple;
	bh=FeM8HVJBhTZO6+1LBH3GZUGU/aI6V8cPlHvRHye71g8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kvZ6Q2Bj70N5vHpfIQA3xJdk2XlTMIRF0rYD8tgxvLYnZ8C80De8q97FbMK7bB4gGUUimrBRBadEhszoBAepQqn6p3SmpsVb/jj79CEei7gdGNlvBLXX86qV7iR6ksex+28/Qtl2AhyFt+9oS2awNcxOStgSLR6eElZoeJ0i6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsY8r/tP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ED8C4CEFD;
	Thu, 30 Oct 2025 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761786040;
	bh=FeM8HVJBhTZO6+1LBH3GZUGU/aI6V8cPlHvRHye71g8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZsY8r/tPnPWkacu8kfv11EmY5C7ejwS79oxg7fvBg8PRDrLSV1x9oylbCb+W8hPvx
	 MzrasjrPF1kuOVNucN61HNZG4MTOua4BsNL/Enyy01Q/pXAy3ow5dBN+7KG4jtNI/X
	 zwT6LNaoMu6KgJAYvsxlVNBAS42mdfWeNJ2IWvqinnn0yi0V+djzFYfMrBa6irr7gb
	 BGEyUr4Ec9EuQzjJxGElchz8TzhuZ0ufnQB02NnQV4pKRFyvrWJjvMVdY4DEMWdJq4
	 k7FWK9LspJoHA09196q+BthAvPVS6J5KHhdiGx2XP0Qf2NZ3q4hrOXUxWFvszt8P8S
	 P7JRBsMVB02Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7D3A55EC7;
	Thu, 30 Oct 2025 01:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: mctp: Fix tx queue stall
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178601724.3269431.3994061659121973030.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:00:17 +0000
References: <20251027065530.2045724-1-jinliangw@google.com>
In-Reply-To: <20251027065530.2045724-1-jinliangw@google.com>
To: Jinliang Wang <jinliangw@google.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Oct 2025 23:55:30 -0700 you wrote:
> The tx queue can become permanently stuck in a stopped state due to a
> race condition between the URB submission path and its completion
> callback.
> 
> The URB completion callback can run immediately after usb_submit_urb()
> returns, before the submitting function calls netif_stop_queue(). If
> this occurs, the queue state management becomes desynchronized, leading
> to a stall where the queue is never woken.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: mctp: Fix tx queue stall
    https://git.kernel.org/netdev/net/c/da2522df3fcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



