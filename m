Return-Path: <netdev+bounces-253532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OXEBaSUd2n0iwEAu9opvQ
	(envelope-from <netdev+bounces-253532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:21:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E28A9C8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3FF130115BF
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44460330668;
	Mon, 26 Jan 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TaNlONzJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0331B10D;
	Mon, 26 Jan 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444436; cv=none; b=LCZixUG6Hj8dYayA0ax7Cm4JAqtyvH3zpKbpqT314W3V6aWJYxryDToKEIL1hpmLpeboIzhBQHcUzScmn/hgKhPMO8j5ubRL+AJCeNHldQ/zG2wtkFf1Eo3XGwEYKjHq/mAwHynTvBP2xPeomD2d1MtAzW4VdQx/j1YylY+/5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444436; c=relaxed/simple;
	bh=3FdQHs3mDvUGT5rX7OJK2axo760hLmnlPgwxBo8NnfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeemaNDXpkCtDhEES44Jexfb/G81DiCiXWqX5UisXUMzladxSbLflC/C4HI+6Rnc3yFQFL6MBiCeTo5WyZ1IGsmaQldRgEjwSSpusThVaxjAevNthwOZm3qLeCw1vvFqD2S006m1JcsU8Pwm6xx2aE6C6dM/7A9vymOCtJuz27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TaNlONzJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lLZfSnd8l0vmNwskGFJdLuWhZQyos3yCTgoijKc5g4c=; b=TaNlONzJnRURaR7peCf7d9C0PO
	vhbIdQ38V6tMdEAwpdPoc+Chh2qQwp25USrbsd7hNkW9v5H27hhkyWwR4lE9BXsTFG2gc6deSYMqv
	YzPcMLxsfe8cQhs9PArtzg8Aq2NzuJvFhDNk31/sEAehfceJlZw71sYoDIAtClYNtDDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkPKJ-004oT1-E5; Mon, 26 Jan 2026 17:20:31 +0100
Date: Mon, 26 Jan 2026 17:20:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Yixun Lan <dlan@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH] net: spacemit: k1-emac: program frame size registers for
 jumbo frames
Message-ID: <169bffe4-5292-48b5-b8e7-448fa4288598@lunn.ch>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126135919.77168-1-tmshlvck@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253532-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 620E28A9C8
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:59:19PM +0100, Tomas Hlavacek wrote:
> The driver allows changing MTU up to 4K via emac_change_mtu() and
> allocates appropriately sized DMA buffers, but it never programs the
> MAC_MAXIMUM_FRAME_SIZE and MAC_RECEIVE_JABBER_SIZE registers.
> 
> This causes the MAC hardware to reject frames larger than the default
> 1518 bytes, even when larger buffers are allocated. Frames exceeding
> the default size trigger jabber errors and are discarded.

This sounds like a fix? Should it have a Fixes: tag? Should it be
added to stable?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

