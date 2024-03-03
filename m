Return-Path: <netdev+bounces-76932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C449886F7D3
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 00:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7750028115D
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603327A733;
	Sun,  3 Mar 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl016b/E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3572E418
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709507755; cv=none; b=eZssxb/pp4/OscyLdM2oydHe5Ja0gJFBFf/XXS2cdLU9CK/sKrK7pyDq21LfhcLwDOD3u0lXYAQvYPHpAkhEpEekjc2hAl0mp9PCiVWyKWrekAzbHSbiVKa7wVCvK6KpsGQh0KPL1Xb8BVVVjznq/YPwo89J1agnJGuXhfDQhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709507755; c=relaxed/simple;
	bh=SWPKG0oLIDCS+xttXBikL/awGPIJvbMpC3ZJAeK7lEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfWWHb/dZrlroDhprDJjaTXc/2m1yleRMCXVBuTc1818C0t7Jy/6i2Q7hqGMBCv7u4xa4MMgYR4isjrkSL/ZRbbavqVyzEAAN8VevssGVcg8l4EFsVj/wKH2R4K82QTJJgckyR20GYJg8WuI8CRjvarVH3eZz5qMxrYYpS2U15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl016b/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3439BC433C7;
	Sun,  3 Mar 2024 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709507754;
	bh=SWPKG0oLIDCS+xttXBikL/awGPIJvbMpC3ZJAeK7lEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fl016b/EZBhJWukgTc+yEC0kWh0Muufslr0YZOXsKGCEtrehX3ekPs3ngB8H3QPcF
	 de5Q1BDDRo1LULRygYSuCebuwHFrYk3BxB5PivOz4oeMyFfyfzztlofXmtmidmKP1G
	 r0pkrS6sFmB5PqnwUmrRlcoysZxlMYOx/5beuQANryfWSEuUqedBh8PdzNVz71iBeW
	 hkQPnJwtBBxWkkCbVeG/+ZagD6zYIl/vmHnHvsJJzdKN6H8iJXCc+QuhrmXitZ1Lza
	 cM0DULmpciIIY0cumGxI9jw0oAJgZIqbtUbNxWKC071Edp1XMAs29/oTlput6Mzlnr
	 I9+IIbyfO74Ow==
Message-ID: <fa45f94c-543a-4a35-bfec-670147d50878@kernel.org>
Date: Sun, 3 Mar 2024 16:15:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: avoid possible UAF in
 ip6_route_mpath_notify()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>
References: <20240303144801.702646-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240303144801.702646-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/24 7:48 AM, Eric Dumazet wrote:
> syzbot found another use-after-free in ip6_route_mpath_notify() [1]
> 
> Commit f7225172f25a ("net/ipv6: prevent use after free in
> ip6_route_mpath_notify") was not able to fix the root cause.
> 
> We need to defer the fib6_info_release() calls after
> ip6_route_mpath_notify(), in the cleanup phase.
> 
...
> 
> Fixes: 3b1137fe7482 ("net: ipv6: Change notifications for multipath add to RTA_MULTIPATH")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv6/route.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



