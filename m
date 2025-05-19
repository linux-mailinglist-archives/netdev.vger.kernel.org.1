Return-Path: <netdev+bounces-191627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16DABC879
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C57AE6C4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE662153D6;
	Mon, 19 May 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TrWPWtAO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886551EDA3C;
	Mon, 19 May 2025 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686871; cv=none; b=rlDF24x//drpgpZ+YXP02qN85ogrmfAiK9RaUgQp1fBki89NJ9Mj/SkDcVOu+PJHI1wYs0hXIX8uwsJcnGnjlFSLOtV9FtMCBUNqLc6FksJ2gxco9xxuUZgbX6Y93K4hdS4vjGAInAfDEihQ+f61SdMA4UCIyzgaLKIEku+0gWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686871; c=relaxed/simple;
	bh=PUPTWPheY4+SMDrMrZ+FFynkzrqiwSoeYjqbbJAFNlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmSrXxumWrkNn6DZKKS2vixJDCfvceOmZencvGMRPL7y4ZzS5NuwJQrWXgLZ4qY0fgj/x4BIHILPX9QAqqH/x5RmBBR3oU2IS1PBz4/IUzUS8RYZDbkBpcjetPI4uD9BdOYfNZh/bdwmLpQ2m2zhulZ5tAOuEVTG8OIL8L1Ikxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TrWPWtAO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=470tGcqSDryRhSxpPi/ceNsL55HjWFtjL3oVVqnZ2XE=; b=TrWPWtAOlEHz32RorX3ZdUPeeI
	qld064sSV/e4md/B/KJ461icXCTCZn6yC1QwZB6BxNwFf6CkYp+HBntEYSKseSSsBDFhXOcZmhNZr
	qkMeQym/fm6ZK4QvaIdF0DExuKX3yfSdgpYwBIO9tnhRGsQjxnzJ1tScvYzY+73doEFE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uH7Bh-00D3Q2-Sy; Mon, 19 May 2025 22:34:17 +0200
Date: Mon, 19 May 2025 22:34:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on
 bcm63xx
Message-ID: <2e5e16a1-e59e-470d-a1d9-618a1b9efdd4@lunn.ch>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com>
 <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
 <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>

> > These changes look wrong. There is more background here:
> >
> > https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287
> 
> This is what makes it work for me (I tested all four modes, rgmii,
> rgmii-id, rgmii-txid and rgmii-rxid).

So you have rgmii-id which works, and the rest are broken?

> E.g. with a phy-mode of "rgmii-id", both b53 and the PHY driver would
> enable rx and tx delays, causing the delays to be 4 ns instead of 2
> ns. So I don't see how this could have ever worked.

In this situation, the switch port is playing the role of MAC. Hence i
would stick to what is suggested in ethernet-controller.yaml. The MAC
does not add any delays, and leaves it to the PHY.
phylink_fwnode_phy_connect() gets the phy-mode from the DT blob, and
passes it to phylib when it calls phy_attach_direct().

There is a second use case for DSA, when the port is connected to the
host, i.e. the port is a CPU port. In that setup, the port is playing
the PHY side of the RGMII connection, with the host conduit interface
being the MAC. In that setup, the above recommendations is that the
conduit interface does not add delays, with the expectation the 'PHY'
adds the delays. Then the DSA port does need to add delays. So you
might want to use dsa_is_cpu_port() to decide if to add delays or not.

    Andrew

---
pw-bot: cr

