Return-Path: <netdev+bounces-302358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2H9vBfpAQGq4eAkAu9opvQ
	(envelope-from <netdev+bounces-302358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:30:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 959866D2B67
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mYkqtHXG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302358-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 076743008C28
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82871244687;
	Sat, 27 Jun 2026 21:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83081ACD;
	Sat, 27 Jun 2026 21:30:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595831; cv=none; b=AYIIELYmVNmaXKnZCame/n438G2f+wrrE1/4hNKX3/Vl9FzHOrGeNBvkkIgz95jkfctorsI85O++5gMfYOykVjbsjclMd9tHgi0i90apvcG9ESNqs3utkC1yqXzeWNVITtro3dVZAr6lnbUdSbmzWdIhVN6edVPnGdrt4T3u91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595831; c=relaxed/simple;
	bh=krTNiPDsPuRh5LLdM0DdlxpaPCAeoJuT2fD7ycNc3Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4dEQAwUfrBIO3GT9+DvcwGgP5E1OUPURSXg2IbBDavbkNNqeftGMHJ9S9OIl5deBRccE7MccKF03PQZbAsBYwKqK1zp0cA82dTvrLnyeww25eZfRBUErXUeWyb6mQiUtauzakkayH8G+qK0Yo4ArRjXZHpZgwAXNw+/3kBL/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYkqtHXG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6A71F000E9;
	Sat, 27 Jun 2026 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595830;
	bh=7zmeTFPg9RCjxyqzDSGo/9G7XtLWMfidKxIsvz34kIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mYkqtHXGPooym5zZZo1nDJxpwIiv9Z1134InZEewnnzNXqRueS5ORaiC33uxAgOXR
	 ZLVw+Y7T4qM+XbFwZZZzYkMPHwhPA7cJ8XEItUYxu53Lj3tuK2f7jmndPSQuiwf6if
	 kud+E6D3YyaSZX0F3Xdd1MUbZB8QwcRvaEljHYp07gK+FYxndcMEySF4vtLD6zTFBC
	 EVjqNd+Zx92lKFSVknwZY3YdoEEXOqfzPAzyX96kLGqjuw63BItAIrefx8P6+p5noL
	 9srYxAWxYBy3rK44NzQ/0MNuZrBdyQ8bL896W5uvFLjLIqVK+vc7Il5rsVya7HGITL
	 AGXrn/QWEyGXg==
Date: Sat, 27 Jun 2026 14:30:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <20260627143028.5afed23a@kernel.org>
In-Reply-To: <12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
	<20260526172447.10ca4b9e@kernel.org>
	<5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
	<38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
	<58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
	<65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
	<5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
	<20260626173352.7dc8f106@kernel.org>
	<12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302358-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 959866D2B67

On Sat, 27 Jun 2026 07:34:31 +0200 Maxime Chevallier wrote:
> > This is very far from what existing python tests do in netdev.  
> 
> We can probably drop the class, as it is with this discussion, it's merely a way
> to regroup doc common to similar tests. The rest really is the usual set of
> ksft funcs you can feed to the run function, with a set of ksft_ethtool_*
> annotators for generic checks.

The common way of checking prereqs in the tests is to call a function
called require_xyz() which then raises a skip. At a quick glance - the
rss_api and xdp_metadata are good tests to get a sense of the usual format.

