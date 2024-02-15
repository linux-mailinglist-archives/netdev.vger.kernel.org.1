Return-Path: <netdev+bounces-71998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878485620A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECA5B2D971
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD4129A8B;
	Thu, 15 Feb 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOTJhC7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8453369
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996628; cv=none; b=QimItK4WPxCRFPkfp3Yli69ve+rispVLCStTneGhrTwQ/XKqtudoNZrXVzMZm1XoMqA58CIuCKOMm4TcV1GTkVggnn80oaNyxcz3cAMrypnAz47GdLdFOJIuThURF9pP3faL0Du+yXiS3rVuTgHMjffi+huDrRvZ4+JPrZ9B8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996628; c=relaxed/simple;
	bh=HO96y2t2B11mtIRxI9YnJjEWhkDK/O6BjJdDofltgCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=roD9C1JOx/PMmMKcsBAkFGhUWy2amN3UjQXTzweDJgFrU9tSdKqy5pxFLK+y1E7uKUfuhmcqu1wXuYFXi0DxJZEuxYwpIwY93GkJqyT3pXdxgDzMbB3S/r54NomHVS7d8zKHHUM9ztZIfpDFFf2yvVHSc8qNGkuIjt2/QoQh590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOTJhC7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E58FC433C7;
	Thu, 15 Feb 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707996627;
	bh=HO96y2t2B11mtIRxI9YnJjEWhkDK/O6BjJdDofltgCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vOTJhC7eQ1VLNiGnj+WcycCNjPCCC8xVNiN+QWff1Pgm5LsxLzbqXhpCr5nvGd/r4
	 XGSZDJehSzw7V+lrC4TjR2WTV1uRc6rqTkcrWATiOCMyOz9QnuGET0H02HWKx7cuoW
	 U0JQwVBUDWzMn1ddyeURiq9GVlHagO/+G8yYwa/VmVQN2b869jKDwEhbR9BYOIjDP3
	 Vw4ZIn3W1PsB8c1DF6AOAQkI4nJlzddw6i77U+c6FnP10/dZrUBHV+fT9nQ3L2vgXC
	 71T8OH1rGIStbsZsqs6aeMhJmhtJBlgbjc3t5OXHAAKIKHRTyQQqJjGMi6YPwwzcwo
	 SaeE9hrA8+bCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65868D8C97D;
	Thu, 15 Feb 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net-timestamp: make sk_tskey more predictable in error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170799662741.6637.15327449318403558646.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 11:30:27 +0000
References: <20240213110428.1681540-1-vadfed@meta.com>
In-Reply-To: <20240213110428.1681540-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, willemdebruijn.kernel@gmail.com,
 luto@amacapital.net, kuba@kernel.org, davem@davemloft.net,
 willemb@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 03:04:28 -0800 you wrote:
> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
> the sk_tskey can become unpredictable in case of any error happened
> during sendmsg(). Move increment later in the code and make decrement of
> sk_tskey in error path. This solution is still racy in case of multiple
> threads doing snedmsg() over the very same socket in parallel, but still
> makes error path much more predictable.
> 
> [...]

Here is the summary with links:
  - [net,v3] net-timestamp: make sk_tskey more predictable in error path
    https://git.kernel.org/netdev/net/c/488b6d91b071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



