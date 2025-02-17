Return-Path: <netdev+bounces-166910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C03A37D95
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3207A3AC963
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C571A3A95;
	Mon, 17 Feb 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kYK7wIm3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E51A23AE
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782495; cv=none; b=uPYo5FO0s3dSDQ7zoOkuSJpmEFUEYD01fMlFmtNBmqI5p3so9CIidVVonxiOyXqCbD/3F2Hwa/lJMiXLlwd2I0hneu0HBwvfi8o+yh7gAQ+1Z/sOfP5o0u0Uobg/UhZsiiU6NesRsju8TDo8zfFVveLmGDUGSfkCPT5iCWIuv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782495; c=relaxed/simple;
	bh=uwV6NrqWW6hip5e1JYZ2H6MUcmc68rJgGcEpoCDMaww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKfHAudHWyBly67GGlLDFQ8o0oIhfb/Fgi4PssbvGYECUJDC5eYh7zJt7/vMeHJ4V+iziPwih3hE7u5Qt1UDLbxP92JTEFTWT1N3VDCDRfefdynCZaEbsFa5YrKbPNgS3WYGq9cV9cd7OwGclvIe3V/vZMjMD8/D79H1JpQVnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kYK7wIm3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=axDwhparsPFBDQM9hta0hYR6+/0yeEeUHojLz9LNtWw=; b=kYK7wIm3uMrXr1phrgzWlsMIiN
	1mGhYlCnkvFOU9SkoZlNVDSCzKUrM99SqIYmNcVgf9YgeZhWy6IWagX3VBZkX8WAKFh/oHJ3yQgKv
	sTJLdtQrc7FMHSEh84S6srxFqYEjEz5ZnGBMovAQaYfFeQ3J10p8R4AASdObFa0Z4z+fsY4EzIL6P
	DLlwvhRSmeEjteO4SzCheoSa4aTHuqPck01Cy9u82l3ibTR6g5L/9I60Rdl48ZOj7MiKOqNy0K/M8
	0Bhxml95Aw+OlOh5l1C/fgGw4yAnWBVGwYqwm+57QXDo8mG4zYjuw/vZbMa45GxiJ55Mh9UCCix2i
	gX83wWZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjwts-0005rj-1L;
	Mon, 17 Feb 2025 08:54:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjwtr-00064r-11;
	Mon, 17 Feb 2025 08:54:47 +0000
Date: Mon, 17 Feb 2025 08:54:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/6] net: phy: remove disabled EEE modes from
 advertising_eee in phy_probe
Message-ID: <Z7L5VziCEn_q5DeT@shell.armlinux.org.uk>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <493f3e2e-9cfc-445d-adbe-58d9c117a489@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493f3e2e-9cfc-445d-adbe-58d9c117a489@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:17:48PM +0100, Heiner Kallweit wrote:
> A PHY driver may populate eee_disabled_modes in its probe or get_features
> callback, therefore filter the EEE advertisement read from the PHY.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

