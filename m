Return-Path: <netdev+bounces-282553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IE4Fvuf8mlutAEAu9opvQ
	(envelope-from <netdev+bounces-282553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC8A49BA16
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B89C3013A60
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175E1482E8;
	Thu, 30 Apr 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KBLaFtqs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965A29CE1;
	Thu, 30 Apr 2026 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508342; cv=none; b=IJbEkcX71hfz7Xlp2IAtfsA5g02vURUVMyF5zf0t6iiQBeHVUrX6CoJbIUU4GyG9SBmoBVlZqDRLDljcWYPdrN0C77Kz2eC8opxk1wZxD3FoL3B2UzUUkp7wsIRB37MGNk96TPxTL4tPl7FjZX1GYA0IWswh50xbAngRe1JZahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508342; c=relaxed/simple;
	bh=hJNz/8PRHKHkiAftvNMkkZEnvBERhqC9AWqUQ3QCs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjRSiskzoXiHy4/sRq1JsyAr0QrbQMfvLwddoY9kHGPd6UP4blKhuJ5ecQISzSREcApd3VfVq1OjJI7enHEACh3TsjFZ/tbpUv1Y8o2izSVIxgc6JMTS2Sciw21k36QgAmQsqqjrlnsHl7RWu50KBBDUaH7ln+/p0hT9Dm1LBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KBLaFtqs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NuM3kpmeo2F6HKXd8wBcwkLWijAbJptVoNwo165S570=; b=KBLaFtqsUaq15T7ZKF8mMKT4e2
	aba9bK2a1AAKyxgi4scTYhlyyLE5R2ZMFH42io+JKgvfk5/58XAXZ3z/YOgvaMiQcwlzpq+oRqPdz
	KXd4E+LVYzaT7kvIxM1FVNu5Ok9/be/hmQ4DYj1nmpxxSmjjQkoFmX9i7Wh94uHQytzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIF77-000bGb-RC; Thu, 30 Apr 2026 02:18:45 +0200
Date: Thu, 30 Apr 2026 02:18:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Damien Dejean <dam.dejean@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: realtek: support MDI swapping for
 RTL8226-CG
Message-ID: <fe792ddb-a5b2-49f4-a888-5b38dc068209@lunn.ch>
References: <20260429211235.2607782-1-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429211235.2607782-1-jan@3e8.eu>
X-Rspamd-Queue-Id: BFC8A49BA16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282553-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,gmx.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> +	if (!swap_enable) {
> +		/* Patching is only implemented one-way, see next comment. */
> +		phydev_warn(phydev, "MDI swapping disabled, but PHY is already patched.\n");
> +		return -EINVAL;
> +	}

This appears to cause the probe to fail? If so, it should really be
phydev_err().

Otherwise this looks O.K.

    Andrew

---
pw-bot: cr

