Return-Path: <netdev+bounces-228009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E2BBF027
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8183AC04F
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B472D6E66;
	Mon,  6 Oct 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1/z2Ce7n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769B231836;
	Mon,  6 Oct 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776301; cv=none; b=hY0iwjEKsPBLaoOkTIp1omo4Qk0Zr3g7RlN1j4mMsolxx9iuV2+Yn6b6zvdZkMbIVVa4219eSbuURj01N28HvagPMHbExiuPEAWj1eR3U6wBgO8EB6cJ8nxQ7A2c+ruE6h50om+KlXLq7dIDQUMJB7Iu6ajwUZVFQkNZHx767I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776301; c=relaxed/simple;
	bh=iuThHOm/7N3impVFIA5MVRJKAz+NUKSTJHWmLJJOhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm1WooajC0SC8G8o//k75eA5zc5A/gGgU5dVUZe7dhVTrhI4HOJhUhd3w7NI4DgsW8Nj6IEUe0BPfUvqJ6DRKOio3VvLHrhFu2ZE4CA1iNRfGqWC9EM4tk1hA4uvdkHFJfS2PYytLeqBCgysVhYdj1V7Adu3EzkS+DEnrA4cW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1/z2Ce7n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zKTfTbBc9rMSSrbbgMKMOx5WxTKfjwTxiQRv+5DFwcA=; b=1/z2Ce7nxrBK2h0TtFLAyAPPes
	eq27beYsKptU1kd5ddEf+nqHtbcc1VP+CkG+1H3WS9CG5mYpkZB+U+7NtXyQc0tjZQm8iTkeY2Kj0
	ypwb+2+pQQNsastUQkDVTI41eRSdN1EnCAKxLVkzHPhHAPpRoSGoKVpRXcY204ZwOel4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v5qCR-00AJbp-4K; Mon, 06 Oct 2025 20:44:43 +0200
Date: Mon, 6 Oct 2025 20:44:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya.Koppera@microchip.com
Cc: josef@raschen.org, Arun.Ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Message-ID: <5f74c41e-15cd-40f3-8fb2-fa636f169d70@lunn.ch>
References: <20250925205231.67764-1-josef@raschen.org>
 <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
 <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>
 <0737ef75-b9ac-4979-8040-a3f1a83e974e@lunn.ch>
 <fbe66b6d-2517-4a6b-8bd2-ec6d94b8dc8e@raschen.org>
 <DS7PR11MB6102D0B2985344C770AEC293E2E4A@DS7PR11MB6102.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR11MB6102D0B2985344C770AEC293E2E4A@DS7PR11MB6102.namprd11.prod.outlook.com>

> phy_sanitize_settings() is supposed to pick the least supported
> speed from the supported list when speed is not initialized.

What makes you think it should pick the slowest speed? The kdoc for
the function is:

/**
 * phy_sanitize_settings - make sure the PHY is set to supported speed and duplex
 * @phydev: the target phy_device struct
 *
 * Description: Make sure the PHY is set to supported speeds and
 *   duplexes.  Drop down by one in this order:  1000/FULL,
 *   1000/HALF, 100/FULL, 100/HALF, 10/FULL, 10/HALF.

So it should pick 1000Full if available. If not it will try 1000Half,
if not 100Full etc.

And the comment is actually a bit out of date. It will actually start
from 800G Full, 400G Full, 200G Full, 100G Full, not that anybody does
Copper at these speeds.

	Andrew

