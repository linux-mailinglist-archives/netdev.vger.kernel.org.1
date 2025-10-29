Return-Path: <netdev+bounces-233984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED72CC1B0F0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16EB188CDCE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F813557EE;
	Wed, 29 Oct 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="XsgaU4fo"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74C2D3ECA;
	Wed, 29 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745347; cv=none; b=CSP+zlfVBjky+M8CbGH3oD6yy7fw9C8FeoaXzHdss9dDR1f9FwDOl3mYEVZYx9tkiJBZHn7PkG+6M4nog/NbDZl0mc58oepLktfOV4vm5E0gNhU+6f+FCudqSSX4wobetIrjCLMMjfj7m9vBVRJNVFcMDx0mhHHWp6OuSVHgs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745347; c=relaxed/simple;
	bh=9AL17cWwZ7qLb4uLsBkGYUTXZoPxRoZAS8i6HCK6JBY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkw+tH1VYkvhD1dhXMZdBAXyE0SQTtdPvbc2YcWaAGKQluVoXmeTy1UFP5JpmDtV1Bt3gH5iai6K2hblGgbntiCnMv4iFLWNaUMu4zF3/lGL/5Ase9gwZjchR8587Avs4jRinc8uVTJmarYTml1fNi9VmANn9iTWW+XxlupDSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=XsgaU4fo; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 15A6EA1551;
	Wed, 29 Oct 2025 14:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=5Biv8ReOMAixkg4w96h7cmr4P8SDbtzmfv5LRygveW0=; b=
	XsgaU4fonIyUoG6URoq+KyJxY/L//5IxOUKyDxrB+S5YOLL+iTC/0hrhgT+A0yse
	1T2dJLbqGmprInG+mMQswpwUHZ8i1BoJ/mB6eNtxPHgKAsxA6suKsHiZUmzT/WUl
	jDO0He1d0JBJgMCg4uupmt8CYNhQjYYyWo/R5RQtLC0CR21uino1Ctn5N72q/EB/
	pS7Xe3kXTx7kq/bMs5GMaY41NWEmHDzJZuRFv+QJtj7EDKmdvyuxEWGCXxgrd7eh
	a5cVrEB0yYmy08O267iIZBD9ICuYtIP0M32azD19cqqs/A7BsGf7LDuqxEM8I//v
	5k6WvluamtYtM2tCgGYXEXDynr7ewSUok/69ba0w5TJmwMSOympWmgweqE+s/7MN
	MqSSKaa+KdMUlLlIlQZdvC9wT7/Pzuilz9AmkuSQMzk493bwwITmSJJZ63dlAqFM
	/OkwnxU9cN8mV28zG+o1TOxf/Xy4ivgAmohYimM7wZM3FeEs+LrEK1KaJSWO417W
	1QEVR7TeXw33VUYiIi6CwMrlaHKMpVhvYMg7MTdnKy8r0EX8Dqr+EC/vgaM6u1rS
	bxmddL3vZRA9O0N9W9YgoXvppqRM+84hhmbx/LUDhP/Sfjj9w2/1vsCALAWysi8k
	odymOGQE6YBzLqX3+8q0+gnRxbz1vTITvUg+U1xqdik=
Date: Wed, 29 Oct 2025 14:42:20 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 0/4] net: mdio: implement optional PHY reset
 before MDIO access
Message-ID: <aQIZvDt5gooZSTcp@debianbuilder>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <23c1bed1-3f95-48b9-8ff0-71696bdcd62b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23c1bed1-3f95-48b9-8ff0-71696bdcd62b@lunn.ch>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761745340;VERSION=8000;MC=189938156;ID=145782;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F67706A

On Wed, Oct 29, 2025 at 01:43:32PM +0100, Andrew Lunn wrote:
> On Wed, Oct 29, 2025 at 11:23:40AM +0100, Buday Csaba wrote:
> > Some Ethernet PHY devices require a hard reset before any MDIO access can
> > be safely performed. This includes the auto-detection of the PHY ID, which
> > is necessary to bind the correct driver to the device.
> 
> nitpicking a bit, but this last part is not strictly correct. You can
> also bind the correct driver to the PHY using a compatible. So it is
> not 'necessary'. It is maybe the preferred way to do it, although the
> DT Maintainers my disagree and say compatible is the preferred way.
> 

I have also gotten the impression, that DT people generally prefer
hardcoding the ID. I can not argue with that. But that should be clearly
reflected in the documentation. Now the description in ethernet-phy.yaml
suggests that a correct ID only is a workaround for misbehaving PHYs:

"If the PHY reports an incorrect ID (or none at all) then the
compatible list may contain an entry with the correct PHY ID
in the above form."

> > The kernel currently does not provide a way to assert the reset before
> > reading the ID, making these devices usable only when the ID is hardcoded
> > in the Device Tree 'compatible' string.
> 
> Which is what you say here.
> 
> > (One notable exception is the FEC driver and its now deprecated
> > `phy-reset-gpios` property).
> 
> > This patchset implements an optional reset before reading of the PHY ID
> > register, allowing such PHYs to be used with auto-detected ID. The reset
> > is only asserted when the current logic fails to detect the ID, ensuring
> > compatibility with existing systems.
> 
> O.K, that is new.
> 
> One of the arguments raised against making this more complex is that
> next somebody will want to add clock support. And should that be
> enabled before or after the reset? And then regulators, and what order
> should that be done in? The core cannot answer these questions, only
> the driver can. The compatible should be used to get the driver loaded
> and then it can enable these resources in the correct order.
> 

Again, I can not argue with that. I can only tell that these patch fixed
our problem - I hope that others may also benefit from it.

> I will look at the patches anyway.
> 
>   Andrew
> 

Really appreciate it, thanks!

Csaba


