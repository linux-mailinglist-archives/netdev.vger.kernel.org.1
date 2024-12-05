Return-Path: <netdev+bounces-149216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D99E4C8D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ECD1881698
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878843EA9A;
	Thu,  5 Dec 2024 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9un34IZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC92F22;
	Thu,  5 Dec 2024 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368215; cv=none; b=Q6BNQSvHKxMkfZf3cfdehqtcopO3zVZSNqzHQlytardgUsQEpcPdMvVL19ldu7/amRBMnlsXT6sdESXVZKSJwULSmVD2fbtemMAGB2cioul5ngTnPVYCGjLi3yop0lrHiv48A4W35oV0gjVWXgvjkmGhg+Tk9WKjtQqot1b8NMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368215; c=relaxed/simple;
	bh=Q0Zqwi+W+tMMxdrdG4WcjLTM9JVFeBUjyln2Ywvijrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CzdLZaq9nH5gtIFQQNDF/ix68+yRNnpfgJ3TejwkTpCDK0/y1hLBjDaPKIxlyj37J5NGM7KgaKDUWAORIiaRUTOq98AmXenA/nAjyuimLpOmvR5kmd52A8RKppuLr0C3eBH/RMbi0Jd9f3H1BzsrjsslGCmIytcq3JV2GLiuzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9un34IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C4BC4CED6;
	Thu,  5 Dec 2024 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733368214;
	bh=Q0Zqwi+W+tMMxdrdG4WcjLTM9JVFeBUjyln2Ywvijrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C9un34IZoh+rmddxVwZoOds2JxMnYW6kO5HEaNxxEoG8bSCp8CudWxEx32rqaze5N
	 eRxWRTtDWeJUZIo1CPfw4rHUJ/gt4AwJM4dF+e+08SVPQfJGp3vx+P34j2OhAkOlB5
	 evwjz8AZ7a0Ql0m/yJ/XYUfS7OgAhneocCevF4Z3+Xt7wInueZnbmJoaHUMMd1hg+9
	 RFTe8ovHehDQwm8aVZTe5OCjcgzzXiTQom/z5UDKRnPHTvcLfGAN5cEejcp0fftdpT
	 5X4AeWynkKy2xbehGyQfZFfNALR7ZQ7OIoWwmrccdJryo46MmCPhNOUkz0TI5/aDQz
	 KdJ+AvH/BnbLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF3380A94C;
	Thu,  5 Dec 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v2] netpoll: Use rtnl_dereference() for
 npinfo pointer access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336822932.1425191.15392762054831061043.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:10:29 +0000
References: <20241202-netpoll_rcu_herbet_fix-v2-1-2b9d58edc76a@debian.org>
In-Reply-To: <20241202-netpoll_rcu_herbet_fix-v2-1-2b9d58edc76a@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, michal.kubiak@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 herbert@gondor.apana.org.au, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Dec 2024 16:22:05 -0800 you wrote:
> In the __netpoll_setup() function, when accessing the device's npinfo
> pointer, replace rcu_access_pointer() with rtnl_dereference(). This
> change is more appropriate, as suggested by Herbert Xu[1].
> 
> The function is called with the RTNL mutex held, and the pointer is
> being dereferenced later, so, dereference earlier and just reuse the
> pointer for the if/else.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v2] netpoll: Use rtnl_dereference() for npinfo pointer access
    https://git.kernel.org/netdev/net-next/c/a9ab02ed97c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



