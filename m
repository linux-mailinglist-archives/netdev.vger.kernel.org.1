Return-Path: <netdev+bounces-290597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE/AH31UD2raJAYAu9opvQ
	(envelope-from <netdev+bounces-290597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3995AB458
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F4057301C155
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D963E5ECF;
	Thu, 21 May 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y/61I2Zq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B943672A2;
	Thu, 21 May 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389562; cv=none; b=OddIaQGW4IDqjhzKXqrxU3Du8uTZ21MSPEgNPUCKtJ2QG6cVE7t+1rw/oZnyQX26neXyamdprie5ks3xEkRZj5coU5KGW0kCgRdeSMTWtzGLd2RaNut3yCKbDrQu6d/r9pLMI0sXp5fu6SUmIMoZ8bZKnWQvHtX7++qyrh7+Iek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389562; c=relaxed/simple;
	bh=8deWXuYWpN3UopnrRVMiaXvxtFuthsBbc4oo2GCRoWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/lbtASXXGIgtt+X1dufQuHPVni5sDF0UW/2NVIVdlDK40okobASOXVLKXQJSfL929T0siBlr0w9UkAGkiZwoXktW42Fc1Eh1KX/V0yLnu8bJLvCdMJ/5gF7DKbvqj9cNZEq2gyWmuYJ4ElGENiLndYoRUrWqSVcYxbxbpZOu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y/61I2Zq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V31M9GGnMq0rWTjUd1WJyFrn+BPioH4qIE6HGDyl798=; b=Y/61I2Zq0FWbxprb6li16j8qXC
	FRaM3VCLlFemQB6/PYo1SM5r48YQo8sgvrYSYphLMoynC7b3l7kHICJTzaV+F5XXrDLscK3zUu1r1
	XKnTW7+RQuisFofMziJjNmrdMxNPZggl1e7hz6DtW0I+0PKcuSRgOMe0+p+IjeRr53aM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQ8VU-0044hN-RW; Thu, 21 May 2026 20:52:32 +0200
Date: Thu, 21 May 2026 20:52:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <c5d56bce-2897-4185-b571-e33b25b95040@lunn.ch>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
 <CY8PR02MB9249BE304350D2FA7C196A6C83032@CY8PR02MB9249.namprd02.prod.outlook.com>
 <660d68f2-2e4a-4dad-a33b-9cbd1847c04e@lunn.ch>
 <CY8PR02MB9249AE486B23AD6637517436830E2@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249AE486B23AD6637517436830E2@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290597-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: DB3995AB458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Little correction to what I said. As timestamp registers are in
> vendor specific MMS, read/write/adjust time callbacks have to be in
> vendor's code.

I've not read that part of the specification, so maybe i'm asking a
dumb question:

Why are these registers in the vendor specific MMS? Is the
specification missing something?

	Andrew

