Return-Path: <netdev+bounces-152463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774A9F405F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710441884AD7
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483912F375;
	Tue, 17 Dec 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwW7PFDY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8CE84D3E;
	Tue, 17 Dec 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401419; cv=none; b=RLPVBtwmKkNHWRcb21ADtD92cobOHVGu5OjdpF7xDAfPojyy9JG2lH+L9YjleMioSFfXUvNYZGvLBJVcezda0Z9cAsZ1igY7hwjAy/XiPZu4TxiOOZOOe0bchn+1zD0edOL1y+UFxo2HvVb0HOialIUTsqfJJPgMkmOAg2909mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401419; c=relaxed/simple;
	bh=aolOjUQcPJHcB3TFuW+03z2WhheJd3KPzBZSmEyStvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VOsJhnkVtep4FKF3RaE/OCSz4SFoZ0Ml6w9ETcrAxNXL7q2zhwmjy/Bt8k7cx45t4ebb5kL5mFl2mLH7s7JAtc0wKtnS+rqvEHuL91qxvOpA1Ry6Q/lEgE/LPg3eA40ujzMvrE7HYiBbq5SKGEsgt4L+Bhv/cqHTfbdzXZYmnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwW7PFDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28F7C4CED0;
	Tue, 17 Dec 2024 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734401418;
	bh=aolOjUQcPJHcB3TFuW+03z2WhheJd3KPzBZSmEyStvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nwW7PFDYCNRSNpEB+DhoOVCXjboq+vgDY0foSEkh5Qe5kLqugpyha7YVPHjXxg0qA
	 NgoehhxTER3gox7ie3R1hf6H1eV6+GT+qiyuMuDHSpLr3PzB3u+w5ldmfOk97ocXVX
	 8TXY+jnC9RGhluisS+QG81e1fsdZtjlPpAj8xHdscz1TXDZCdFh07yijQOKdBMpSQT
	 m1U3hDWBi4sulf/1LAdVv+BnrQY0UTc++mgSt6iH5fdmDuc/4ouPSVq21FPJ2cV2Eb
	 cOokM64bCIcW7uX5RhUJx6ef16ZTkAjJfUU4X4THDOn9jRdqvy2bIQ9LnnysrYD7JA
	 m+0KBmmAAhswQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB24F3806656;
	Tue, 17 Dec 2024 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rxrpc: Disable IRQ, not BH,
 to take the lock for ->attend_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440143581.415501.15696101472209767037.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:10:35 +0000
References: <2870146.1734037095@warthog.procyon.org.uk>
In-Reply-To: <2870146.1734037095@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 20:58:15 +0000 you wrote:
> Use spin_lock_irq(), not spin_lock_bh() to take the lock when accessing the
> ->attend_link() to stop a delay in the I/O thread due to an interrupt being
> taken in the app thread whilst that holds the lock and vice versa.
> 
> Fixes: a2ea9a907260 ("rxrpc: Use irq-disabling spinlocks between app and I/O thread")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] rxrpc: Disable IRQ, not BH, to take the lock for ->attend_link
    https://git.kernel.org/netdev/net-next/c/d920270a6dbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



