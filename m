Return-Path: <netdev+bounces-105901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A9913759
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 04:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6D528193C
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8B8BE7;
	Sun, 23 Jun 2024 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJb2qQp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16A2F4A
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719109643; cv=none; b=FhbQ7XQhTBjkvv8nMEdLoI3rrsvmsfZBa6uyRLYxoExP89q1vZSHFqEa8a2MxsI2hA8wYFsTVOgLlcGSqWZzymdgvF5V0fRS/Rc+mltJMdnofLR8q+SXNp+LnQ00BM4bYoM2oWI6T9ljQlyahBDcHAe5ytxal2ECBBbtIXhq22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719109643; c=relaxed/simple;
	bh=SgqXAk8Hm5czEX0iZgrQnj0VP5t9f4lWoqXfuyySgfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHWPKTVZKrUK+TdiazeoZzDcc+bStWcq8RAR9xZgi/giy6IGzN/ULtLK67fFO1/w1wa2P997GHDaJHMqBrZB8I3FD2DSbWfPB7VKMccSo7+gyFzZA1hNXYvL5cJxKwj6F/cnbwLtIKS05MQvD76ZkOw7s0BX5oSFfh3KBvUFvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJb2qQp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884CC3277B;
	Sun, 23 Jun 2024 02:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719109643;
	bh=SgqXAk8Hm5czEX0iZgrQnj0VP5t9f4lWoqXfuyySgfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJb2qQp7NN50cKt7vdS5XnGyIYbSlk5V/WhnkKfXZgzskp3GlmNaL7n4s20yv2J7e
	 XjAKwTqAw7zYW7LlIBZZIih3OZz5jh/d+64RiGL4bvV/nHBtOjTzFIM/2x17kMet22
	 W/Jdo0tRQxDgYGQmYT4UYmw02+D6EY9sDeSVvhhVdeWErboRvRi/oYqosDpkxVb6Wp
	 3tjN7Sn8sQ3jdPdeEGixurZVqG7rYI1f/gWOIl/aBw37oyjF+VaH9xtTLLie2ziwAN
	 8GCSOudGdGxK4K484NItoHgLJZ3zrmkXLhZI4E0ZSA7hjM/Bmr+jTEVoP37zsItx2w
	 eJCK4uK82ieUw==
Date: Sat, 22 Jun 2024 19:27:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH net 2/2] selftests/net: Add test coverage for UDP GSO
 software fallback
Message-ID: <20240622192722.689abc7d@kernel.org>
In-Reply-To: <20240622-linux-udpgso-v1-2-d2344157ab2a@cloudflare.com>
References: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
	<20240622-linux-udpgso-v1-2-d2344157ab2a@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 18:14:44 +0200 Jakub Sitnicki wrote:
> +	ip link add name sink type dummy mtu 1500

Looks like this doesn't make CI happy:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/651680/59-udpgso-sh/stdout

I'm guessing "mtu 1500" needs to go before "type dummy"?
iproute2 hands over arguments after type to type specific handler.
-- 
pw-bot: cr

