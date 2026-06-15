Return-Path: <netdev+bounces-299542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G3T1Eo4uMGpdPgUAu9opvQ
	(envelope-from <netdev+bounces-299542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 899BB688955
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:55:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jw4v1n3g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299542-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD6AD301474C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324142B74A;
	Mon, 15 Jun 2026 16:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80A42980B;
	Mon, 15 Jun 2026 16:51:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542274; cv=none; b=hHqB/4HPHhYG8QntLdL6Ivy1Tp7B0Yob6fYlRmASRE8H7LLKofh2ojsH5vlSwb+bSFqzY5L2tnsFWIJDsW4buLFR/ycm5ownvGTNC4cyXfmrrmfy3IqazMOxED7ZvbQQrAyrXLm6SmIqrtv6lj+ifx74fMPKXQVQ6BFf+hhSob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542274; c=relaxed/simple;
	bh=4Hldff5Shw/RhPnWMRDH6F6iSV94zbTwaJQK5z7eUnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ4MmLCSi8UVwWQdjTscUn3TU0rZIA258owdh1khblZizfZAHF9AAGiwzcEdkM2zWIR/qUGbgNZA7Z1pyMfPHO+AXMfNonHdguSLgs8TvAuUftSUcPMBiJx20nBua9WV6c6LU6WruwuPY3vjZ2TE4MNocaSjYMN0uuQcTNTChbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw4v1n3g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E91F00A3A;
	Mon, 15 Jun 2026 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542273;
	bh=4Hldff5Shw/RhPnWMRDH6F6iSV94zbTwaJQK5z7eUnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jw4v1n3gwACU3EF95g0jgItIYkmUY8lK7fJt0Gz7t4zJ8YrFsmrvtAsQLztFNfb6I
	 F7IhAvsWICQocODvaV4RXXlj+/dFZswaLy52deambgQDYDdON5qK/mzSEaN+ew74O6
	 0YGvNDXlXhM1aCW9J3V8ZmtLBUXo5cZ0eQixSN9sa32iakwax2x+Aq+58O+Eo+ayq8
	 rANAN7WIOWIzIjnIiiEHwSWpx8870P5AeIY2rPFuDuZektekp5Ps6odKPc2kcOVvnQ
	 L8WQwV+r5udLKa7E7e0kybJH2aFSS36NHeZ4RKcDztfXaQJyhzCtfmJxqLN8ZGQ2ys
	 LPNhN7edIqmZQ==
Date: Mon, 15 Jun 2026 09:51:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <20260615095112.1dca0977@kernel.org>
In-Reply-To: <9E7B1B5A-ACE1-4488-A600-96FAD88D070E@padl.com>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
	<20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
	<20260612153656.4c5b8c62@kernel.org>
	<9E7B1B5A-ACE1-4488-A600-96FAD88D070E@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299542-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:devnull+cedric.jehasse.luminex.be@kernel.org,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kabel@kernel.org,m:cedric.jehasse@gmail.com,m:devnull@kernel.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cedric.jehasse.luminex.be];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 899BB688955

On Sat, 13 Jun 2026 13:37:08 +1000 Luke Howard wrote:
> On egress, one can use the switch chips=E2=80=99 AVB support, but this li=
mits
> the number of TCs to three (corresponding to SR class A, B, and
> =E2=80=98legacy=E2=80=99 traffic). I have a submitted MQPRIO offload patc=
h that does
> this. This matches how MQPRIO and CBS are used on end station NICs,
> but is not flexible enough to support an arbitrary number of TCs.
> Because of this, offloading PRIO may be cleaner.

Yes, it's been a while since I worked on qdisc offload, but the NIC /
host-centric offloads operate quite differently than the switch-centric
ones. Offloading MQPRIO to a switch is likely to lead to technical debt.

