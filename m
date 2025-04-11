Return-Path: <netdev+bounces-181479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135CA851EB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5236C19E354A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF027C17B;
	Fri, 11 Apr 2025 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHeS7M9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561E27C175;
	Fri, 11 Apr 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341223; cv=none; b=hRTzqA+YEE2aAdacLN9a8NdGfYIFDlaAo+upLgqevvFPLw3qe7ToQTrig7gASka56rdCNxdxLvZMNCWyF1sVOuXJ1oVR10F/11QrpgwGelXPIIEF4LRvPX5tY67MdtDFQwX7GPKS7uwKUwYLgCVspqK/19g+5KZd1xuGjk5zPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341223; c=relaxed/simple;
	bh=Kxd1/K4Kw8r1pEXzeL4ujOBLRHH0U8GijbKbrkFGCyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYXGQb5/mXG3zfRyHM+yNCkDe4OAphvKB+nLj5gUNvv5aF537JNotBb8awVFDCj3rBPjidW/YVfm7C7X5hqQse5UWivUdopJLznuAd+g5/V8mzXWumyxEkMaHpK5Lx83W4trRlxneC8uXVPkQA+j+hHydG2AvhVjckpvwgJ31Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHeS7M9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABCAC4CEDD;
	Fri, 11 Apr 2025 03:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744341222;
	bh=Kxd1/K4Kw8r1pEXzeL4ujOBLRHH0U8GijbKbrkFGCyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FHeS7M9Ieb716BXN46FghNAOcXJewBPbNEqopbA7V9ybuRYjaqsmyn8IYEwC0qKrn
	 PdM4HhhzbA8L7KsdWl51WQrkN4Rij/BcjDozGweyReUFhIu+gZE+pLOQHt1z12APOA
	 ll15abvxEKL4xGxoK1wSWG0Z6axguCWRolhq8VbgELwSsjqvaohEvBwgqFdrqgcUBC
	 i4qyft4SZiL1cinTPPoWnWUQnrh3N86iaojJsOJbvxgy0/a952Cq0kv7btbjs6xMnx
	 pzmc7N6AAzA5sM69lmUntXylj0BtnGBZ9nkM1ysQDpg+kh15sl0GK08FToSsZoc+DN
	 0yoaut2nSGauw==
Date: Thu, 10 Apr 2025 20:13:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: <netdev@vger.kernel.org>, Joseph Huang <joseph.huang.2024@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Roopa
 Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>
Subject: Re: [Patch v4 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
Message-ID: <20250410201341.17660e10@kernel.org>
In-Reply-To: <20250408154116.3032467-2-Joseph.Huang@garmin.com>
References: <20250408154116.3032467-1-Joseph.Huang@garmin.com>
	<20250408154116.3032467-2-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 11:41:09 -0400 Joseph Huang wrote:
> -	if (err)
> -		goto err;
> +	if (err == -EOPNOTSUPP)
> +		goto notsupp;
>  
>  	spin_lock_bh(&br->multicast_lock);
>  	mp = br_mdb_ip_get(br, &data->ip);
> @@ -516,11 +516,12 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	     pp = &p->next) {
>  		if (p->key.port != port)
>  			continue;
> -		p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +
> +		br_multicast_set_pg_offload_flags(p, !err);
>  	}
>  out:
>  	spin_unlock_bh(&br->multicast_lock);
> -err:
> +notsupp:

One small nit, please name the jump label after the target, 
not the reason for the jump. So here "out_free" would be 
a good name.

>  	kfree(priv);

