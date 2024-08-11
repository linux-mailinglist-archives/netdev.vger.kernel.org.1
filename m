Return-Path: <netdev+bounces-117493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD6694E1E8
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB791C20DB1
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B814B948;
	Sun, 11 Aug 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F8ts+x+C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA113634C;
	Sun, 11 Aug 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390678; cv=none; b=PHFxll41R5qG/daWE5Cc2FOeGTY7mF7f8r5xT8Ds/yFsAzWnLC8npUvPlLroOzxW1KiiMVuadSZY39aufdf5OSjvETZVKNQ5WHrNE004rW0gWRRVV9U0HMpsl2VTuiDla9Npl3SPy7R3ujEfp9LcM4hpe4KVIccye2IvE5f2jkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390678; c=relaxed/simple;
	bh=ts4phOiODwYcBVxhPj7XQhH8DwkGBT50gka7WWipaLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erxVIW8gbshO4Eff987pvtKpEbZ/6eQJW/I1i0Hb7Fu7YZAeXkbxCxvTHH/FthiFfb2PvIIEpRfJlSPa0fLJMHy/ybqawVQN31IJztRtapunsFHwO+5tk8twZCQgm2THZsJ1wDzu+vNzN82Y9ak36Bwf5WmDNcpvO0F5CAenp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F8ts+x+C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QaoF6Pxe07CoCbtMqlSdaHuobGu7TQGjfXel/HnobjQ=; b=F8ts+x+C5UExSt66Qlzm7Z2wpg
	XeaifMMhElTW78rujLHmszKQ+Bd9hmek8tlOvY3qv008rA8KgLA+MFyXOgLTsy5MGmROZksOSbjrc
	0ueJL8Ahm4uiGUAydIiAGAeNtv29HnDwRrTVT2OJSK1xAzMk7KW0qIRcBXXvjVF/hnIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAdY-004VPW-1b; Sun, 11 Aug 2024 17:37:40 +0200
Date: Sun, 11 Aug 2024 17:37:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, masahiroy@kernel.org,
	alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 03/14] net: ethernet: oa_tc6: implement
 register read operation
Message-ID: <817aa1a7-9f19-48a1-9402-1c95225bed3e@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-4-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-4-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:38:55AM +0530, Parthiban Veerasooran wrote:
> Implement register read operation according to the control communication
> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface
> document. Control read commands are used by the SPI host to read
> registers within the MAC-PHY. Each control read commands are composed of
> a 32 bits control command header.
> 
> The MAC-PHY ignores all data from the SPI host following the control
> header for the remainder of the control read command. Control read
> commands can read either a single register or multiple consecutive
> registers. When multiple consecutive registers are read, the address is
> automatically post-incremented by the MAC-PHY. Reading any unimplemented
> or undefined registers shall return zero.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

