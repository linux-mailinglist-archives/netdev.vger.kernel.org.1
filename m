Return-Path: <netdev+bounces-304237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DLp9JSGdRmq9aAsAu9opvQ
	(envelope-from <netdev+bounces-304237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:17:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B2A6FB323
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:17:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=qZtCO5ww;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304237-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39DF530038CC
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673C2F8EBF;
	Thu,  2 Jul 2026 17:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F52E2DD2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:12:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012326; cv=none; b=p3ypcLgrpH45dJn8STmt2wDGUn4ONbQjVJtCpHQaBcn2uIFofCawnc2CajZjzTW+95AYDVNt5eYLNi94RSeKZqsimsJaFCQInt29TJQSkGusnO+mQiTpM7iZL1j/Q+PG/CjnucgXGsndpqFr6OoPHEbJzc6kwFwDsmzgAZUa3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012326; c=relaxed/simple;
	bh=of+IMlpL/ueIYjyYjfkeQwS01D5npHn3fFrdzcOeoxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSXVnu85GbrXEnu8i9niah9dIIXh4pXW1eBD4rt0HENxDSnSGAWO6exA+aTzAzNNLW+DOAA81vt6BCOzKB4/RjyipNxKgey44oVjN3nfARMd14AgT/OS6H04pMObNogHbkTDdgTmMJa7cYEE7EtmFGlJ97whEITBNJ7ZAZWLLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qZtCO5ww; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4kYkWk7jJTX5/rLh389qM70iGgCvsYRDdhOQSw+Cpp0=; b=qZtCO5wwC9pY2Ql3t2EyCjzQgF
	8lR3jDAW7r6hzfu2tMvRoFDDig4k3Vrrk/Ma0kxpM4oJ9jvwe2TXuqddbmhGRxbHafNVm7G9ydUS/
	MwNU/7cWO/ygSLFZls86N/eLRYnqwCUa2/YWWLsLaxojco36tOGXjV1dinzqjj2J4N0k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfKx1-00APCb-Ik; Thu, 02 Jul 2026 19:11:47 +0200
Date: Thu, 2 Jul 2026 19:11:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddaraju DH <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org,
	netdev@vger.kernel.org, Shubham Das <Shubham.Das@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: [PATCH net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Message-ID: <e9349915-df99-4d93-bb2b-f17686266a38@lunn.ch>
References: <20260702145326.1024800-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702145326.1024800-1-siddaraju.dh@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:mkubecek@suse.cz,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:Shubham.Das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.cz,bootlin.com,kernel.org,vger.kernel.org,intel.com,ericsson.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08B2A6FB323

On Thu, Jul 02, 2026 at 08:23:26PM +0530, Siddaraju DH wrote:
> Add comment to clarify the physical media 10000baseCR follows.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> This change follows the conversation from netdev mail thread with
> subject: "the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?"

Please add a link to lore, it makes it a lot easier to get to the
discussion.

Link: https://lore.kernel.org/r/[Message-ID]

    Andrew

---
pw-bot: cr
 

