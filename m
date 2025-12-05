Return-Path: <netdev+bounces-243811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7386CA7D37
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01651312FD12
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5F330B15;
	Fri,  5 Dec 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pRICgugV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839E220F49;
	Fri,  5 Dec 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942373; cv=none; b=eWbrk0UhfXr2drprkH3fj8GY4wDgkCUUW0CDFHtzNH0gfRA5JlRiRlwGJz2McNZvtz6bYWkrd9lKKSR+HQxkoGemlaGfrAl1pBLFv5R1kEx5hZ6+Z07yxnLXNuaszAfL9XKnY0CJyQ8LURbjcEUXYJLefNg0A2xddmGe1XBAAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942373; c=relaxed/simple;
	bh=iaFPACdq6D5w5GtdT1Ku5FA0SJCnTMER0jv2PZlKj6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ265maRtWJWmL/RaLwgTuf58oa0X+FWyYzszyok45fUGSTV3MpBG9Pn84xhrzn8pB3Vr7roCR5SjaBgTQdq/8FhwM/NZO8wjtgBvkpo4OmLh8WlPIxVOzYAIm8xdtkHxQ+FWuZPlh2F+yNKf4OIOLoqJpNFAs/rhoDmx9R74go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pRICgugV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bEHKql3ttmsxpRvWMIKymYkbEJes7DQVBIWepvvrSjo=; b=pRICgugV83fFIcg1ZTlbPp7fdm
	g4dBruRGNMFRi4NpgCGTJMOp1Yv8MhxiEGrB0l6pWJmzmwSICN53hR+0xCSeotCT8uyGDSPzQysWh
	gcMo89OXIwbvor3GGJGYly74rC0gJ39oK456UMtZMGxiHJVUe2WnGI/e1uh5B91hmHgs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRW7r-00G5pn-KF; Fri, 05 Dec 2025 14:45:35 +0100
Date: Fri, 5 Dec 2025 14:45:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>

On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> Despite being documented as self-clearing, the RANEG bit sometimes
> remains set, preventing auto-negotiation from happening.
> 
> Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> delayed_work emulating the asynchronous self-clearing behavior.

Maybe add some text why the complexity of delayed work is used, rather
than just a msleep(10)?

Calling regmap_read_poll_timeout() to see if it clears itself could
optimise this, and still be simpler.

	Andrew

