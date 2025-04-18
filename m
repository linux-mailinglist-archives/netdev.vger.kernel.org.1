Return-Path: <netdev+bounces-184040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD2A92FCA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50001B62C6B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF3267B85;
	Fri, 18 Apr 2025 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGmjyuQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52657267B71
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942207; cv=none; b=DLajNTzQE1L7eHfVlWkN5t9YNl4vBfGFWly/RcXAlzrhEUa6Ddb3QO80T0YaMaEDgPPOuqAjFIda/LXjFsgecu8ZFZ9HqybnQtY096VCZ3ZB6jcylKht7TwyaL7wjuJ/Sp9axGt2IXqGjlvnXBqAmkcO/IXyQWUAzyrB+7PYtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942207; c=relaxed/simple;
	bh=aXA9NqUlpUBGd6rR5V1g0kLlXLqsLbwk1bDBnbXJuT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WWTQShd+02r5aOtUJgOU+agNhmprg2T90ouBBpf2UR90rO96xRnbSDaKleP0sTlGkOl12pFxuTMHRdRsc8Hb+7rsTijkBMwgMWv551U6VDAlcDkO/7Yvaj6gDYSBPKPXIBUqIpUsrxJOOTc4MQr9DiRDgt0oNrUx57WCpA7thJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGmjyuQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2598AC4CEE4;
	Fri, 18 Apr 2025 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942207;
	bh=aXA9NqUlpUBGd6rR5V1g0kLlXLqsLbwk1bDBnbXJuT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XGmjyuQiRWPg99I8LiB3tpshzlHWprsZdS5CwLap0iSlWS7Mpn3Q3sLarnAeHJ2Lw
	 IRi7LdVs4/ZjRIqt0i7D1BGkoOmSXMH6NMT3EOirjqfsag4VHYFQddeG0V2My5nO5c
	 UrUO/aSP5C/zovGNRRN5kH/VSbxbsjlxMHumURB6KUINY9pE8/vXKZcvhkeCZIsgnG
	 8U1mbGFoaV6+uCSSiB5+dUd7l+JO6mkNImVkMES3JPoNJvadlwYKuTToOL2bfnTVgo
	 JqFA95pzVHUuZFMxse7Y1K9Ar2H/FG3mZYiJfpyhku0k3Zn4aBfIyE58Hy+sXu+5jY
	 LgtdSFQxCu33Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E81380AAEB;
	Fri, 18 Apr 2025 02:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdev: fix the locking for netdev notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494224501.79616.16190776092573800020.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:10:45 +0000
References: <20250416030447.1077551-1-kuba@kernel.org>
In-Reply-To: <20250416030447.1077551-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzkaller@googlegroups.com, kuniyu@amazon.com, sdf@fomichev.me,
 jdamato@fastly.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 20:04:47 -0700 you wrote:
> Kuniyuki reports that the assert for netdev lock fires when
> there are netdev event listeners (otherwise we skip the netlink
> event generation).
> 
> Correct the locking when coming from the notifier.
> 
> The NETDEV_XDP_FEAT_CHANGE notifier is already fully locked,
> it's the documentation that's incorrect.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdev: fix the locking for netdev notifications
    https://git.kernel.org/netdev/net-next/c/22cbc1ee268b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



