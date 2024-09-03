Return-Path: <netdev+bounces-124708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F896A7D9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A40281CBC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EBF1DC73D;
	Tue,  3 Sep 2024 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i+OQCvT4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2F1DC72B;
	Tue,  3 Sep 2024 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393295; cv=none; b=ukFWw8jxvl/vdTQ2alsnbKb5W7nkYzZp47dEU8arsizOAEUQQxZwcvBDN2XfphGFqk1PxjrdP4dKXp/TRgOty6WV0gOTbJukQ414hSonSk0a2PAqV0CclRmMaH2JQIBM0o16caOiwfas5lJRCWPur6kTT31ub8Sm1D/VE7IsgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393295; c=relaxed/simple;
	bh=o/GJaAVkSA8f3QuX5wMU9hS1tu9wfBuKuqb6nYVaorQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axq1dOO1I+fXciSmbTpRk+Ut4Bho3zKGK/Li42WVM5Uxgqa9TB1rffbPl439vuXmbuCkTY6GOSf1wKv5P7V8PRrIwq4hXOXfyXcDiTHmzFMg0AbkCOvhl2B44OBWM4uBHXZNjE6tUiTgBjk8eCFNOPOGiEwd9hdhemr3IvW38LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i+OQCvT4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NVOmpJl/gZismI+LmmkZDr9Gv4PayKu29ypL/jEIbfw=; b=i+OQCvT4DpnvJsihUVd1DDDMUd
	Lv8HEJIc7oJ7p6aAKQFUcpqE/3H9jSGcGE5liRjWnG8QaGKLILHL3dwEzhUJZT1UrIBE1SAfp6mdg
	n/4psBKHymnj3Snet9RkDbzRRrkNErFJRVT9vH0+wTQ+iMzEte5ez3RPt0QQCF0XfGvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slZbl-006T0I-8g; Tue, 03 Sep 2024 21:54:33 +0200
Date: Tue, 3 Sep 2024 21:54:33 +0200
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
	linux@bigler.io, markku.vorne@kempower.com
Subject: Re: [PATCH net-next v7 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <00607dcd-fabc-45f5-b199-5c880c94b65b@lunn.ch>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
 <20240903104705.378684-14-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903104705.378684-14-Parthiban.Veerasooran@microchip.com>

On Tue, Sep 03, 2024 at 04:17:04PM +0530, Parthiban Veerasooran wrote:
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
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

