Return-Path: <netdev+bounces-293786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA57HsqUHWqmcQkAu9opvQ
	(envelope-from <netdev+bounces-293786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:18:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D0620B16
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17713040AA8
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1283AFD17;
	Mon,  1 Jun 2026 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kDrOBjym"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFD3A5422;
	Mon,  1 Jun 2026 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323108; cv=none; b=lZg7XqM/gM4rBy7SRwuWd3AKKRgukyxkb8qi9nWsZXKcysh5HvbKC/cNvgFlksjj8JuKixnuPxusdT3as2FTbpP1NCwp8nQBia4oKNUpwhXRYo38enGoaudGO+kSC3X2bsj6Se2AL02DZdaw4eLji5E0sMIz0MjJg3v+5+V+dzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323108; c=relaxed/simple;
	bh=cm5uyXXOnHkykgEfCKBv1AIhhPjck4X4ZMDDkmzFc4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPr+wfL7OdOodzrzlFDu+NuHRujz4IWhmtNt8//Orf2EY3E9tXfXrzpDtGnmcdpu9ik37/zJhAtRWAFZiz+JJvTGi3iRma4nCSk+wW1Ze7E/B2McRnRGgeTbrAs56ax2XFURvyTE5lL4OsRNxcQ57lD1LeqRPEsvu5LVpWN85jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kDrOBjym; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=RpnjPSU19vtkqzJJvb2Ap/dUdnkh4XzyhDgFdX9Jpkc=; b=kD
	rOBjymji4PzRbKLvciQGa+j8WdhC2hnPMGrRCcDWt3iIsjxdEBx+SdsbjQCsrNMrC6lKM8e9c9nst
	QViGpLa+1WWAfevAh01ci7cf/qnbiv143vDqWXJwgeC6e5YqsGipaTRDLgEhIMwjN4KH+pIbOFAZ7
	ijOZjr1P4JJQSc4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU3MW-005W8V-SN; Mon, 01 Jun 2026 16:11:28 +0200
Date: Mon, 1 Jun 2026 16:11:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gustavo Kenji =?iso-8859-1?Q?Mendon=E7a?= Kaneko <kaneko.dev@pm.me>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: macb: check return value of clk_prepare_enable()
 in runtime resume
Message-ID: <d3813a62-c0b2-4506-93a7-24d7f654ed18@lunn.ch>
References: <20260601061906.127174-1-kaneko.dev@pm.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601061906.127174-1-kaneko.dev@pm.me>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293786-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 009D0620B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 06:19:22AM +0000, Gustavo Kenji Mendonça Kaneko wrote:
> macb_runtime_resume() calls clk_prepare_enable() five times but discards
> the return value each time. clk_prepare_enable() is marked __must_check,
> and if a clock fails to enable the driver would silently continue with
> potentially unclocked hardware.
> 
> The symmetric disable path, macb_clks_disable(), already uses
> clk_bulk_disable_unprepare(). Convert the enable path to the matching
> clk_bulk_prepare_enable(), which enables the clocks as a group and, on
> failure, unwinds the ones it already enabled before returning the error.

Given that the device is missing clocks either way, it is dead. What
is the benefit of returning the error code? It would be good to add
that to the commit message, as a justification for the
change. Otherwise this just seems like pointless churn.

   Andrew


