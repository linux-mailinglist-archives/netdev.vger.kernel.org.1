Return-Path: <netdev+bounces-18594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65C757CC8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5201C20D05
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF55D2F0;
	Tue, 18 Jul 2023 13:01:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA3D50C
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:01:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4711FC6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ewzm0xhIbc+t0uCS8YB3TFuu2PKx1WD6uU8fYlC3qO0=; b=d091isMtnfTuzzhyeq0TqHXCMf
	7LJVsrqtAgqHXFmENcmWQoSBgisIgmDaJ4fvbm9qAVc4W2i0nq4iAS722YEvniI0r7n+JMGnxniZ/
	BxWpdrZ/f91oQj6EldSJzalMGkbmSNdyOtFqfMuoRmCxoP2fArG4e4wkFXoZyOm3u2P8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLkJv-001cmP-0f; Tue, 18 Jul 2023 15:00:51 +0200
Date: Tue, 18 Jul 2023 15:00:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <501615b6-a345-4ecd-9773-1e8d3cb4dfb2@lunn.ch>
References: <20230717193350.285003-1-eichest@gmail.com>
 <20230717193350.285003-6-eichest@gmail.com>
 <dbd85f63-6abc-4824-a5ec-3ed5f270ffeb@lunn.ch>
 <ZLY7+aM4IUw+T3cH@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLY7+aM4IUw+T3cH@eichest-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 09:16:32AM +0200, Stefan Eichenberger wrote:
> Hi Andrew,
> 
> On Mon, Jul 17, 2023 at 11:54:39PM +0200, Andrew Lunn wrote:
> > > +#define MARVELL_PHY_ID_88Q2110	0x002b0981
> > 
> > > +
> > > +static struct phy_driver mv88q2xxx_driver[] = {
> > > +	{
> > > +		.phy_id			= MARVELL_PHY_ID_88Q2110,
> > > +		.phy_id_mask		= MARVELL_PHY_ID_MASK,
> > 
> > Probably not an issue...
> > 
> > The ID you have above is for revision 1 of the PHY. But the mask will
> > cause the revision to be ignored. Do you want to ignore the revision?
> > Are there different errata for revision 0 and 1?
> 
> A0 to A2 (Rev 1-3) are the same software wise for the current scenarios.
> Z0 (Rev 0) might behave slightly different in the reset scenario but
> most likely it works as well. Unfortunately, I could not test it because
> I don't have such a device.

Thanks.

Please consider Marek comment, but:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

