Return-Path: <netdev+bounces-138851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271BC9AF2B8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFB7287480
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7741FE0F6;
	Thu, 24 Oct 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HHzABib3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE017623F;
	Thu, 24 Oct 2024 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798946; cv=none; b=JwaNQM9Ve+sDhhsM6YnVd4r80Lzn9UJYVZu4F8PGXzRZRcxbuuuDu8i8v3ki/aTL4THn8JM+ZwB025oHoAkPORIktUdKWWRw4GP8euhj7ppElLzz66SVDIoIK/RWcOpPIi98N7f4OIvc4eMpSXGHG9jzh0NDDS6hBLyuhZkuJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798946; c=relaxed/simple;
	bh=U6QvMDEsCbBxXoOMNUVPUVN1fBFMj89ipAdq5Id5ANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsDAFiI29uacPHmmGmUgiqV8aafO+HP6Nnd/zifJUET1dmvVDpByn5zBsJyxF8FJJt6sLfzfp2yc/cpUIHGOkT8tQQ1ilLvrc/dB+uLBj4Nhy0V02CPiVuW0lCA+2Lr4D/iyNvr2L4EUQEL+zi6lT+6B7wwnqwd3TJ/s/c4muHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HHzABib3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jLBpKC7zcJBqXTj7emAV29KYNBXdV6l3x1/fVs4h7m0=; b=HHzABib37F1LYKeSHWLrg0gp8C
	Ox6VTjVRU9uX+2h1O0JjgMRHLoH9EeU8/GvHyagB+AKv6Dhl9z3T5XRAGMJqV/QxZKww5G2phVJ+L
	RzADsBG9YodsoevaTstESgcpI8LqjLIjAccAirBJVOTRpLXTqWT5AAbmF4vxU0OuCJuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t43ib-00BAaJ-2l; Thu, 24 Oct 2024 21:42:01 +0200
Date: Thu, 24 Oct 2024 21:42:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v3] net: ftgmac100: refactor getting phy device handle
Message-ID: <fa1ff3ab-b5c0-4efb-9fd4-81815ba4dd2b@lunn.ch>
References: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>

On Tue, Oct 22, 2024 at 04:42:14PM +0800, Jacky Chou wrote:
> Consolidate the handling of dedicated PHY and fixed-link phy by taking
> advantage of logic in of_phy_get_and_connect() which handles both of
> these cases, rather than open coding the same logic in ftgmac100_probe().
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> v2:
>   - enable mac asym pause support for fixed-link PHY
>   - remove fixes information
> v3:
>   - Adjust the commit message

It takes a bit of effort to see it is correct, but it looks O.K. to
me.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

