Return-Path: <netdev+bounces-151073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998559ECAB9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A377A169792
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C341EC4EA;
	Wed, 11 Dec 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lOTuc5rK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19036239BC4
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914607; cv=none; b=O0l/8Y57EFfRunvE26sKjUN5Lzlzp/6HYvYKAmP5eBt+nhT5qr1a4yycQgCdx128EZyIq/Y0yNU7oAGvQ56PTbPdh/7WBK8E0Hy1zsW6f3ljJAMA2MhJ/W/RK0rdEFotnoILb3vlG9oakUXBDc5IWWAiJvnmBLyGvda9/WFG4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914607; c=relaxed/simple;
	bh=+qAn1A/hfhq7+cTaxVBMqAk05GF9rXH1Rz/XfF7qeiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSm6PEbzIXLdQDO8LLCZoWOa/tJtqjbRgQNW35tvQt5Zg/bpazEp6ddlL8DqY8K9epKgODfzHLItTS2x88sr5rzO68Qn6pH0w3AsUtA5Pc5jfc2j8i1OzxGmKFM675rQU3o41oR2KodcbGHEAItS/9KzL+er9GqaPau8ApkSe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lOTuc5rK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vXBO4RzaWJqlBx+pZ3dR8dWcfIYvonKMR/KALcMpMBM=; b=lOTuc5rKQIYj5Zk7fNeztPErhw
	1HdRzPbesUnO6spz0RF7zrtpKTR0/6Gc1H1AMuOXk/FzPvmm+V42Q3/I2xtjIMLWsC5NWKSyn+Hn+
	xFH65sZuG0X2B+EBPtmtv6/paDPLueiL8enjBmJif7/mgn7Crr3NzyXwmd76qL6G6nVdn00LhxGLo
	BsDAWygmsAf0x8amN6SRlzz3FIXJfkJ7hnd/6bohsJjDxDXHPCmhycGunRODyy9XuUs64eqId23dK
	JBdY50U1/ExaqcIcPg+oIZF4BaE9I7rVEmkP7WF4nlePBgL7uHJVCRDAtMCGYOzi978USjuek/kEL
	8sOgdBpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLKOV-0003m6-0a;
	Wed, 11 Dec 2024 10:56:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLKOS-0003su-1n;
	Wed, 11 Dec 2024 10:56:36 +0000
Date: Wed, 11 Dec 2024 10:56:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: tai: warn once if we fail to update
 our timestamp
Message-ID: <Z1lv5EfGq6WGwjRO@shell.armlinux.org.uk>
References: <E1tKzVN-006c5w-EH@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKzVN-006c5w-EH@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 12:38:21PM +0000, Russell King wrote:
> @@ -303,7 +304,8 @@ static long mvpp22_tai_aux_work(struct ptp_clock_info *ptp)
>  {
>  	struct mvpp2_tai *tai = ptp_to_tai(ptp);
>  
> -	mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL);
> +	if (mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL) < 0)
> +		  dev_warn_once(tai->dev, "PTP timestamps are unreliable");

I see nipbot spotted an issue with indentation here. v2 sent.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

