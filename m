Return-Path: <netdev+bounces-270229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IWGN/S9vml4ZgMAu9opvQ
	(envelope-from <netdev+bounces-270229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3E2E6357
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40665301ABB1
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE12393DD1;
	Sat, 21 Mar 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wzSjnSKE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92EE38F22E;
	Sat, 21 Mar 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108120; cv=none; b=jPHQy76BDOfubK73hw6Wb2gOh2ZPaObcXRqhoAtemqV38nQ9QuWvHUjFzqLEZypTmIvtuP536uIa/8eS0j16dSaloJglBNbmorO+jh+axBHtyeFeRQqKdGPEifVQHvhRUWSDduR8t7kHAVMjwFUncx3z31V99uAh/LaXM88h7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108120; c=relaxed/simple;
	bh=PKcD8DnD3VLuM+Hnef06Ut+iyHkqIlgOD7TXtpVjTXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fauzIC8PwlAvpJOw76vJiju2SY0d79DvIs6HV6Gk+tYdEwpIqEof9pmBtak1ITDE/02W8faRbHEDZ4g5ghs4dOrVvUuRoiKuEA617Tl1X3mrpB0LAZws1cnaJOmJwCCnXRqJeIrCopnaxeXsWkW92ZCrjOfHxBX71n0t4HnzVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wzSjnSKE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3Fy9gUHzgMAPEEFZcrvLxRVy4kJkdP/QasYLigMTp9E=; b=wzSjnSKES2i78CHWgQKAo8KXVE
	LcSCYCMxzge3wiJaRr7jExiPJRTJWjYSrVByWrdbDftLI3A2JwF/8TwwfVt5cnzZPkW8sFOpN7bbO
	fXTLpcuFNg5UFpBKTF5QHPBRXi4uaiNJKJthkrQImnDtCRc+tuGxNb6uU5UdCW28iAoM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3yYu-00Cj6o-C6; Sat, 21 Mar 2026 16:48:28 +0100
Date: Sat, 21 Mar 2026 16:48:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH phy-next 1/3] phy: lynx-28g: use timeouts when waiting
 for lane halt and reset
Message-ID: <3d9b524b-bb61-4e64-a655-3fa70d8b64ef@lunn.ch>
References: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
 <20260321011451.1557091-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321011451.1557091-2-vladimir.oltean@nxp.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,solid-run.com:email]
X-Rspamd-Queue-Id: 60D3E2E6357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 03:14:49AM +0200, Vladimir Oltean wrote:
> There are various circumstances in which a lane halt, or a lane reset,
> will fail to complete. If this happens, it will hang the kernel, which
> only implements a busy loop with no timeout.
> 
> The circumstances in which this will happen are all bugs in nature:
> - if we try to power off a powered off lane
> - if we try to power off a lane that uses a PLL locked onto the wrong
>   refclk frequency (wrong RCW, but SoC boots anyway)
> 
> Actually, unbounded loops in the kernel are a bad practice, so let's use
> read_poll_timeout() with a custom function that reads both LNaTRSTCTL
> (lane transmit control register) and LNaRRSTCTL (lane receive control
> register) and returns true when the request is done in both directions.
> 
> The HLT_REQ bit has to clear, whereas the RST_DONE bit has to get set.
> 
> Any time such an error happens, it is catastrophic and there is no point
> in trying to propagate it to our callers:
> - if lynx_28g_set_mode() -> lynx_28g_power_on() times out, we have
>   already reconfigured the lane, but returning an error would tell the
>   caller that we didn't
> - if lynx_28g_power_off() times out, again not much for the consumer to
>   do to help get out of this situation - the phy_power_off() call is
>   probably made from a context that the consumer can't cancel, or it is
>   making it to return to a known state from a previous failure.
> 
> So just print an error if timeouts happen and let the driver control
> flow continue. The entire point is just to not let the kernel freeze.
> 
> Suggested-by: Josua Mayer <josua@solid-run.com>
> Link: https://lore.kernel.org/lkml/d0c8bbf8-a0c5-469f-a148-de2235948c0f@solid-run.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

