Return-Path: <netdev+bounces-234379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD98C1FDBD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C8B1A25F5C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5F33F8A2;
	Thu, 30 Oct 2025 11:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76C33F399
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824469; cv=none; b=Kokg4zNlYS+x8VIONy99DVCCupLv8xAFToErE/3QLyufKdWJx/tdUNnzwZv7H7COal1C8eQqKgg2TVv6SPXQRU/ezamxXlelRdeXkoPq6DamY4RQbDN49NuGM5yZgu1Q98x6sDJS7DihLzQg8XBT4PVS3K0hE9wZYtBA3D3HkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824469; c=relaxed/simple;
	bh=lZKo9fp4728vlExsBM5BJnKwNB7fqUa1ufmGk3S8KXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7Mr65bjJA4AoTwFaIHYY9Ta5USgIgEObBwndI8PNRnUVq2CSmff3Mpn7QyNhuLrcLG/pC7SYSI2aMDjlTRzTDYKXK5eB3HAhg1ZEyrF5sWOlSSTJ2Uv5RyEIGJ6+w7gT6rem44s2g0cvlhEZc5gwOpDSeqeAE37fnUgmfczP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vER1M-0004mR-8i; Thu, 30 Oct 2025 12:40:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vER1J-006CfY-2A;
	Thu, 30 Oct 2025 12:40:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vER1J-008sMp-1j;
	Thu, 30 Oct 2025 12:40:45 +0100
Date: Thu, 30 Oct 2025 12:40:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v8 2/4] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aQNOvYzUH8OEbw8d@pengutronix.de>
References: <20251027122801.982364-1-o.rempel@pengutronix.de>
 <20251027122801.982364-3-o.rempel@pengutronix.de>
 <4dc6ca34-d6c5-4eec-87b3-31a6b7fba2f8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dc6ca34-d6c5-4eec-87b3-31a6b7fba2f8@redhat.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Oct 30, 2025 at 12:04:11PM +0100, Paolo Abeni wrote:
> On 10/27/25 1:27 PM, Oleksij Rempel wrote:
> > Introduce the userspace entry point for PHY MSE diagnostics via
> > ethtool netlink. This exposes the core API added previously and
> > returns both capability information and one or more snapshots.
> > 
> > Userspace sends ETHTOOL_MSG_MSE_GET. The reply carries:
> > - ETHTOOL_A_MSE_CAPABILITIES: scale limits and timing information
> > - ETHTOOL_A_MSE_CHANNEL_* nests: one or more snapshots (per-channel
> >   if available, otherwise WORST, otherwise LINK)
> > 
> > Link down returns -ENETDOWN.
> > 
> > Changes:
> >   - YAML: add attribute sets (mse, mse-capabilities, mse-snapshot)
> >     and the mse-get operation
> >   - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
> >     ETHTOOL_MSG_MSE_GET/REPLY
> >   - ethtool core: add net/ethtool/mse.c implementing the request,
> >     register genl op, and hook into ethnl dispatch
> >   - docs: document MSE_GET in ethtool-netlink.rst
> > 
> > The include/uapi/linux/ethtool_netlink_generated.h is generated
> > from Documentation/netlink/specs/ethtool.yaml.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v8:
> > - drop user-space channel selector; kernel always returns available selectors
> 
> Overall LGTM, but it's unclear why you dropped the above. I understand
> one of the goal here is to achieve fast data retrival. I _guess_ most of
> the overhead is possibly due to phy regs access. Explicitly selecting a
> single/limited number of channels could/should reduce the number of
> registers access; it looks like a worthy option. What am I missing?

Yes the goal was fast data retrieval. However, I realized the initial
channel selector was just a guess at the right optimization.

My concern is that the channel selector do not fully achieve the goal.
While reading metrics from just one channel is an advantage, the
optimization could be much better if we also allowed reading only one
metric from that channel, instead of all of them.

So, rather than push another half-guess, I decided it is safer to
remove this part of the interface entirely for now. Once we have data on
where the actual performance bottlenecks are, we can design and add a
filter that solves the right problem.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

