Return-Path: <netdev+bounces-101481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEFF8FF081
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16C71C20B8E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45D196C75;
	Thu,  6 Jun 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PHTiZfyZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD17195B11;
	Thu,  6 Jun 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687312; cv=none; b=RiIMZriqeTNYfui3W/2o9M9vy4yM84F9TGuGgyvXRZHikuwiP1T0btQ9Zlb3vh58pi0stXsHnWejX4+F9QXZYOMw9Ml+S4nU/i346VdRPDnKFWC+yicXIPJTiamoAtnRne8U1gcdShzCLv5ew4l/3ygf+Rug99FMqSnLAmLSwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687312; c=relaxed/simple;
	bh=+JbV2WwHLiNrIrXPhAnPneX3NCFy22wigTTB7b9U+jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy7oAJqTL3g1WAcQVTkl8/HPpkNoas6LPf1oV9JlOCn2cnUs7xBKjP/JMv2gT3UEW2UAya5wFx+YWuJWlcpLis0h37TgESamRjSzOKyoRPVhvwW2iI2rZyMEaMbm9cw0wQce4/d172s3SDR7ey7zDVBPGzei4Jdo/3tyH9VQGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PHTiZfyZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GMT1ykjhbgM22EzMElHF0RPQcaLGLoRrCnFOFHH5cgQ=; b=PH
	TiZfyZAZ2V5yposKZaaL0QYpCK5AUaOSZ5KQ1Y6abzo1vaOuUM1m1TQ+tWR27Hq1VLWwU2NPLRidY
	chqFe5WvAIcsU2TWZ93uhwIuZzgmS4/lHzGNAnIC6i2mVynAb6bTLWjA11zp7C4y9upfkzdM4dM79
	5Mo9cR5rhz+os9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFEvx-00H1vZ-IS; Thu, 06 Jun 2024 17:21:45 +0200
Date: Thu, 6 Jun 2024 17:21:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: sfp: Always call `sfp_sm_mod_remove()` on remove
Message-ID: <24a48e5a-efb3-4066-af6f-69f4a254b9c3@lunn.ch>
References: <20240605084251.63502-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605084251.63502-1-csokas.bence@prolan.hu>

On Wed, Jun 05, 2024 at 10:42:51AM +0200, Csókás, Bence wrote:
> If the module is in SFP_MOD_ERROR, `sfp_sm_mod_remove()` will
> not be run. As a consequence, `sfp_hwmon_remove()` is not getting
> run either, leaving a stale `hwmon` device behind. `sfp_sm_mod_remove()`
> itself checks `sfp->sm_mod_state` anyways, so this check was not
> really needed in the first place.
> 
> Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>

I was expecting Russell to review this. Maybe he missed it.

This looks O.K. to me:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

