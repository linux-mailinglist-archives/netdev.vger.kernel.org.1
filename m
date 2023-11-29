Return-Path: <netdev+bounces-52057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D87FD2B4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA72282E1E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CC14F67;
	Wed, 29 Nov 2023 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uxdg67Cs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D82108;
	Wed, 29 Nov 2023 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jGrCfYezTPSxeFbranpvlau+kjAnGU8RqjVFS/ZmLXQ=; b=Uxdg67CsfehvK7viG1Zgn3GPuj
	0A/HVeEsCtowUhjKDU3XJZ3KVt0seKhx8eR1OYtSERWNllYQwBfeq9DtBVQcbSRVZlbjUGDWwmIGr
	uoEdm/8OA1cQKYHBQ+V1YkibDaki6i0UGnFVNS11EJgvNQ3kJPCRWL6XnsBWHv8E8MjV3Bg+0mJVm
	4xpkFTq90f1SYQtTEdUWl0S0VqkOkQA6mWM4sFrqbw1CiY2dTbLEaGpVycyfFAGqUoN6XO37ReW1T
	61edQLeYA+pEnbpBfbsf3v37Yue6nRROzdK5A5lIJ4vSMG3THHAbQz25WmHstuHKiReJQnt/G7Wxe
	AuaMSXow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37716)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r8Gsk-0008Tj-0Q;
	Wed, 29 Nov 2023 09:29:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r8Gsm-0003rS-5F; Wed, 29 Nov 2023 09:29:24 +0000
Date: Wed, 29 Nov 2023 09:29:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 04/14] net: phy: at803x: move qca83xx stats out
 of generic at803x_priv struct
Message-ID: <ZWcEdDFFCs17T5ha@shell.armlinux.org.uk>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-5-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 29, 2023 at 03:12:09AM +0100, Christian Marangi wrote:
> +struct qca83xx_priv {
> +	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
> +};

If QCA83xx is going to use an entirely separate private data structure,
then it's clearly a separate driver, and it should be separated from
this driver. Having two incompatible private data structures in
phydev->priv in the same driver is a recipe for future errors, where
functions that expect one private data structure may be called when
the other private data structure is stored in phydev->priv.

So, if we're going to do this, then the QCA83xx support needs to
_first_ be split from this driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

