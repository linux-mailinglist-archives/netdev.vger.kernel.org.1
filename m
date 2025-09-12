Return-Path: <netdev+bounces-222722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503CB557C2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90621896041
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B4298CA3;
	Fri, 12 Sep 2025 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vKCvKWq7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7828D830
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709795; cv=none; b=HUY3aZxxAktvcHqQagmYhxLQ19oo/qyZjBg8J4exvpdUNpk2bSZlA2b1rMfhjl9Zo6YhbPDJwqfvoElj1dfv9H8u7dhCB7I0ftfwunzwJj+xxmbNgMv1AEcGCX/K+9ONJXrgRteOy6GK3k4ZGjo8sEROFcyMH0EyLVQBKPVIfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709795; c=relaxed/simple;
	bh=c9ZHD8pXVQIewsX9NmaacPN/Cd+KLaIWy7kaiLQEvJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF/Jcjq7+hcp//J9Np/u/f3MvlLerfjEJrO93QAKI6qwgjcvOlKPyvIVVB6j8cfYnynaneLQ8cq3WAMaj12NQwSj45xCay5kqF4IgKrOWf2sx+IBMp7UAYaXwHwFT1eH2PmgbFGqGkVvcJeYxF/LzlY1K/p98U8oTFZcJLtmpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vKCvKWq7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5O9hrIiYrgg9urrTQp9ep4+Z+glIVYR26OR55YIIzKM=; b=vKCvKWq7ubNaKNo31ynNmXK/72
	vgCZCwm9afKNJu4ZTv5xdQKJ4Hd+qr9f8hY78TDojKxiHGYsRcvAt51ma4zt+B4T19OTixGEybRxd
	nF7Ard26o8Xt8gicWbDaEp5r5va+cC8Ddg/4paecjrNMvVU7HRajHphmt7Kouknlb+oU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAbm-008Fr2-Tj; Fri, 12 Sep 2025 22:43:02 +0200
Date: Fri, 12 Sep 2025 22:43:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, saeedb@amazon.com,
	darinzon@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: ena: fix duplicate Autoneg setting in
 get_link_ksettings
Message-ID: <96f1e320-a777-4828-a681-80f81f9a44de@lunn.ch>
References: <20250912202201.3957338-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912202201.3957338-1-alok.a.tiwari@oracle.com>

On Fri, Sep 12, 2025 at 01:21:59PM -0700, Alok Tiwari wrote:
> The ENA ethtool implementation is setting Autoneg twice in the
> 'supported' bitfield, leaving 'advertising' unset.
> 
> ENA devices always support Autoneg, so 'supported' should always have
> the bit set unconditionally. 'advertising' should only be set when
> ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK is present, since that
> reflects runtime enablement.
> 
> Fix by unconditionally setting Autoneg in 'supported' and moving the
> conditional flag check to 'advertising'
> 
> Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

