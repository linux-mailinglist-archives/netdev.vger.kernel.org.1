Return-Path: <netdev+bounces-74246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EDC860964
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0584F1F25DF4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1532D26B;
	Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmNB8xtj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC1D310
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659029; cv=none; b=SAoRqXPtU8ZdhdgvAKQL3HbkllSXa+QQDp/sud4sydPDfslvuIAWJEWGvzq78NxgRSXrcUPL+TFe/pamQlPs2q8HRwG4X2h1AqcnA0cqDmFzDSKS/egr4LY+HXd5ziS3M9EAhQXMg2Y1yld5CiTsbGKCw8ewOh8Nply9EBlSi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659029; c=relaxed/simple;
	bh=tZtwExmfsT7d+ioXYtSIyvSfZp3Lph00Y2aZ5hzMJFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OwRBxmExxRZuNX87e0nDMl4fB3h4veyQalJpg8dlOoUJ+YMKBWfEU5jBSgKvQILqPy5el/hVpP0OyP2Ccs2cDrtiipm7gkPtffHybygylY+jkLjc++T9jdRHxrKOrZOlPN4pfRpeIg04h/Do0tHQXo9UDtJwuanEg/Lry4BpOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmNB8xtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3540EC43394;
	Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708659029;
	bh=tZtwExmfsT7d+ioXYtSIyvSfZp3Lph00Y2aZ5hzMJFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KmNB8xtj3TMQ0SRR4pgZU+YuwnZ1o4kAYDYEiqPD7T7NoUkwzQD+U5+W9Ag0h4hbP
	 jwNvAWg0wEO9jl//TDWrRtsrV1SBII+YDLVBZuo1Ht+WEWb5An1LI9AJLLDnWeBMGP
	 ECpkO7P6mVYv1oSFiDYIATcccrgSMJc1nZG6F1J6wXLY4JbCKV8HTP6R+ll3FHJ19b
	 lO+bxUXw37rNe3Vd3Im0sraMST/AfEdHG6q2OmwbYl9NWbrfal84zvzZgWVDOt2gc9
	 ojAlWZkn87HMpg3gFHGLl785+8bfmcsYvMbAHWiWiiLnyxyXakMcPI4DrJvA+znXUI
	 Jxn7/XE0q3+8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FA70D990CD;
	Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mctp: take ownership of skb in
 mctp_local_output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865902912.26504.1534942051498825166.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:30:29 +0000
References: <20240220081053.1439104-1-jk@codeconstruct.com.au>
In-Reply-To: <20240220081053.1439104-1-jk@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 16:10:53 +0800 you wrote:
> Currently, mctp_local_output only takes ownership of skb on success, and
> we may leak an skb if mctp_local_output fails in specific states; the
> skb ownership isn't transferred until the actual output routing occurs.
> 
> Instead, make mctp_local_output free the skb on all error paths up to
> the route action, so it always consumes the passed skb.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mctp: take ownership of skb in mctp_local_output
    https://git.kernel.org/netdev/net/c/3773d65ae515

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



