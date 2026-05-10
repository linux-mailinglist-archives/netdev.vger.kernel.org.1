Return-Path: <netdev+bounces-286410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEAeLJ8PAWppQQEAu9opvQ
	(envelope-from <netdev+bounces-286410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 01:07:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630E506C16
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 01:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB4A300C5AA
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB63612F0;
	Sun, 10 May 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rs1TKp8d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7733D6C1;
	Sun, 10 May 2026 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778454424; cv=none; b=HitRagdJRL82gQ9OS4v04GLWBTGRI3W8bObY8JYs9Mq1wK5YOC/yUl7R1xmMzc0S/w28faMi79644s53Rh/BIufbcv/wcEQzHb6T5imvHKe5Dn0kJ/fpeHLk6wXK0oiLbMgtSE61ah3uRM/aIvxJgK3cTcFazber5gN9BuuPe84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778454424; c=relaxed/simple;
	bh=E54gEwLFNHoWTy4Ac36ClnD1EKkCREJQnf4WFyjG19s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHY0cn+f/BjWuamunbQ0FE8bQoSuEf8oGFm1OvM6B6mh9xtzUxo5KqNOxa1cQFoT/ipltmI5mwFmkaTuHfpI1PCk470rka/V9hsViBoxpXJ9EFkM4fNanBFdNUtRWu1hAN+c5Joyn6yvF5I4b2r5c70go19BPximIC0wBnIVXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rs1TKp8d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lC1rO6J7Wj8sDYwXPZbBHVZOFpnDVzKk8C9Q3ZEIWoY=; b=Rs1TKp8dXI1xUl76lnzRLEesHd
	yUIUkLyoPLpYf+veLQQggUeEkRRExhAKeIReLJ3ZaNG/uDH9v1y9YSjlLLwgXwqr3dcqBqT7wwKeR
	N3Vq0e+yBXaRz4+UpQtYqEZk350s39HKMpl7STR65q88EMNgEB5E+JMKHSsva9WxMaho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMDEP-002Fx9-8v; Mon, 11 May 2026 01:06:41 +0200
Date: Mon, 11 May 2026 01:06:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in setup
Message-ID: <6d2e8041-938f-4171-be40-9e0b0a2faa73@lunn.ch>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
 <20260510214518.2064192-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510214518.2064192-1-fidan.aliyeva.ext@ericsson.com>
X-Rspamd-Queue-Id: 3630E506C16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286410-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 11:45:18PM +0200, Fidan Aliyeva wrote:
> >
> > In mv88e6352 scratch register in Global Control 2 set of registers
> > returns which port is attached to SERDES. This value is set and
> > stays constant after the switch is released from reset; thus, it
> > can be cached during chip setup instead of reading the register
> > everytime when SERDES config is needed.
> > 
> > 1. Add setup_chip_specific member to mv88e6xxx_ops and
> > g2_scratch_config3 member to mv88e6xxx_chip.
> > 2. Add mv88e6352_g2_cache_global_scratch_config3 function as
> > .setup_chip_specific which reads the CONFIG3 value from the scratch
> > register and caches it.
> > 3. Call .setup_chip_specific during chip setup.
> > 
> 
> Can we actually use setup_errata for this instead of adding a new member
> to mv88e6xxx_ops?

I was also thinking if there was another ops which could be used.

How about...

CONFIG3 holds the pin strapping values at reset. So how about
ops.reset?

Add a int mv88e6352_reset(struct mv88e6xxx_chip *chip) which first
calls mv88e6352_g1_reset() and then reads the scratch register?

    Andrew

