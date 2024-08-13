Return-Path: <netdev+bounces-117988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7C9502CD
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FED42873F8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493619884D;
	Tue, 13 Aug 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BhXC5VjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89C16B39A
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546024; cv=none; b=lDFHmp88atLNIQiT8pODQlUezvCSC0RuGRjOwbAT1Wi4dqMl6c0HBhHrUjY2MJ+tX32sypv8sqBaTg5Mi23Z/+y890vUPfuJB5wpZp8s0CaNiWcgasD8e4DYC72uesM4di80mgPcGH5BRd9gWNaBfYsAlACj27h92P+EE0V7UI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546024; c=relaxed/simple;
	bh=VKt67MYl44lrvEeeMgipAY7ICHITo+R4PDlLhG0wumo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBasCv+fw5n+amc16cjj9C++vdK6dDbRBpN+bItotKQD8tFYFuxHdhRxdLBuNkF0Prjg6+55xPrxHf4SpzEIEYAx7obQnPsNFdnflsgs6f3hcOQMBjpIYQU2agNiSEch754XV2G7qGwcZeVyCBCPFrKy8mmemOstvJ85pmN72AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BhXC5VjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527EFC4AF09;
	Tue, 13 Aug 2024 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546023;
	bh=VKt67MYl44lrvEeeMgipAY7ICHITo+R4PDlLhG0wumo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhXC5VjZMZqWFS1aguWAS+iiDFNfrNKZjE6BfhN7umbDhvXj/Np5k5ecagvE5gkDe
	 nPTAdHoLzP77ZYWsadO+TtcXP5J3ElTB2n/uT5/xZDWV2lqZXoQNurWJ2gYKsZ6lG5
	 Fh8prrpjTKtWYy34pJk7iB64fBnD3MFFEhV26ulI=
Date: Tue, 13 Aug 2024 12:47:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: stable@kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH stable 5.15.y] net: stmmac: Enable mac_managed_pm phylink
 config
Message-ID: <2024081350-lingo-uncooked-32c0@gregkh>
References: <20240803113044.2285-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803113044.2285-1-jszhang@kernel.org>

On Sat, Aug 03, 2024 at 07:30:44PM +0800, Jisheng Zhang wrote:
> From: Shenwei Wang <shenwei.wang@nxp.com>
> 
> commit f151c147b3afcf92dedff53f5f0e965414e4fd2c upstream
> 
> Enable the mac_managed_pm configuration in the phylink_config
> structure to avoid the kernel warning during system resume.
> 
> Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Now queued up, thanks.

greg k-h

