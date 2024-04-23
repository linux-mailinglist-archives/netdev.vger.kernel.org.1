Return-Path: <netdev+bounces-90655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7678AF6BA
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0471C222C0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582F537E9;
	Tue, 23 Apr 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q71Nv3DW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE731CD39;
	Tue, 23 Apr 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897613; cv=none; b=kDGYEIzo2yL2eP5JCmoieTN/CYh/W6pe/ZZFemowCKj/wEVZOCs6HBI7M9J8SbTZBmfrx2SgSHJekWXPfWiQ1xdMOajJxJEb0uczzwoEKnc2RLcP2ZMpUXqh5jzfmKfOwyEahM+6n8/q/rQmMtwBm3cqkFpHju2Eu0YS6S61Tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897613; c=relaxed/simple;
	bh=ThM0dkHUHd9BFq7Itl11tNeAKPWyMMKwFqpa1Ol1kFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkKG+Cm7PXD6Y0Mdkbc7eXz70cslSAwrfkSWZJECLBKAr5WEX0iQKSWom0TCWn6U3fMkvGFOLbD0kgoMZOIvEV2gx+Au+0+H1kb7Y5nrVEy9zeyeccrUwj3ZkYKTDq48XAMjjNh0iuEY82U64H+Ukx4CKblEz8AkSjz3d++CK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q71Nv3DW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F0C116B1;
	Tue, 23 Apr 2024 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713897613;
	bh=ThM0dkHUHd9BFq7Itl11tNeAKPWyMMKwFqpa1Ol1kFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q71Nv3DWdZB5OeZUeWla7WxgboDD/bWp3ZWM5sNlfUrPMJQCQ2DuaXsbNxRDn89+o
	 TJbjlroBpTCOS7HqI8MlnrQY8GK//mc100ChzwnGL/hrOKa+3rikfVLBqpSC9AQZbC
	 qje6Er1tztJ8N/D/JhjfD8EM6BgK9lgJJ4tnvWaIVnh9emuHQ113dfgdLCR9l/jzxS
	 fyzTSjmIwYwFhSN5zOJNYsZxgr09Q+zZ4cxExYenCsGce9A+8u6XjGlcNK1gr7T0di
	 VN939SBTagn1ZutMmOVY5c1TA27Gaj8lHtQ+fU4w38B1Nnto9pQ3OUBzjNi7tmdwj2
	 l0VQJdVCO9Rdw==
Date: Tue, 23 Apr 2024 19:40:08 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	shironeko <shironeko@tesaguri.club>,
	Jose Alonso <joalonsof@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net] net: usb: ax88179_178a: stop lying about
 skb->truesize
Message-ID: <20240423184008.GZ42092@kernel.org>
References: <20240421193828.1966195-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421193828.1966195-1-edumazet@google.com>

On Sun, Apr 21, 2024 at 07:38:28PM +0000, Eric Dumazet wrote:
> Some usb drivers try to set small skb->truesize and break
> core networking stacks.
> 
> In this patch, I removed one of the skb->truesize overide.
> 
> I also replaced one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path")
> 
> Fixes: f8ebb3ac881b ("net: usb: ax88179_178a: Fix packet receiving")
> Reported-by: shironeko <shironeko@tesaguri.club>
> Closes: https://lore.kernel.org/netdev/c110f41a0d2776b525930f213ca9715c@tesaguri.club/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jose Alonso <joalonsof@gmail.com>
> Cc: linux-usb@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


