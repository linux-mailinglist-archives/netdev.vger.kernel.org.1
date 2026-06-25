Return-Path: <netdev+bounces-301967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b7RhADg2PWqAzAgAu9opvQ
	(envelope-from <netdev+bounces-301967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C786C6621
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:07:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=umKFd6BU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301967-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301967-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561093005D02
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A9348883;
	Thu, 25 Jun 2026 14:06:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FD2EEE65;
	Thu, 25 Jun 2026 14:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396399; cv=none; b=aa2qji7DjZCfE3+BBM3j+OP41RAOE8aPrI8EzI0rJkhaXWGU0cHPaUkoy3odbHVWuW+ESXTweuCRSN73GbIbSGFJsp5+e4eWQtom83eVOFRZFUo3CZ3N8xeq6xz3nPtFUgzGOGpNRNTcKQBxQ6SaqJnl3rVbf6tXxRIuMA3OCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396399; c=relaxed/simple;
	bh=f+u5RtJcIgCVjLpx7Av2ZrVcWc8kx6/gH7zoC1Hme2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6fqZsMij2ovPi3xRfIJrGD3pyUypc5eVnOYQ7MVTMT/FzKhuQ0ca6KOoFk3L+Ot4WFDbUlJgtSh9NppHxEgiQQ+HJ6fq21NYQ6cswRh6zmjMjmqJCP6zhUub8LKM8szFUaGQ22EDrB0ZSr7h+GwDbgg6fMXI7vaOnCCRMMiRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=umKFd6BU; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LaBpv62xdpnE2KPrv3KRWbkaQROLPC7gFgPeRezwIGQ=; b=umKFd6BUT27fcdQcOviwMZOE4B
	gJTWO8Y/J/fC4FLXVIn7eVyc/Uv5xF+KPiti1nlj78FDpc1ng/8WPWTHr+8aH3Wjz5BNyTkevhTWf
	OHSsqD9v4Oh7zyG0O6EsaDXJCuJkWPKSVb0Upi3kH9Zl/Yr8qUTNzdKHha6d5ef1zv3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wckim-009FOW-6A; Thu, 25 Jun 2026 16:06:24 +0200
Date: Thu, 25 Jun 2026 16:06:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pch_gbe: return errors from MIIM accesses
Message-ID: <6ce97e2c-ed90-46e7-ad7b-0f520736c3d2@lunn.ch>
References: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-301967-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40C786C6621

On Thu, Jun 25, 2026 at 11:05:03AM +0800, Pengpeng Hou wrote:
> pch_gbe_mac_ctrl_miim() polls for the MIIM controller to become ready,
> but returns zero on the initial ready timeout and ignores the completion
> timeout after issuing the operation. MDIO and PHY helpers can then report
> success with zero or stale data.
> 
> Make the MIIM helper return an errno and pass read data through an output
> parameter. Propagate the error through the MDIO read path, the probe-time
> PHY discovery path, and the internal PHY register helpers that already
> return an error status.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Do you have the hardware? This is a complex change to make without
being able to test it.

You need to think about the risks.

On the one side, MII pretty much never fails. It is a big shift
register, which just gets clocked out. So the errors you are trying to
report probably never happen.

On the other side, you are making a big change to the code. How likely
is it, you made an error, and have broken this code?

I personally would never make a change this size unless i could test
it.

Please also take a look at drivers/net/mii.c. Notice that all calls to
mii->mdio_read() assume success. There is no error checking.

	Andrew

