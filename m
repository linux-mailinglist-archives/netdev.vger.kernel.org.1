Return-Path: <netdev+bounces-208632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C416DB0C711
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F0D1883924
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEAC28C2B0;
	Mon, 21 Jul 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B+dK7Yr5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4E2E406;
	Mon, 21 Jul 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109891; cv=none; b=cyh0tuzDgDAQe5FcnVe/C5FNYTU6RJypC1Eo0Gn3wVYIZhNSIeGlmwqjfAJ6y5oDP6sOckfIZ25EAbvG0NKqy3UysSGnsJUbnWQR9Ht/5IIk1fhgvUAblppWrf8hqh/9JnT5NprSoozmwADn9MWeOt80p15M2iVLzLIHXFrMunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109891; c=relaxed/simple;
	bh=IXMpzorN0DpbTX6QQuw1FzgLXmltEX1pZmXF9lOrz0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISOGMVLH+5iG26mMbebJ4gGQxVxf6e/Mliq14jJWA0BsWY+46pig6IAmhVJskn5iI5KXrZqyW0k8F40mENnxJZsdx9jTCpP4JEP2kKj73XZDgLKi2nwzrPptNwMabHO9YO1uReFl/SX/rPmt+udVXEtjd+JW9Db/q7wky1/ErgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B+dK7Yr5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WS1Xbv45ET5YWY4e1pY2jzB+5AD0h/g8lcMpQh8JFX4=; b=B+dK7Yr52bNUa/8wL/Ge2xlEQ7
	mu1Ea1J+W2r1ggv9PnXiXImSVabc+QIXL7FRQZNvF5H78JM9fqQw10lGmWJaAFY/LbMjf/6WrzMkz
	44NNZeHPaS4bwq8+pg98eJryb6QCV1uG8TyGrZLussEmNjxL+B6Fza1IQqcbNwfmEpQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udrxP-002MvA-JG; Mon, 21 Jul 2025 16:57:35 +0200
Date: Mon, 21 Jul 2025 16:57:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <1a6ea9a1-6b79-41f7-a272-037e6a075f0e@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <32fc367c-46a4-4c76-b8a8-494bf79a6409@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32fc367c-46a4-4c76-b8a8-494bf79a6409@linux.dev>

On Mon, Jul 21, 2025 at 02:30:40PM +0100, Vadim Fedorenko wrote:

> > +/* Device IDs */
> > +#ifndef PCI_VENDOR_ID_MUCSE
> > +#define PCI_VENDOR_ID_MUCSE 0x8848
> > +#endif /* PCI_VENDOR_ID_MUCSE */

Hi Vadim

Please trim the quoted text when doing reviews.

> 
> this should go to include/linux/pci_ids.h without any ifdefs

Actually, no. include/linux/pci_ids.h says:

/* SPDX-License-Identifier: GPL-2.0 */
/*
 *      PCI Class, Vendor and Device IDs
 *
 *      Please keep sorted by numeric Vendor ID and Device ID.
 *
 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.
 */

But the #ifndef should be removed.

	Andrew

