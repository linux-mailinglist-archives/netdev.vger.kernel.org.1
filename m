Return-Path: <netdev+bounces-135198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CA99CBA1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8040F2823F7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BA1AAE06;
	Mon, 14 Oct 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qZ1uS9e0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC51514CB;
	Mon, 14 Oct 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913027; cv=none; b=RE1YJ8AXnGelu5iy8SaPH4+C02mCzCKRIwjP0p/1PxzVN7YWeEd28xcAj1iTSLv23b0Ysg9m8OJDbJqE0wgmOM+tR2i2xAhnZhprJ+7QnfM1pWcekQnV17y/4/Itj1450K3om7rZdPsqko/A5azi8lDml3q/QboHACGc2nEZfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913027; c=relaxed/simple;
	bh=2396StbdL4oUeYyEyO3PnaqMTvVOnE0Vjf2IuT0fY9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOxdz118EMInwj5uK+f1RpvigSwttkcfexiF+8son53CmvWAYwG7tIM5YRuGx4FxgfFzdbX+XF5qnkdOOu3SU2fLTMDtWMb80PS86h/2uprbD+TXxMpZwp35Qf73upRJ/8ZDhBxfuWhxQ31sdtNXriW25LcrpPXnYD5+tUg5CQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qZ1uS9e0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zzV0POEfsxpQFudwXMex/Qq8ERcOm2RINXdYeXPqIGg=; b=qZ1uS9e0IebaN6hZQdkIXlHEhi
	aCmmpdZVv4N7+W77Vonq5ez7l2k60srRRXGxMdYCS53CAS6057tRK+q6fxbo53qi9BcqyWO/4KlS8
	+1A31ztI2WwvWW8m0U+0rylWD8eg2sm4ojH+K6mUHwrwH3ce4gLK4DUmvEdL8PZHsIf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0LFn-009ven-5N; Mon, 14 Oct 2024 15:36:55 +0200
Date: Mon, 14 Oct 2024 15:36:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [RFC PATCH net-next 1/1] net: phy: Add capability to
 enable/disable 2.5G/5G/10G AN in ethtool
Message-ID: <1c55b353-ddaf-48f2-985c-5cb67bd5cb0c@lunn.ch>
References: <20241014060603.29878-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014060603.29878-1-SkyLake.Huang@mediatek.com>

On Mon, Oct 14, 2024 at 02:06:03PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> For phy loopback test, we need to disable AN. In this way,
> users can disable/enable phy AN more conveniently.

Please take a look at:

https://lore.kernel.org/netdev/20241013202430.93851-1-gerhard@engleder-embedded.com/T/

We need a good understanding of how 802.3 expects loopback to be used,
and a commit message based on what 802.3 says. Our current
understanding is that 1G and above requires auto-neg for correct
operation, so we don't want to allow autoneg to be disabled in normal
operation. It could be we need to special case loopback somehow.

	Andrew

