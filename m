Return-Path: <netdev+bounces-300537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p0vzFkdfNGofWQYAu9opvQ
	(envelope-from <netdev+bounces-300537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 23:12:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A261B6A2BD8
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 23:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=MR1Fz1ld;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300537-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73DDF3032F61
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410E3431E7;
	Thu, 18 Jun 2026 21:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8B284662;
	Thu, 18 Jun 2026 21:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817156; cv=none; b=G4GgdNdEzmb+1/Hrm/ccLbCh37b1LKph+Sl4xabrVHbji/y82R8WECJzp1yu6QOUtwWhcKUC+ZLzsCQwFMTQ3muT0JnE4k+JGqnBj4bMihPYB+OBzlHyA2RjTgAqVHzrAchJqUaDMWdNhgdmK79p0sEfGmj3HUxLdvtKywV91Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817156; c=relaxed/simple;
	bh=K3qESzyCheBDLi5ScRh7TdjxExqxcUymoAQ3JTLgyw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8dS2fu8TZqgomNGQFK7XxQetfBFkUQuqvMRGZ+3MxV0l86rkDb0i1pJ5b9qvjzY0XIOpkh2S/TygEpnEJoLQOTrZ7o9dT/keZTuHaw7LAGzNP/ngf3XzKkjKGjPEOiKcW23IHomwtL2QM/iE3c7VEBon0T/utTrXDWbFn9mW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MR1Fz1ld; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K3qESzyCheBDLi5ScRh7TdjxExqxcUymoAQ3JTLgyw8=; b=MR1Fz1ldJ8AX3Wa/b01tCIUea+
	r4CnL0w0Q2FdSp1Lnd3VOZ2Ja/4sjatLet/NHGxTi414L+R12g8b6MMg5EyB/yMMwDhKeoBcCHWSE
	lD62lZVns1TcLeperitfM7Ivle+w4SbfGmTQ9BCm7e/ISXLhP15od85jEkYDVN/swObKKnDzkGgMi
	PG2A5mg7rMuoprs81fZHA5HrYm6KV3sJNsY2AMWOPse6bTkD8AdOhJ2bGhsHr3CHB70kI36L4nOH5
	4roBMEZKNCGK9exDqotV1sJoHcwtHOvkg+grqI06JWRhu8NN3bO/krND20g8iG9/ACuJjzQw4AIHQ
	QNYpE6dg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1waK2J-00000006tbX-3jK8;
	Thu, 18 Jun 2026 21:12:32 +0000
Date: Thu, 18 Jun 2026 22:12:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alex Goltsev <sasha.goltsev777@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: add sock_open() for unified socket creation
Message-ID: <20260618211231.GB2636677@ZenIV>
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sasha.goltsev777@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sashagoltsev777@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300537-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.org.uk:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A261B6A2BD8

On Thu, Jun 18, 2026 at 04:06:31PM +0300, Alex Goltsev wrote:

> +/**
> + * sock_open - creates a socket (unified interface)
> + * @family: protocol family (AF_INET, ...)
> + * @type: communication type (SOCK_STREAM, ...)
> + * @protocol: protocol (0, ...)
> + * @res: new socket
> + * @sock_type: one of SOCK_USER, SOCK_KERN, or SOCK_LITE
> + *
> + * Unified entry point for all socket creation variants.
> + * SOCK_USER creates a userspace socket (via sock_create).
> + * SOCK_KERN creates a kernel socket (via sock_create_kern).
> + * SOCK_LITE creates a lightweight uninitialized socket (via sock_create_lite).
> + *
> + * Return: 0 on success, negative errno on failure. On failure @res is NULL.
> + */

What's the point (and why not make it inline, while we are at it)?

Are there really callers that would pass a non-constant value as the last argument,
and if so, what are they doing next?

