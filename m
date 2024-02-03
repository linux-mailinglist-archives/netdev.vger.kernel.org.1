Return-Path: <netdev+bounces-68865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED348488F7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725141F2392A
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10112B9E;
	Sat,  3 Feb 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iEb8p+t0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9C12B80
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995638; cv=none; b=daIv0urKwu5kSOLpEUPVlO6lmYjdwNpTiuJjy1cd/od2bdPXopK4A8rJqMVZgd0Ww45X/mCPAyrVO0Igdqg5NFoWkhozI+LNSSCvyWiH2I5wtUiwW/b8DV+5YOs5DKDv4MmKGW233gSj/9CHROH19X1ZlMpjU3Abo8eVRPEQ27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995638; c=relaxed/simple;
	bh=W1ccS6qOBb9rfZ8f4vHQElQ5+2Zuy3VsZ3wIVc4ZgMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBE609LRHlHdwB+Xf1tAeS2TdkSS8EuD72PWIBd+8NQEA19Jj+WmRIJP/ZvWMEN7UpQhvz7MdAH//oylqRKyD47sPZYM3i9Dz3p/SVUjOpgRrcGTz3u/Ha0V841YUrTC0rwS8Sk5s5xwJdHlFXiW/PX3kzDS0eoxNoMGMfMjwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iEb8p+t0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kXbFX3GmS88bUU2saO7XyQAR431ERG5byQEOstVJs98=; b=iEb8p+t0IvI0w5mtoAxtN3B0d2
	kEG84NQa3wzYVQpFMCb4h9YzQzGBT2j6S61isMvO6NlcDpKzwaVCzv0n4Ojt/hGFNdTFqHzlkkqON
	VU88mBBO86NMpJWPecH7lY2qt6nXSTphCPH/JmVKJJSlnPppoA1IULuXwmYBca9yyVJk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWNXY-006vXc-35; Sat, 03 Feb 2024 22:27:08 +0100
Date: Sat, 3 Feb 2024 22:27:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] tg3: convert EEE handling to use linkmode
 bitmaps
Message-ID: <2f5220c8-06db-4d82-adcc-74d5d1f45db2@lunn.ch>
References: <0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com>

> Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
> in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
> the current functionality.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

