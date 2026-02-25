Return-Path: <netdev+bounces-260940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKtvEaX4nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:27:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E8198098
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EF63302DE22
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65772395DA1;
	Wed, 25 Feb 2026 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cAp580mK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99717BB21
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026017; cv=none; b=qqmCRXp/Vd7lzdycnhzZ7AX4A4lUKG5tg4YuROTsfFTg3Lz9TyFq/RUOpVmOqFXZ2eaArZGPTUwQtKsz2AGDpwzPmhkhMNd6kPg+HD2sawsUST5wCjsasNEgHOVVrQ77cmnIz5vW9Un4VVnrhNh6akKBD86+Ki46W4M0C3kt1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026017; c=relaxed/simple;
	bh=LTvu16iDIyvQlZN0z1ucA7pFEkcAdhfv4NbkO34sF0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDBDU7b4r/m/Du1Ji/jAVzgT2cfx+TdMcZ489GsekQj0pLXKT61TP0o7CXqZSvcMQHqp7j8hLCnE9ujf008UKRpKt+8oDI5m0F9aXTZNZJ85lDeLWKFKdqtnOW0oDjYzM1X13gx9cstmDoQBTixWyD5S1WARMkD8bSAxQEKCPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cAp580mK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tH1txli5ZbjJyuBn6TTwaByCQYmvFas0S+xVPZo4XkU=; b=cAp580mKnk5S4g5wzcKCqiiMz3
	/s/rRMPjpt0tf1CQP7k/mON5eUC2AHBHAifFo+EoGjEZtNnOaz0BSo+eYyhrzNWQ9ej+33z4zv7Kp
	aoyt2SA7oU7NHNFkxMxTaXuZzuvsC2J4KLZUml9OBEvkJTK08/6yYPSOWHamHIUUnzmw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvEuY-008kQQ-UM; Wed, 25 Feb 2026 14:26:42 +0100
Date: Wed, 25 Feb 2026 14:26:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix .ndo_fix_features()
Message-ID: <af465a47-264f-4029-943a-fd4222092f9d@lunn.ch>
References: <E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk>
 <20260224173037.7871e5ac@kernel.org>
 <aZ6xqig4zh_Un8R7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ6xqig4zh_Un8R7@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: AE2E8198098
X-Rspamd-Action: no action

> Then, looking at the "Enable TSO" block of code in stmmac_hw_setup(),
> it looks to me like we can end up with some queues that have TSO
> enabled, and others which don't (because TBS has been enabled on the
> queue.) As far as I'm aware, the network layer doesn't support
> per-queue TSO.

There is a software implementation of TSO. See for example:

commit 3ae8f4e0b98b640aadf410c21185ccb6b5b02351
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Mon May 19 14:00:00 2014 -0300

    net: mv643xx_eth: Implement software TSO

You might be able to use this to fill in the gaps.

    Andrew

