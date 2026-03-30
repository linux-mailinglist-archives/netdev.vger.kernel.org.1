Return-Path: <netdev+bounces-273165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP8xHTRzymlQ9AUAu9opvQ
	(envelope-from <netdev+bounces-273165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3E35B633
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C8BF301DD34
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D613D1703;
	Mon, 30 Mar 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4u8bxRXT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837630E84F;
	Mon, 30 Mar 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874890; cv=none; b=q4Ihz0mdk2EH6bJTRlrdHDQhiZdJD+ORAgm1XrTXCJKUkXzFdFf7CW0pJp1UGhsjrch0UwHGTqC7IwbYVcFdvkhxq2LwAXBK+Wj/mSaQ6QBrHU1SmS/AxpAZp5KYTqbFxdKvR0FUbh+39zu1UmtQBSdrDOqPgmuxOMB+B2uw2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874890; c=relaxed/simple;
	bh=Ussa43LWPtA6yUb/RL9ctofSX1Bow0SUPYYU5fJRt9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihsyt1G++RauNM5a9K5WC3r41utcnTe1OoiQwg0Qm6N9y3liQd0dWtbeg9cV42MFJmLggX/B/l2HQSJY7Xsiv5x38n7/wLyg5PW79AaY6NOqhudcYih4PG7VchlvOofp3Amx4juygWiF8g96vEQpJO7jZwigHorsCe5PMSnMNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4u8bxRXT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SQnnYyQCAMoEC4ylO9r2ZhM0h4XUUS6e+qeqslEd9oI=; b=4u8bxRXTVofUZNO3GnH46dTRFh
	qABu43NQTw6SA6vZbt0RI3XRPew1nnG7gyKQhBVJVQsVvGTFO1BUVWa70F4gHlz/NamAiUfYEUBMI
	RmPQIB7RaCbLT76S1pz4lyKS8jk5zZngwhYJcbPxAj0X9BlDfzYVeEg2lPlUSB5H+lBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7C2E-00E242-Kn; Mon, 30 Mar 2026 14:48:02 +0200
Date: Mon, 30 Mar 2026 14:48:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] declance: Rate-limit DMA errors
Message-ID: <5df83811-91ed-47e3-a6d2-3d96eaef0b0d@lunn.ch>
References: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
 <alpine.DEB.2.21.2603291303190.60268@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2603291303190.60268@angie.orcam.me.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273165-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,orcam.me.uk:email]
X-Rspamd-Queue-Id: 31A3E35B633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 01:32:51PM +0100, Maciej W. Rozycki wrote:
> Prevent the system from becoming unusable due to a flood of DMA error
> messages.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

