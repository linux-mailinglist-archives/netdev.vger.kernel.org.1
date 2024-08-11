Return-Path: <netdev+bounces-117501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF34F94E225
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890701F21316
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28E15099A;
	Sun, 11 Aug 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eYUjJahw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B37F6;
	Sun, 11 Aug 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392560; cv=none; b=dWAZTTJs1BPOEXCdm6oILpcykgFHwPUCxNtuTc0jteYltt2KKzW/OeQcVxu4SH91DYyz+YObOYthCYo8SXeeS3IsAIhLBWx7FkAp+DJqyX6cL+oNuQAYXcjDvCFdRwy+RuJrBxdVYhjZ4xk37l0rt3v+GfTy3J/nxTXnsvnHzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392560; c=relaxed/simple;
	bh=hCAQ116x3Hmbd/LpKND63YA31xscxw+DNNFO/YfTueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO3v3k2OVhHemJK8CnxCLacYVScFRvWTKFqTVenDY4qz0e7sNMyaJe0s1DIcuXrAwKd0r4DotdbO/GY4WBt+iU1E7N+AzeGH9t1shDYRP2EqdWurlCYzNWPWP0hMhUxGEnHMvyflfv0Xm2eDKXzkWLVnk/A23I0JzcTy4FBHaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eYUjJahw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PwlmP6m6ZlNuFnU37bFwXCVDeuLJQZU+NcyVICh6+ow=; b=eYUjJahwQDeitAGD0vzz0MHY3r
	f5Yfja5/PVYr2tT+Js9bm7R9vN7nCSIh7c5BUzJvl9ow4rFvPTwW9wXIX1sxje9USu3Oedm3UHi2o
	BSSUW1qk6um00lglDiXpzzjLH+x/mEFCFHBwlACU6of1Y6eUlhczxvGv91aKrnijAWOs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdB7v-004VZQ-4B; Sun, 11 Aug 2024 18:09:03 +0200
Date: Sun, 11 Aug 2024 18:09:03 +0200
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
Subject: Re: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <0451de33-3256-4c6b-a6ac-ca99b946fb15@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:39:05AM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
> MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
> 
> By default, the chunk data payload is 64 bytes in size. The Ethernet
> Media Access Controller (MAC) module implements a 10 Mbps half duplex
> Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
> physical layer transceiver integrated is into the LAN8650/1. The PHY and
> MAC are connected via an internal Media Independent Interface (MII).

I see there are some fixes needed for Multicast, but otherwise this
looks O.K.

Please send a new version with the fixes, and then i think we are
ready for this to be merged.

	Andrew


