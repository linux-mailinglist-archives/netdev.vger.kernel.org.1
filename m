Return-Path: <netdev+bounces-110006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E092AAB6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E1FB21324
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA144C64;
	Mon,  8 Jul 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXPIoSHk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C9A29;
	Mon,  8 Jul 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471451; cv=none; b=f+ODVHyQmUgcmVDP+KHDad73WBnhgamMUnccixkKaLrJOGWBIldXuRm17UKo2fzzpxJJblOLwDbRBU83No0BHk5BlJe+qyC4hNW0xU+Uq3s22jIqmILRs5zk9ARX0AK9TsqmAIWqhtml7BaBB7bpxItU1ivXLdlpVC7XLeIwen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471451; c=relaxed/simple;
	bh=ji7wYm2m/vKs/SRhmS/int3PI83ishRDU4ddyjP+vsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIy1c2Wzedgt5lwbNv1EyIdZhsJUP0IV7cCePPq+TNzilAfbS8E8NlXp/b89vsnFrOqcPbMMrpuPGG+6kk1QCLl1B7478IaiG2by/MYVt72QwnHaEIMDhdK1GKPmcJVFuiyophTw6xhQ0y41ki4amRuVHdQwCeORnXup0d0KuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXPIoSHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FC7C116B1;
	Mon,  8 Jul 2024 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720471451;
	bh=ji7wYm2m/vKs/SRhmS/int3PI83ishRDU4ddyjP+vsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXPIoSHkktYvW9NG0COkM9irwnheNNBwGlTkvyMTGjkHNk13bsZrRHziY8nhRDtRr
	 jF/WFrK2nGeujC0LKE+8OTLRVbmWWFU++9jUwNdn9rYBIJFacKBGzmEETF0A5v/Qlt
	 CIrG211PhR+7cxPAMv4su1lxgD36K61D+nOsv2HQ0jqdCxvPlp/5LMwFRQVBFKocRk
	 QiCK3i6/7040w310GS60PrmjJ/VDqoFNUju+hkj2MNha1jLf9XEEU8fVKOgIEswjat
	 tARQNNmdLLWpEUd+Uc3Vg1dGta4cJwlOdvF/ESXlHikDrkINYlXdxIZFLCvOOYuktH
	 3YXnMOm2O3w4A==
Date: Mon, 8 Jul 2024 13:44:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v16 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240708134409.0418e44a@kernel.org>
In-Reply-To: <20240707145523.37fdfeec@kmaincent-XPS-13-7390>
References: <20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com>
	<20240705-feature_ptp_netnext-v16-13-5d7153914052@bootlin.com>
	<20240707082408.GF1481495@kernel.org>
	<20240707145523.37fdfeec@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jul 2024 14:55:23 +0200 Kory Maincent wrote:
> > 
> > nit: make htmldocs flags that this title underline is too short
> > 
> > ...  
> 
> Arf, indeed forgot to rebuild the doc, sorry.

Looks like there's also a new driver to fix :(

