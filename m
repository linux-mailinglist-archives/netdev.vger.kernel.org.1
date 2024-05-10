Return-Path: <netdev+bounces-95378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796258C2150
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68591C20B29
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43541635CD;
	Fri, 10 May 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT8diRdS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFEE1635C1
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334829; cv=none; b=uXPLClz2nSs9aUt8yVsqaPgYlMH4UfA4nmXxvYKnKfOhaLJDDu/NjnmKHpXS822c+kTZAryrm7KF2X0FnFWaaY0F0HoR4fH9sJ2KWpDcjhj2DoV9ne36/jcqyWmnU/vJQpSypy7rFMNqe+W8cjGPTV4NHStKrKiaODUyeFmUVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334829; c=relaxed/simple;
	bh=o5XMke/m8qdP8sUU9ygLwCnN5SRs3tMHEiWb530/y2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI2wa1fn+ZsyrB6w5eMfYGJ/cxjAvlO7veR+RHP9oE9eu4V1Aux3dT93vUb1Rpv9M2YIeLQ2EFRkFTXPee2q9wT6z8Z1qwB7EdN4A5A93PwzpSb6wyUgyrmVvle3cZYQflicRyEIQ/w/trP3Oe1TKyMok0YS+PLG01joQ8GwTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT8diRdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B92C113CC;
	Fri, 10 May 2024 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715334829;
	bh=o5XMke/m8qdP8sUU9ygLwCnN5SRs3tMHEiWb530/y2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT8diRdSn1CQP6T8crL+jmbsjb4Z0A20kBivBkqgHsSaH9l4UaNaZ21fmh4fa18HR
	 fxeYedkLW2wws0EJ1M444XXIvlJOSLeGUcn2OuoJ04vuWPs79aXr1tmYXkJwygA5N7
	 j3/fnaFIhuI1ugYh6WMP2E2tCL6D86bTXMavfSOhV446cGNd89vJ/WFftMyiFKVS5E
	 H/7l7QnYy77dvXFPl3AEkS2jgn5y3xlZTl7PVJQIV4kPAXwAPyRoz7gHiAoyAafCqX
	 G0tKs256tjuUHOQJrCJNK1TOagh5mMu2ktdSmXeIk/kFyWcSzvj7vPemya0QTR76kS
	 tsR4BKDolkTrA==
Date: Fri, 10 May 2024 10:53:42 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v3 net-next] net: usb: smsc95xx: stop lying about
 skb->truesize
Message-ID: <20240510095342.GB1736038@kernel.org>
References: <20240509083313.2113832-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509083313.2113832-1-edumazet@google.com>

On Thu, May 09, 2024 at 08:33:13AM +0000, Eric Dumazet wrote:
> Some usb drivers try to set small skb->truesize and break
> core networking stacks.
> 
> In this patch, I removed one of the skb->truesize override.
> 
> I also replaced one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
> stop lying about skb->truesize")
> 
> v3: also fix a sparse error ( https://lore.kernel.org/oe-kbuild-all/202405091310.KvncIecx-lkp@intel.com/ )
> v2: leave the skb_trim() game because smsc95xx_rx_csum_offload()
>     needs the csum part. (Jakub)
>     While we are it, use get_unaligned() in smsc95xx_rx_csum_offload().
> 
> Fixes: 2f7ca802bdae ("net: Add SMSC LAN9500 USB2.0 10/100 ethernet adapter driver")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> Cc: UNGLinuxDriver@microchip.com

Reviewed-by: Simon Horman <horms@kernel.org>

...

