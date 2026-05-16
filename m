Return-Path: <netdev+bounces-288639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLmwBvCBCGo2tAMAu9opvQ
	(envelope-from <netdev+bounces-288639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 16:40:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9155C20B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CA43007356
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860823E1696;
	Sat, 16 May 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xOsOfCF2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571393E2ABE;
	Sat, 16 May 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942444; cv=none; b=WZSZ5EeOCrccDcZ5i9lMNgjDFUBh2gjYWK3nHVvatXRceGTPKJXs1NGaCNIKE0MF91MF+dLU7V8k29pIyjUtNuU9QjrbNtaw399iSLhDktdwIfYp/lmGq9PRzTIhKdJpI+mRwZIEZm1YqOLCmCGa8txhwgl7erDTtBudN3k6vyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942444; c=relaxed/simple;
	bh=AyofXCFE6jBNxym9ihjfxFz6RLsIaid4691EcS6ps80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzusPn69socLDSes848DN1CeUqnw6GoRiTJEsR9rkT0S7XbT2g80FET6EfN3QT4484GCa1x+E/I2LDLR0XIb+Kc/4WP4fZclNqAkKFIxvqxliFunBjACNSW95hmDkrCbbJYdczAN9kcgOlAtSIl3QllncirAX5q15rXk9tzaR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xOsOfCF2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nX8W65VuJAoSGN+OaiKWzI/OENqI9wC5+iFOehOGmWU=; b=xOsOfCF22B9Kta59doy4bCtfME
	FSuzr7GsSQDKmTBPw2jWi0tjY24twSa1V0eipnDWh5nJHQt0UptH8GgUaigo+9mOdGjV1jFrp3BJO
	xh+jaTcdAO9UQydYDn91AUKNy//2wm4cuuqseAIRxuszXIPou0eY4hUx02JM9dpzP56o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOGBl-003EGG-Jv; Sat, 16 May 2026 16:40:25 +0200
Date: Sat, 16 May 2026 16:40:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: honor eee_disabled_modes in phy_support_eee()
Message-ID: <c18fa685-0ff6-4783-a26e-aa375df1ed71@lunn.ch>
References: <20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de>
X-Rspamd-Queue-Id: 6AF9155C20B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 06:51:02AM +0200, Nicolai Buchwitz wrote:
> phy_support_eee() copies supported_eee into advertising_eee
> unconditionally, overwriting any filtering applied during phy_probe()
> based on DT eee-broken-* properties or driver-populated
> eee_disabled_modes. MAC drivers that call phy_support_eee() after
> probe (e.g. bcmgenet, fec, lan743x, lan78xx, r8169) then cause the PHY
> to advertise EEE for modes the user marked as broken.
> 
> The symptom is that ethtool --show-eee on the local interface reports
> "not supported" (supported & ~eee_disabled_modes is empty) while the
> link partner sees EEE negotiated and active.
> 
> phy_probe() already filters advertising_eee via eee_disabled_modes
> after calling of_set_phy_eee_broken(). Apply the same mask in
> phy_support_eee() so the filtering survives the copy.

I don't think this not the full fix.

of_set_phy_eee_broken() sets phydev->eee_disabled_modes.

genphy_c45_ethtool_get_eee() masks supported_eee with this when
reporting to user space what is supported.

genphy_c45_ethtool_set_eee() will also mask what user space passes in,
if it is not empty. However, if nothing is passed in,
phy_advertise_eee_all() is used, and that does not make use of
phydev->eee_disabled_modes, which i think it should.

So while your fix seems correct, i don't think on its own, it is
sufficient. Whenever phydev->supported_eee is used, we need to review
the code and see if it should be masked by phydev->eee_disabled_modes.

    Andrew

---
pw-bot: cr

