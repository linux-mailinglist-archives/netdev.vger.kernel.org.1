Return-Path: <netdev+bounces-304609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bHH2MMPmR2pehQAAu9opvQ
	(envelope-from <netdev+bounces-304609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:43:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550C7045FD
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:43:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=kFSwk4DT;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304609-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304609-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6A1307FC15
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5193002C8;
	Fri,  3 Jul 2026 16:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5CE2D6E5A;
	Fri,  3 Jul 2026 16:37:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096633; cv=none; b=Fv77UqAc1zIn7ZbX0tV+yCqzzVDH9Yi7BNn6fV/pWVFqxHVPiJebH+cG7FLUE50LaAolwIfB9uq96koX8h52b6zGysHiwsOX8p51g/9wnjxCkATrRInDGEWL+J+9tlkIWUx1KVZD0Y0FC9JqhPxVRo6MveZUPgSzpX788fyu5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096633; c=relaxed/simple;
	bh=KxfPhjPFhReMVWNPeenydaELfDtLChm7M44+DEKl6+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEeDul3FxP24rPBUT334AXY0JPu9qAf4gfv+XlNcA+NT3ZV6gtxpFf676XSSi9WkNgrfbSoyy/l0B6x0/PIJQY/hFpfVnd02ORZpXxbLDX7gazPnRVqbxYsuAfbJaVgDDoxzhNhuw44TZk7RobSiXRWdz1H8fATRcPh52rh5Zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kFSwk4DT; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hmUlKrsXOGhOBBr628gJIn4v+9qb1yvV83sBQpdAcHc=; b=kFSwk4DTw4+gfIrH6tewSvXnSw
	Yz48PKw6lXxWGIAJPkCYagfkVvpBYYbHB/WQKzov2EyOoXvINyvasmDeo5DR25S/gy3leIWuE/V6L
	euuuFMEW9Cfm4tnktjUSP0J9yReBsA1ykCv24lx1WAH7biAaKP/Ix+nBiNKNL1XJYiYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfgsk-00AZm5-Q4; Fri, 03 Jul 2026 18:36:50 +0200
Date: Fri, 3 Jul 2026 18:36:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: mal: fix W1C write race in ICINTSTAT
 clearing
Message-ID: <3a9bdad9-3755-4efd-8de4-a3ce3ff30b69@lunn.ch>
References: <20260702234923.1320412-1-rosenp@gmail.com>
 <akcnQEiJYfAtPqN1@zatzit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akcnQEiJYfAtPqN1@zatzit>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,garzik.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@gibson.dropbear.id.au,m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1550C7045FD

On Fri, Jul 03, 2026 at 01:06:40PM +1000, David Gibson wrote:
> On Thu, Jul 02, 2026 at 04:49:23PM -0700, Rosen Penev wrote:
> > The ICINTSTAT register is write-1-to-clear (W1C).  The read-modify-write
> > pattern in both mal_txeob() and mal_rxeob() can lose interrupts: if a bit
> > that should not be cleared is already asserted when mfdcri() reads the
> > register, it is included in the read value, retained by the bitwise OR, and
> > then written back as 1 - inadvertently clearing a pending but unhandled
> > interrupt.
> > 
> > Fix by writing only the specific bit to clear (ICINTSTAT_ICTX for TXEOB,
> > ICINTSTAT_ICRX for RXEOB).  W1C semantics guarantee that writing 0 to the
> > other bits has no effect.
> 
> Wow, it's a long time since I thought about the MAL.
> 
> > Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> 
> This doesn't appear correct.  The lines in question were added by
> fbcc4bacee30c ("ibm_newemac: MAL support for PowerPC 405EZ")
> 
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> Assuming ICINTSTAT is indeed a W1C register (or "read/clear" as I
> believe they were termed in the 405 documentation) the change looks
> correct.  However, I no longer have access to the documentation that
> would let me verify that.  I would absolutely not trust an LLM to know
> if that's the case, since it's a fairly arbitrary and specific detail
> of an obscure CPU.

I agree. If this is pure LLM, we need some form of verification.

  Andrew

