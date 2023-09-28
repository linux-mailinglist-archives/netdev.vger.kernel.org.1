Return-Path: <netdev+bounces-36771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2667B1B8A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1468B2814B6
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6637CAA;
	Thu, 28 Sep 2023 11:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE8374D8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 11:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B66C433C7;
	Thu, 28 Sep 2023 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695902309;
	bh=u/+AGQZZm+SiM9ktB+jXaWA0khtFcUnQM0ytfHWXFVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVJWBEPbmQ1AsrWdZbYoR0JX6ImPJMNyCHuGcXDB/8c6nnfANxbdTQxPQzz8Jfak/
	 dzGN0SzHJ4gjBDujvjVOyJmU1ygHBHcAkS5BspN9ld2AFtH7qwA9sfLwJINdS4Csqi
	 MuoNZEDFCWIVs8RDFNDnjyoiLhNs6WFFTv7d4lct10MV4LQJgh/253XvFse/7thAa7
	 4GWDJhaD2yd8MBVNJqs6JUTiEzA+RIInsxHSnthb7hGW9Z+c9x+X8lAl36D9KWgf9V
	 sOln0yEPivAuZDTbvwiiJITq2JTfNPmctiXerI914qVqX4/Lz9BDnGvKTfX/8ObkoI
	 y7r1HHp+x5Psw==
Date: Thu, 28 Sep 2023 13:57:13 +0200
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	srk@ti.com, vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: add sw tx/rx irq
 coalescing based on hrtimers
Message-ID: <20230928115713.GG24230@kernel.org>
References: <20230922121947.36403-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922121947.36403-1-rogerq@kernel.org>

On Fri, Sep 22, 2023 at 03:19:47PM +0300, Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Add SW IRQ coalescing based on hrtimers for TX and RX data path which
> can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalesing for TX0
>   ethtool -C eth1 tx-usecs 50
>   - configure TX0
>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>   - configure TX1
>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>   - configure TX0 and TX1
>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce tx-usecs 100
> 
>   show configuration for TX0 and TX1:
>   ethtool -Q eth0 queue_mask 3 --show-coalesce
> 
> Comparing to gro_flush_timeout and napi_defer_hard_irqs, this patch
> allows to enable IRQ coalesing for RX path separately.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


