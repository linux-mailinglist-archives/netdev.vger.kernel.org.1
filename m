Return-Path: <netdev+bounces-157780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DCAA0BA1D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B62160C59
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E520F068;
	Mon, 13 Jan 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WIdE1Sba"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84468246330;
	Mon, 13 Jan 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779157; cv=none; b=UZWcyyQ8JRT63SwxW8Y1BXzcRMnQR862UyXPw234RY7nQ1zo0JImj60ukLs9wxPgzGD209g23PBcUDO7QQcjJgVf5QasSBd9Twv7EV0rw0CZttLIW0ZwCaIh6tOui+7/M8muGYC2GlI6lBasyf+GJbXEcRoREEw4B4b7FlWm0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779157; c=relaxed/simple;
	bh=97rncnpRqOVfFZQnVcLRtg3raEf/Yloky2lcqgdlp24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbXhTCCAr2ln+MtpuG2k+b54vdSqNOUHGDgHSlSSUaBSY8JZWRiaKObIlpWRcfTHqUKXUJL/cT/r1DT/6MaE9In/Db4mUd2qO+rBVzs1q2vwad6/FLvUs9fX/wvcqzZyw6+SOpHutiaDQNCDXkShOYHbVTG9ntXWxOrLJ+T89z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WIdE1Sba; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nl3Mw4Ndpe7aZrKhI8t+n+/czM8OaalquBI/xX0tQ8A=; b=WIdE1Sba7ulUJLWZr8AlOw/rac
	EHP1Csl7Y7MCeFWZf2F2bLnlUf58zNncweVjALqPxuZdMOE9F9nJOEhwl8XZ1m/hmIAUGrkMibmBS
	ipxofbBoyf3Wr/Af3EFLDh+lR6mS8W4IJJZ+AF4BP2oQylV4ESKodQD12FO/K1fpDO5A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXLaV-0047S8-N4; Mon, 13 Jan 2025 15:38:43 +0100
Date: Mon, 13 Jan 2025 15:38:43 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiBbUEFUQw==?= =?utf-8?Q?H?= v2 05/10] ARM: dts: aspeed:
 system1: Add RGMII support
Message-ID: <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
References: <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>

On Mon, Jan 13, 2025 at 08:26:08AM -0600, Ninad Palsule wrote:
> Hi Jacky,
> 
> On 1/13/25 00:22, Jacky Chou wrote:
> > Hi Ninad,
> > 
> > > Thanks. When are you planning to push this change? I might need to hold on to
> > > mac changes until then.
> > Yes. We have a plan to push the patch about RGMII delay configuration.
> > Currently, I try to align our SDK to kernel.
> 
> Thanks. What will be the "phy-mode" value after you make these changes?
> 
> Will it be "rgmii-id" for MAC1..4?

It should be.

> If that is the case then I can test it with current configuration which may
> add extra delays in the RX from PHY side.

I would then expect traffic will not flow correctly, and your see CRC
errors, because of double delays. It is however a useful test, because
if it does somehow work, it probably means the PHY driver is also
broken with its handling of delays. I don't know what PHY driver you
are using, but those in mainline should be correct, it is something i
try to review carefully.

	Andrew

