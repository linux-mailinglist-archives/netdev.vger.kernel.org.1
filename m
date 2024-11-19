Return-Path: <netdev+bounces-146042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF89D1CD9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C802B21401
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ABF34CC4;
	Tue, 19 Nov 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3jM89Q1r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323B20328;
	Tue, 19 Nov 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978010; cv=none; b=T+nkriHsN/iqirDu7PvSrfDbUC4qZX1ywmZPKV2CmHbx+VveGNpXwSPZneB8Z7OXXR39g7UQaEgFO75lg3AneInMGoZcqT32suXlLVeB2Y6qXAFE3gItctPbIMMfUJPfvv7Y8dvztseMIol/jpeZoXOr9omY5jyLDHPwb8KdUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978010; c=relaxed/simple;
	bh=+YnG/FCxZp94SDKmGouq92sDGcy/8RbPvZOvOm3Mpts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Emd0a8/0vCAFcpsux2tRnCRVieZQjAZb9iuZ8Hn09iEr33OCMttzIHPv0yrxNed9S2ZZAIKIOAT3pmlLhk2kL6pZEgviFleknAPEcdcpmnFIntCFxlb9UMA/m/oKdsN9E3BKYjRiV/7kEzanvcchouwxeXwAhfIA+m0H9fyIJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3jM89Q1r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xySWq+GoYzDun91uVlEVQ1i2/eAkfhtKbJiC0a+d9TQ=; b=3jM89Q1rX/g8rqO/mJtBMQQbFE
	qesK0GQlBUhRCDTUfHew7ib3HHikAuepx1ogjBbsOJKdswtGDsjLij3ePm8KwIXY86B4h7wazvUDj
	r4o2jwdNDte2bw6qsCsDIyr94idpPNTvJMP6X7vHFkjMx5+x0yg/arxqHuLjQIFlZKaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDCaw-00Dj0f-SL; Tue, 19 Nov 2024 01:59:54 +0100
Date: Tue, 19 Nov 2024 01:59:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <5b9d79f1-ccdd-47c3-a02a-5ff0b12c1fb8@lunn.ch>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
 <29ddbe38-3aac-4518-b9f3-4d228de08360@lunn.ch>
 <20241115092237.gzpat4x6kjipb2x7@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115092237.gzpat4x6kjipb2x7@DEN-DL-M70577>

On Fri, Nov 15, 2024 at 09:22:37AM +0000, Daniel Machon wrote:
> Hi Andrew,
> 
> > > The lan969x switch device supports two RGMII port interfaces that can be
> > > configured for MAC level rx and tx delays.
> > >
> > > Document two new properties {rx,tx}-internal-delay-ps. Make them
> > > required properties, if the phy-mode is one of: rgmii, rgmii_id,
> > > rgmii-rxid or rgmii-txid. Also specify accepted values.
> > 
> > This is unusual if you look at other uses of {rt}x-internal-delay-ps.
> > It is generally an optional parameter, and states it defaults to 0 if
> > missing, and is ignored by the driver if phy-mode is not an rgmii
> > variant.
> 
> Is unusual bad? :-)

Depends. Having a uniform usage is good, it causes less confusion. But
strict enforcement also has its plus side.

> I thought that requiring the properties would make
> misconfigurations (mismatching phy-modes and MAC delays) more obvious,
> as you were forced to specify exactly what combination you want in the
> DT.  Maybe not. I can change it,  no problem.

Do these ports only support RGMII? The general pattern is that ports
supporting RGMII also support other modes, GMII, MII, rev-GMII,
rev-MII etc. For these other modes RGMII delays are meaningless. The
general pattern is that they are allowed in DT, but are just ignored.

If the LAN969x ports only support RGMII, and you are enforcing the
four RGMII modes in DT, you could also enforce the delays are present
and only have all allowed values. But i would not have the enforcement
any more strict than the other ports. Do you enforce the phy-modes for
the ports with a PCS?

	Andrew

