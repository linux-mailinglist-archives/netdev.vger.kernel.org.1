Return-Path: <netdev+bounces-273173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EAWDF12ymnZ9AUAu9opvQ
	(envelope-from <netdev+bounces-273173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857B35BAF3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 120DE3019F13
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6423D3331;
	Mon, 30 Mar 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fBrIrBct"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB23CFF6E;
	Mon, 30 Mar 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875789; cv=none; b=MP9lzwztRpz+C/W82wTkpGBc1Yges3npI97quFiMNJbPtOXxkz2XTZlW6U4zUf4jqJcxuVG5zGMu62hLxs34r+4qmT1sZYLA3hlKwiK2JdR5IyoXF2/E0V//jA6qeZDviigrW5t/7VMPL688j6hcGQrRqeFCvrLJPElkuVH6Ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875789; c=relaxed/simple;
	bh=fZFv1sL22s1KLoFQRd7hx3UzLd4aDAomV5puiFgoK6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtQHqhVH0NodAOHWKXwFeRVPypOhBEuCMt4roxXPALoTk0TxRgDXW7jDb997LNjIdYgYfRldTy5k3RgMFQOwyMPvrOhypoCnUbRwtMuY8Se4GUtxLCba809+n99CDxM+g5GKXkWZnYaYL1ZUBW/3QIrXVuuxEzp+xb+BHVDPe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fBrIrBct; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V4U0/TuhcWrZ0MeULa8tBifO46s5JTqhmO1GQ8H5Gk0=; b=fBrIrBcthFrPIk7gAMmpTtsLys
	9sjwRRMO2ia5a+V7hkxgAGvSzSC8zqZ7iYu9U6mMBVJewN+43RIwS0Bwi34IKTZ90opVgvtT6l3vT
	Xk8cqeP1kkfQt29Xt2Hdbi1jN6Qsk5gkVqpiwlhZb30r8Uy6rKfrjBjGUWbWDtrfF8eI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7CGg-00E2CB-Hx; Mon, 30 Mar 2026 15:02:58 +0200
Date: Mon, 30 Mar 2026 15:02:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: microchip: add downshift tunable support
 for LAN88xx
Message-ID: <30e7b68e-b7fb-44d6-83bf-e6acd09e7fd8@lunn.ch>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260329224202.500229-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329224202.500229-2-nb@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,raspberrypi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-273173-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 8857B35BAF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int lan88xx_set_downshift(struct phy_device *phydev, u8 cnt)
> +{
> +	u32 mask = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK |
> +		   LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT;
> +	u32 val;
> +
> +	if (cnt == DOWNSHIFT_DEV_DISABLE)
> +		return phy_modify_paged(phydev, 1, LAN78XX_PHY_CTRL3,
> +					LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT, 0);
> +
> +	if (cnt == DOWNSHIFT_DEV_DEFAULT_COUNT)
> +		cnt = 2;
> +
> +	switch (cnt) {
> +	case 2:
> +		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2;
> +		break;
> +	case 3:
> +		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3;
> +		break;
> +	case 4:
> +		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4;
> +		break;
> +	case 5:
> +		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5;
> +		break;
> +	default:
> +		return -EINVAL;

And this could be a range check followed by a FIELD_PREP(cnt - 2);

	Andrew

