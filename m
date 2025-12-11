Return-Path: <netdev+bounces-244356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D365BCB5641
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50EC23001610
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5932FC01C;
	Thu, 11 Dec 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDbU7mPN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AC2FBE10;
	Thu, 11 Dec 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446203; cv=none; b=TbDYIDCD3zm9tOCIVZvTCj+MfgGZYK2IQBPhQEvtou6tK7/HgD/68hnuLs2FkCx60qczwpWd/lqLvZfDOhtH21kGH1YL7SBFbCKT2v4xezlkW1DUCds/zYxgnseUKhOBIpDyOahbalYRdNx3tqBZvfIcN4DPSz1u5PQz9P2XgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446203; c=relaxed/simple;
	bh=Mb4oe9NOVj/ByxPMpfJp5GorIcuj+R8pUlJlrcEZGAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L9BvxUtVErA191KhVscIbF3Xr80if+dlMbe+CLZw3hZnIHVTtaZPHLk3+n+Xj13ZLh7snXaJQ/gwbly0SPwlzvCz0qR8UGNgaMAfuCJOYEWVtOR1/RrfKV1NRSPYXaW/XQzstHYW5Sv+uBT+2wR/E/HFHsbg0BxY0Jcp36xMEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDbU7mPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A54AC113D0;
	Thu, 11 Dec 2025 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765446202;
	bh=Mb4oe9NOVj/ByxPMpfJp5GorIcuj+R8pUlJlrcEZGAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FDbU7mPNUzcYbU7T8rVVUR+YVshZrJlneaNJkj187j5XuG9YModEjoS3pLBKnkQsC
	 kXwXve3XOZx4s7ccZTQOjkXaki9mlrGOh2GZFIsKmNe2oCNtEc4jgygM5BUdGu1wl1
	 a7dCkE0xOHo98lhYUT3TtIZF2zGvSynIUf1hglpdV34jQ66yChruYCr8VIKzHyYFtE
	 G9k5tq85sCnkyJ32zJgkoqWEeYGJt645VNcI4RR03MZy3oUR3wTWNI8BT9GHzuG1a0
	 eVO/QCmyV7yiSVX71aVhWkUzXbaFk5yRLNqkxeurBFqPK4wim0jHNqP//wa/upXtgF
	 1gsq5r7vwnzWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788953809A35;
	Thu, 11 Dec 2025 09:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] caif: fix integer underflow in cffrml_receive()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176544601627.1308621.3200906619222938174.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 09:40:16 +0000
References: 
 <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sjur.brandeland@stericsson.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, danisjiang@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 04 Dec 2025 21:30:47 +0800 you wrote:
> The cffrml_receive() function extracts a length field from the packet
> header and, when FCS is disabled, subtracts 2 from this length without
> validating that len >= 2.
> 
> If an attacker sends a malicious packet with a length field of 0 or 1
> to an interface with FCS disabled, the subtraction causes an integer
> underflow.
> 
> [...]

Here is the summary with links:
  - caif: fix integer underflow in cffrml_receive()
    https://git.kernel.org/netdev/net/c/8a11ff0948b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



