Return-Path: <netdev+bounces-53756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01180483D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425601F22995
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A738C05;
	Tue,  5 Dec 2023 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iARyHszU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309BC6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 19:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lxyi7SrNT3dh1Pd9A5RNFyiC8w43PXm+zMIXduDqCuw=; b=iARyHszU6pW1pGpy8NYgk04rnS
	nml4FAMXfJivGu+ij+SoWZZ1W0/fHU23XamJ5Zm0VWMiawggVXK4Z2k2HJ/ChV9bMq7b6Nkuc4XzC
	BpfmAd4D8MuBkqU76nnhKTyysOLd9y6Th/1jobuiVrd7yF6Ljc6IChdX0KfPPEMoBoxw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAMOv-0022wy-M8; Tue, 05 Dec 2023 04:47:13 +0100
Date: Tue, 5 Dec 2023 04:47:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] net: mvmdio: Performance related
 improvements
Message-ID: <584efde2-d3f3-4318-ab3c-6011719d5c68@lunn.ch>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100811.2708884-1-tobias@waldekranz.com>

On Mon, Dec 04, 2023 at 11:08:08AM +0100, Tobias Waldekranz wrote:
> Observations of the XMDIO bus on a CN9130-based system during a
> firmware download showed a very low bus utilization, which stemmed
> from the 150us (10x the average access time) sleep which would take
> place when the first poll did not succeed.
> 
> With this series in place, bus throughput increases by about 10x,
> multiplied by whatever gain you are able to extract from running the
> MDC at a higher frequency (hardware dependent).
> 
> I would really appreciate it if someone with access to hardware using
> the IRQ driven path could test that out, since I have not been able to
> figure out how to set this up on CN9130.

Hi Tobias

I tested on Kirkwood:

               mdio: mdio-bus@72004 {
                        compatible = "marvell,orion-mdio";
                        #address-cells = <1>;
                        #size-cells = <0>;
                        reg = <0x72004 0x84>;
                        interrupts = <46>;

The link is reported as up, ethtool shows the expected link mode
capabilities, mii-tool dumps look O.K.

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


