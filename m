Return-Path: <netdev+bounces-222719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72BDB557A4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8205E5C2252
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE713C8E8;
	Fri, 12 Sep 2025 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YCPcdast"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21C2DC76D;
	Fri, 12 Sep 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709055; cv=none; b=Z7iybfQVe3pxeHw6kvv59mqSlsVrlQEseXHGBlClb5V7drIiWPBHL0fc/0cqLfifYHx/JxmxBjP5Ko2/Cx+GxwS6lht05XwmhjAyqdVD/0zNTRwrxmrBZpDWU1OmJB6UErebEQNiD9KIzvRWwjuE2TqUMLoTc8iSLJpCrKlXsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709055; c=relaxed/simple;
	bh=sb+oCVM1irAzZEoerydIc/XcFgI2rsnrcT9Qn93RKVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3WYkjNvputkNtJE/+/FOwChR3fWP5dV/xFko7+FLNlndIXPbtini3lfTp965WTXgT8B/k08Ed4AH0mcaHE9NSzYZWndyAykuFUE0vf65638kY3Vnho7knbYoZ8t3OckEGBwGjDwU6+n9a01BPLKLEV8/LkUKQQHVvBCkNwYLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YCPcdast; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mVBouDME3yyB4oBFbpIyijCZ2IoHFwuH0Y/Nfu3LeAM=; b=YCPcdasteYKljjzN0JKrJrS6lP
	l3fz/ljsVsjqV2C0ALlax8u6tA3uvM9WaSTUQTrQFM9giuHCkSQwHRgmi4fihEeo6RhZmjkVZ4FqS
	WJNH9xfAocflQzYZpnQKzblj9gY81xljHdYLn36SnAVt7nqshJZidrxEdFFOgk/07zR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAPc-008FmE-0B; Fri, 12 Sep 2025 22:30:28 +0200
Date: Fri, 12 Sep 2025 22:30:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	boon.khai.ng@altera.com, 0x1207@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	emil.renner.berthing@canonical.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v6 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <7c81cd46-36e5-4280-9a49-8924a7bd5f92@lunn.ch>
References: <20250912055352.2832-1-weishangjuan@eswincomputing.com>
 <20250912055702.2939-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912055702.2939-1-weishangjuan@eswincomputing.com>

> +	/* Read rx-internal-delay-ps and update rx_clk delay */
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "rx-internal-delay-ps", &delay_ps)) {
> +		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
> +
> +		eth_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
> +		eth_dly_param |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
> +	} else {
> +		dev_warn(&pdev->dev, "can't get rx-internal-delay-ps\n");
> +	}

The binding specifies the X-internal-delay-ps values are required. So
this should be dev_err_probe() and return -EINVAL to stop the probe.

	Andrew

