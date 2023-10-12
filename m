Return-Path: <netdev+bounces-40477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA077C77DD
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0451C20EC9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4083D399;
	Thu, 12 Oct 2023 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="czAGNXYM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01273D38C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:24:51 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7FDD
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zVVjh9vMESdndK1O3Gkjn+lT8wRkRCe0artB4X9mVmc=; b=czAGNXYMgV9bK15mcBOWpLFd2u
	KY9LdDggWdsFtICsn1xN5l93SlTOZgNgJ95eeK8ixM2sWk/8g86+gE3cHKQLPW4VbVxo58w9b/5zq
	6SYcaKxZXDhQgOlHYvzR+cWu+DHfQ+63nQHG7RC52Eo+sRTK3fUqkPinEHngTebbC3Ao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qr2Ee-00211C-Jf; Thu, 12 Oct 2023 22:24:44 +0200
Date: Thu, 12 Oct 2023 22:24:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, opendmb@gmail.com,
	justin.chen@broadcom.com
Subject: Re: [PATCH net-next 1/2] ethtool: Introduce WAKE_MDA
Message-ID: <779d6ab4-0c15-4564-9584-1c5332c1f5d1@lunn.ch>
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
 <20231011221242.4180589-2-florian.fainelli@broadcom.com>
 <20231011230821.75axavcrjuy5islt@lion.mk-sys.cz>
 <3229ff0a-5ce5-4ee2-a79d-15007f2b6030@gmail.com>
 <78aaaa09-1b35-4ddb-8be8-b8f40cf280bc@lunn.ch>
 <0271cea4-f2ab-4d8c-aa0a-9dd65a1318db@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0271cea4-f2ab-4d8c-aa0a-9dd65a1318db@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > My previous concern was discoverability of the feature. Its not part
> > of ethtool -s eth0 wol. At minimum, i would suggest something in the
> > --help text in the wol section and man page pointing to the
> > alternative way to configure wol. And maybe report via the standard
> > wol flags that the hardware has the capability to use flow-type WoL?
> 
> WAKE_FILTER is supposed to be set by the driver if it supports waking-up
> from a network filter. That is how you would know that the device supports
> waking-up from a network filter, and then you need to configure the filters
> with ethtool -N (rxnfc).
> 
> Where this API is a good fit is that you can specify a filter location and
> the action (-2 = RX_CLS_FLOW_WAKE) to indicate where to install the filter
> and what it should do. Where it may not be such a great fit is that it is a
> two step process, where you need to make sure you install filter(s) plus
> enable WAKE_FILTER from the .set_wol() call.
> 
> At the time it was proposed it felt like a reasonable way to program,
> without having "ethtool -s eth0 wol" gain a form of packet matching parser.
> Also, it does not seem to me like we need the operations to be necessarily
> atomic in a single call to the kernel but if we feel like this is too
> difficult to use, we could consider a .set_wol() call that supports being
> passed network filter(s).
 
I think two step is fine. I would say anybody using rxnfc is a pretty
advanced user.

But we should clearly define what we expect in terms of ordering and
maybe try to enforce it in the core. Can we make the rxnfc call return
-EBUSY or something and an extack message if WAKE_FILTER has not been
enabled first?

	Andrew

