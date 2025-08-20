Return-Path: <netdev+bounces-215240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233BAB2DBAD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB2C17DBC9
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630D2DAFA6;
	Wed, 20 Aug 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gVO6e4XX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA0219E8D;
	Wed, 20 Aug 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690646; cv=none; b=J8gsEKspEpfGtfpTV7vaHJJj2COl+N50okel4NEdbcb+dpDwNKF+doWxiHi7nl1AnGMb1JtmZW6MDGaLVME2ki6iRQ5RdgLlVdLPZv9xzuFnFe1YcaYPT1yPkcOcidRP4njGO8a+IO3KE9yS1a/kOg2JNRGoLlJ+RbEqOJq3AS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690646; c=relaxed/simple;
	bh=UFromHrRsf0eFQ0r2IUAwdJR52qB1xTJ/5THf8+c8wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq9mDHg7VFYZrmo5NcMWWMbYyfi2gQaymxuewYwteJR0a7n6cno16rCz+FN1S7qFPUlQeNsyTM+u7yMkWFR7YeuT7aCwZng88B5fA+F25/zJ9+0CjbidjvCELas0oO7Eh8lGgbuVKAAYnduqvBphCnkxWkDJOC3Qr8jwORDiMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gVO6e4XX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ufkVTHxVBuyxmr8RYXYQrx87GoJRgwyDH3U7ezovC8=; b=gVO6e4XXVUFWIuH5QSdV3rib7k
	P8CIY4WUkN2oreYgfP3kH+21ekt0P7yb9Nb2HyoWY8wetZQW3zIvsbTJlCEw9S0RC3j5UWgFBee+t
	6XpiiWvtH1sfaIIMlDX26WNgaN+yLi8Xp4fHRxH/u1z7BiscC6K6IKDuPTXjf2XBzdGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uohKl-005Je3-Kc; Wed, 20 Aug 2025 13:50:27 +0200
Date: Wed, 20 Aug 2025 13:50:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:LANTIQ / INTEL Ethernet drivers" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: dsa: Remove the use of dev_err_probe()
Message-ID: <6cfac11c-1489-4423-815d-07f0417cc7d7@lunn.ch>
References: <20250820085749.397586-1-zhao.xichao@vivo.com>
 <20250820085749.397586-3-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820085749.397586-3-zhao.xichao@vivo.com>

On Wed, Aug 20, 2025 at 04:57:49PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

