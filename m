Return-Path: <netdev+bounces-164200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E206CA2CE62
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73688188B6BD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0E1AA1D5;
	Fri,  7 Feb 2025 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftxklBZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB43197A92
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961032; cv=none; b=OM1BbT/B4c/ONdILHnRbTVwZ93IKa7u+yBe7kJRbjtGbkXkteW/sqFlz7hUtVUvAerN0nir79D7Wv6q743zqSAyZerIo+UcjJjy4gQI2/6dKVqb1r69yCLfe3i5TkToNisOBrOFX3ZBWh41m8jtHNuUv/Vrn628Scn/ST3P0e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961032; c=relaxed/simple;
	bh=NHRXu46pUUv3nw1E6pVFgnUDoXugb5NYNybisOwdkyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaiVpdJJska7B3iof3CAJCF4DyOFk5phjMiCJigobH27Ppx2oFllVsz/jX6cBozdn83euIzyvlt53e9yeSwnCzvc7MVrBES0wh/PiVw2nnkoBWlvZA3/De3wE9c95k7gEAy4WmYjgLorngINa+FlrN/XLhqU4bB9cNjBVAyBRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftxklBZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB8C4CED1;
	Fri,  7 Feb 2025 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961031;
	bh=NHRXu46pUUv3nw1E6pVFgnUDoXugb5NYNybisOwdkyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ftxklBZpos16xzUAWcnulk+xFNf+4DCBe12d9r+APtc4v6NxyTczwIz2MnNuNghxh
	 HKcdTArkNvltok2pfr2xllJAcl43++MaO0uWndci77rrhvKtyw6HpfUZd6gDF5rwms
	 PhQJDeuphnTpiRKf37Z7RHuEvJ8WwgmHWIu5piMRW/Xk7n10EYyRpJvV8MuPruKSPJ
	 V/AvjLyWRotSr2AaGxSFBQLj/vAXwYskmzyA38jnV+5IiLqL1yHfwkte2RRj4nHndE
	 ZCErThF8mtOJ82Adc6kizVQjk6xJvmqA4hoDyhzvVzxD8pT/5Xgb3fBwBLoYj+R2AV
	 KX3rZSwjJlHAw==
Message-ID: <683a3bde-cf11-4265-a73e-d3c40abdf4fb@kernel.org>
Date: Fri, 7 Feb 2025 13:43:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/8] arp: use RCU protection in arp_xmit()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> arp_xmit() can be called without RTNL or RCU protection.
> 
> Use RCU protection to avoid potential UAF.
> 
> Fixes: 29a26a568038 ("netfilter: Pass struct net into the netfilter hooks")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/arp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



