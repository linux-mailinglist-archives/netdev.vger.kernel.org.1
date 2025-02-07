Return-Path: <netdev+bounces-164199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053AA2CE63
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8133AC8DF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB991ADFE4;
	Fri,  7 Feb 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njlNnGTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BC197A92
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961003; cv=none; b=AO5Ogs9LqU50nadqJlv1mO+KS5P+oi1kBXl7Gl0PebCy3GY76P7f/0469vL6VaAiGZG8CVaFz+27zViUMMI6YknbADbBOVzcZIu44Lgw3PKvvgS/ADaDHqmEGhYzD+j/rAgtFO3ADmcOHxZPwB+zSc75UwNcJ9SgzZ0v7T4YJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961003; c=relaxed/simple;
	bh=MGXGcWu3sVAN7IxyYm02SgBQe46yRJlETy0dWDkkz/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/kc3Yk9ItxZtOjYSGVY+kDtsuatew/YL3w4Lowc1z1K2MuTYFKwfl+Z3FydA0Pk48FWtELXb+HtaANY9vMrqc+o//uOeg6DKYUXSpJhbSecEY1/SHYWKKKwd7GWDgFaTPqlAsBmQvKNp7WfnJUbr5+hqyOQf1GebN9IChyS8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njlNnGTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517D6C4CEE2;
	Fri,  7 Feb 2025 20:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961003;
	bh=MGXGcWu3sVAN7IxyYm02SgBQe46yRJlETy0dWDkkz/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=njlNnGTXe+b4ZlUjqJza79voJLRo2frZAgP+6SbA/463Gxpd0VgLzyRalwF+bTR6q
	 JB4qL7nk0b35YDuNoW3pR3m9DQE4tuyerqH/sDQnhTc95ivBF7ttl4sQ5QNNa4DU0N
	 Ru/KbH49NXv7oQlgyQrpdhBjSA6mk/7PyHaj6g/WvDTUUnEVsrs6wOGSGPWp5yCr7Q
	 UQ6bm/v8pGcEl1++XY+dQ5CTOfIyc19YuB7RVeRgqurNtbnlmIKrMLH9dquc3ui9ml
	 ewmof0rQW5x07RyQhg3/CCI/7YKTZAu8eSNa8VdaZxfQ5BZlHDbpxaxr5Tlygftr9a
	 isNUDdsoxDkrw==
Message-ID: <26cd3ec5-cf35-4162-af3c-ef185cf82916@kernel.org>
Date: Fri, 7 Feb 2025 13:43:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] neighbour: use RCU protection in __neigh_notify()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> __neigh_notify() can be called without RTNL or RCU protection.
> 
> Use RCU protection to avoid potential UAF.
> 
> Fixes: 426b5303eb43 ("[NETNS]: Modify the neighbour table code so it handles multiple network namespaces")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/neighbour.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


