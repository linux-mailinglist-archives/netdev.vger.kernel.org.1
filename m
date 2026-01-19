Return-Path: <netdev+bounces-251100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D041D3AB16
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A9DF300AC93
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099D36C587;
	Mon, 19 Jan 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="McYHLsoU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAC36D513;
	Mon, 19 Jan 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831389; cv=none; b=YZsstVupKqq1JmbNQWp4ZYcrZMhGqigWGo8Svagi4zophJ+JFKouMBg09rCbRbQdC6WoNkwypRmL36Mtw3lDKDLnFhsS9S7PiJtLmhk+7VizhZS3+UpjGcwS0C35qjItctP+9uISFedcIhaGRg3dS18L/WpMiNtuIDZWk7wKzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831389; c=relaxed/simple;
	bh=zy7qGyHcgXKTbVBu7KbB87S9Xan5KyuqjsKyQptoqsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNBRbEOyjdz0wWSfxLBenQl8mmCVHgkvFNiljli4EvUOclaXyPtEUdgoKgzDKc5HInwvAAhSVjPftrc9k/BtkJznPrUbx9V2R+QMxV8mVeYuoUyMsMij0SmAGAcRnmgzf3oYZ7a4oIgW28Rh4iZrZI2Uh7ewu99/mOgp/J2gjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=McYHLsoU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RVJhMHq8ld88SqHnXA6hXJehvsR4bZGlV03k7YNUTL8=; b=McYHLsoU+BccPO2uVchv/KfFuU
	uPvI7rOtllIB1vlBKUEzW0QnLBCjnXsR1dzM/Onb9eSEpJnzs0DFF7Q6A4Hq/i5FO7WS+et2clfum
	qasKMZ3mrVPV91xzmnrLzPsYKRFpzyMS9/4H9y8OK4KATRa/A+yHRVvS9V0N3LLeja2PlCTEWMKpD
	qO5a5rCM3DJiUlgzhGmbFyddGt6bv5L5xhQS1Z6PQaAWPwMbomEB8fNaTnGSGywyblcOXd7Eh0Xlk
	CO6pqOHaCOfS+SsCCwKHUYGnPtklqSw7iDO2O3/ZiWhZhfpdU88EopNNElVWC6ZNhaE/qDMVr8iUF
	y+MlY7Cg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37842)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhpqT-000000005GR-3aqB;
	Mon, 19 Jan 2026 14:03:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhpqS-000000006bq-27WA;
	Mon, 19 Jan 2026 14:03:04 +0000
Date: Mon, 19 Jan 2026 14:03:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 2/4] net: phylink: introduce helpers for
 replaying link callbacks
Message-ID: <aW45mL8EdXPtvwtU@shell.armlinux.org.uk>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
 <20260119121954.1624535-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119121954.1624535-3-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 19, 2026 at 02:19:52PM +0200, Vladimir Oltean wrote:
> Some drivers of MAC + tightly integrated PCS (example: SJA1105 + XPCS
> covered by same reset domain) need to perform resets at runtime.
> 
> The reset is triggered by the MAC driver, and it needs to restore its
> and the PCS' registers, all invisible to phylink.
> 
> However, there is a desire to simplify the API through which the MAC and
> the PCS interact, so this becomes challenging.
> 
> Phylink holds all the necessary state to help with this operation, and
> can offer two helpers which walk the MAC and PCS drivers again through
> the callbacks required during a destructive reset operation. The
> procedure is as follows:
> 
> Before reset, MAC driver calls phylink_replay_link_begin():
> - Triggers phylink mac_link_down() and pcs_link_down() methods
> 
> After reset, MAC driver calls phylink_replay_link_end():
> - Triggers phylink mac_config() -> pcs_config() -> mac_link_up() ->
>   pcs_link_up() methods.
> 
> MAC and PCS registers are restored with no other custom driver code.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This approach looks reasonable from a quick glance (which is all I
currently have time to do at the moment.)

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

