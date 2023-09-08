Return-Path: <netdev+bounces-32556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930A79865E
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25BE281999
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E54C6D;
	Fri,  8 Sep 2023 11:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CEF1863
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:00 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB461FF2
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ticEEEbSo8nOvPYC8Qkd9ImNP/7mT+DtGJtUFOASLiM=; b=V5bzmEr1CN+o8EX91SxaCKUpjd
	scgj067GYCDnpR5i+bCMIC0Q6lHLQEyGiatWeGNuALKPRrkVkRnuCgoicR3rrhLdg5jIWYdYVTS50
	dXl6vShxrkUrFfavhFoIQHt11Ggb1PfeQRTCcZiuUCvRk6XvaR0W7YyxJYf1FtZPMpQn6dO+vrUJX
	3dzSJFdSC+VIxPaaAQFk8W3SPe2ivNHEskjd7Knw+rUmpdiJoLA0osByzCYgNdd8lj/aP1EHrXhWY
	fT6ppXdKF4zhs8NmJLmexpThY3uEkfBTKHwovhsarO+L+hxFCQYQaucuNy4EQhy+sV30cPB/Te4vL
	DHaMojqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40328)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeZXE-0004s7-1t;
	Fri, 08 Sep 2023 12:20:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeZXC-0006qI-58; Fri, 08 Sep 2023 12:20:22 +0100
Date: Fri, 8 Sep 2023 12:20:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jijie Shao <shaojijie@huawei.com>,
	lanhao@huawei.com, liuyonglong@huawei.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
	wangjie125@huawei.com, wangpeiyang1@huawei.com
Subject: [PATCH RFC net-next 0/7] net: phy: avoid race when erroring stopping
 PHY
Message-ID: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series addresses a problem reported by Jijie Shao where the PHY
state machine can race with phy_stop() leading to an incorrect state.

The issue centres around phy_state_machine() dropping the phydev->lock
mutex briefly, which allows phy_stop() to get in half-way through the
state machine, and when the state machine resumes, it overwrites
phydev->state with a value incompatible with a stopped PHY. This causes
a subsequent phy_start() to issue a warning.

We address this firstly by using versions of functions that do not take
tne lock, moving them into the locked region. The only function that
this can't be done with is phy_suspend() which needs to call into the
driver without taking the lock.

For phy_suspend(), we split the state machine into two parts - the
initial part which runs under the phydev->lock, and the second part
which runs without the lock.

We finish off by using the split state machine in phy_stop() which
removes another unnecessary unlock-lock sequence from phylib.

 drivers/net/phy/phy.c | 204 +++++++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 94 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

