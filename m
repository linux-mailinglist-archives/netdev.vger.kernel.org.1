Return-Path: <netdev+bounces-300347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9G6kA2SmM2rREgYAu9opvQ
	(envelope-from <netdev+bounces-300347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:03:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCFC69E525
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:03:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="24UdRo/V";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300347-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300347-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F188B3010932
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955A35C188;
	Thu, 18 Jun 2026 08:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FA3B27F4;
	Thu, 18 Jun 2026 08:03:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769825; cv=none; b=pMWRZxZAIEVHZ3CElQDoDetXV1xJ7xjI2IkpU5ScimBl3SmsPXy9JbqUnRIW39sBJT5P3tSx6pm5fBRrUkIHJL9IypxdivTBCEr27rX2uM2iV4ye8EX3LRgiXtMTPYGQmVVkVUAaNlAAn3SRJi3CaVaD9IcLL5QISNG4wlixu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769825; c=relaxed/simple;
	bh=pc+JJpgmK98J7sN7dvO4b45hgWqJKOtrRWzchKs5LyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAa/UsoQIL7RSj9ag+aLQR5TJ1aE3iwX5WMC0mPxbKJx7dafYXWyzl9Ro+mi1Y46xRdq/nDus4s7pvzYd/C4XwrJjV4OY1jtNiI/2OcHMur7FexZ7XBU6WcHgImY4AW9Kal+n1anhbtlK10k1g8C+g6sj6IqB3Rjwi940KyiWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=24UdRo/V; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cdcE/bZAwY+vrGx8xIpJUXIwcAfQ/obnGs58pb8fxys=; b=24UdRo/VNqemHwxz/BFagGkLUV
	P+85b52FifonFgZuG5ZXKuQYkWr9Y3aa0dOu0NPhK/CH/hSF9gw319U/HiJ89vWLXRcu4cIwNYOM4
	7ap/AYx3neJrYX9p1cKeU7lM92hm+QQ/uBo3DbPF/+4TOZ+t2bXXJ8LIzgBdj/LDQB+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wa7is-008J5c-0W; Thu, 18 Jun 2026 10:03:38 +0200
Date: Thu, 18 Jun 2026 10:03:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] net: emac: Fix NULL pointer dereference in emac_probe
Message-ID: <25f043a6-fe66-48ea-a6eb-cd3acbd1e289@lunn.ch>
References: <20260618023405.415644-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618023405.415644-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-300347-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CCFC69E525

On Wed, Jun 17, 2026 at 07:34:05PM -0700, Rosen Penev wrote:
> Move devm_request_irq() after devm_platform_ioremap_resource() so that
> dev->emacp is mapped before the interrupt handler can fire.  An early
> interrupt hitting emac_irq() would dereference the NULL dev->emacp and
> crash.
> 
> Also remove redundant error message. devm_platform_ioremap_resource()
> already returns an error message with dev_err_probe().

I still think there is a bigger problem that interrupts can fire
early, but:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

