Return-Path: <netdev+bounces-64421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE218330CB
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 23:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A153C1F22E3D
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE755E76;
	Fri, 19 Jan 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h2KMvRaW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7B1E48E
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703896; cv=none; b=GGsURyoNa+brFhI/qGyfgyMGw/Gj35bsUN+tVmHQLJXkR4X0SaUQBpgX3b6ZL60D5WkfGI9XQCAaXr8mJoMpE6aXlAxMgCdhapenvT7QCk5DS2tLVGdigKDlzBzs5/bpzPvf7Dy69AujZAMV6nxZ3WZRLYuBaPoQTpUU3qfi8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703896; c=relaxed/simple;
	bh=9bWw7hfx7nkX0k3bYVdDdaaTpIaHSsD/aa7Nr2SLRRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1e82EHUHbf86Z98zhVV7u2RBHGWE20654q+FTsQFW4OhLgsE8cs5Eom6ildwdRx3nh7Qjxlg5u2aEF4T84ta2nARjvbEPEJ2hm/uFzFikrDpUIN95ITmdThglOhOsIWtIcjvA4ABSiBDAqWUldrvVnL+vGt7A6unZnuUgRfoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h2KMvRaW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5cYnU5+Ny7MURwxeXqcL4MDBQDJIQ3Gjz4Afm6s7do0=; b=h2
	KMvRaWDQPecdgQpZUCXRuNt3Ip9fw/Rys37qX3HSN/g217SM/xDYzBFthfl9mcl7bGTL+P7nvpoZV
	jySOALZ5AMTiEIiOpda2jeZLM9Gf3Qzh5t+d1okYUbJJayZfhrOtwi95E4Bs3g2SqQGzqmkUrbGaT
	cyQ+7m07dA1RLV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQxV0-005af9-ID; Fri, 19 Jan 2024 23:38:06 +0100
Date: Fri, 19 Jan 2024 23:38:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Message-ID: <f35fa6b9-ed6f-461b-a62d-326fa401bc88@lunn.ch>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
 <PH7PR12MB7282617140D3D2F2F84869DBD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR12MB7282617140D3D2F2F84869DBD7702@PH7PR12MB7282.namprd12.prod.outlook.com>

> The above prints proved that the micrel PHY started autonegotiation
> but the result is that it failed to complete it. I also noticed that
> the KSZ9031 PHY takes ~5 full seconds to complete aneg which is much
> longer than other PHYs like VSC8221 (which we use with BlueField-3
> systems).

What is the link partner? From the datasheet

MMD Address 1h, Register 5Ah – 1000BASE-T Link-Up Time Control

When the link partner is another KSZ9031 device,
the 1000BASE-T link-up time can be long. These
three bits provide an optional setting to reduce the
1000BASE-T link-up time.
100 = Default power-up setting
011 = Optional setting to reduce link-up time when
the link partner is a KSZ9031 device.

Might be worth setting it and see what happens.

Have you tried playing with the prefer master/prefer slave options? If
you have identical PHYs on each end, it could be they are generating
the same 'random' number used to determine who should be master and
who should be slave. If they both pick the same number, they are
supposed to pick a different random number and try again. There have
been some PHYs which are broken in this respect. prefer master/prefer
slave should influence the random number, biasing it higher/lower.

auto-neg should typically take a little over 1 second. 5 seconds is
way too long, something is not correct. You might want to sniff the
fast link pulses, try to decode the values and see what is going on.

I would not be surprised if you find out this 5 second complete time
is somehow related to it not completing at all.

	Andrew

