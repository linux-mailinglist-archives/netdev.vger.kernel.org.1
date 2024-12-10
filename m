Return-Path: <netdev+bounces-150490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2C9EA6B2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95E6188B277
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14461D4609;
	Tue, 10 Dec 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hNRUjPrR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106E208A7
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801856; cv=none; b=C7b/IQeZVN+IIhMgZjmvCcJrNR8JkAAn7/teQ7okpuP1t37bFklNgV5qla22sQ7TnVLH4XYmTB9c0mZdBZ2vz3eiGQ05gy04LHaGmKjSeQRfZZJQhEbanCtCyRSlIG83YF1d+U2PoRs727QxUtv2xiM8vfAgFtt/GLQXK+nawqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801856; c=relaxed/simple;
	bh=3E/BX/W0ErnkpbfoqgzC/e8/qzttXifHQQBiUDYM9Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCw1up8PYV6wYDpyenYB339l12v+tAqECy92H4DgrhxE2oq7xt7/mMcf3bHpm50+Tj4v1Wkasg7ghwETHzxcuqx84mJ1XYh1QkkJ7XbZoEzDVsWZUUDl/kMvYTGcXApmBH/ZMMaZJjHfH8nCJQ4qV7e985fAb7gx2kpTV3z2Ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hNRUjPrR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7oOoHfGAk/UUkkorWLTDq+raHehjERBPwDvCmMKY2G4=; b=hNRUjPrRA3KhoH9IbsH7DVPMzy
	GLV8TMeaG2kc3IzQ923+dwblycqnPUW6+oZWYoR/NrhMsjRmruWM5Unl0yRVHQqDJT1lNnWYOWHZq
	4pUQIX7aW7/wfvL3UP+IeusSu3lSKXXFaLNe6IZzpaM/Gh8P9QpkwjGcDWlX6wk0dDBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKr3v-00FkhM-4w; Tue, 10 Dec 2024 04:37:27 +0100
Date: Tue, 10 Dec 2024 04:37:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 10/10] net: lan743x: convert to phylink managed
 EEE
Message-ID: <49dd18b9-5ffa-4726-a3c5-02e1ef90f04c@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>

> +	adapter->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;

Is EEE not defined for 10Mbps?

	Andrew

