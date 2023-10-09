Return-Path: <netdev+bounces-39022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF087BD7BE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB862814C8
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA86171D1;
	Mon,  9 Oct 2023 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DYvK21L7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67C28ED
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:56:51 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C7F94
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PSeuNVU/Fsoca3dlhrBlUcILtXx5DzZHkg/NQuL00cU=; b=DYvK21L7h1IOfuQllaWZ1Wf260
	g87V13ZtmQQENkU7BfV7m9Bzl+FTy8bZxhe4iJsRk7U6wF6G4u0+u7MVluC/Kf+AVUkFNydyZszTA
	pIAnYDKnLXGqhEbD1pbgzulwyzygJ8Osaj7PdUJk4kUobAIRP8vW8EF9Eujm+hsxni2CK5bDVcIJM
	qdOhAcR2PjIeHF5umHdLGxk1/HOCczNQoiIKNq+o6uJWQV9nLn58uyt60cIkiM4LkXDcAabrj6Tis
	189GzlrWAQZZl7gllLKdLI2uPMG47/QeRP1RDqMn2+X6kYIc4TqDrsSHxJKCVA2Odu/xL5N8Ewo5g
	79Fq/Ysw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qpn0B-0008Hd-1q;
	Mon, 09 Oct 2023 10:56:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qpn0B-0006IE-7v; Mon, 09 Oct 2023 10:56:39 +0100
Date: Mon, 9 Oct 2023 10:56:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 0/3] net: dsa: remove validate method
Message-ID: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

These three patches remove DSA's phylink .validate method which becomes
unnecessary once the last two drivers provide phylink capabilities,
which this patch set adds. Both of these are best guesses.

 drivers/net/dsa/dsa_loop.c             |  9 +++++++++
 drivers/net/dsa/vitesse-vsc73xx-core.c | 26 ++++++++++++++++++++++++++
 net/dsa/port.c                         | 15 ---------------
 3 files changed, 35 insertions(+), 15 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

