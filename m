Return-Path: <netdev+bounces-169691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88206A453E7
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFEB1894B7D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF824256C62;
	Wed, 26 Feb 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhIrYCDc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5D2566EC;
	Wed, 26 Feb 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540008; cv=none; b=p/Z1r00pQAfjK3Uk8tr6z7NlgmaStFR21X+3KwJw2vHKrkyd8s0EVWr8gBAyewutIEyXg3l/MFZxpSb4cOrD/EeX+slGXQ/pX+Y90xVgrUutyMoQDfVnSENTiWDgswGmzpmU293ULU3ST0zrBVIJUCQlhG0ZGm1CyotCTegCqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540008; c=relaxed/simple;
	bh=WQpRlPiUCAU20AwWw2u3/hTEdVdZJsd32jZ3Wv43t70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QdfWQRXcjNEGXWqkdNPMSOwfNj2VzGo5I+OjDNE4WF3yRRwKD1sZWBuowM956d/6hY6cAdTMP2NuuTy2FChxsswt+tFWKzJGxLRtkPi2QFo67w3wq/V4VJbTBgcsw4TKzndctxMtrmPCq55n2ealFkFg6Ju11lUlyIvkdWTjdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhIrYCDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C68C4CEEB;
	Wed, 26 Feb 2025 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740540008;
	bh=WQpRlPiUCAU20AwWw2u3/hTEdVdZJsd32jZ3Wv43t70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UhIrYCDcc4Yjx0Emt5ICdQ202BLfgGOLHoZV0GbzYZgckQpbgUCs3ZbQ4akqZwlKq
	 GPZ0uD3um7Dhvf5aWQr8Iz2nfi7ZrGO2Pb5q2Z3F+uRV9Csu+/+PmuWe2HbUKrklIF
	 qTZTJwopyH8WpZKs4mRRUsZ1VYdwAIicuRzjOTXlHSTyMJxeHJRmA4tngzIpoOGSuj
	 U1OSPMpk5PHJQWDUjbRY58Ai7ssjd1680pPT3MGL8Smuf+P+p1KbflG9R7ws7sT6rw
	 b5omLVLKe5HAtxXClq/R88jCX/LB4lpDlJQG9RrRzkdqf61zW9GLOGN5s7YWMn6vNi
	 5ef6Dz/14Rc+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D94380CFDD;
	Wed, 26 Feb 2025 03:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] tcp: devmem: don't write truncated dmabuf CMSGs to
 userspace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174054003999.219541.1372303468063333953.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:20:39 +0000
References: <20250224174401.3582695-1-sdf@fomichev.me>
In-Reply-To: <20250224174401.3582695-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kuniyu@amazon.com, willemb@google.com, horms@kernel.org,
 ncardwell@google.com, dsahern@kernel.org, kaiyuanz@google.com,
 asml.silence@gmail.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 09:44:01 -0800 you wrote:
> Currently, we report -ETOOSMALL (err) only on the first iteration
> (!sent). When we get put_cmsg error after a bunch of successful
> put_cmsg calls, we don't signal the error at all. This might be
> confusing on the userspace side which will see truncated CMSGs
> but no MSG_CTRUNC signal.
> 
> Consider the following case:
> - sizeof(struct cmsghdr) = 16
> - sizeof(struct dmabuf_cmsg) = 24
> - total cmsg size (CMSG_LEN) = 40 (16+24)
> 
> [...]

Here is the summary with links:
  - [net,v4] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
    https://git.kernel.org/netdev/net/c/18912c520674

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



