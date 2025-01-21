Return-Path: <netdev+bounces-160105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E1A182DE
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AB1168B54
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D921F4E4E;
	Tue, 21 Jan 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nh35QrK8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE9187FE4;
	Tue, 21 Jan 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480505; cv=none; b=I3gSnbTdDLQ2QLO3MhGUnHBm5NGZXS1FbKmnKKRX8Rg7A/p6FMvQx+u/UL+yC5tPKwOsjTgLBKG2Rkhb537z14iE8lEFVOP+mBLem4NOfCd9zwcDLGg19T4sZCbv0A4sjQnN+DcX4cKzf8umYDHGLfP1roKoF1i0h+J7c4q1a1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480505; c=relaxed/simple;
	bh=aKihCuwpDjP+3WpP5pWPvpBfWV6EZUzB/Dw+KPp79Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiDpiAcNclIsig/1oviV0fo7KBPko3e5K/cXbU7vasJ7BFAVtqPlb68d68Aw0Tor7yqsyVvciHLo+LcTiYrsU4Bgvoz+ZUMNHVL8D8PMJ8Kf5sloHayRyPjoXhwnbzsVuzhGFrmn7bgu/FaM5bSrvxZoOoDin7bR2IEAyfMm4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nh35QrK8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AULDCh3skin4ia5GKeLHsxGKbV03ce5IgBpotaDf2ec=; b=nh
	35QrK8RCaUIKsIkRLa/caNMCkPEwIszDDVMCVYCuSBeFVw0uSNVXSSqypcAWMBcLuYWnyIQLwdvvA
	7Uy0TGi97SsFiUealcDDdhEM2rHM0Gu2lWQkmrA0lIJMOR3x7sSDcmf6j6TCX+LRWkIxunAC7KaA3
	8Vvw8ob9VKHPMCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1taI2w-006hg6-Dk; Tue, 21 Jan 2025 18:28:14 +0100
Date: Tue, 21 Jan 2025 18:28:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Laurent Badel <laurentbadel@eaton.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <c345df3f-8b5d-4f86-bef0-72870d1f9a66@lunn.ch>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121103857.12007-3-csokas.bence@prolan.hu>

On Tue, Jan 21, 2025 at 11:38:58AM +0100, Csókás, Bence wrote:
> The core is reset both in `fec_restart()`
> (called on link-up) and `fec_stop()`
> (going to sleep, driver remove etc.).
> These two functions had their separate
> implementations, which was at first only
> a register write and a `udelay()` (and
> the accompanying block comment).
> However, since then we got soft-reset
> (MAC disable) and Wake-on-LAN support,
> which meant that these implementations
> diverged, often causing bugs. For instance,
> as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`. To eliminate
> this bug-source, refactor implementation
> to a common function.
> 
> Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

The subject say "Refactor...." A refactor generally does not need a
Fixes: tag. Maybe make the subject reflect the bug you are fixing, and
reword the commit message to focus on the bug being fixed, not the
refactor.

	Andrew

