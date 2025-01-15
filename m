Return-Path: <netdev+bounces-158357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920FEA117A5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF1818821E0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53481CDFA9;
	Wed, 15 Jan 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="krVR3BV+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0079C0;
	Wed, 15 Jan 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736910362; cv=none; b=I7OxoDCwjJH10rVnHcHPIclaX2959KqO/FHCWPvFgV5B2veNW0zzMYA/ZmnSbnn2fKWrvfm8GLq4k2ksNXZAZG+TbX0NaN9Om/U8fIIg7geHZQku+x68kkFJgjBVgmSFBqGTMa0ANl1hH0evakZOy8HcT2S8a15XNr3suSxVY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736910362; c=relaxed/simple;
	bh=9rqZtZ658I8C/7KeTF4yZcpEiL9EAcBb3GFwN2I2zwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRL4PF0TNm1tSk/F9cWYzerwX7O18skaH+AidnGAqD7qAraKnTkM859O+FCMM5n1DchChClBaDgo9ZOte6lnl9J+eivQzj5iHp2AiS0+yWUmXjbd7BNWR8s9pDccrBR5eCVEQSnrFNPpwS+3EH1ea+KCGCTgqyNcxPOAPcFqF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=krVR3BV+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xZ3pSeWobvg8Tl71lQfQroV+f3jXMvH5qIsHJ4PQK2A=; b=krVR3BV+9Rjj3324BmDgxaZ2mg
	hvJQmkiQLPMtvaxTBuqsr6Cbg69R1frvco63GG5G1dyw/jnG65GNG/3pDGQUCxDQteU/UDf3hUIDE
	15MV/GMsuGypwbzxqc/55u7g29U9XYdknbk0RptcwYib0cd5HTzItZPOkx6hKnJmgjAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXtii-004eNm-6i; Wed, 15 Jan 2025 04:05:28 +0100
Date: Wed, 15 Jan 2025 04:05:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
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
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiDlm57opoY6IFtQQVRD?= =?utf-8?Q?H?= v2 05/10] ARM: dts:
 aspeed: system1: Add RGMII support
Message-ID: <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
References: <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Jan 15, 2025 at 02:57:04AM +0000, Jacky Chou wrote:
> Hi Andrew and Ninad,
> 
> > >
> > > Thanks. What will be the "phy-mode" value after you make these changes?
> > >
> > > Will it be "rgmii-id" for MAC1..4?
> > 
> > It should be.
> 
> Perhaps we will keep using "rgmii"

No. It is wrong.

> The reason is we cannot be sure all PHYs have support for phy-mode property.
> We will refer to the other MACs and PHYs driver about phy-mode and 
> rx/tx-internal-delay-ps properties how they implement.
> 
> Currently, we will plan to implement RGMII delay in ftgmac100 driver based on
> ethernet-controller.yaml.
> 
> At same time, we will think how to configure these phy-mode "rgmii-rxid", "rgmii-txid" 
> and "rgmii-id in MAC driver.

I already explain how this works once. Please read this thread
again.... The MAC can apply the delays, but it must mask the phy-mode
it passes to the PHY.

	Andrew

