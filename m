Return-Path: <netdev+bounces-176810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4FA6C415
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A653B580F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73BE22DFA6;
	Fri, 21 Mar 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQWCTinm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918771514F6
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588397; cv=none; b=mZO6yeRP9g4x1UK63kHZsMZtIsTYBiyViwNFfdZbAwDoflSz3cf4N0Fp/PIGmHSSgcPyaGyNhiEzXGopZ1S9XZr74QbKDWT0fO+Y4Ke/hbcwGKBuKMa6pxOcXC6CtVGuYxprTfeEnbhg9cvY0tSrPKG7nxnSBnZuLj02MA0EIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588397; c=relaxed/simple;
	bh=yqZNUjy++krCOO+lrhhNz4m2xd43LqqN53dGPduYei8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RI4H5Aa/Nxdu8BuumPj14/qjZs2T5kNb1dlcXNxCkQgF6U/RIK1lPQ1/J8nBWt4+fV9It4625oAjBTMl0qrU4vDpAw0vy/VURxV5yGti7Mqp/JWYDJdeX7hfbb9jubWBaWjlJNwTw4m/UYIyI+OjbwcZGYVDORyYdy7GJ8VTQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQWCTinm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA0BC4CEE3;
	Fri, 21 Mar 2025 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742588397;
	bh=yqZNUjy++krCOO+lrhhNz4m2xd43LqqN53dGPduYei8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQWCTinmUDN0r8lHWwdC2kpp3Mlw33DssRHdC91lP5ICCFgmULxBgBF7zJTVTTbD6
	 Iax7WLACYLDe5CJfhTbdpG+1o9LuL3DdFSYJKncpkC3PyOz4vsioTJL+17fDLSh0W7
	 2JvoTawruxWQkKsUpaR5tYJZZ9VTmPgnbd60W7MKdk1j/aJ+13zCo5UreD6sYKr7Oc
	 y/w6E3NDgu2ZTeDcdJspYMaI/ud7yWHlYYARzbiqxrYUZWBtyYRB8q963ijnTO9v8/
	 xediDtQ3vsINCjD2BmA6FRot2bYS0/woPgxm7QF9+jz8x326tqyWKTBwqsAXYFHM8R
	 F7U8igANJtwVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E953806659;
	Fri, 21 Mar 2025 20:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: bnxt: fix out-of-range access of vnic_info array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174258843303.2610773.3170948505080771456.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 20:20:33 +0000
References: <20250316025837.939527-1-ap420073@gmail.com>
In-Reply-To: <20250316025837.939527-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 somnath.kotur@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Mar 2025 02:58:37 +0000 you wrote:
> The bnxt_queue_{start | stop}() access vnic_info as much as allocated,
> which indicates bp->nr_vnics.
> So, it should not reach bp->vnic_info[bp->nr_vnics].
> 
> Fixes: 661958552eda ("eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] eth: bnxt: fix out-of-range access of vnic_info array
    https://git.kernel.org/netdev/net/c/919f9f497dbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



