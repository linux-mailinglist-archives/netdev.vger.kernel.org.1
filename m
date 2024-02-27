Return-Path: <netdev+bounces-75263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CC868DDF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E94B28BA0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8831386CE;
	Tue, 27 Feb 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wFIBdSf/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E10137C42
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030477; cv=none; b=TEs9rrqtu80jRcvvFOGTrcNZeYL6nMEyOiSYnyUSWVJeySBn1JiTsi7jDn/jBaSAUAcqYOXVnh9iwkxXdXT+mSerACvf8HyQOT4cYVdtaJO/Vv38kM5LoYUnQ83NJtqDni+wdFnd5nQk6pu4zp0aEp8WR1cTYK3EaUVPLqW+2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030477; c=relaxed/simple;
	bh=PNqDfs3F9M37ZhKTAoc6I86cYKnHcdey65qo2OX2NZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8MMaDRiv3Uakg13vRhvhbEIIfkEFy8THGQdXId3L+FilQJhLyw/Aht6JqUTxtoLxKT+7KsXqeujNJsbctSswfdveaUqzIXGSUBkvf5ZQzLLzRXH07IPvP3uPkw5W72NiJl6va6mNS09I8HRV/wJePAOldUejyTizg64XrfV1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wFIBdSf/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=De9w2tAe9T5xirm+ElspeGIVkiB4le184V/yPCDSqhE=; b=wFIBdSf/Olkmofx0qDzYU+H8XG
	/72VQBcBDlqpuIhqUChrfr0q3KaLL6632l1Z45s9HhmG1adnxwD3SuvJTay908VfNrtkuOYlquJOt
	YEJoYrG6SkuszXqH8TJ4/qWfqHclMoIXKRplAKZs4tK4DOQPDsCuJKKZA69gh5gn8LBuLd7kEAGEr
	JzwCP5n752BBVQIyU1U82+PJAOSyLgDiDQxA60nNpq9PRH85bRezamyjWWp9QgC7m3A2kZohFeflW
	zUjoAjQiF2qdCiIdiLe2Z/9iRsqh3tR9YgG+Czqh+nZz96H/ITpYPA2YZGFWCrSBR9OAirvwTvmN5
	2UXPzbZg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36676)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reutY-0007p7-1a;
	Tue, 27 Feb 2024 10:41:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reutX-0007Kl-Ln; Tue, 27 Feb 2024 10:41:07 +0000
Date: Tue, 27 Feb 2024 10:41:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/6] net: phy: realtek: Add driver instances
 for rtl8221b/8251b via Clause 45
Message-ID: <Zd28Q6YOI4JEfDPf@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-5-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227075151.793496-5-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 08:51:49AM +0100, Eric Woudstra wrote:
> Add driver instances for Clause 45 communication with the RTL8221B/8251B.
> 
> This is used by Clause 45 only accessible PHY's on several sfp modules,
> which are using RollBall protocol.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

