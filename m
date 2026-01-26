Return-Path: <netdev+bounces-253502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN8xEHx6d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:30:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A878979D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1760E3023E04
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF533E363;
	Mon, 26 Jan 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xjofg5AN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BE33E357
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437791; cv=none; b=pxtWDN6zSGM2K0bx7XqRGnDaNieHbA5rGLaRxUJ9KkvH2qZ5GyGUF4LmPS1FhAuO2QtydpLrhLBLMwLdrh1n5DuVNRPmt2EwQsOzBvTL9wZ0LU2X39gqkiFam+tYs87Y6Kp4deXaqwwbnA9kwS0ooJgZiqEkuViXHiBV9wGfEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437791; c=relaxed/simple;
	bh=mRXqkvj2+oqiQuNjhATmvogtz1ils9kMEVQVfBAQCJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9khimJnactZER2rZqlo4F8u+EK0C4TY6FkvUugcsUJSzbZo292NxMKghIbz7fibza7ZZl9uwawRmvYCfAHTH0b9BOdgQOi4kvgU37exWlDSfpyUWgLh5l/crJpZXsEvWafRSnSqIKaUPpuYAjA28EXjEh1Y3QHEnNQGxQ5Hqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xjofg5AN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4dLf7546S9hZSsNSkVi7UQDGlNH1LP+TZ6mGN7mjJoo=; b=Xjofg5ANtelVi4ROH/I+WBxNVO
	hFwiPrZliIjsOBvRvwYHm23VUGQyEWaLCHBLcdftzPI8uYy8MHybIvXBGlU6iNO2scD6dIMw0m97K
	sA/hUPQSqytaOLIT06vrcBU88YdKVs8NSTrU5PUk4jdbYLAg7viJqSDLS6VxayGqfZew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkNb8-004nNS-6d; Mon, 26 Jan 2026 15:29:46 +0100
Date: Mon, 26 Jan 2026 15:29:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support handle
 multi-descriptor frame rx
Message-ID: <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
 <87cy315lru.fsf@redhat.com>
 <840fd286-779e-4130-b544-913116c97a29@lunn.ch>
 <87qzrdecs1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzrdecs1.fsf@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: A8A878979D
X-Rspamd-Action: no action

> > I was more interested in plain networking, not XDP. Does it perform
> > better with page pool? You at least need to show it is not worse, you
> > need to avoid performance regressions.
> >
> 
> I retested with iperf3. The target has a single rx queue with iperf3
> running with no cpu affinity set.
> 
> |              |  64 | 128 |
> | baseline     | 273 | 545 |
> | pp (page)    | 273 | 544 |
> | pp (2 frags) | 272 | 544 |

So no real difference. That is unusual, it is typically faster, or if
it is always doing line rate, it uses less CPU time. That might
suggest the page pool integration is not optimal?

	Andrew

