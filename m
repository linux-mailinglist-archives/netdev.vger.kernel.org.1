Return-Path: <netdev+bounces-147701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527889DB46A
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B0BB22B8D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862C41547EE;
	Thu, 28 Nov 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqkt1n8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176A1537C6
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784421; cv=none; b=fvfLFO7rcjsjABa7UcR+Fh47kFMQOBonll8FzYEd5dELb+ylgRPn9C3DzD7jdp0ilHmnoIPD0Tcqp/9V+kp4FaDDC9tRou7q2NDui67FLOpcfkk8yBOpchywTGUE7mI8fYY4BJzvfF8Ay8MqgLi7CTz7I8RVSsEhbzlMkj1pY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784421; c=relaxed/simple;
	bh=7+D2u1BAc7VSD6WReIeUIHXKsbIS/pOUlebyT67Xcno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qhx27pr9CjiZFo5u0TAq7neT0AXBeagcRuZzUg+FSkxwU0VXlRBD+if+Ma3SC8tHVxihKGw7430qAl9e8BIMEuX8M94qodURox7hRCeFOpbpspMnqQOvol3f9jnkNKQLKgMHRGYbzK8PSfHtONrKA6HH3sFlUxQLl5OIrnrf3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqkt1n8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C269CC4CED2;
	Thu, 28 Nov 2024 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732784420;
	bh=7+D2u1BAc7VSD6WReIeUIHXKsbIS/pOUlebyT67Xcno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wqkt1n8zP+bcfSqsndT+FmYkkEwFphqcZwPWAj/+sdkaH8wgnYsFif8H/orJDujT+
	 xDRar/ZCD4wkutFyTskXDFJTvSt2IagxlwoTLNdARAbdHrokAsYRHLqGJIS8YqXQHU
	 IrggFoz/f4M3jtWg/jgXshPSy0LWImIwR/ko5nnyvKAxhLkmXnLSErt80OZD8H8vxJ
	 na4OhmdvEJGXlQ/VMXQntQ8uQ7GIOlnemcLsaJ8HxC4MP6MCrcxc9Bs673FKJyxqER
	 4F1NJ6pHI05aPz1yUA0gtcfUF4NeytnEfz7ml0l+kxdgvk+Z5E7M3WTWY6GHE4W39m
	 71yDX0iWY7B6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34541380A944;
	Thu, 28 Nov 2024 09:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Fix use-after-free of nreq in
 reqsk_timer_handler().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278443403.1668601.4134040578720720822.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 09:00:34 +0000
References: <20241123174236.62438-1-kuniyu@amazon.com>
In-Reply-To: <20241123174236.62438-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 liujian56@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 23 Nov 2024 09:42:36 -0800 you wrote:
> The cited commit replaced inet_csk_reqsk_queue_drop_and_put() with
> __inet_csk_reqsk_queue_drop() and reqsk_put() in reqsk_timer_handler().
> 
> Then, oreq should be passed to reqsk_put() instead of req; otherwise
> use-after-free of nreq could happen when reqsk is migrated but the
> retry attempt failed (e.g. due to timeout).
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Fix use-after-free of nreq in reqsk_timer_handler().
    https://git.kernel.org/netdev/net/c/c31e72d021db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



