Return-Path: <netdev+bounces-222720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E097B557AE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3184856608B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A5211A35;
	Fri, 12 Sep 2025 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hza4FmlN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE62DC76D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709409; cv=none; b=dGvcsPMKuRA8uBvVa16le9lsh0wdsilGpKpdc9MB1hR1kzxelrVJ74iwUN0c/RJA/vrOFcSxpMSq1PvUkDgwZBfsXqojfGTddRtG6vIsrBjWVHy1isx/98WrbXwMO3fnkeb01RWQdNwVR/eRnSObLMfvTBIspmwL9os9mxfTYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709409; c=relaxed/simple;
	bh=kzGlxNAIWV3br9b3tVz1lXP6+GdlTkmo1VaTNHPMWpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vrfto6VqzXVF/OjB3ncIQW8Gs0a2APooqIdIUI2wEr9B4U/yDD79M2bKVRn2vQwRunf/nkF+ya8PVQbaUqpI2CL/Ag30GJs8eYJKn7TQ42v3Yche2GGKOr80aj3RPxMtGDfad9h4t77dSaNXLfi6C4i+q0WSIs2GxpSw1ftn9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hza4FmlN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cyCyLGML5xcb4UNJGaWz3oPm1rJji59KfpAlSIagdZQ=; b=Hza4FmlNgCgAmXOskMYSaE7j+j
	uOt+RNgzF1UjWqt9VqaqaL6cHwAih3ewL66/J6KvJEZmgh1Eroa6vjeed2w+8YCCnu+kCFpglDBno
	5xk3ijUMa5AKUR8Akna1ef9z/oxEwkGyYH5l2mKrmsHUPtUzgmAH77n3D3QAdLdtP6Dc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAVb-008Fou-29; Fri, 12 Sep 2025 22:36:39 +0200
Date: Fri, 12 Sep 2025 22:36:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/2 net-next] ethernet: Extend
 device_get_mac_address() to use NVMEM
Message-ID: <5e481fbe-d6cf-4ee0-a531-f8cec75c28f9@lunn.ch>
References: <20250912140332.35395-1-wahrenst@gmx.net>
 <20250912140332.35395-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912140332.35395-3-wahrenst@gmx.net>

On Fri, Sep 12, 2025 at 04:03:32PM +0200, Stefan Wahren wrote:
> A lot of modern SoC have the ability to store MAC addresses in their
> NVMEM. So extend the generic function device_get_mac_address() to
> obtain the MAC address from an nvmem cell named 'mac-address' in
> case there is no firmware node which contains the MAC address directly.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

