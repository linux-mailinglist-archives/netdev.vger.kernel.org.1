Return-Path: <netdev+bounces-177952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7BA7337F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3144D163527
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AC215771;
	Thu, 27 Mar 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga1mIy8c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145F2628D;
	Thu, 27 Mar 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082896; cv=none; b=HeFwRIeVQ4th2kl9Ou4DMeXQv3auhmn3Yj0Pb8eJlWw29zvMPKbGPtFuQ4h/agkvPHNs9XziazmD24cNYM7r+x7R+ffzOrTVAJDK3lFLRAeU5OiGxBitonwVh6bCozg4bwzSI3vP0sdRn9ivtsDS6Ib6PiuOrPhNOfeiRSy5Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082896; c=relaxed/simple;
	bh=/77T7Lxp7mBP0JQr0B86ImNOJdM4Z01QHPbpOkOEm0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db6Z08r+F6rIJzt2p+mXWXnqcVfzUuVEctginpXjEwVps0YzLNrUzqJ816B6oZnJl/WSLNp7xzGCQMtzhGQb0t2tbyxHHbDmYnKpfFswR/B51qWZj59atgW4um2B6yr0y1rNpLtT9OO8gsDpOv3ZXRY+Fzli47UTmAWWJmhfYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga1mIy8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA50EC4CEDD;
	Thu, 27 Mar 2025 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743082895;
	bh=/77T7Lxp7mBP0JQr0B86ImNOJdM4Z01QHPbpOkOEm0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ga1mIy8cGEIk89zLS4NbbA9rUH+C9q71xUSi1GZJEfGvHKxXi4I5npIB16IAfmV5Q
	 hEXh+oUDf3lOT4H0vayRWf7Yzbm5MLQ8ejy+v/QZbvf7f4FKcpSo84Esm+h7Q0NE/C
	 1Ct4RHd+vhUH5VCcDCP3kR37sxxsTAUKjPBgiEwLWnEcmMbByje98H3cqXsFy6yv45
	 orGKcfQvQ0sBIOb6VYjjkua9wiZ8v/z7TUilnvRYyqEv5ZQBa+Lp3DX8nwUm50Uvmb
	 lyWC5RdAHGRLyxOhQ/bzy+OAwBgnWcbBg8oQTS0mv7DQPPf1P0pZADLS2VK0sH+p7/
	 4kLqyxrY1DtjQ==
Message-ID: <4e52b966-308d-41b2-ae60-d8f4b8b1cdd5@kernel.org>
Date: Thu, 27 Mar 2025 09:41:33 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv6: Fix NULL dereference in ipv6_route_check_nh
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>,
 Purva Yeshi <purvayeshi550@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250326105215.23853-1-purvayeshi550@gmail.com>
 <Z-P5vvrdA5MHMW_o@krikkit>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Z-P5vvrdA5MHMW_o@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 6:57 AM, Sabrina Dubroca wrote:
> 2025-03-26, 16:22:15 +0530, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> net/ipv6/route.c:3427 ip6_route_check_nh() error:
>> we previously assumed '_dev' could be null
> 
> I don't think this can actually happen. ip6_route_check_nh only gets
> called via fib6_nh_init -> ip6_validate_gw -> ip6_route_check_nh, and
> ip6_validate_gw unconditionally does dev = *_dev. Which is fine,
> because its only caller (fib6_nh_init) passes &dev, so that can't be
> NULL (and same for idev).

And fib6_nh_init has:

        struct net_device *dev = NULL;
        struct inet6_dev *idev = NULL;

> 
>> Ensure _dev and idev are checked for NULL before dereferencing in
>> ip6_route_check_nh. Assign NULL explicitly when fib_nh_dev is NULL
>> to prevent unintended dereferences.
> 
> That's a separate issue (if it's really possible - I haven't checked)
> than the smatch report you're quoting above. And if it is, it would
> deserve a Fixes tag for the commit introducing this code.

I do not believe it is a problem.


