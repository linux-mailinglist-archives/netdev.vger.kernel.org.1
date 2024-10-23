Return-Path: <netdev+bounces-138127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF98E9AC120
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DAA1F210AC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925E1514FB;
	Wed, 23 Oct 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZxvusKO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941661C2BD
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671149; cv=none; b=n6I1CN2clPQeW1RtBMrRpJLcp/u461ui+BbGioCzsfLbnAfA65TFWnV6ALw7RueT3h9cZtAxCuQvDABGAuTZ+y+5WhHFDGKGQ1ZsD6HMmEcVJRHthfL3lr0u3OsM1h/ZB2Jj06XyGr+iLeAKdK1NBzIBzqoBdfBwSYP2lsRMK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671149; c=relaxed/simple;
	bh=Jjrw7Aa9EXghQc04YRM97m3oLtHh5j/b9bDaktqmGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0p9a6Ob0XbgZ8UTbAAj/bBNT12TTaDu+Jy+ysi/vUrBTYroX/BMhXY+1fpCGfh35SC0sfqIcH8gUa+rlVJKDLlMsNcP51tSbA69sF6ybRFGvIXfk7nkQZMXLriEa77JqHDz/AjDCpDZv7rkzDmoW6xWK9F5X6Fu1RYiUvDh1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZxvusKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0685C4CEC7;
	Wed, 23 Oct 2024 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671149;
	bh=Jjrw7Aa9EXghQc04YRM97m3oLtHh5j/b9bDaktqmGec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZxvusKO3gusRMCJP/MryWMTRiuWnhM9IHtqYhaY1hTGWi+vLfT79O0HEa4IoFCnS
	 EjUajMXEaX+94Y6zhN/IOMPis+Xb/WOy6Lnr1xrvkvaKsuBHB64Ffk7MXzZNsaqnIy
	 0QyaL+NBiWrB8IZr41RREQ2OXebb3rcYNFuD91z4CgsVgYKLfBuA0ynfHoZ8iPku6E
	 g2G0EJY+KSNj08Pp99g+srdBw9MBpr2fpRPB1CN8ZN71PjR9Igo0/B39GfFdP6D9Ia
	 PfidsXzPKcqXcMbUf++FszxDp9tOkv2xNPJLU/wLurlw2kHEHfZCxdTnmb17wv5dbH
	 bqbEM9fd+y2Mw==
Date: Wed, 23 Oct 2024 09:12:25 +0100
From: Simon Horman <horms@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] bareudp: Use pcpu stats to update rx_dropped
 counter.
Message-ID: <20241023081225.GK402847@kernel.org>
References: <959d4ea099039922e60efe738dd2172c87b5382c.1729257592.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959d4ea099039922e60efe738dd2172c87b5382c.1729257592.git.gnault@redhat.com>

On Fri, Oct 18, 2024 at 03:35:28PM +0200, Guillaume Nault wrote:
> Use the core_stats rx_dropped counter to avoid the cost of atomic
> increments.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
> I'm using core_stats for consistency with the vxlan implementation.
> If we really want to avoid using core_stats in tunnel drivers, just
> let me know and I'll convert bareudp to NETDEV_PCPU_STAT_DSTATS. But
> for the moment, I still prefer to favor code consistency across UDP
> tunnel implementations.

Hi Guillaume, all,

I think that this patch improves things and the suggestion above
can be treated as a possible follow-up.

Reviewed-by: Simon Horman <horms@kernel.org>

