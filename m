Return-Path: <netdev+bounces-269477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE58LBoPvGkirwIAu9opvQ
	(envelope-from <netdev+bounces-269477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:58:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61482CD4C3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7594301EA29
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D83D6CC7;
	Thu, 19 Mar 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlB2m3NC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EA3CE4B6;
	Thu, 19 Mar 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932026; cv=none; b=sveQEa7UkEYdA1F1YytkvAYlOhbSnbS0T4Ruji0DzpiFpoWFWkGv8z15NAUETCaWkgwHZoh0OxlJFzcVQ5HeX3DdHXBD9/Xm3rvpAzIKyjOUotErIqCn4m0IGl3ZF6/BQnCwsTCRLmnQWAekaOYLSfTlBPsm8Vn/2MR/hIFNp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932026; c=relaxed/simple;
	bh=rGBzuTdV67vpKY5ZL0KiZjtu15TYhwh3ofg/+ry07r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I384Jy50K8aNUkxbX3Wu3P+YZkFaxi3GBT5fVn858hS1hvQtNkuQmoRDGjHGapni3EI3sIypSFuxuY3KoHzuHrYNENJ7HprS2VIGjxDla7VZ7sn7729jzsiEMH/625nY4VnqcpM7PuMCzZWpVBZhy2LXnIdXaBIx9gmiPYLpnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlB2m3NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0318C19424;
	Thu, 19 Mar 2026 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932025;
	bh=rGBzuTdV67vpKY5ZL0KiZjtu15TYhwh3ofg/+ry07r4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlB2m3NCdVPh1g5yWDF9i5h1ZSib6iQ9EZ6taTsPfEygLzIhKAdbZR0z/uqh2JZbn
	 1ca0skbd4EtPSspf1ovEbMwBsvdxhHYVp4lpLNmYN2nxatRTT8uuABjLbwsOQFYB5i
	 TR5kahdN1xirGg8WtclXulBY9Ot4ScAQAlEMgAYIfe7ARQA2e4IhrjXYgbQ5DgPrH3
	 fSa6QlhYuQoFz6ZAY2EyDKf6qNSWX6hQQOBxNlM7sbxCo4S6qRlZ7Z7Y0W9P+ojUU9
	 q025yGx/l4KwxWVT7ZHNM24nlHpfsiasef0kph/eLKEg2Llm/Kcng+TAvHvo0Spmvs
	 3/JUak+Ye7QRQ==
Date: Thu, 19 Mar 2026 07:53:43 -0700
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
Message-ID: <20260319075343.0aa9fac8@kernel.org>
In-Reply-To: <97bd2ab1-a8ff-4c0b-a328-952139f18fc8@bootlin.com>
References: <20260309152747.702373-1-maxime.chevallier@bootlin.com>
	<20260309152747.702373-11-maxime.chevallier@bootlin.com>
	<20260312190705.0b3a3f78@kernel.org>
	<97bd2ab1-a8ff-4c0b-a328-952139f18fc8@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B61482CD4C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 10:27:11 +0100 Maxime Chevallier wrote:
> > GENL_REQ_ATTR_CHECK ?
> > I guess you'll have to move it to prepare cause we don't get info 
> > here :(  
> 
> Sorry for my comments coming apart on your review, I'm getting this new
> iteration done in-between other tasks  :(
> 
> I can't move that check to the prepare_data() step, as we need the
> request->port_id field to be populated at that stage for the DUMP
> op (for each port, we set request->port_id, then we call prepare_data
> and so on).

Not sure I get what you're saying - that it doesn't work or that it
leads to "duplicated" work? Alternative is to add info to parse_request
args which I suspect is useful long term anyway.

