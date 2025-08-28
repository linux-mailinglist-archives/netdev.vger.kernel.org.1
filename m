Return-Path: <netdev+bounces-218016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A619B3AD57
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A47C7A59
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527231865FA;
	Thu, 28 Aug 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0PdWmCf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE29145B3E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419391; cv=none; b=Hb0z1DELGQxNztMgiK74JFF300a9Fq+Sb4kerdRZD5vc8Hz+zZx6PDHLmmHdKsKukd//HBipOlhWOAacT/LWeWyTs/slhT94t1ggRmWpItVYKnx99+w6C77tetYMOluUugXw7RWJk4hqRtGBqswduW6lGVkhfvwz7IFR4lbnp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419391; c=relaxed/simple;
	bh=mq926KxoNuzfpSCEqHhb1aSlorjZkI/RoehO72IDAy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNm9yrqvNesBy8AqLOVaa5npwkrGZLnAWlUAytXHliUwaeel+wTtrkTzqIK5AvKnpnrah1jqImZRFcoRfsBELK1TfacJTEesU7/jAOPccbwZwhmqA0TBvUAoN0hMfHxX8GN6pP31/VwwZHG+xoNKX12XfNPGmfvBT9tNy88bYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0PdWmCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D4CC4CEEB;
	Thu, 28 Aug 2025 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419391;
	bh=mq926KxoNuzfpSCEqHhb1aSlorjZkI/RoehO72IDAy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O0PdWmCf+fwZrM1hlXbF8aNNzC21mCRw+43qq60wp2cc8sg/OeRrf0FMX/zuasL1D
	 FxNDWHiUPbSJYVeDShqXdX/SbL8rPwxiaJNFg9ecgmX6r8drzeWR4C5qJLp6QMJCJD
	 oYDtJJ/1vVpr5IifkwjOGbMGhL5TmqonV3EUnF6QQsXc/mpyEXHWEnayehEZKPDr0k
	 d/qd0p4nn3mY32K/dwFBa9pW2YqBsDbJTQzrq3RpFexdi8UKXW4YZ76SrVYeCYWWrA
	 jyf5rgHwmxehGz0yqplw2RWBKZhbB2LdHRkrnoI2FORsMvMQDtekMMiogs62GQ99iu
	 JT8DVXI8/4Pag==
Message-ID: <5a0deee8-3039-478a-9752-4fc2e87b1486@kernel.org>
Date: Thu, 28 Aug 2025 16:16:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] tcp: use dst_dev_rcu() in
 tcp_fastopen_active_disable_ofo_check()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-8-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Use RCU to avoid a pair of atomic operations and a potential
> UAF on dst_dev()->flags.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_fastopen.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


