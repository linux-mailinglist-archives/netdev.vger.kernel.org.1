Return-Path: <netdev+bounces-254267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKLqILsTemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305AA2490
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3AE130028C1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482C35F8C7;
	Wed, 28 Jan 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XUAerFIF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D635EDBB;
	Wed, 28 Jan 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608118; cv=none; b=bwj2JASiXjxWDRdtP//EMF7Htwc7VUaZtYV2TsotNdNciZaV84ResAwpi06T7ArUWASSeWGhG8rmEjgpRDXq3l98hIwPGNCQR5pFR1JJa2XhdziQlL56bZ4s9mjvJKlXks9AqXf27HJfM7RE7fxCiyPNFE5nxhFII3Ly3EYudtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608118; c=relaxed/simple;
	bh=1oi4RXMKOgsQulwTR7LeXmX/5KQRkzwlphiR1nqA0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwiRTb03HUhAzKzNHYhgkHrFAF2W3eOCxTYEE3rf6sgciAXaBh6naq0n1QzcTWWsfK+H7LJIAtjJYxwRKcpAF90+Z+MJ0NBlmkbgHDWcCyD5l+/72Hlf9ESUypGPlzaYvu1Mas2cMxx0eTWhcBxzxhKkyIGtNfBcLD+yYFSrgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XUAerFIF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Etq37S/kWwlxG+pkXPUe6EmUtqjBTPB15zLQ90Mr2yQ=; b=XUAerFIF2vP9gq+uOpl2eGjeSd
	5qkuR0GMuCG3p+Vszo81Lx0MIyZdWVA13JT94VhzKngzNXxU0SMIZgtDpF4g0MGKW2ccTR6gLq9Pj
	fkEYmPo/L0NaCBgAe174Up8XNX8VJfUJQD5gSZ4HnWFZHRy2LQ1062SiOgeuEEysUG3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl5uE-005BkZ-AS; Wed, 28 Jan 2026 14:48:26 +0100
Date: Wed, 28 Jan 2026 14:48:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] dpaa2-switch: prevent ZERO_SIZE_PTR dereference when
 num_ifs is zero
Message-ID: <8241c7f7-6de4-4621-ad80-3f1af000afdd@lunn.ch>
References: <SYBPR01MB7881BEABA8DA896947962470AF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881BEABA8DA896947962470AF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9305AA2490
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:07:34PM +0800, Junrui Luo wrote:
> The driver allocates arrays for ports, FDBs, and filter blocks using
> kcalloc() with ethsw->sw_attr.num_ifs as the element count. When the
> device reports zero interfaces (either due to hardware configuration
> or firmware issues), kcalloc(0, ...) returns ZERO_SIZE_PTR (0x10)
> instead of NULL.
> 
> Later in dpaa2_switch_probe(), the NAPI initialization unconditionally
> accesses ethsw->ports[0]->netdev, which attempts to dereference
> ZERO_SIZE_PTR (address 0x10), resulting in a kernel panic.
> 
> Add a check to ensure num_ifs is greater than zero after retrieving
> device attributes. This prevents the zero-sized allocations and
> subsequent invalid pointer dereference.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

The patch itself looks O.K. However, we ask that fixes are based on
net, and indicate this in the subject line.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

