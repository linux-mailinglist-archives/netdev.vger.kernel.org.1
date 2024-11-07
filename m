Return-Path: <netdev+bounces-143027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533639C0F20
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18368285A22
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55DE217F43;
	Thu,  7 Nov 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buQ533qM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEC217F5B;
	Thu,  7 Nov 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008422; cv=none; b=Ukb19jfvEJfmJ8hMdBsi0gVdddNXADnCc+DhyrPKw5wEYCiEGQACa3Cj0rQ0UbZ8BjvWdt6N3BsH0oILUX9tI+rru6XYpX0fZzP/VjppyGDRIRXRbh5j/Uo8wUI/19x5wjQLlSpaZHqPrTOpLdUi1eJLxmNSZMHNQFoAkChcw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008422; c=relaxed/simple;
	bh=fPJifo0hs/HtqMuzhM0IPkRT1/JDj+9uahX1NfxyrUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bgvcun+yz37JjiILrr9iMpc89/C4OmcfsTPp8ozItXA4f1xX1CfVOpjSNA5By/ymthIm/AtJw8CamuVa8CufZHgtw2iU1E2xd8nECVAOUaPNtuM1hUn5ZWxnS3uaud0bn63AOKfJyV4onBAkLgATMnnfFoitivaMi92spBR9zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buQ533qM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37189C4CED3;
	Thu,  7 Nov 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731008422;
	bh=fPJifo0hs/HtqMuzhM0IPkRT1/JDj+9uahX1NfxyrUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=buQ533qMeCQsSwVJcenjrONe8GJnZCkE6VdFeihdB7FL94IwamfqFUoNSi4kECgg7
	 /QwFZWnRiMYoWgTX0FUlpoCFXz4cRO6sQa9I1vjTYLMdV5zkaP03mZ9AENKgjTDUGK
	 oKUiSuSzedbLGF14jK8l6KQQ/2sRg5ZZVnBzSvkniVovzNIrNFTmdEOH7ub/m6Cp5I
	 Fi4jEFa9z1CUFIkSnA3zv3bNHurNV3A1o83zhqWdrdCa5569W2udpuzCJ2dcv/dbPD
	 ungpareBlN08V/kuNVxlefjyo6qHnS7MEaI6L4HD8DKgENnwd00oB/R0DmCVR5JFbr
	 7R3vV+6o/XGqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBD3809A80;
	Thu,  7 Nov 2024 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix missing locking causing hanging calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173100843124.2072933.507089538126045621.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 19:40:31 +0000
References: <726660.1730898202@warthog.procyon.org.uk>
In-Reply-To: <726660.1730898202@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 Nov 2024 13:03:22 +0000 you wrote:
> If a call gets aborted (e.g. because kafs saw a signal) between it being
> queued for connection and the I/O thread picking up the call, the abort
> will be prioritised over the connection and it will be removed from
> local->new_client_calls by rxrpc_disconnect_client_call() without a lock
> being held.  This may cause other calls on the list to disappear if a race
> occurs.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix missing locking causing hanging calls
    https://git.kernel.org/netdev/net/c/fc9de52de38f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



