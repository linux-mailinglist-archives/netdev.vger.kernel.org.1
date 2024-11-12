Return-Path: <netdev+bounces-144237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7FB9C633A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589CF1F2251A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDB221A4D3;
	Tue, 12 Nov 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U1qSvagq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF421A4C6
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446359; cv=none; b=JYQdnl2m+UqfSv+CxFaxkEw8F4ziQIH1fjaseQ2ORxMIJb+jwHnTTMsrJdIqYZtbasmG+RBxrA2Cb70cRjFtoz79Nu6p4lWFYLoO01LFvyRHjLalTRgbXnW098cYiOtcH1ijfueVo/RmURAVztv+bnmLrWBgR4b0HpWZ6/lqk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446359; c=relaxed/simple;
	bh=z//0UvQp60+5/jKOnQ8KwLt+4BVJ1W35fIdEmBttVd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIIHJRW1Ejmd6NsA0NMp8ep3Z/oD9aXYg9G9WGcCSRdOw6d/ePzqdhCE4C2398NMExa8+x1/CA2UdA68Nq7f5goiKJVJPVfTsReQMPXpN0raY0mRW/82qmBDf+/HyUhcMl/cIedlQQ2a3Wy67aEoY3XaC9tQa3UfwIwrrlwcJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U1qSvagq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fYP1V6V8eYhVN+j0FXarG3HK7+HtW47Nu9F6unUmjtg=; b=U1qSvagq+gQfIVKsja9x7Q5BW+
	1+fYjbEnrbm3IvHXS+2S77hYIlqxzN7eA7TTbWpPY9pVdLVGXoq/bNP9cXs13pq74duv5HGcxpvWE
	fJ49eGJoMzLarbacMR3zDLGjvUsXgrS7c88sELNaqkHVP6FKvtzUhplGrs+7+w66JsQWvJrE9phQr
	qLLorIgywbU5/7fAxCcj032B7n3zKBeSlm5/H4ApijRXuMlOrNAOj6GQhgQTcsrADT9CggMgXZFZ2
	dV3fuKZAqQA+9YQ8BQ8X2QUwyiLATo1wOUL0M2xXeOmU8CeWUoSnjOGNXK801M43BPKqTO4Fgu9qM
	hTs7elJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAyI4-00051a-0C;
	Tue, 12 Nov 2024 21:19:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAyI3-0007mb-10;
	Tue, 12 Nov 2024 21:19:11 +0000
Date: Tue, 12 Nov 2024 21:19:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: simplify eeecfg_mac_can_tx_lpi
Message-ID: <ZzPGT_iTCfXHASc9@shell.armlinux.org.uk>
References: <f9a4623b-b94c-466c-8733-62057c6d9a17@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a4623b-b94c-466c-8733-62057c6d9a17@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 12, 2024 at 09:36:29PM +0100, Heiner Kallweit wrote:
> Simplify the function.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

