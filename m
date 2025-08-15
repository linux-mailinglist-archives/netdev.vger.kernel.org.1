Return-Path: <netdev+bounces-213894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C88B27447
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C46189CE4D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813560DCF;
	Fri, 15 Aug 2025 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kilzjN4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D513595B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219013; cv=none; b=TTi36POcaCWR1gInVy/Ix2uAtn9aAy22cRTl4AasCsQSxKldnx1ViX7Gv809Hw4SeuYzNEO2YSeTyVpTBbPZn9opTRllNe9M/yuUZHNbzqpoKI4zkIzxtguGD9e5DYHgVfyGpsGNkL7Y+2q8f1b+9VL7MIxbtlTS4BOi/4rSDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219013; c=relaxed/simple;
	bh=g5sfBB+8wm+QzrL4fd0Fu1o9NJK9Iqu6DIyVGvdZLZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H91LWG/V3blYtdUgh+BO2/QzN/GW1iyOfHzzw4m950THYl8mGhOmHLYH+2w/CkUAqQzrg7xTq4pl6CKoIX9XbE3EJvDLgnCXkYF3MPKHLkbBdpTPJVl4gbPVv7pd66NhxIVtlSgKFbqwzfvFqu9fTtMzUFhUz5UeyZlpIWQKyxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kilzjN4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20AAC4CEED;
	Fri, 15 Aug 2025 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219012;
	bh=g5sfBB+8wm+QzrL4fd0Fu1o9NJK9Iqu6DIyVGvdZLZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kilzjN4zEVqTe9tQjptp/LHY7GB0SKVZCzYbYC29Xxpxj/BlPQbA+OBUuER4MFf7H
	 XUjFZIt/Qw24yMaDPYfpKkVD1FgPFZe4MfxrgJZM2WK9Qi3m/vW/+H7i4YeekYsDQw
	 8c9szoyiKLQb01XAl0EhGqF/0RGxN2ryMF9CHHk+A2h4viaxaMEwe584WBpDd03cOa
	 RpF9q0/qg9KMllnuedPOpZQNp1VnvIzsklyntiiCRkQ8jFG+qLg0nujW3tcTALdDNP
	 y/n91dXnTT8XQpwn8lafyqBJwIPpmnt7UBQ9VD3tCJgaJXbNoVHsVLuo7ChGwWV8np
	 lTpw74damNlvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4B39D0C3E;
	Fri, 15 Aug 2025 00:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bridge: Redirect to backup port when port is
 administratively down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521902398.500228.4413563447477304609.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:23 +0000
References: <20250812080213.325298-1-idosch@nvidia.com>
In-Reply-To: <20250812080213.325298-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, petrm@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 11:02:11 +0300 you wrote:
> Patch #1 amends the bridge to redirect to the backup port when the
> primary port is administratively down and not only when it does not have
> a carrier. See the commit message for more details.
> 
> Patch #2 extends the bridge backup port selftest to cover this case.
> 
> Ido Schimmel (2):
>   bridge: Redirect to backup port when port is administratively down
>   selftests: net: Test bridge backup port when port is administratively
>     down
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bridge: Redirect to backup port when port is administratively down
    https://git.kernel.org/netdev/net-next/c/3d05b24429e1
  - [net-next,2/2] selftests: net: Test bridge backup port when port is administratively down
    https://git.kernel.org/netdev/net-next/c/51ca1e67f416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



