Return-Path: <netdev+bounces-284520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B4dI60g+mkyKAMAu9opvQ
	(envelope-from <netdev+bounces-284520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:54:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50B4D1ADF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08BB1300D34C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140B4963C2;
	Tue,  5 May 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jrbIj/gK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC844963CA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000022; cv=none; b=XrpquRBDpHn2xlKh3pD8x3uaP/bcFqwHDgXWhoFaZcSVr01Wfx4ZovDfEAKtaaKbWxR/CV9ngqquNXK97nnEtrFnvalctxY5x4yUdGD4M92+9AlUCQTeOYMJpbcAFE6fal5Y7N8wnQkyYqscE8yIZud6wWbCps5gxbJXhscklbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000022; c=relaxed/simple;
	bh=NzJNQHBLYDCmvpAVrm++HRTXpvQH4WYM0IU7IeaPr9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVWD+rJFVSoTlP4IvROmoXcVUmlptGRiqRMoi7Ty1/AccVk/EB5Xep3TSK6Bi1qghaJWoI+kxoRAgsbVH29OlWO7Dw4DPg7wPm5jcor7Y/dlYURElJHaWtU78/UdIYNUQZqq2WVTCEgHciVT95LddwQR565ThMH1eyW5KYMiFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jrbIj/gK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CZf3JsloClML9ftLipbx7Xdo0S9d/mTg7u5tc9KIxOY=; b=jrbIj/gKRJ55ife6Ccc9aLnd76
	dTMSqMGRKp1yiTqrrXoMtyjOEAlSmmBkWJk83rr/tan1KeTAtdBJ46PQW3qUHVOXMAK1Es4ILHgy2
	DJ+Yc/iRUfmHXiyJyalcC+VRdvzqIxBCVkbAmJTlUIjr/RFd6/pxHk+fZ3OweeIrFudA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKJ1b-001VUt-S7; Tue, 05 May 2026 18:53:35 +0200
Date: Tue, 5 May 2026 18:53:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	richardcochran@gmail.com, milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com, vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Message-ID: <49123e89-5a8c-4b8f-9811-6e393b8b2c97@lunn.ch>
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
 <9c7eecee-f0c2-4ee3-95cf-ae9965191902@lunn.ch>
 <aa5798db-51b1-4d44-abec-c55b0560ec21@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5798db-51b1-4d44-abec-c55b0560ec21@machnikowski.net>
X-Rspamd-Queue-Id: 0C50B4D1ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-284520-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> >>> Anything we need to do?
> >>
> >> Can you share the config file you used? Seems the PTP clock was not
> >> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?
> > 
> > Shouldn't the configuration file be part of the test?
> > 
> > 	Andrew
> 
> I meant the kernel config.

Ah. O.K. 

> The PTP emulation requires PTP Mock to be
> enabled, as that's the backbone for generating timestamps. If it's
> disabled - netdevsim netdevs will report no timestamping support, as in
> the example above.

Maybe a Kconfig selects or depends should be added to netdevsim to
ensure the needed parts are enabled?

       Andrew

