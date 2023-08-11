Return-Path: <netdev+bounces-26766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D3778E56
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D658B2821A5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73B7491;
	Fri, 11 Aug 2023 11:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202926FC2
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:56:06 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D12D69
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 04:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6SLxNOsnxTzDA0SKzJ3vwlr6PopSpMYZDq5vEXXasT4=; b=rIaVSsnRikjApPkJcq/ZJhQm+1
	6v6u+RaTsIfw17zg/eo8JI+P9fSoo3F0ZOqB7Owkt/3YV9GDb3J//KB1elPRHsByE1akjXOCTqFMv
	3DJWCwAdGQiIloj20r/0Xp1l3QN9VAuIJXdSJHsmtfPD8EdOEBntSWqETJhgCi4LmFyD86PmEItDg
	WsRo1Ha6qSD6xRe6OjEyrVQeQMY5pySl9j3GPzaNoks66cvYbdhtFuRuZ6z5eabIOVWc7VGj3bcRO
	GzjNCJytaP21MC6YbXDnbVj3Eu2B/Z22Sh7vKuB4HKV/1XLWxr7yhoEqtRlI0JRrqJbXTr0B/VQdb
	TBhtu6SA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56686)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qUQkE-0005U0-2L;
	Fri, 11 Aug 2023 12:55:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qUQkD-0002q5-D3; Fri, 11 Aug 2023 12:55:53 +0100
Date: Fri, 11 Aug 2023 12:55:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Camelia Groza <camelia.groza@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next] net: pcs: lynx: fix lynx_pcs_link_up_sgmii()
 not doing anything in fixed-link mode
Message-ID: <ZNYhyWCX16gjzqWv@shell.armlinux.org.uk>
References: <20230811115352.1447081-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811115352.1447081-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 02:53:52PM +0300, Vladimir Oltean wrote:
> lynx_pcs_link_up_sgmii() is supposed to update the PCS speed and duplex
> for the non-inband operating modes, and prior to the blamed commit, it
> did just that, but a mistake sneaked into the conversion and reversed
> the condition.

Yes, it certainly looks that way, thanks for catching this.

> It is easy for this to go undetected on platforms that also initialize
> the PCS in the bootloader, because Linux doesn't reset it (although
> maybe it should). The nature of the bug is that phylink will not touch
> the IF_MODE_HALF_DUPLEX | IF_MODE_SPEED_MSK fields when it should, and
> it will apparently keep working if the previous values set by the
> bootloader were correct.
> 
> Fixes: c689a6528c22 ("net: pcs: lynx: update PCS driver to use neg_mode")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

