Return-Path: <netdev+bounces-265856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE+NKnV9r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:09:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6D2440DC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83599300DF50
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DDF311950;
	Tue, 10 Mar 2026 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijJNQ69u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507724679F;
	Tue, 10 Mar 2026 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108595; cv=none; b=Fv6t5FDjR9+HXp/9Qmm90KnzPdyYWeoRxaA8PL8fOUs9ynnM3F27VdB4QmNRdfggQH0TDpuimxhLEtSxLSO8WuGWUF9FoId016UCv39FBFdiI0EBUUWg5rBSyysm27fwNvffFee21NThZZ2sxTU9YwcxiukSRaQLyYQdNF2vk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108595; c=relaxed/simple;
	bh=QoQhFxePdxZV0mbq93f7befZaXb8GMtKyfIz6w9tfAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJQ8JEJ9euIvrcd3WdPhW7sk7zX4BG9G4UMenXztlRkKMVRo8440mSX4kwFJWQPMza33GPWsp79VI3hg6bet9ECHxt4aQJFI4MqMFPm9imrlEunEqbBZ+3YX/kkgTAJwPuMAptiNEzgWWQ/2DL81CvbX/5Pt01sABWhRZoMjjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijJNQ69u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C252FC19423;
	Tue, 10 Mar 2026 02:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108594;
	bh=QoQhFxePdxZV0mbq93f7befZaXb8GMtKyfIz6w9tfAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ijJNQ69uHj55G5ZomNV0G97fSfkTVBcaYBHp/tsbheFd4qMHDRi0JuPw6ivjIM+WI
	 btyahAs+NpQUkCTh3Wpvg1UWKCT7RhJPagIviLj/l5kOT5s9V/m2VOqAJhPYmSyK4B
	 lVOKgnhMxW5J2epjnegKC9lYRyW2z41Zn1envDufWBl5WxB1C83SXeowsktKxP5lkY
	 tXSHZ+fC9uzv9ozNkO+nNpSNbZXmdwt12886aVTtFYUpVRdvf/HidfEYXRp/S+bV7O
	 yMo374d4OoM0fc4R3+yA9F6Bk96e+NFmj1Q7guS7AnM1SQyBlx956hl8xfamz2uH4R
	 DDg51Ows1JdYg==
Date: Mon, 9 Mar 2026 19:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>, Donald
 Hunter <donald.hunter@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
 Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v12 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20260309190953.7c0831b7@kernel.org>
In-Reply-To: <20260304094811.2779953-1-o.rempel@pengutronix.de>
References: <20260304094811.2779953-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 47D6D2440DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265856-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bootlin.com,denx.de,lwn.net,linux.dev,resnulli.us,nxp.com,iogearbox.net,vger.kernel.org,microchip.com,queasysnail.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed,  4 Mar 2026 10:48:11 +0100 Oleksij Rempel wrote:
> Introduce a new document, flow_control.rst, to provide a comprehensive
> guide on Ethernet Flow Control in Linux. The guide explains how flow
> control works, how autonegotiation resolves pause capabilities, and how
> to configure it using ethtool and Netlink.
> 
> In parallel, document the pause and pause-stat attributes in the
> ethtool.yaml netlink spec. This enables the ynl tool to generate
> kernel-doc comments for the corresponding enums in the UAPI header,
> making the C interface self-documenting.
> 
> Finally, replace the legacy flow control section in phy.rst with a
> reference to the new document and add pointers in the relevant C source
> files.

Russell, Andrew, does this doc look good to you?

