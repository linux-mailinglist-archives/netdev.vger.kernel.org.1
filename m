Return-Path: <netdev+bounces-157932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79CA0FD6B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EDE3A7882
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD85695;
	Tue, 14 Jan 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSNerIMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF724024E
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814942; cv=none; b=G0wc7nh11abTued4sqjuiTmjiaadI7xGV6mn6xqB9uXplss5NvCLaNevQphD8z4cbbzMahe+NX3rrYL+lSf+tn/JNz3MbROJ0laW5CRr9WWJCc2u2AaRjygjKSffrJXLfzYVKXvtEu2QlUIHhoV0sLdDi831+HLpP6aivJYM3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814942; c=relaxed/simple;
	bh=Z4FJ1qGx+wY2ENI6JGO9FScRIImbqT6YtQrivVRNsow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdhlRKr/o3G1wnl1zSsjqs8SpNOxQlmc0Tk6PD9XQ6Zmv7Bpnj+rkbsgczGPGo20s+OcZnW+XzUCKZgCi4Hgll/SNpeXc96dU7ycppWmnaOJ/wiswZByzjzLO2nh+tmincijDjM/UnKgfFK2T7k5g7gGT3IE9rJeDnoJLghRPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSNerIMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0259C4CED6;
	Tue, 14 Jan 2025 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736814942;
	bh=Z4FJ1qGx+wY2ENI6JGO9FScRIImbqT6YtQrivVRNsow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HSNerIMNF2rR2B5WOgbzxFPFX73A5+LNqZGvdHjyV8wtucJSVT/rQAKpJPVx15Xxh
	 cXpMxJCTII3bXzwE2fc+kKg5DtFqdbBvsZ2cbpoAEtk/d3azOdg3SjNf8S46SBfZTi
	 htf3O71kyTJxk86FShqyxp8W4J0ilw8hR+vPZ/BH7kgydgy178x0mh8RzqRO0fXZVD
	 ONNpqYLkPjL7J8aK67wBREincpeG5ETd38e7uozeP1bw/u/mt/DGVfQuPQlHQYq/ZI
	 7Ocyvv88KwV4f+3HFF7k+JYNRozrh8QIrRZQWu/6OagdlOG3Sm2dX7NtwNzWhfen89
	 fQ9YXvwL56G1A==
Message-ID: <0543159a-addf-485f-8806-c6e56705ee28@kernel.org>
Date: Mon, 13 Jan 2025 17:35:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet: ipmr: fix data-races
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250113171509.3491883-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250113171509.3491883-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 10:15 AM, Eric Dumazet wrote:
> Following fields of 'struct mr_mfc' can be updated
> concurrently (no lock protection) from ip_mr_forward()
> and ip6_mr_forward()
> 
> - bytes
> - pkt
> - wrong_if
> - lastuse
> 
> They also can be read from other functions.
> 
> Convert bytes, pkt and wrong_if to atomic_long_t,
> and use READ_ONCE()/WRITE_ONCE() for lastuse.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/mroute_base.h |  6 +++---
>  net/ipv4/ipmr.c             | 28 ++++++++++++++--------------
>  net/ipv4/ipmr_base.c        |  6 +++---
>  net/ipv6/ip6mr.c            | 28 ++++++++++++++--------------
>  4 files changed, 34 insertions(+), 34 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



