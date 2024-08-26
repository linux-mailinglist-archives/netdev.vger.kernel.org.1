Return-Path: <netdev+bounces-121762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3895E691
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 04:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959B91F21279
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DB5256;
	Mon, 26 Aug 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y4mXSZ5H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC228F7D;
	Mon, 26 Aug 2024 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637600; cv=none; b=jZmmv2e755EYk95Gf+DvzAhPXFquhGhFx9ItNCaTRk1UrDp3TgZrQafYmVMVhFiZ2mVXjPjjtccer6o3Sg70Q1kZqYW3NTnUE7szCxTY4vV5p/DYdAcibB8C4pJoB5Cc0abmMew+d+aVe16f8KzelibS4QA6ybusRJ6l5VciCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637600; c=relaxed/simple;
	bh=ZLbkXzvsNWm/KODjTFp/XZXyWk9WKGEvbM+97lRLxrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msUqQfmFd1Ki838lUFMBVGyzyuVdGhLPlULzBNUvgJbtVIlb47dRZQqm2xXA6ugEb5fy+tIx6OZwZb3ytuuvQkMWA/hkrRBLtBNBGfg0Cy6d7tlzAnP/uuI6zOkLUzp6GkuB3eKYW2Mcw3c5uoA92dALAp85GzVVJbbJFE08BDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y4mXSZ5H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O7vvI1LQks25JwfjGjxgQm47rsMQqZ5j18xTA+Di2GU=; b=Y4mXSZ5HdgxMVRLnkRdPLFn+ec
	M3LbLFMJL1JvEQhXfOKOfhjFoLJ6gU7Eq8XbUt6e/R68UzK4i0OqMY1sZbK2myx0Oc1B4UOP8R2zc
	ePEt7Vb7+1kfZ2pyYbJYvRHfb+kRvKnyUBilH9CtjwdCLCe1i2ecLr4l5Oj3d3K9i3yI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siP1I-005fIP-8G; Mon, 26 Aug 2024 03:59:48 +0200
Date: Mon, 26 Aug 2024 03:59:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v3 1/2] net: phy: Optimize phy speed mask to be
 compatible to yt8821
Message-ID: <a4fbc34b-5d87-449a-83df-db0cfc1bf3cf@lunn.ch>
References: <20240822114701.61967-1-Frank.Sae@motor-comm.com>
 <20240822114701.61967-2-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822114701.61967-2-Frank.Sae@motor-comm.com>

On Thu, Aug 22, 2024 at 04:47:00AM -0700, Frank Sae wrote:
> yt8521 and yt8531s as Gigabit transceiver use bit15:14(bit9 reserved
> default 0) as phy speed mask, yt8821 as 2.5G transceiver uses bit9 bit15:14
> as phy speed mask.
> 
> Be compatible to yt8821, reform phy speed mask and phy speed macro.
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Ideally, your Signed-off-by: should be last. No need to repost because
of this.

	Andrew

