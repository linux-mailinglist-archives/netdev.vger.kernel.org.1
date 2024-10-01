Return-Path: <netdev+bounces-131081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C598C851
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19118284D4E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B81CEE85;
	Tue,  1 Oct 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tS8MOpGM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EFF19CC39;
	Tue,  1 Oct 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822461; cv=none; b=bWL+CEEFslo02djHUnBI0K+ZY30TUEWymrhT4l4oJBSrILjLeolSAeUwf73jla9EntjFa/hexZod7J5UKnzjp4bA2TG8Q0lDcrO5xRaw3Rf9wDn76kn+cDHaxFb4IhFkSWlOmChy1KsbeYqTzy7dHLsyhwyieFA2pb5tHGKFH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822461; c=relaxed/simple;
	bh=G35ceyA3I/3jR4DoDBPzvc8A+5LW0y5ljnBt+aOCaCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJoYexb2ta570y5zPGw8Q1vqz+HY4bkpTkbxpKDDBBpJJdTmV1zmdothxlhUK3X6Qi2hlqtEA0UnzH20TARKllAtYdCLx8SXeZmOuzPw/mmMcIpIRMOQKbG3iZg31H8xVRGlMGlWw0m6hnxCTqv3+YnVPeL2hYzyK+HQm2bQZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tS8MOpGM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KNLPACdzNQO/8e/1Kcz1HNmYFsucLkPJcpTfmBawZsg=; b=tS8MOpGMWm6ZNfbwLAamiJcDdC
	U2DmC+hSFSbqqRlDUfAAkiq8o6ACsisE9+Vs/foT6WF32qXPebhFRwRNgEUH9kdjhuVttcB5rAUy4
	TmTZz/sXLGwT+a2QypAvB7IE9Xsnh649Oz8JUEX0Oma1JQD2HjvlmG6baK7OvKqxIwDk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlY3-008maQ-J5; Wed, 02 Oct 2024 00:40:51 +0200
Date: Wed, 2 Oct 2024 00:40:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	olek2@wp.pl, shannon.nelson@amd.com
Subject: Re: [PATCHv2 net-next 01/10] net: lantiq_etop: use
 netif_receive_skb_list
Message-ID: <975e614a-f37a-4745-90a2-336266b21310@lunn.ch>
References: <20241001184607.193461-1-rosenp@gmail.com>
 <20241001184607.193461-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001184607.193461-2-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:45:58AM -0700, Rosen Penev wrote:
> Improves cache efficiency by batching rx skb processing. Small
> performance improvement on RX.

Benchmark numbers would be good.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/lantiq_etop.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 3c289bfe0a09..94b37c12f3f7 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -122,8 +122,7 @@ ltq_etop_alloc_skb(struct ltq_etop_chan *ch)
>  	return 0;
>  }
>  
> -static void
> -ltq_etop_hw_receive(struct ltq_etop_chan *ch)
> +static void ltq_etop_hw_receive(struct ltq_etop_chan *ch, struct list_head *lh)

Please don't put the return type on the same line. If you look at this
driver, it is the coding style to always have it on a separate
line. You broken the coding style.


    Andrew

---
pw-bot: cr


