Return-Path: <netdev+bounces-156382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D480A063C2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3277A123A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452220103D;
	Wed,  8 Jan 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XtQQjt1u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33C1FFC67;
	Wed,  8 Jan 2025 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358785; cv=none; b=V6N4bNpHs0hymyE4Eh5Y/8Krb7MB944AW7gyERpjTkFiL/JZyznSlvLT1hPDAgVlAfExj71rOe9uuAG6Fp7AxGtmQScM+n0oT8n7X//yM4Uu2XXBcA/YWeybYCRXJ/3ZS+uGBawr45olEdHm8hW0VuSaD0k684pr3DbGLd+gnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358785; c=relaxed/simple;
	bh=NwN06BuwWws3Dy2bB2ldsOtGEyJBTTRxRTzJzhgbLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRWv+Mo/HYDXb4XPDcgR4I5+jqwbvAfb5ZvHmZ3AzJtBNq5xh/G5Fq35V/QUA6v6RQnbVZIG0b2Qw3kJz4hyGrVySec8p+q9lLS/eTu5xFbXKizBkSsWHNuiaqP/2QNNYSFxTZu82mjK6vV8iO9UObedTAzgmfhbjRUwAaciJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XtQQjt1u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TAAO1Chf6hDYV9mEVdFl4KLhPTl2u2J4AKlDsKfF4qk=; b=XtQQjt1um6jDIVerxn2G5x/9Yg
	VigbPTw+BhyEl8UPKACYGGkerBa4/lPUaT3YGcbKd1+qBorH4cqWZMhxVgKqR4ZhTRpgw3i8Ktlw5
	JCZJm55al/ky1Nbj3aK19x4uKztA8k/2F/fRu2z/UXlopcvNLhwaJkYa0mH4b/1CWbno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVaEW-002e68-6T; Wed, 08 Jan 2025 18:52:44 +0100
Date: Wed, 8 Jan 2025 18:52:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
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
	"ninad@linux.ibm.com" <ninad@linux.ibm.com>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>

> >Does the mac0 TX clock have an extra long clock line on the PCB?
> >
> >Does the mac1 TX and RX clocks have extra long clock lines on the PCB?
> >
> >Anything but rgmii-id is in most cases wrong, so you need a really
> >good explanation why you need to use something else. Something that
> >shows you understand what is going on, and why what you have is
> >correct.
> 
> Here I'll add some explanation.
> 
> In our design, we hope the TX and RX RGMII delay are configured by our MAC side.
> We can control the TX/RX RGMII delay on MAC step by step, it is not a setting to delay to 2 ns.
> We are not sure the all target PHYs are support for RX internal delay.
> 
> But ast2600 MAC1/2 delay cell cannot cover range to 2 ns, MAC 3/4 can do that.
> Therefore, when using ast2600 MAC1/2, please enable the RX internal delay on the PHY side 
> to make up for the part we cannot cover.
> 
> Summarize our design and we recommend.
> AST2600 MAC1/2: rgmii-rxid
> (RGMII with internal RX delay provided by the PHY, the MAC should not add an RX delay in this 
> case)
> AST2600 MAC3/4: rgmii
> (RX and TX delays are added by the MAC when required)
> 
> rgmii and rgmii-rxid are referred from ethernet-controller.yaml file.

O.K, so you have the meaning of phy-mode wrong. phy-mode effectively
described the PCB. Does the PCB implement the 2ns delay via extra long
clock lines or not. If the PCB has long clock lines, phy-mode is
'rgmii'. If the PCB does not have long clock lines, 'rgmii-id' is
used, meaning either the MAC or the PHY needs to add the delays.

The MAC driver is the one that reads the phy-mode from the DT, and
then it decides what to do. 95% of linux MAC drivers simply pass it
direct to the PHY. If the phy-mode is 'rgmii', the PHY does nothing,
because the PCB has added the delays. If it is rgmii-id, it adds
delays in both directions. This works, because nearly very RGMII PHY
on the market does support RGMII delays.

There is however a very small number of MAC drivers which do things
differently. Renesas produced an RDK with a PHY which could not do
delays in the PHY, and so were forced to do the delays in the
MAC. Please look at how the ravb driver works. If the PCB does not add
the delays, rmgii-id, the MAC driver adds the delays. It then masks
the phy-mode it passes to of_phy_connect() back to 'rgmii', so that
the PHY does not add any delays. If the PCB did add the delays,
'rgmii', the MAC driver does not add delays, and it passed rgmii to
the PHY driver, and it also does not add delays.

So, your MAC driver is broken. It is not correctly handling the
phy-mode. First question is, how many boards are there in mainline
which have broken phy-modes. If this is the first board, we can fix
the MAC driver. If there are already boards in mainline we have to be
much more careful when fixing this, so as not to regress boards which
are already merged.

Humm, interesting. Looking at ftgmac100.c, i don't see where you
configure the RGMII delays in the MAC?

	  Andrew


