Return-Path: <netdev+bounces-121148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE495BF7C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654B21F2422B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3251D0DEC;
	Thu, 22 Aug 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNqxS+XO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CC1D0DFB;
	Thu, 22 Aug 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358036; cv=none; b=qVYfBV8A/26YBM1fAG1SaLVQ7CSmMkK21VE/oGWOQQv5l6VFVhDbQQ9Xl5v+DcmmWzaNf+smq2qhxzxPQWkQiA/QzO361LpRUl5kgLfQMsh7e8foVUz3DOnFM8ImK/cGTP1GFkqKqSfV1I8g/ivIkIk98OFWjB3vpff3YMcjs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358036; c=relaxed/simple;
	bh=TkI+gwicm9X9JpS4va+43nk40MKQ1+2fIp5eZKUFvFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CA4MTtdAPBxWTAs+5qdkUEcFgDFFB/hU8VJ5i/QRPFpGjqxOpw2jh3WvAJ7jn3L8zz2Ac6976+8uqEOn3OASWXSH3EAXj44JcJAPsaexyQz8+iJ5GSGAKsDy9aOzX8hM0YGu1T41l7F4ICMorI2AnJ7lpO4Pr622G8r8QwpLFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNqxS+XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C34C4AF0B;
	Thu, 22 Aug 2024 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724358036;
	bh=TkI+gwicm9X9JpS4va+43nk40MKQ1+2fIp5eZKUFvFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mNqxS+XOXm/TKBFvA2it9bPTSoxu1gHiMei9xZ6HYI2lBM9nYQD/gLYU6d3Zn+a80
	 F5T0qXbv0zXRWbPuDfSERF1qpC6M/pFvuiudD9YuPrp19jMkkMBLVONi4zl5FdHs4T
	 fgFP5JHRiyvx3vj1WxbLIAUjWkMMkMfAScFnwEv0qHp5idE05LwMwC5Qz0dT/JrHPn
	 Q/uglDnFWCeCFa+1N8nP1rtAp6E4mqX3YLzNq49bMAJLSSWIt7T4AIITOZqY8xW/5Y
	 yWHr+4jT2H9WU8ZOMiMGYak5awHzq3xaPMzsApDsyfPtza+4YqTDaeKgig80Gy2atA
	 EmjgK/bm0rriQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F493809A81;
	Thu, 22 Aug 2024 20:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ovs: fix ovs_drop_reasons error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172435803577.2470731.17657336110621199874.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 20:20:35 +0000
References: <20240821123252.186305-1-dongml2@chinatelecom.cn>
In-Reply-To: <20240821123252.186305-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, amorenoz@redhat.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 dongml2@chinatelecom.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 20:32:52 +0800 you wrote:
> There is something wrong with ovs_drop_reasons. ovs_drop_reasons[0] is
> "OVS_DROP_LAST_ACTION", but OVS_DROP_LAST_ACTION == __OVS_DROP_REASON + 1,
> which means that ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".
> 
> And as Adrian tested, without the patch, adding flow to drop packets
> results in:
> 
> [...]

Here is the summary with links:
  - [net] net: ovs: fix ovs_drop_reasons error
    https://git.kernel.org/netdev/net/c/57fb67783c40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



