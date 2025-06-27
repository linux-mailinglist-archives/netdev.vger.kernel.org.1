Return-Path: <netdev+bounces-202078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA2AEC2D2
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAFD1C619B1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5C290BC8;
	Fri, 27 Jun 2025 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxlOiX4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008B290BA2
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064590; cv=none; b=g931//UH18gEm7tdBHs40d18iXg7VAFXQrQftTQdkjdKBO7pVAjtZIu/Rp9Sx+yl8mpNld04u+fsQZOQlhSUiRrSuZyP1a5lmN3VwCfBsdw3RDaMcV1N5bX1nSnoLZaZ3OouQqs/N97eX41Bn0giLMHHNqP34j2CkWdpOZ67k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064590; c=relaxed/simple;
	bh=rY1sh8o5PKFBABlE0sKWshCnhx5CJA1WwVl4vorsnQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZ14np4oq7ZVOXL1sNBQ3W/xoREMZp01ihgCTP1K7prRpFzGBu/F072ywUDUCp1c9VmeK446cHkFJVUZWjRFB5kikc4M8vFYloPsAK3vTuo0Nqr5EYBD4zXLLnd9WgDpPyyGTCPYP32zR7SSwobTy7bvCsz19HBIKg3oSYBLydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxlOiX4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAC8C4CEE3;
	Fri, 27 Jun 2025 22:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751064589;
	bh=rY1sh8o5PKFBABlE0sKWshCnhx5CJA1WwVl4vorsnQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FxlOiX4bU2xMJYB3c+Yae1AMVQJ+C6HHwRXM2aYHL3xhZTNEZGa8zoQxmjYJBBx3c
	 ZMGIIbigcd+t/miPyYFXdk9nhakHXW66ZrIdq1y9o9HYrkWi/dt1CJzUdlgx+FZ7Iq
	 OFMXYfntsaquILkjMAmkjYWXy40uO3CmymYu9Vu0yy+pBQXn7kVylDralRN3sqCK+h
	 9njwniHRVRgNhvEp2TADkH9CWAtmxDSmOCGIZx4omgwDn1+Yt5qFSq6aAhJgXpHMFC
	 iwtxpu9thPlfP1ny02uiXM4/4w3MQEI0azM/vC/qFLqJwqx4aYl2Y3behNm5ygZgC2
	 6Pdy6Lhq4NLqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD138111CE;
	Fri, 27 Jun 2025 22:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: take page size into account for page
 pool
 recycling rings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106461574.2081565.15577176900237342067.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:50:15 +0000
References: <20250626165441.4125047-1-kuba@kernel.org>
In-Reply-To: <20250626165441.4125047-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 09:54:41 -0700 you wrote:
> The Rx rings are filled with Rx buffers. Which are supposed to fit
> packet headers (or MTU if HW-GRO is disabled). The aggregation buffers
> are filled with "device pages". Adjust the sizes of the page pool
> recycling ring appropriately, based on ratio of the size of the
> buffer on given ring vs system page size. Otherwise on a system
> with 64kB pages we end up with >700MB of memory sitting in every
> single page pool cache.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: take page size into account for page pool recycling rings
    https://git.kernel.org/netdev/net-next/c/f7dbedba6312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



