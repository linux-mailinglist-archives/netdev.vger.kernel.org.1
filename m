Return-Path: <netdev+bounces-158043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4ECA1034B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF33A7D98
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094A243328;
	Tue, 14 Jan 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Juh4vZOW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAE22DC44
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848211; cv=none; b=V3DUOeethKBoW90jP5hN15HE+IiWR5sf43vfto7kesQuHpZ1xlxl68Nmy4tdTs7UgR47YZex6QeeoyC7X4GrOUicZWuA8V3d6aqJIF5+n9BMXYskKdb/pSxuoF0FZ2pj1dUgtNnKbTA1FP/xE6/sQ/YWcglYrW1XehS68SQ3Leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848211; c=relaxed/simple;
	bh=G+QhnUfJCIWBYVa/pI461qo/brbWyvOM6zV9Khb/Uuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YiCGXrEWq9ynFMSzaQmJuSwkE0EqdAJBiJYFccSlGb+4KkPI0pdxYpDRe1G4BD1jGySt+wWT/MUz4tgbAMe7y5hn2tANGiqy1LxtoU0jdYzbUCF1rYjyXuMfsrHGOABPYFalFMrVG4Udkiv5ym904UG0EXW5dcHenn+Zk7KI9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Juh4vZOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7820C4CEE1;
	Tue, 14 Jan 2025 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736848210;
	bh=G+QhnUfJCIWBYVa/pI461qo/brbWyvOM6zV9Khb/Uuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Juh4vZOWicANbwwhzYOtXVIHoqBgFSoupC6uU0WkIns4H7ZLx8c6uPwbMn1OWT8lg
	 D89Zc82FN21uPUEzckcMi/7NHGyZJC41qAeVBL3C9hQNr2sigZP3HyGux2miKFdfAO
	 S41zjyfN6XDK7cv0dk3HMcuI0xcHgRN0Lj+te+QoOwf6cKjNzHdM/6eEm1DHC4in3H
	 GDaPpwNRZXKPe9cHIDQVbDmMlbPBhGR0FN20FobAJmNqJVGxysFJPMlef4kMJjNSgK
	 WN0ef2J0HvZ8AQN9rayfGewmy2+T2kxH0AWqdd9ehxdZTv1IpS9Hy2FpvtIHGTeYMS
	 QUmMn8TrjZuPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0F380AA5F;
	Tue, 14 Jan 2025 09:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: calls synchronize_net() only when needed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173684823353.4114903.1861011495450506175.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 09:50:33 +0000
References: <20250109171850.2871194-1-edumazet@google.com>
In-Reply-To: <20250109171850.2871194-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  9 Jan 2025 17:18:50 +0000 you wrote:
> dev_deactivate_many() role is to remove the qdiscs
> of a network device.
> 
> When/if a qdisc is dismantled, an rcu grace period
> is needed to make sure all outstanding qdisc enqueue
> are done before we proceed with a qdisc reset.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: calls synchronize_net() only when needed
    https://git.kernel.org/netdev/net-next/c/88df16f851ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



