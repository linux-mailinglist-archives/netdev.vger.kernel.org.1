Return-Path: <netdev+bounces-119334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C395533C
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC05B21EF2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16033145A01;
	Fri, 16 Aug 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nNBUsMgI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490EE145348;
	Fri, 16 Aug 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846823; cv=none; b=QKvRfg+bv3NXTXMLjfqb2hhLsaH74LKxwJbmYka82oOrqvaAnWYvH8qG5f+jFyTKr5/OPDREc7P4tqO9Z7inblOBuNAVZ2Cy/d7UUpUxGtTx5MAohsU7E+N4HAFxwtfoWkMlrq9ClCNBXONHkxJE7DSsKthzuQ7C7VaTixOmzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846823; c=relaxed/simple;
	bh=tiIqd3ZTo0VQlD1ZGjaX6/NkFoCtKN18i8iG4oM/NuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXXAtK/uVvJTblKqQnMqVm2USbYJVjnofEOcE0KyFXfrQOiWQhq9uJs1cAHAHH1MrFuD9hrpgeeC1ePlYZsDaI0SCTVRjnMUXFm1n06fSWcHxtRf/REFrIsA8WvgteR5YKdgBfC3UhG6VNAZ0VCsFAASV+NK4pIY9+LSpLAGaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nNBUsMgI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=julBlAj/xD2CErpPyxrVQd2GReW019eIF3ipPkI0unw=; b=nNBUsMgISEZeV0Rix+jYbH1VzK
	mbKx5sGoDkQg8Bipa1Kzv5F2YFqiFyImc/+ZfncgZnuKSP4FDAB7T5RheiTKO1GQUTDUqC5B8S99q
	J052mznoCJfZc8X9jhz6FX/SDiqh6dBtULcuVk+kZ0rb8gzymR25WXg0zolnQ/jzq5Os=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf5In-004y96-Lp; Sat, 17 Aug 2024 00:20:09 +0200
Date: Sat, 17 Aug 2024 00:20:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v2 1/2] net: phy: Optimize phy speed mask to be
 compatible to yt8821
Message-ID: <a34b1141-b104-4f02-a6e6-7cd363b06815@lunn.ch>
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
 <20240816060955.47076-2-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816060955.47076-2-Frank.Sae@motor-comm.com>

On Thu, Aug 15, 2024 at 11:09:54PM -0700, Frank Sae wrote:
> yt8521 and yt8531s as Gigabit transiver use bit15:14(bit9 reserved default
> 0) as phy speed mask, yt8821 as 2.5G transiver uses bit9 bit15:14 as phy
> speed mask.
> 
> Be compatible to yt8821, reform phy speed mask and phy speed macro.
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

