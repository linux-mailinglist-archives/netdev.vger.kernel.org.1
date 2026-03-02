Return-Path: <netdev+bounces-262695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1i3GIsGtpWleEQAAu9opvQ
	(envelope-from <netdev+bounces-262695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:33:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0F1DBE65
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FA0E3027594
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147040FDA5;
	Mon,  2 Mar 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5A4V46mp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057040F8D8;
	Mon,  2 Mar 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464998; cv=none; b=K7PDruDOsBcFjSRUcaPN59arHlmTwfn+k2KxqxgsyP6GveTR1Eflyx2p8uFrla/SFJ/q9QmjtNS6fZYBR9nKh3lx0vrpV/ut7UsE9s8CX5rf+cEx/+IhDOmWfl1wp0MUuSbzetqOga5qrnitu91FjRFveXT9FivKoPfK0EubqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464998; c=relaxed/simple;
	bh=EVYwK15dduGoyeZ0r5hvbbMoJyoIUeqNEStYXt32qlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MujfXyx9TxKCDi8UYTn9P230o8lx+jPjX2Q8CA2bYHxuYMJAKPCBklmrrSRbiMMaru3a04yk/Z0fwRZy9GyINK8G5UVUp0S2JuDwqTaYUu2V5SeBqYpSGU+Bj7Fgm8ycKXyTidyO1P4iVHx3SuwBXYtekYoc5xMHBcwGRZdJhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5A4V46mp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z/L1RsM3ifNpNZNp4Aw/HlURvPThVG1lk4TYHvWSF78=; b=5A4V46mpge7k4Q/0orHLQoyri9
	blKLRtS4agjMpmaalW+TWwrHoBTOWJaHLult03tudMjFWdWQvfAXS9V+unyuhg2E9GuebFc83lqOO
	54Hx+w4Qa6jy1jvIsmGXdvzKYUlha0ocSzDAtAimxVhLfpHB8lE6nVHnDaNVd1LBqD68=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx56e-009h7F-Ej; Mon, 02 Mar 2026 16:22:48 +0100
Date: Mon, 2 Mar 2026 16:22:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Handle PHY reset during initial PHY
 ID read
Message-ID: <9c29300b-a8f9-4b92-bb38-c75a6b56e793@lunn.ch>
References: <20260302144458.3180702-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302144458.3180702-1-wens@kernel.org>
X-Rspamd-Queue-Id: 6DE0F1DBE65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-262695-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:44:57PM +0800, Chen-Yu Tsai wrote:
> The mdio device core handles reset GPIOs and controls for PHYs and
> MDIOs after the MDIO or PHY device is created. However this does not
> cover the initial PHY ID read _before_ the PHY device is created, since
> the PHY ID is needed for the PHY device. This causes PHY devices that
> have reset GPIOs or controls to not work after a reboot if the GPIO
> is left in the reset state; neither will it work if the reset GPIO is
> by default (for example, missing a pull-up) in the reset state.
> 
> One possible workaround is to place the reset GPIO or control property
> under the MDIO bus instead of under the PHY. However the common PHY
> device tree bindings already allow a reset for the PHY, so we should
> make some effort to support this.

Please either:

1) Add the ID to the DT

2) Work on driver/base, and add generic power on sequencing code which
can handle reset GPIOs, reset controllers, regulators, clocks etc. A
solution which works for PCIe, USB, SATA, and other enumerable
devices.  And then modify phylib to use this generic code.

    Andrew

---
pw-bot: cr

