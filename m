Return-Path: <netdev+bounces-115357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB3945F87
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F075D1C214B8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E71E4863;
	Fri,  2 Aug 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQmvJyEq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364813C914;
	Fri,  2 Aug 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609630; cv=none; b=FRYudCZ+OfbIFtQF4+77kLGzY4mTkp4LWPpLFg9FrtmXbqGQDxmvMyVw/wCXwqrf3g9CUdsOHmCXV054XUMrNAkn89HC4cKDt4Cdp6DDJoIdUKVi6vfQp3c3wP3/Up4uL2pl2GAxf4/p5ImEtswaD6XGl9IJ4piaxKfjHf8vbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609630; c=relaxed/simple;
	bh=3nZe6efvp7p7Oe1KMkHCZ0W0GKAvWNi0nrsXS6fzg9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giB4LSAH5+4NoaeVfDbthoFxNddMAQhrFy0nlsZ2oZmJLrcujEYU3VZFuKQM+9p4QcLxRbN3FmDD/V2EIGazmCzQcr74ELvF438vapmd+5Wi6nOCDHI+o/BMDDcFMRwgxR0U1725DNvxRaz9vi3zv5rdPV3dVhH6gD3gYq+4hR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQmvJyEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF829C32782;
	Fri,  2 Aug 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722609629;
	bh=3nZe6efvp7p7Oe1KMkHCZ0W0GKAvWNi0nrsXS6fzg9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQmvJyEqF5s8wlcEdNT03TXawctzlrb9hl/rnd4uG/zQHXVYtizy4jD/gfIy6fb8v
	 dRIrBhasQDyCMfGoboarpdOm1bKP7YUf2APnJ8d/+IFs+0P9TpWBm1TRK4+0wZWuzG
	 /a/UUSPKEDqOpbQOOUmnVO3fLxP6Z4HUNIAMU9pziQh27HRpvT3wHoQBK4+wN6QTjZ
	 R3JTIxo/tdwbrVX3h6QeLTNYpjeaGsDgtr1OX73wGgortj59XLP5iHm9UHlPeCKTMx
	 xWnUsXAe3OHZcLX2Zkg5Zintko1x266buP5IT+2LkrRdsGchiHMM8dLaRgsJSS3r+J
	 R8i26GL0QUUhg==
Date: Fri, 2 Aug 2024 15:40:25 +0100
From: Simon Horman <horms@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: cooldavid@cooldavid.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
Message-ID: <20240802144025.GC2504122@kernel.org>
References: <20240802054421.5428-1-yyyynoom@gmail.com>
 <20240802141534.GA2504122@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802141534.GA2504122@kernel.org>

On Fri, Aug 02, 2024 at 03:15:34PM +0100, Simon Horman wrote:
> On Fri, Aug 02, 2024 at 02:44:21PM +0900, Moon Yeounsu wrote:
> > `ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
> > Therefore, we should use a well-defined function not a bit shift
> > to find the header length.
> > 
> > It also compress two lines at a single line.
> > 
> > Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> 
> Firstly, I think this clean-up is both correct and safe.  Safe because
> ip_hdrlen() only relies on ip_hdr(), which is already used in the same code
> path. And correct because ip_hdrlen multiplies ihl by 4, which is clearly
> equivalent to a left shift of 2 bits.
> 
> However, I do wonder about the value of clean-ups for what appears to be a
> very old driver, which hasn't received a new feature for quite sometime
> 
> And further, I wonder if we should update this driver from "Maintained" to
> "Odd Fixes" as the maintainer, "Guo-Fu Tseng" <cooldavid@cooldavid.org>,
> doesn't seem to have been seen by lore since early 2020.
> 
> https://lore.kernel.org/netdev/20200219034801.M31679@cooldavid.org/

By "Odd Fixes" I meant "Orphan"

...

