Return-Path: <netdev+bounces-205263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E1AFDEC8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C60C1BC3276
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBF23D2B9;
	Wed,  9 Jul 2025 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WzL0vmwb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00823208;
	Wed,  9 Jul 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752035230; cv=none; b=FkZOHog4J4uc2tzguoqSpGoYA0o9hXNRALw5a3tkbCOwVRFir7vO+BQBVYzCgml/nvj0L/OTXAhflg3NZFJ4Mr3NG9Vgemi2LxZPcyke4svjgSVu5Wcwzsyzbjp7HzAghEzOUgqJomLZ4BvpQCAP/UJlo0TC59RfQo5Sas24gMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752035230; c=relaxed/simple;
	bh=ObANF4uRYqE9ZSQpJ8ovfMLIz42ZK79VF7fq2SlCxYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQgmWObS1Sr/8rswyXoW1hmGCbqKqMDAOqdYCeYSMiz9NdTNLl6dsHS48U3/9qw5tENiv3wPeNIaZHLnN+8531fhAogFFWKXxkIHhrcUHLZxqYKShZ+p/xjIR6v2+7AQDYlYDXkRuoScEkkefv+x5T5MbZICkQdJMSJyEDIDm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WzL0vmwb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GMqdXQYPH7R0rLOgNG95+m6qioNSgp89n0jbG2AEzM8=; b=WzL0vmwbdhe2FrulM825lSq4Q2
	HPWAhGcz/WgC5SqZrrfkt2WPJq7W1JgEHp20VOgRQRDFD4SFWjuukNlIi0Uo5fGH26QyPUOJQfHSH
	CL8q1rrHcuQNaV06/FpHWVCSESgmlgLph1k1GbGC4n8crJjrg4+oYFycKuJYMFW8iSEMY7qTzL1zy
	uvQGLdrcIMbOBkyweFYukWqQI35GUpoFpZA7n4rfqlczgUx6139PkZRKxY1J7jOrv41ByT3Qvgfag
	+px1+9TgevMKpRmFkgMbzAk6v5mh6xLX06XbFIi9awwLHP7Y6T5iCrN3a5FlBgFdZNKLDSwX5dXKY
	WnsieUQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38326)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZMOY-0007QR-2d;
	Wed, 09 Jul 2025 05:26:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZMOV-0002Ds-28;
	Wed, 09 Jul 2025 05:26:55 +0100
Date: Wed, 9 Jul 2025 05:26:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: lizhe <sensor1010@163.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: stmmac: Support gpio high-level reset for
 devices requiring it
Message-ID: <aG3vj1WYn3TjcBZe@shell.armlinux.org.uk>
References: <20250708165044.3923-1-sensor1010@163.com>
 <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
 <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 09, 2025 at 09:57:50AM +0800, lizhe wrote:
> + gpio_state = gpiod_get_value_can_sleep(reset_gpio);

Use gpiod_get_raw_value_cansleep(). The normal get/set return the
active/inactive state, whereas the _raw get/set return the physical
state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

