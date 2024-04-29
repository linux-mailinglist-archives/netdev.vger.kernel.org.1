Return-Path: <netdev+bounces-92058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A28B539D
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D081F21CDF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149B1805E;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxwK3pey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DE17C72
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381230; cv=none; b=lYxK+vLL5CgpFKFF7E3ScWmhQa78iDjskzaSm+9xVf6TEm6GKvvRHiHdcJWJqgjmSJyRf0jZNWFqWOHzIMy7Nq9qsVd5GIEPt+3RHXr8Y1WqdqyO7OvlejcRtc1+ef7bga4fh5J+N/OnC/JbbAyOSqPcCvSxS4K5Sco0z4fo9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381230; c=relaxed/simple;
	bh=CG5pIuo5p0V9KncnKjZEWQu/0pBZmxqYDWuIkMdGx3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EYVZQHx0VZw56+b4a+Hk5aJRK8B88BE0so4LIXEBZTAyDoyOM3cgNtfS4V13rj7ywSJEkc/qcTrewfyokc81nTZrp9SRnlknu/K5wMB5O7sBnXX5edxgbxGWCaXnXOikf14vfUZZuk2Vu/aDfWEmPNamHTct5hq/21z633aJKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxwK3pey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F439C4AF1A;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381230;
	bh=CG5pIuo5p0V9KncnKjZEWQu/0pBZmxqYDWuIkMdGx3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxwK3peyfDmoLezEH6SgRNVzCKuSN7rp3UqZQXspTrhQ1oObAzLJ41oGUara8MxSr
	 ZUrrmTZxiVTjNDqHFNZh38eZBwM//sjxbmMQnYKD6Yx/WW5qTjRf/1DEcbDYOEeVxo
	 JB0LkIxmthcQ15fYz+iA7//MO3MlTWgWqfTPbPyjpk3pe58AhpMTOqiAtEMTbAZRce
	 QtrtpwkXJMAgXQpWNWZomi5HHViTgTeU1Lp8BLll+PXCyk9Vw40w85tuZKGw2MrlbX
	 Mk75hMQ0WFnn/dR4KEsVLP9g73s1wMNsq53NzALWudtP3qn3gF4nRf+Lqu4DeizO/y
	 2zw4xVsPkPXtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D78FC4361A;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: give more chances to rcu in
 netdev_wait_allrefs_any()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438123044.5873.9404991094113699100.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 09:00:30 +0000
References: <20240426064222.1152209-1-edumazet@google.com>
In-Reply-To: <20240426064222.1152209-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 06:42:22 +0000 you wrote:
> This came while reviewing commit c4e86b4363ac ("net: add two more
> call_rcu_hurry()").
> 
> Paolo asked if adding one synchronize_rcu() would help.
> 
> While synchronize_rcu() does not help, making sure to call
> rcu_barrier() before msleep(wait) is definitely helping
> to make sure lazy call_rcu() are completed.
> 
> [...]

Here is the summary with links:
  - [net-next] net: give more chances to rcu in netdev_wait_allrefs_any()
    https://git.kernel.org/netdev/net-next/c/cd42ba1c8ac9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



