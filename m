Return-Path: <netdev+bounces-269198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHenM8Agu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A82C3388
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DDFE31423EA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE703590AE;
	Wed, 18 Mar 2026 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHnpj2eW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D23033FF;
	Wed, 18 Mar 2026 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871222; cv=none; b=i4kJP0SXbqfCdQVFcmRJQ05PR1Ae95fp6wQljA7Js71syWlDFcODaMaAthkH87nSFWd/pf7loA0i6fEFmN9Gebijloyk6SKaDm29qu7P4CZAqPgC6zlbyJiHl/8omzDWxW9Uu6st1ftDkI87aPB2HvXmFxtioRuxF8tNim24+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871222; c=relaxed/simple;
	bh=Sb+rfmq4oFooLFg9kKHjL78GHpDPnVw8b80Lzn4xQGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBAWEsR/Wnr8fFhUfjyVzkezONGqZ/KwaPHca6RXRZUVI2z0b2YjdQ0pjZEp0/AyucP97ZVqofhu5J4LxybT51BP23vPVaPGjWsPFii7W+Ui9jBYo5cjyKN6RZWFIWD3jiMFwJ55zW/5NfJ7X6ThbbHsW3p3kfCi8HAD9IDbz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHnpj2eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54853C19421;
	Wed, 18 Mar 2026 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773871222;
	bh=Sb+rfmq4oFooLFg9kKHjL78GHpDPnVw8b80Lzn4xQGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iHnpj2eWMp5kyOvia+xhS7YPjRgvHhojFBbtVLEkiSFrREHzf1ThsnY+mul/DCbEm
	 bCZtk8UomhfqnN7WpA6d5SlWaCMbxeDj/49cWIROdK41gGXd6SV3BXpLOmciDabQYt
	 utwP9f4nNFFylZCD5ZZ4+TTyfQtGQAIOUrI8l4orZLs02BYkBvUSBCX8QynVQQisBM
	 3UW9liAnAELr9BRaoT/O8UdI7Lfr3xCNgaBJZ+AxuFpEbliUvWzDomFOIIMXL+AaLU
	 IS83YVI23/HqiW/izjI2JLbXWw8FBgUtXsVq0UBM+D5eXhD/DY+m5S5C5g9CY7rJ08
	 Fdu3spiGfw7MA==
Date: Wed, 18 Mar 2026 15:00:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau
 <dimitri.fedrau@liebherr.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Subject: Re: [PATCH net-next v7 10/10] net: ethtool: Introduce ethtool
 command to list ports
Message-ID: <20260318150020.621cf1f1@kernel.org>
In-Reply-To: <839f1eb9-cdc5-49bf-8ce0-1be9f5ca1c33@bootlin.com>
References: <20260309152747.702373-1-maxime.chevallier@bootlin.com>
	<20260309152747.702373-11-maxime.chevallier@bootlin.com>
	<20260312190705.0b3a3f78@kernel.org>
	<839f1eb9-cdc5-49bf-8ce0-1be9f5ca1c33@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.900];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 712A82C3388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 08:28:00 +0100 Maxime Chevallier wrote:
> >> +#include "common.h"
> >> +#include "bitset.h"
> >> +#include "netlink.h"  
> > 
> > alpha sort  
> 
> So that's not as easy as it looks, "bitset.h" is really barebones and
> needs definitions for stuff like ETH_GSTRING_LEN, but also all the
> u32/bool types, etc.
> 
> In all files in net/ethtool/*.c the local includes list isnt' properly
> sorted due to that.

That's not right, let's fix it. Headers should be self-sufficient.

