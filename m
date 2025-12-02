Return-Path: <netdev+bounces-243236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80593C9C085
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08763347C4F
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971843168FB;
	Tue,  2 Dec 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rOIL1eOT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD5320CD9
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690767; cv=none; b=SEuZRHxIbnCpw3qwxbOdyyPo+ecohN24M7LKsWWidlEl/UOUxDVJgI2obCwyCcC/w03LPK84U1F4oHGRtOxcKCWTnPbVpDBwCfW8XHBLK0ZBzRKMRouz+cixHguAT8jaLp74uBvzPFJPFe1UQ2fniLxq/9a/1Qx8BcVGFtRGBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690767; c=relaxed/simple;
	bh=zJUxyA0Hd+UFWmoIl95swG12On91cxFdVDwEpnSWMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd6VvBNlWr27A16J4IC6G8nYp97pESqOA5HrFFuENT1ScnB0E8hum+RiCPE9QT6nz398pKqdFCyieUd4XPh5szvoYBEbwsWlQZtL5UhsA80VqdKrQu7kXZL0VAY+dzCHyavDRY5zE4XwjekB6IUfpkMsex8mxQlx1LUmLjwWSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rOIL1eOT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uMEdNSp2pHXWmIKyFSArTZaOESA0rARPTf5xfOdp2+Y=; b=rO
	IL1eOTIVAwy/zIQl4p9PlSF9B9mlpZHJiSaU87p+BYWrDzf2Zyu0fJL+Mo+z/UBcMVBqn2mFvE+JT
	hEwIlDMA2elBxwYYzuCC599GzgmNMfYA8vCH8K5jaxIP1uwpb/IE1X6GvpSDEuaRKBzlxk1uojEqq
	UASIJPwZ1sXbx/0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQSgE-00FiJa-VI; Tue, 02 Dec 2025 16:52:42 +0100
Date: Tue, 2 Dec 2025 16:52:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	nic_swsd@realtek.com
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
Message-ID: <2d6a68c7-cad7-4a0d-9c73-03d3c217bfce@lunn.ch>
References: <20251201.201706.660956838646693149.rene@exactco.de>
 <8bee22b7-ed4c-43d1-9bf2-d8397b5e01e5@gmail.com>
 <B31500F7-12DF-4460-B3D5-063436A215E4@exactco.de>
 <76d62393-0ec5-44c9-9f5c-9ab872053e95@gmail.com>
 <9F5C55F0-84EC-48C2-94E2-7729A569C8CA@exactco.de>
 <679e6016-64f7-4a50-8497-936db038467e@gmail.com>
 <89595AAE-8A92-4D8B-A40C-E5437B750B42@exactco.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89595AAE-8A92-4D8B-A40C-E5437B750B42@exactco.de>

> Well, the argument is for wakeup to “just work”. There also
> should be some consistency in Linux. Either all drivers should
> enable it or disable it by default. That is why I have thrown in
> the idea of a new kconfig options for downstream distros to
> make a conscious global choice. E.g. we would ship it it
> enabled.

You might need to separate out, what is Linux doing, and what is the
bootloader doing before Linux takes over the machine.

Linux drivers sometimes don't reset WoL back to nothing enabled. They
just take over how the hardware was configured. So if the bootloader
has enabled Magic packet, Linux might inherit that.

I _think_ Linux enabling Magic packet by default does not
happen. Which is why it would be good if you give links to 5 to 10
drivers, from the over 200 in the kernel, which do enable WoL by
default.

	Andrew

