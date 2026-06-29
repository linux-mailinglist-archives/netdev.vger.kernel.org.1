Return-Path: <netdev+bounces-302685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GG9FCEmIQmod9QkAu9opvQ
	(envelope-from <netdev+bounces-302685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A488E6DC604
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:59:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=CyjnYNT+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302685-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D93D30C307A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF453B637C;
	Mon, 29 Jun 2026 14:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95537AA81;
	Mon, 29 Jun 2026 14:51:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744720; cv=none; b=VK9T3TdE5N2Pe7uoku1KsOxLrEpiIfrKbFk47KeBSJmg1/7Jdi5JI0lv6x9v1RGMva4N3yzDzdkj9Q393orJWr8O/7irn+FFU6xVI3Eu53Tmq3rVJnvNvktUaLC7jPeQaljRwKEdKcvdHZANB1CKG7E/ldqfg5ebtlHRbcPh+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744720; c=relaxed/simple;
	bh=/fnKstZTxpGqEDSaqOgUdnlO5VH/C68uK+N8UmIpMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQCd5bti1zs66xQ6E6snsxycU2+td0mrxOxS3HENGuAELKnWp1kZ8zK50BF9OU0qSXB5Y+ONF88cDsQIe09EU1e3Oh5QfXILWjp7qhuavv3UYO5YWQjd35LoB60+SmEPgOuS+Zmf/cyFdbxQ6f6xwNHUQaPJeg+/HQttF0+H8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CyjnYNT+; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/AfarInOXZoQttS9XdojiWOifGGDVIjOfnZjpbVuMLA=; b=CyjnYNT+ZnESbXQF1Svd7WQk8f
	uBfbEKyFXVd8qGyQUVAWVUauOKMpiUSWKR8JqGQGCVPlYAJ2fGTlieuDmb61VQsSsr4uaEvVHE9R6
	SyStUQKj1dUeUloX6PkK/z8ohPeKVC+Tg0y/12ctqnEVt2iRiOb0QD9/ZfYb2GCVqtts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weDKu-009m0c-7X; Mon, 29 Jun 2026 16:51:48 +0200
Date: Mon, 29 Jun 2026 16:51:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rafael Passos <rafael@rcpassos.me>
Cc: andrew+netdev@lunn.ch, tytso@mit.edu, Jason@zx2c4.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [PATCH v2] Wireguard: Fix data-race in rx/tx counter
Message-ID: <b8155b00-ce06-49de-a283-3db4dbc0c99c@lunn.ch>
References: <DJL786MPR9HO.BWHI3U37PDVM@rcpassos.me>
 <20260629125913.2354450-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629125913.2354450-1-rafael@rcpassos.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302685-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rafael@rcpassos.me,m:andrew+netdev@lunn.ch,m:tytso@mit.edu,m:Jason@zx2c4.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A488E6DC604

> When looking around drivers/net, I found a few u64_stats uses without
> per-cpu. I will do some digging to understand the reasoning behind it,
> compared to the original "bare u64 counters" in wireguard.

/*
 * Protect against 64-bit values tearing on 32-bit architectures. This is
 * typically used for statistics read/update in different subsystems.

The assumption is, updating a 64 bit value on a 64 bit machine is a
single operation. You either see the old value, or the new value. For
statistics counters, we general don't care about valid but slightly
outdated values.

On a 32 bit machine, updating a 64 bit value requires up to two reads
and two writes. So if a reader and a writer operate at the same time,
the reader might see one of the invalid intermediary states, also know
as tearing. We do care about a totally wrong value.

u64_stats_sync.h gives you a mechanism which is totally free on 64bit
systems, but gives the needed protection on 32 bit systems to avoid
seeing tears.

You only need mutual exclusion on the writer side, from other
writers. If you have per-cpu counters, you naturally get mutual
exclusion, the CPU cannot be a writer twice to its own per CPU
counters. However, without per-CPU counters, you need some form of
locking. I don't know the locking used in wireguard, it might already
be in place? If so, this would be a cheap solution.

	Andrew

