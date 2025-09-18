Return-Path: <netdev+bounces-224285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6DAB83806
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3290A2A01C0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AF2D7DFC;
	Thu, 18 Sep 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t20taABH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC050243946
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183606; cv=none; b=Ro+jVj07J53shrBSBu+sxJ7cyWe9mTiRwYtFAWV7/VD+vLD2bWKEfyVe9WAbyamPKtW2ofu+pWSLofrIftl1TPe2y+0mHhZcoeDy8S3YsvoIho6oZbKjD9ABmHP4hSegS70Lhik1gR+92yJHx1Q1B2XuFVE9KgoPCz7eIR1TIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183606; c=relaxed/simple;
	bh=Lw0h1U8Vv7/uICGpHwUXvICubDX5nGaKi9MaGw3MTpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JnjXwzhlI0abg3YOhaK8rvCB89AURiEQ6H4vYQu0MO7VLV3YkBs3QqRc2Th9YHvNoK1skEdNpIg8lbrwafdMNT30mqHoDAvbgq1nXXIrZEzVBkuFdMDpRcs9TLDxoyqj8PeM5xrUnW3nOxhSfcXaz4dEWaQy2WCpjex1LSudltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t20taABH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E39C4CEF0;
	Thu, 18 Sep 2025 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758183606;
	bh=Lw0h1U8Vv7/uICGpHwUXvICubDX5nGaKi9MaGw3MTpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t20taABHFykSsnvBxQZuk25+SDZghcNxmut3FmAj4PYvPUKaJkIRhYqge5A88SGpq
	 3PNVYVRGANn27bzLmkw1JsIsV3xyByPYMdCWhsVYKpRpN67gSUecEpQwDt+2rS5202
	 RUeXWOA+MWJu/57AYQsOpZoaS9gatdehB1nT75f9l+GyuRvjAJq6MqaVOf2OVNGb3b
	 55Jo1TTFVy+E5FM+aSbk/XA1fK+EDKsu8BJA1ftOaOO3N9ScN8ioHDw3ceNTQP65Qh
	 ZSpLGbarFSThijajE+iFtAYtABQ/7mG4il97MNYuYiWjFS8aQIxR59d4KXyal1/DuJ
	 Hgq0NGaH9gj9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1839D0C28;
	Thu, 18 Sep 2025 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: fbnic: support devmem Tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175818360677.2317424.10480948154647956199.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 08:20:06 +0000
References: <20250916145401.1464550-1-kuba@kernel.org>
In-Reply-To: <20250916145401.1464550-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 07:54:01 -0700 you wrote:
> Support devmem Tx. We already use skb_frag_dma_map(), we just need
> to make sure we don't try to unmap the frags. Check if frag is
> unreadable and mark the ring entry.
> 
>   # ./tools/testing/selftests/drivers/net/hw/devmem.py
>   TAP version 13
>   1..3
>   ok 1 devmem.check_rx
>   ok 2 devmem.check_tx
>   ok 3 devmem.check_tx_chunks
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: fbnic: support devmem Tx
    https://git.kernel.org/netdev/net-next/c/b127e355f1af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



