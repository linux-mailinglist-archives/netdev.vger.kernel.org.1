Return-Path: <netdev+bounces-119174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3E9547E7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E501C2162F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDC143757;
	Fri, 16 Aug 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBual/tS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A91AC8B9
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807129; cv=none; b=sMQYo/NiCxLn2xbRXjVWInciOd5BUaU+sXZB1Y1fcNLePNi3uZM8bCmt544hHyBIB8cRnYpuWcxVwLT0+rKuQzHTm7KPquU9kQ7swvJqnLICjs7Hwg7QO6J/Pg9zvT1I+p1fhCQvnJy+BQ/ScqQr9iP58O0RExq2dfm9z1e+wJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807129; c=relaxed/simple;
	bh=l1y+UbmxceefYhRGfYFT8JhcHTibXLS9v/Suh6jPF8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDpOG9js2Ltu2Be2LeNb7SHOYQMZC33Vd+BWjnAAewjYcq+6uS/qEzQZafYVwRSWalg1Yo3rjK0Z+qpzYQL5B3+wkJTgwv9RGoVVe9BNqu+mTmV6EAWHxQJLsX8nzqSfUdAn8iM93okHisUlS4vtp2ovUfBC6iXs1LxsgBQ5mHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBual/tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC3C32782;
	Fri, 16 Aug 2024 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723807128;
	bh=l1y+UbmxceefYhRGfYFT8JhcHTibXLS9v/Suh6jPF8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBual/tSho0zJHtfqB4L8uNH7bbgG59BlC7EJwrylEvoM4XN/9jcSYIvknJeGhqTP
	 wkVwY+a98VJO8nCMYfo23r5c1xb1kO78pmsHYpYB78COk8EwVPsKlTxMGTN0fk5t7t
	 B+JrbLUltSa2bH11TFzBW/IJl0HPJV792e8WnG0et6SFwgCBRo3IzSfEfBzw8y3bFU
	 M6IBZrR9oTfHqAgtvznJFVU2MyEBrXeSrR8NK6KX3nMuY1nRnn3RQmPiQXjvd1T/MU
	 TcAGGDYk2VqGtBoML+wQcTnODm0QEZ6L2yG7TI5lcDLksk1SY1dVqWaEuVsoJuIIMh
	 2ycxShIt8PfzA==
Date: Fri, 16 Aug 2024 12:18:43 +0100
From: Simon Horman <horms@kernel.org>
To: Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>,
	Craig Taylor <cmtaylor@apple.com>
Subject: Re: [PATCH netnext] mpls: Reduce skb re-allocations due to skb_cow()
Message-ID: <20240816111843.GU632411@kernel.org>
References: <20240815161201.22021-1-cpaasch@apple.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815161201.22021-1-cpaasch@apple.com>

On Thu, Aug 15, 2024 at 09:12:01AM -0700, Christoph Paasch wrote:
> mpls_xmit() needs to prepend the MPLS-labels to the packet. That implies
> one needs to make sure there is enough space for it in the headers.
> 
> Calling skb_cow() implies however that one wants to change even the
> playload part of the packet (which is not true for MPLS). Thus, call
> skb_cow_head() instead, which is what other tunnelling protocols do.
> 
> Running a server with this comm it entirely removed the calls to
> pskb_expand_head() from the callstack in mpls_xmit() thus having
> significant CPU-reduction, especially at peak times.

Hi Christoph and Craig,

Including some performance data here would be nice.

> Cc: Roopa Prabhu <roopa@nvidia.com>
> Reported-by: Craig Taylor <cmtaylor@apple.com>
> Signed-off-by: Christoph Paasch <cpaasch@apple.com>


And one minor nit, which I do not think warrants a repost:
netnext -> net-next.

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

