Return-Path: <netdev+bounces-103641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A0C908DA8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990511F2430C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D0EAF0;
	Fri, 14 Jun 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlgEjdaz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717E17996
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376021; cv=none; b=laQyeBybw7xhQ7YLFV5jls7x+vIfssA13V4z2SbbDHs+VTgjKtJk49FqAlHWz4QzOw2eMm+iPawNTKcvjsx5lKdGP+eQ2ibYiEiO6pP/gsU4Yg1WKX8HeONM6Hk8SFHkIXtOmnHoyu+sae/PitchLlL7HS7EcwmKhdSPwvmNrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376021; c=relaxed/simple;
	bh=P72VS2+gM+5unjA/p73VEnt/BqY2wXnzBPd+2ZswDps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDnKi/va+rP9GWpyLP1bgXYTH+ezQ3FF/3jF2YGnAW4Bqup/uXGFvns8lpO82QNXkrEeRj/+lQqOo1W83/tvhdD3d6JuA7OPJKOLlVsYLc6HmjGAkzizQvfq1d+0Lp6GKLbhQYhhWaDuNGgGVRr0b74oQCTFLneSnz0ypP18vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlgEjdaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B3C2BD10;
	Fri, 14 Jun 2024 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718376020;
	bh=P72VS2+gM+5unjA/p73VEnt/BqY2wXnzBPd+2ZswDps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HlgEjdazpQw5lKdRjmFN5Id4i1l+x1wWuaqXG96q+WmsZXBfRFO6az+2R6BICO7yH
	 /lZNIbRjHssnF+/nKzjNrNuAFKa13M3kISXb/XffNtY6Zte9PYH5KUEvKGmWK+39Os
	 WhZvnwpnvwOwYrITanPpyWB8KobHQag7ZIFcSy3w9k/XtvHfifO2zz12fn4aQ33w9f
	 C/HYnPDHku+9b4zYzSBxNikNzPkSbCrXja14YfkfZqN9OMZzd49T7DwY5fTm1flgGv
	 SfnMgHCcVEWBW4aikFy42TveLvy+70gcwy9vI/Wpxdx3pXhKrq/ncW3ZP6naIdREet
	 H6CJfIEw0wJYQ==
Message-ID: <e48a44aa-ae66-4758-9c88-8ae28b699496@kernel.org>
Date: Fri, 14 Jun 2024 08:40:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: prevent possible NULL deref in fib6_nh_init()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Lorenzo Bianconi <lorenzo@kernel.org>
References: <20240614082002.26407-1-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240614082002.26407-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/24 2:20 AM, Eric Dumazet wrote:
> syzbot reminds us that in6_dev_get() can return NULL.
> 
> fib6_nh_init()
>     ip6_validate_gw(  &idev  )
>         ip6_route_check_nh(  idev  )
>             *idev = in6_dev_get(dev); // can be NULL
> 

...

> Fixes: 428604fb118f ("ipv6: do not set routes if disable_ipv6 has been enabled")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



