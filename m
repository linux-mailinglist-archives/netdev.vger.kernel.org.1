Return-Path: <netdev+bounces-276509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDCZOi5P1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A173BC65C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860393006148
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425539F175;
	Wed,  8 Apr 2026 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QD7AAyNm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD91A682C;
	Wed,  8 Apr 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652562; cv=none; b=VMJns0LvVU2zhkUbITHKzVhqvIgPHp9hyDTg5M2HVPpUgaz5cAVotZrYmLj/YBqV0VT2EU8cBIpqzBXzHHvEGAjGu5ESVpq+1Rx8LVqxi8w0919IH8rymv8NPCyUbLUuJBmN6c1q5lWY2Zo3hKbEQB8tBOo4tiFo4pqzuyDepyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652562; c=relaxed/simple;
	bh=mUV7rw2q0A5WHCyqNbJNlBt1Jf5QNS+QEdRTpZaMpHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id9Z7t307947o4FqjFnDFKDKEZspmaEA+SSXjSOa3oNiHlV8ESaNCtKWpab01OpvzArCcw09Aj6h3Q8klx1/eEhWZPyCLBkNtRQJZh5MRbTdsSksYog0sZGvXEGni9vCaTaA6ow4hGxy9B1mLyc98gvuMbwMfmJd0kv4dzMBRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QD7AAyNm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wk20NWwmRkm5ObVx2JYrWw87flI+3LO6XzTgPlVGc1I=; b=QD7AAyNmhXlfQRYectb5KpVEA0
	b2M8P1LvJmHjzlC9DvkYb5O3D5YmfiCaQ97F31LjdILDI2CN0X1A1PXTfkzn2eM1GhX/jqFAA5Vi4
	kj463cHzn/OFKdC4KcRx/7A0SJw+OIH4o4DF+/5oVHW1QYTUBE8GiKd+1bFbvwmZu7vk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wASLH-00FHvu-5q; Wed, 08 Apr 2026 14:49:11 +0200
Date: Wed, 8 Apr 2026 14:49:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH v2] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <34a6a7d3-427d-4399-af9e-303ed7496843@lunn.ch>
References: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45A173BC65C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The register can be read and written from userspace via standard Clause 22 PHY
> accesses (for example using phytool) on DSA user ports.

Please add a phy tunable. .get_tunable/.set_tunable.

       Andrew

