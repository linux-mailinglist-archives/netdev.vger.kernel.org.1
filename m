Return-Path: <netdev+bounces-224100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF3FB80B6F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B317518848FA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8333B487;
	Wed, 17 Sep 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbeR38N3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBC19E98C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123852; cv=none; b=SrEYmLHMikngCx0Aojj54zcf0dBDOicYke/SqginXsAa9iCIBRiD+jx1VAnTJQricMAVekzrPrXWUJX7PtqHGmZPeFefdVaGdlykCXLMRCrA/BmACB7PIG8uyLkRdD5Ne5NxgcQPjzABUkbwCjI9zehodX6EwaG+6d5LsmIpz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123852; c=relaxed/simple;
	bh=LGwsyxLmtznvMB35hom2jPbsclfLsrkVG3Fgw8UXByE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGIaZRo2Ru19btjpNWxi/VLgB4jLzMmoQcEUGfAN+SLDRl8lKW6tDzqMwBslJJrNa8KpHOY7Fmi9pbLbocr0iLhHgacn6V41sgLWJYZAKL1Ccz+iWsG5U1cgWXgzD/mGdRcuN1WL5++qyhMyN6BQXFvXYPvEFyP08QIIJMcjrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbeR38N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13511C4CEE7;
	Wed, 17 Sep 2025 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123852;
	bh=LGwsyxLmtznvMB35hom2jPbsclfLsrkVG3Fgw8UXByE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MbeR38N3j7D18tkYQMdKbGBrbDUvyp0tSn12RpLXZmSwi6LHNewPp8WK1yBZgEjof
	 FPlT1M9VwBwxI95lPKIolOu/mMrUeJzopxV89ezs/LHr9m8sa0MP5G5MktuFBX1jf+
	 sVSlB1x18Roeno6S0ytN3EFQq43o5gQJG+FQJYfOg3rfkmgDYtmGwnwD4uS14A71uz
	 5LzeQiVF2o5Xoy3jVp9ZkylT+Siz7RTOWOA7u7c5sKr8YJgtW52Be2an8FqON+nZ21
	 5lrOqi5IWKjJOZRr4b4gau1tPdhherSXFJP2ULY5GxdXo+uQfgtyI8ddPXZp7GM8jU
	 TAFjv9t7DWd+Q==
Message-ID: <51fa5967-df5a-4cbe-bf4a-11626d209dd4@kernel.org>
Date: Wed, 17 Sep 2025 09:44:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/10] udp: update sk_rmem_alloc before busylock
 acquisition
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-7-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-7-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> Avoid piling too many producers on the busylock
> by updating sk_rmem_alloc before busylock acquisition.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



