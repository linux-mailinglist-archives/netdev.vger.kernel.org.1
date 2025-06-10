Return-Path: <netdev+bounces-196364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BCAD467D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340343A3681
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770672D5411;
	Tue, 10 Jun 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9cGo6Fx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053D2D540B
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596988; cv=none; b=REBZ8ugjY7yT/iYM8pL7JSu2q2zr4uO6c8BOtDUNjHq+7Mp7w/ktR3+mO4Q3FYx38TMEf+3M9yQeLiJWKkxCDJJDCOxKqMFRxw6yQJpgp6Vz0PbSVjnOSsy+9fKyuQz8aIbIEedjWsCAFXLqZsBsAOg4jRXA4/Nq8JW3UM/u4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596988; c=relaxed/simple;
	bh=clq+0oE4jcdU1aQiyVXXxVOORSCiq2e2uxLNeQzEm1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxamPNUqLljiSUL58Q8mzBeQdE7tpECDH/5rkHzRg9kanJb/03MYHhA384w2i16UY89EZ69RBByygAqGnAN34sCVgcOZQ6DktVZoEh04zEtKzq+W/T42IpEJlk/irfi8LsCtNXKvf67sMd3AMhH3y0p1SUbT9JEWK2wwVfV/hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9cGo6Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A130C4CEED;
	Tue, 10 Jun 2025 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749596987;
	bh=clq+0oE4jcdU1aQiyVXXxVOORSCiq2e2uxLNeQzEm1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9cGo6FxfkRI4GwchhKeNaEjwTxYDYKBSR3UYX4SglTxQD/tbFsiCRQeoUJSOyJQZ
	 yhB5T6siTg3VO1E8Tzh0sWRlZWsWSg+YWnBxbAFvBQetdgGclKCid/sikiBhrfWOZo
	 lDhPP2dDykaF016W75t2h1NP1BghGqqZO5FVuUHTQW4hbth+OehBrUQwKAPutFf/5n
	 6hLgCneJTvYgeBFdfJ4Ylm6Zi0IaC8znQxb6U9Wd445aMzD+SXczVRcABn+ZWFhpFw
	 Ngc2krC13lEj5kEnztIc0XUkG+dJ22AhRYyqik63E5m2/8m3RUe4seyXcrJ0QpUWjI
	 5y6e4gve9fHow==
Date: Tue, 10 Jun 2025 16:09:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Baron <jbaron@akamai.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: Re: [PATCH net-next] netlink: Fix wraparounds of sk->sk_rmem_alloc
Message-ID: <20250610160946.10b5fb7d@kernel.org>
In-Reply-To: <20250609161244.3591029-1-jbaron@akamai.com>
References: <20250609161244.3591029-1-jbaron@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 12:12:44 -0400 Jason Baron wrote:
> As noted in that fix, if there are multiple threads writing to a
> netlink socket it's possible to slightly exceed rcvbuf value. But as
> noted this avoids an expensive 'atomic_add_return()' for the common
> case. I've confirmed that with the fix the modified program from
> SOCK_DIAG(7) can no longer fill memory and the sk->sk_rcvbuf limit
> is enforced.

Looks good in general, could you add a Fixes tag?
A few coding style nit picks..

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e8972a857e51..607e5d72de39 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1213,11 +1213,15 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
>  		      long *timeo, struct sock *ssk)
>  {
>  	struct netlink_sock *nlk;
> +	unsigned int rmem, rcvbuf, size;

Please try to short variable declaration lines longest to shortest

>  	nlk = nlk_sk(sk);
> +	rmem = atomic_read(&sk->sk_rmem_alloc);
> +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> +	size = skb->truesize;

I don't see a reason to store skb->truesize to a temp variable, is
there one?

Actually rcvbuf gets re-read every time, we probably don't need a temp
for it either. Just rmem to shorten the lines.

> -	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
> -	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
> +	if (((rmem + size) > rcvbuf) ||

too many brackets:

	if (rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf) ||

would be just fine.

Similar comments apply to other conditions.
-- 
pw-bot: cr

