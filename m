Return-Path: <netdev+bounces-251997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLZHK9UlcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-251997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:15:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5A5BF07
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 340D278869C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA4364E9F;
	Wed, 21 Jan 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9gNpnQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC63168EF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012632; cv=none; b=hf6dY1u7a489dqkZKmZA1L2q/1RcUGAfhGc5uhPNHObn0DLez0/WD1vzouaqaiaq7UxT0nvF7EC/YK9zGmh0WE9I1+FnTEK2oHSob6Sz017RX+L1uSaVvikmdCfD7n33RANCP34/eAWhflDKbOhijyZ4mDYxm2k6LvYJJM0C9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012632; c=relaxed/simple;
	bh=l6oe0Xx6NOX8C66jcqBFVtoW+s+VZ1cnmvJ5QOvDMoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTzyUmHIobi8KkNDgyCVT/m1FyzjWr6oSwkHBe6vAJ8nf62pqUnJWND9JvfMNqRXtd3AVSF8N4e+GEV21YT4PSR89yvTaPBGNU92naaFa7gQeBxmBXwltnYpaUTU9MG2LRH1F4ONLWT0UTQwkmaMZ3vNA2flSVdKnByppubVZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9gNpnQj; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47eda5806d7so21095e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012629; x=1769617429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6T3WJuA4E+9aoryIRHTxSBnO+FD6uxeUirc/O0FSnGs=;
        b=i9gNpnQjXozeaul/sJG5e90lU94nf+M1hNsHqIS9fHF3WA/QT5RFr73oSNdpxTb9ov
         TSDScJ9/mYdoaHuPD7nRmd+cG+y6qrH7soPoEFCYs85L5Jh7xUOZai9HYYKf45W4M8+A
         V9rlpRhAG2PZ/TpcSWAet+PEY1fT3/8oAwXNoDnC5CWiPUNvnEe5dFwXFCh3PeUH3I2d
         aMp8DNuiILjDKRXdprvIxWPxwtI2+xpEZctF5N7zkX8eT8cTRSHPi1GTmuehHH8v6Z4Q
         /z9S5UEpsIudgY4OtCgEyWdF8frmkVBSauPbxQt/SMprdW9aIDu98FD8hEL5aVAdgEjU
         wQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012629; x=1769617429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T3WJuA4E+9aoryIRHTxSBnO+FD6uxeUirc/O0FSnGs=;
        b=PykKk4XE46RboElae10b/gPYFGWLLdZBKFR2jZl8PT8QdM79nmATX4pU+Q63+B4OdY
         O9D0z/Cl9sJHt2lG/PYz5Sias/37FhzOwRJzFZOzrmCzcdBP/y1UOialhHwl10rO/0I7
         Aa2u3cAheATCMIWrT+x5thPBpu4/34MG94aG65zGfFeHbyyKVqYNoRT5IY1W9ieoxdEW
         ldRXc3T1vG4nP4fk1/I0i2eX1zIRX0PYrbJ18wwK50OREqqDwcp1ysT1COe9KHE5kCq8
         hjdh2uqpIncwB7/MF4igr7NUS1VIdRCInBF/QjZ5LRoqxrBVD/HjznWmZKaEVoSh8uOu
         y2xg==
X-Forwarded-Encrypted: i=1; AJvYcCX1oejPkoFG6wEzC8CJj4WBhIlTyrBSCgJsooF2SU9G629MxzVVjjH014DTVCz6T4aNeH4AhEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5v7Lg3YMu1j9PQvzylU0KjV7JAgNtliTB4vgmmr1GgESs2BJG
	G6C4kYuoJC1asOrP2Px7P5f/YaITIJ+QB68Z2zArxlIioXjCC3ZpAKPZ
X-Gm-Gg: AZuq6aJlbe2MsXWe0IeCT0rtHpPB8/4JM5/YPnw4bHSsfsWw1dv/ZthDNZCsQHbNuCc
	Mbc/rsm4lMAVKhABRFc7CpC4AQrWV17UQ5Edo7nuVNDWzrVCUNfeTgHx3pAaqSKXfgVoDc7Xbk+
	dJ5Pdcct17VqwowNuwdj/HDMvI5t7z6g2xiEKCY7f7YkWT1XaMTcy1zNqcF8vEPCEbz2VbJxbtM
	dGhsO3lxNFvi7plF9DkC18dNAwVUDlrIkMSsF3Y54qyyRjWB2EPmNnRjfsIGs5YeDkenJPFZIE2
	1zmmlcoBv4MZFVMXXYK1qER1d3SkwMiahGN4Cv6er+utb3hi8GHV+LQHBWCBa2mgU/9P1tTz0GH
	J+2WzNVNvDykSMHnsyl6abhAd2vjvesiLLZ7flOsnNaUPfjq/RDG1ph2N+YKGnNOhGMleCU5TVs
	OGoFg=
X-Received: by 2002:a05:600c:64cf:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-4801e33c5ecmr150113385e9.3.1769012629150;
        Wed, 21 Jan 2026 08:23:49 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:c2ab:16f0:db90:9d02])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43597ae9f37sm8153161f8f.8.2026.01.21.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:23:48 -0800 (PST)
Date: Wed, 21 Jan 2026 18:23:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-phy@lists.infradead.org,
	davem@davemloft.net, maxime.chevallier@bootlin.com,
	alexandre.torgue@foss.st.com, mohd.anwar@oss.qualcomm.com,
	neil.armstrong@linaro.org, hkallweit1@gmail.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vkoul@kernel.org,
	andrew@lunn.ch, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,05/14] net: stmmac: add stmmac core serdes support
