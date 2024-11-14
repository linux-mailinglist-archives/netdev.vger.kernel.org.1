Return-Path: <netdev+bounces-144676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E59C816E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7D5283DAD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84AA1E7C11;
	Thu, 14 Nov 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aibQ9WsE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF021E4110;
	Thu, 14 Nov 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554422; cv=none; b=ELlkcQmSpMdmvVh93JjFLVat5gLT1jFj1nF1pFPCNuN+jRZ34Szo2FnJfdMJDlCYZ4zxDBmVC6383SQvZ3N/ykkIEN6Qf+VSP4gio2ysbIemazHAj2sGIoNWNXUSSZkZyJoaN/ebwtrrQMB8iAjlTAhak/QGnxrsSg7+lahqBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554422; c=relaxed/simple;
	bh=yd7r6fGq/T405I/Av7+WTKyK6EkNK3GIlm+MbMrN+tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XurMp6LtOsYlOF9GllK6NiOvBU48AYZbSllYm75AemURwDE43V1ldlrCJGhQJo+Co9pL5bIgc9O7TQfQbDYLTv2nwSs49X+/Ebnv26cAwUKxL/M88XbbKCa/m0J7VMuCB0p/9+vHz++d6IfjeM8guXohI3TY9gKdtnYnU8X/5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aibQ9WsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB09C4CEC3;
	Thu, 14 Nov 2024 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731554422;
	bh=yd7r6fGq/T405I/Av7+WTKyK6EkNK3GIlm+MbMrN+tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aibQ9WsELBSPkz7TTblsmwFuH0wTp34BMUm6zRU6v7Y72q0iNIZh+JqONAZREgErH
	 gvPJgjmWg+E+Oj2mMSKO8sAsb9cRVtetkmPkMwt+54SF0eVnl+6nQ+1nlKlcQNq3Ku
	 JyWuMU9hP7HVQkdzSeYgr6GFEv03uFbQEudKd+yqPinm+cGKotViaZF1f36fIRVEW1
	 R4NsF1XJyx+/AmugzlhLVpDl1kgk8zkbVDy5Ct9Jd+2Vw+k84E34nFUgdbK6qNyXe9
	 lcpN9L0AHHG2L2qmANEhSOkQv14fpVEGWYmOjGQ6hDmQhVrk1ZmuOUipC/+SZ5IPZZ
	 BP3RlFJDBXrFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF053809A80;
	Thu, 14 Nov 2024 03:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155443276.1469697.649946285219573980.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:20:32 +0000
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
In-Reply-To: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Nov 2024 06:08:36 -0800 you wrote:
> Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> following code flow, the RCU read lock is not held, causing the
> following error when `RCU_PROVE` is not held. The same problem might
> show up in the IPv6 code path.
> 
> 	6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G            E    N
> 
> [...]

Here is the summary with links:
  - [net,v2] ipmr: Fix access to mfc_cache_list without lock held
    https://git.kernel.org/netdev/net/c/e28acc9c1ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



