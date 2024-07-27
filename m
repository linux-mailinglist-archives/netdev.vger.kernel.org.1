Return-Path: <netdev+bounces-113329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801B93DD0D
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 04:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04B3B2293D
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD8110A;
	Sat, 27 Jul 2024 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUWkdn8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC39186A;
	Sat, 27 Jul 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722047645; cv=none; b=luAg+7MtEes618/ohMiUNz9cKjUCs4hGnfphJSl5btrgh8mBtULZPeNABCSoUYcY40csYS9DXuhef72algdEdDUqCLkHFHXdvu14cVNOBchsmf+aUcq2eFwgRL4DCTE6EggBuRRUrp7VUCLasUsRPfBu/y2Xvf4+SsZlyQfm9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722047645; c=relaxed/simple;
	bh=WUGzS0/4ok9IVp5S2mYYKhHHy6u8mJnjJT9e6i7ZlA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1CdWKhtELgb8sv+S6yFE9hk1GBs9ma6pM7NcGrZel6YpaHGyT7zi64eXV2LNh7IDFrdR58KBBe7fDMoJnkQhpDVqCjFkts29Q3I2GuwjrheclcxtZr/fpVIUXUvLEFCj4Mquns/qnkICtdkR/KuwMd3bUj/Uh7Ad1BaT7JhZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUWkdn8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371ECC32782;
	Sat, 27 Jul 2024 02:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722047644;
	bh=WUGzS0/4ok9IVp5S2mYYKhHHy6u8mJnjJT9e6i7ZlA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UUWkdn8sjE/jgmd7RlaORqpQw1noC/mQ9RNTFvGXz7+TFi0F1RtdAwGwX7T1tLPpO
	 ATxVOKMx9NCadWsfY9RzDGLiZRaLNU8sGJbKheavpCvbokLok82jHY6/ueSEJAs+4y
	 qqnEAjp9vOq1locqk1UMd+TjXOrhKuitSjuGKrEm0eBGRVv0s7BWn+RMXF39dOVbQi
	 K9bDG3iQ//0t3lLeU5AkwawqzD/Va0LjX8sJUyNLtJ5qYqQN/LpfG18O+OmYkG4ms/
	 qCzqp23yITv6JsjT2hT4gi21jmGYDl2tBmkVSLqtIAr8oV0dIZiMv9K3d3Q6B20x/1
	 OU6J6uRnm1Rtw==
Date: Fri, 26 Jul 2024 19:34:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net] net/tcp: Disable TCP-AO static key after RCU grace
 period
Message-ID: <20240726193403.1b15a2af@kernel.org>
In-Reply-To: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com>
References: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 06:00:02 +0100 Dmitry Safonov via B4 Relay wrote:
> @@ -290,9 +298,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
>  			atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
>  		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
>  	}
> -
> -	kfree_rcu(ao, rcu);
> -	static_branch_slow_dec_deferred(&tcp_ao_needed);
> +	call_rcu(&ao->rcu, tcp_ao_info_free_rcu);

Maybe free the keys inside tcp_ao_info_free_rcu, too?
IIUC you're saying that new sock is still looking at this ao under RCU
protection - messing with the key list feels a tiny bit odd since the
object is technically "live" until the end of the RCU grace period.

