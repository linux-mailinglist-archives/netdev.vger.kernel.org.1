Return-Path: <netdev+bounces-119082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD3953FB6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712F51F23096
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93D41C6A;
	Fri, 16 Aug 2024 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3sM9HNf8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDF6F2E0;
	Fri, 16 Aug 2024 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775593; cv=none; b=tfBTouvGX/1ughPGa5HWcZwqNAX6PLhTyHxwX4GNfxwPoxTNQ+pCG8W8hC135ewNtIzglCorQuUA6QglNxGvWH13KUfATnTeI0oQAgFoCa7lbXPzM5bnfOly3itO4XyiVIwXO6vvxdZuhV0d/Fl+KAELIW6b0cQuQqCrzCTcf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775593; c=relaxed/simple;
	bh=+hycJpFn+kf6fMVa9crjYGSDMXzfCWIVHI5hZ35K6IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrRBtjULS7B2E5Q+/BXQMXYrauUJk44u+xbU5qnmZ8mMaVO2vCm+OClIPx5HEUzaEBymLV4OBbRj7iMtnqJNwSe+gdU1HLlnlPDEb1a8h9ZszvBHRQZ5nT/if5DuiEn6NDyGjWwlXP89DU30rdaAG9V0XIzQ9vJuPO8FQCoGtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3sM9HNf8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qVyYTHbtuwYjWfo8L+O8hoLZSEsYgsRh9cZGjypJx3E=; b=3sM9HNf8jlpA4tKW2w1fsRcvef
	PulRJVAF4MxPK+V4kiqr369qFnFdrlMiG5zcf5m+t362SSE7ICydtCemHnUR2maP1pDmxgHEd9bpV
	drh/wuZtmhA82aawX0r6svERJkA06X1WNGxaYYGWpSdpeQ16N349FMgxY+KIiCFMSFOY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1semlv-004tPx-BM; Fri, 16 Aug 2024 04:32:59 +0200
Date: Fri, 16 Aug 2024 04:32:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Message-ID: <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>

> According to the commit message c858d436be8b ("net: phy: introduce
> PHY_INTERFACE_MODE_REVRMII"), my understanding is that
> PHY_INTERFACE_MODE_REVRMII and PHY_INTERFACE_MODE_REVMII
> are used for MAC to MAC connections, which means the MAC behaves
> link an RMII/MII PHY. For the MAC to PHY connection, I think these two
> macros are not applicable.

In MAC to MAC connections, REVRMII means that end plays the role of a
PHY, even though it is a MAC.

What is actually happening when you use these properties/register
setting on the PHY?  It is playing the role of a MAC? In order to have
a working link, do you need to tell the MAC to play the role of the
PHY?

	Andrew




