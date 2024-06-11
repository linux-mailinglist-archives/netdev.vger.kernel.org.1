Return-Path: <netdev+bounces-102404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88D902D75
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC291F2275E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C936D;
	Tue, 11 Jun 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0SdWZn32"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4E18E;
	Tue, 11 Jun 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718064837; cv=none; b=RoEbR6gZktsR/56aXDmrk+RzxZ7FvpVaODAca/HqmqATi7w03Zs5JmhjBtawaOEUyWn+3fpX+t/w/LoQ/xxmddvTtBQOHd3gg00ueBljyxL/oj7BHgEay3LyshJgzczxlo7SB/3tQsaVzGR5vsphgTm1uANOFFwOLkMF4a7O3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718064837; c=relaxed/simple;
	bh=MMoChjlubO/CbVraXX3twISoR0b4Z6eqTKCHUDdUxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwkTwERL3pozRuty2zEQG23Y39Hr5Jthe5xi+32KHa3S9lCIhTEuD0HIhDeyeNO/G92g1Bvbyb2MfzZomIg06lvrAZQUPO2zeRsEE5mw1JECxE6UpRuctkyL6PPjKVpjAucMp0rcuX6CjbCRkIvtUy7tS1kO+SpYJqMLVZ0G1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0SdWZn32; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6qqJ9a7fy1RSScoIqniM3oXpUHSrRaKPvWxc35OkLzU=; b=0SdWZn3202PSUPM5JzGe2tkxLj
	i9hXcZkBqU+yZIPszxSJ736JtKiJvrjIpRHacnfgWUdnKPFL/uT8fjbIFI8TuNfvZpJZv0Ix0nslt
	54navFKiPCmsnFvcZSmB14xoCS2MT6caLXYAxWYYJee5eCZyB9sv/nZ1Yhtmt1RZkGbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGp8u-00HL6z-Dw; Tue, 11 Jun 2024 02:13:40 +0200
Date: Tue, 11 Jun 2024 02:13:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
Message-ID: <7c06c9d7-ad11-4acd-8c80-fbeb902da40d@lunn.ch>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610231022.2460953-4-sean.anderson@linux.dev>

On Mon, Jun 10, 2024 at 07:10:22PM -0400, Sean Anderson wrote:
> Add support for reading the statistics counters, if they are enabled.
> The counters may be 64-bit, but we can't detect this as there's no
> ability bit for it and the counters are read-only. Therefore, we assume
> the counters are 32-bits.

> +static void axienet_stats_update(struct axienet_local *lp)
> +{
> +	enum temac_stat stat;
> +
> +	lockdep_assert_held(&lp->stats_lock);
> +
> +	u64_stats_update_begin(&lp->hw_stat_sync);
> +	for (stat = 0; stat < STAT_COUNT; stat++) {
> +		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);

The * 8 here suggests the counters are spaced so that they could be 64
bit wide, even when only 32 bits are used. Does the documentation say
anything about the upper 32 bits when the counters are only 32 bits?
Are they guaranteed to read as zero? I'm just wondering if the code
should be forward looking and read all 64 bits? 

>  static int __axienet_device_reset(struct axienet_local *lp)
>  {
>  	u32 value;
>  	int ret;
>  
> +	/* Save statistics counters in case they will be reset */
> +	if (lp->features & XAE_FEATURE_STATS) {
> +		mutex_lock(&lp->stats_lock);
> +		axienet_stats_update(lp);
> +	}

It is a pretty unusual pattern to split a mutex lock/unlock like this
on an if statement. Maybe just unconditionally hold the mutex? This
does not appear to be anyway hot path, so the overhead should not
matter.

	Andrew

