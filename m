Return-Path: <netdev+bounces-27186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7A77AAA6
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 20:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12A0280D83
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C888C18;
	Sun, 13 Aug 2023 18:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F6625
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 18:52:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B768124;
	Sun, 13 Aug 2023 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qkbjf27ChqO5EbWzM1wD2VroQ/eyQ9P6RhMGX5u/958=; b=I+q0QOSqSnENFIwWnF/HZLdocT
	tC7Yo24fMiJBPBpdAPZtGtcsDikLysCZPYD0eGvpQ6nzPbIsj0GLKp7aj0GzqgyNTFKTQdolaIhZN
	YwvOdzS8BzvV9wxqNW+4Sm7E/RVABWruWDNkP3XHphPzE4hmujp9bVsnw0nVaOhDsjTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qVGBt-003z4U-7a; Sun, 13 Aug 2023 20:51:53 +0200
Date: Sun, 13 Aug 2023 20:51:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: phy: mediatek-ge-soc: support PHY LEDs
Message-ID: <1bda7c1e-6a4e-491b-878b-f232972f4c3d@lunn.ch>
References: <32e534441225c62e3bf9384b797d9beda7475053.1691943605.git.daniel@makrotopia.org>
 <9bae16cd-501e-4fe5-9736-d32d958aec7c@lunn.ch>
 <ZNkQFwvm_sNiVDRO@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNkQFwvm_sNiVDRO@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 13, 2023 at 06:17:11PM +0100, Daniel Golle wrote:
> Hi Andrew,
> 
> thank you for reviewing my patch!
> 
> On Sun, Aug 13, 2023 at 07:03:21PM +0200, Andrew Lunn wrote:
> > Hi Daniel
> > 
> > > This requires syscon phandle 'mediatek,pio' present in parenting MDIO bus
> > > which should point to the syscon holding the boottrap register.
> > 
> > If i'm reading the code correct, if this property is missing, the PHY
> > will fail to probe? Since this was never a mandatory property, it
> > looks like this will break old DT blobs?
> 
> As the for-upstream-Linux dtsi for the MediaTek MT7988 SoC is still in
> the making there aren't any existing DT blobs we'd want to be compatible
> with at this point.

Ah. O.K. If there is need for a respin, please add that to the commit
message.

	Andrew

