Return-Path: <netdev+bounces-285799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNoDB3XX/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328414F6638
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7018E3037164
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4C30F95F;
	Fri,  8 May 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jLgL8V3U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25109140E5F;
	Fri,  8 May 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243183; cv=none; b=p8JHTUuL8YfFoc8M0tt3cPJ4/OPkIa+5IN26QKECbmKkrK2SBJJqzU29+ukheI6aGRrM58mepspwaz84O0RYu2MFgkWbLWDZG/MU9t7aUbKMHLwMRxKuapwWmynYp6Qsgannn4oVJBfuAeZKTnzaRkv1NXg6QasDj7srSlRQovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243183; c=relaxed/simple;
	bh=NLsH/K7VXedzOuGGqbtSWxnkuFBGclsNhZ5CMAY3NHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkQtKvmQOq8Ee0ffPpgRElofwoWJd9wC98ctLctEjbKX1TDAN0SnOOfI5V379pcGqg3P2KYclhrVN4gFeM1SZ0oWAbZcEGMEE4UITEWWOQMFkhpDmG7dtE29x5Iy6jqt6ASu9IYbLpcU1BU8Uam+G0tkeoc+uoCC8DCaOhLywu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jLgL8V3U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jD++zbm7TRn7z9Gkmzdiydf261KgGUA5U+K5FfJeBoo=; b=jLgL8V3UndE/w2kjJUn6i6q94l
	F73Njt0/LztH/sr56sNrLKGbBNgXWO7eUZxv7yR7eSl8UXM6nTAz5gS9CAICg9nvQXIAHQTHVq4uF
	XujQotNRJVZZeY/ZeLoZ7TOZUYKj58RrwlwF6gNyk/pn3VJHaNMJ8N0A47Y/OgLVlvIA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLKHS-001xtk-Lp; Fri, 08 May 2026 14:26:10 +0200
Date: Fri, 8 May 2026 14:26:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH] net: phy: DP83TC811: add reading of abilities
Message-ID: <b679c30d-5cc3-477e-9ba5-6d40fc5cf364@lunn.ch>
References: <20260508074931.8226-1-schuchmann@schleissheimer.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508074931.8226-1-schuchmann@schleissheimer.de>
X-Rspamd-Queue-Id: 328414F6638
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-285799-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,schleissheimer.de:email,ti.com:email,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 09:37:43AM +0200, Sven Schuchmann wrote:
> At this time the driver is not listing any speeds
> it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT
> for DP83TC811. Add the missing call for phylib to read the abilities.
> 
> Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

Hi Sven

A good first attempt. Two things which should be improved.

netdev uses two trees. "net-next" for ongoing development work, and
"net" for fixes which will be backported in stable. This is a fix, so
should be on the "net" tree, and the Subject: line should indicate
"net":

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#git-trees-and-patch-flow

Since this is a Fix, it needs a Fixes: tag, indicating where the issue
was introduced.

The history is interesting. When it was first introduced in

commit b753a9faaf9aef1338c28ebd9ace6d749428788b
Author: Dan Murphy <dmurphy@ti.com>
Date:   Fri May 11 13:08:19 2018 -0500

it had:

+static struct phy_driver dp83811_driver[] = {
+       {
+               .phy_id = DP83TC811_PHY_ID,
+               .phy_id_mask = 0xfffffff0,
+               .name = "TI DP83TC811",
+               .features = PHY_BASIC_FEATURES,

The commit message does not mention it is a T1 PHY. PHY_BASIC_FEATURES
means it is a standard 10/100 BASE-T PHY, not a T1 PHY.

Then in

commit dcdecdcfe1fc39ded8590aed2fe84d62f14b2392
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Fri Apr 12 20:47:03 2019 +0200

    net: phy: switch drivers to use dynamic feature detection

That line got commented out, when we starting using the registers of
the PHY to enumerate its capabilities. So at that point, it want from
being a 10/100 BASE-T to not listing any link modes.

I would say it was wrong from the beginning, so use of Fixes: tag of.

Fixes: b753a9faaf9a ("net: phy: DP83TC811: Introduce support for the DP83TC811 phy")

Anybody trying to backport the fix that far will fail, because
genphy_c45_pma_read_ext_abilities() did not exist back then. But it
should work for modern LTS kernels.

    Andrew

---
pw-bot: cr

