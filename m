Return-Path: <netdev+bounces-147463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E09D9A89
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FDA164600
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF01D63DB;
	Tue, 26 Nov 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAeI0C58"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20DC1CD219
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635585; cv=none; b=Ea16d3h5WFvBd12Fzx0bYIxlconzX/14u36OAtgR/+sXberUzWQFi6RiqthaFDs4MUvyXLxmETsO72URsmsITyu950XpgffIWVeLFKaHTUeZQZvDEWV1HcD/WGManA7MZshcwt4CYieRGUpPy1eh6u73Y5/LsjLdAXS74e9+23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635585; c=relaxed/simple;
	bh=u7/N9YCSeLQsuwt5fNsyydTkqsJfijKx7m27V/lg1lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okeHANt0sEMfzv1M6SMOIPL/PcyXHvJWEjFgmheZEGlDrcLPZvK8PSl/BBiNRWA++ElNvPFdlj7Y8b2+GeiT0p9aoSegkeIyWpU04gJSa9ByhRFMBIjVi3zncYVZcj1U51rGw8Ios/S0OfJGI273uUQJiZPf6AbhRYeJVoW/INY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAeI0C58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D6AC4CED0;
	Tue, 26 Nov 2024 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635585;
	bh=u7/N9YCSeLQsuwt5fNsyydTkqsJfijKx7m27V/lg1lM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YAeI0C58AkMFBUY9OAMDna1OEa8g4T8BgreGrsJIOk3zNvjR6KRfVlzIpBIWsLJoZ
	 repXoN8BvIZFWEumsuTGmsypvHZZcuU/QIVy+jfbBfKbZkL+h2ubu2+0T2avvYQpIF
	 rMTleru+EugI633h8dsRadBLTN+7QSZaUlSg41sRRKUYveE5O0oAfzgMWw+1K3MCKi
	 1dDNliO1Psr45Hcx5Pv7k+NMOFCxcTenN05KtCAi4r49YdYcy6RDl3EzpYuyo+vqcX
	 3MCisk4TcjfszEMkQuUuqbj9/D8qwooti0rCCKI43/mu7xIA5Ipso500quro4D/uNI
	 SYTUCcSZt/GXw==
Message-ID: <57614d75-7f44-40be-8078-cc4a0773a0cd@kernel.org>
Date: Tue, 26 Nov 2024 08:39:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/3] ip6mr: fix tables suspicious RCU usage
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stefan.wiehler@nokia.com
References: <cover.1732289799.git.pabeni@redhat.com>
 <3a8b03f560f0b4b447a227950e6e5283231d138b.1732289799.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <3a8b03f560f0b4b447a227950e6e5283231d138b.1732289799.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 8:40 AM, Paolo Abeni wrote:
> Several places call ip6mr_get_table() with no RCU nor RTNL lock.
> Add RCU protection inside such helper and provide a lockless variant
> for the few callers that already acquired the relevant lock.
> 
> Note that some users additionally reference the table outside the RCU
> lock. That is actually safe as the table deletion can happen only
> after all table accesses are completed.
> 
> Fixes: e2d57766e674 ("net: Provide compat support for SIOCGETMIFCNT_IN6 and SIOCGETSGCNT_IN6.")
> Fixes: d7c31cbde4bc ("net: ip6mr: add RTM_GETROUTE netlink op")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv6/ip6mr.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



