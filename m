Return-Path: <netdev+bounces-117025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CF94C62C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A018B1C22120
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D101494CF;
	Thu,  8 Aug 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O9aoaGt7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FA7E1;
	Thu,  8 Aug 2024 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151270; cv=none; b=FkvzgKx8Mm5w6v7ZSFPfqpZYxayBT5vK06pvZJSagINGevF/X2IHiNkv5YVWeoCbmNuFwwWmin22Rb/+PBB+oNXBOdiLtDiQ76zVm0vujk/Kf/YllcASTT2Klwu3LFhbI19ECLCqX29U80xWaL2t/ku4ZeNETck/+N65xufdKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151270; c=relaxed/simple;
	bh=xqLHqzCU8aBwJ4Ej4AWOUupcbrGKDQvGQ1ZmHf24Hi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyU0GUcZ5wZieaZwA7RVxSC9jsMAjpBAuVegZ2w0Av04czKd8xZMXsaeM6lkwDiqjHE7CV0IzSV8HtQCDbPBX5ZR+MvWbGFpbLYYlSQLt4tr2KBmYaZfHaLZ7GQqt9ZnHczh+tC4uHDRNXN0EhbHjC8mTUJslg4pLMYO8y9EAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O9aoaGt7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VKo4u86uyyjeRTMM8OxzJuJakbhFM7FDGSWLAQkAuzw=; b=O9aoaGt7bBjOloxTMezHLsO49Q
	qNPk2NUOUmbPhmnLfseSuylMGmgiIFwKkT5KBni+UV46bQeCkWqZ56PagNl7jtQ2SejklUFQczOGc
	1PbJyVK8vc+eodC03/6gjqj2LJZz3Dk+SI3KeKpxJ7PMIFYGGlBbCv7MF9IzAtFbuz5xFZfV2rJfp
	tGcxgHKNYYea1NKy3ZzVveOypiAL6uvEAtwlqmYfUY1hbOUUyM0yk4HG/Hi0uEm78HkiIHDjAab8P
	J1NJjZsJpY6GHbdtAi/JVIS+2dRfDPCIBDmn5IXElriLG11xCbAXoKfX1jCufF8TXiR3/c1fE2YEY
	Xk9t9YqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53462)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1scAM2-0002YX-2x;
	Thu, 08 Aug 2024 22:07:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1scAM4-0005UN-G8; Thu, 08 Aug 2024 22:07:28 +0100
Date: Thu, 8 Aug 2024 22:07:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, Bryan.Whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <ZrUzkF8jj50ZgGhk@shell.armlinux.org.uk>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
 <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
 <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
 <Zqyau+JjwQdzBNaI@shell.armlinux.org.uk>
 <PH8PR11MB796562D6C8964A6B6A1CC7E595B92@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB796562D6C8964A6B6A1CC7E595B92@PH8PR11MB7965.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 08, 2024 at 08:23:38PM +0000, Ronnie.Kunin@microchip.com wrote:
> We looked into an alternate way to migrate our lan743x driver from phylib to phylink continuing to support our existing hardware out in the field, without using the phylib's fixed-phy approach that you opposed to, but without modifying the phylib framework either. 
> While investigating how to implement it we came across this which Raju borrowed ideas from: https://lore.kernel.org/linux-arm-kernel/YtGPO5SkMZfN8b%2Fs@shell.armlinux.org.uk/ . He is in the process of testing/cleaning it up and expects to submit it early next week.

That series died a death because it wasn't acceptable to the swnode
folk. In any case, that's clearly an over-complex solution for what is
a simple problem here.

The simplest solution would be for phylink to provide a new function,
e.g.

int phylink_set_fixed_link(struct phylink *pl,
			   const struct phylink_state *state)
{
	const struct phy_setting *s;
	unsigned long *adv;

	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
		return -EINVAL;

	s = phy_lookup_setting(state->speed, state->duplex,
			       pl->supported, true);
	if (!s)
		return -EINVAL;

	adv = pl->link_config.advertising;
	linkmode_zero(adv);
	linkmode_set_bit(s->bit, adv);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);

	pl->link_config.speed = state->speed;
	pl->link_config.duplex = state->duplex;
	pl->link_config.link = 1;
	pl->link_config.an_complete = 1;

	pl->cfg_link_an_mode = MLO_AN_FIXED;
	pl->cur_link_an_mode = pl->cfg_link_an_mode;

	return 0;
}

You can then call this _instead_ of attaching a PHY to switch phylink
into fixed-link mode with the specified speed and duplex (assuming
they are supported by the MAC.)

Isn't this going to be simpler than trying to use swnodes that need
to be setup before phylink_create() gets called?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

