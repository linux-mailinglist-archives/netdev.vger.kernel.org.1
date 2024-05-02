Return-Path: <netdev+bounces-93060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D48B9E17
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2FD28879C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4B15DBA8;
	Thu,  2 May 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVmLgpBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316515D5D1
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665751; cv=none; b=d/AUamYvAa2AcBsSQqhQskZKTnaRmCWA86wFuQpNBjp3Z060G/ece8AV38jkfmMoRAStKksk06U1DxCGoaIvzDoVd0nKY/gh7KNd91PEry5aRRvOK2wpWTpT247NB3A5h+ZbhtlpHgFs78Wr2BN8MWwJEFhrEymmg0QFKPS2Z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665751; c=relaxed/simple;
	bh=RM6eEEPuAXHdm3YPEf5G8m3NtFVA0ZgnkYt9iKb8exc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIvyebQQkMz0JHE5P6JdSlK33BgwszVTGI0HMcgYeSAk7FaZGxi0+31lDLrmxvB/YIZImLug8w6Kutw1GgOrFKojcJyPwSYQ5kcFVwqriEGqSSNffj245Tup+ZXnR5B/1SuupU8+uepSumFIxfUMxa9kzU7uzWzKKIGad61gwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVmLgpBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2D2C113CC;
	Thu,  2 May 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714665751;
	bh=RM6eEEPuAXHdm3YPEf5G8m3NtFVA0ZgnkYt9iKb8exc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aVmLgpBJqUTxoxOcEabdhNGSeM0PMrep2DTJG6Su32+cD0GfC5mzBzVEPT+93FZfz
	 NNrp/69xJkTfrSr9L372zatYMTOwakRxd3J5dfL24RKYKbaOXPIVcqDEC6wEHNiGtL
	 Dpmt44iQlzl1Uy7U1BeU3qeFHO7m/srDNrkOCDpllkaJ3ycyevNYigb2SfTIi7Y6U9
	 pG5JuyzCkZdJiiOHDWqp+4Yk2lIfJQpElL8HKQO6/Czvt/EyXkgxV2k5GdmV6pn9QA
	 MZ+LCoqr+aFCqiFgAL05rKt2hvzyJnbjZJ47ZBrxdGdZeiNj5lHVcqg8pgT9+omPoq
	 NBpIAvq33XrYg==
Message-ID: <40af8207-c02a-481f-8e1a-9ac2b7d21277@kernel.org>
Date: Thu, 2 May 2024 10:02:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] rtnetlink: use for_each_netdev_dump() in
 rtnl_stats_dump()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20240502113748.1622637-1-edumazet@google.com>
 <20240502113748.1622637-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502113748.1622637-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 5:37 AM, Eric Dumazet wrote:
> Switch rtnl_stats_dump() to use for_each_netdev_dump()
> instead of net->dev_index_head[] hash table.
> 
> This makes the code much easier to read, and fixes
> scalability issues.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/rtnetlink.c | 59 +++++++++++++++++---------------------------
>  1 file changed, 22 insertions(+), 37 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


