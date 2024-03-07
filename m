Return-Path: <netdev+bounces-78514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3673875720
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2C6281677
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBEB136650;
	Thu,  7 Mar 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G02ZJ1j2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7E1AACA
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839714; cv=none; b=DOVsIgGZnovnqwT2VYknsSEkpywZ9LimB4t2ciI61+6HXwJYLPa27nhOaRtOiSlHEnua7980RijDvsj1xV78XnT6LATvwvR3ctDJx+Yv08QgOkC4b8aCMRUN0uD9drBS01YiD+tItXjcDCNAaPmLn3EfTBOzfnn87oGM3anC5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839714; c=relaxed/simple;
	bh=lW9q/US5u5IovhrqF29UFUm5vjg6tF9v7WlzFhura/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwfmD+RX1eONctDqbw1b9aSCqtBC2dboIYtef7g6ovDqljCTNCqi3r7lfxGkH/pFoPbyfFvBszPOj/nDTYqIF7PAYiqco55nJ5pRMcIPOqKRwBl0IIQU9wo+45itOC3IExXI5F+GkiXXCWxSPh3RzjRrxi0mzYhjERfM6Dp6Qq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G02ZJ1j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15277C433C7;
	Thu,  7 Mar 2024 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839714;
	bh=lW9q/US5u5IovhrqF29UFUm5vjg6tF9v7WlzFhura/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G02ZJ1j2KmxE0OPWClKulCAyrga7J/GGOsNvFAqLPJ7N0200upOS2Kj44jbk1MiGn
	 5/siG/0LgWCSvtkvmQqBA30dPWytaoKCoiHpWcercG/9l5Y0nw+UkNqf4G2HY+iF0b
	 xLOpWLq9IpfroofF+lJyifnOpWBU5aNilUw7L6AGJw4dCCWXpzpc4z0ceDKScKJYPC
	 3I31s+wxLSWhX/ghn8y7DfXUtCQQtp+5lKF0wJUlsLgAg5tz3fxuPvsFuQs3WJYIQp
	 uFQzXwMA43i8NN0ZLhzrfbxQK37exBLpdEw2UmT4+wSuJna6RBuD6/6IfRFtCSrH0W
	 RqGcLEXZ8A6qw==
Message-ID: <52eea550-1179-42f4-a09d-083b2bda22a6@kernel.org>
Date: Thu, 7 Mar 2024 12:28:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] nexthop: Simplify dump error handling
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20240307154727.3555462-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240307154727.3555462-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 8:47 AM, Ido Schimmel wrote:
> The only error that can happen during a nexthop dump is insufficient
> space in the skb caring the netlink messages (EMSGSIZE). If this happens
> and some messages were already filled in, the nexthop code returns the
> skb length to signal the netlink core that more objects need to be
> dumped.
> 
> After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors in the
> core") there is no need to handle this error in the nexthop code as it
> is now handled in the core.
> 
> Simplify the code and simply return the error to the core.
> 
> No regressions in nexthop tests:
> 
>  # ./fib_nexthops.sh
>  Tests passed: 234
>  Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



