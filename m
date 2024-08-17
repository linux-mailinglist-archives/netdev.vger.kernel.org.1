Return-Path: <netdev+bounces-119421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E572A9558BF
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A193D2828C0
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19332575F;
	Sat, 17 Aug 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HVNf0LRT"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F26C8C0;
	Sat, 17 Aug 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909651; cv=none; b=iyi9TahtKy+BLXViwXqrekH+cL8BJtg2K718mB+7XG5g9nOrfEyE3Jle2lGJzEe7qgGjKIB7Z8hOftb0DDPEYkefezATTMaU+geejw+2X7H4VMMUwtEAtCS6dEF4awdm5UERC3hTTxhq8RIiB/XJTcqP3d3saTcObz1JpXlt7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909651; c=relaxed/simple;
	bh=lmqePAThAmEXa5Omwlik3LsrOE7yjU2UB1JVB9/5sVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOi8qlZ3o/d+cshDx61dJFUiwRRbPQ8pHS20bKzay4sIomc48rCLa4GiBEvda5EWxeJRrr1n0eJFwYkdeP6XNFzCITxPUlelBiDcaHHf7/IAVwCwKxfRIKLePlBzXdeFXo1C3+oGfTMuCmVDEsNYUqWYjT+eoqYfvd9Svj5UYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HVNf0LRT; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A26FE0003;
	Sat, 17 Aug 2024 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723909641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4tAB4S3uOiq7D418XEUK0C4GJJ3oRKt4ozyQqoAZI8=;
	b=HVNf0LRT2gRPTSsV2MNlX7GpF9q06DiFWgMH/cOem3yoGNOKDc1cmVtcqfcU7yh5Xeb/0Z
	wqnoGzH50VnDSLcb8CZckiZmjtbZaCvGKBHtOnC5S3W4p7yszu/2NP+CMIsyd0dMbsWhUE
	5bSO4CVfmYAV09S3O/Ca5VIAJCFWmWl9wVSSoO1nSdrAcbGY3TRdMrGX2sj+SoK5IsNkqE
	1yTYJRclkUQfZNYGrEqN/VKYnGvgT84LwLnaO6Sn0xicuK7ZqWEFBh+LGURB1/Rgs8Hbhc
	kCamJeKZ4MFWM/ni9icKK8d7gE26XfWIszklmi1s6IzF/wLKymB/LEAw2G0gEw==
Date: Sat, 17 Aug 2024 17:47:15 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Jakub Kicinski
 <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v17 00/14] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240817174715.77522d52@windsurf>
In-Reply-To: <6b84cdf2-34c8-4e61-857e-79a1d5e782da@lunn.ch>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240715083106.479093a6@kernel.org>
	<20240716101626.3d54a95d@fedora-2.home>
	<20240717082658.247939de@kernel.org>
	<a1231b3a-cd4d-4e74-9266-95350f880449@csgroup.eu>
	<6b84cdf2-34c8-4e61-857e-79a1d5e782da@lunn.ch>
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
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello Andrew,

On Sat, 17 Aug 2024 17:43:52 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Jakub, as you say it looks solid. I can add to that that I have been using
> > this series widely through the double Ethernet attachment on several boards
> > and it works well, it is stable and more performant than the dirty home-made
> > solution we had on v4.14.  
> 
> Have you posted a Tested-by:
> 
> You can also post Reviewed-by: if you have taken a look at the
> code. It won't have the same value as one from Rusell, but it does add
> some degree of warm fuzzy feeling this code is O.K, and it starts
> building your reputation as a reviewer.

Hmm did you check the replies from Christophe to each patch of this
series? He has already posted a Tested-by and Reviewed-by to every
single patch in the series :-)

Thanks!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

