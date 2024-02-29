Return-Path: <netdev+bounces-76241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E886CF64
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DA41F275E0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE27160642;
	Thu, 29 Feb 2024 16:34:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89C38DEA
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224478; cv=none; b=I262ijy+u3sad516UGRXoo0jpgo8IfH1c/newJgffM6kzVCXlSPRCUCcL5lgn5egMprNIo8Fo6dr43WhicK2l+QEsickQlYcFiq6tvnzG7YCBKpi4lYh7K5zk3euiwORAfobPD12HGIIChtDlAcWim6/NkWtiqbBkpN+fqVGmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224478; c=relaxed/simple;
	bh=zPXWnSO9TKhJF4fzESRhSx7G2OEtY0+FSbZqERMMVS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjgwF3jqKoNia5GhzHVySnrfUIeJ+TRVHitsBnRtlm4xr8nFTSCyAVRTVnFNYIhZmNpppBMVOMrmeDrkVfsu5NOOhUS3ebByMn7GIxi8YQC08Y4P1j/rnjKMpskragvY3dWcc5dO+TNpzNv8ajIOwhP1CTsBjhzpdbFaM+HVNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rfjMQ-0003ld-1b;
	Thu, 29 Feb 2024 16:34:18 +0000
Date: Thu, 29 Feb 2024 16:34:08 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH RFC net-next 1/6] net: phy: realtek: configure SerDes
 mode for rtl822x/8251b PHYs
Message-ID: <ZeCyAGiZZAFbVxAi@makrotopia.org>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-2-ericwouds@gmail.com>
 <Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
 <20240229135010.74e4304a@dellmb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229135010.74e4304a@dellmb>

On Thu, Feb 29, 2024 at 01:50:10PM +0100, Marek Behún wrote:
> On Tue, 27 Feb 2024 10:36:05 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > > +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
> > > +	if (ret < 0)
> > > +		return ret;  
> > 
> > It would be nice to know what this is doing.
> 
> No documentation for this from Realtek, I guess this was just taken
> from SDK originally.

There is an additional datasheet for RTL8226B/RTL8221B called
"SERDES MODE SETTING FLOW APPLICATION NOTE" where this sequence to
setup interface and rate adapter mode, and also the sequence to
disable (H)SGMII in-band-status are described.

However, there is no documentation about the meaning of registers
and bits, it's literally just magic numbers and pseudo-code.

