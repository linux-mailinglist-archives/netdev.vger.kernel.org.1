Return-Path: <netdev+bounces-97176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC48D8C9B81
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDDF1C21A00
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711D4F5ED;
	Mon, 20 May 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRPYrDb1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8E12E7E;
	Mon, 20 May 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201627; cv=none; b=N0ht4Cf42mRaUvymLNfwj7o11SqxhLrrNGDkNUbfIJ7ZSxLVw0roJl4Da6nHW7w8l1Yp+nXvzuKkPu841OoyY3pVy4eQ/FgZ33XUf3Apgly+JV6RmZ3UzP1kQWHL1MLrJqmBa58EYD707y9tkY2qI0Aaelu4JLQmhyxGKV2V7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201627; c=relaxed/simple;
	bh=dP1LMsJLv3VJrkeYyGYZNQK44uBs20xMIzE9ILtN+Rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jdSIkxU5m529xNOaVJgzN07c0vl64i3WsY9i35qx7xzJouenTjxCoj/+jka6SoY0Q/vI46YRYd9ac9oUVRvAMNe4wbIDfORGepKnfEYmcER5Bs41rdlh/TZBd7r0RfvsxXq3GJ78gXUCx8/0h0f+eJhTTZWpJfdKajzRvji+vLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRPYrDb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9E84C2BD11;
	Mon, 20 May 2024 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716201627;
	bh=dP1LMsJLv3VJrkeYyGYZNQK44uBs20xMIzE9ILtN+Rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CRPYrDb1RZ4RdC7QK+QXMK1hfIjbomlo9XXt9RqcL7O1fqgzeD1Kk3HDTS7Ob26S+
	 k8Kvu4xddmEB9NFqxpDUXHu5O58eGrTHikR1JF0CpSorK6GNH1IwrOidFHyh5Nt/Ju
	 6IfRGgK7Iz5wQfRRruD9aEyMJAWmw3Y4ZyXwO9SbJbjEGDkKaQow0o1/eCSH90NCGV
	 4aH7YQeiaYGQKNkSYdVkOZcTDIjzIAWv3YPWKs+vwsZaDWkpUX5WYvJ2jPpOLxyRZk
	 PZYh+cqlL+GDof5rYu4jA/29t14B7Vk4Uj9PHLkNlu/wWKfgItNJn1tcVsbPnZjIkL
	 LQb+jimcIhR3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D90F9C54BB0;
	Mon, 20 May 2024 10:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] ipv6: sr: fix missing sk_buff release in seg6_input_core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171620162688.11269.3250559897530538992.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 10:40:26 +0000
References: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, david.lebrun@uclouvain.be,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
 ahabdels.dev@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 May 2024 18:45:41 +0200 you wrote:
> The seg6_input() function is responsible for adding the SRH into a
> packet, delegating the operation to the seg6_input_core(). This function
> uses the skb_cow_head() to ensure that there is sufficient headroom in
> the sk_buff for accommodating the link-layer header.
> In the event that the skb_cow_header() function fails, the
> seg6_input_core() catches the error but it does not release the sk_buff,
> which will result in a memory leak.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: sr: fix missing sk_buff release in seg6_input_core
    https://git.kernel.org/netdev/net/c/5447f9708d9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