Message-ID: <20260121162345.4jpzvwqhfqxd7tl7@skbuf>
References: <E1vhoSH-00000005H1f-2cq9@rmk-PC.armlinux.org.uk>
 <20260119192125.1245102-1-kuba@kernel.org>
 <aW8M9ZiiftGBQIRM@shell.armlinux.org.uk>
 <20260120081844.7e6aq2urhxrylywi@skbuf>
 <aW9VHt6meEJFxV0I@shell.armlinux.org.uk>
 <20260120121114.2aedgu42i2wax3yp@skbuf>
 <aXDm0jVOYOZ9l6Wu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDm0jVOYOZ9l6Wu@shell.armlinux.org.uk>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251997-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,davemloft.net,bootlin.com,foss.st.com,oss.qualcomm.com,linaro.org,gmail.com,vger.kernel.org,google.com,lunn.ch,redhat.com,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4EF5A5BF07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 02:46:42PM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 20, 2026 at 02:11:14PM +0200, Vladimir Oltean wrote:
> > On Tue, Jan 20, 2026 at 10:12:46AM +0000, Russell King (Oracle) wrote:
> > > First, I'll say I'm on a very short fuse today; no dinner last night,
> > > at the hospital up until 5:30am, and a fucking cold caller rang the door
> > > bell at 10am this morning. Just fucking our luck.
> > 
> > Sorry to hear that.
> > 
> > > On Tue, Jan 20, 2026 at 10:18:44AM +0200, Vladimir Oltean wrote:
> > > > Isn't it sufficient to set pl->pcs to NULL when pcs_enable() fails and
> > > > after calling pcs_disable(), though?
> > >
> > > No. We've already called mac_prepare(), pcs_pre_config(),
> > > pcs_post_config() by this time, we're past the point of being able to
> > > unwind.
> > 
> > I'm set out to resolve a much smaller problem.
> > 
> > Calling it a full "unwind" is perhaps a bit much, because pcs_pre_config()
> > and pcs_post_config() don't have unwinding equivalents, unlike how
> > pcs_enable() has pcs_disable(). I don't see what API convention would be
> > violated if phylink decided to drop a PCS whose enable() returned an error.
> 
> While pcs_pre_config() and pcs_post_config() do not have unwinding
> equivalents (what would they be?) the issue here is that these could
> have changed any state that isn't simply undone by calling
> pcs_disable().
> 
> For example, pcs_pre_config() could have reprogrammed signal routing,
> clocking, or power supplies to blocks.
> 
> This already applies to Marvell DSA pcs-639x.c, where the pre/post
> config hooks change the power state of the PCS block (for errata
> handling), and the only way that gets undone is via a call to
> pcs_disable() which explicitly disables IRQs and power for the PCS. Its
> pcs_disable() isn't a strict reversal of pcs_enable(), it does more.
> 
> We already declare the interface to be dead on pcs_post_config()
> failure, but we don't do that for pcs_enable() failure.
> 
> Maybe I need to explicitly state that pcs_disable() does not directly
> balance pcs_enable(), but that _and_ the effects of pcs_pre_config()
> and pcs_post_config(). However, that itself will add to the problems.
> What if pcs_pre_config() and pcs_post_config() succeed but not
> pcs_enable()? pcs-639x needs pcs_disable() to be called, but if we
> require pcs_disable() to be balanced with a successful call to
> pcs_enable(), that messes up that driver, and pretty much makes it
> impossible to work around the errata.

What if we reordered phylink_major_config() such that phylink_pcs_enable()
comes first, followed by phylink_pcs_pre_config() -> phylink_mac_config() ->
phylink_pcs_post_config()? Superficially looking at pcs-639x, I don't
think it would break.

If we did that, we'd effectively have to also call pcs_disable() when
pcs_post_config() fails, and that is semantically compatible with saying
that pcs_disable() is balanced with pcs_enable(). It also gives the
ability for drivers such as pcs-639x to unwind in pcs_disable() any
actions done in pcs_enable(), pcs_pre_config() or pcs_post_config().

Plus, it's more natural/useful from an API perspective to say
"the PCS has to be enabled in order for anything to be done with it",
rather than the current "first mac_config cycle runs with the PCS not
enabled; subsequent mac_config cycles run with the PCS enabled".

> If you feel strongly about this, then the only thing I can think of
> doing is to move this SerDes support out of stmmac and into phylink
> (which is a point I already raised in the cover message) so that
> its failure can be dealt with at the higher level, where we can
> ensure that phy_power_off() is balaced with phy_power_on(). However,
> that means pushing even more of the stmmac specific "we need the
> clocks running to access registers XYZ or reset" weirdness into
> phylink.

I think core phylink support for generic PHYs eventually makes sense,
but at this stage it's perhaps too early, there's too much we don't yet
know. I would wait at least until it's clear, with an upstream example,
that multiple generic PHYs per phylink instance are needed: 1 SerDes PHY
per lane (for 40GBase-R etc), plus 1 retimer PHY per lane direction.
Also how do those retimers differ from SerDes PHYs. At the very least,
the phy_validate() of SerDes PHYs should be additive w.r.t.
supported_interfaces, whereas the phy_validate() of retimers should be
subtractive.

Also, moving SerDes PHY into phylink only avoids the problem, but if the
PCS driver needs to allocate memory, it will return. I have downstream
patches for a software backplane AN/LT state machine in phylink_pcs,
which is allocated in pcs_enable() and freed in pcs_disable().

