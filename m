Return-Path: <netdev+bounces-152468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4729F4085
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0BA16227B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039912C54B;
	Tue, 17 Dec 2024 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi+mqH2T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482670827;
	Tue, 17 Dec 2024 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402015; cv=none; b=kmcmDAoqham/SjgDeye/DjlTUQZuzJbZ5YjuptUO93uMKR8/t9Dq3DOALhdOYXb345mysedPsPhmMrq1uTPGrVn0dIUJUML2dzT1KnQFt6tfuUJm9YzjFRo8p50y9msKKAXlui29XbQjq4vh+x/zaOAcexbDEkGKn7/OHLo1+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402015; c=relaxed/simple;
	bh=n7CaTJOp+NRFRkoP+aaLkQZqBL3ymC1rPFhgna7nj0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JS4WXlGqBsiSYuS+a6f/IlF5d7KCgio0TukqD4ThklCDUnQu40f8ybs6Q5Feqbr2u0/RAVxia3hLFv+o+FkD4a7cgCF5E63OVMdZohMpEk5lu39426Dn4BfC5V8kLHBwmvn0VFdC3Xcl3Yf/DSZiNkl7wkDoKwqT1GAnBnEtA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi+mqH2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474F2C4CED0;
	Tue, 17 Dec 2024 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734402014;
	bh=n7CaTJOp+NRFRkoP+aaLkQZqBL3ymC1rPFhgna7nj0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zi+mqH2TzEl/x31yrYS/WI68L6wG0UayCRvkhoDebw902/kmlCIzV2O4+aHg1sv2G
	 ZYAb4awofXdfILW+CvBs7ekxoCCONiEjZWTJ9Vx0gmF1jWyZCpoh2b28kdU2SFG2F6
	 03GI30YWB8YrfQyYuYvdzTVx4S3KVJfIegp6lvDcYUOSB36LbcS+2I4AWXrSV5Yhyf
	 bpWSU/YzElBqsl1pDcQsszXtFDxJ9yqMHwRltwodn3rChDH7zvuE8QG6qEM3DMdbFZ
	 RJDcZ6W9JyiNp30EdL/uTJUYj4JKKKjhiXkuiwNFDuq4YPsbRPdExpVssZEgIrTt+L
	 biyE5/J9f6TSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9F7163806656;
	Tue, 17 Dec 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] chelsio/chtls: prevent potential integer overflow on
 32bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440203151.417803.17558200798224826958.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:20:31 +0000
References: <c6bfb23c-2db2-4e1b-b8ab-ba3925c82ef5@stanley.mountain>
In-Reply-To: <c6bfb23c-2db2-4e1b-b8ab-ba3925c82ef5@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: atul.gupta@chelsio.com, ayush.sawal@chelsio.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 green@qrator.net, horms@kernel.org, werner@chelsio.com, leedom@chelsio.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, jgg@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 12:47:27 +0300 you wrote:
> The "gl->tot_len" variable is controlled by the user.  It comes from
> process_responses().  On 32bit systems, the "gl->tot_len +
> sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
> could have an integer wrapping bug.  Use size_add() to prevent this.
> 
> Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] chelsio/chtls: prevent potential integer overflow on 32bit
    https://git.kernel.org/netdev/net/c/fbbd84af6ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



