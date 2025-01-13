Return-Path: <netdev+bounces-157811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16149A0BD2C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6C83A9EAA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C725760;
	Mon, 13 Jan 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U6sya9U8"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB01CAA87
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785386; cv=none; b=mWclad5BDljSu6c5F6vfjUw2+GsL+wicLm+9Wz2EYGvL08Z9gpnL8vSzg1VWLuFgqU4LqKAvFqHvTi1tj7eAs4QRpD8eFrbVvxsfjJtfpwye9DXtlfslSFB9nPeuFJfheYpekpjQ8TiO7C0S4iegUdQn0US4NDmKSyOsQeAXgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785386; c=relaxed/simple;
	bh=LoZ1Pqh9Di665toUrGLlNS9e5AwJ/aKbGnrZXNG+3EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLpnGDRnk892YALpBCMLoaAUCPJSyFYnYAkeRqVhkcBQ52jJ9YA8a8YT8chLbCnYYDZ7NeP2+pjc78JbHlhSpbiejau1GKKzimOO3zBjtZpNpniKzQ2HG2QT9SKCGxJWEeQgthfVF7lc7kMdYF0zdl+6DuF9oU/1f+NuLBfpuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U6sya9U8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEFF41C0008;
	Mon, 13 Jan 2025 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736785382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUDw3kvKolhpUjOdJ7XwzQnmZAdNK5carUKXfz4URKw=;
	b=U6sya9U8Jron8CxjyT1kKNFV7NYolRM3yYla103nP9LRuqaLt/3HGsXiNATsmbsCfw8IAE
	0qS4C224oZwjsCidXCYCGZ41qIuW6RKg/LopwQuKINAhjes+h6T5l0XgwQmzDGzWiQikDQ
	nI5u7+E6VinhnKUhj14BSgOp/QS7Sm+4V960HB4VBGL94ASbS6LQuhZJGrlvLrsd8pVr60
	5iTs5Hfi+88+Z4ARtyMs1mdltQ4YgoKtaYye2xuTjmC8sVqkRqGiKcKRTBLp7dSWp8p4Cj
	y5CiEwY3gbG81sI8SHyFQ54JTFyGwBoqvvqzZ4hw377JxlGZvcTTaJnShfm99Q==
Date: Mon, 13 Jan 2025 17:22:55 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Couzens <lynxis@fe80.eu>, Alexander Duyck
 <alexanderduyck@fb.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Daniel Golle <daniel@makrotopia.org>, Daniel
 Machon <daniel.machon@microchip.com>, "David S. Miller"
 <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Eric Woudstra <ericwouds@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>,
 kernel-team@meta.com, Lars Povlsen <lars.povlsen@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Madalin Bucur <madalin.bucur@nxp.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Paolo Abeni <pabeni@redhat.com>, Radhey
 Shyam Pandey <radhey.shyam.pandey@amd.com>, Sean Anderson
 <sean.anderson@seco.com>, Sean Wang <sean.wang@mediatek.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Taras Chornyi
 <taras.chornyi@plvision.eu>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <olteanv@gmail.com>
Subject: Re: [PATCH net-next v2 0/5] net: phylink: fix PCS without autoneg
Message-ID: <20250113172255.3772dd6a@fedora.home>
In-Reply-To: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Mon, 13 Jan 2025 09:22:15 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Hi,
> 
> Eric Woudstra reported that a PCS attached using 2500base-X does not
> see link when phylink is using in-band mode, but autoneg is disabled,
> despite there being a valid 2500base-X signal being received. We have
> these settings:
> 
> 	act_link_an_mode = MLO_AN_INBAND
> 	pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED
> 
> Eric diagnosed it to phylink_decode_c37_word() setting state->link
> false because the full-duplex bit isn't set in the non-existent link
> partner advertisement word (which doesn't exist because in-band
> autoneg is disabled!)
> 
> The test in phylink_mii_c22_pcs_decode_state() is supposed to catch
> this state, but since we converted PCS to use neg_mode, testing the
> Autoneg in the local advertisement is no longer sufficient - we need
> to be looking at the neg_mode, which currently isn't provided.
> 
> We need to provide this via the .pcs_get_state() method, and this
> will require modifying all PCS implementations to add the extra
> argument to this method.
> 
> Patch 1 uses the PCS neg_mode in phylink_mac_pcs_get_state() to correct
> the now obsolute usage of the Autoneg bit in the advertisement.
> 
> Patch 2 passes neg_mode into the .pcs_get_state() method, and updates
> all users.
> 
> Patch 3 adds neg_mode as an argument to the various clause 22 state
> decoder functions in phylink, modifying drivers to pass the neg_mode
> through.
> 
> Patch 4 makes use of phylink_mii_c22_pcs_decode_state() rather than
> using the Autoneg bit in the advertising field.
> 
> Patch 5 may be required for Eric's case - it ensures that we report
> the correct state for interface types that we support only one set
> of modes for when autoneg is disabled.
> 
> Changes in v2:
> - Add test for NULL pcs in patch 1
> 
> I haven't added Eric's t-b because I used a different fix in patch 1.

I stumbled on that issue last friday as well, with a MCBin and a
device I'm working on, using 1000BaseX with autoneg disabled. I didn't
get time to investigate back then, but reading this series it was
definitely that exact problem I was facing.

I missed your V1 and I just tested that V2, the problem is gone :)
Thanks !

The code LGTM to the best of my knowledge, so

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

