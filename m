Return-Path: <netdev+bounces-53733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5380448D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976B52813C4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23E46AD;
	Tue,  5 Dec 2023 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPhJIaUR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD04689
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF2C433C8;
	Tue,  5 Dec 2023 02:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701742674;
	bh=CFuIQBFb4jQLP5hJXSZ1DamnTQmlulyUK6o3iWa+amA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPhJIaURVkaehK07DiA9eU7x4cF/P10zqZmv6Gx6GiTtbUDmQj0fxdb3uMce1NdRd
	 Owsw6ukeGy96FxYtXL22lMsoYsmwV/mAD+NnJJAVP8VdZ8jPdk4EzbSrFQXjT8FJSe
	 lhRshCmKH/h7Sl5BVk3rEILYGeDJ7sYgmaTdwDai9aoSfefuSLBrDlZLZQJmqVuAsV
	 xYQsCXgbVQEm908rvw/PNhrpFfPiMv3vClnnexPXg6hG1UdLiKdEsS+PFesBI+hIcH
	 7j0YdVgbRmhefip2PIRQ2fIZTkS2brQi+sl6Ly+WF6TjpJBvwHh5DSPTpDS9C9yQp9
	 f1GbEGR3xDw4A==
Date: Mon, 4 Dec 2023 18:17:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, David Epping
 <david.epping@missinglinkelectronics.com>, Vladimir Oltean
 <olteanv@gmail.com>, Harini Katakam <harini.katakam@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231204181752.2be3fd68@kernel.org>
In-Reply-To: <20231128133630.7829-3-ansuelsmth@gmail.com>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
	<20231128133630.7829-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 14:36:30 +0100 Christian Marangi wrote:
> +/**
> + * phy_package_write_mmd - Convenience function for writing a register
> + * on an MMD on a given PHY using the PHY package base addr, added of
> + * the addr_offset value.
> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + * @val: value to write to @regnum
> + *
> + * Same rules as for phy_write();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> + */

> +/*
> + * phy_package_write_mmd - Convenience function for writing a register
> + * on an MMD on a given PHY using the PHY package base addr, added of
> + * the addr_offset value.
> + */
> +int phy_package_write_mmd(struct phy_device *phydev,
> +			  unsigned int addr_offset, int devad,
> +			  u32 regnum, u16 val);

Hm, I see there's some precedent here already for this duplicated
semi-kdoc. It seems a bit unusual. If I was looking for kdoc and 
found the header one I'd probably not look at the source file at all.

Andrew, WDYT?

