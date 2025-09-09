Return-Path: <netdev+bounces-221019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AAB49E66
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B8117CD94
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3E21A428;
	Tue,  9 Sep 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X383e6XC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8438217705
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379603; cv=none; b=lr+LHnaH+JiYKOMiY3jWZbWFgqFvzvyyglHw1zYh/QcQQORPCYAxi1p47kO86S1YTrN7RLlIzzcPTP/7bb9lJmhJN5O9SjDIFhsmlUlRELF8OlI3Mn9Iamwx/Q2RhBEA0zHVqcG68HR1A1KfSXMMuofmsDQUqo3ccpDndEOCA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379603; c=relaxed/simple;
	bh=28wRX+aGS3wGoMTY9nI55bUzK9gMneC2YFlFNFNap3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bbdDrahdAU2aVTwlwNfNyM3oib9a9USLP+Cbu+QxSJKsnjEhUPz5/KwlPyuAbPLQzY4sj69AFt1s2cCWyWOX37cw1EX8IAMWEeqQZWlcIF3/edv6flBpZR++JFhrLCLUDb2BZF0n67liDsceqxvC16igUkKadxMZnK93uYh0a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X383e6XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FB5C4CEF7;
	Tue,  9 Sep 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757379603;
	bh=28wRX+aGS3wGoMTY9nI55bUzK9gMneC2YFlFNFNap3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X383e6XCpK5I2z+rFIblzbxnzQH+jQ8+iZ0kUpQb0I8jboOWQNV25dFVJkNZMlGgE
	 mPCqagPCbwpv0WcX2glciscigsvf8ekHQQVv/ttiRnUt67qbakya1aIHjcVYuXESr1
	 WPTq6WZz5Cj5nPa/IPLQ6zW6WZ5OZdIDs2/udFSpFYryAPZD+Ezamhm0x5f4sTjzNz
	 PXsAVGRmF/5sm7Od8CId62NZh/kYQ1sw1lcQ6olM+81stY7vKNOJ9u106xEBrKBeCl
	 OGUFpIn0o4U8TJDwfKPgjJYLAACbUJvrmi9ImeN22DOmTdQy2lLkMKiwapn006hxWO
	 ziet+hYKjw0OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACCB383BF6C;
	Tue,  9 Sep 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] genetlink: fix genl_bind() invoking bind() after
 -EPERM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175737960676.101810.7564572517875044422.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:00:06 +0000
References: <20250905135731.3026965-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250905135731.3026965-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jiri@nvidia.com, stanislaw.gruszka@linux.intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 06:57:27 -0700 you wrote:
> Per family bind/unbind callbacks were introduced to allow families
> to track multicast group consumer presence, e.g. to start or stop
> producing events depending on listeners.
> 
> However, in genl_bind() the bind() callback was invoked even if
> capability checks failed and ret was set to -EPERM. This means that
> callbacks could run on behalf of unauthorized callers while the
> syscall still returned failure to user space.
> 
> [...]

Here is the summary with links:
  - [v2,net] genetlink: fix genl_bind() invoking bind() after -EPERM
    https://git.kernel.org/netdev/net/c/1dbfb0363224

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



