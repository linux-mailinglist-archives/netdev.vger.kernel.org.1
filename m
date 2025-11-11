Return-Path: <netdev+bounces-237383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B0C49DEC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93A23A998E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C223D994;
	Tue, 11 Nov 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SidOLS0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DE1400C
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821036; cv=none; b=RY3zyXXsQwa8qIFYfnI/5/kzSlDBvb2GCBezFmTRIY3da3J97CCRsezG6tEFas4WrEuCE431cEBX3MbM2fpCgzl83w0DjoQdkJuG8F+ljc4iUOgqoW3jnrpCnEDenmgZBeOsBvx7mj7jDFRM4eNbL/IDUAzRgRfQ2I5vG1+cQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821036; c=relaxed/simple;
	bh=rHHAJYrK+oNAXDF1eBZp9ZW9uMDH16HLdET5qM8wMog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YxQVQOYQ3rFb+I/UL/+JIUIKVz/F5Co+g4xddjbRUK0bpcBqhqAul8dhvolrwdBhXyTU8cwaKcakSXsbEvfBFYvmMg3gWm/rv4VA0uYtXmg/wSmYS/RvT+zxKPsbFgDa6PtD1jxuKF8V2Avmf767tlIXZlwG+pLKMGNfiVLQZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SidOLS0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF69C4CEFB;
	Tue, 11 Nov 2025 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762821035;
	bh=rHHAJYrK+oNAXDF1eBZp9ZW9uMDH16HLdET5qM8wMog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SidOLS0Kl/JMnN01/y8BPdIfqxp/TNMRLeqdGxXTOMOVamL69c0A/+sw5Ns/UQswL
	 TDoOJ2fuFxfBLPAQAdsRmbJe0EpjXxjFkMsY6+AB6iXg+3zAv2Qrmjs3BSolkTLg+U
	 EeZlP+y6mXQN+HJXuwQHdB+bjOVqj3BzbuSPSzv8jKh1vfwIdt+LlK11jD/GLlOu5J
	 7fWdcsgEvcjdPBZHubpOX1Tw8ziSPf6XDcoiWoc3zQIjWH4WrH9niIcZm0FiRrHwgR
	 9j4pTlA9i7j6FhC0jSdaEuqSedRhkPw3OwgXDCOIOZHiEVaS1nxNeOIoqPyypD6Sj1
	 zRWbKc43x6+Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEEB380CFD7;
	Tue, 11 Nov 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: prevent possible shift-out-of-bounds in
 sctp_transport_update_rto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282100651.2823873.12261946208719362080.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 00:30:06 +0000
References: <20251106111054.3288127-1-edumazet@google.com>
In-Reply-To: <20251106111054.3288127-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 11:10:54 +0000 you wrote:
> syzbot reported a possible shift-out-of-bounds [1]
> 
> Blamed commit added rto_alpha_max and rto_beta_max set to 1000.
> 
> It is unclear if some sctp users are setting very large rto_alpha
> and/or rto_beta.
> 
> [...]

Here is the summary with links:
  - [net] sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
    https://git.kernel.org/netdev/net/c/1534ff77757e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



