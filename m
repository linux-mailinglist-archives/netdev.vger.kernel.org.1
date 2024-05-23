Return-Path: <netdev+bounces-97677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4308CCA7F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 03:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1377C1C2012A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 01:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443EA34;
	Thu, 23 May 2024 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4mkv5SM/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A24685
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429135; cv=none; b=LXGC4XyzumKNT7C/DXjzAPees4EucszqDa7SiySIcKrdYZyv0vOpDCnFcflNh24wo/kTh+iaYBKm0QDhrPzUUyd/iWkXkVzSquQiNxR9+Wdepo2nnRyfNs+FHG3P494fdAUKTbQFWpur8PJebyEhB1NGpMPjLYLjUGnOJD3zKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429135; c=relaxed/simple;
	bh=Y9CowDEKybjwzmTUjQClMd88FG1Lf6m6nIuAUNC/Q9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4/uhT/XGdsthiZL8KhsUaIyzovsbJPW7UEX1YiQa92mDMd0p0dav/B/DXA7HD9ID9KaTf8pehGJtvBkIXzhaXRe1AByrEpS+yA/tYSh49BKOspu3o1myiQoC+kkm/61lnsXlVBk2X5xMIBwyu/pw7dtLjmAFzs0BNFNjNoGs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4mkv5SM/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=12UiUkZyn04S4KeHyjnJv8NbT2RkA+iVfABYi+JqkUE=; b=4mkv5SM/1D9us8PIr4vPAiD28k
	XsiH8CJ84A3weQTWqWCoatRX6WEJsJtX6IhExfqGChJ5rUAlKr8hrHnWL4hwLDzLlIKDdFnF9n/ci
	KqHT6Rsnx7Q7c+UT5iD8zHEKCkhG01zsVHqUZw1TSm71FEWnEeJDX9JRZgpuFXcbM0Rg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9xcm-00FrAm-UD; Thu, 23 May 2024 03:52:08 +0200
Date: Thu, 23 May 2024 03:52:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Glinka <daniel.glinka@avantys.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Message-ID: <6d0f1043-cf3a-4364-84e0-8dec32f8b838@lunn.ch>
References: <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
 <BEZP281MB277651F9154F2814398038C790F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB277651F9154F2814398038C790F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>

> > What SFP do you have in the SFP cage? Are you sure it needs 1000BaseX?
> > Most fibre SFPs do, but if it is copper, it probably wants SGMII.

Russel is better at reading these things, but...

> 
> This is the SFP cage we are using:
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>         Connector                                 : 0x0b (Optical pigtail)
>         Transceiver codes                         : 0x18 0x00 0x00 0x01 0x40 0x08 0x00 0x80 0x00
>         Transceiver type                          : 10G Ethernet: 10G Base-SR
>         Transceiver type                          : Infiniband: 1X SX
>         Transceiver type                          : Ethernet: 1000BASE-SX

Why is it saying 10G, but 1000BASE-SX?

>         Transceiver type                          : FC: short distance (S)
>         Transceiver type                          : Active Cable
>         Transceiver type                          : FC: 1200 MBytes/sec
>         Encoding                                  : 0x06 (64B/66B)
>         Active Cu cmplnce.                        : 0x03 (unknown) [SFF-8472 rev10.4 only]
>         Vendor name                               : municom
>         Vendor OUI                                : 00:1b:21
>         Vendor PN                                 : MUN-AOC-SFP+-001
>         Vendor rev                                : Rev1
>         Option values                             : 0x00 0x1a
>         Option                                    : RX_LOS implemented
>         Option                                    : TX_FAULT implemented
>         Option                                    : TX_DISABLE implemented
>         Vendor SN                                 : SA1708250054
>         Date code                                 : 170825
>         Optical diagnostics support               : Yes
> 
> >> The link is reported as down but is directly wired to the SFP which
> >> reports the link is up.
> >
> > How do you know the SFP reports the link is up?
> 
> This is the SFP state:
> Module state: present
> Module probe attempts: 0 0
> Device state: up
> Main state: link_up
> Fault recovery remaining retries: 5
> PHY probe remaining retries: 12
> moddef0: 1
> rx_los: 0
> tx_fault: 0
> tx_disable: 0
> 
> When I pull the Cable it reports link_down.
> 
> >> Therefore I forced the link up in the port control register.
> 
> > You should not need to do this. You need to understand why the switch
> > thinks it is down.
> 
> >> We are using the 5.4 kernel and currently have no option to upgrade to a later version.
> 
> > If you have no option to upgrade to a later version it suggests you
> > are using a vendor crap tree? If so, you should ask your vendor for
> > support. Why else use a vendor crap tree?
> >
> > What is actually stopping you from using a mainline kernel? Ideally
> > you want to debug the issue using net-next, or maybe 6.9. Once you get
> > it working and merged to mainline, you can then backport what is
> > needed to the vendor crap kernel.
> 
> We need a feature which was dropped in 5.15.

If you are willing to Maintain the feature, you might be able to bring
it back. You could try submitting a patch adding it back, and include
a change to MAINTAINERS listing yourself. It does however require you
to actually look after it for the next decade...

   Andrew


