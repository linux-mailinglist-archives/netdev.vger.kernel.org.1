Return-Path: <netdev+bounces-148754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7CF9E310A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C11D167ACE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0417BA6;
	Wed,  4 Dec 2024 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3/CNdVWO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537617BCA;
	Wed,  4 Dec 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277565; cv=none; b=ZMMQSUW9pKOSMxHc8YOEd0qnWzXASbMhX81jOm11IP24HkFaSfbfRxgJQxB5LnBTxrvh/9scC2hEHJK8a9f1823LKWWINPVEaEdAKnGTGWm0EK9PKuOF9yKJdMzoDbZQGsU2yQHGf7bQA/cjbRKPhWQNuE0eGDXkIq+10az+DLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277565; c=relaxed/simple;
	bh=EaWlY3Rladrv6cDaoPGIjofHMmMBKH9l1LuuJ3xZlDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdmPSaBHsHb+NQvvkIQlGt2kkorixFZVc87l9LUXXSmIi8ln11Z9SrUCX80H1zcQHP6NqK3wNN23bjSjj2jn0+Wbd0bNyEVRVbBmlHTFWhw+G1lIqumvKNhl0o26a9Eq74tjN7pIXptCuZT9UGRM5NCNkCsAJQetjtjw1XXEtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3/CNdVWO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p7XICfgHZc4blY4tthT+SlGoVQXR/wj9/bfgbTsdLZ4=; b=3/CNdVWOu8G5hnNE12k/JqJKGV
	tP8eYD01gnFW9Wldi8/lJ/pRS+drZA1UmDy9UsYPvebfwct2xdVkTZV35h2vV62kNnsy78G00+wlf
	ikww15oNLSXSRdla4ckdXd2Hp6Xkddq3NC5h3+az6HTjfKtVEoNGxQc618mmifXLlhjM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIefd-00F9cF-Ut; Wed, 04 Dec 2024 02:59:17 +0100
Date: Wed, 4 Dec 2024 02:59:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 05/10] net: freescale: ucc_geth: Use the
 correct type to store WoL opts
Message-ID: <364e20f3-855d-423e-aef8-ab7126155457@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
 <20241203124323.155866-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203124323.155866-6-maxime.chevallier@bootlin.com>

On Tue, Dec 03, 2024 at 01:43:16PM +0100, Maxime Chevallier wrote:
> The WoL opts are represented through a bitmask stored in a u32. As this
> mask is copied as-is in the driver, make sure we use the exact same type
> to store them internally.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

