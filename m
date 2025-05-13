Return-Path: <netdev+bounces-189941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2DAB48DC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90501467A77
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBF18801A;
	Tue, 13 May 2025 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+z1ZOZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E215A85A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100265; cv=none; b=IIgv1/DKlOS8pCfFpMgy0uT+OLJ6hhnTGGr4grDCp75u2bmFqwiseXBKc9z0GfTFdlgChZNla9VmNPBF0hYPJYIRNSs4VcBxL3xbLp9KiU4kP4GkhUp2s3pzEyDOTcaHDkMCIb1rh3S25qJKOOfxz6V3ku+Ettj23v/P+pQTemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100265; c=relaxed/simple;
	bh=rNruk/x/SB5ra373DIRaI7ZVfD7nymAik4FJeIE6g2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6TyL17dOTYaMF5Aat9FBN4DyeIR1Q9/dcvUVGMMEb9w8NQOX3I0F9ioea58qI0isD/KnppzxXrG75G4lC1Lh3MURpzmfXmIBvrDtA41R0QW7tLckGhYRWI0bzT1nFMSgLSwn15QkTQUhgkb6pxSlvKHqtsKaTxAOSi4lCbD1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+z1ZOZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C408C4CEE7;
	Tue, 13 May 2025 01:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747100264;
	bh=rNruk/x/SB5ra373DIRaI7ZVfD7nymAik4FJeIE6g2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+z1ZOZrKR4JZz6lHlB5b8vQ9i2aTN3Ajl/Tp8ICpzoNmNjms6Pv9zqdovtoiIwmj
	 uTTYrCPbl4CgfQCeFzIwDHExOag4G7ETD86c10bzvk4RVkI4Mf12fAfjumcClu47JL
	 yUW+j2UfLnYYF2GYAV5tbQzsIDaJkd9JFoQAGW0+mS4/UjDhwSir+J9FGXSJBuXUJx
	 1yyqBKQwKiBHbmXOpXNH4OxQcKKtE47Po9SlcdgoV72ZYZQmayUzkA5pJBEEQet/v4
	 J0dEnHzToiQ+hzY23cHipwt341Jvqqx8jJu0u/ml+8FtxPaNX8eWEvd+d/TNUwOkle
	 a9a29jfAk8kiA==
Date: Mon, 12 May 2025 18:37:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Al Viro
 <viro@zeniv.linux.org.uk>, Qingfang Deng <dqfext@gmail.com>, Gert Doering
 <gert@greenie.muc.de>
Subject: Re: [PATCH net-next 10/10] ovpn: ensure sk is still valid during
 cleanup
Message-ID: <20250512183742.28fad543@kernel.org>
In-Reply-To: <20250509142630.6947-11-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
	<20250509142630.6947-11-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:26:20 +0200 Antonio Quartulli wrote:
> In case of UDP peer timeout, an openvpn client (userspace)
> performs the following actions:
> 1. receives the peer deletion notification (reason=timeout)
> 2. closes the socket
> 
> Upon 1. we have the following:
> - ovpn_peer_keepalive_work()
>  - ovpn_socket_release()
>   - synchronize_rcu()
> At this point, 2. gets a chance to complete and ovpn_sock->sock->sk
> becomes NULL. ovpn_socket_release() will then attempt dereferencing it,
> resulting in the following crash log:

What runs where is a bit unclear to me. Specifically I'm not sure what
runs the code under the "if (released)" branch of ovpn_socket_release()
if the user closes the socket. Because you now return without a WARN().

> @@ -75,13 +76,14 @@ void ovpn_socket_release(struct ovpn_peer *peer)
>  	if (!sock)
>  		return;
>  
> -	/* sanity check: we should not end up here if the socket
> -	 * was already closed
> +	/* sock->sk may be released concurrently, therefore we
> +	 * first attempt grabbing a reference.
> +	 * if sock->sk is NULL it means it is already being
> +	 * destroyed and we don't need any further cleanup
>  	 */
> -	if (!sock->sock->sk) {
> -		DEBUG_NET_WARN_ON_ONCE(1);
> +	sk = sock->sock->sk;
> +	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))

How is sk protected from getting reused here?
refcount_inc_not_zero() still needs the underlying object to be allocated.
I don't see any locking here, and code says this function may sleep so 
it can't be called under RCU, either.

