Return-Path: <netdev+bounces-233357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954BC1279E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08B2750814D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63C214A64;
	Tue, 28 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQmwo3ti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F162135CE;
	Tue, 28 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613234; cv=none; b=OHoWdPcYcWMSYCkpDTQzoem4YvSH+arrzYpNMujujN4FH+MXJUC33jP7JLcpwU4+T9RL0LjO3S1ZZyERVIIRoolRV9IrYp04TMYvK7/4/fs7GO6r9GZixlXsfTmndGjmMUh8R1Sq8S5Itj6B7PL2CqdyGcVeeEmpIasgja6XVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613234; c=relaxed/simple;
	bh=z7qQBG/pDhxln6r51Sva6zQQ+cMlbrXg4Kh3DO7tqkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/QR9wWfRhvZGuR/Lu38E7XQsAM8xcQJLKZUKWFuwG2lepsmnnYAmGGJBcegE2/DheHJfTBBYO9JjBrgxTJxPJaiGO9qHLWdyZxNLwHkUj/w+d9/QBLz5Q39JZOUK22gdncbjAQltZ3/xY0rmAoNKDo0TwPr3YMO2VQsBwjB/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQmwo3ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ECAC113D0;
	Tue, 28 Oct 2025 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613234;
	bh=z7qQBG/pDhxln6r51Sva6zQQ+cMlbrXg4Kh3DO7tqkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IQmwo3tixMI5bmrZrrqj/m3uwWDGFLE3wGI4rkVJwk5k3nQHPf135/5AfSmkD/lrB
	 6DokeuVU0TVYDUEYmjI2wkiZ03q1obXZRmukgH5Dqvsf4pNpo30bD4vI5++CZDnem4
	 QVTHrGiiMBWehzOpzHICXHRbEi7fBUb7Fr6TdxaxLsG5IB7gWtM5b43DQs+6xnJlX3
	 c/rnyOhB2DL719HVo2HMe+/ndDCRSacOcmuialpY7iIAHBhyPYg+VPaTg3HCpiMv/n
	 aSGzHyrpNrN17aSyX9FavjwhE1zBAZNPLxDSXFq/NXpRIr/0OYMHcoZzM55nY5KulV
	 qkgcwHIrauAHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEA39D60B9;
	Tue, 28 Oct 2025 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161321199.1646308.12615821827806721678.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:00:11 +0000
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 habetsm.xilinx@gmail.com, alejandro.lucero-palau@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 19:48:42 +0530 you wrote:
> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
> passed as a argument to efx_mae_process_mport(), but when the error path
> in efx_mae_process_mport() gets executed, the memory allocated for desc
> gets leaked.
> 
> Fix that by freeing the memory allocation before returning error.
> 
> [...]

Here is the summary with links:
  - [v2,net] sfc: fix potential memory leak in efx_mae_process_mport()
    https://git.kernel.org/netdev/net/c/46a499aaf8c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



