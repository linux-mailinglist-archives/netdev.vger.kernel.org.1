Return-Path: <netdev+bounces-298548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id impJDDHPK2rRFQQAu9opvQ
	(envelope-from <netdev+bounces-298548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58367830F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:19:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ClOk1Op3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298548-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298548-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CDF7311FEC6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6738228C;
	Fri, 12 Jun 2026 09:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE093812F2
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:18:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255911; cv=none; b=VSQ5y7SyHlcK1nONLceOIUoBfgCl7ifj5yZez4omXC92vRJiDaU6hou/cG3Vgs9qMXf2azHA+/FhgkS1yys1QTwc1VvU10dtaA+DCcjqMRtTzpkW/mbZTDPIO3sVlzyFD+qDQFzEjpOJ66pRjWpleZtVm+s2InpsJrsXp603oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255911; c=relaxed/simple;
	bh=Zd3AZIDL7if/qF12oMBTJz11JgR87TNdx4PQbs5fhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U15geTcfmzpLzkMvCnpJFO8YY8o5L6hAoh47HCM9EECUUGpkq1y1nFR2IdTtbvKcZsw5/IJ730sEkaS6AK4ZdPTQ8fetPyNnVZq8ISDNyRTqq4JWHxe3IaqBEFaL/YL7e/u+JQmwiVbq97JcmN9UQfE4j3+RBkwvWOdcczT67aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClOk1Op3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A1D1F000E9;
	Fri, 12 Jun 2026 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255910;
	bh=Zd3AZIDL7if/qF12oMBTJz11JgR87TNdx4PQbs5fhlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ClOk1Op3tv4OcRm3eXszKt+gFZaQzBqvwgYQwdBcNuIcOBalZfMIunVSQ7zyjOIDz
	 r5dLNZN7A9ccOgufmZokd5rI6mHGLaoPVrg4RtM4aZebMdlaAHIQ1xOme8bZi4FIaw
	 9CgvZJNlxI9uduieRVyFyXZVgK58bY3MLK5mHweXB1tYAtWzCH+c9zoE8+0Ls7Vw28
	 S4a1Kt5dBRZpfXmLr5MFnmB4fDUs33bF1N27OKFTvIFs1OL6xJwcexeHs776lc7/+L
	 gCO6cVsnMWAwex6qquOh6HPfhO3fugU//ld+wweCW4BVZF4w7K+FmMB4GGlSuOhP3p
	 kMfCaXI7EbDjA==
Date: Fri, 12 Jun 2026 10:18:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v4 0/5] ionic: Expose more port stats to ethtool
Message-ID: <20260612091825.GB625020@horms.kernel.org>
References: <20260610061830.51037-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C58367830F

On Tue, Jun 09, 2026 at 11:18:25PM -0700, Eric Joyner wrote:
> The primary aim of this patchset is to support the reporting of new port
> statistics (and one old one) that firmware sends to the driver; these
> include general FEC codeword stats and the FEC histogram. A scheme for
> these extra stats is introduced in order to prevent devices that don't
> support these new statistics from unconditionally setting them or
> reporting them in ethtool.

...

Hi Eric,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch.

