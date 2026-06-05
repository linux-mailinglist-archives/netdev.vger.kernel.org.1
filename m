Return-Path: <netdev+bounces-295601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZbMQMig5ImoDUAEAu9opvQ
	(envelope-from <netdev+bounces-295601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CB644BEC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:49:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=epV4iXjc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295601-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295601-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F2B301D06D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC653074B1;
	Fri,  5 Jun 2026 02:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F51F63D9
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627598; cv=none; b=ONXPXVxzzS035pNKNzBh4sMSv7S4FrmCBeSczLLJzea/wznTqIBZyrl4JU3KL1+yl/E8eVkGYnkE/wEB0CZho9fE0jXx21YapjPJn1uk01OPBM9hhbbIzTg92F5FpTMOzgX8zEGB3z/SOQ0iKZz3k6lE3XwhBsAw1GDmthjv4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627598; c=relaxed/simple;
	bh=YIVhdtanfoG7q1HePw2+YiABT2b17z337g/4wnGX8ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR5OhBTx87kd/2pWWXg9gF1lzdOhWdp9c3vkCXtpejljXyddQHrbf0KbXCFqiNh8F2RC5HaAD3TmqilBVLGFWQhatrnBI+xJ9DdF3gR717t9F+tyX4iP3Ud3PfVkIE4iBbnl1Ga/BBtJEf/N98rMXulAYD8707kNK1Vcbc4UoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epV4iXjc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F691F00893;
	Fri,  5 Jun 2026 02:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627590;
	bh=YIVhdtanfoG7q1HePw2+YiABT2b17z337g/4wnGX8ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=epV4iXjczXGYHrE9DNUki4BJ/7TV8yV5EBtfP3kQNuhzzqpXEMe9ZoY/3k1kAvWxh
	 ZRirA3w2SNMuFZBZDq3LHSXWh0lnKHRNFOWquBMdhc7Rjkxa42H+THAbobnIIfX5Lq
	 RPsQyCMLVAm8isW6iVjCtL+z+ORsPuc2tYY+wipyQgOKeiB7TdKOg7vXPtMdtFEKgq
	 xdVN4/+i+5myEoN+rfDhyfQihSpWwHQdHfflxnaJwiJWL/8Zir6OJl4AZGwLd0ZSb2
	 6IkUJd/9dEKAxTD56+Vzt8DPHZ7CPBw0ZIIafmUiRZB3+voekIEe1wxUhDKtuSIIxJ
	 mL/lIH/9dUHZQ==
Date: Thu, 4 Jun 2026 19:46:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net] ethtool: Set histogram ranges to NULL before
 querying FEC data
Message-ID: <20260604194629.45a3ef03@kernel.org>
In-Reply-To: <20260604225440.11083-1-eric.joyner@amd.com>
References: <20260604225440.11083-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 115CB644BEC

On Thu, 4 Jun 2026 15:54:40 -0700 Eric Joyner wrote:
> If this field isn't set to NULL, then drivers that set the non-histogram
> FEC statistics and don't support/modify the histogram fields will
> trigger a WARN_ON() in fec_put_hist(). Drivers shouldn't be forced to
> set this field to NULL if they don't have a need to touch FEC histogram
> reporting, so set this field before the driver gets the data structure.

&data should be zero-initialized, how is this patch not a nop?

Are you sure this can trigger unless the driver is buggy and sets
ranges without reporting any values?


