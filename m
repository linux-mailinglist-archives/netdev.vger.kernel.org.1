Return-Path: <netdev+bounces-215886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31424B30C6D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AFF5E3FC1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350A28935C;
	Fri, 22 Aug 2025 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5OuwMnFk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1ED22578A;
	Fri, 22 Aug 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832672; cv=none; b=lswpjXUpDyMqGHp+ompfrH2xGvJD6sCuypj5JzSECRW0mSVO4Wdb9NTxnl2wWWSL2brf+ECob/mCu6Tc/wXP/60kBDHIam498FY/IpEKa6lfFQtDHa4LfNdAl4QFQYxbPRYrvXi0CjdZIQvJ7lc197qRiaVOG46j86c1rFyaNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832672; c=relaxed/simple;
	bh=U91kuvG7t2D2eG/kbuTSn6ZjVILpojBxiIDh8I8Ofbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz8Gn04RPH41IzdOIAWn8LV9z6CtIH9vpxziO9Cpk/JMXuNFZryUpjgHdAjKEtuvVF632g/JKj6tKKSFSek5UyvOE4TiCqlvOK+MMF6EAf7zUREuGfmqa7T8M67K4y653NIZY4ZgeSHNBh1ndGM0HrI+p4H3YALGYPkUb8wj/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5OuwMnFk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FQHWCj2G7uE0VQTePlKYzggszJQgMhjnofu5HSi2Vew=; b=5OuwMnFk8XspHeSWT5qjK0jRrg
	C0ctkC7F0t/TaaLvA8Rr/qlr4y6DSI/6ALz5iiVOM4Uf4PUAurNE49I9LOCAHJClYQK3D+vGHkPse
	NOT9YoUvBtM6e8cRThEI7IZ4FAJqJrCOXw5YOaKpl45cH8SYNgZzrHQ8wAVoZsVq7jno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upIHZ-005X48-JB; Fri, 22 Aug 2025 05:17:37 +0200
Date: Fri, 22 Aug 2025 05:17:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com,
	jszhang@kernel.org, jan.petrous@oss.nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	boon.khai.ng@altera.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: Re: Re: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700
 ethernet driver
Message-ID: <548973df-2fa8-4502-9f7c-668d0eeb16c6@lunn.ch>
References: <c212c50e-52ae-4330-8e67-792e83ab29e4@lunn.ch>
 <7ccc507d.34b1.1980d6a26c0.Coremail.lizhi2@eswincomputing.com>
 <e734f2fd-b96f-4981-9f00-a94f3fd03213@lunn.ch>
 <6c5f12cd.37b0.1982ada38e5.Coremail.lizhi2@eswincomputing.com>
 <6b3c8130-77f0-4266-b1ed-2de80e0113b0@lunn.ch>
 <006c01dbfafb$3a99e0e0$afcda2a0$@eswincomputing.com>
 <28a48738-af05-41a4-be4c-5ca9ec2071d3@lunn.ch>
 <2b4deeba.3f61.1985fb2e8d4.Coremail.lizhi2@eswincomputing.com>
 <bad83fec-afca-4c41-bee4-e4e4f9ced57a@lunn.ch>
 <3261748c.629.198cfa3bc10.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3261748c.629.198cfa3bc10.Coremail.lizhi2@eswincomputing.com>

> We re-tuned and verified that setting the TXD and RXD delays to 0 and
> configuring TXEN and RXDV to 0 yielded the same hardware performance as
> long as we only applied delays (e.g. 200ps) to TXCLK and RXCLK.

This is in addition to phy-mode = 'rgmii-id'?

> Therefore, in the next patch, we will drop the vendor-specific properties
> (e.g. eswin,dly-param-*) and keep only the standard attributes, namely
> rx-internal-delay-ps and tx-internal-delay-ps.
> Is this correct?

Yes, 200ps is a small tuning value, when the PHY adds the 2ns. This is
O.K.

	Andrew

