Return-Path: <netdev+bounces-156494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C387A0694A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 00:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6207F3A60E1
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0020469D;
	Wed,  8 Jan 2025 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DRFgas6V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B5202C4A;
	Wed,  8 Jan 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736377733; cv=none; b=PzSB5o/Wduj01YQ8KjzSm97c5tjers6UoBhaFdBgvMS8ha6ox9JO1rKON1mcg6UuqEvna+zH9Gck+aZQNCHiVyGTs7CjDMP3WALYE8Jb4atX7nmCkiMz6y49rsf5yD8zpfhIBomM8Y4RcaoCQPr/760rsJxuah/V7Pey4W2VMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736377733; c=relaxed/simple;
	bh=OD4n4Ihhod1YWFLQrPlUmorM01sR8f6EOYUcmNeagwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtyT/DZApJfWweR7uc/mxRLgCJMy8bWzhqd2xrroQiwtg221ih/MBSVFcDQOaEK6r5ww6L1Qw94fxgAng+6/gAsOwY5IUMnqSc4KoAg2xZcp9lKqAirWLZKyMuacaSCWxMF41myvdTujNeCjkwysRY5rXXu+MSRtqbOO92NW3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DRFgas6V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QOtK78nI5rgA0uceIpeywrkch6lrzYwEKPd0Sio4ZFM=; b=DRFgas6VTsmXXXEGrkB5OiPOvF
	n24ZB8sfIZX6LOwyK9VXZLMMtiqAnersB31MXoV7NMLPgq2vZNJ+TswKCUlCkXPhdnLhF6ZHpY2mp
	k2vWGt8YIjABDZl9Tw+M6ErieZZOm2BpuusTUIiCS3UvQTF2viEAcvlZYFTHJjNl3fDg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVf9p-002iOJ-BJ; Thu, 09 Jan 2025 00:08:13 +0100
Date: Thu, 9 Jan 2025 00:08:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>

> There are around 11 boards in Aspeed SOC with phy-mode set to "rgmii" (some
> of them are mac0&1 and others are mac2&3). "rgmii-rxid" is only mine.
> 
> No one in aspeed SOC using "rgmii-id".

O.K, so we have to be careful how we fix this. But the fact they are
all equally broken might help here.

> > Humm, interesting. Looking at ftgmac100.c, i don't see where you
> > configure the RGMII delays in the MAC?

This is going to be important. How are delays configured if they are
not in the MAC driver?

    Andrew

