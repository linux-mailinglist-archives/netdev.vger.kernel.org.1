Return-Path: <netdev+bounces-151852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59C9F1510
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86ABD188BF6C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01441E882F;
	Fri, 13 Dec 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlRdTqV9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8B1E766F;
	Fri, 13 Dec 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115116; cv=none; b=hLqyMj6wNwKzVYdBwzJ2BsLLFMg4hn4oQAPPu/9i0EmxKbvNrymdBh1VPSNGly8t3tCEBsUoIgwoICHBjOmyREJ6eBdQ77GX5Y0/gDeDo4jwuOic1qSZLX7gkEndXJf+A2p8qwUn8cGMa0GN3MExrNVfagZ1EeKzWIkHTydc1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115116; c=relaxed/simple;
	bh=YdECUCP8bMmugbey+xGVES8PchuBNXXBe8V0WAOZO0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN9q7YsoPka80NJ3KKhv1YkhuBPQJHZv6kHMES3aUvvIKK9Qly332rhrllyqzFyjcUHZx/++nsOHNUBU9zk/4erPq49wfsz9gQF5k4djM20m6VhDGc5XmYm4B13Tu10u+dtFmdHoC2RWPS7F9UppSRh0uvtDj35FSCdScMGMBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlRdTqV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF145C4CED0;
	Fri, 13 Dec 2024 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115116;
	bh=YdECUCP8bMmugbey+xGVES8PchuBNXXBe8V0WAOZO0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlRdTqV9/LphXPkvitkNcwFMu9IVGpcuch0dH35aqqVfpvHXShBm7qzccI0a1M+AB
	 JmY1S8lMazrzBy0L1YSl3lkxEFvL9OOCPK68AtKDAfhAMA6/b3PVw7WQ+DFZmfJGbE
	 ROIy0s9DeSk4t/++8VD9jCyOf7wWnA7+3hb5LCUxRd+r4vbx+NmCBaM9/cPTIhJ1I/
	 1jJvgjxJmh5Kjm952P2xU/ByDJkz4+9EJ0srjlZqNx5rM+z+g0r6dnY0Ogc95FOTYD
	 7NjnbHUT/MqXZgeMq2wCDU2G2VYHLq5Tte3lNX2YohHSv2Y55Mgx5NymkPQhiOmMaI
	 R7csttpti9Ueg==
Date: Fri, 13 Dec 2024 18:38:30 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Zhipeng Lu <alexious@zju.edu.cn>,
	Dipendra Khadka <kdipendra88@gmail.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-af: fix build regression without
 CONFIG_DCB
Message-ID: <20241213183830.GD561418@kernel.org>
References: <20241213083228.2645757-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213083228.2645757-1-arnd@kernel.org>

On Fri, Dec 13, 2024 at 09:32:18AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When DCB is disabled, the pfc_en struct member cannot be accessed:
> 
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_is_pfc_enabled':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:22:48: error: 'struct otx2_nic' has no member named 'pfc_en'
>    22 |         return IS_ENABLED(CONFIG_DCB) && !!pfvf->pfc_en;
>       |                                                ^~
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_nix_config_bp':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:1755:33: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)
>  1755 |                 req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
>       |                                 ^~~~~~~~~~~~~~~~~~~~
> 
> Move the member out of the #ifdef block to avoid putting back another
> check in the source file and add the missing include file unconditionally.
> 
> Fixes: a7ef63dbd588 ("octeontx2-af: Disable backpressure between CPT and NIX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>

I think a nice follow-up would be to move pfc_en
so there is no/less unused space around it.

