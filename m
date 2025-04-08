Return-Path: <netdev+bounces-180330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E357EA80FCA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B07BBD37
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A7224B14;
	Tue,  8 Apr 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy63/AB2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60339ACF
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125459; cv=none; b=kLQZvcDVEadX1b8pS9DUTO1NJpLJmN2hDH7SxudDb26H2MRePMH76UicNFNlluqQXdJDiidLqb2UuM/S+jPLcKRs42NwuzVOLfSdi5dSYV1QbMVmDYhZaYL2qAgOOFLQsDkNxWllde9CyE2gpumviE3MDIaA99D5xJmocJovFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125459; c=relaxed/simple;
	bh=L20RJp9qO1NuPfqvJNziH58Zeai3b/zTFQeZuoauvD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ieu3biNSq8l1g6dGCMpfnE5OfrUordL7cDNPG7NVVqEJnDA2TMrI5UMN9xfnAVCRMHedgsmQwrhd3qtH7DUVAyDncgZz8Nw0lzAavYWn0WtkzIj/0JMl7QgMBoJu0lKd5Fza6SROsOcRgSsDCfwLLXdK/o09d3L8qpmUjdFjw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy63/AB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA45C4CEE5;
	Tue,  8 Apr 2025 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125458;
	bh=L20RJp9qO1NuPfqvJNziH58Zeai3b/zTFQeZuoauvD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gy63/AB27M/wd1IrZ8lWY/RBrzeHjlSzZ3ko0yDgvNZ1uUVcSBgRBBlAsrxog9Z40
	 CtGHVQqDw06wPNVWjHsNhRa7eqifhkh7dshpoRylcmZ57z71gXgYLvoSO+LzMtMKdb
	 O7GTZFFW+D8H8ceY7ANbLPCyXTFvf3extDAYJPbA5Nts57FtHN+Lafx6RaOWkpZDud
	 iGbB5gVJUUy34iZffxn4m5LaqDDMaWx++Zj11MuvmMFYjrvc+gAmQ2W3hVtH6LFjQx
	 7CbjveYZRjb/J1F5W4p+tTgSexCpo+FpSXxZYf8ejyHs7z2uS6FWDYSvy2DQiZHsEj
	 Vz9U1drBkF3Ww==
Message-ID: <f5f89b3a-c532-477d-9dcf-7362de336777@kernel.org>
Date: Tue, 8 Apr 2025 09:17:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Align behavior across nexthops during path
 selection
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemdebruijn.kernel@gmail.com
References: <20250408084316.243559-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250408084316.243559-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 2:43 AM, Ido Schimmel wrote:
> A nexthop is only chosen when the calculated multipath hash falls in the
> nexthop's hash region (i.e., the hash is smaller than the nexthop's hash
> threshold) and when the nexthop is assigned a non-negative score by
> rt6_score_route().
> 
> Commit 4d0ab3a6885e ("ipv6: Start path selection from the first
> nexthop") introduced an unintentional difference between the first
> nexthop and the rest when the score is negative.
> 
> When the first nexthop matches, but has a negative score, the code will
> currently evaluate subsequent nexthops until one is found with a
> non-negative score. On the other hand, when a different nexthop matches,
> but has a negative score, the code will fallback to the nexthop with
> which the selection started ('match').
> 
> Align the behavior across all nexthops and fallback to 'match' when the
> first nexthop matches, but has a negative score.
> 
> Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> Fixes: 4d0ab3a6885e ("ipv6: Start path selection from the first nexthop")
> Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Closes: https://lore.kernel.org/netdev/67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


