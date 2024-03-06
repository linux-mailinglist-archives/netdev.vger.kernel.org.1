Return-Path: <netdev+bounces-78184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3B874492
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2044528421F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F21CD11;
	Wed,  6 Mar 2024 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spmJIx6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820B1C6A3
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768312; cv=none; b=YV1tCQiYzjQrMdqrTQJEYE4T4YKEzVsKX1l7mKudKkqe/kYrIhMGzmAGiA5dq6ArhJ9eJjiXA8026+6M97SJexA69xzhttCGCa+fGhV4boupi33QsZJ/qHgoMA7ACMJ6sn+9iyNXX1w6vc3R74f7SWWL5qCyfqtKw78hakAfJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768312; c=relaxed/simple;
	bh=2GZzftSieHcpVNK1QZl154afIroBwOVlc4ZL4GHGnhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sc3UjfT/nUKBMS/TOX/v61IqA+FVX6lCCRZW52Cyt+ZrHs2b677nkvLjyOIAyJ72/YN0rs+0QNgEiJrf+HWFQmX7QV7YiJuw+wV1RciE4kszuEZQ+C7G1N6Obr2v44cK3EHtWuty7EW5ZfNY/ic/N46tWTMT6/OACgmcYx1fLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spmJIx6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8C9C433C7;
	Wed,  6 Mar 2024 23:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709768311;
	bh=2GZzftSieHcpVNK1QZl154afIroBwOVlc4ZL4GHGnhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=spmJIx6Vegrvk6lW4kDmQ+7qSzGJPgb3f+vv6+i6P9iDjg7qGdZr+mDdxsZvwvzf1
	 i4BOBi9fEydSmPUJdxmr249jd1GS9skyny4ByAQp4dng6P85YzamsePYIyCLlBbKSu
	 K0TwfDqdcHWSO0uuxkQ+xjdbppqOmv2Cc9MVcFQ3jtLtcGMu6v6oRNMGL5xfZarQbA
	 d/nXAqGdMEMcrfXZg7ofWPBkUI5mv0mxCrUQtfHt669K0nrzfYCR3z+6WaJZfAXVVj
	 hTADNE2DJijkTLbz3A9L8r/jze/hlFokkCT6TMg5EcM8HgskKVvBf59DZFgqT5XKNd
	 PVBNr+DyCnDxg==
Message-ID: <f4bcf5fd-b1b0-47a8-9eb3-5aae2c5171b7@kernel.org>
Date: Wed, 6 Mar 2024 16:38:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] ipv6: make inet6_fill_ifaddr() lockless
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240306155144.870421-1-edumazet@google.com>
 <20240306155144.870421-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240306155144.870421-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 8:51 AM, Eric Dumazet wrote:
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 2f84e6ecf19f48602cadb47bc378c9b5a1cdbf65..480a1f9492b590bb13008cede5ea7dc9c422af67 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2730,7 +2730,7 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
>  		if (update_lft) {
>  			ifp->valid_lft = valid_lft;
>  			ifp->prefered_lft = prefered_lft;
> -			ifp->tstamp = now;
> +			WRITE_ONCE(ifp->tstamp, now);

There are a lot of instances of ifp->tstamp not annotated with READ_ONCE
or WRITE_ONCE. Most of them before this function seem to be updated or
read under rtnl. What's the general mode of operation for this patch?
e.g., there are tstamp references just above this one in this function
not modified. Commit message does not describe why some are updated and
others not.

