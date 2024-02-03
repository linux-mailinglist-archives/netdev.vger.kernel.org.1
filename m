Return-Path: <netdev+bounces-68866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CEE8488FA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57262812CB
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9A12B7D;
	Sat,  3 Feb 2024 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o7WXiL8C"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A912E46
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995717; cv=none; b=XbH9jDLIYpoWjtr5r95vhxRtT+QvawrMwRBMup/t+lqd1F7UoblIUCAGomNUnG++4aWFByL+jVTLJp2/hrByCGnklzVh0kEJyXa/EteDHo5eBpMe7spySotA4+pdm+WO3kvyM7zyYtJcY1FNCWxPWIPY8wBZ9ZAdWRiv+n7nJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995717; c=relaxed/simple;
	bh=lfrHHE8yhCqJloxoyGNhU88Ijb0K1qYEXH77Q8qOPZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah0dkzNLWYEHJ/c1WpF0MyXVjkFR/VEZHbmOo0zX61Z69QH/yJMdn9T71I6qhekfl90FY8PGRJfSuBp4jWQsnR62/epGoF6avVrL3UctEQ14i9ZKH90x34rQ1tI3UBsXTEyGI4nnErL7VF3lULMl0z9LIhDC4VWrtlBr5A/5YA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o7WXiL8C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yELKVZUW+XrApwASaKAYQ84Of1LoeH3xAT4DY0I6SFk=; b=o7WXiL8C39bDXpf/w89elnPB0O
	KgB9L9TigtmSP5sfC81ponrPDZsMcq5MmXkRo3O+dVsJFP/71oILQcP7mKreC1/z/XcjfAzbQyWSA
	ayZdTPdmMvJOQx8KNU7syTA82b4sonG7wEtqcz/KTBYPPgiCNFOV9/7F/ZLOXr5jxAtJletdZ5I++
	I6fsRexe8Dbgbm6TzcNA789FiMm3CTovNO8cCss068+RneCR/ZOJzntaZ3xRKaie4Pm3140/WAOx4
	gTY33BrIVqrT16Ye5uf1dLSY4iQG5WNxj6hmo7PGIycnQJz9sNx04AtFOgYpMl+51RhxP5MzcaouG
	2crCaqWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWNYk-0007QT-2U;
	Sat, 03 Feb 2024 21:28:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWNYi-00018W-2J; Sat, 03 Feb 2024 21:28:20 +0000
Date: Sat, 3 Feb 2024 21:28:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>
Subject: Re: [PATCH net-next 0/2] Unify C22 and C45 error handling during bus
 enumeration
Message-ID: <Zb6v8wLIp9m79ieN@shell.armlinux.org.uk>
References: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 03, 2024 at 02:52:47PM -0600, Andrew Lunn wrote:
> When enumerating an MDIO bus, an MDIO bus driver can return -ENODEV to
> a C22 read transaction to indicate there is no device at that address
> on the bus. Enumeration will then continue with the next address on
> the bus.
> 
> Modify C44 enumeration so that it also accepts -ENODEV and moves to

C45

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

