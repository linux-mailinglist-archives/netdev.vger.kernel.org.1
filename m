Return-Path: <netdev+bounces-304128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dC9uEU9URmqyQwsAu9opvQ
	(envelope-from <netdev+bounces-304128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:06:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C46F74F2
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:06:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304128-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304128-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C9DE30B7E8E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9103DA5D8;
	Thu,  2 Jul 2026 11:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0012E8B82;
	Thu,  2 Jul 2026 11:08:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990485; cv=none; b=A7+l78aLHAqWKbB5iHkDmrX2nT3t8Wf3Ju0vCxfU7QZpBgZkWEyOrcKDtMp78ZohrjAf6PlcwNpl6tlZdplYXa9tBxYcdOSA6QTQ2sIbUMKobpdGEBzjkv8EWJHrHDheb9IkF2iDdFL3OdwLaI/CIHF+U+MtBWGRxUvI7AgS0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990485; c=relaxed/simple;
	bh=NtwljrLY6p2ZueS5jksY4cMrkYyHa7GgXF7EIKbYhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFnPrg1Za2yanCf6b4pa+xzbYkB6LNx2PIKrBjPaa7hFjbCNwXNKJoYwgPiqOoCyXWZcHEw3rs++4Nr3eVExTkpHjqrmqMSXBB8axCVJVM1S3bXJ4BHMyi1mCBIkHcuhv4W5c05Bn8+UmFnfM6tl+7mrDD6UG/ruzMDXVS/zYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Date: Thu, 2 Jul 2026 13:07:47 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, regressions@lists.linux.dev,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <akZGg96-Xu9VeGrw@karahi.librecast.net>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[librecast.net];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:mst@redhat.com,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.linux.dev,vger.kernel.org,kernel.org,tu-dortmund.de,gmail.com,lunn.ch,davemloft.net,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 942C46F74F2

On 2026-07-02 09:24, Simon Schippers wrote:
> On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
> >> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> >> significant performance regressions with TAP interfaces and multithreaded
> >> network code. Please revert.
> >>
> >>
> >> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
> >> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
> >> interface. This test has run successfully on every stable, LTS and mainline RC
> >> released in the past year. Every kernel with my Tested-by has run this test.
> >>
> >> There have been a bunch of changes to MLDv2 so I started bisecting there, but
> >> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
> >> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
> >>
> >> Reverting this commit fixes the test.
> >>
> >> To eliminate my code and any multicast weirdness, I ran tests with iperf3
> >> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
> >> reverted.
> 
> Thank you very much for your bisect!
> 
> As the author, I am sorry for that regression!

No worries. That's why we test :-)

> > - does it help to increase the tun queue size?
> 
> I agree, this would be great to know.
> 
> However, even then we must act. I am considering IFF_BACKPRESSURE
> as a feature flag, defaulting to off. It would just enable/disable
> the stopping logic in tun_net_xmit() and the waking logic
> in __tun_wake_queue(). If disabled, it would result in the same logic
> as before.
> 
> I could provide such a patch as [net] material.

I'm going to make myself a strong cup of tea and dig into it a bit more here and
will let you know if I find anything worth reporting.

If you need me to try re-testing with specific settings or test a patch I'm
happy to do so.

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

