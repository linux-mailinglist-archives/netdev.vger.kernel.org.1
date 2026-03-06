Return-Path: <netdev+bounces-264806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOjKK43cqmlqXwEAu9opvQ
	(envelope-from <netdev+bounces-264806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:54:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EA622229E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25953309C9E1
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33026399019;
	Fri,  6 Mar 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vNvn0cnb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F0330676;
	Fri,  6 Mar 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805028; cv=none; b=lU+VzmXuWH/mKU1K+4IRL1JkdKS8MlIK8RxOAYj2cwFM7wLap+u/i9MrAueN14VHsM3MYGgApb0aktqrwvU9CJP+E3mQ1NiTd1FfYrtBBiIzQ+qb+An6re3FV4htSUDr+UOBG3yO5ZjbxB/9PFM6WuWDvSzufXFtaGCHpbvMeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805028; c=relaxed/simple;
	bh=ytWK1jKnyeKXF+mq1lMXFMlBgIqR9ijziULw9jkJtvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY+b+D8Gld7J4NDAbm9zOB4EAJTjf2a4wvh3FUYApFt/khpvhmwjWAUh5kFtJb/bv4aKRYUyN3+ADz47n2wAqcMZTOy0dx0JMRcaVPQLBZ41Uy/YgcWSW8v2QzXgXBa21cl83MGzcgj9XYhDlPNRBMQPHKDU9PJxwGLN0CqNZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vNvn0cnb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uEI9CzsDJrE8mNx2N+kMo8wNobvLjxOyMo21wYJgdNU=; b=vN
	vn0cnbEnJPEzdx4Jy2Qw+YqRAwpigMVZtxfx2HgdrmsPxgPUlOM39hJENl6RpRVTdOxlu4Z2FtC7r
	ps6YXHkh9uZRx/idUdIAMRU71olNvq3e/6vkciP7SdiBrEy0etwRlTA6wQuzYV9KhxNPG40wnyQHP
	OudLUXnGCCXe50g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyVZ6-00ATzf-EF; Fri, 06 Mar 2026 14:50:04 +0100
Date: Fri, 6 Mar 2026 14:50:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mnhagan88@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: sfp: improve Huawei MA5671a fixup
Message-ID: <73bdd0c9-5e51-415a-a9f2-ce6f14a46103@lunn.ch>
References: <20260306125139.213637-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306125139.213637-1-noltari@gmail.com>
X-Rspamd-Queue-Id: 28EA622229E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264806-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:29:55PM +0100, Álvaro Fernández Rojas wrote:
> With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAULT
> signal, but we also need to apply sfp_fixup_ignore_los() in order to be
> able to communicate with the module even if the fiber isn't connected for
> configuration purposes.
> This is needed for all the MA5671a firmwares, excluding the FS modded
> firmware.
> 
> Fixes: 2069624dac19 ("net: sfp: Add tx-fault workaround for Huawei MA5671A SFP ONT")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

