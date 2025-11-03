Return-Path: <netdev+bounces-235156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E95C2CB7C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DD8189AC0C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9BC283CB0;
	Mon,  3 Nov 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bm3C/hpN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DA1C5F1B;
	Mon,  3 Nov 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182802; cv=none; b=DL7vD1XEjHuPNxtBVfA90JEXPc3/Y/DJggOh8lSfxwwkcY6zHDHIArRdYie3/yjm+Wh1WAgZzqI88iuyMRBBReDtnvwv52UrHVK3gToIfQc/36rXMIBXbI1stACJkoq+7gkAxeNtQufbn7RM01bPDOsHSq5v/VJAL4XXKRfixLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182802; c=relaxed/simple;
	bh=zWOWgDLpCZMz5NjTvSfnqsVWClJ1JmJ8xFAxWmZLOVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGifv4vKZ1bSseq4jboWlgsm1b5TKyCyXk0yiMGmCokjWSfT5drI6Y0cdtglpPq/7KzGMJswZaGFZR7bHxOlBcnrLfc7/PazKVz8nReZp/m5uXhMLGLVRUmedFhEGh7JXr96h5dahqgIyGWeV8xHYbasCUIpQo62hiiA8kyScbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bm3C/hpN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JSXdgW2kfRWFxjWTR3l7Kh9s8bfojqXtZjuMl+0bips=; b=bm3C/hpNZY8fqnVxP022GlshBm
	31AP42vDSUyI6KbUn9Jo0Z3QzSUJGsL/da2JwIx5c1BgMoki0OLohgNb8TrgXd3IZT5VwLOhd/xBR
	wigGmg+7naJpD14G2ZB0rR8MrEjDh0jzwDT4yn+c69Whpy+MvTSgCS0xMfry/CkPN05g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFwEo-00CnDn-Tg; Mon, 03 Nov 2025 16:12:54 +0100
Date: Mon, 3 Nov 2025 16:12:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: spacemit: Check netif_running() in
 emac_set_pauseparam()
Message-ID: <bcebb4b4-69c3-4fa5-bbca-9558a9a7d526@lunn.ch>
References: <20251103-k1-ethernet-remove-fc-v3-1-2083770cd282@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-k1-ethernet-remove-fc-v3-1-2083770cd282@iscas.ac.cn>

On Mon, Nov 03, 2025 at 10:02:49AM +0800, Vivian Wang wrote:
> Currently, emac_set_pauseparam() will oops if userspace calls it while
> the interface is not up, because phydev is NULL, but it is still
> accessed in emac_set_fc() and emac_set_fc_autoneg().
> 
> Check for netif_running(dev) in emac_set_pauseparam() before proceeding.
> 
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

