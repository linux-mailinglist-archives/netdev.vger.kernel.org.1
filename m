Return-Path: <netdev+bounces-168590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F5A3F6FB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434618616A7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885B70821;
	Fri, 21 Feb 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0/Sbe6zB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9F7080D
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147336; cv=none; b=pYBifoxgjV6DPf9IJc8vIJ+e8Rn9IfrNuIlelyMTj/ANZUQO4GJeNO/Xx07W6H5FxEYRow7MTp5RQDkY4Kn4/jZChwwV1tYRmikSpQQEcAX36EjA/Q+KKcGRhVhghCI2IatvmFCebqq0YqNnO0h3HCOd5THl9O/z49K+vbP8TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147336; c=relaxed/simple;
	bh=H5yh3XlqfVet82WCCkr5ue7OJLEw93JfvwdwqcALVHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fqbHc4NCKzVCk/dBQ/Begd/4FMRv2CMYrqzN7AmIyUiohlzd6nekB1nwWX7goDu3EVZR24KyLFe/CqX9GJ44J37Yhcx3hRSyHXLp0LrIyyaaQEd3Q0wdjK8a2w5OhI/njKmfuNQkv2zTAjVTA+1rqkDEXqDt+2HQVh2jjJWGpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0/Sbe6zB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZN090mxAPz84RAmjDf1ffqgTe4ng9t/Mi1/ZHq++UpE=; b=0/Sbe6zBOF5wWfA8ZGcllkkHOu
	tAQPGfV0LWLk2aLeX2iOW3NchjXJWQjzLAX652zVJ8XRPNZc6RRylLZVEzVtOfzgC9GgS5bxFd0WC
	TyG0hSJXiSZSnId8QQCxJVWSdnr1ccNyBUxwUx0Wsbxx/C06VxWuEhNFProVooYVF1ShrIV7i1MK8
	An9WxG+DHPwaJGy8aCFnKRKK0unAJjNtjvSfjl1/AKDj+Ie8ttmp2B+12n5mUEaV0gG5nJ5hFmGEM
	ln+zk/UrQfwec/G+KuVUJakLk7zIqlAG/lv3zM2UoOrSb/ooFhNywzerlCXYNVMnb2+tfUS8S9WuJ
	ZhqypXRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tlToH-0004nV-1b;
	Fri, 21 Feb 2025 14:15:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tlToD-00023s-0v;
	Fri, 21 Feb 2025 14:15:17 +0000
Date: Fri, 21 Feb 2025 14:15:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>, Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: thead: clean up clock rate setting
Message-ID: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series cleans up the thead clock rate setting to use the
rgmii_clock() helper function added to phylib.

The first patch switches over to using the rgmii_clock() helper,
and the second patch cleans up the verification that the desired
clock rate is achievable, allowing the private clock rate
definitions to be removed.

 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 28 ++++++++---------------
 1 file changed, 9 insertions(+), 19 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

