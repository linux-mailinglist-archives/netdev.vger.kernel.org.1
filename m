Return-Path: <netdev+bounces-148027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A89DFDEF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9DD28113C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943121FBE9C;
	Mon,  2 Dec 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kRpHsowu"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4B1F949;
	Mon,  2 Dec 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133587; cv=none; b=BbQVk2UHoeyt5p7hepYmYg9ehLlAua1ttmOqLBnCQdCR+PI5ddlgI6BXUTmN6CYCjXUdRfTG3YEyrFujReoU66Wci7LvNJ6W4/S83yGXkTXKVpXsWYyjYGndq0TIR3cC6SaEtsv0Kd27PWCkDlHCKsEEF9tz9mAwMpgiIBv/mpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133587; c=relaxed/simple;
	bh=kIGKRiYFo9gfIocY3AIKLrI90/1zJlp9PccU5cRWR18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozu3yQXipKepXRA8n6eZ+q10yYHhe2wNNZtUNV7t3r+3At/35xFwGRAvG/t47e0A3jIUbA1A3NTrTpMA8jLt5dYA0CQUILohpjQVBYR0l3sLXwiYqoh88bcV6hC/GGUt3hFSkrb7Uy/TAmlsT8IACqyv9zMhQOrRkva5heFo9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kRpHsowu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2A2524000D;
	Mon,  2 Dec 2024 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733133577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtUJqVnYZrl3ywx7eOs9Z38x3/zncCE9TLZZ+vTvhGc=;
	b=kRpHsowuOozd8HgYfuHQsSjktAj4UMxEYQTZUr8jPZ8nwhac95bxnJw77hGnbJxP+lswhL
	IQZgdk1DoRyWMKFoxrFOTHjRzvZyEuRY8qkiZqc8j3KxVOU7cyVWcVp/avmDsmO+lbimgr
	wucnSuXblY6+vVxWUXX6kkAnMdeEo2Kx846ZhrLsBq1RFzUBXG5PqOD3806VMDI+vjrFAb
	xlBp9sWIgA9o+b4jh5c0/Q98M9aikn3APV/arjJUUtHBf0+CqUqfZFEPBFh9KYAEWdkpv7
	pZ1CiJwvcudE0bEtSNc+2kGLafA1hAv6ZtE9kdutqAW+kbcHIgUn7UvSEofBrw==
Date: Mon, 2 Dec 2024 10:59:34 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>, Dennis Ostermann
 <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any
 supported speed
Message-ID: <20241202105934.0eddb032@fedora.home>
In-Reply-To: <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
	<20241202100334.454599a7@fedora.home>
	<73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Nikita,

On Mon, 2 Dec 2024 14:20:17 +0500
Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:

> Hello.
> 
> > What's your use-case to need >1G fixed-settings link ?  
> 
> My hardware is Renesas VC4 board (based on Renesas S4 SoC), network driver is rswitch, PHY in question 
> is Marvell 88Q3344 (2.5G Base-T1).

Ok so it's baseT1, which is indeed different than the BaseT4 case I was
mentionning. It could be good to include that in the commit log :)

> To get two such PHYs talk to each other, one of the two has to be manually configured as slave.
> (e.g. ethtool -s tsn0 master-slave forced-slave).
> 
> This gets handled via driver's ethtool set_link_ksettings method, which is currently set to
> phy_ethtool_ksettings_set().
> 
> Writing a custom set_link_ksettings method just to not error out when speed is 2500 looks ugly.

Yes and this would apply to any PHY that does >1G BaseT1. The thing is,
while it does solve the problem you're facing, the current proposition
will impact 2.5G/5G/10GBaseT4.

I don't think you need to write a custom set_link_ksettings, however we
should make an exception for BaseT1. Maybe add an extra condition in 
phy_ethtool_ksettings_set() to check in the advertising/supported if we
are dealing with a BaseT1 PHY, and if so bypass the check for
10/100/1000 speeds, as it doesn't apply in your case ? 

Maybe the PHY maintainers have better ideas though.

Thanks,

Maxime

