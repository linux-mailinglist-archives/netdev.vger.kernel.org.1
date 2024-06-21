Return-Path: <netdev+bounces-105655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3B912298
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3342428B098
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5B171E5D;
	Fri, 21 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL8EQ5Wa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8E171E45
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966429; cv=none; b=LDt/wqzOapwWP5QcX/g3dKVfEDwqU8jOfkXUCaooqTtsDtJyHJlN47eBSAx/T8defiLImWj/VQJPiMoa7UQISV1gdtaz+qGn3JNLPvw63kWbZUXoOzlKvJW1nSRNjpf6GxAErq0OvDFYoiYXxWyZSWAy5BIDzTEihyBBugAHGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966429; c=relaxed/simple;
	bh=zqqgXUqLlNMAaiKFHz0+URupPcYwt0z/a5fcs6/pkuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLy3fFKXXGVYXz4/EDGfkT0odNI6vTd5oNCMP0sGwAxqOlqmIROpe+86GAm7FOi2aNgaiVkDTPI6bco6t7alh7yw1I9MLqKYavKye4whie+6sjEzuMtdQiWNJvKQXmeQOK1oS3MErsjfeIgVevAnQOfl2tF/tRiW25soyzHEN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL8EQ5Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86743C4AF0A;
	Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966428;
	bh=zqqgXUqLlNMAaiKFHz0+URupPcYwt0z/a5fcs6/pkuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aL8EQ5WaH/ScT7KAWcYz1ftXJG2YEn5EX2l1RZQ7s4NhfxxllMBaSsXM7k/CvY9sB
	 ErlEqz18CmAW/tDv97YQDpBr5iWV+2yLuznrmbkKGcRQ1DvsXSY17v9JQAbJ62nBY+
	 4GB7AMCRz0zwiy9tb+O8qObPQwqN6Euakn2dWLc3GvaAJwk2Ef+lJOwQqbNAazkmfX
	 y2FYhfs/lpndPG2xFPCDVwrJQQ4OVG5QGOL70g20q2Fu3NSxg2axDqlTt7oXjRWoOs
	 iatTI4v8tpmaBCOS6xWLurDmNv3hD2zzrefwGAs4jTwV1y5taARg+N7I3SbmCUFDYT
	 R+UMTDR6Y+dtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74FBCCF3B9B;
	Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ionic: fix kernel panic due to multi-buffer handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896642847.6147.9770871206585086960.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 10:40:28 +0000
References: <20240620105808.3496993-1-ap420073@gmail.com>
In-Reply-To: <20240620105808.3496993-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 10:58:08 +0000 you wrote:
> Currently, the ionic_run_xdp() doesn't handle multi-buffer packets
> properly for XDP_TX and XDP_REDIRECT.
> When a jumbo frame is received, the ionic_run_xdp() first makes xdp
> frame with all necessary pages in the rx descriptor.
> And if the action is either XDP_TX or XDP_REDIRECT, it should unmap
> dma-mapping and reset page pointer to NULL for all pages, not only the
> first page.
> But it doesn't for SG pages. So, SG pages unexpectedly will be reused.
> It eventually causes kernel panic.
> 
> [...]

Here is the summary with links:
  - [net,v2] ionic: fix kernel panic due to multi-buffer handling
    https://git.kernel.org/netdev/net/c/e3f02f32a050

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



