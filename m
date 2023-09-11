Return-Path: <netdev+bounces-32773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA1D79A65D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE1B1C204FC
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF2BE57;
	Mon, 11 Sep 2023 08:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F5AD38
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 08:55:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C91A1
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hK5N1xkZD90QK5x/uvWw9uPoE8nMFdDFrplF6CaEOY8=; b=nQRksg/QjHskXIliQy6wAiiVQu
	R2wogu519ojX7LW+3fSOZEYSlhQ8Gh1rReH8BvuxnVuyAm2prURl9n2diI2hwrpjtiqlxwi2pUNLz
	zR6LTbF8DbOYKjDqibooy9KGvTaXTDEMnIdoAFtemPIc+hH1FSVjEHmmZeCO0zkFRSJTcWczdlbV5
	fyQ/9dcN9YUg4uMdh5kZ7qiZriGFzW1Xtcv+WU/IpW9dzYGbR733ybHtaky/1E2Affu9doata8KFa
	ywA+k/98HZFxGW5S4iqWb4eD3nRM/pWxmM8/eq+vxK1DS77TojVd+mJBhZrjcbc6GrgxGPHyJI+xH
	1AHRtQpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41620)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qfch6-0007bf-25;
	Mon, 11 Sep 2023 09:54:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qfch4-0001XB-CC; Mon, 11 Sep 2023 09:54:54 +0100
Date: Mon, 11 Sep 2023 09:54:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, lanhao@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
	wangjie125@huawei.com, wangpeiyang1@huawei.com
Subject: Re: [PATCH RFC net-next 0/7] net: phy: avoid race when erroring
 stopping PHY
Message-ID: <ZP7V3jHYgyvnTeuf@shell.armlinux.org.uk>
References: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

It would be good if Jijie Shao could test these patches and provide a
tested-by as appropriate.

Thanks.

On Fri, Sep 08, 2023 at 12:20:22PM +0100, Russell King (Oracle) wrote:
> This series addresses a problem reported by Jijie Shao where the PHY
> state machine can race with phy_stop() leading to an incorrect state.
> 
> The issue centres around phy_state_machine() dropping the phydev->lock
> mutex briefly, which allows phy_stop() to get in half-way through the
> state machine, and when the state machine resumes, it overwrites
> phydev->state with a value incompatible with a stopped PHY. This causes
> a subsequent phy_start() to issue a warning.
> 
> We address this firstly by using versions of functions that do not take
> tne lock, moving them into the locked region. The only function that
> this can't be done with is phy_suspend() which needs to call into the
> driver without taking the lock.
> 
> For phy_suspend(), we split the state machine into two parts - the
> initial part which runs under the phydev->lock, and the second part
> which runs without the lock.
> 
> We finish off by using the split state machine in phy_stop() which
> removes another unnecessary unlock-lock sequence from phylib.
> 
>  drivers/net/phy/phy.c | 204 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 110 insertions(+), 94 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

