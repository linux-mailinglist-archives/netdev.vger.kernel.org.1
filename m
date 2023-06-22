Return-Path: <netdev+bounces-13115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836E73A532
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE1C28184A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A071F94B;
	Thu, 22 Jun 2023 15:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25A1DCB0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:37:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173AF118;
	Thu, 22 Jun 2023 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4lUNPdzeGRfvUv6WjT+IRwoZNLTeUVrgSIo14geZN8U=; b=rT+/pP0BC4mmt62uwzA4v1uCpj
	w3HdtFaJRe54kWXL6Dqf/7+4PgtV7oTVZg7JJ8Zp7KxuXEc1ikzrkm89gMzgObPTgJX5HdBueDsr2
	sdRmqmTvEWW3U2L7l9u3nKQIJys+wFMkCUOU6eIidiVgFILQxwxTwcrmwKA9hSo1PKFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCMMS-00HHKJ-Mz; Thu, 22 Jun 2023 17:36:40 +0200
Date: Thu, 22 Jun 2023 17:36:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, ansuelsmth@gmail.com,
	rmk+kernel@armlinux.org.uk, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: bcmgenet: Ensure MDIO unregistration has clocks
 enabled
Message-ID: <533872e1-b323-4bca-aacc-4d3cfbed53bd@lunn.ch>
References: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 03:31:07AM -0700, Florian Fainelli wrote:
> With support for Ethernet PHY LEDs having been added, while
> unregistering a MDIO bus and its child device liks PHYs there may be
> "late" accesses to the MDIO bus. One typical use case is setting the PHY
> LEDs brightness to OFF for instance.
> 
> We need to ensure that the MDIO bus controller remains entirely
> functional since it runs off the main GENET adapter clock.

So this clock is enabled in bcmgenet_open() and disabled in
bcmgenet_close(). The assumption being, the MDIO bus is only used when
the interface is up.

How does this work when there is an MDIO based switch attached? I had
similar problems with the FEC and mv88e6xxx. DSA would try to talk to
the switch with the master interface down, and MDIO would time out. I
needed to add runtime PM support to the MDIO bus ops.

       Andrew

