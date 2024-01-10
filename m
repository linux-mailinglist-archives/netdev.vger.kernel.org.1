Return-Path: <netdev+bounces-62168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703D82603D
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540311C21560
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD18474;
	Sat,  6 Jan 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OSXQfSwW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBFF79D2;
	Sat,  6 Jan 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tNlB7/uA5K4ebymu4kVPBZ4jtrA/OS7aEQ6lXpdIR98=; b=OSXQfSwWh2SrU+sRxW2RNmUfGR
	aFSo3urtubLOcYgj4i+G6VGqiNBD5HQ0aBEMe35JjazFXiN5FUwRrnQ2Wj0MngjhmFtAHZAQt6dxY
	BogU3KL6nkFDnfXYEf4EC+QPmbi4fRpdld+4u5o7Vaw1KHPCl/kLfluZiRpPoEbjHon0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rM8rE-004WpA-CJ; Sat, 06 Jan 2024 16:45:08 +0100
Date: Sat, 6 Jan 2024 16:45:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Message-ID: <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>

> I just realized that the UNIPHY block is a MII (probably SGMII) controller.
> Isn't it? And I expect that it responsible more then just for clock
> enabling. It should also activate and perform a basic configuration of MII
> for actual data transmission. If so, then it should placed somewhere under
> drivers/net/phy or drivers/net/pcs.

Before we decide that, we need a description of what the UNIPHY
actually does, what registers it has, etc. Sometimes blocks like this
get split into a generic PHY, aka drivers/phy/ and a PCS driver. This
would be true if the UNIPHY is also used for USB SERDES, SATA SERDES
etc. The SERDES parts go into a generic PHY driver, and the SGMII on
to of the SERDES is placed is a PCS driver.

The problem i have so far is that there is no usable description of
any of this hardware, and the developers trying to produce drivers for
this hardware don't actually seem to understand the Linux architecture
for things like this.

> As far as I understand, we basically agree that clocks configuration can be
> implemented based on the clock API using a more specialized driver(s) than
> MDIO. The only obstacle is the PHY chip initialization issue explained
> below.
> Thank you for this compact yet detailed summary. Now it much more clear,
> what this phy chip requires to be initialized.
> 
> Looks like you need to implement at least two drivers:
> 1. chip (package) level driver that is responsible for basic "package"
> initialization;
> 2. phy driver to handle actual phy capabilities.

Nope. As i keep saying, please look at the work Christian is
doing. phylib already has the concept of a PHY package, e.g. look at
the MSCC driver, and how it uses devm_phy_package_join(). What is
missing is a DT binding which allows package properties to be
expressed in DT. And this is what Christian is adding.

	  Andrew

