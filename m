Return-Path: <netdev+bounces-224946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261FB8BB01
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152DD1C05B0E
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968141F130B;
	Sat, 20 Sep 2025 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLPpAT2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C419309E
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327630; cv=none; b=MHJ40ux2x98av7t0eitS6l0j5anHIzTag5QGFfh3ZbO8IU+jAvU7MvwGPktVDL8HElEOolR9qYMw+z4aW/sT5S4cAEFfZGpuMYVSnnwlynELalz1IkqukLgF0aetYsz8AL2rmj0m6cGHrnXelfA8GPJCZJKR25+A5XrCUO3OHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327630; c=relaxed/simple;
	bh=+a1RjflTZvfRu1wM6tSm8faRNy8F0rv6UKNwMOvtfa4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aHcOo+n1lbfdYXeQWqAWC4kCv2Pz2KHy3VTXy2y9fC4NTo9ZgBnJmpClM/DRD9KrkmqHBKsy3olozIGiphL3B2d5li3ESWylJfTNuDUSjjTsA/OUPDw3jGCv8F+q0hPujqkaQkebxxmGrJFE6JfM5Ftyb8/mPTBQG6Ob8wTUedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLPpAT2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CEC4CEF0;
	Sat, 20 Sep 2025 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327629;
	bh=+a1RjflTZvfRu1wM6tSm8faRNy8F0rv6UKNwMOvtfa4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QLPpAT2rSfIE2Ob5rTCXhwAo8gg1eCii86mAv0WZgoLc9kKaM9VmieCSgCBXSDCBR
	 8HdO90XFjN1etcWv0p7XFzw2QNTR/pqnkZB7cHxZAYBmSdEQ6DQWJxBdXSZJv2vMwM
	 r1xFwoHWHq9EOWs1TkIjgFErSvZ8PMxnktlfhnYR4Lw3mVHvyYEKxySqGcwg3Nj+09
	 ZawMNSNNcDCMxndFcjvsN4d1H4X3luKosD4Bz00jjkxZ9PXgOXKl7+e2JAQp1Ke/g3
	 sV1oZtkqYvCXCTW3nJpDwqW2+024TmWPRh/lOQR/7IV2V7fyCPXfE89XOBVaKJJ+Yj
	 BCsV59peeWG+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB039D0C20;
	Sat, 20 Sep 2025 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: prefer sk_skb_reason_drop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762824.3747217.9550799378940882956.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:28 +0000
References: <20250918132007.325299-1-edumazet@google.com>
In-Reply-To: <20250918132007.325299-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, daniel.zahka@gmail.com,
 0x7f454c46@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 13:20:07 +0000 you wrote:
> Replace two calls to kfree_skb_reason() with sk_skb_reason_drop().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  net/psp/psp_sock.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] tcp: prefer sk_skb_reason_drop()
    https://git.kernel.org/netdev/net-next/c/b02c1230104d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



