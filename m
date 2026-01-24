Return-Path: <netdev+bounces-253059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHh6EsaQdGkH7QAAu9opvQ
	(envelope-from <netdev+bounces-253059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:28:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0027D19F
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1392D3009519
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B822D785;
	Sat, 24 Jan 2026 09:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCF21D5BC
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246903; cv=none; b=JasoFUPfO1TQw7RV0uY6EKUvATOdd1yR2EbRXaLFrkRYs6Jzm0fVC+nBRC4lx9J7htKrJiSe+E/jzA1vu7+vJNzd205g9rl39EVd/LBr1O7Rns92z3Vy0bCjC1oAP70u/9QWiJi05wTdhkzxrFu/dYFNVh23Q3cxUoSmKE6AWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246903; c=relaxed/simple;
	bh=R8TjR8U5StVkQVOX3b+02jUpOizvvkKWJy71UMC7mY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2h0f1b7XYbRUkctX0sleLevryVrnZKcUJmJJsTGcDTOPPjFOY47tUyWOc9Dl2gMRwufVZ52p6Wz6t8AnGRdZ53GRLm85n1BcfxZKhhd7u9eNwsMOM8A8+OsReyj9ibuFnx2ckKfMNkj00RC73ViVZCo4p3s2TYi91isv/zIwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjZwI-0005Yq-HC; Sat, 24 Jan 2026 10:28:18 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjZwE-002EiQ-03;
	Sat, 24 Jan 2026 10:28:13 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjZwD-00CpQc-0b;
	Sat, 24 Jan 2026 10:28:13 +0100
Date: Sat, 24 Jan 2026 10:28:13 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch, andrew@lunn.ch, chuck.lever@oracle.com,
	davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
	gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
	jacob.e.keller@intel.com, kernel-team@meta.com,
	kory.maincent@bootlin.com, lee@trager.us, pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/3] net: ethtool: Track pause storm events
Message-ID: <aXSQrWBbkwS5hqXU@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <20260122192158.428882-2-mohsin.bashr@gmail.com>
 <aXPntx9wiUqbKGRN@pengutronix.de>
 <20260123141527.358506c6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123141527.358506c6@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-253059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 6A0027D19F
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:15:27PM -0800, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 22:27:19 +0100 Oleksij Rempel wrote:
> > > +      -
> > > +        name: tx-pause-storm-events
> > > +        type: u64
> > > +        doc: >-
> > > +            TX pause storm event count. Increments each time device
> > > +            detects that its pause assertion condition has been true
> > > +            for too long for normal operation. As a result, the device
> > > +            has temporarily disabled its own Pause TX function to
> > > +            protect the network from itself.
> > > +            This counter should never increment under normal overload
> > > +            conditions; it indicates catastrophic failure like an OS
> > > +            crash. The rate of incrementing is implementation specific.  
> > 
> > Hm, we already have the tx pause frame counters. So, the anomaly is
> > visible to the user anyway (even if it isn't explicitly labeled as an
> > anomaly).
> 
> We are trying to prove a negative here, that's why we need a new
> counter. As the doc says this counter should indicate that storm
> is never actually detected under normal conditions. Another thing
> to keep in mind is that we're talking about metric collection at scale,
> so every 1min to 5min.
> 
> > What is not visible to the user is when HW or SW disables flow control.
> > Maybe that is what the counter should represent and be named? Would
> > tx-pause-auto-disabled-events make sense?
> 
> According to our existing uAPI for PFC pause storm is the term of art.

Fair enough. If it is aligned with the existing interface and doing the
same thing, there is no reason to continue this discussion.

For the uAPI part:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> 

Thank you,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

