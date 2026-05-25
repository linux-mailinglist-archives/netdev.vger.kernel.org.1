Return-Path: <netdev+bounces-291433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG1jIDCnFGrJPAcAu9opvQ
	(envelope-from <netdev+bounces-291433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:46:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD55CE17C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A2F03007894
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14E290DBB;
	Mon, 25 May 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IVPbaRWQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF8267AF2;
	Mon, 25 May 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738411; cv=none; b=DXXvqgImmzjt2rET+npINK4pIJj40OEYrM7bMC+UqFiCNh5oOzXRlda60h+NWhhHPfieJMAOiB5JoRHFQvHRjo8hwHQK2/fvVFVNmkknj3lEipUW5gQuQeqQizzK/9c/VYEOJ2obgIJbZiJmBsxvoTF+T7ljH2UYYBu3e99kGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738411; c=relaxed/simple;
	bh=kPqtZ+t4actD8HiF/AlDCg9RRdQTBIbbESaKTJJOXA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq+g2ahC1Dv0wuXX698mIgmyDj1sppu7+qx0QrNrH8IrPwplkWd4ILvPWfCr2CGvu/5Rxo+SbCT9Ly3hRQRGdED3tcwCfZ4KI8mzrR2q45DdGHIFuecr3I8o55d+xA0SXr81dxA5zBBF4y6cCSv8UxovuO74mw8Ezv04EHMbYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IVPbaRWQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kJH4eAuLTn/9VBHNDdS21HNu2w6MoQbVhjKm1wkjibQ=; b=IVPbaRWQR0TemdNwL7UWxuUz9o
	1tRrIh+hBN1Zv2izgh3yWc0kW+yp+lH2LaLMd++hX6opoEDqpO64HECd/qHnC6gSuOy4oyVkBaM3U
	sZp/IOYrXDszYgpaTDYbYWc6DovI6ckV/ull6CSjCq70lhMb+ODUDtCi/k98HdVFbg2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRbFU-004VMB-T5; Mon, 25 May 2026 21:46:04 +0200
Date: Mon, 25 May 2026 21:46:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Meghana Malladi <m-malladi@ti.com>, liuhangbin@gmail.com,
	h-mittal1@ti.com, haokexin@gmail.com, vadim.fedorenko@linux.dev,
	devnexen@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
	arnd@arndb.de, afd@ti.com, basharath@couthit.com,
	parvathi@couthit.com, vladimir.oltean@nxp.com, rogerq@kernel.org,
	danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v6 1/2] net: ti: icssg-prueth: Add Frame
 Preemption MAC Merge support
Message-ID: <ac753d51-0a1b-4fda-aae3-661ca5b8715c@lunn.ch>
References: <20260525182700.3135858-1-m-malladi@ti.com>
 <20260525182700.3135858-2-m-malladi@ti.com>
 <de0255c8-d751-4220-b0ab-88aef3a15f9a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0255c8-d751-4220-b0ab-88aef3a15f9a@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291433-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 24BD55CE17C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> > @@ -44,6 +44,7 @@
> >   #include "icssg_config.h"
> >   #include "icss_iep.h"
> >   #include "icssg_switch_map.h"
> > +#include "icssg_qos.h"
> >   #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)

Sorry for hijacking another message, but the indentation looks odd
here.

	Andrew

