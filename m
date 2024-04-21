Return-Path: <netdev+bounces-89846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA48ABE32
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6633280DA4
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 01:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CFF205E2E;
	Sun, 21 Apr 2024 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVceRAAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89E205E2C
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661783; cv=none; b=kn2xciOkY4edEvMUOHFXJ/SaPBtLhuZIoTLKjdMAcPV/viIdIlK1ClpVPgMIxjI2opN+ngtDvPC8R/ouK2lPoYrwiI71m0ieG0MqDwukpSJkLZjlaEIJ28OkFv2r768QInscLdj6araEwtlUm7RvMl89aYCPbw56Cy+S6t79DVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661783; c=relaxed/simple;
	bh=3Z5Hn1b+GxjUdE2zhcZmgQBjs1XkG/aQqoeHvMpihUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Axanwd0vSNtOpFQU6F5DInKM2UaXU6akMI9soGwqoBx07RA+vjVpJ5xD2671inmrHbhRqox4S7imJwlFuFutCQwXR9ViMxBnIOg/pceeHnyI8lC01xGIz0Dsb+8D0aXpsaNbIARdl6sZM969dtTMlJ18OQobGXdUEoNJFRIuY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVceRAAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568D5C072AA;
	Sun, 21 Apr 2024 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713661783;
	bh=3Z5Hn1b+GxjUdE2zhcZmgQBjs1XkG/aQqoeHvMpihUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVceRAATucp3/XD0JkzcokhsZwpugMLZObcPPUfPYGeemsg6jqtk/3ZdlREQqNXGU
	 iKBNBVyR83hUMyPuPG/XtR0qGjf8JbjenUSccMif6IfodncKiPrUdj2pKCftxJ/3fC
	 tcZSMgDzRjF2FUbV9cjsUoQklmrTRbIXX5qvOutKMiZslDgDOe/FwoThCCtfnfN0vQ
	 Qp3n3VFa3qX1PuBt3XAtgcERVUt/aH2OnqD/5FjkEWpT5bvKF/B989RyFugjBsOHTA
	 Bm6eD+leDYX4edhqz1H5pj+K3Ij2WFt5+gYrVXOMEIOrT037FlXjxtLevHTeJESAHv
	 GQWX3ZpuaqAkQ==
Message-ID: <4013b9a0-7d7c-46e8-b579-68a3b06de2a3@kernel.org>
Date: Sat, 20 Apr 2024 19:09:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] icmp: prevent possible NULL dereferences from
 icmp_build_probe()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Andreas Roeseler <andreas.a.roeseler@gmail.com>
References: <20240420070116.4023672-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240420070116.4023672-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 1:01 AM, Eric Dumazet wrote:
> First problem is a double call to __in_dev_get_rcu(), because
> the second one could return NULL.
> 
> if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)
> 
> Second problem is a read from dev->ip6_ptr with no NULL check:
> 
> if (!list_empty(&rcu_dereference(dev->ip6_ptr)->addr_list))
> 
> Use the correct RCU API to fix these.
> 
> v2: add missing include <net/addrconf.h>
> 
> Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Andreas Roeseler <andreas.a.roeseler@gmail.com>
> ---
>  net/ipv4/icmp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



