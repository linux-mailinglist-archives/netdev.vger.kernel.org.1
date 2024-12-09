Return-Path: <netdev+bounces-150248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6319E9947
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162FB167B5A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978421B4235;
	Mon,  9 Dec 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="11OGKHN5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D31ACEC9;
	Mon,  9 Dec 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755570; cv=none; b=uLd8kN2QA/vWUbqjtMU34BHj9LfkJZg6yCnbu635rY5pp+doBmyt+t+hy9RXNJ6QNuqkRSVME8YnbVDt7ktWEHZOaOfnjnUggtK3LwNRVDsywk71lAsutte3KnBZ3qydYNNDGoirSQVdUIHHGjmqYLPq+dw9oBymMYfxxnb5d+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755570; c=relaxed/simple;
	bh=2Ontbdl/Ui2RDELfVUpWEnj2cLmzdFyE2WE4OdC/s/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIoMnfN3XHsUZk52vxnGiQhJBLHd0/kCqtiKMMaWoazPmd+K2TJ5OIqpDvnzEvuPDNbLN1MFSWnUpEVyXsFXMb03IX19NoOrQMItlg8jdm64ID0HMYmgtIGibNbQOsUIRSdJpJ3/FKaJR/Toa4J+qeVqEm74PDetYPawlZUm6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=11OGKHN5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IWv5S8qTo3ORVYAj9ok2lHaimbOV5HPyhvsgh0TLoGA=; b=11OGKHN5/i14E8mbq+cWtikWTp
	IA8mdbKXzjYA5dn1ppe6vgoW43RZjt4japA9BxE3oqShRPsHyzbqvs6/YvHGdyTkXxiHYw2vHMaQO
	nKQw5gyAflUC6DChEjhHvxJueVZWszIjI+6sGg0zp4okvboBr6KpcC2nZQJ2cAfkN1Zc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKf1H-00FgRu-W0; Mon, 09 Dec 2024 15:45:55 +0100
Date: Mon, 9 Dec 2024 15:45:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Message-ID: <376bdfed-a000-486f-9aa5-4e186753bdd8@lunn.ch>
References: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
 <20241209-dp83822-gpio2-clk-out-v1-2-fd3c8af59ff5@liebherr.com>
 <bcef90db-ca9d-4c52-9dc5-2f59ae858824@lunn.ch>
 <20241209135205.GA2891@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209135205.GA2891@debian>

> > I would of preferred MDIO_MMD_VEND2 rather than DP83822_DEVADDR, but
> > having just this one instance correct would look a bit odd.
> >
> Is it worth fixing it in a separate patch, replacing all DP83822_DEVADDR
> with MDIO_MMD_VEND2 ?

You could do. As a reviewer, i like to be able to quickly see, these
are vendor registers, i don't need to check if they are part of 802.3,
and should have standard names, and be pulled out into a library for
others to share. So if you want to add a patch, i'm happy with that.

	Andrew

