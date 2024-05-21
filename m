Return-Path: <netdev+bounces-97314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0828CAB88
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CFA282905
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424F6CDD0;
	Tue, 21 May 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSTaiM8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909616CDBD
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286229; cv=none; b=AAczFJDW4aZ8evW0ecbTfKHbYe+s1zppfsRY8ilH0RVwo/1IpSxYDbpbjf5u299uGdqYDiO3+QrF6Uimbz7647cC/iVnCmnRIjMdyhF0n5LS6H4sNwpWIRHMhrdmRXk5xV74gr0h9JUXQpJQX7rjqubL3YrGxOCNBpXC7HtHo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286229; c=relaxed/simple;
	bh=TjJ6Xc2lw1xumu+o9ZZ7ipzDZy+ngsvzPUHL6OKjqfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mYb1ujGAy0p8xsApqIRwHeOLH0CS3K99HJbW5KMG1GADkGZbI4GJwGpy5+112VuaeZapEO7mrzCokK1YVDm+hqkiCVNfOu96DyM3V1m8YneYOAGcOZWQvv8J9enykiOnlP2otalwlb61VttolfMhSPY/3ItzT45eunUxwxwsm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSTaiM8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18C68C4AF07;
	Tue, 21 May 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716286229;
	bh=TjJ6Xc2lw1xumu+o9ZZ7ipzDZy+ngsvzPUHL6OKjqfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aSTaiM8Ayc1ZqYpPKFOWMnIbigVPJd5FSnZU1qfwv2yHwC639lctRlUKMPvQS19IV
	 HSXUYUGxHpOkvK5YjxF4MwMkPS2YaSmUH0lr0AfiWXoJX/Pf0IyacilwWO10dDhW2v
	 glw/c/RmYDxY/Tmg0pFXVQalF7SOHnniG6s0hstMLg3JJrKJwVLGYxD/X/joIEnDL6
	 85cvbabqL8FLr+f8dgAc+mpPOchB816N1Ts8503ulldtY0N4Wzr/x/F+v71Lhtgyxy
	 2RB6Wh7p2aI6v+Kj2KlwxpPol/dcZtgryMdmWnzBkDVaa7B+c8Uva/et5QC3Kbqwir
	 YSEKOePM4YXrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05DD5C54BB1;
	Tue, 21 May 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171628622901.9229.14757241708226262407.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 10:10:29 +0000
References: <20240516134835.8332-1-kuniyu@amazon.com>
In-Reply-To: <20240516134835.8332-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, mhal@rbox.co, netdev@vger.kernel.org,
 billy@starlabs.sg

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 May 2024 22:48:35 +0900 you wrote:
> Billy Jheng Bing-Jhong reported a race between __unix_gc() and
> queue_oob().
> 
> __unix_gc() tries to garbage-collect close()d inflight sockets,
> and then if the socket has MSG_OOB in unix_sk(sk)->oob_skb, GC
> will drop the reference and set NULL to it locklessly.
> 
> [...]

Here is the summary with links:
  - [v6,net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
    https://git.kernel.org/netdev/net/c/9841991a446c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



