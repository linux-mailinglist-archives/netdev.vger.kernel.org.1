Return-Path: <netdev+bounces-119349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FB95549B
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 03:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799CE284685
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8A79E1;
	Sat, 17 Aug 2024 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3UxzhE0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3979DE
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723858221; cv=none; b=tY8cKtePuEGOnxfPm25Iv/FFhKpKy11yxkQf8uPAzgEtVZhMJxtqsE1LpbW7t9dyGg1pO3obXVKxcPIrc5uhaPa+qB2pSvL6qfmXyYOar0CwGQ8SiJeyUbEN1fIhpnCIdG4qivdN5JtiYm5O9237gqqce2E8HtcIdyOWf414szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723858221; c=relaxed/simple;
	bh=95UIDwBjcVwTq+OiPtmd20i2N8Ozl3hfKyGxklsfXKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyspQzhxUIBFmEci1uwZQrXUiNHpFBi3ASnwvMCkNL3ZMn9QttcYBn+pYr+u99GF2TW714dZyKFwgIvxU9YU3om4L+D/DoE3i3yY7J6L5oSMkcijwEbool5fSII9Fg6JVSJUfpi5611FP2ePhAADLoUCOlFA5ONh2Y1KxPUL1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3UxzhE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D787C32782;
	Sat, 17 Aug 2024 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723858220;
	bh=95UIDwBjcVwTq+OiPtmd20i2N8Ozl3hfKyGxklsfXKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h3UxzhE0Wm+tEKdpK/EHtJBAuM168vGNRzg2trNpatA2ACDLAduPGBkLv/9P4WbYj
	 y9PSzL91a19qZNgF3BBgWrJqVHRwlebp/HcpW5UhHBATVhGu9vzlo++t3ElGPuEOda
	 MYjxUKZTWKLbnn8rbQpLYX2Bqyc+BfczvqZZfYOumx69U5+2HpYw0qkyxAyega5vpq
	 K8BpgkRuaunYNznNhr/Vgw9C1t5qmHkSCcfCgtWjLr2MSFUh1/0gwnUdZVXJhP6/yQ
	 1ihWRiUfZb042axCeHdAxWGEiYuqLI408MBkHeefH7vr6LAErwtHhaRfdlPY4qLu2w
	 tkzadgzNnAXtg==
Message-ID: <ccf2296a-f5c6-4618-87cb-891a6ff2d76f@kernel.org>
Date: Fri, 16 Aug 2024 19:30:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp_metrics: use netlink policy for IPv6 addr
 len validation
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20240816212245.467745-1-kuba@kernel.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240816212245.467745-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/24 3:22 PM, Jakub Kicinski wrote:
> Use the netlink policy to validate IPv6 address length.
> Destination address currently has policy for max len set,
> and source has no policy validation. In both cases
> the code does the real check. With correct policy
> check the code can be removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> ---
>  net/ipv4/tcp_metrics.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


