Return-Path: <netdev+bounces-162735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB3A27C5A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7473C188323B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9532063C9;
	Tue,  4 Feb 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OARTj0DF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFA205505
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699426; cv=none; b=ghiNTquoMewRoWSnZcdPN8zNNjin1WtimZfH8ghasJwe05r2e0XaCT8aVBRR7OdpS6kVfKuJPUmHEwqHH59tj6lTnO9ktHHHnxVdlJCOPurFlFljdj3psqOKe8dG+lHKZ6v00ljnJPXr3FFJGbpalKRT/Lo0vJZRSQlZAb50WR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699426; c=relaxed/simple;
	bh=PlNZhCVigeJkNYhsqXkNNaJXewI0vLEfVqC4jKBkxGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smH4ZoFXS/WCNLpsKL3D7iHEW0SPkcuIOplhEAENHM519Kg/qcmVgg+zJoLA6KtijJXuov751l0MYDJP687RGGmoa8GaOnMhT72b4lKzV4qdF/vfZ3tIHOmSIXomexv4EAk5ETYobFNSGGutoRtPiYUNdUk8Sn2PP+KT5/+RqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OARTj0DF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B87BC4CEDF;
	Tue,  4 Feb 2025 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699426;
	bh=PlNZhCVigeJkNYhsqXkNNaJXewI0vLEfVqC4jKBkxGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OARTj0DFbHYFhXwIPRKAtVTs0QZYeNoaPf35miEzGXL5CpSNfhk/z8GPHNtm0ARiU
	 bjXzfFqB17oA3jmsr+5e6P+omY8mTDtjdjpmHvUnWYcLa+dAbTcXnQPIrXS6RnPwrY
	 yEKs9lF/oMZCWFXI9q2sQQoOJuyJh3oFrgRFLJxl1E1DpFE+nV/J7tono7pgTVnrvM
	 dC332yxOVQKB7OcCfDCToS/5rg1wEnHluy/2l0F7nYVZmvQlbguHdTqE0TnfDfP1lj
	 HrpQc8xIbfz3WmohO3x8gObdwobbAK1LlgmYvJV97X4LhK1YprY518Q9Aa9FVbuiG+
	 xdy6TSEZoKoTA==
Date: Tue, 4 Feb 2025 20:03:41 +0000
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, amirva@mellanox.com,
	petrm@nvidia.com, joe@atomic.ac
Subject: Re: [PATCH net] net: sched: Fix truncation of offloaded action
 statistics
Message-ID: <20250204200341.GN234677@kernel.org>
References: <20250204123839.1151804-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204123839.1151804-1-idosch@nvidia.com>

On Tue, Feb 04, 2025 at 02:38:39PM +0200, Ido Schimmel wrote:
> In case of tc offload, when user space queries the kernel for tc action
> statistics, tc will query the offloaded statistics from device drivers.
> Among other statistics, drivers are expected to pass the number of
> packets that hit the action since the last query as a 64-bit number.
> 
> Unfortunately, tc treats the number of packets as a 32-bit number,
> leading to truncation and incorrect statistics when the number of
> packets since the last query exceeds 0xffffffff:
> 
> $ tc -s filter show dev swp2 ingress
> filter protocol all pref 1 flower chain 0
> filter protocol all pref 1 flower chain 0 handle 0x1
>   skip_sw
>   in_hw in_hw_count 1
>         action order 1: mirred (Egress Redirect to device swp1) stolen
>         index 1 ref 1 bind 1 installed 58 sec used 0 sec
>         Action statistics:
>         Sent 1133877034176 bytes 536959475 pkt (dropped 0, overlimits 0 requeues 0)
> [...]
> 
> According to the above, 2111-byte packets were redirected which is
> impossible as only 64-byte packets were transmitted and the MTU was
> 1500.
> 
> Fix by treating packets as a 64-bit number:
> 
> $ tc -s filter show dev swp2 ingress
> filter protocol all pref 1 flower chain 0
> filter protocol all pref 1 flower chain 0 handle 0x1
>   skip_sw
>   in_hw in_hw_count 1
>         action order 1: mirred (Egress Redirect to device swp1) stolen
>         index 1 ref 1 bind 1 installed 61 sec used 0 sec
>         Action statistics:
>         Sent 1370624380864 bytes 21416005951 pkt (dropped 0, overlimits 0 requeues 0)
> [...]
> 
> Which shows that only 64-byte packets were redirected (1370624380864 /
> 21416005951 = 64).
> 
> Fixes: 380407023526 ("net/sched: Enable netdev drivers to update statistics of offloaded actions")
> Reported-by: Joe Botha <joe@atomic.ac>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Thanks Ido, all,

I agree that this function operates on packets as if it was 64-bit.  And in
a quick audit it seems that all callers, except qfq_enqueue() pass a 64-bit
rather than 32-bit integer (I did not check if the values passed can indeed
exceed 0xffffffff).

I also agree that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>


