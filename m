Return-Path: <netdev+bounces-161225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844FA2016C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41503A5972
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42F1DDC03;
	Mon, 27 Jan 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNVWL8SK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241A1DDA35;
	Mon, 27 Jan 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019415; cv=none; b=UFI9aNITzkY+j8QiYNS2tb0rSPC/NTeh9YPinANKPmpjOk+O8OU+unsSBtmKT43qFeVe+7+LyDtHakj3na/zhUKyp3NV2RIeCouuDz99UHOsBiLjPBqpeoJJo+DGhzrGc4XB+zL5HDTBvlYv1QOHNrjjvP8D7HCDQUMW66+tTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019415; c=relaxed/simple;
	bh=AUOeK2J9qB1ieGMXOr8KdvuuVCmWV7mY6qGanLmn9gQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mm3EMZoWSACYD1DoCiTKwT3i6EuGT8LatCmEMDBOdVVutbT3gPBTmc+HH0oBBBAG+xEMYvpUmGKOjOqRsfm+70w1CUqEbfuDQoTNlVFmdEMLBLKMLQiS7n/nw+UIajIjMYBWnuFnJGnw6T/M30eSDRKPoBfdm8+oJdwzc0T0gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNVWL8SK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1622CC4CEE0;
	Mon, 27 Jan 2025 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738019415;
	bh=AUOeK2J9qB1ieGMXOr8KdvuuVCmWV7mY6qGanLmn9gQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kNVWL8SKbItFIZ/mRD7NnFlpQhUNeCTRw0G0VGzSXcSBdSBB7QioJ7nNXl7lCiCiE
	 7khAAyekOR90NU25LmS4POOWtR2tqBs6Wx3vITG/rf7ghu3AMluuJBoopw+T8NktNC
	 je+aOuGTgfILjE2+bEWNboGyby2AIqmsvEGGyNxjXr/KZmzj8qc9kx229R2JN5euPX
	 UYNBqLoMO787nYkICTVDGq4eCFN0usqgf/WUxpSmrEa6oaPkoF/ngTZbyPrR1mtq1T
	 cNKoNtAXwYsqmVE6xaumNT6ybK9jjjhZZyqDV8q/gOnKm6Q0EdT5myrlVPDV54BNDa
	 OMa4vbTzvALdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAD380AA63;
	Mon, 27 Jan 2025 23:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: Fix uninit-value in vxlan_vnifilter_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801944075.3253418.13654964922922414195.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 23:10:40 +0000
References: <20250123145746.785768-1-syoshida@redhat.com>
In-Reply-To: <20250123145746.785768-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 23:57:46 +0900 you wrote:
> KMSAN reported an uninit-value access in vxlan_vnifilter_dump() [1].
> 
> If the length of the netlink message payload is less than
> sizeof(struct tunnel_msg), vxlan_vnifilter_dump() accesses bytes
> beyond the message. This can lead to uninit-value access. Fix this by
> returning an error in such situations.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: Fix uninit-value in vxlan_vnifilter_dump()
    https://git.kernel.org/netdev/net/c/5066293b9b70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



