Return-Path: <netdev+bounces-230500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE267BE93DD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59ADF4E9DBC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5C32E12B;
	Fri, 17 Oct 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l7+7dEQU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879132C928;
	Fri, 17 Oct 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712066; cv=none; b=ukwMV80Y8sQ+M00dKeSv2hajQDjBDtMaq9fJt/vL7pu2g5a/3iZq+evmConw3Jz2222obp/EvEgnQusIPxO4DnHIPpuHA9EdkTWLHYsGlm/W67Jqs640eKYCrxhuDOAXwpePamAHa3dI0MyncOL30XFEhebo3EelUmO2vZrp724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712066; c=relaxed/simple;
	bh=jMYJasEqi3ay7PvrLC5T+zN3+dFN7Aj08FeWCzReUaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN6ZE8siw9Wye2eJuPS13Mkj1IE8ielQzZ0+GY62uDxESj6+XUeDDka2rcmiHLBerMtrZnO543XKOMYJUDnK+cmZP0SUSRJaIhBFEftLBgBpUaXDqSilYmE4iznt/u79DJa5z22iJVtS6nLX/HuTTEpaNskfwXSDBdAoCn1MpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l7+7dEQU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MSBj7p/t8+LNOBqFH9+2YK/Kz0Pi3Cgi9QUtr1JDAKE=; b=l7+7dEQUOkS3Yve+gWZYOOp1jB
	BZOSzomIg1EJEE5tG8nixcXADTqkHQ+G1/J5Pc92wKExBppSTwd4waDL56j8U+xz45YALYYqIxveC
	IXfbLJCxHJRvfCNQpz3dTdt+JnbUjYEp2NV8OpVbppxVytnVStcgdbAnA2thNPByjnpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9ldP-00BI7b-Vu; Fri, 17 Oct 2025 16:40:47 +0200
Date: Fri, 17 Oct 2025 16:40:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <6ceec6c5-a912-494c-852f-1075644ccb74@lunn.ch>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
 <20251015134503.107925-4-buday.csaba@prolan.hu>
 <aPHxZrLrCyjVO9cR@debianbuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPHxZrLrCyjVO9cR@debianbuilder>

On Fri, Oct 17, 2025 at 09:33:58AM +0200, Buday Csaba wrote:
> Dear Maintainers,
> 
> I am about the submit the v3 version of these patches, hopefully the last
> iteration. I think I managed to elimante all failures and almost all of
> the warnings, except one: patchwork complies, that not all the maintainers
> are CC'ed.
> 
> I have used get_maintainers.pl to get the address list. I am on the
> net-next tree. Is there a problem with get_maintainers.pl or with
> patchwork? Can I ignore that warning?

patchwork might be passing additional parameters to
get_maintainers.pl. These tests are not go/no-go. We look at the
results and evaluate what they are saying. Missing
p.zabel@pengutronix.de is not a big issue.

	Andrew

