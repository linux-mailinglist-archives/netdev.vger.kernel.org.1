Return-Path: <netdev+bounces-239499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4448AC68CF3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EC5BD2A34C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1D34DCD7;
	Tue, 18 Nov 2025 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF3pvjXG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733A3469EE;
	Tue, 18 Nov 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461241; cv=none; b=kOKBYo8R/FDe2EtMuunIFdTZ+Vjb9F8KfsOszuSC3eWd1iALh2RjDE5+mbNBuyPcftB92NDzmAAijPcJtDjK8KKduaz3OT/e+ASznSXOMo6WitIO2boNK/PQFlDU5p7xMQus7hIycoxy5YWOpASU7dZ9VZvEO016iQSnc8LAKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461241; c=relaxed/simple;
	bh=ZmxesUULdacz8nl6g3EXIoBJBowhigVCTBP5sxLvGEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hu+Xe8iFmep2ogvAVfnzexdQNB8u4DGJqoyxD9/cGC0vXmWQs53vJbtPM5kMcgvyRxybLPbbG9CtsmW5TMfjPG+7NeHvbYZeb+VOj6mxhROZ/yoqxLLVoUCDYMx2lySuPDBbtuAOqCL6FP4Z7tZOhAauyC53sUOJUxMk1UMADHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF3pvjXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31713C4AF0D;
	Tue, 18 Nov 2025 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763461240;
	bh=ZmxesUULdacz8nl6g3EXIoBJBowhigVCTBP5sxLvGEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DF3pvjXGLVaILfyd+9FdtcKCNM+CyWfYKFTt8fU0oRrUysXPvXBSIjJJEQBHyyfT+
	 gIiXgGnGRexoTklVkuGBgzR7A1XPjWijMqnD/DXoHZZa4/nQ+qqKYD7cV0CfFbjocG
	 aBtTxhm3Rfvep1uFnYEAJ4evqiGSsJx4JsZLz4DwVsh42+J1TPDgJkDDodOp1PxmF5
	 oHgChIAQd7GcVu/2TYo0B5iFYiVEkaG7e/filV7EmGTJGvcYRzLCmKWyNQhRmIcUBm
	 OGcXBFNceNTbEHGHjhLXp3AwuSTOU51JpJP8EfciGW1aDRo6OW+X5pfjOK5qemZ7aq
	 AHWcBVEK806Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D143809A84;
	Tue, 18 Nov 2025 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: qlogic/qede: fix potential out-of-bounds read in
 qede_tpa_cont() and qede_tpa_end()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176346120591.4081375.10043652831381384268.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 10:20:05 +0000
References: <20251113112757.4166625-1-Pavel.Zhigulin@kaspersky.com>
In-Reply-To: <20251113112757.4166625-1-Pavel.Zhigulin@kaspersky.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Yuval.Mintz@qlogic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Nov 2025 14:27:56 +0300 you wrote:
> The loops in 'qede_tpa_cont()' and 'qede_tpa_end()', iterate
> over 'cqe->len_list[]' using only a zero-length terminator as
> the stopping condition. If the terminator was missing or
> malformed, the loop could run past the end of the fixed-size array.
> 
> Add an explicit bound check using ARRAY_SIZE() in both loops to prevent
> a potential out-of-bounds access.
> 
> [...]

Here is the summary with links:
  - [net] net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()
    https://git.kernel.org/netdev/net/c/896f1a2493b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



