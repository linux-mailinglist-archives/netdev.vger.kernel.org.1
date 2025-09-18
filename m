Return-Path: <netdev+bounces-224591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CCB86713
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A5F1C253C9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC62D3A93;
	Thu, 18 Sep 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9X/2U8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDF1643B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221026; cv=none; b=UIQc28MxICAQIhUacTnEHol/RbvRRfcXUeD6TCxFrh/1VdUcJdca6feX/NMtfvUknKAPAEMUKoWU6kPCdXnkUgPHjqJkUIjEJuncbm3JZXydzOC5FofVzELDhiRDefAkFuXzg6mOyv5yfxs1PwlLY9wboEdwQWoseempzIShEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221026; c=relaxed/simple;
	bh=swO4djFg4sEzypuyf5cwmvSomRbMUKnl9Mf54hVaKjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYtz/8nL4ggGuTLQE+q5ngnvW7sQCAf7zqRcUNaNUvGKmbLik4WrPmWaHmKMdeAGnryANE89OxkGq4t/MC/VCjvQFgRp7O3cefyWyzmDAydhkwGtjYPyivqbqMePSEvEAQOsWoIgaRb7yButsbTv5NXQ4CqEkEBIQjdZg0QBe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9X/2U8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24C6C4CEE7;
	Thu, 18 Sep 2025 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221026;
	bh=swO4djFg4sEzypuyf5cwmvSomRbMUKnl9Mf54hVaKjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h9X/2U8WkjUGNeLbegsgdYkWWdH/1HpVF+n0c+TUZyAq6cueqnATB8ZYK7Qa0PzHh
	 jzHb9jAxG9npKJTdzpryzBg131dnij9YPhHuorKSXvggoceYXgP5p0USdxxc6fPqcT
	 WGarPI4noR12DMTDRbDHFWtJOGfLl8RauxJJbCnHSou2Wv9+6h0m1YsGJcWHdGsXDA
	 MKEql/tz6O3cni5ZOK77BYzO4ApcS1Ia2sIuvVDg3m5/cf9sJBt9ZDx3vKSF2NGruo
	 C906JC4tHRc57wqCq0qTvDjQGuddxyxuqs86sY8FF+KXT13aByDhOvgK3nPt48jS2/
	 s8baPnXDEvgyA==
Message-ID: <316dbb0f-cb41-40d7-bf20-4d0e4ef40dbc@kernel.org>
Date: Thu, 18 Sep 2025 12:43:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: ipv4: use the right type for drop
 reasons in ip_rcv_finish_core
Content-Language: en-US
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250918083127.41147-1-atenart@kernel.org>
 <20250918083127.41147-4-atenart@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250918083127.41147-4-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 2:31 AM, Antoine Tenart wrote:
> Make drop reasons be `enum skb_drop_reason` instead of `int`. While at
> it make the SKB_NOT_DROPPED_YET checks explicit.
> 
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/ipv4/ip_input.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


