Return-Path: <netdev+bounces-133156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA194995211
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BFA1F2582D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31A1DFE32;
	Tue,  8 Oct 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHvboVC2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0331DFE22
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398432; cv=none; b=nYh+yeff4sYZvyOtBtVp9Ao5BN1UNbcecwX009AJF8I2UPGIG9b2NyAGleZLlmHJweekM18FpAoLsyUuQPIcrWWphpFsrZJB6s0VcoT8FfqzgtYiD0fxGi/URULIHxbVF/st8ZmCA/WzjuSOBDdgR8xTefaVbR0fuecZytqpGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398432; c=relaxed/simple;
	bh=8wqFyqHm7M3uJx03nvVdrgiT5fFTP46r31V5Y4tPPYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+b7nUNBZo3/wd9Gczq9WOp061MT3hCq6v0o4d3gCQR3Kiuqt0tK5CombY8Nk1QbxsGLLCWzt19HALkdhEg5mM0qxeULO8j6e5GAsDWyfeYrrkTWqy/TNOo/HSS5C8Z3+s0yP4PXGe//fdlG6arzbqJ+8+nhrbgy7z6eDAFVD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHvboVC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D15C4CECC;
	Tue,  8 Oct 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398431;
	bh=8wqFyqHm7M3uJx03nvVdrgiT5fFTP46r31V5Y4tPPYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lHvboVC2hrsXFV6zpsqteh0fJmD3VFz0HsfnHAksuQymQQH75WMzDfpQooKmPO5l1
	 5Ee5W0KeeuW+4stmz0N9jy5+FNHb6Gba/z1d2O+qZqzFz9ow+I3lC6O4PwiDIHo1Ga
	 KmbGU3SPQZrTD/UmQnbo7cduptPlJ+2I5ps4kA+Q6yaYxxqMQpx1ADSVWuEuaJ8peJ
	 l9Es9RmUwuop4QxQ/W4PSDbQCqL9KRw1mAMbUMSHAl0LYfjAR0rIe0jA92pXpLuYDt
	 Y7tVQTVxo5CrZc7zCksKBtxNTo49wKGzIU9L1rjLe6Dh25eGl3Pe8rcGIeMAGh83EY
	 wfnJKfGplQ0LA==
Message-ID: <fa6a9964-b8e0-4ecf-975e-04d8760db1de@kernel.org>
Date: Tue, 8 Oct 2024 08:40:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: switch inet6_acaddr_hash() to less
 predictable hash
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20241008121307.800040-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241008121307.800040-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 6:13 AM, Eric Dumazet wrote:
> commit 2384d02520ff ("net/ipv6: Add anycast addresses to a global hashtable")
> added inet6_acaddr_hash(), using ipv6_addr_hash() and net_hash_mix()
> to get hash spreading for typical users.
> 
> However ipv6_addr_hash() is highly predictable and a malicious user
> could abuse a specific hash bucket.
> 
> Switch to __ipv6_addr_jhash(). We could use a dedicated
> secret, or reuse net_hash_mix() as I did in this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/anycast.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



