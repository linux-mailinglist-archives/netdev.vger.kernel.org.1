Return-Path: <netdev+bounces-152465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08A9F4062
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F62116D705
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4361448E0;
	Tue, 17 Dec 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtHUFPzG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66961448DC;
	Tue, 17 Dec 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401421; cv=none; b=VNZQhbMJeAau36gSK4Gsvg+b64FmHYCKXAzC4R4+JIhilC4J0WnpT+MLuQitF6P1bI7surGsI3g5dazowYZEe8vLuuaz/6nhfqIpW7cQVrbYI67qs2x8D/2sVqwqqLoOD3xz89eJFvgtwwMbqhoSO8LwIe0+FpLxrW5VuK7gh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401421; c=relaxed/simple;
	bh=3VW5sEJ1KIn6a7Ti7KDjGaqOKVbVsxpWMnO+UpJZ01k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sm7Wj+opktKIIkwMZGjigLlKDy3tPuHznsPhQXFrWFKMvJOzwfv43L1k7xyc2ZyBldtW3kxMatKAyL2Loh1pxslnS5DtCdrdbTtcTDmTBjb9+LKUpXQ191lkVwIsJFzUAw+aWGPLSb34QA/ELnaqV3DMvTUxjzIuznYgNn4hgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtHUFPzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52982C4CED0;
	Tue, 17 Dec 2024 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734401421;
	bh=3VW5sEJ1KIn6a7Ti7KDjGaqOKVbVsxpWMnO+UpJZ01k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rtHUFPzGKKkuzRptSe4346ErRctvLBrzd779Bl69uUo8UN2p4/fXLFP/a3BLNYdyb
	 Q8/cubuxzm/LYV+nVjyxsiGTztSM0+yz3an+ySg0xDGtAA9XdjMOOAl/ter1GcePAN
	 6yCBpnTItUUVb9SUu0fR/pGMBKvFAD5L2T8w9fKh9ZDddRH2kHv+zedyizQdo1LeeO
	 PCkwAR06xmFfwdeCVVd9c+t29m33BEbipWx5TtqjjOx6KdGRtZZgpLnB2xpTNawsOt
	 +e6ELXcUvoPK0GX8GfR42q25Fyfc27kNWG0nYfh7igwgY2MrnwWW1EQX+p13dtMPcY
	 lAleu/i5VtcsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC383806656;
	Tue, 17 Dec 2024 02:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rxrpc: Fix ability to add more data to a call once
 MSG_MORE deasserted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440143824.415501.3353560173014525806.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:10:38 +0000
References: <2870480.1734037462@warthog.procyon.org.uk>
In-Reply-To: <2870480.1734037462@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 21:04:22 +0000 you wrote:
> When userspace is adding data to an RPC call for transmission, it must pass
> MSG_MORE to sendmsg() if it intends to add more data in future calls to
> sendmsg().  Calling sendmsg() without MSG_MORE being asserted closes the
> transmission phase of the call (assuming sendmsg() adds all the data
> presented) and further attempts to add more data should be rejected.
> 
> However, this is no longer the case.  The change of call state that was
> previously the guard got bumped over to the I/O thread, which leaves a
> window for a repeat sendmsg() to insert more data.  This previously went
> unnoticed, but the more recent patch that changed the structures behind the
> Tx queue added a warning:
> 
> [...]

Here is the summary with links:
  - [net-next] rxrpc: Fix ability to add more data to a call once MSG_MORE deasserted
    https://git.kernel.org/netdev/net-next/c/ae4f89989479

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



