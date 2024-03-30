Return-Path: <netdev+bounces-83516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A4892C13
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB34F1F2165E
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9B2B9C5;
	Sat, 30 Mar 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBHXtnbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC821364
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711817106; cv=none; b=SaSSys8ViG24JlIbI3qvKhqYhT2iFFajn47TKmxNmsQ2sNaxzsjbiRQyifY/NHlklbh3XwFKPg9iqUCFjOgP+WKVwyngRNEntd954NwCchgXySOuxMtn0o8jbFUPTbZI6o6aUuVzMeOhDogZOSjQXMouCe28yOu/CvQEkToupfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711817106; c=relaxed/simple;
	bh=kEePYDXGbJSmM2ABiU1MAO3b0ZIycsmGd3qsAq/kUBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx8IUT19Hyrh/CBArhvDcKf/RQROW7vVhVX1RZQ2gbrU/BMW3UcYnPyYfoIS4A4jlFYHYuF0X8iSk1N/4axZh9ZQfU4belozBGyqsUae5gk+t4qwE/Li4zTrIVii7olE04BKwsJD9NcMaIeX8wSfdvfQs3qHpFQUOJrPKTBg29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBHXtnbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C24C433C7;
	Sat, 30 Mar 2024 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711817105;
	bh=kEePYDXGbJSmM2ABiU1MAO3b0ZIycsmGd3qsAq/kUBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uBHXtnbcq1D5u7N4It0Jo1d5yqmNkKD0wwIpmT+yk39KwYUHLi6/O5XJKG8eqeFG/
	 BnjhRJgfEH1/Lehf3rDuIB7lebWklFAhEbiE89L/8r2ktaeZYxHqa2M6bkdy3htmv1
	 jI+zbtzz9DYi1iu+Alw97RmVOJsc70iWGoK+YcHusVN5H7dHC+oMhQfjAbScHompKc
	 p1ZYyK/aHLKAVRpb/SPND6t4g3a8l58XFXt5MoDCtB3M715SHNw2NJbddv11GuwzG5
	 Q0rpXJJPhV78kIxIfsOHpoC5vVY8Bz64jUthJjeFcrGTs5z5CHlPOetsIsnz2s2PaR
	 /OqIROuqb2M7A==
Message-ID: <cbbba1ba-78cd-486f-ba7f-4fb87292eb5b@kernel.org>
Date: Sat, 30 Mar 2024 10:45:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: remove RTNL protection from
 inet6_dump_fib()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240329183053.644630-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240329183053.644630-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 12:30 PM, Eric Dumazet wrote:
> No longer hold hold RTNL while calling inet6_dump_fib().
> 
> Also change return value for a completed dump,
> so that NLMSG_DONE can be appended to current skb,
> saving one recvmsg() system call.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv6/ip6_fib.c | 51 +++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


