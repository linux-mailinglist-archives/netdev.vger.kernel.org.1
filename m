Return-Path: <netdev+bounces-150216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EC9E97C9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1DA1888CF6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2073595B;
	Mon,  9 Dec 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aieOTtCn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869D35953
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752244; cv=none; b=W/aCPOKunwMHa3akJzb1Fa6ejsxkmcs7n5XwLLBQi0iepCy1nuFfgUBW2MTSWTXSa8UAqD31Oq0vTLSP1L08m/blu/LGBfUl3miZDkndtzrFFR2+/AkEMaCrAySnwCule2Lg2oMsqp+fhGXk/JM86wxcaPupR97qQJTenDPNYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752244; c=relaxed/simple;
	bh=vZFXHrLugp1XfkeP/xEO1YcdXTBWg4MmsYHWcJ2NHKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1paC8l4xf9Vv8Ai5lnOzPnPbytrWYtvingjh1JqwhTbbfihGBgcdNaj+nagjbDNtaUf9rRJ2WtQcwBzQ37RWQJVL9QE9iscB9T4MX+aMPPtiD6uhvEN0+/lTJq91xAKGeBvDoOL6mU0QsDDN7TkBydmvnmbg4q7dz6gkKKM0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aieOTtCn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xHmv8QzjpWkFMDUgI9IVmjjbM0qshsGjce0ouIEXP3s=; b=aieOTtCnPCokXrMn+LDh4CGLnB
	W+gEGocFuWZX8oGnyb12bZ4s5w/6LZTmwwg/DR7ECSnUAA3p9bBG28huZZUOXYUIA+8yRighOD11F
	BGJvy/pTVUKIUEG3J5xXlgQESdqinF8ZfhwWk51Jcg5K3uY3jtuF90MsWnImsx9mTrTU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKe9o-00Ffw4-VT; Mon, 09 Dec 2024 14:50:40 +0100
Date: Mon, 9 Dec 2024 14:50:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tian Xin <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 11/16] net-next/yunsilicon: ndo_open and ndo_stop
Message-ID: <66fc273c-8c1b-4147-b8fa-cb0e250180ed@lunn.ch>
References: <20241209071101.3392590-12-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209071101.3392590-12-tianx@yunsilicon.com>

> -static int xsc_eth_close(struct net_device *netdev)
> -{
> -	return 0;
> -}
> -


That looks odd in a new driver. I assume the function was put in the
wrong place in an earlier patch and is now being moved? Please fix the
earlier patch.

	Andrew

