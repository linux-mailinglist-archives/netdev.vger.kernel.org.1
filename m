Return-Path: <netdev+bounces-142976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CA9C0D3E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5ED1F2335F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63021315C;
	Thu,  7 Nov 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kQaYL3Pj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DE192B88;
	Thu,  7 Nov 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001861; cv=none; b=KnCXgV906Y3Vzg94L83XCAk/UNIRzwmQlvkMHtN7/LDwAAQiJzBwFDOHKVsRaL2DLQ3jXY7yhrpqQ9gkTypTbjhP/y1s/T/qo3PYLPgQ/QTWstF8C5y45o+Z76tZ4L7Ma88flJ2+pgMs3kmGud6Ydp40q1yCaf7oZGlBHwrZ4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001861; c=relaxed/simple;
	bh=z6UUxD61zEBXDyLdAhWREPy/j6mTf5UBn3AeWZqjzvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkAeulCkFjGKQPxvQ+SlK3v3sC24qKyEY//bWFhs+S3CJd0dfxVd2tY5k84LtlbW1P/oZIFmkJ52bCdIUIyi786fTa00jh+Wdr7v6C2cTq5/BXubky5oDzrFChphvpuysxIHYGvuFEOT285gTvhLk5nkJLZUfa5IcnSCxDL0EDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kQaYL3Pj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kEaAjPqxlbUokOSw8+r3h55hCl/NpE/YAzSPYHUSRiQ=; b=kQaYL3PjHeX16/mJR/vEOUQBDk
	DTH3LISANAp9xaYvaj+2MBtXMYhBoqrGpjv7YIyTFppfFsiTybVmD4E0jGyH9YZJ/24IRo4Afdr+k
	kqRpCepI9mBOLuPD/OuKI4HkOfMq+3ohcO+q38TeyyxLNXUXaURhD4AjrS+cQ6g9bF3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96ei-00CUXE-9H; Thu, 07 Nov 2024 18:50:52 +0100
Date: Thu, 7 Nov 2024 18:50:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 5/7] net: freescale: ucc_geth: Simplify frame
 length check
Message-ID: <479444a6-8ee4-47b8-82fc-947bea9087cf@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-6-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:52PM +0100, Maxime Chevallier wrote:
> The frame length check is configured when the phy interface is setup.
> However, it's configured according to an internal flag that is always
> false. So, just make so that we disable the relevant bit in the MACCFG2
> register upon accessing it for other MAC configuration operations.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

