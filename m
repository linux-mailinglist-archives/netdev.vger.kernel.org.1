Return-Path: <netdev+bounces-299104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OyCWNfzuLWr7mwQAu9opvQ
	(envelope-from <netdev+bounces-299104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:59:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD89680139
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nCER2mMQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299104-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F6D301AD0B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639B390CBA;
	Sat, 13 Jun 2026 23:59:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274D3242BA;
	Sat, 13 Jun 2026 23:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395194; cv=none; b=OiRgN1Q5kNss2jH2GxuavAnSxOkkaYPLZ9bkwzIqaAaxFAbfesd9NNcovRMOxyp1kop7savdnGZNGfgW6GJ9qtdY9TVdPv4n7rPPiHEzG13PlKCXnHbSTP788uSiLUoqlj0nDPtlmO/dktT8wsUU4IUjaMDDeaBV2uUIdfu7u/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395194; c=relaxed/simple;
	bh=AKPoNBVM5QLmdnhBqVQCCGBrkAVluDSMT793EJc23jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzoW2hq4dlyqrDc23/yPTk8iJyqkkwmajLbV88qbokc8+9LF4f4oprnEMMvaP+/PG8fuU51FeuQbo0zAjpvMdvrdY3uJdFvIxfv1/TQ8AYA00N8Tvc0/m7FRRUpwrnmgUJL4x0clxIqD2YLaYyV/E08VzQNqlEMXnbw1YCt3qzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCER2mMQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ED61F000E9;
	Sat, 13 Jun 2026 23:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395193;
	bh=hoaO3paOlThs+FEBajI10NwH3K6hgSI4nk0u5G3a5ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nCER2mMQw27f/mDzxmAuNXxbqC0/+22LHSQOjjsez7WWdBOsyifiHlFIQ7Xc9zWpT
	 Xpk1VAxM/nVel1ll4KNcaHVZFGZqQYuy18IBqCYUH+8nzIpa4w0ysrW1lUfQjqgZfs
	 dR6DuaddUW5+hRAqSfu+J7i4pRr02/jRyPrjBmWUhuSOXrwPSWqmzL1Ze8Zbu2k2En
	 PQnyPV9d8bA9z/HAULixu43dhH68oWszgQFSEffdRiL/FaX8Fn+lpvr4el/sIDmgwu
	 BVzpoLZj+AL/X14qCwPUWWTQqEnane44jlNl9WKkR8iUNonX2iMHGBrpC6ZWBjVKQo
	 KkwMFMay5ZHsQ==
Date: Sat, 13 Jun 2026 16:59:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <daniel@makrotopia.org>,
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v5 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
Message-ID: <20260613165951.115d06b8@kernel.org>
In-Reply-To: <20260611031839.568-3-javen_xu@realsil.com.cn>
References: <20260611031839.568-1-javen_xu@realsil.com.cn>
	<20260611031839.568-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299104-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,realsil.com.cn,tipi-net.de,vger.kernel.org,makrotopia.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AD89680139

On Thu, 11 Jun 2026 11:18:37 +0800 javen wrote:
> + * Returns negative errno code on failure, 0 if Master/Slave didn't change,
> + * or 1 if Master/Slave modes changed.

Returns:

the colon is needed otherwise:

Warning: drivers/net/phy/phy-c45.c:420 No description found for return value of 'genphy_c45_an_setup_master_slave'

There's also an AI review at 
https://sashiko.dev/#/patchset/20260611031839.568-3-javen_xu@realsil.com.cn
-- 
pw-bot: cr

