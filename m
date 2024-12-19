Return-Path: <netdev+bounces-153219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B59F735B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001CF16726F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57C195808;
	Thu, 19 Dec 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcrDo44V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAC1474B9;
	Thu, 19 Dec 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579018; cv=none; b=Cwd6ESyGzhGorjOUjdN0fPAMOBkoxpIlYHBLme7b27rEQDs3Eq5LhjzPKWDRODOH3i7/Wl4TxQN4vXuqFhig4qMK7MZtXw8qmh6BAcvFH+8MQ1nFLr36bOod+eIhJ++XSnx8ytUmurcBxzY5nuYFwAJ8qj63+WxDi6P7rvdHXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579018; c=relaxed/simple;
	bh=NPFznDPSKa2dnj/Lq0kX7H2Sl8zYObIx+leUH2oX6As=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pSlnmtsGxrYanYc2fMou0JoIHwgIwkcI6jbb4VsufBlNCaspbHH0ajplWzABAqdAD37tzecaM3UNrv99qIFT07mrz5gXUfc92uqR/5E3zPbYlhctJ1Tbe7X+eoZT+z3msnha6YEjjksjK06XYnIdY5pKK/XwxI7Rnjv1e+xJ/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcrDo44V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55C4C4CEDF;
	Thu, 19 Dec 2024 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579017;
	bh=NPFznDPSKa2dnj/Lq0kX7H2Sl8zYObIx+leUH2oX6As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IcrDo44V8jdvAaEaHUI2Ney5DZKmOtmzN5+FHm5m54uWcmHk2GMPbvCgbHNXKKm1k
	 QhQJug28kqlL4SKq4OL+I1x4J8bNzD7S9Hxp6lLgpT/4ndGo24I3URqzVla5ZlqlJ8
	 OX8vK0IvRbrP8r83P1C8qv+NlrGEEtneJHUkZ4rNnaFFkVadZOqPioEdLiNxE0Dj8W
	 k6rjIL4D9N02QisySIYxEl9xYyrmOSRzs1uR0N0KZf83EK4fDSPiGtk3tvdJMUq9jk
	 Ti2+Mko5Oa99EnVQNefXrLgX7TIVonpsQgzgb1CAV2NNuQmihNP9DabsOdJr3jGwEH
	 IKwCoVxE4sgng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2E3805DB1;
	Thu, 19 Dec 2024 03:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] psample: adjust size if rate_as_probability is set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457903512.1807897.16813300449540359079.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:35 +0000
References: <20241217113739.3929300-1-amorenoz@redhat.com>
In-Reply-To: <20241217113739.3929300-1-amorenoz@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, yotam.gi@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, echaudro@redhat.com, aconole@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 12:37:39 +0100 you wrote:
> If PSAMPLE_ATTR_SAMPLE_PROBABILITY flag is to be sent, the available
> size for the packet data has to be adjusted accordingly.
> 
> Also, check the error code returned by nla_put_flag.
> 
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] psample: adjust size if rate_as_probability is set
    https://git.kernel.org/netdev/net/c/5eecd85c77a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



