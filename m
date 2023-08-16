Return-Path: <netdev+bounces-28189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8043677E9CD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403F51C211B8
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45317751;
	Wed, 16 Aug 2023 19:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13314A80
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 19:39:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7762720;
	Wed, 16 Aug 2023 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XBrGNwityOqu1WOq5YiirS65EdsM79s51TK3CZzvdPo=; b=Wz2FwOW2Pki0Qtv8KBCjFX0XUA
	yeQ4kHE1vTiLeQcSC+0MgUF6WLhlF66hBVUuBKjAiiHon8WqWEM9JAM2aBREPEX/rrwsZAplUI272
	CFZw2I4KPyEWixNrzbnblRG9Z+KgqJwAmHql5X+BSFZk722nDM272/Nuwbc0hc2pdBUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWMMj-004JBZ-Hs; Wed, 16 Aug 2023 21:39:37 +0200
Date: Wed, 16 Aug 2023 21:39:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Walle <michael@walle.cc>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
Message-ID: <898c8b42-c3ad-4c2c-8903-c25f58a4d079@lunn.ch>
References: <20230816180656.18780-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816180656.18780-1-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 09:06:52PM +0300, Serge Semin wrote:
> Based on the original code semantic in case of Clause 45 MDIO, the address
> command is supposed to be followed by the command sending the MMD address,
> not the CSR address. The commit 002dd3de097c ("net: mdio: mdio-bitbang:
> Separate C22 and C45 transactions") has erroneously broken that. So most
> likely due to an unfortunate variable name it switched the code to sending
> the CSR address. In our case it caused the protocol malfunction so the
> read operation always failed with the turnaround bit always been driven to
> one by PHY instead of zero. Fix that by getting back the correct
> behaviour: sending MMD address command right after the regular address
> command.

I'm actually surprised we have not got more reports of me breaking
MDIO with this patchset. I did test bit-banging, but only for C22.

> Fixes: 002dd3de097c ("net: mdio: mdio-bitbang: Separate C22 and C45 transactions")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

