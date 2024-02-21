Return-Path: <netdev+bounces-73637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44F85D6B5
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D611F22701
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE83FE48;
	Wed, 21 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/UoZhvf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A63FE2C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514427; cv=none; b=FNKha0N/rq9tEZ9i279CMtU3/f65vp4RuILByE656mICKoFe31S/QszRmX4I8nvkK2tJbgryxPuQk9/zoSvCej+am1DULJJms04n41Fw/qj7XAxsoFhv2uP6N7KearJcYaSknQWpif5UFNKmL/jIcyh1vuXjIoLDWdi/1zaOeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514427; c=relaxed/simple;
	bh=O+Kbo8DS6jLgDFs0FCpP9uf9LZXUvOEYXnT7/EVUZXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GZ7EOJOOaUOXtcgxnVNBfLA1uAWtMWvdL/IUI2QhOcBjsrawooFmlOPb94m6DLKXcxDZUxxJH26FKbGl5fc8xJFt97Ib5PoT1qJE50fh5VIlU9V+WBwulGo/wr0dU1M7xP7zrKK7IwoJmWk6OlL4f+E/3t2v111RFJs4oHC5XlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/UoZhvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3E4DC433A6;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708514427;
	bh=O+Kbo8DS6jLgDFs0FCpP9uf9LZXUvOEYXnT7/EVUZXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/UoZhvftc/k7/KS6y1gk+wwhvpx+CrhWwYin8opRd73w7pQtDkQkpiDuWNgCaGlb
	 XBoT2/4Aa0cj3jmXORnNhdHnh8j2SnX1wB+svkQtiLCvhQKVvqKZw0gfj1f4BTcdLf
	 1TXnzoeLLPm38cesYhBvjomTlDEnABf3KkjQjTCf+K9n4zIZT7Nus9TMmbLtsqFfa7
	 on3mL/D0Yca9pMjIBYlNfpl2KHS3Y2iLuDurwpHatqIdn1+ZHhsdc0lQqqPzW74kDJ
	 AqynNehV5dGXyWhMjpNffzA69IjItSBRBOwoDOKTWLOxXuvyusnGAEMl4kdFWviTwv
	 y/8sl9tUcmlCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF654C04E32;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: copy only needed fields from userspace-provided
 EEE data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851442684.9417.11313982323041176544.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:20:26 +0000
References: <59bd00bf-7263-43d9-a438-c2930bfdb91c@gmail.com>
In-Reply-To: <59bd00bf-7263-43d9-a438-c2930bfdb91c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 18 Feb 2024 15:49:55 +0100 you wrote:
> The current code overwrites fields in tp->eee with unchecked data from
> edata, e.g. the bitmap with supported modes. ethtool properly returns
> the received data from get_eee() call, but we have no guarantee that
> other users of the ioctl set_eee() interface behave properly too.
> Therefore copy only fields which are actually needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: copy only needed fields from userspace-provided EEE data
    https://git.kernel.org/netdev/net-next/c/8306ee08c0ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



