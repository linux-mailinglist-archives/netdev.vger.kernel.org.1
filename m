Return-Path: <netdev+bounces-23947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F1E76E407
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA81C213DE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397A1548E;
	Thu,  3 Aug 2023 09:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0847E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:11:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661BE30FA;
	Thu,  3 Aug 2023 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YXtuZ2n5jga89rhZDLO410sBa+4jMqiuCMADBBP02zE=; b=gbcMZXB0Zl7jTZAO6Xp5xKovyB
	sjgOMSju3pu3/9ZOXeGOAUixyobtf8qiYkuWa/CUTllmwZYvClPRDjcHoMEgk1kuA7eFgBXDBAOua
	YdjA1y14qsHhIFllWTMY1y6XxusNUq0OFXlgrlXejPKnFr1Yp0Tw0+s6IPYao1ruN2h6GX660Pv2z
	l9pmQBYSeqVXPijk1biHtNt8sAohRoIJFN68HW9Vu9JXiEohZazFppLplumRppO+SZC+MXdIh3O/i
	7/HB/g3/V3D/6FnyCBKnbU99/lw+p7z1wwYMc5bSgscQQ626LRGNnBjQ7UuazsZrgPqB+Ki5ov1sB
	qADgm0+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39958)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qRUMr-0006dY-2x;
	Thu, 03 Aug 2023 10:11:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qRUMq-0002my-8Q; Thu, 03 Aug 2023 10:11:36 +0100
Date: Thu, 3 Aug 2023 10:11:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Li Yang <leoyang.li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Bauer <mail@david-bauer.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH v4 1/2] net: phy: at803x: fix the wol setting functions
Message-ID: <ZMtvSP0Ys2XqammZ@shell.armlinux.org.uk>
References: <20230802191347.6886-1-leoyang.li@nxp.com>
 <20230802191347.6886-2-leoyang.li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802191347.6886-2-leoyang.li@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 02:13:46PM -0500, Li Yang wrote:
> In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"), it
> seems not correct to use a wol_en bit in a 1588 Control Register which is
> only available on AR8031/AR8033(share the same phy_id) to determine if WoL
> is enabled.  Change it back to use AT803X_INTR_ENABLE_WOL for determining
> the WoL status which is applicable on all chips supporting wol. Also update
> the at803x_set_wol() function to only update the 1588 register on chips
> having it.  After this change, disabling wol at probe from commit
> d7cd5e06c9dd ("net: phy: at803x: disable WOL at probe") is no longer
> needed.  Change it to just disable the WoL bit in 1588 register for
> AR8031/AR8033 to be aligned with AT803X_INTR_ENABLE_WOL in probe.
> 
> Fixes: 7beecaf7d507 ("net: phy: at803x: improve the WOL feature")
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

