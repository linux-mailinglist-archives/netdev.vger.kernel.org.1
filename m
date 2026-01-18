Return-Path: <netdev+bounces-250783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EFD3923C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0906330049F5
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B1F1C862E;
	Sun, 18 Jan 2026 02:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC477405A;
	Sun, 18 Jan 2026 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703657; cv=none; b=ueGJqICRaA5ad6GEhBiJdO+RPUVPqLmKXlw9D8u5L+I8OkHzHNWbRzptFoZixI02LCD31pQfoLa94aPEXrWUzwfyc9R76SvkA3PMDtEtv8J/y5EnISYT4+B7Y+DSKxrvTF4glVaKS3V1mivMC/94xOLg//Q/MiYHvXEcN6dvSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703657; c=relaxed/simple;
	bh=2G0v2Edbib0zJWAzHp+XmFwmDhzo3gTwgZkHFi/3mCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l353Iat9K0yTpoj89t4UwT9b0kExwYRVf+vf9TXDL0wEEI6JhekM7NjrAt70JNyzsz6n0Yx9qJFVnjBWsiB+iqU3yNgvostzfHT3UpkrFSHR4HrE+Zi0m2MNT4ga1T1IOr4Bb8REiFG92uYPbGNTbN6Ue6XytyJNOZCVH/ToCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhIc5-000000000Wm-2ltB;
	Sun, 18 Jan 2026 02:34:01 +0000
Date: Sun, 18 Jan 2026 02:33:52 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: fchan@maxlinear.com, hkallweit1@gmail.com, jpovazanec@maxlinear.com,
	yweng@maxlinear.com, davem@davemloft.net, andrew@lunn.ch,
	linux@armlinux.org.uk, edumazet@google.com,
	ajayaraman@maxlinear.com, john@phrozen.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	lrosu@maxlinear.com, bxu@maxlinear.com, pabeni@redhat.com
Subject: Re: [net-next] net: phy: intel-xway: workaround stale LEDs before
 link-up
Message-ID: <aWxGkAUlvyleFC1A@makrotopia.org>
References: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
 <20260118022907.1106701-1-kuba@kernel.org>
 <20260117183145.6f6a7d7e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117183145.6f6a7d7e@kernel.org>

On Sat, Jan 17, 2026 at 06:31:45PM -0800, Jakub Kicinski wrote:
> On Sat, 17 Jan 2026 18:29:07 -0800 Jakub Kicinski wrote:
> > > @@ -286,8 +287,33 @@ static int xway_gphy_config_init(struct phy_device *phydev)
> > >  		return err;
> > >
> > >  	/* Use default LED configuration if 'leds' node isn't defined */
> > > -	if (!of_get_child_by_name(np, "leds"))
> > > +	if (!of_get_child_by_name(np, "leds")) {
> > >  		xway_gphy_init_leds(phydev);
> > > +	} else {  
> > 
> > Does this leak the device_node reference returned by of_get_child_by_name()?
> 
> Of course this is a pre-existing issue but could you fix it first
> in net then proceed with this submission? Otherwise we'll have a
> conflict.

Ack. I'll send the fix for this to net first, then resend this patch
after the merge of net-next and net.

