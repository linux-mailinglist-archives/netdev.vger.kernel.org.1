Return-Path: <netdev+bounces-183782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C3A91EE5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4A619E8149
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082F250C00;
	Thu, 17 Apr 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pTnm5dB7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E19250BEE;
	Thu, 17 Apr 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898120; cv=none; b=HSxayQEOmrErAn4cF5Qyc5qaDPmi2V3Z3UUnGKMJymXaWjjRYSeXOWqoDXLYkylNshrTJbFtMNmYg4SJv4V0iBNZUzHAGmLQiAOAhjdoiG5l1v4kBrLNGCsjv8taWnJWKpt1UtbL8Ps0z5wkmq6+JQ2encLN82uRF46q3/gfHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898120; c=relaxed/simple;
	bh=5lzD0TshOdrR27H/jD0A3Zp1OSldjowmx/m925ghKvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVBY+08xWT9Eb0RWH2J+00qxxFKuMooS3VOqo93Hg2PmbtOTV+2hAQLS9ls542zGuVpNm1UQJRbWRepA4ce639LzK34KN+TxdH2myXayWmVC7PaMBpayneqeGw/TobId6glql3fP8Wqu4YGO90SQrXOhyFiNad/l2kFmYN6tPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pTnm5dB7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MfEXm04TR9hSAuPlSBHlDuFQXlICktBrJoOYKmYwNLE=; b=pTnm5dB7K/QYer3+j7qstl9t2m
	u2mHR3vFF6A70hv4G+0XqpgYbW5aFq90v+P45JkGylwl9eejYw7PIr+FiZrDVtJ4ho7EGqdE1g2yr
	pYH4yrq67wGX8hDraLxcMH9f/micPho+mv8Deg0ldzXBv/b9R/3+ZUWUQK0fX3ZITMrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Phk-009n2J-NR; Thu, 17 Apr 2025 15:55:00 +0200
Date: Thu, 17 Apr 2025 15:55:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Nathan Sullivan <nathan.sullivan@ni.com>,
	Josh Cartwright <josh.cartwright@ni.com>,
	Zach Brown <zach.brown@ni.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	Hao Guan <hao.guan@siflower.com.cn>
Subject: Re: [PATCH net] net: phy: leds: fix memory leak
Message-ID: <f9f60754-ef84-483f-bd77-b7bc99aadb27@lunn.ch>
References: <20250417032557.2929427-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417032557.2929427-1-dqfext@gmail.com>

On Thu, Apr 17, 2025 at 11:25:56AM +0800, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> A network restart test on a router led to an out-of-memory condition,
> which was traced to a memory leak in the PHY LED trigger code.
> 
> The root cause is misuse of the devm API. The registration function
> (phy_led_triggers_register) is called from phy_attach_direct, not
> phy_probe, and the unregister function (phy_led_triggers_unregister)
> is called from phy_detach, not phy_remove. This means the register and
> unregister functions can be called multiple times for the same PHY
> device, but devm-allocated memory is not freed until the driver is
> unbound.
> 
> This also prevents kmemleak from detecting the leak, as the devm API
> internally stores the allocated pointer.
> 
> Fix this by replacing devm_kzalloc/devm_kcalloc with standard
> kzalloc/kcalloc, and add the corresponding kfree calls in the unregister
> path.
> 
> Fixes: 3928ee6485a3 ("net: phy: leds: Add support for "link" trigger")
> Fixes: 2e0bc452f472 ("net: phy: leds: add support for led triggers on phy link state change")
> Signed-off-by: Hao Guan <hao.guan@siflower.com.cn>
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>

Thanks for the fix. I agree with Maxime, this looks correct.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

The use of devm_free() should trigger any reviewer to take a closer
look because it generally means something is wrong.

    Andrew

