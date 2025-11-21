Return-Path: <netdev+bounces-240627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF5C7710E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCA683555F9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F82DA757;
	Fri, 21 Nov 2025 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hibCGmj3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28F221DB3;
	Fri, 21 Nov 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693454; cv=none; b=ak1usEbi/zjGsIsNMhKA+UGd0h/eeahHlBv8OcBWCLBbctLWWn6XcmxM9lCQa57zdIdS5cTHs/2UcluPCkqcTd3V7UI8ypbqTtzw/50PjeLxeSSkHjT5Vwim0Y6qH67UGSdiR31HlV62CfungvNEl8uQtmTQYWVWsasPDQ7cMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693454; c=relaxed/simple;
	bh=fW79ECj4gYUE3wXYsVqsjNH+UzaRyxd4gP0zjMFaqqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MjSlbyRrsdVhYYHwAR0m945scALcewCNr4l5ey1Bzt4m26Qjld96Kqwg76KPXyEp/gcjE+allHAR/40wQiIJSI30WUhCyyu3EVyPjxJaIgC9gu3hU26w3hjTSASxXeJPL/dJ2PH6+7RJWqvNpzzx4N0gG9giwIsJXL7bHIWGXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hibCGmj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23BAC4CEF1;
	Fri, 21 Nov 2025 02:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763693453;
	bh=fW79ECj4gYUE3wXYsVqsjNH+UzaRyxd4gP0zjMFaqqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hibCGmj39McTgjLX1g+JxkW9BxR0oHsm78C5sDRxntra3ZL9+BLLBOgm5iqkoGMLo
	 Bq16CXHsJuZf5slcQcawH+eP6Byvvr5+HennhikltlO/aYp/rJUBIPQITu9zBFxvRk
	 Nr1KpN+bCGPRPkjKt0mWK9twGPAQ43gejjKjZ2n5ZQHtNdDVIYpSOuOSFrMyMAEH3y
	 swI7NX6byOoqrWfQdYuPoLdRDHoYprjMem3L8PIDg8J75rzWiD8q/DX1pFhDq+lkkL
	 BaaC+lYZwgN8jqJ9OygeLIkU0ObUxVbgLyXR49YBGrBHBagx0tyLzkm1c57BP4m5v8
	 zCUOYaRThj2mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1513A41003;
	Fri, 21 Nov 2025 02:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: access @pp through netmem_desc
 instead
 of page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369341849.1872917.8450711459019683493.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:50:18 +0000
References: <20251120011118.73253-1-byungchul@sk.com>
In-Reply-To: <20251120011118.73253-1-byungchul@sk.com>
To: Byungchul Park <byungchul@sk.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 ziy@nvidia.com, willy@infradead.org, toke@redhat.com, asml.silence@gmail.com,
 alexanderduyck@fb.com, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mohsin.bashr@gmail.com,
 almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Nov 2025 10:11:18 +0900 you wrote:
> To eliminate the use of struct page in page pool, the page pool users
> should use netmem descriptor and APIs instead.
> 
> Make fbnic access @pp through netmem_desc instead of page.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: access @pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/920fa394dcda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



