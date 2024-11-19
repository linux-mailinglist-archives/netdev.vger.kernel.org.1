Return-Path: <netdev+bounces-146244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425F9D26CC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE703282CB1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9711CCB3C;
	Tue, 19 Nov 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v9EloRtN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F71514FB;
	Tue, 19 Nov 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022786; cv=none; b=W/S8NHLcCTj1wN2H0N55n6pKvoYtScYhEYgpE1iYzaaLT25YJTioHsTsmXLpaYYKyCjoyBxPzZdV+TILo6lssDWJx+HFs/fUX4Lb3zD1bnEAeQNvzNM/RjlOI66gHu1QwUiQErNCSx+tiWU7ZHpbXS8zlFoZ0rRfwFXvC7wJEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022786; c=relaxed/simple;
	bh=cOoy4IKrB0v1Tc0ApOxtFvI/5KxrBkZBg06rONCExGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxJXHTNpecoJgxIFfoex7L/2g91saRsRGrMjSlNZ4nmxcu9OCxN0oVH7FnFJgxuwmpa5OYfHsTuwlDXGI2AYNQIxGET1Qf4MptTNBX6oXvZRS33y5e+xtbpacq6zbKa2g5X+7Yit94GGkQQ0BS7dbfO0P2MiZQvN0twXL7SJcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v9EloRtN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=10XFHA4WlKYuCUuXVeCcAEgWg2V+Sh14geel43tsfcc=; b=v9EloRtNMXlEcEg5euoahINDxU
	BsgU65QlQD3uKoH2Qfbws9YV99RKTqGhbNFfLlHJdXiMqeRGVZPP9EN3NhIszhvO2b7U1cHNOl8TB
	Uf2vRBK/g7+XhmdmS+DtqxOBlvzGNzx5wQ9oYLv7nfbV0tIxHs9aYDTptdocqbXumWkc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDOEv-00DnnA-DP; Tue, 19 Nov 2024 14:25:57 +0100
Date: Tue, 19 Nov 2024 14:25:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 0/3] Add Aspeed
 G7 MDIO support
Message-ID: <6ae91aae-5939-4ffd-a430-181fb88d259b@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
 <SEYPR06MB513475D2B233EA9BDF52AD259D202@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513475D2B233EA9BDF52AD259D202@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Nov 19, 2024 at 05:35:40AM +0000, Jacky Chou wrote:
> Hi Andrew Lunn
> 
> Thank you for your reply.
> 
> > > The Aspeed 7th generation SoC features three MDIO controllers.
> > > The design of AST2700 MDIO controller is the same as AST2600.
> > 
> > If they are identical, why do you need a new compatible?
> 
> We want consistent naming in the DTS of the new SoC, even if Its 
> design is the same as the older SoC.

You might find the DT Maintainers push back against this. What you
want is effectively a Marketing game, it has little to do with
technology, describing the hardware.

	Andrew

