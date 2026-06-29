Return-Path: <netdev+bounces-302442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iCKFDNDZQWpJvAkAu9opvQ
	(envelope-from <netdev+bounces-302442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A56D584E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=mit.edu (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302442-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302442-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38EC93006009
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 02:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87A37B021;
	Mon, 29 Jun 2026 02:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A03750D6
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:34:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700488; cv=none; b=q25WZDxzJo11WnXZds1eZ/s6/mNX8T2x2b2ZGm6Rlab4q0kMU7hbP+za0G7xE7koLHiNLYOWiECxFQixUvKMWbXw3eNr2dUb/52lpdQQGiLF2xjxK3Oi8ZLlG6b+OHK50515ibWaNHVzPIsQt9A6oeTRWxr1z83KxE/ISKTpiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700488; c=relaxed/simple;
	bh=MqjIMNfvVj1MvB1WbtO0xB14EvFr7MbBubzfSRE+otA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXyMI7Y+vjFDhAVDdrcofePUiUAVyaLhvc9GscODZoPmrKRGSZvTxxNrj9lVNvrlb6A2bVez6roIFWPGp32MiaU4bVXexUctLgMkHqDHqowlJvNvG10CXyVssfgEEI7vSbCKvV6eJE8RXOwsiGXWJuK/izw7vEVMNGKtUwFFKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Received: from macsyma.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 65T2YHMF021906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jun 2026 22:34:18 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 157EB7C1B88; Sun, 28 Jun 2026 22:34:17 -0400 (EDT)
Date: Sun, 28 Jun 2026 22:34:17 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rafael Passos <rafael@rcpassos.me>, Jason@zx2c4.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [PATCH] Wireguard: Fix data-race in rx/tx counter
Message-ID: <akHY4UEa1ab2PF-j@mit.edu>
References: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
 <20260628203823.144789-1-rafael@rcpassos.me>
 <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[mit.edu : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302442-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:rafael@rcpassos.me,m:Jason@zx2c4.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[tytso@mit.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D6A56D584E

On Sun, Jun 28, 2026 at 11:02:05PM -0500, Andrew Lunn wrote:
> On Sun, Jun 28, 2026 at 05:38:23PM -0300, Rafael Passos wrote:
> > fixes data-race in {rx/tx}_bytes counter for wireguard connection.
> > these values were incremented inside a read_lock_bh block, but write
> > protections were missing. making them atomic was the simplest way out.
> > This was found by syzbot with kcsan.
> 
> Atomics are expensive in general, especially on high CPU count
> systems. 
> 
> Statistic counters tend to be very asymmetric in usage. They are
> incremented frequently, maybe per packet, but reported very
> infrequently, maybe every minute when an SNMP agent reads them.

One of the reasons why kcsan and syzbot can be quite noisy is that a
human being needs to *think* and consider whether or not this is
actually important.  (One of the reasons why I'm not all that worried
about our new AI overlords taking over the world.  :-) Consider what
is the worst that might happen if the tx/rx_bytes counter might not be
completely accurate?  Is it worth the performance penalty of using
atomics (or the memory overhead of per-CPU counters)?

	    	       		   - Ted

