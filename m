Return-Path: <netdev+bounces-224770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E380B89850
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BA35A4150
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45023A58B;
	Fri, 19 Sep 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qmoKXRqq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BD2367AD;
	Fri, 19 Sep 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285929; cv=none; b=MRm2GcvdSznYFQR4k9MT0GckqLN2fDDi63mVjM2C+uMKvSgNsLT8882wfMqlEWmWtTVHT+/FvR4eFgPJ0s+i5pCwzpB0LevEjF806x817yjXtdM3b4N9mj3UyVIODQ4gKMdSTgiQzxst3/9kUsa1SoKMyJnl5vD1La3mwZ2X2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285929; c=relaxed/simple;
	bh=E3h6oz46c1oO7YS1ADd9W3U80okfrVwTJpJpYesGLoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA+KSKX9+IRwhdtUS85POhM44ccbv3r0QM0nl98Q2F2Nf2Eujshsi6Os8917EGVXGd1cR62rPeAro4wcbebh0kyvilsmjOxHhliQ+3ti3C1SpYaUF947ztnOX+Dc68zGM2jggM+02y6i0AHH6yAH1c+Bc7jJf5z9DjL3qlXtGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qmoKXRqq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YjpNJj42YnsVwPa8Is3HPgPmVub3F55wZFRC5rN5PC8=; b=qmoKXRqqVMV9X0WkB9Tmo5yyvV
	EI4zFLGcsylwR8GxS2Eqf+RDs6ENCk1sxWq2aGYskc+pIKY0YZuGatjyoAjQBzvMUDjGa38qucJs8
	AxfOC85RIpXIKSgNqPk/14a8PBxrdQoEpgdQEaUcZLLX78/pIINFpkr5oERe2Hi+E3xQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzaUC-008w5i-3M; Fri, 19 Sep 2025 14:45:12 +0200
Date: Fri, 19 Sep 2025 14:45:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: linux@armlinux.org.uk, Frank.Sae@motor-comm.com, davem@davemloft.net,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY
 during resume
Message-ID: <df1f93ec-e360-4cb3-adf4-454f427851dc@lunn.ch>
References: <aMqILVD_F7Rm-mfx@shell.armlinux.org.uk>
 <20250919073826.3629945-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919073826.3629945-1-yicongsrfy@163.com>

> Since this issue cannot be fundamentally resolved within phylib,
> we need to seek a solution within the PHY driver itself.

How about this...

Allow a node in DT which looks like this:

mdio {
	phy@0 {
		# Broadcast address, ignore
		compatible = "ethernet-phy-idffff.ffff";
		reg = <0>;
	}

	phy@16 {
		# The real address of the PHY
		reg = <16>;
	}
}

The idea being, you can use a compatible to correct the ID of a PHY.
The ID of mostly F is considered to mean there is no PHY there, its
just the pull-up resistor on the data line. So the PHY is returning
the wrong ID...

of_mdiobus_child_is_phy() then needs to change from a bool to an int,
and return -ENODEV for "ethernet-phy-idffff.ffff", and the caller
needs to correctly handle that and not create the device.

I would also suggest the PHY driver disables the broadcast address
when it gets probed on its real address.

	Andrew

