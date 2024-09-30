Return-Path: <netdev+bounces-130329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4198A1E7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A21F280D7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456B18FDA7;
	Mon, 30 Sep 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TRWjVGY9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567818E03C;
	Mon, 30 Sep 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697959; cv=none; b=VUa36j1oszpdIYU3t2v7NeO6ZFG7SN8blQM/JBpsDZpCzkoFfc0mHa7PmCSYT+3p2hU0Szv7/taavwoyEYjIiaaA0UaWHgu8/2JVNCrwKJEIPlZhMNkALmQEDkXw4iUNU9H+t/DgV147VQ3qwtQUn7vlYLzuoXRxz1ABZHlJOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697959; c=relaxed/simple;
	bh=Rhh1zpGXHGaU4obKT80lW838Lh91r1JuZxSBMOr8FMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JilXrD3UjBw2EsODv3Y49ICHcejhsUQSyRSmWZdOxOcW0DX9vxc7vMylp64GThozdNptMbZeNdgRVT0C1zOTym+i9AL6lJaQ6hS4i3SHmNaZSgTZDM8iqiaJ8zCcyf5MtG83MPXfd4zHmpfwcak/uSQVXjNdxI/nqCp8XMzdNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TRWjVGY9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Y5FCow2LkmEhl/LKF8B/aV5u4d4v1zphLYPcjj01Cc=; b=TRWjVGY9Zfj+pez53yGc0IhZmS
	pRjSmzeDil7V26gXsD3WVfNF7BHpZwo7/A01Mh2YQpcx6SPWlWiPH1PvK7I+793shAOLWJTHit+e/
	0OWrKU4bYrtJ8XUc/vY2Q5+aNNrSRsQJ8gcemx0U1VWVlwTWGR+5eBRA/VdKgRUztqqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svF9c-008c4J-Pz; Mon, 30 Sep 2024 14:05:28 +0200
Date: Mon, 30 Sep 2024 14:05:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Bauer <mail@david-bauer.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: mxl-gpy: add basic LED support
Message-ID: <e817c154-efbb-466b-82ec-46eb18711daf@lunn.ch>
References: <55a1f247beb80c11aa7c8a24509dd77bcf0c1338.1727645992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a1f247beb80c11aa7c8a24509dd77bcf0c1338.1727645992.git.daniel@makrotopia.org>

> +static int gpy_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				  unsigned long rules)
> +{
> +	int ret;
> +	u16 val = 0;

These two should be the other way around.

> +static int gpy_led_polarity_set(struct phy_device *phydev, int index,
> +				unsigned long modes)
> +{
> +	bool active_low = false;
> +	u32 mode;
> +
> +	if (index >= GPY_MAX_LEDS)
> +		return -EINVAL;
> +
> +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> +		switch (mode) {
> +		case PHY_LED_ACTIVE_LOW:
> +			active_low = true;
> +			break;
> +		default:
> +		return -EINVAL;
> +		}
> +	}

The return should be indented one more tab.

    Andrew

---
pw-bot: cr

