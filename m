Return-Path: <netdev+bounces-210892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8618B15533
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0042F3BE834
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF38280330;
	Tue, 29 Jul 2025 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="grMGqVHT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB84192D6B;
	Tue, 29 Jul 2025 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827633; cv=none; b=KaPBiZohf3qH+aH8OqyUGVyAOI9Jxgdu+ekSp0JONx1wixEwu/ZXC9ciTHedWI3h/OZAZQHyPcmu4+WzOae06ZcqJTXRB+68Djki5Tm6X4leryZyUn+rWy2eLNLWuNwfptpYvnp+4T8yp2dN96MHnc5ltAOM8Zj70llgq7R4Q8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827633; c=relaxed/simple;
	bh=QIK4yD4DxfpAS8UG7HAtnA5UGB8SXN5IRVDdqwbsP5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLNBkfoXX+Jk8b4XQxvrhxJ+WoXL1bgdtKtDdPLzl8Z8LWUTDOQJhjmomHbmkhW5VwYATdjLBYRWqs1JiWLzK2tWOl3FD+wP4KpS2FgwMq16AzvkFffM+GFq6h49GKIlQ+k8PhCLsRpi96SruWMCrK/+2/s7Kh4mgiTP4iZ4du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=grMGqVHT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VT1xegKU6q7qBTBFPfEJDcRc9vou9nj3uu4XBCqMijo=; b=grMGqVHT/Dcevvjs4ns1908GJf
	Ignocqh0WG14HJmxtFWcGoC+yILvlQEmRxnP8twLU89oYmU78rynwwRU3DrIQPlW0V0zh+R2gB2y3
	7Rsg2o3egdmd9mP99HBIiKzYzoYbLQYxrVWcxVLOYh5Wrlzwjx16JfyZ7SooibbsrIP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugsgG-003EbN-Gy; Wed, 30 Jul 2025 00:20:20 +0200
Date: Wed, 30 Jul 2025 00:20:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
Message-ID: <11482de4-2a37-48b5-a98e-ba8a51a355cd@lunn.ch>
References: <20250729213148.3403882-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729213148.3403882-1-florian.fainelli@broadcom.com>

On Tue, Jul 29, 2025 at 02:31:48PM -0700, Florian Fainelli wrote:
> In case the rate for the parent clock is zero,

Is there a legitimate reason the parent clock would be zero?

I can understand an optional clock being missing, but it seems odd
that a clock is available, but it is ticking at 0Hz?

Maybe for this case, a warning should be issued to indicate something
odd is going on?

	Andrew

