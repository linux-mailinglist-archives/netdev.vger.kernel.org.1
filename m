Return-Path: <netdev+bounces-188806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C6FAAEFDA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB9A3B920E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479ED4A21;
	Thu,  8 May 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebyPfbU4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F378F54
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746662989; cv=none; b=dNBH/+5sk/39Hlr4d98g3iJDFB6psMRulhemAixcJXLn9LZCTUjgHXx0tM8HM1kXZY8TWNdzhhzYePPhv/wqRdh7RkABbfhoIOEBsQjzyKIEeFqK1JtJbTEKK1y52OBleZ8/GUUWMIw7wKS6HMz9H90UTAaaAmrdUpFibrItPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746662989; c=relaxed/simple;
	bh=Od8OW0JLhIuFrXA3QM7xKasmXZpRaR18WotNXlHqEeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3LziCJw95yOeuwzTE7QSYCXEp+OlMLLi1vC+62QrBXm8Wpnn85xcPfkDpk2qr07lkqbMTY5fK+jtc4UfD5VeVpoP3ByIXnhLxgTQ5e3Vi5DLrv7pnXoPobvopvLNBINmMHe3+tFnurplwagInUEWzaQT161Nfpah5Snl/14C1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebyPfbU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F9FC4CEE7;
	Thu,  8 May 2025 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746662989;
	bh=Od8OW0JLhIuFrXA3QM7xKasmXZpRaR18WotNXlHqEeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebyPfbU49hqVqbWdoJC+yqVxhjo6hWY9n8XttYko8MUaNSEb4jJcf50C+lZNWtOUu
	 IM9DqA3wn5N2LrpKN7/ptbRhboEZcz+T1qahsLMwm9Fq7Qjf0RIhHePiER7KHNMGGD
	 GgTu21ECoyzKEOhjTnzrPolhzkZXUNt7o14HwIzMWQk6y/yiAfFpzUOkbvGwrcynbu
	 f3H2LpJiV9Tb295Rwd+Fh1re3UiAA+GRBKVZP0t7IzcmEfS0izRHWlL3GF5HqX8CPQ
	 ZydI+y7uqGdT+EXxpP0T0aYX7JNY6puy/J3jwsaVgKfLbOF+MmiCf+nCSCowbMJGZU
	 oBe6s1HICQOpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD15380CFDC;
	Thu,  8 May 2025 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: Fix unsafe attribute parsing in
 output_userspace()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666302775.2402616.7770603426553083227.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 00:10:27 +0000
References: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
In-Reply-To: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 May 2025 16:28:54 +0200 you wrote:
> This patch replaces the manual Netlink attribute iteration in
> output_userspace() with nla_for_each_nested(), which ensures that only
> well-formed attributes are processed.
> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: Fix unsafe attribute parsing in output_userspace()
    https://git.kernel.org/netdev/net/c/6beb6835c1fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



