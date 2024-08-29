Return-Path: <netdev+bounces-123070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA796396D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2271C211FF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C13A8F0;
	Thu, 29 Aug 2024 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwnSFpiB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20D146A96
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905872; cv=none; b=bqysgmdT8IRT8mu3RTxCQlfC0d8aUSJsDZQKN3eU2EqamLdwXZ5dKI29rNKx8ObzF9mZCHXldvWmq4E85WJyVamB1vso8J9FC7eGhGlvcXE4CwAff+kMIRzG0R0V0nArj0qj4Pu0sjLHo1KQmS8g3AXbEeLKw4N+wGtTjB5T8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905872; c=relaxed/simple;
	bh=6YdLOpoIQawvJtdBv49LZ4hgWv3jwouL2iSyMod/S8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KChFUInFAnsyO4BtYtJZCDtZOzXotWDBCG548a0Fd0OHB/MoAfZiSmO6PiyGUg8b6SW5w6qXQCCjEl0jSZ/yDAGVkRNSqfXqr/9Ih7uv8MrTWGyj6ka6IEs3Q7YzlbHANogPxdC/y8soI73xFUa41ZZDGZmzCWJGk2AR7CDRveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwnSFpiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F927C4CEC1;
	Thu, 29 Aug 2024 04:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724905871;
	bh=6YdLOpoIQawvJtdBv49LZ4hgWv3jwouL2iSyMod/S8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QwnSFpiBeTR8/UbzfEP+h7ditvTktuP6TY8cFlIUVLuwLGg/lTEGdesST/dN7cTK8
	 /NFZj13yF61rMTMmGLtDhccwSIqspBbz8JupuX42TjrHzPUxxyU/NnaNQzjCTHR0v0
	 oSD99ne41R4xHjOTpj+2IBzrH1b0e8kkVjCy1U8PgWu7FcVTrwn5VzC3XgF899CdTO
	 CceTBiHWaQyQ7uLAgOse5bnFWGOjW5lBN3cYHO6B1UdbONhNp8lMqSCtv9turoHmpW
	 ZmV4aOnS9hsuxR2SfX/bhY+TfPH/veNrzEzT8bf7Fc4EhLiXfWIw0ZlRD/3z4B9KGX
	 tW7sg/A9EdwYQ==
Message-ID: <4078c74f-9c36-497c-8351-0c409da49fbb@kernel.org>
Date: Wed, 28 Aug 2024 21:31:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] icmp: icmp_msgs_per_sec and icmp_msgs_burst
 sysctls become per netns
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240828193948.2692476-1-edumazet@google.com>
 <20240828193948.2692476-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240828193948.2692476-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 1:39 PM, Eric Dumazet wrote:
> Previous patch made ICMP rate limits per netns, it makes sense
> to allow each netns to change the associated sysctl.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h           |  3 ---
>  include/net/netns/ipv4.h   |  2 ++
>  net/ipv4/icmp.c            |  9 ++++-----
>  net/ipv4/sysctl_net_ipv4.c | 32 ++++++++++++++++----------------
>  4 files changed, 22 insertions(+), 24 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



