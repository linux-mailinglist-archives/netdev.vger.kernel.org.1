Return-Path: <netdev+bounces-17548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CD751F51
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D06281C58
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CA101E1;
	Thu, 13 Jul 2023 10:53:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C079CB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:53:52 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF7B2683
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nRcZIsKxvmrAshmovqZ0PBHkbboYrBOuJKzoR64nZs4=; b=Zz+epBMrff5eGpjPcaYhQB0zg9
	GAftyB9r9GL9Rxk08RWe8lMyWd3XUwchJwvLCjxKXuAy5KijW47csQY7ST/JiZh0mR0zOA4+JgfB5
	85eRn0YqEPpN4x9wchmIsZFxKRm/msarYBbDarr2xyegCdfz+Givj8hnFTnZ0gstDqK112Nisu81q
	E5e5po4wxaVwkGGcExhcjPtxzKBtd36753ttO/yRU1NoSgoiLVIPVeGC6k8C1jKX5Kp2md5aIDwGV
	8JcGrfphSn9eArbpSkEOag8cKShxpjBEOpweVATVhMSajxxAlpoLCH6ZdrRz88J4oEs0MtXnBqUor
	9XGLqXFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55938)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJtx9-0006l7-1a;
	Thu, 13 Jul 2023 11:53:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJtx8-00065s-K2; Thu, 13 Jul 2023 11:53:42 +0100
Date: Thu, 13 Jul 2023 11:53:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <simon.horman@corigine.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
 <ZK/RYFBjI5OypfTB@corigine.com>
 <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
 <ZK/V57+pl36NhknG@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/V57+pl36NhknG@corigine.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:45:59AM +0100, Simon Horman wrote:
> On Thu, Jul 13, 2023 at 11:35:05AM +0100, Russell King (Oracle) wrote:
> > On Thu, Jul 13, 2023 at 11:26:40AM +0100, Simon Horman wrote:
> > > On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> > > > Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> > > > it sometimes does not take effect immediately. This will cause
> > > > mv3310_reset() to time out, which will fail the config initialization.
> > > > So add to poll PHY power up.
> > > > 
> > > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > 
> > > Hi Jiawen Wu,
> > > 
> > > should this have the following?
> > > 
> > > Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")
> > 
> > What is that commit? It doesn't appear to be in Linus' tree, it doesn't
> > appear to be in the net tree, nor the net-next tree.
> 
> Hi Russell,
> 
> Sorry, it is bogus. Some sort of cut and paste error on my side
> that pulled in the local commit of an unrelated patch.
> 
> What I should have said is:
> 
> Fixes: 8f48c2ac85ed ("net: marvell10g: soft-reset the PHY when coming out of low power")

Thanks, but I don't think that's appropriate either.

The commit adds a software reset after clearing the power down bit, but
that doesn't have anything to do with mv3310_reset().

There are two places that mv3310_reset() is called, mv3310_config_mdix()
and mv3310_set_edpd(). One of them is in the probe function, after we
have powered up the PHY.

I think we need much more information from the reporter before we can
guess which commit is a problem, if any.

When does the reset time out?
What is the code path that we see mv3310_reset() timing out?
Does the problem happen while resuming or probing?
How soon after clearing the power down bit is mv3310_reset() called?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

