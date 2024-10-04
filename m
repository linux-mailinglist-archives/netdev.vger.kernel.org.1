Return-Path: <netdev+bounces-131978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0FB990127
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A984A1F213D5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4211714D3;
	Fri,  4 Oct 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w3tx4/ZF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82B15852E
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037548; cv=none; b=WGrS+3dzkCHZZ3W7sryjapIW+0kShHpUJaFvuZDRUiznQn+a3KsKIyEdkCOrXQ0RcTaWH0RTPRgiene/e4lnTZMBKN0SbwYQX+0UEYu54FPxbKNUY2mBhZVkvY6XeqZySD3TQycvugmsSsBhqJFp3VTsO6xsfXUB5GIOVM9qLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037548; c=relaxed/simple;
	bh=6tARbvL632yLhx2RP/UocP0fBpvKjdEv5WTAR37JkwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrCS2MXaDCmcnvNWLDKZnmog9YxmhdXOurWWIkzz3hu8uvTSlRpEoQMy+UUCJ/oP5Mf0Hj0CbYMFsoJbZqyiPArVQ+i2chQXdYr5H/ZdPvzq90JrmBfeShyC8NgTn2bqVF1qsTY0yKYCxcTwgbPV/ch4YqwHX5I6tkML7ipx78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w3tx4/ZF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bkxq8btcV1/bsy5w1n0JN+FGpo5w1ifQL3Os5BhEG98=; b=w3tx4/ZFSUVRbrNh2+uesLqFOC
	nQLGWh6y4ICuHSZirHqFNsbVpPfrLyEgcMMpCDo4QCmkDNEPjlqctafNvTevKSfdf0f/WMFw4Em5M
	Mw0tBB3bTt//RM32BU7fZ1WWP/bkdZx1dKW6+n1tn2JfTKDPY9C96F6Ju85E/RjygINjSZGTo9Zdd
	7GhEEdyCPjZv/2dsGj8PXzgpKKOpqre1TWwJPnRaDH8spcN/YElwyM9F76eIVL7DM7mzHYoWwsqMI
	ytNQrRF0HD8YPuVQQu3xVKu9sb6hQp3KVkG8Gfv9P0yOQ8OqG3R+qYdmlLhJC42RPvxWGSwHb6xBD
	dY5l8M+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56868)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swfV5-0001kl-1i;
	Fri, 04 Oct 2024 11:25:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swfV1-00016c-38;
	Fri, 04 Oct 2024 11:25:28 +0100
Date: Fri, 4 Oct 2024 11:25:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <Zv_Cl-FhF6bU7_Wr@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 11:19:57AM +0100, Russell King (Oracle) wrote:
> This is the second cleanup series for XPCS.

As an additional note for Vladimir, the outstanding patches now are:

net: pcs: xpcs: convert to use linkmode_adv_to_c73()
net: pcs: xpcs: add xpcs_linkmode_supported()
net: mdio: add linkmode_adv_to_c73()

which based on your recent comment about c73 stuff, I'm not intending
to submit due to the 2500base-[K]X issue. The second patch may be of
some use however. I'll send that separately once this series has been
reviewed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

