Return-Path: <netdev+bounces-164327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4550AA2D5F6
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6959B188CF95
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9349817ADE8;
	Sat,  8 Feb 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UYLmH37D"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF010E5
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739016109; cv=none; b=PGVVEM9zjc34Y6dENYZ21Pa5wsHXYvdnoFH2TGGKzN2j3fg1amf+pSw+tkinqpMAJzcamsCz4API71ixmJCTw3V4IA4IEQb85PX7o73NzpJsK86ZF4LElhcTwzw80FcSk+koVuw7NSVO+geRv4ynELQUc26yAvsPpMx3xeCOhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739016109; c=relaxed/simple;
	bh=5hu3o6G9g1q7ZgBpipiKqX7AluD4jU0m5lEFHK4fQmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbf8lF3Xmq3O5Fb+v0/UDk+hwzfWCRCy3A5aOdQSyJwnwZwnv4M2Oa31e90n1rKd6FrIckkxfxMiGuF/BsXnKwtR3FUv3MqHEr3OhpF/Tn/kV9nJCns0QCDAQRgWZy/Hj1WEVWL8/8QLvFXwDQb4h4xkshg7LPy2b/3m33lc08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UYLmH37D; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MO3pzlYIc3oU84Z/+5hpycr7DTZRcxksXp5iILNgL40=; b=UYLmH37D4DFP+Zl/TFu19s+xwH
	UHYPi+au+gCUumYh6zPLyzQFMCwjmCmC8SOLwuU15+owGqFn7YpIEsdY4AbLc+uKDyS7DtJwjzUt6
	9g4OqqLpexZ/5nnLdMq8QF7nb8A+3wtaJUF7bYZELPT5Uq4QMdITpJNFRre2dfRDPiYJGEgKgoQgt
	VMuOpvM6i4bA0zkjeqbGpFsVx7UKV+Ibl+nC36uMjQifI9/MibNKC5PYlUtyfgxlb9+/vdbUIkWBE
	TSIG08KEjxbOSIyNi0W+w5IJwJSCbNiYoPfYNC7BOQ+m+e2TkeG8HjeZZkpudOb9jKIj+2XX/stUi
	Oifq/HDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tgjWn-0000Zb-2t;
	Sat, 08 Feb 2025 12:01:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tgjWl-0005Rg-0g;
	Sat, 08 Feb 2025 12:01:39 +0000
Date: Sat, 8 Feb 2025 12:01:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support
 for KSZ9477
Message-ID: <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 05, 2025 at 01:27:26PM +0000, Russell King (Oracle) wrote:
> Work for Microchip to do before this series can be merged:
> 
> 1. work out how to identify their XPCS integration from other
>    integrations, so allowing MAC_MANUAL SGMII mode to be selected.

This is now complete.

> 2. verify where the requirement for setting the two bits for 1000BASE-X
>    has come from (from what Jose has said, we don't believe it's from
>    Synopsys.)

I believe this is still outstanding - and is a question that Vladimir
asked of you quite a while ago. What is the status of this?

Until this is answered, we can't move forward with these patches
unless Vladimir is now happy to accept them given Jose's response.
Vladimir seemed to be quite adamant that this needed to be answered.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

