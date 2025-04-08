Return-Path: <netdev+bounces-180358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C9A810CD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85C34475E3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB422A7F3;
	Tue,  8 Apr 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of749uDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EAEEB3;
	Tue,  8 Apr 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127380; cv=none; b=Zx5oahLKuLWzjx4sScnO0IgpPnuyuOf/G8XafvyYKbb2NHWT2OS4gz5G11ZiOUY7bvTD53J3c4Flxqxh8IEQ4dzkD306MFjnrmF3Yii/z3NbXWatUUlOt31aMh8SVAyRQmA5v+O0LI7zNwdatp/wnFaPStCLoZnr8LCVWmZPSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127380; c=relaxed/simple;
	bh=xSrK7LAUSSUCi4ZzH6O6Ty3z7EDtkJ5DhOg5gEePWLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq1Gd61vRoDnzJAynLuTXZ5xNIGY1AAOXuPUJ6KzsIoKPo3/noIpwWCJp0q52Jep7xsDJmLNjbjXStz7wsncwTzDa7FQ6NC2rRO2G3r6RvcpXQIWUasir93xbCEyiBikOVW5uwuOhDYb9p05F+s8NrnA1amB6P6bwdVGRvH/B8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of749uDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF94CC4CEE5;
	Tue,  8 Apr 2025 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744127379;
	bh=xSrK7LAUSSUCi4ZzH6O6Ty3z7EDtkJ5DhOg5gEePWLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Of749uDuTgz7/WgXpLcGSOGpAPy4TPUi/Z0rrk3K+bntaoiSBHvd9I4dNHqkpmyS3
	 Vf55OSR20730/zkiAfflhyHamswWsCCDRaC66oF2N0tEvNw2mMHB+5NWvXV60lKtGi
	 Dj3LDrKpeBPGl9C/BraLMv0R3bXlwqmNXUhhXHqyynQ2E2LvlZ7l30OUYKRh7w7ORt
	 Vw4NPl7+LDuhZBewQeOPC3+IL1mfuZsgiDSyhXb77zgRz2clfcvmv5jqwFHiBf8DEq
	 3TUyegXPg2J+YZwdS3eKPtjytOsJ2B+dfmA1oACgzpmA98a1VteK1lfLbgcpcsCiQj
	 76S9xtadpKA8A==
Date: Tue, 8 Apr 2025 16:49:34 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250408154934.GZ395307@horms.kernel.org>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>

On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> timestamping the egress and ingress of packets, but does not support
> any packet modification.
> 
> The PHYs support hardware pins for providing an external clock for the
> TAI counter, and a separate pin that can be used for event capture or
> generation of a trigger (either a pulse or periodic).  This code does
> not support either of these modes.
> 
> The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> drivers.  The hardware is very similar to the implementation found in
> the 88E6xxx DSA driver, but the access methods are very different,
> although it may be possible to create a library that both can use
> along with accessor functions.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add support for interruption.
> Fix L2 PTP encapsulation frame detection.
> Fix first PTP timestamp being dropped.
> Fix Kconfig to depends on MARVELL_PHY.
> Update comments to use kdoc.
> 
> Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory,

Some minor feedback from my side.

> ---
> 
> Russell I don't know which email I should use, so I keep your old SOB.

Russell's SOB seems to be missing.

...

> diff --git a/drivers/net/phy/marvell/marvell_tai.c b/drivers/net/phy/marvell/marvell_tai.c

...

> +/* Read the global time registers using the readplus command */
> +static u64 marvell_tai_clock_read(const struct cyclecounter *cc)
> +{
> +	struct marvell_tai *tai = cc_to_tai(cc);
> +	struct phy_device *phydev = tai->phydev;
> +	int err, oldpage, lo, hi;
> +
> +	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
> +	if (oldpage >= 0) {
> +		/* 88e151x says to write 0x8e0e */
> +		ptp_read_system_prets(tai->sts);
> +		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
> +		ptp_read_system_postts(tai->sts);
> +		lo = __phy_read(phydev, PTPG_READPLUS_DATA);
> +		hi = __phy_read(phydev, PTPG_READPLUS_DATA);
> +	}

If the condition above is not met then err, lo, and hi may be used
uninitialised below.

Flagged by W=1 builds with clang 20.1.2, and Smatch.

> +	err = phy_restore_page(phydev, oldpage, err);
> +
> +	if (err || lo < 0 || hi < 0)
> +		return 0;
> +
> +	return lo | hi << 16;
> +}

...

> +int marvell_tai_get(struct marvell_tai **taip, struct phy_device *phydev)
> +{
> +	struct marvell_tai *tai;
> +	unsigned long overflow_ms;
> +	int err;
> +
> +	err = marvell_tai_global_config(phydev);
> +	if (err < 0)
> +		return err;
> +
> +	tai = kzalloc(sizeof(*tai), GFP_KERNEL);
> +	if (!tai)
> +		return -ENOMEM;
> +
> +	mutex_init(&tai->mutex);
> +
> +	tai->phydev = phydev;
> +
> +	/* This assumes a 125MHz clock */
> +	tai->cc_mult = 8 << 28;
> +	tai->cc_mult_num = 1 << 9;
> +	tai->cc_mult_den = 15625U;
> +
> +	tai->cyclecounter.read = marvell_tai_clock_read;
> +	tai->cyclecounter.mask = CYCLECOUNTER_MASK(32);
> +	tai->cyclecounter.mult = tai->cc_mult;
> +	tai->cyclecounter.shift = 28;
> +
> +	overflow_ms = (1ULL << 32 * tai->cc_mult * 1000) >>
> +			tai->cyclecounter.shift;
> +	tai->half_overflow_period = msecs_to_jiffies(overflow_ms / 2);
> +
> +	timecounter_init(&tai->timecounter, &tai->cyclecounter,
> +			 ktime_to_ns(ktime_get_real()));
> +
> +	tai->caps.owner = THIS_MODULE;
> +	snprintf(tai->caps.name, sizeof(tai->caps.name), "Marvell PHY");
> +	/* max_adj of 1000000 is what MV88E6xxx DSA uses */
> +	tai->caps.max_adj = 1000000;
> +	tai->caps.adjfine = marvell_tai_adjfine;
> +	tai->caps.adjtime = marvell_tai_adjtime;
> +	tai->caps.gettimex64 = marvell_tai_gettimex64;
> +	tai->caps.settime64 = marvell_tai_settime64;
> +	tai->caps.do_aux_work = marvell_tai_aux_work;
> +
> +	tai->ptp_clock = ptp_clock_register(&tai->caps, &phydev->mdio.dev);
> +	if (IS_ERR(tai->ptp_clock)) {
> +		kfree(tai);

tai is freed on the line above, but dereferenced on the line below.

Flagged by Smatch.

> +		return PTR_ERR(tai->ptp_clock);
> +	}
> +
> +	ptp_schedule_worker(tai->ptp_clock, tai->half_overflow_period);
> +
> +	spin_lock(&tai_list_lock);
> +	list_add_tail(&tai->tai_node, &tai_list);
> +	spin_unlock(&tai_list_lock);
> +
> +	*taip = tai;
> +
> +	return 0;
> +}

...

