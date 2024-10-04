Return-Path: <netdev+bounces-132249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF437991215
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2071C23324
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF73147C86;
	Fri,  4 Oct 2024 22:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F143140E50;
	Fri,  4 Oct 2024 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079347; cv=none; b=CxNx6tawfd4l/FWwHxvHPRoFgmp9ExKjbYhLUI0HNKKgpEm+gbArHfHEnx/2/fH/2OOG0GzmFAL9zxnI7DLBlG0OGsj6rzyE8gbADk8panQYIcm8dzjUD/dlLNe4ecI0LPGtnlSmtD81/7qYuCFRb3PFOD++neyc/5FOsPRUjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079347; c=relaxed/simple;
	bh=Y5Zp0NtxDlZ8LvFkxIEgQFAHbtGPzd9WZpF7R8Wkx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUujPAcXuj7Kd3rwhpC4/lRncL/f2Pni4vLS3cpUMRhz8TKJHfubkaxERjjSRVBQ9Q5jtR82RHRKnIS2eHgxyKpqtU1y5978c6IjXrYdX5TIqGcCW87lKFQZhBRmeQy1m1KquO1jOtWPgH9EuNE+j7ov/VGtPf0mgmbwM/8Smgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swqNN-000000001Je-2SSR;
	Fri, 04 Oct 2024 22:02:17 +0000
Date: Fri, 4 Oct 2024 23:02:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: make sure paged read is
 protected by mutex
Message-ID: <ZwBl5XBPGRS_eL9Y@makrotopia.org>
References: <792b8c0d1fc194e2b53cb09d45a234bc668e34c6.1728057091.git.daniel@makrotopia.org>
 <398aed77-2c9c-4a43-b73a-459b415d439b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398aed77-2c9c-4a43-b73a-459b415d439b@lunn.ch>

On Fri, Oct 04, 2024 at 11:25:29PM +0200, Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 04:52:04PM +0100, Daniel Golle wrote:
> > As we cannot rely on phy_read_paged function before the PHY is
> > identified, the paged read in rtlgen_supports_2_5gbps needs to be open
> > coded as it is being called by the match_phy_device function, ie. before
> > .read_page and .write_page have been populated.
> > 
> > Make sure it is also protected by the MDIO bus mutex and use
> > rtl821x_write_page instead of 3 individually locked MDIO bus operations.
> 
> match_phy_device() as far as i know, is only used during bus probe,
> when trying to match a driver to a device. What are you trying to lock
> against during probe?

The idea is to reduce the amount of unnecessary lock/unlock cycles (1 vs
3). Of course, we could just omit locking entirely here, but that seemed
a bit wild to me, and even if it would work in that specific case, it
just serve as a bad example.

